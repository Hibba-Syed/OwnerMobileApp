import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';

import '../Utils/utils.dart';

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String?;
    int? unitId =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Receipts",
        appBar: AppBar(),
        widgets: [
          IconButton(
              onPressed: () {
                const LedgerPage().showFilter(context,
                    child: filterView(context), resetFunction: () {
                  context.read<ReceiptsCubit>().reset();
                  context.read<ReceiptsCubit>().getReceipts(context, unitId);
                  Navigator.pop(context);
                }, applyFunction: () {
                  context.read<ReceiptsCubit>().getReceipts(context, unitId);
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: primaryColor,
              ))
        ],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomSearch(
              initialValue: context.read<ReceiptsCubit>().state.keyword,
              onChanged: (value) =>
                  context.read<ReceiptsCubit>().onChangeKeyword(value),
              onSubmitted: (value) =>
                  context.read<ReceiptsCubit>().getReceipts(context, unitId),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ReceiptsCubit, ReceiptsState>(
              builder: (context, state) {
                if (state.loadingState == LoadingState.loading) {
                  return const Expanded(child: CustomLoader());
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor.withOpacity(0.1)),
                      border: TableBorder.all(color: primaryColor),
                      columns: [
                        "Date",
                        "Reference",
                        "Paid by",
                        "Amount",
                        "Actions",
                      ]
                          .map((e) => const SharedDocumentPage()
                              .sharedDocumentDataColumn(e))
                          .toList(),
                      rows: state.receiptsModel?.receipts?.map((e) {
                            Map data = e.toJson();
                            data.remove("id");
                            data["paid_by"] =
                                data["paid_by"] + " (${data["payee_type"]})";
                            data.remove("payee_type");
                            data["actions"] = null;
                            return receiptsDataRow(
                              data,
                              onTap: () {
                                context
                                    .read<ReceiptDetailsCubit>()
                                    .getReceiptDetails(context, e.id);
                                Navigator.pushNamed(
                                    context, AppRoutes.receiptDetails);
                              },
                            );
                          }).toList() ??
                          []),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  DataRow receiptsDataRow(Map data, {void Function()? onTap}) {
    return DataRow(
        cells: data.values
            .toList()
            .map((e) => receiptsDataCell(e, onTap: onTap))
            .toList());
  }

  DataCell receiptsDataCell(dynamic text, {void Function()? onTap}) {
    return DataCell(
        Center(
          child: text == null
              ? const Icon(
                  Icons.download_outlined,
                  color: primaryColor,
                )
              : CustomText(
                  text: text.toString(),
                ),
        ),
        onTap: onTap);
  }

  Widget filterView(BuildContext context) {
    return BlocBuilder<ReceiptsCubit, ReceiptsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Date Range"),
            const Gap(10),
            const LedgerPage().dateRangeCustomTextWidget(
              context,
              state.dateRange != null
                  ? "${const OccupantPage().dateTimeFormatter(state.dateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.dateRange?.end)}"
                  : "Select date range",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 1, 1),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) =>
                    context.read<ReceiptsCubit>().onChangedateRange(value),
              ),
            ),
          ],
        );
      },
    );
  }
}

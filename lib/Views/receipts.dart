import 'package:iskaanowner/Models/receipts.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';
import 'ledger_by_statement.dart';

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
              icon: Icon(
                Icons.filter_alt_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
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
            Expanded(
              child: BlocBuilder<ReceiptsCubit, ReceiptsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.receiptsModel?.receipts?.isEmpty ?? true) {
                    return const CreditNotesPage().emptyList();
                  }
                  return ListView.builder(
                    itemCount: state.receiptsModel?.receipts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Receipt? receipt = state.receiptsModel?.receipts?[index];
                      return InkWell(
                        onTap: () {
                          const LedgerByStatement()
                              .decidePage(context, receipt?.id, "receipt");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: kGrey.shade200,
                                  blurRadius: 2,
                                  spreadRadius: 2)
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.receipt_outlined,
                                  color: kWhite,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: receipt?.reference ?? " -- ",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const Gap(10),
                                        CustomText(
                                          text: const OccupantPage()
                                              .dateTimeFormatter(
                                                  receipt?.datetime),
                                          color: kGrey,
                                          fontsize: 12,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: receipt?.paidBy ?? " -- ",
                                          fontsize: 14,
                                        ),
                                        CustomText(
                                          text:
                                              " (${receipt?.payeeType ?? " -- "})",
                                          fontsize: 12,
                                          color: kGrey,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: formatCurrency(
                                              receipt?.amount ?? 0),
                                          fontsize: 13,
                                        ),
                                        Icon(
                                          Icons.download_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  DataRow receiptsDataRow(BuildContext context, Map data,
      {void Function()? onTap, void Function()? urlOnTap}) {
    return DataRow(
        cells: List.generate(
            data.values.toList().length,
            (index) => receiptsDataCell(context, data.values.toList()[index],
                onTap: onTap,
                isIcon:
                    index == (data.values.toList().length - 1) ? true : false,
                urlOnTap: urlOnTap)));
  }

  DataCell receiptsDataCell(BuildContext context, dynamic text,
      {void Function()? onTap,
      bool isIcon = false,
      void Function()? urlOnTap}) {
    return DataCell(
        isIcon
            ? Center(
                child: Icon(
                  Icons.download_outlined,
                  color: context.read<AppThemeCubit>().state.primaryColor,
                ),
              )
            : CustomText(
                text: (text ?? " -- ").toString(),
              ),
        onTap: isIcon ? urlOnTap : onTap);
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

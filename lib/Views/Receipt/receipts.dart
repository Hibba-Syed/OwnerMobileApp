import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';
import '../../Widgets/receipts_list_page.dart';

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
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
              child: ReceiptsListPage(
                unitId: unitId,
              ),
            ),
          ],
        ),
      ),
    );
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
import '../../Utils/utils.dart';

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const DashboardPage().appBar(
                  context,
                  text: "Unit $unitNumber - Receipts",
                  trailingIcon: IconButton(
                    onPressed: () => const LedgerPage().showFilter(context,
                        child: filterView(context), resetFunction: () {
                      context.read<ReceiptsCubit>().reset();
                      context
                          .read<ReceiptsCubit>()
                          .getReceipts(context, unitId);
                      Navigator.pop(context);
                    }, applyFunction: () {
                      context
                          .read<ReceiptsCubit>()
                          .getReceipts(context, unitId);
                      Navigator.pop(context);
                    }),
                    icon: Image.asset(
                      "assets/filter.png",
                      scale: 4,
                    ),
                  ),
                ),
                CustomSearch(
                  initialValue: context.read<ReceiptsCubit>().state.keyword,
                  onSubmitted: (value) {
                    context.read<ReceiptsCubit>().onChangeKeyword(value);
                    context.read<ReceiptsCubit>().getReceipts(context, unitId);
                  },
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
            CustomText(
              text: "Date Range",
              color: const Color(0xffB2B1B1),
              fontSize: MediaQuery.of(context).size.width * 0.032,
            ),
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
                    context.read<ReceiptsCubit>().onChangeDateRange(value),
              ),
            ),
          ],
        );
      },
    );
  }
}

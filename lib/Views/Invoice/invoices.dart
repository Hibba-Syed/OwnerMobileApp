import 'package:iskaanowner/Widgets/invoices_list_page.dart';

import '../../Utils/utils.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const DashboardPage().appBar(
                context,
              
                  text: "Unit $unitNumber - Invoices",
              
                trailingIcon: IconButton(
                  onPressed: () => const LedgerPage().showFilter(context,
                      child: filterView(context), resetFunction: () {
                    context.read<InvoicesCubit>().reset();
                    context.read<InvoicesCubit>().getInvoices(context, unitId);
                    Navigator.pop(context);
                  }, applyFunction: () {
                    context.read<InvoicesCubit>().getInvoices(context, unitId);
                    Navigator.pop(context);
                  }),
                  icon: Image.asset(
                    "assets/filter.png",
                    scale: 4,
                  ),
                ),
              ),
              CustomSearch(
                initialValue: context.read<InvoicesCubit>().state.keyword,
                onSubmitted: (value) {
                  context.read<InvoicesCubit>().onChangeKeyword(value);
                  context.read<InvoicesCubit>().getInvoices(context, unitId);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: InvoicesListPage(
                  unitId: unitId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterView(BuildContext context) {
    return BlocBuilder<InvoicesCubit, InvoicesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Invoice Date Range",
              color: const Color(0xffB2B1B1),
              fontSize: MediaQuery.of(context).size.width * 0.032,
            ),
            const Gap(10),
            const LedgerPage().dateRangeCustomTextWidget(
              context,
              state.invoiceDateRange != null
                  ? "${const OccupantPage().dateTimeFormatter(state.invoiceDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.invoiceDateRange?.end)}"
                  : "Select date range",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 01, 01),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) => context
                    .read<InvoicesCubit>()
                    .onChangeInvoiceDateRange(value),
              ),
            ),
            const Gap(10),
            CustomText(
              text: "Due Date Range",
              color: const Color(0xffB2B1B1),
              fontSize: MediaQuery.of(context).size.width * 0.032,
            ),
            const Gap(10),
            const LedgerPage().dateRangeCustomTextWidget(
              context,
              state.dueDateRange != null
                  ? "${const OccupantPage().dateTimeFormatter(state.dueDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.dueDateRange?.end)}"
                  : "Select date range",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 01, 01),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) =>
                    context.read<InvoicesCubit>().onChangeDueDateRange(value),
              ),
            ),
          ],
        );
      },
    );
  }
}

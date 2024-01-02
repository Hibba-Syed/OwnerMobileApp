import 'package:iskaanowner/Widgets/invoices_list_page.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
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
      appBar: BaseAppBar(
        title: "$unitNumber - Invioces",
        appBar: AppBar(),
        widgets: [
          IconButton(
              onPressed: () => const LedgerPage().showFilter(context,
                      child: filterView(context), resetFunction: () {
                    context.read<InvoicesCubit>().reset();
                    context.read<InvoicesCubit>().getInvoices(context, unitId);
                    Navigator.pop(context);
                  }, applyFunction: () {
                    context.read<InvoicesCubit>().getInvoices(context, unitId);
                    Navigator.pop(context);
                  }),
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
    );
  }

  Widget filterView(BuildContext context) {
    return BlocBuilder<InvoicesCubit, InvoicesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Invoice Date Range"),
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
            const CustomText(text: "Due Date Range"),
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

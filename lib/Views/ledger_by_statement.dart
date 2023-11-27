import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';
import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';
import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class LedgerByStatement extends StatelessWidget {
  const LedgerByStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerCubit, LedgerState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.ledgerByStatementModel?.record?.data?.ledgers?.isEmpty ??
            true) {
          return const CreditNotesPage().emptyList();
        }
        return SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) =>
                    context
                        .read<AppThemeCubit>()
                        .state
                        .primaryColor
                        .withOpacity(0.1)),
                border: TableBorder.all(
                    color: context.read<AppThemeCubit>().state.primaryColor),
                columns: [
                  "Date",
                  "Document",
                  "Reference",
                  "Type",
                  "Description",
                  "Debit",
                  "Credit",
                  "Balance",
                ]
                    .map((e) =>
                        const SharedDocumentPage().sharedDocumentDataColumn(e))
                    .toList(),
                rows: state.ledgerByStatementModel?.record?.data?.ledgers
                        ?.map((e) => const LedgerPage().ledgerDataRow(
                              e.toJson()..remove("id"),
                              context: context,
                              onTap: () =>
                                  decidePage(context, e.id, e.document),
                            ))
                        .toList() ??
                    []),
          ),
        );
      },
    );
  }

  void decidePage(BuildContext context, int? id, String? document) {
    String? page;
    if (document?.toLowerCase() == "receipt") {
      context.read<ReceiptDetailsCubit>().getReceiptDetails(context, id);
      page = AppRoutes.receiptDetails;
    }
    if (document?.toLowerCase().contains("credit") ?? false) {
      context.read<CreditNoteDetailsCubit>().getCreditNoteDetails(context, id);
      page = AppRoutes.creditNoteDetails;
    }
    if (document?.toLowerCase() == "invoice") {
      context.read<InvoiceDetailsCubit>().getInvoiceDetails(context, id);
      page = AppRoutes.invoiceDetails;
    }
    if (page != null) {
      Navigator.pushNamed(context, page);
    }
  }
}

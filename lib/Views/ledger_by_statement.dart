import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';
import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';
import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/ledger_by_statement.dart';
import '../Utils/utils.dart';
import 'ledger_by_account_details.dart';

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
        return ListView.builder(
          itemCount:
              state.ledgerByStatementModel?.record?.data?.ledgers?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Ledger? ledger =
                state.ledgerByStatementModel?.record?.data?.ledgers?[index];
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: kGrey.shade200, blurRadius: 2, spreadRadius: 2)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor),
                        padding: const EdgeInsets.all(10),
                        child: const LedgerByAccountDetailsPage()
                            .ledgerIcon(ledger?.document),
                      ),
                      const Gap(10),
                      CustomText(
                        text: " ${ledger?.type ?? " -- "}",
                        fontWeight: FontWeight.bold,
                      ),
                      const Gap(10),
                      const Spacer(),
                      const Gap(10),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor
                                  .withOpacity(0.2)),
                          child: CustomText(text: ledger?.document ?? "")),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: ledger?.reference ?? " -- ",
                        fontWeight: FontWeight.bold,
                      ),
                      const Gap(10),
                      CustomText(
                        text: const OccupantPage()
                            .dateTimeFormatter(ledger?.date),
                        color: kGrey,
                        fontsize: 12,
                      ),
                    ],
                  ),
                  CustomText(
                    text: ledger?.description ?? " -- ",
                    fontsize: 15,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Debit : ",
                        fontsize: 13,
                      ),
                      CustomText(
                        text: "${(ledger?.debit ?? 0).toStringAsFixed(2)} AED",
                        fontsize: 13,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Credit : ",
                        fontsize: 13,
                      ),
                      CustomText(
                        text: "${(ledger?.credit ?? 0).toStringAsFixed(2)} AED",
                        fontsize: 13,
                      ),
                    ],
                  ),
                  const Divider(
                    color: kGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Balance : ",
                        fontsize: 13,
                      ),
                      CustomText(
                        text:
                            "${(ledger?.balance ?? 0).toStringAsFixed(2)} AED",
                        fontsize: 13,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
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

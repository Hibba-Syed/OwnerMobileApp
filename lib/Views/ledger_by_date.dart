import 'package:iskaanowner/Views/ledger_by_account_details.dart';
import 'package:iskaanowner/Views/ledger_by_statement.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/ledger_by_date.dart';
import '../Utils/utils.dart';

class LedgerByDate extends StatelessWidget {
  const LedgerByDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerCubit, LedgerState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.ledgerByDateModel?.record?.data?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList();
        }
        return ListView.builder(
          itemCount: state.ledgerByDateModel?.record?.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            LedgerByDateDatum? ledgerByDateDatum =
                state.ledgerByDateModel?.record?.data?[index];
            return InkWell(
              onTap: () {
                const LedgerByStatement().decidePage(context,
                    ledgerByDateDatum?.id, ledgerByDateDatum?.document);
              },
              child: Container(
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
                              .ledgerIcon(ledgerByDateDatum?.document),
                        ),
                        const Gap(10),
                        CustomText(
                          text: " ${ledgerByDateDatum?.type ?? " -- "}",
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
                            child: CustomText(
                                text: ledgerByDateDatum?.document
                                            ?.toLowerCase() ==
                                        "credit_memo"
                                    ? "Credit Note"
                                    : ledgerByDateDatum?.document == "" ||
                                            ledgerByDateDatum?.document == " "
                                        ? "JV"
                                        : ledgerByDateDatum?.document ?? "JV")),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: ledgerByDateDatum?.account ?? " -- ",
                            fontsize: 18,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Gap(10),
                        CustomText(
                          text: const OccupantPage()
                              .dateTimeFormatter(ledgerByDateDatum?.date),
                          color: kGrey,
                          fontsize: 12,
                        ),
                      ],
                    ),
                    CustomText(
                      text: ledgerByDateDatum?.transactionNo ?? " -- ",
                      fontsize: 13,
                    ),
                    CustomText(
                      text: ledgerByDateDatum?.reference ?? " -- ",
                      fontWeight: FontWeight.w500,
                      fontsize: 17,
                    ),
                    CustomText(
                      text: ledgerByDateDatum?.description ?? " -- ",
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
                          text: formatCurrency(ledgerByDateDatum?.debit ?? 0),
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
                          text: formatCurrency(ledgerByDateDatum?.credit ?? 0),
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
                          text: formatCurrency(ledgerByDateDatum?.balance ?? 0),
                          fontsize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

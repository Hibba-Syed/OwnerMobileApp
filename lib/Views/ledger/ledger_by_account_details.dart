import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Models/ledger_by_account.dart';
import '../../Utils/utils.dart';

class LedgerByAccountDetailsPage extends StatelessWidget {
  const LedgerByAccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AccountDatum? accountDatum =
        ModalRoute.of(context)?.settings.arguments as AccountDatum?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                text: accountDatum?.name ?? "",
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: accountDatum?.transactions?.length,
                itemBuilder: (BuildContext context, int index) {
                  LedgerAccountDatum? ledgerAccountDatum =
                      accountDatum?.transactions?[index];
                  return InkWell(
                    onTap: () {
                      const LedgerPage().decidePage(context,
                          ledgerAccountDatum?.id, ledgerAccountDatum?.document);
                    },
                    child: Column(
                      children: [
                        if (index == 0)
                          const LedgerPage().openingAndClosingBalance(
                              context,
                              accountDatum?.openingBalance,
                              accountDatum?.closingBalance),
                        if (index == 0) const Gap(5),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: CustomText(
                                      text: ledgerAccountDatum?.reference ?? "",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      color: const Color(0xffB2B1B1),
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const RequestsPage().iconAndText(
                                          context,
                                          "assets/calender.png",
                                          const OccupantPage()
                                              .dateTimeFormatter(
                                                  ledgerAccountDatum?.date),
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                              text:
                                                  "● ${ledgerAccountDatum?.type}",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              color: Color(ledgerAccountDatum
                                                          ?.type
                                                          ?.toLowerCase() !=
                                                      "payment"
                                                  ? 0xffFB5454
                                                  : 0xff65D024),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          const LedgerByAccountDetailsPage()
                                              .ledgerImageIcon(
                                                  ledgerAccountDatum?.document),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          text: ledgerAccountDatum?.document
                                                      ?.toLowerCase() ==
                                                  "credit_memo"
                                              ? "Credit Note"
                                              : ledgerAccountDatum?.document ==
                                                          "" ||
                                                      ledgerAccountDatum
                                                              ?.document ==
                                                          " "
                                                  ? "JV"
                                                  : ledgerAccountDatum
                                                          ?.document ??
                                                      "JV",
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.038,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor
                                              .withOpacity(0.8),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: ledgerAccountDatum
                                                  ?.transactionNo ??
                                              "",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.032,
                                          color: const Color(0xffB2B1B1),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(
                                              text: "Debit",
                                              fontSize: 13,
                                            ),
                                            const Gap(10),
                                            Flexible(
                                              child: CustomText(
                                                text: formatCurrency(
                                                    ledgerAccountDatum?.debit ??
                                                        0),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.032,
                                                color: const Color(0xffB2B1B1),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(
                                              text: "Credit",
                                              fontSize: 13,
                                            ),
                                            const Gap(10),
                                            Flexible(
                                              child: CustomText(
                                                text: formatCurrency(
                                                    ledgerAccountDatum
                                                            ?.credit ??
                                                        0),
                                                color: const Color(0xffB2B1B1),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.032,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        const Divider(
                                          color: kGrey,
                                        ),
                                        const Gap(5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: "Balance",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            const Gap(10),
                                            Flexible(
                                              child: CustomText(
                                                text: formatCurrency(
                                                    ledgerAccountDatum
                                                            ?.balance ??
                                                        0),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontWeight: FontWeight.bold,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ledgerIcon(String? type, {IconData? icon}) {
    if (type?.toLowerCase() == "receipt") {
      return const Icon(
        Icons.receipt_outlined,
        color: kWhite,
      );
    }
    if (type?.toLowerCase() == "invoice") {
      return const Icon(
        Icons.receipt_long,
        color: kWhite,
      );
    }
    if (type?.toLowerCase() == "credit_memo") {
      return const Icon(
        Icons.note,
        color: kWhite,
      );
    }
    return Icon(
      icon ?? Icons.balance,
      color: kWhite,
    );
  }

  String ledgerImageIcon(String? type, {bool makeNotificationDefault = false}) {
    if (type?.toLowerCase() == "receipt") {
      return "assets/receipt.png";
    }
    if (type?.toLowerCase() == "invoice") {
      return "assets/invoice.png";
    }
    if (type?.toLowerCase() == "credit_memo") {
      return "assets/creditNote.png";
    }
    if (makeNotificationDefault) {
      return "assets/notification.png";
    }
    return "assets/ledger.png";
  }
}

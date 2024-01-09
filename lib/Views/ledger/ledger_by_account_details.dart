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
      appBar: BaseAppBar(
        title: accountDatum?.name ?? "",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: [const DashboardPage().notificationIcon(context)],
        appBarHeight: 50,
      ),
      body: Column(
        children: [
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                RowText(
                  text: "Opening Balance : ",
                  text2: formatCurrency(
                    accountDatum?.openingBalance ?? 0,
                  ),
                ),
                RowText(
                  text: "Closing Balance : ",
                  text2: formatCurrency(
                    accountDatum?.closingBalance ?? 0,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
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
                                child:
                                    ledgerIcon(ledgerAccountDatum?.document)),
                            const Gap(10),
                            CustomText(
                              text: ledgerAccountDatum?.type ?? " -- ",
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
                                    text: ledgerAccountDatum?.document
                                                ?.toLowerCase() ==
                                            "credit_memo"
                                        ? "Credit Note"
                                        : ledgerAccountDatum?.document == "" ||
                                                ledgerAccountDatum?.document ==
                                                    " "
                                            ? "JV"
                                            : ledgerAccountDatum?.document ??
                                                "JV")),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: ledgerAccountDatum?.reference ?? " -- ",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const Gap(10),
                            CustomText(
                              text: const OccupantPage()
                                  .dateTimeFormatter(ledgerAccountDatum?.date),
                              color: kGrey,
                              fontSize: 12,
                            ),
                          ],
                        ),
                        CustomText(
                          text: ledgerAccountDatum?.transactionNo ?? " -- ",
                          fontSize: 13,
                        ),
                        CustomText(
                          text: ledgerAccountDatum?.description ?? " -- ",
                          fontSize: 15,
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "Debit : ",
                              fontSize: 13,
                            ),
                            CustomText(
                              text: formatCurrency(
                                  ledgerAccountDatum?.debit ?? 0),
                              fontSize: 13,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "Credit : ",
                              fontSize: 13,
                            ),
                            CustomText(
                              text: formatCurrency(
                                  ledgerAccountDatum?.credit ?? 0),
                              fontSize: 13,
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
                              fontSize: 13,
                            ),
                            CustomText(
                              text: formatCurrency(
                                  ledgerAccountDatum?.balance ?? 0),
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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

  String ledgerImageIcon(String? type, {IconData? icon}) {
    if (type?.toLowerCase() == "receipt") {
      return "assets/receipt.png";
    }
    if (type?.toLowerCase() == "invoice") {
      return "assets/invoice.png";
    }
    if (type?.toLowerCase() == "credit_memo") {
      return "assets/creditNote.png";
    }
    return "assets/ledger.png";
  }
}

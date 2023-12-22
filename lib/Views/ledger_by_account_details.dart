import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/ledger_by_account.dart';
import '../Utils/utils.dart';

class LedgerByAccountDetailsPage extends StatelessWidget {
  const LedgerByAccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AccountDatum? accountDatum =
        ModalRoute.of(context)?.settings.arguments as AccountDatum?;
    return Scaffold(
      appBar: BaseAppBar(
        title: accountDatum?.ledgerName ?? "",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: accountDatum?.ledgers?.length,
        itemBuilder: (BuildContext context, int index) {
          LedgerAccountDatum? ledgerAccountDatum =
              accountDatum?.ledgers?[index];
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: kGrey.shade200, blurRadius: 2, spreadRadius: 2)
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
                        child: ledgerIcon(ledgerAccountDatum?.document)),
                    const Gap(10),
                    CustomText(
                      text: " ${ledgerAccountDatum?.type ?? " -- "}",
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
                            text: ledgerAccountDatum?.document ?? " -- ")),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: ledgerAccountDatum?.reference ?? " -- ",
                        fontsize: 18,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Gap(10),
                    CustomText(
                      text: const OccupantPage()
                          .dateTimeFormatter(ledgerAccountDatum?.date),
                      color: kGrey,
                      fontsize: 12,
                    ),
                  ],
                ),
                CustomText(
                  text: ledgerAccountDatum?.transactionNo ?? " -- ",
                  fontsize: 13,
                ),
                CustomText(
                  text: ledgerAccountDatum?.description ?? " -- ",
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
                      text:
                          "${(ledgerAccountDatum?.debit ?? 0).toStringAsFixed(2)} AED",
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
                      text:
                          "${(ledgerAccountDatum?.credit ?? 0).toStringAsFixed(2)} AED",
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
                          "${(ledgerAccountDatum?.balance ?? 0).toStringAsFixed(2)} AED",
                      fontsize: 13,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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
}

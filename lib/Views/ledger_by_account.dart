import 'package:iskaanowner/Models/ledger_by_account.dart';

import '../Utils/utils.dart';

class LedgerByAccount extends StatelessWidget {
  const LedgerByAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerCubit, LedgerState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.ledgerByAccountModel?.record?.data?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList();
        }
        return ListView.builder(
          itemCount: state.ledgerByAccountModel?.record?.data?.length,
          itemBuilder: (BuildContext context, int index) {
            AccountDatum? accountDatum =
                state.ledgerByAccountModel?.record?.data?[index];
            return InkWell(
              onTap: () {
                if (accountDatum?.ledgers?.isNotEmpty ?? false) {
                  Navigator.pushNamed(context, AppRoutes.ledgerByAccountDetail,
                      arguments: accountDatum);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(1, 1),
                          color: kGrey.shade200,
                          blurRadius: 2,
                          spreadRadius: 2),
                    ]),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: accountDatum?.ledgerName ?? "",
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          fontsize: 17,
                        ),
                        const Gap(20),
                        const Text(
                          "0 AED",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                    const Icon(Icons.keyboard_double_arrow_right_outlined)
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

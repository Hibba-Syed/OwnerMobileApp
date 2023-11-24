import 'package:expandable/expandable.dart';
import 'package:iskaanowner/Models/ledger_by_account.dart';
import 'package:iskaanowner/Views/ledger_by_statement.dart';

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
        return ListView.builder(
          itemCount: state.ledgerByAccountModel?.record?.data?.length,
          itemBuilder: (BuildContext context, int index) {
            AccountDatum? accountDatum =
                state.ledgerByAccountModel?.record?.data?[index];
            return Container(
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
              child: ExpandablePanel(
                header: CustomText(
                  text: accountDatum?.ledgerName ?? "",
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                  fontsize: 17,
                ),
                collapsed: const Text(
                  "AED 0",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: tableView(accountDatum?.ledgers, context),
              ),
            );
          },
        );
      },
    );
  }

  Widget tableView(List<LedgerAccountDatum>? ledgers, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => primaryColor.withOpacity(0.1)),
          border: TableBorder.all(color: primaryColor),
          columns: [
            "Date",
            "Document",
            "Reference",
            "Type",
            "Transaction No",
            "Description",
            "Debit",
            "Credit",
            "Balance",
          ]
              .map(
                  (e) => const SharedDocumentPage().sharedDocumentDataColumn(e))
              .toList(),
          rows: ledgers
                  ?.map((e) => const LedgerPage().ledgerDataRow(
                      e.toJson()..remove("id"),context: context,
                      onTap: () => const LedgerByStatement()
                          .decidePage(context, e.id, e.document)))
                  .toList() ??
              []),
    );
  }
}

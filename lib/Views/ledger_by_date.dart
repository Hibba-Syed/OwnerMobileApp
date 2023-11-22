import 'package:iskaanowner/Views/ledger_by_statement.dart';

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
        return SingleChildScrollView(
          child: SingleChildScrollView(
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
                  "Account",
                  "Description",
                  "Debit",
                  "Credit",
                  "Balance",
                ]
                    .map((e) =>
                        const SharedDocumentPage().sharedDocumentDataColumn(e))
                    .toList(),
                rows: state.ledgerByDateModel?.record?.data
                        ?.map(
                          (e) => const LedgerPage().ledgerDataRow(
                              e.toJson()..remove("id"),
                              onTap: () => const LedgerByStatement()
                                  .decidePage(context, e.id, e.document)),
                        )
                        .toList() ??
                    []),
          ),
        );
      },
    );
  }
}

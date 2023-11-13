import 'package:iskaanowner/Views/ledger.dart';
import 'package:iskaanowner/Views/shared_documnet.dart';

import '../Blocs/Ledger/ledger_cubit.dart';
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
                  "Description",
                  "Debit",
                  "Credit",
                  "Balance",
                ]
                    .map((e) =>
                        const SharedDocumentPage().sharedDocumentDataColumn(e))
                    .toList(),
                rows: state.ledgerByStatementModel?.record?.data?.ledgers
                        ?.map(
                            (e) => const LedgerPage().ledgerDataRow(e.toJson()))
                        .toList() ??
                    []),
          ),
        );
      },
    );
  }
}

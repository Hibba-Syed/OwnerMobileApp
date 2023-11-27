import 'package:iskaanowner/Views/ledger_by_statement.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
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
                              context: context,
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

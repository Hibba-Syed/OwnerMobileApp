import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class CreditNotesPage extends StatelessWidget {
  const CreditNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String?;
    int? unitId =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Credit Notes",
        appBar: AppBar(),
        widgets: [
          IconButton(
              onPressed: () {
                const LedgerPage().showFilter(context,
                    child: filterView(context), resetFunction: () {
                  context.read<CreditNotesCubit>().reset();
                  context
                      .read<CreditNotesCubit>()
                      .getCreditNotes(context, unitId);
                  Navigator.pop(context);
                }, applyFunction: () {
                  context
                      .read<CreditNotesCubit>()
                      .getCreditNotes(context, unitId);
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.filter_alt_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ))
        ],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomSearch(
              initialValue: context.read<CreditNotesCubit>().state.keyword,
              onChanged: (value) =>
                  context.read<CreditNotesCubit>().onChangeKeyword(value),
              onSubmitted: (value) => context
                  .read<CreditNotesCubit>()
                  .getCreditNotes(context, unitId),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<CreditNotesCubit, CreditNotesState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.creditNotesModel?.creditNotes?.isEmpty ?? true) {
                    return emptyList();
                  }
                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor
                                  .withOpacity(0.1)),
                          border: TableBorder.all(
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor),
                          columns: [
                            "Date",
                            "Reference",
                            "Description",
                            "Amount",
                            "Actions",
                          ]
                              .map((e) => const SharedDocumentPage()
                                  .sharedDocumentDataColumn(e))
                              .toList(),
                          rows: state.creditNotesModel?.creditNotes?.map((e) {
                                Map data = e.toJson();
                                data.remove("id");
                                data["action"] = null;
                                return const ReceiptsPage().receiptsDataRow(
                                  context,
                                  data,
                                  onTap: () {
                                    context
                                        .read<CreditNoteDetailsCubit>()
                                        .getCreditNoteDetails(context, e.id);
                                    Navigator.pushNamed(
                                        context, AppRoutes.creditNoteDetails);
                                  },
                                );
                              }).toList() ??
                              []),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget filterView(BuildContext context) {
    return BlocBuilder<CreditNotesCubit, CreditNotesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Date Range"),
            const Gap(10),
            const LedgerPage().dateRangeCustomTextWidget(
              context,
              state.dateRange != null
                  ? "${const OccupantPage().dateTimeFormatter(state.dateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.dateRange?.end)}"
                  : "Select date range",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 01, 01),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) =>
                    context.read<CreditNotesCubit>().onChangedateRange(value),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget emptyList() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "No results found !!",
          ),
        ],
      ),
    );
  }
}

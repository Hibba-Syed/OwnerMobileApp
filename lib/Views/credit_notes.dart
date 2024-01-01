import 'package:iskaanowner/Widgets/credit_notes_list_page.dart';
import 'package:lottie/lottie.dart';

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
                child: CreditNotesListPage(
              unitId: unitId,
            ))
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

  Widget emptyList(
      {String lottie = "assets/not found.json",
      double? width = 200,
      String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            lottie,
            width: width,
          ),
          const Gap(20),
          CustomText(
            text: message ?? "No results found !!",
          ),
        ],
      ),
    );
  }
}

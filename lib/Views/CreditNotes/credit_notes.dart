import 'package:lottie/lottie.dart';

import '../../Utils/utils.dart';

class CreditNotesPage extends StatelessWidget {
  const CreditNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const DashboardPage().appBar(
                  context,
                  text: "Unit $unitNumber - Credit Notes",
                  trailingIcon: IconButton(
                    onPressed: () => const LedgerPage().showFilter(context,
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
                    }),
                    icon: Image.asset(
                      "assets/filter.png",
                      scale: 4,
                    ),
                  ),
                ),
                CustomSearch(
                  initialValue: context.read<CreditNotesCubit>().state.keyword,
                  fillColor: kWhite,
                  onSubmitted: (value) {
                    context.read<CreditNotesCubit>().onChangeKeyword(value);
                    context
                        .read<CreditNotesCubit>()
                        .getCreditNotes(context, unitId);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: CreditNotesListPage(
                    unitId: unitId,
                  ),
                ),
              ],
            ),
          ),
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
            CustomText(
              text: "Date Range",
              color: const Color(0xffB2B1B1),
              fontSize: MediaQuery.of(context).size.width * 0.032,
            ),
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
                    context.read<CreditNotesCubit>().onChangeDateRange(value),
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
      String? message,
      void Function()? ontap}) {
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
            text: message ?? "No results !!",
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomButton(text: "Refresh", function: ontap),
          )
        ],
      ),
    );
  }
}

import 'package:iskaanowner/Views/ledger_by_statement.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/credit_notes.dart';
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
                  return ListView.builder(
                    itemCount: state.creditNotesModel?.creditNotes?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      CreditNote? creditNote =
                          state.creditNotesModel?.creditNotes?[index];
                      return InkWell(
                        onTap: () {
                          const LedgerByStatement().decidePage(
                              context, creditNote?.id, "credit_memo");
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
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.note,
                                  color: kWhite,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: creditNote?.reference ?? " -- ",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const Gap(10),
                                        CustomText(
                                          text: const OccupantPage()
                                              .dateTimeFormatter(
                                                  creditNote?.date),
                                          color: kGrey,
                                          fontsize: 12,
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      text: creditNote?.description ?? " -- ",
                                      fontsize: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: formatCurrency(
                                              creditNote?.amount ?? 0),
                                          fontsize: 13,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (creditNote
                                                    ?.documents?.isEmpty ??
                                                true) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "No documents found to download");
                                              return;
                                            }
                                            launchUrl(Uri.parse(
                                                creditNote?.documents?.first));
                                          },
                                          child: Icon(
                                            Icons.download_outlined,
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
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

  Widget emptyList(
      {String lottie = "assets/not found.json", double? width = 200}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            lottie,
            width: width,
          ),
          const Gap(20),
          const CustomText(
            text: "No results found !!",
          ),
        ],
      ),
    );
  }
}

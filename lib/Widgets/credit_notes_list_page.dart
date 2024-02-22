import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Models/credit_notes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';
import '../Views/ledger/ledger_by_account_details.dart';

class CreditNotesListPage extends StatefulWidget {
  final int? unitId;
  const CreditNotesListPage({super.key, this.unitId});

  @override
  State<CreditNotesListPage> createState() => _CreditNotesListPageState();
}

class _CreditNotesListPageState extends State<CreditNotesListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      CreditNotesCubit creditNotesCubit = context.read<CreditNotesCubit>();
      if (creditNotesCubit.state.loadMoreState != LoadingState.loading) {
        creditNotesCubit.getMoreCreditNotes(context, widget.unitId);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditNotesCubit, CreditNotesState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.creditNotesModel?.creditNotes?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
              ontap: () => context
                  .read<CreditNotesCubit>()
                  .getCreditNotes(context, widget.unitId));
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<CreditNotesCubit>()
                      .getCreditNotes(context, widget.unitId);
                },
                child: ListView.builder(
                  itemCount: state.creditNotesModel?.creditNotes?.length ?? 0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    CreditNote? creditNote =
                        state.creditNotesModel?.creditNotes?[index];

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            const LedgerPage().decidePage(
                                context, creditNote?.id, "credit_memo");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF2F2F2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        const LedgerByAccountDetailsPage()
                                            .ledgerImageIcon("credit_memo"),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                      ),
                                      const Gap(5),
                                      CustomText(
                                        text: "Credit Note",
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.038,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(0.8),
                                      )
                                    ],
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: CustomText(
                                              text: creditNote?.reference ?? "",
                                              fontSize: 13,
                                            ),
                                          ),
                                          const RequestsPage().iconAndText(
                                            context,
                                            "assets/calender.png",
                                            const OccupantPage()
                                                .dateTimeFormatter(
                                                    creditNote?.date),
                                          )
                                        ],
                                      ),
                                      const Gap(5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: CustomText(
                                              text: "Amount",
                                              fontSize: 13,
                                            ),
                                          ),
                                          Flexible(
                                            child: CustomText(
                                              text: formatCurrency(
                                                  creditNote?.amount),
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(5),
                                      const Divider(
                                        color: kGrey,
                                      ),
                                      const Gap(5),
                                      CustomButton(
                                        text: "Download",
                                        function: () {
                                          if (creditNote?.documents != null) {
                                            launchUrl(Uri.parse(
                                                creditNote?.documents ?? ""));
                                          }
                                        },
                                        padding: EdgeInsets.zero,
                                        buttonColor: const Color(0xff65D024)
                                            .withOpacity(0.1),
                                        textColor: const Color(0xff65D024),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        icon: Image.asset(
                                          "assets/download_summary.png",
                                          color: const Color(0xff65D024),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if ((index + 1) ==
                            state.creditNotesModel?.creditNotes?.length)
                          SizedBox(
                            height: 150,
                            child: state.loadMoreState == LoadingState.loading
                                ? const CustomLoader()
                                : null,
                          ),
                      ].animate(interval: 600.ms).fade(),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

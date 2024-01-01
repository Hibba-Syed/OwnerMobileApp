import 'package:iskaanowner/Models/credit_notes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

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
          return const CreditNotesPage().emptyList();
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  context.read<CreditNotesCubit>().getCreditNotes(context, widget.unitId);
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
                                                  creditNote?.documents ?? ""));
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
                        ),
                        if ((index + 1) ==
                            state.creditNotesModel?.creditNotes?.length)
                          const SizedBox(
                            height: 150,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (state.loadMoreState == LoadingState.loading)
              const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}

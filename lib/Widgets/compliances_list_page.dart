import 'package:iskaanowner/Blocs/Compliance%20Details/compliance_details_cubit.dart';
import 'package:slideable/slideable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/compliances.dart';
import '../Utils/utils.dart';

class CompliancesListPage extends StatefulWidget {
  final int? unitId;
  const CompliancesListPage({super.key, this.unitId});

  @override
  State<CompliancesListPage> createState() => _ReceiptListPageState();
}

class _ReceiptListPageState extends State<CompliancesListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      CompliancesCubit compliancesCubit = context.read<CompliancesCubit>();
      if (compliancesCubit.state.loadMoreState != LoadingState.loading) {
        compliancesCubit.getMoreCompliances(context, widget.unitId);
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
    return BlocBuilder<CompliancesCubit, CompliancesState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.compliancesModel?.compliances?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
              ontap: () => context
                  .read<CompliancesCubit>()
                  .getCompliances(context, widget.unitId));
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<CompliancesCubit>()
                      .getCompliances(context, widget.unitId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.compliancesModel?.compliances?.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Compliance? compliance =
                        state.compliancesModel?.compliances?[index];
                    return Column(
                      children: [
                        Slideable(
                          items: [
                            ActionItems(
                              icon: Icon(
                                Icons.edit,
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              onPress: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.editCompliances,
                                  arguments: {
                                    'unit_id': widget.unitId,
                                    'compliance': compliance,
                                  },
                                ).then((value) {
                                  if (value == true) {
                                    context
                                        .read<CompliancesCubit>()
                                        .getCompliances(context, widget.unitId);
                                  }
                                });
                              },
                              backgroundColor: Colors.transparent,
                            ),
                          ],
                          child: InkWell(
                            onTap: () {
                              if (compliance?.certificate?.isNotEmpty ??
                                  false) {
                                context
                                    .read<ComplianceDetailsCubit>()
                                    .getUnitComplianceDetails(
                                      context,
                                      compliance?.id,
                                      widget.unitId,
                                    );
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.complianceDetails,
                                  arguments: {
                                    "unit_id": widget.unitId,
                                    "id": compliance?.id,
                                  },
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(
                                      1,
                                      1,
                                    ),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    color: kGrey.shade200,
                                  ),
                                ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/compliances.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          text: "Compliance",
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const RequestsPage().iconAndText(
                                                context,
                                                "assets/calender.png",
                                                const OccupantPage()
                                                    .dateTimeFormatter(
                                                        compliance?.duedate)),
                                            const Gap(10),
                                            const RequestsPage().iconAndText(
                                              context,
                                              "assets/calender.png",
                                              "Expiry: ${const OccupantPage().dateTimeFormatter(compliance?.expiry)}",
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFAFAFA),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CustomText(
                                            text: compliance?.name ?? " -- ",
                                            maxLines: 1,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                        ),
                                        const Gap(10),
                                        CustomButton(
                                            text: compliance?.notApplicable == 1
                                                ? "Not Applicable"
                                                : "Download Certificate",
                                            padding: EdgeInsets.zero,
                                            buttonColor: compliance
                                                        ?.notApplicable ==
                                                    1
                                                ? const Color(0xffFB5454)
                                                    .withOpacity(0.1)
                                                : compliance?.certificate ==
                                                        null
                                                    ? kGrey.shade100
                                                    : const Color(0xff73E12F)
                                                        .withOpacity(0.1),
                                            textColor: compliance
                                                        ?.notApplicable ==
                                                    1
                                                ? const Color(0xffFB5454)
                                                : compliance?.certificate ==
                                                        null
                                                    ? kGrey
                                                    : const Color(0xff73E12F),
                                            icon: Image.asset(
                                              "assets/certificate.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: compliance
                                                          ?.notApplicable ==
                                                      1
                                                  ? const Color(0xffFB5454)
                                                  : compliance?.certificate ==
                                                          null
                                                      ? kGrey
                                                      : const Color(0xff73E12F),
                                            ),
                                            fontWeight: FontWeight.w500,
                                            height: MediaQuery
                                                        .of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            function: () {
                                              if (compliance?.notApplicable ==
                                                  1) {
                                                return;
                                              }
                                              if (compliance?.certificate !=
                                                      null &&
                                                  compliance?.certificate !=
                                                      "") {
                                                launchUrl(Uri.parse(
                                                    compliance?.certificate ??
                                                        ""));
                                                return;
                                              }
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "No certificate found to download");
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if ((index + 1) ==
                            state.compliancesModel?.compliances?.length)
                          SizedBox(
                            height: 150,
                            child: state.loadMoreState == LoadingState.loading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : null,
                          ),
                      ],
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

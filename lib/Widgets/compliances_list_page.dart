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
          return const CreditNotesPage().emptyList();
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
                        Container(
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.task_outlined,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor,
                                    size: 18,
                                  ),
                                  CustomText(
                                    text:
                                        "Compliance: ${compliance?.name ?? " -- "}",
                                    fontWeight: FontWeight.bold,
                                    fontsize: 15,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                      ),
                                      CustomText(
                                        text:
                                            "Date: ${const OccupantPage().dateTimeFormatter(compliance?.duedate)}",
                                        fontsize: 12,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                      ),
                                      CustomText(
                                        text:
                                            "Expiry Date: ${const OccupantPage().dateTimeFormatter(compliance?.expiry)}",
                                        fontsize: 12,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (compliance?.certificate != null &&
                                          compliance?.certificate != "") {
                                        launchUrl(Uri.parse(
                                            compliance?.certificate ?? ""));
                                        return;
                                      }
                                      Fluttertoast.showToast(
                                          msg:
                                              "No certificate found to download");
                                    },
                                    child: const UnitsPage().roundedContainer(
                                      context,
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.visibility_outlined,
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                            size: 18,
                                          ),
                                          const CustomText(
                                            text: " Certificate",
                                            fontsize: 14,
                                          )
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      invert: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if ((index + 1) ==
                            state.compliancesModel?.compliances?.length)
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

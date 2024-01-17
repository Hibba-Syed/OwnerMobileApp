import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/requests.dart';
import '../Utils/utils.dart';

class RequestListPage extends StatefulWidget {
  final int? unitId;
  const RequestListPage({super.key, this.unitId});

  @override
  State<RequestListPage> createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      RequestsCubit requestsCubit = context.read<RequestsCubit>();
      if (requestsCubit.state.loadMoreState != LoadingState.loading) {
        requestsCubit.getMoreRequests(context, widget.unitId);
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
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.requestsModel?.applications?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
              ontap: () => context.read<RequestsCubit>().getRequests(
                    context,
                    widget.unitId,
                  ));
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<RequestsCubit>().getRequests(
                        context,
                        widget.unitId,
                      );
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.requestsModel?.applications?.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Application? application =
                        state.requestsModel?.applications?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<RequestDetailsCubit>()
                                .getRequestDetails(context, application?.id,
                                    application?.applicationType);
                            String? routeName = const RequestsPage()
                                .getRouteName(application?.applicationType);
                            if (routeName != null) {
                              Navigator.pushNamed(context, routeName,
                                  arguments: [
                                    application?.id,
                                    application?.reference,
                                    application?.applicationType,
                                  ]);
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kWhite,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(
                                        1,
                                        1,
                                      ),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      color: kGrey.shade200),
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
                                          "assets/unit.png",
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
                                          text: const AdDetailsPage()
                                              .getRequestName(
                                                  application?.applicationType),
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
                                                "assets/reference.png",
                                                application?.reference,
                                                fontWeight: FontWeight.bold),
                                            const Gap(10),
                                            Flexible(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: const RequestsPage()
                                                      .getStatusColor(
                                                          application?.status)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: CustomText(
                                                  text:
                                                      "● ${application?.status}",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                  textAlign: TextAlign.center,
                                                  color: const RequestsPage()
                                                      .getStatusColor(
                                                          application?.status),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Gap(10),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFAFAFA),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/occupant.png",
                                                color: context
                                                    .read<AppThemeCubit>()
                                                    .state
                                                    .primaryColor,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              const Gap(10),
                                              CustomText(
                                                text: application?.clientName ??
                                                    "",
                                                maxLines: 1,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Gap(10),
                                        Row(
                                          children: [
                                            const RequestsPage().iconAndText(
                                              context,
                                              "assets/call.png",
                                              application?.clientPhone,
                                            ),
                                            const Gap(8),
                                            const RequestsPage().iconAndText(
                                                context,
                                                "assets/calender.png",
                                                const OccupantPage()
                                                    .dateTimeFormatter(
                                                        application?.createdAt),
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                        if ((index + 1) ==
                            state.requestsModel?.applications?.length)
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

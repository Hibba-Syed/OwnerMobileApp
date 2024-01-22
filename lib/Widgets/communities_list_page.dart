import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';

import '../Utils/utils.dart';

class CommunitiesListPage extends StatefulWidget {
  const CommunitiesListPage({super.key});

  @override
  State<CommunitiesListPage> createState() => _CommunitiesListPageState();
}

class _CommunitiesListPageState extends State<CommunitiesListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      CommunitiesCubit communitiesCubit = context.read<CommunitiesCubit>();
      if (communitiesCubit.state.loadMoreState != LoadingState.loading) {
        communitiesCubit.getMoreCommunities(context);
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
    return BlocBuilder<CommunitiesCubit, CommunitiesState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.loadingState == LoadingState.error ||
            (state.communitiesModel?.associations?.isEmpty ?? true)) {
          return const CreditNotesPage().emptyList(
            ontap: () =>
                context.read<CommunitiesCubit>().getCommunities(context),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<CommunitiesCubit>().getCommunities(context);
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: state.communitiesModel?.associations?.length,
            itemBuilder: (BuildContext context, int index) {
              Association? communitiesDatum =
                  state.communitiesModel?.associations?[index];
              return Column(
                children: [
                  if (index == 0) const DashboardPage().header(context),
                  InkWell(
                    onTap: () {
                      context
                          .read<UnitsCubit>()
                          .getUnits(context, communitiesDatum?.id);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.units,
                        arguments: [
                          communitiesDatum?.name,
                          communitiesDatum?.id
                        ],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                ImageBuilder(
                                  url: communitiesDatum?.backgroundImageUrl ??
                                      "",
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  width: double.infinity,
                                ),
                                if (communitiesDatum?.type != null)
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: kWhite,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: CustomText(
                                        text: communitiesDatum?.type
                                                ?.capitalize() ??
                                            "",
                                        color: kWhite,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: communitiesDatum?.name ?? " -- ",
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                  ),
                                  const Gap(10),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/home.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          const Gap(10),
                                          CustomText(
                                            text:
                                                "${communitiesDatum?.unitCount ?? 0}",
                                            color: const Color(0xffB2B1B1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035,
                                          ),
                                          const Gap(10),
                                          CustomText(
                                            text: "Unit(s)",
                                            color: const Color(0xffB2B1B1),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035,
                                          ),
                                          const Gap(10),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/location.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          const Gap(10),
                                          CustomText(
                                            text:
                                                communitiesDatum?.address ?? "",
                                            color: const Color(0xffB2B1B1),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if ((index + 1) ==
                      state.communitiesModel?.associations?.length)
                    SizedBox(
                      height: 150,
                      child: state.loadMoreState == LoadingState.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : null,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

import '../Blocs/App Theme/app_theme_cubit.dart';
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
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.communitiesModel?.associations?.length,
                itemBuilder: (BuildContext context, int index) {
                  Association? communitiesDatum =
                      state.communitiesModel?.associations?[index];
                  return InkWell(
                    onTap: () {
                      context
                          .read<UnitsCubit>()
                          .getUnits(context, communitiesDatum?.id);
                      Navigator.pushNamed(context, AppRoutes.units, arguments: [
                        communitiesDatum?.name,
                        communitiesDatum?.id
                      ]);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(1, 1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: kGrey.shade200),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              communitiesDatum?.backgroundImageUrl ?? "",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const UnitsPage().roundedContainer(
                                      context,
                                      const Icon(
                                        Icons.image_outlined,
                                      ),
                                      color: kGrey.shade300,
                                      height: 120,
                                      width: 120),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kGrey.shade200),
                                  child: CustomText(
                                      text: communitiesDatum?.name ?? " -- "),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          CustomText(
                                            text:
                                                (communitiesDatum?.unitCount ??
                                                        0)
                                                    .toString(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const CustomText(
                                            text: "Units",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: (communitiesDatum?.units
                                                as List)
                                            .map(
                                              (e) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                width: 70,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor),
                                                child: Column(
                                                  children: [
                                                    const Icon(
                                                      Icons.home_outlined,
                                                      color: kWhite,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    CustomText(
                                                      text: e.toString(),
                                                      color: kWhite,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ))
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
              ),
            ),
            if (state.loadMoreState == LoadingState.loading)
              const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class UnitsListPage extends StatefulWidget {
  final String? communityName;
  final int? communityId;
  const UnitsListPage({super.key, this.communityName, this.communityId});

  @override
  State<UnitsListPage> createState() => _UnitsListPageState();
}

class _UnitsListPageState extends State<UnitsListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      UnitsCubit unitsCubit = context.read<UnitsCubit>();
      if (unitsCubit.state.loadMoreState != LoadingState.loading) {
        unitsCubit.getMoreUnits(context, widget.communityId);
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
    return BlocBuilder<UnitsCubit, UnitsState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.unitsModel?.units?.length,
                itemBuilder: (BuildContext context, int index) {
                  Unit? unit = state.unitsModel?.units?[index];
                  List infoList = [
                    const UnitsPage()
                        .infoCards(context, unit?.unitSizeSqft, "Size"),
                    const UnitsPage()
                        .infoCards(context, unit?.bedroomCount, "Bedroom"),
                    const UnitsPage()
                        .infoCards(context, unit?.bathroomCount, "Bathroom"),
                    const UnitsPage()
                        .infoCards(context, unit?.parkings, "Parking"),
                  ];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.unitDetails,
                            arguments: [
                              widget.communityName,
                              unit?.unitNumber,
                              unit?.unitId,
                              unit?.slug,
                            ],
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1, 1),
                                  color: kGrey.shade300,
                                  blurRadius: 2,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const UnitsPage().cardHeader(context, unit),
                              const Gap(10),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Divider(
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor,
                                  ),
                                  GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 2 / 2.5),
                                    itemCount: infoList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return infoList[index];
                                    },
                                  ),
                                ],
                              ),
                              Divider(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "Balance",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Gap(10),
                                    const Expanded(child: Divider()),
                                    const Gap(10),
                                    CustomText(
                                      text: formatCurrency(
                                          unit?.unitBalance ?? 0),
                                      fontsize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if ((index + 1) == state.unitsModel?.units?.length)
                        const SizedBox(
                          height: 150,
                        ),
                    ],
                  );
                },
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

import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';

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
        if (state.loadingState == LoadingState.error ||
            (state.unitsModel?.units?.isEmpty ?? true)) {
          return const CreditNotesPage().emptyList(
            ontap: () => context
                .read<UnitsCubit>()
                .getUnits(context, widget.communityId),
          );
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<UnitsCubit>()
                      .getUnits(context, widget.communityId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.unitsModel?.units?.length ?? 0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Unit? unit = state.unitsModel?.units?[index];
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
                              padding: const EdgeInsets.all(10),
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
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
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
                                          text: unit?.unitNumber ?? "",
                                          fontWeight: FontWeight.bold,
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
                                        unitInfoRow(
                                          "assets/bath.png",
                                          unit?.bathroomCount ?? 0,
                                          "Bathroom",
                                          "assets/bed.png",
                                          unit?.bedroomCount ?? 0,
                                          "Bedroom",
                                        ),
                                        unitInfoRow(
                                            "assets/sqft.png",
                                            unit?.unitSizeSqft ?? 0,
                                            "Sqft",
                                            "assets/parking.png",
                                            unit?.parkings ?? 0,
                                            "Parking"),
                                        const Divider(
                                          color: Color(0xffB2B1B1),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: "Balance",
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            const Gap(10),
                                            Flexible(
                                              child:
                                                  Builder(builder: (context) {
                                                Color? color;
                                                if (unit?.unitBalance != null) {
                                                  if (unit!.unitBalance!
                                                      .isNegative) {
                                                    color =
                                                        const Color(0xffFB5454);
                                                  } else {
                                                    color =
                                                        const Color(0xff65D024);
                                                  }
                                                }
                                                return CustomText(
                                                  text: formatCurrency(
                                                      unit?.unitBalance),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  color: color,
                                                );
                                              }),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                        if ((index + 1) == state.unitsModel?.units?.length)
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

  Widget unitInfoRow(String image1, int count1, String text1, String image2,
      int count2, String text2) {
    return Row(
      children: [
        Expanded(child: individualInfo(image1, count1, text1)),
        const Gap(10),
        Expanded(child: individualInfo(image2, count2, text2)),
      ],
    );
  }

  Widget individualInfo(String image, int count, String text) {
    return Row(
      children: [
        Image.asset(
          image,
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        const Gap(5),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$count  ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffB2B1B1),
                  ),
                ),
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: const Color(0xffB2B1B1),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

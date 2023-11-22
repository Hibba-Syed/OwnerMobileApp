import 'package:flutter/cupertino.dart';

import '../Utils/utils.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? communityName =
        ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: BaseAppBar(
        title: communityName ?? "",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "My Properties",
              color: primaryColor,
              fontsize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<UnitsCubit, UnitsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  return ListView.builder(
                    itemCount: state.unitsModel?.units?.length,
                    itemBuilder: (BuildContext context, int index) {
                      Unit? unit = state.unitsModel?.units?[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.unitDetails,
                            arguments: [
                              communityName,
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
                            children: [
                              cardHeader(unit),
                              Row(
                                children: [
                                  roundedContainer(
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.home_outlined,
                                          color: kWhite,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CustomText(
                                          text: unit?.unitNumber ?? "",
                                          color: kWhite,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 70,
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Divider(
                                          color: primaryColor,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Gap(10),
                                              roundedContainer(
                                                Column(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          (unit?.unitSizeSqft ??
                                                                  0)
                                                              .toString(),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const CustomText(
                                                      text: "Size",
                                                      fontsize: 12,
                                                    )
                                                  ],
                                                ),
                                                invert: true,
                                                padding:
                                                    const EdgeInsets.all(5),
                                              ),
                                              const Gap(10),
                                              roundedContainer(
                                                Column(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          (unit?.bedroomCount ??
                                                                  0)
                                                              .toString(),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const CustomText(
                                                      text: "Bedroom",
                                                      fontsize: 12,
                                                    )
                                                  ],
                                                ),
                                                invert: true,
                                                padding:
                                                    const EdgeInsets.all(5),
                                              ),
                                              const Gap(10),
                                              roundedContainer(
                                                Column(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          (unit?.bathroomCount ??
                                                                  0)
                                                              .toString(),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const CustomText(
                                                      text: "Bathroom",
                                                      fontsize: 12,
                                                    )
                                                  ],
                                                ),
                                                invert: true,
                                                padding:
                                                    const EdgeInsets.all(5),
                                              ),
                                              const Gap(10),
                                              roundedContainer(
                                                Column(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          (unit?.parkings ?? 0)
                                                              .toString(),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const CustomText(
                                                      text: "Parking",
                                                      fontsize: 12,
                                                    )
                                                  ],
                                                ),
                                                invert: true,
                                                padding:
                                                    const EdgeInsets.all(5),
                                              ),
                                              const Gap(10),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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

  Widget roundedContainer(Widget child,
      {EdgeInsetsGeometry? margin,
      double? width,
      double? height,
      EdgeInsetsGeometry? padding,
      bool invert = false,
      AlignmentGeometry? alignment,
      Color? color}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: invert ? kWhite : color ?? primaryColor,
        border: invert ? Border.all(color: primaryColor) : null,
      ),
      child: child,
    );
  }

  Widget cardHeader(Unit? unit) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // roundedContainer(
          //   CustomText(
          //     text: unit?.name ?? "",
          //     color: primaryColor,
          //     fontsize: 12,
          //   ),
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          //   color: primaryColor.withOpacity(0.1),
          // ),
          roundedContainer(
            CustomText(
              text: "Balance : ${unit?.balance} AED",
              color: kWhite,
              fontsize: 12,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          ),
        ],
      ),
    );
  }

  Widget tenantInfo(Unit? unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          roundedContainer(
            const Row(
              children: [
                Icon(
                  CupertinoIcons.person_alt_circle,
                  color: primaryColor,
                  size: 15,
                ),
                CustomText(
                  text: " Occupant",
                  color: primaryColor,
                  fontsize: 12,
                )
              ],
            ),
            invert: true,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          ),
          const SizedBox(
            width: 10,
          ),
          CustomText(
            text: unit?.residentName ?? "",
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget contactsRow(List contacts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: contacts
              .map(
                (e) => roundedContainer(
                  Row(
                    children: [
                      Icon(
                        e["icon"] as IconData,
                        color: primaryColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: e["name"] as String,
                        color: primaryColor,
                        fontsize: 12,
                      )
                    ],
                  ),
                  invert: true,
                  margin: const EdgeInsets.only(right: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

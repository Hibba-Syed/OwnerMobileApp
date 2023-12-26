import '../Blocs/App Theme/app_theme_cubit.dart';
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
            CustomText(
              text: "My Properties",
              color: context.read<AppThemeCubit>().state.primaryColor,
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
                      List infoList = [
                        infoCards(context, unit?.unitSizeSqft, "Size"),
                        infoCards(context, unit?.bedroomCount, "Bedroom"),
                        infoCards(context, unit?.bathroomCount, "Bathroom"),
                        infoCards(context, unit?.parkings, "Parking"),
                      ];
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cardHeader(context, unit),
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
                                      // color: kWhite,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCards(BuildContext context, int? number, String? text) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: kGrey.shade200, blurRadius: 1, spreadRadius: 1)
        ],
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context
                    .read<AppThemeCubit>()
                    .state
                    .primaryColor
                    .withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Container(
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: kWhite),
                padding: const EdgeInsets.all(15),
                child: CustomText(
                  text: (number ?? 0).toString(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CustomText(
              text: text ?? " -- ",
              fontsize: 12,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget roundedContainer(BuildContext context, Widget child,
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
        color: invert
            ? kWhite
            : color ?? context.read<AppThemeCubit>().state.primaryColor,
        border: invert
            ? Border.all(
                color: context.read<AppThemeCubit>().state.primaryColor)
            : null,
      ),
      child: child,
    );
  }

  Widget cardHeader(BuildContext context, Unit? unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: context.read<AppThemeCubit>().state.primaryColor),
      child: CustomText(
        text: unit?.unitNumber ?? "",
        color: kWhite,
        fontWeight: FontWeight.bold,
        fontsize: 18,
      ),
    );
  }

  Widget contactsRow(BuildContext context, List contacts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: contacts
              .map(
                (e) => InkWell(
                  onTap: e["onTap"],
                  child: roundedContainer(
                    context,
                    Row(
                      children: [
                        Icon(
                          e["icon"] as IconData,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: e["name"] as String,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                          fontsize: 12,
                        )
                      ],
                    ),
                    invert: true,
                    margin: const EdgeInsets.only(right: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

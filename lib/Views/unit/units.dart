import 'package:iskaanowner/Widgets/units_list_page.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? communityName =
        (ModalRoute.of(context)?.settings.arguments as List).first as String?;
    int? communityId =
        (ModalRoute.of(context)?.settings.arguments as List).last as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: communityName ?? "",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: [const DashboardPage().notificationIcon(context)],
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
              child: UnitsListPage(
                communityName: communityName,
                communityId: communityId,
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

  Widget roundedContainer(
    BuildContext context,
    Widget child, {
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool invert = false,
    AlignmentGeometry? alignment,
    Color? color,
  }) {
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
                color:
                    color ?? context.read<AppThemeCubit>().state.primaryColor)
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

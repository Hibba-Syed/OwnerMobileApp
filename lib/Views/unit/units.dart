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
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardPage().appBar(
                context,
                widget: CustomText(
                  text: communityName ?? "",
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              CustomText(
                text: "My Units",
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
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
        fontSize: 18,
      ),
    );
  }

  Widget contactsRow(BuildContext context, List contacts) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: contacts
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(left: 5),
                child: InkWell(
                  onTap: e["onTap"],
                  child: roundedContainer(
                    context,
                    Row(
                      children: [
                        Icon(
                          e["icon"] as IconData,
                          color: (e["color"] as Color?) ??
                              context.read<AppThemeCubit>().state.primaryColor,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: e["name"] as String,
                          color: (e["color"] as Color?) ??
                              context.read<AppThemeCubit>().state.primaryColor,
                          fontSize: 12,
                        )
                      ],
                    ),
                    invert: true,
                    margin: const EdgeInsets.only(right: 5),
                    color: (e["color"] as Color?) ??
                        context.read<AppThemeCubit>().state.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

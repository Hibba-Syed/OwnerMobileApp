import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Views/side_drawer.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/profile.dart';
import '../Utils/utils.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: const Drawer(
        child: SideDrawerPage(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: appBar(
                    context,
                    image: "assets/menu.png",
                    text: "Dashboard",
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                );
              }),
              const Expanded(
                child: CommunitiesListPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesRow(
    BuildContext context,
    List<Widget> list,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 10 / 10),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return list[index].animate().fade(duration: 600.ms);
      },
    );
  }

  Widget iconButton(BuildContext context, String icon, String text,
      {void Function()? onTap,
      LoadingState loadingState = LoadingState.none,
      Color color = kWhite}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            loadingState == LoadingState.loading
                ? const CustomLoader(
                    applyCenter: false,
                  )
                : Image.asset(
                    icon,
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: context.read<AppThemeCubit>().state.primaryColor,
                  ),
            CustomText(
              text: text.split(" ").toList().map((e) => e).join("\n"),
              textAlign: TextAlign.center,
              fontSize: MediaQuery.of(context).size.width * 0.035,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    ProfileModel? profileModel =
        context.read<ProfileCubit>().state.profileModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.075,
              backgroundColor: kWhite,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.06,
                backgroundColor: kWhite,
                backgroundImage: NetworkImage(
                    profileModel?.record?.company?.faviconUrl ?? ""),
                onBackgroundImageError: (exception, stackTrace) =>
                    const AssetImage("assets/placeHolder.png"),
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "${profileModel?.record?.fullName?.capitalize()}",
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text:
                        "Welcome to ${profileModel?.record?.company?.name?.capitalize()},",
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            )
          ],
        ),
        const Gap(30),
        const DashboardPage().categoriesRow(context, [
          const DashboardPage().iconButton(
              context, "assets/unit_financials.png", "Unit's Financial",
              onTap: () {
            Navigator.pushNamed(context, AppRoutes.unitFinancial);
          }),
          BlocBuilder<DownloadSummaryCubit, DownloadSummaryState>(
            builder: (context, state) {
              return const DashboardPage().iconButton(
                  context, "assets/download_summary.png", "Download Summary",
                  onTap: () {
                context.read<DownloadSummaryCubit>().downloadDocument(context,
                    "$baseUrl/mobile/owner/profile/download-financial-summary",
                    customFileName: "financial-summary");
              }, loadingState: state.loadingState);
            },
          ),
          const DashboardPage().iconButton(
              context, "assets/shared_documents.png", "Shared Documents",
              onTap: () {
            context.read<SharedDocumentsCubit>().getSharedDocuments(context);
            Navigator.pushNamed(context, AppRoutes.sharedDocument);
          }),
        ]),
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: "Communities",
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.05,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  String? capitalizeFirstWord(String? input) {
    if (input == null) {
      return input;
    }
    if (input.isEmpty) {
      return input;
    } else {
      return input[0].toUpperCase() + input.substring(1).toLowerCase();
    }
  }

  Widget notificationIcon(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: () {
        context.read<NotificationsCubit>().getNotifications(context);
        Navigator.pushNamed(context, AppRoutes.notifications);
      },
      icon: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Badge(
            backgroundColor: context.read<AppThemeCubit>().state.primaryColor,
            isLabelVisible: (state.loginModel?.unreadNotifications ?? 0) == 0
                ? false
                : true,
            label: CustomText(
              text: (state.loginModel?.unreadNotifications ?? 0).toString(),
              color: kWhite,
              fontSize: 10,
            ),
            child: Image.asset(
              "assets/read_bell.png",
              scale: 4,
              color: const Color(0xff575757),
            ),
          );
        },
      ),
    );
  }

  Widget appBar(BuildContext context,
      {String image = "assets/back.png",
      void Function()? onTap,
      bool enableLeading = true,
      bool enableTrailing = true,
      String? text,
      Widget? trailingIcon}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onTap ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Image.asset(
                image,
                color: enableLeading ? const Color(0xff575757) : kTransparent,
                scale: 4,
              ),
            ),
            if (text != null)
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  text: text,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              )),
            trailingIcon ??
                (enableTrailing
                    ? notificationIcon(context)
                    : IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.safety_check,
                          color: kTransparent,
                        )))
          ],
        ),
        const Divider(
          thickness: 0.5,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

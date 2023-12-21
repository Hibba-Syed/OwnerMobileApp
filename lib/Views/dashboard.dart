import 'package:iskaanowner/Views/side_drawer.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: capitalizeFirstWord(context
                .read<ProfileCubit>()
                .state
                .profileModel
                ?.record
                ?.company
                ?.shortName) ??
            "",
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ));
        }),
        automaticallyImplyLeading: true,
        appBar: AppBar(),
        widgets: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
          )
        ],
        appBarHeight: 50,
      ),
      drawer: const Drawer(
        child: SideDrawerPage(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text:
                  "${setGreeting()} ${context.read<ProfileCubit>().state.profileModel?.record?.fullName ?? ""}!",
              fontWeight: FontWeight.bold,
              fontsize: 20,
              color: kBlack,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: "Utilities",
              color: context.read<AppThemeCubit>().state.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            categoriesRow(context),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: "My Properties",
              color: context.read<AppThemeCubit>().state.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<CommunitiesCubit, CommunitiesState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  return comunitiesUi(state.communitiesModel?.associations);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoriesRow(BuildContext context) {
    List categories = [
      iconButton(context, Icons.balance_outlined, "Units Financial", onTap: () {
        Navigator.pushNamed(context, AppRoutes.unitFinancial);
      }),
      BlocBuilder<DownloadSummaryCubit, DownloadSummaryState>(
        builder: (context, state) {
          return iconButton(context, Icons.download, "Download Summary",
              onTap: () {
            context.read<DownloadSummaryCubit>().downloadDocument(context,
                "$baseUrl/mobile/owner/profile/download-financial-summary");
          }, loadingState: state.loadingState);
        },
      ),
      iconButton(context, Icons.document_scanner_outlined, "Shared Documents",
          onTap: () {
        context.read<SharedDocumentsCubit>().getSharedDocuments(context);
        Navigator.pushNamed(context, AppRoutes.sharedDocument);
      }),
    ];
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 10 / 13),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return categories[index];
      },
    );
  }

  Widget iconButton(BuildContext context, IconData icon, String text,
      {void Function()? onTap, LoadingState loadingState = LoadingState.none}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
          boxShadow: [
            BoxShadow(spreadRadius: 2, blurRadius: 2, color: kGrey.shade200)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: context
                        .read<AppThemeCubit>()
                        .state
                        .primaryColor
                        .withOpacity(0.2)),
                child: loadingState == LoadingState.loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ))
                    : Icon(
                        icon,
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        size: 35,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomText(
                text: text.split(" ").toList().map((e) => e).join("\n"),
                color: kBlack,
                fontWeight: FontWeight.bold,
                fontsize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget comunitiesUi(List<Association>? data) {
    return ListView.builder(
      itemCount: data?.length,
      itemBuilder: (BuildContext context, int index) {
        Association? communitiesDatum = data?[index];
        return InkWell(
          onTap: () {
            context.read<UnitsCubit>().getUnits(context, communitiesDatum?.id);
            Navigator.pushNamed(context, AppRoutes.units,
                arguments: communitiesDatum?.name);
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
                        child:
                            CustomText(text: communitiesDatum?.name ?? " -- "),
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
                                  text: (communitiesDatum?.unitCount ?? 0)
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
                              children: (communitiesDatum?.units as List)
                                  .map(
                                    (e) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 70,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
    );
  }

  String setGreeting() {
    String greeting = "Good Morning,";
    final now = DateTime.now();
    final currentTime = now.hour;

    if (currentTime >= 5 && currentTime < 12) {
      greeting = 'Good Morning,';
    } else if (currentTime >= 12 && currentTime < 17) {
      greeting = 'Good Afternoon,';
    } else if (currentTime >= 17 && currentTime < 20) {
      greeting = 'Good Evening,';
    } else {
      greeting = 'Good Night,';
    }
    return greeting;
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
}

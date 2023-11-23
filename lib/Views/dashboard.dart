import 'package:iskaanowner/Views/side_drawer.dart';

import '../Utils/utils.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Dashboard",
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: primaryColor,
              ));
        }),
        automaticallyImplyLeading: true,
        appBar: AppBar(),
        widgets: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: primaryColor,
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
                  "${setGreeting()} ${context.read<ProfileCubit>().state.profileModel?.record?.firstName ?? ""}!",
              fontWeight: FontWeight.bold,
              fontsize: 25,
              color: kBlack,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: "My Properties (Sort by Communities)",
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            categoriesRow(context),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          iconButton(Icons.ac_unit, "Units Financial", onTap: () {
            // context.read<UnitFinancialsCubit>().getUnitFinancials(context);
            Navigator.pushNamed(context, AppRoutes.unitFinancial);
          }),
          BlocBuilder<DownloadSummaryCubit, DownloadSummaryState>(
            builder: (context, state) {
              return iconButton(Icons.download, "Download Summary", onTap: () {
                context.read<DownloadSummaryCubit>().downloadDocument(context,
                    "$baseUrl/mobile/owner/profile/download-financial-summary");
              }, loadingState: state.loadingState);
            },
          ),
          iconButton(Icons.share, "Shared Documents", onTap: () {
            context.read<SharedDocumentsCubit>().getSharedDocuments(context);
            Navigator.pushNamed(context, AppRoutes.sharedDocument);
          }),
        ],
      ),
    );
  }

  Widget iconButton(IconData icon, String text,
      {void Function()? onTap, LoadingState loadingState = LoadingState.none}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryColor),
        child: Row(
          children: [
            loadingState == LoadingState.loading
                ? const SizedBox(
                    height: 12,
                    width: 12,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: kWhite,
                    )))
                : Icon(
                    icon,
                    color: kWhite,
                    size: 15,
                  ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              text: text,
              color: kWhite,
              fontsize: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget comunitiesUi(List<CommunitiesDatum>? data) {
    return ListView.builder(
      itemCount: data?.length,
      itemBuilder: (BuildContext context, int index) {
        CommunitiesDatum? communitiesDatum = data?[index];
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
                    "$baseUrl/${communitiesDatum?.backgroundImage ?? ""}",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const UnitsPage().roundedContainer(
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
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kGrey.shade200),
                        child: CustomText(
                            text: communitiesDatum?.name ?? "Not provided"),
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
                              border: Border.all(color: primaryColor),
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
                                          color: primaryColor),
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
}

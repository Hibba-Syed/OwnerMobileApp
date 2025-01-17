import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Blocs/App Theme/app_theme_cubit.dart';
import '../../../Models/Requests/tp.dart';
import '../../../Utils/utils.dart';

class TpDetailsPage extends StatelessWidget {
  const TpDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? requestId =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as int?;
    String? reference =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String?;
    String? type =
        (ModalRoute.of(context)?.settings.arguments as List)[2] as String?;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: const DashboardPage().appBar(context,
                    text: const AdDetailsPage().getRequestName(type)),
              ),
              Expanded(
                child: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
                  builder: (context, state) {
                    if (state.loadingState == LoadingState.loading) {
                      return const CustomLoader();
                    }
                    if (state.tpDetailsModel?.record == null) {
                      return const CreditNotesPage().emptyList(ontap: () {
                        context
                            .read<RequestDetailsCubit>()
                            .getRequestDetails(context, requestId, type);
                      });
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        StatefulBuilder(builder: (context, changeState) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kWhite),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      changeState(() {
                                        DefaultTabController.of(context)
                                            .animateTo(0);
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: 400.ms,
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(
                                                DefaultTabController.of(context)
                                                            .index ==
                                                        0
                                                    ? 0.8
                                                    : 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CustomText(
                                        text: "Details",
                                        color: DefaultTabController.of(context)
                                                    .index ==
                                                0
                                            ? kWhite
                                            : context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                        maxLines: 1,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      changeState(() {
                                        DefaultTabController.of(context)
                                            .animateTo(1);
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: 400.ms,
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(
                                                DefaultTabController.of(context)
                                                            .index ==
                                                        1
                                                    ? 0.8
                                                    : 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CustomText(
                                        text: "Seller(s)",
                                        color: DefaultTabController.of(context)
                                                    .index ==
                                                1
                                            ? kWhite
                                            : context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                        maxLines: 1,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      changeState(() {
                                        DefaultTabController.of(context)
                                            .animateTo(2);
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: 400.ms,
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(
                                                DefaultTabController.of(context)
                                                            .index ==
                                                        2
                                                    ? 0.8
                                                    : 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CustomText(
                                        text: "Buyer(s)",
                                        color: DefaultTabController.of(context)
                                                    .index ==
                                                2
                                            ? kWhite
                                            : context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                        maxLines: 1,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              header(context, state, reference),
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 20),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.tpDetailsModel?.record
                                    ?.application?.sellers?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Seller? seller = state.tpDetailsModel?.record
                                      ?.application?.sellers?[index];
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kWhite,
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ListTileTheme(
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        horizontalTitleGap: 0.0,
                                        minLeadingWidth: 0,
                                        child: ExpansionTile(
                                          title: const AdDetailsPage()
                                              .headingText(context,
                                                  "Seller ${index + 1} Details"),
                                          children: [
                                            Column(
                                              children: [
                                                {
                                                  "icon": Icon(
                                                    Icons.person,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Seller Type",
                                                  "value": state
                                                      .tpDetailsModel
                                                      ?.record
                                                      ?.application
                                                      ?.sellerRequesterType,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons.person,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Seller Name",
                                                  "value": seller?.sellerName,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons.numbers_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Resident Number",
                                                  "value": seller
                                                      ?.sellerResidenceNumber,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons.numbers_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Cellular Number",
                                                  "value": seller
                                                      ?.sellerCellularNumber,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons.numbers_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Office Number",
                                                  "value": seller
                                                      ?.sellerOfficeNumber,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons.numbers_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Passport Number",
                                                  "value": seller
                                                      ?.sellerPassportNumber,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Passport Expiry",
                                                  "value": const OccupantPage()
                                                      .dateTimeFormatter(seller
                                                          ?.sellerPassportExpiry),
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons.email_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Email",
                                                  "value": seller?.sellerEmail,
                                                },
                                                {
                                                  "icon": Icon(
                                                    Icons
                                                        .location_city_outlined,
                                                    color: context
                                                        .read<AppThemeCubit>()
                                                        .state
                                                        .primaryColor,
                                                  ),
                                                  "key": "Citizenship",
                                                  "value":
                                                      seller?.country?.name,
                                                },
                                              ]
                                                  .map((Map<String, dynamic>
                                                          e) =>
                                                      const ProfilePage()
                                                          .profileInfoTile(
                                                              context,
                                                              e["key"],
                                                              e["value"]))
                                                  .toList(),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 20),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.tpDetailsModel?.record
                                    ?.application?.buyers?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Buyer? buyer = state.tpDetailsModel?.record
                                      ?.application?.buyers?[index];
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kWhite,
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ListTileTheme(
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        horizontalTitleGap: 0.0,
                                        minLeadingWidth: 0,
                                        child: ExpansionTile(
                                          title: const AdDetailsPage()
                                              .headingText(context,
                                                  "Buyer ${index + 1} Details"),
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: kWhite,
                                              ),
                                              child: Column(
                                                children: [
                                                  {
                                                    "icon": Icon(
                                                      Icons.person,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Buyer Type",
                                                    "value": state
                                                        .tpDetailsModel
                                                        ?.record
                                                        ?.application
                                                        ?.buyerRequesterType,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons.person,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Buyer Name",
                                                    "value": buyer?.buyerName,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons.numbers_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Resident Number",
                                                    "value": buyer
                                                        ?.buyerResidenceNumber,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons.numbers_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Cellular Number",
                                                    "value": buyer
                                                        ?.buyerCellularNumber,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons.numbers_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Office Number",
                                                    "value": buyer
                                                        ?.buyerOfficeNumber,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons.numbers_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Passport Number",
                                                    "value": buyer
                                                        ?.buyerPassportNumber,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Passport Expiry",
                                                    "value": const OccupantPage()
                                                        .dateTimeFormatter(buyer
                                                            ?.buyerPassportExpiry),
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons.email_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Email",
                                                    "value": buyer?.buyerEmail,
                                                  },
                                                  {
                                                    "icon": Icon(
                                                      Icons
                                                          .location_city_outlined,
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor,
                                                    ),
                                                    "key": "Citizenship",
                                                    "value":
                                                        buyer?.country?.name,
                                                  },
                                                ]
                                                    .map((Map<String, dynamic>
                                                            e) =>
                                                        const ProfilePage()
                                                            .profileInfoTile(
                                                                context,
                                                                e["key"],
                                                                e["value"]))
                                                    .toList(),
                                              ),
                                            ),
                                         
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ].animate(interval: 50.ms).fade(),
                          ),
                        )
                      ]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(
      BuildContext context, RequestDetailsState state, String? reference) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          const AdDetailsPage().header(
            context,
            state.tpDetailsModel?.record?.unit?.unitNumber ?? " -- ",
            state.tpDetailsModel?.record?.association?.name ?? " -- ",
            state.tpDetailsModel?.record?.createdAt,
            state.tpDetailsModel?.record?.status,
            [
              {
                "icon": Icons.link,
                "title": "Reference",
                "subTitle": reference ?? " -- ",
              },
              {
                "title": "Noc Fee",
                "subTitle":
                    (state.tpDetailsModel?.record?.application?.transferFee ??
                            " -- ")
                        .toString(),
              },
              {
                "title": "Noc Fee status",
                "subTitle": state.tpDetailsModel?.record?.application
                        ?.transferFeeStatus ??
                    " -- ",
              },
              {
                "title": " Security Deposit",
                "subTitle": (state.tpDetailsModel?.record?.application
                            ?.transferSecurityDeposit ??
                        " -- ")
                    .toString(),
              },
              {
                "title": " Security Deposit status",
                "subTitle": state.tpDetailsModel?.record?.application
                        ?.transferSecurityStatus ??
                    " -- ",
              },
            ],
          ),
       
          const Gap(20),
        ],
      ),
    );
  }
}

import 'package:flutter_animate/flutter_animate.dart';

import '../../../Blocs/App Theme/app_theme_cubit.dart';
import '../../../Utils/utils.dart';

class AdDetailsPage extends StatelessWidget {
  const AdDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? requestId =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as int?;
    String? reference =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String?;
    String? type =
        (ModalRoute.of(context)?.settings.arguments as List)[2] as String?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage()
                  .appBar(context, text: getRequestName(type)),
            ),
            Expanded(
              child: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.adDetailsModel?.record == null) {
                    return const CreditNotesPage().emptyList(ontap: () {
                      context
                          .read<RequestDetailsCubit>()
                          .getRequestDetails(context, requestId, type);
                    });
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          header(
                              context,
                              state.adDetailsModel?.record?.unit?.unitNumber ??
                                  " -- ",
                              state.adDetailsModel?.record?.association?.name ??
                                  " -- ",
                              state.adDetailsModel?.record?.createdAt,
                              state.adDetailsModel?.record?.status,
                              [
                                {
                                  "icon": Icons.link,
                                  "title": "Reference",
                                  "subTitle": reference ?? " -- ",
                                },
                                {
                                  "icon": Icons.email_outlined,
                                  "title": "Requester Type",
                                  "subTitle": state
                                          .adDetailsModel?.record?.clientType ??
                                      " -- ",
                                },
                                {
                                  "icon": Icons.money_outlined,
                                  "title": "Payable Amount",
                                  "subTitle": state.adDetailsModel?.record
                                          ?.payableAmount ??
                                      " -- ",
                                },
                                {
                                  "icon": Icons.monetization_on_outlined,
                                  "title": "Payment status",
                                  "subTitle": state.adDetailsModel?.record
                                          ?.paymentStatus ??
                                      " -- ",
                                },
                              ]),
                          applicationDetails(
                            context,
                            state.adDetailsModel?.record?.clientName,
                            state.adDetailsModel?.record?.clientPhone,
                          ),
                          customTableView(
                              context,
                              ["Device", "No of devices", "Cost"],
                              state.adDetailsModel?.record?.application
                                      ?.deviceInfo
                                      ?.map((e) => [
                                            e.deviceType ?? " -- ",
                                            (e.deviceCount ?? 0).toString(),
                                            formatCurrency(e.cost ?? 0)
                                          ])
                                      .toList() ??
                                  [],
                              title: "Device"),
                        ].animate(interval: 50.ms).fade(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context, String? unitNo, String? communityName,
      DateTime? createdAt, String? status, List<Map> data) {
    return Column(
      children: [
        CustomText(
          text: "Unit#: ${unitNo ?? ' -- '}",
          fontWeight: FontWeight.bold,
        ),
        const Gap(10),
        CustomText(
          text: communityName ?? " -- ",
          fontWeight: FontWeight.bold,
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhite,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ListTileTheme(
              contentPadding: EdgeInsets.zero,
              dense: true,
              horizontalTitleGap: 0.0,
              minLeadingWidth: 0,
              child: ExpansionTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text:
                              const OccupantPage().dateTimeFormatter(createdAt),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            CustomText(
                              text: "●",
                              color:
                                  const RequestsPage().getStatusColor(status),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const UnitsPage().roundedContainer(
                                context,
                                CustomText(
                                  text: status ?? " -- ",
                                  color: const RequestsPage()
                                      .getStatusColor(status),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                                color: const RequestsPage()
                                    .getStatusColor(status)
                                    .withOpacity(0.1),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                children: data
                    .map((e) => const ProfilePage().profileInfoTile(
                          context,
                          e["title"] as String,
                          e["subTitle"].toString(),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget headingText(BuildContext context, String text) {
    return Column(
      children: [
        const Gap(10),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: text,
            color: context.read<AppThemeCubit>().state.primaryColor,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        const Gap(10),
      ],
    );
  }

  Widget applicationDetails(
    BuildContext context,
    String? name,
    String? phone, {
    Widget? customWidget,
    bool enableHeader = true,
  }) {
    return Column(
      children: [
        const Gap(5),
        if (enableHeader) headingText(context, "Applicant Details"),
        const Gap(5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhite,
          ),
          child: Column(
            children: [
              const OccupantPage().emergencyContactCard(
                context,
                name ?? "",
                phoneNumber: phone,
              ),
              if (customWidget != null) customWidget
            ],
          ),
        ),
      ],
    );
  }

  Widget supportingDocuments(
    BuildContext context,
    List<Map> data, {
    EdgeInsetsGeometry? padding = const EdgeInsets.all(10),
    String? headerText,
  }) {
    return Column(
      children: [
        const Gap(5),
        headingText(context, headerText ?? "Supporting Documents"),
        const Gap(5),
        Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhite,
          ),
          child: ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return const Column(
                children: [
                  Divider(
                    thickness: 0.5,
                  ),
                  Gap(5),
                ],
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return const OwnersPage().documentInfo(
                  context, data[index]["name"],
                  url: data[index]["url"]);
            },
          ),
        )
      ],
    );
  }

  Widget customTableView(
      BuildContext context, List<String> columnName, List<List<String>>? data,
      {String? title}) {
    if (data?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        const Gap(5),
        if (title != null) headingText(context, title),
        const Gap(5),
        ListView.separated(
          itemCount: data?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 2,
              endIndent: 50,
              indent: 50,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhite,
              ),
              child: Column(
                children: List.generate(
                  columnName.length,
                  (i) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: columnName[i],
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      Flexible(
                        child: CustomText(
                          text: (data?[index][i] ?? " -- ").toString(),
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String getRequestName(String? type) {
    String name = "";
    if (type?.toLowerCase() == "ad") {
      name = "Access Device";
    }
    if (type?.toLowerCase() == "cs") {
      name = "Concierge Service";
    }
    if (type?.toLowerCase() == "hb") {
      name = "Facility Booking";
    }
    if (type?.toLowerCase() == "fo") {
      name = "Fit Out";
    }
    if (type?.toLowerCase() == "mi") {
      name = "Move In";
    }
    if (type?.toLowerCase() == "mo") {
      name = "Move Out";
    }
    if (type?.toLowerCase() == "ri") {
      name = "Resident Information";
    }
    if (type?.toLowerCase() == "tp") {
      name = "Transfer of Property";
    }
    if (type?.toLowerCase() == "wp") {
      name = "Work Permit";
    }
    if (type?.toLowerCase() == "dp") {
      name = "Delivery Permit";
    }
    if (type?.toLowerCase() == "ss") {
      name = "Short Stay";
    }
    return name;
  }
}

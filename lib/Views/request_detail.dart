import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // int? requestId =
    //     (ModalRoute.of(context)?.settings.arguments as List)[0] as int?;
    String? reference =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String?;
    String? type =
        (ModalRoute.of(context)?.settings.arguments as List)[2] as String?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "${getRequestName(type)}\n$reference",
        fontSize: 14,
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const CustomText(
                    text: "Unit#: 1009",
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    text: "IT Plaza",
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: kGrey.shade200),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: const OccupantPage().dateTimeFormatter(
                                  state.requestDetailsModel?.record?.createdAt),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const CustomText(
                                  text: "●",
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const UnitsPage().roundedContainer(
                                    context,
                                    CustomText(
                                      text: state.requestDetailsModel?.record
                                              ?.status ??
                                          " -- ",
                                      color: Colors.green,
                                    ),
                                    color: Colors.green.withOpacity(0.1),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10))
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        Column(
                          children: getRequestList(context, type, state)
                              .map((e) => const ProfilePage().profileInfoTile(
                                    context,
                                    e["title"] as String,
                                    e["subTitle"].toString(),
                                    e["icon"] as IconData,
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  if (type?.toLowerCase() == "ad") vehiclesView(context, state),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Application Details",
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: kGrey.shade200),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const UnitsPage().roundedContainer(
                                  context,
                                  Icon(
                                    Icons.person_outline,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor,
                                  ),
                                  invert: true,
                                  padding: const EdgeInsets.all(20)),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: const UnitsPage().roundedContainer(
                                    context,
                                    CustomText(
                                        text: state.requestDetailsModel?.record
                                                ?.clientName ??
                                            " -- "),
                                    padding: const EdgeInsets.all(20),
                                    color: kGrey.shade200),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.phone_outlined),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CustomText(text: "Phone :"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const UnitsPage().roundedContainer(
                                    context,
                                    CustomText(
                                      text: state.requestDetailsModel?.record
                                              ?.clientPhone ??
                                          " --",
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    invert: true,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CustomText(text: "Email :"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const UnitsPage().roundedContainer(
                                    context,
                                    CustomText(
                                      text: state.requestDetailsModel?.record
                                              ?.clientEmail ??
                                          " -- ",
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    invert: true,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Supporting Documents",
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: kGrey.shade200),
                      ],
                    ),
                    child: Column(
                      children: [
                        const OwnersPage().documentInfo(context, "Title Deed",
                            url:
                                "$baseUrl/${state.requestDetailsModel?.record?.titleDeed}"),
                        const OwnersPage().documentInfo(context, "ID File",
                            url:
                                "$baseUrl/${state.requestDetailsModel?.record?.clientIdFile}"),
                        const OwnersPage().documentInfo(
                            context, "Passport File",
                            url:
                                "$baseUrl/${state.requestDetailsModel?.record?.passportFile}"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget vehiclesView(BuildContext context, RequestDetailsState state) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhite,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  color: kGrey.shade200),
            ],
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                      child: CustomText(
                    text: "Device",
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                      child: CustomText(
                    text: "No. of Devices",
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                      child: CustomText(
                    text: "Cost",
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
              Divider(
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              ListView.separated(
                itemCount: 2,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return const Row(
                    children: [
                      Expanded(child: CustomText(text: "parking")),
                      Expanded(child: CustomText(text: "2")),
                      Expanded(child: CustomText(text: "200 AED")),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  List getRequestList(
      BuildContext context, String? type, RequestDetailsState state) {
    List requestList = [
      {
        "icon": Icons.email_outlined,
        "title": "Requester Type",
        "subTitle": state.requestDetailsModel?.record?.clientType ?? " -- ",
      },
    ];

    if (type?.toLowerCase() == "ad") {
      requestList.addAll([
        {
          "icon": Icons.money_outlined,
          "title": "Payable Amount",
          "subTitle": state.requestDetailsModel?.record?.payableAmount,
        },
        {
          "icon": Icons.monetization_on_outlined,
          "title": "Payment status",
          "subTitle": state.requestDetailsModel?.record?.status,
        },
      ]);
    }
    if (type?.toLowerCase() == "cs") {
      requestList.addAll([
        {
          "icon": Icons.money_outlined,
          "title": "Service",
          "subTitle": " -- ",
        },
        {
          "icon": Icons.date_range,
          "title": "Date",
          "subTitle": "23 May 2023",
          "widget": const ProfilePage()
              .profileInfoTile(context, "Time", "11:00", Icons.timer_outlined)
        },
        {
          "icon": Icons.notes_outlined,
          "title": "Description",
          "subTitle": state.requestDetailsModel?.record?.description ?? " -- ",
        },
      ]);
    }
    if (type?.toLowerCase() == "hb") {
      requestList.addAll([
        {
          "icon": Icons.build_circle_outlined,
          "title": "Facility",
          "subTitle": "Hall",
        },
        {
          "icon": Icons.door_back_door_outlined,
          "title": "Nature of Function",
          "subTitle": "Birthday Party",
        },
        {
          "icon": Icons.group_outlined,
          "title": "Expected Guests",
          "subTitle": "20",
        },
        {
          "icon": Icons.book_online,
          "title": "Booking Date",
          "subTitle": "23 May 2023",
        },
        {
          "icon": Icons.timer_outlined,
          "title": "Start Time",
          "subTitle": "02:33",
          "widget": const ProfilePage().profileInfoTile(
              context, "End Time", "06:00", Icons.timer_outlined)
        },
        {
          "icon": Icons.attach_money_outlined,
          "title": "Payable Amount",
          "subTitle": "1000",
        },
        {
          "icon": Icons.attach_money_outlined,
          "title": "Security Deposit",
          "subTitle": "50",
        },
      ]);
    }
    if (type?.toLowerCase() == "fo") {
      requestList.addAll([
        {
          "icon": Icons.person_outlined,
          "title": "Contractor Name",
          "subTitle": state.requestDetailsModel?.record?.clientName,
        },
        {
          "icon": Icons.phone_android_outlined,
          "title": "Contractor Contact Person",
          "subTitle": state.requestDetailsModel?.record?.clientName,
        },
        {
          "icon": Icons.group_outlined,
          "title": "No. of Staff Expected",
          "subTitle": state.requestDetailsModel?.record?.clientName,
        },
        {
          "icon": Icons.calendar_month_outlined,
          "title": "Start date",
          "subTitle": "23 May 2023",
          "widget": const ProfilePage().profileInfoTile(context, "End Date",
              "23 May 20223", Icons.calendar_month_outlined)
        },
        {
          "icon": Icons.fast_forward_outlined,
          "title": "Temporary Electricity Required?",
          "subTitle": "No",
        },
        {
          "icon": Icons.indeterminate_check_box_outlined,
          "title": "NOC (fit out) Fee",
          "subTitle": " -- ",
        },
        {
          "icon": Icons.security,
          "title": "Security Deposit",
          "subTitle":
              "${state.requestDetailsModel?.record?.securityDeposit ?? " -- "}",
          "widget": const ProfilePage().profileInfoTile(
              context, "Status", "pending", Icons.done_all_outlined),
        },
        {
          "icon": Icons.check_box_outline_blank_outlined,
          "title": "Total Payable Fee",
          "subTitle":
              state.requestDetailsModel?.record?.payableAmount ?? " -- ",
          "widget": const ProfilePage().profileInfoTile(
              context, "Status", "pending", Icons.done_all_outlined),
        },
        {
          "icon": Icons.notes_outlined,
          "title": "Description",
          "subTitle": state.requestDetailsModel?.record?.description ?? " -- ",
        },
      ]);
    }
    if (type?.toLowerCase() == "mi") {
      requestList.addAll([
        {
          "icon": Icons.calendar_month_outlined,
          "title": "Requested Date",
          "subTitle": " -- ",
          "widget": const ProfilePage().profileInfoTile(
              context, "Requested Time", "6-7", Icons.timer_outlined)
        },
        {
          "icon": Icons.calendar_month_outlined,
          "title": "Resident Information Reference",
          "subTitle": "RI20230116109441",
        },
        {
          "icon": Icons.done_all_outlined,
          "title": "Resident Information Status",
          "subTitle": "Completed",
        },
        {
          "icon": Icons.attach_money_outlined,
          "title": "Security Deposit",
          "subTitle": "0",
        },
        {
          "icon": Icons.attach_money_outlined,
          "title": "Refund Amount",
          "subTitle": "0.00",
        },
      ]);
    }
    if (type?.toLowerCase() == "mo") {
      requestList.addAll([
        {
          "icon": Icons.calendar_month_outlined,
          "title": "Requested Date",
          "subTitle": " -- ",
          "widget": const ProfilePage().profileInfoTile(
              context, "Requested Time", "6-7", Icons.timer_outlined)
        },
        {
          "icon": Icons.attach_money_outlined,
          "title": "Security Deposit",
          "subTitle": "0",
        },
        {
          "icon": Icons.attach_money_outlined,
          "title": "Refund Amount",
          "subTitle": "0.00",
        },
      ]);
    }
    if (type?.toLowerCase() == "wp") {
      requestList.addAll([
        {
          "icon": Icons.person_outlined,
          "title": "Contractor Name",
          "subTitle": state.requestDetailsModel?.record?.clientName,
        },
        {
          "icon": Icons.phone_android_outlined,
          "title": "Contractor Contact Person",
          "subTitle": state.requestDetailsModel?.record?.clientName,
        },
        {
          "icon": Icons.group_outlined,
          "title": "No. of Staff Expected",
          "subTitle": state.requestDetailsModel?.record?.clientName,
        },
        {
          "icon": Icons.calendar_month_outlined,
          "title": "Start date",
          "subTitle": "23 May 2023",
          "widget": const ProfilePage().profileInfoTile(context, "End Date",
              "23 May 20223", Icons.calendar_month_outlined)
        },
        {
          "icon": Icons.security,
          "title": "Security Deposit",
          "subTitle":
              "${state.requestDetailsModel?.record?.securityDeposit ?? " -- "}",
          "widget": const ProfilePage().profileInfoTile(
              context, "Status", "pending", Icons.done_all_outlined),
        },
        {
          "icon": Icons.check_box_outline_blank_outlined,
          "title": "Payable Amount",
          "subTitle":
              state.requestDetailsModel?.record?.payableAmount ?? " -- ",
          "widget": const ProfilePage().profileInfoTile(
              context, "Status", "pending", Icons.done_all_outlined),
        },
        {
          "icon": Icons.money_outlined,
          "title": "Cheque details",
          "subTitle":
              state.requestDetailsModel?.record?.serviceChargeStatus ?? " -- ",
        },
        {
          "icon": Icons.notes_outlined,
          "title": "Description",
          "subTitle": state.requestDetailsModel?.record?.description ?? " -- ",
        },
      ]);
    }
    if (type?.toLowerCase() == "dp") {
      requestList.addAll([
        {
          "icon": Icons.calendar_today_outlined,
          "title": " Requester Date",
          "subTitle": state.requestDetailsModel?.record?.createdAt,
        },
        {
          "icon": Icons.money_outlined,
          "title": "Delivery Company",
          "subTitle": " -- ",
        },
        {
          "icon": Icons.notes_outlined,
          "title": "Description",
          "subTitle": state.requestDetailsModel?.record?.description ?? " -- ",
        },
      ]);
    }
    if (type?.toLowerCase() == "ss") {
      requestList.addAll([
        {
          "icon": Icons.group_outlined,
          "title": "No. of people",
          "subTitle": "1",
        },
        {
          "icon": Icons.calendar_month_outlined,
          "title": "Date",
          "subTitle": "23 May 2023",
          "widget": const ProfilePage().profileInfoTile(
              context, "End Date", "23 may 2023", Icons.calendar_month_outlined)
        },
        {
          "icon": Icons.notes_outlined,
          "title": "Description",
          "subTitle": state.requestDetailsModel?.record?.description ?? " -- ",
        },
      ]);
    }
    return requestList;
  }

  String getRequestName(String? type) {
    String name = "";
    if (type?.toLowerCase() == "ad") {
      name = "Access Device";
    }
    if (type?.toLowerCase() == "cs") {
      name = "Concierge Service";
    }
    if (type?.toLowerCase() == "fb") {
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

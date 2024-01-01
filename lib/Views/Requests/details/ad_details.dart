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
      appBar: BaseAppBar(
        title: "${getRequestName(type)}\n${reference ?? ""}",
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
          if (state.adDetailsModel?.record == null) {
            return const CreditNotesPage().emptyList(ontap: () {
              context.read<RequestDetailsCubit>().getRequestDetails(
                  context, requestId, type);
            });
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  header(
                      context,
                      state.adDetailsModel?.record?.unit?.unitNumber ?? " -- ",
                      state.adDetailsModel?.record?.association?.name ?? " -- ",
                      state.adDetailsModel?.record?.createdAt,
                      state.adDetailsModel?.record?.status, [
                    {
                      "icon": Icons.email_outlined,
                      "title": "Requester Type",
                      "subTitle":
                          state.adDetailsModel?.record?.clientType ?? " -- ",
                    },
                    {
                      "icon": Icons.money_outlined,
                      "title": "Payable Amount",
                      "subTitle":
                          state.adDetailsModel?.record?.payableAmount ?? " -- ",
                    },
                    {
                      "icon": Icons.monetization_on_outlined,
                      "title": "Payment status",
                      "subTitle":
                          state.adDetailsModel?.record?.paymentStatus ?? " -- ",
                    },
                  ]),
                  applicationDetails(
                      context,
                      state.adDetailsModel?.record?.clientName,
                      state.adDetailsModel?.record?.clientPhone,
                      state.adDetailsModel?.record?.clientEmail),
                  customTableView(
                      context,
                      ["Device", "No of devices", "Cost"],
                      state.adDetailsModel?.record?.application?.deviceInfo
                              ?.map((e) => [
                                    e.deviceType ?? " -- ",
                                    (e.deviceCount ?? 0).toString(),
                                    formatCurrency(e.cost ?? 0)
                                  ])
                              .toList() ??
                          []),
                  supportingDocuments(context, [
                    {
                      "name": "Title Deed",
                      "url": state.adDetailsModel?.record?.titleDeedUrl,
                    },
                    {
                      "name": "ID File",
                      "url": state.adDetailsModel?.record?.clientIdFileUrl,
                    },
                    {
                      "name": "Passport File",
                      "url": state.adDetailsModel?.record?.passportFileUrl,
                    },
                  ])
                ],
              ),
            ),
          );
        },
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
                    text: const OccupantPage().dateTimeFormatter(createdAt),
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
                            text: status ?? " -- ",
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
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              Column(
                children: data
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
      ],
    );
  }

  Widget headingText(String text) {
    return Column(
      children: [
        const Gap(10),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: text,
            fontWeight: FontWeight.bold,
            fontsize: 20,
          ),
        ),
        const Gap(10),
      ],
    );
  }

  Widget applicationDetails(
      BuildContext context, String? name, String? phone, String? email,
      {Widget? customWidget}) {
    return Column(
      children: [
        headingText("Application Details"),
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
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        invert: true,
                        padding: const EdgeInsets.all(20)),
                    const Gap(10),
                    Expanded(
                      child: const UnitsPage().roundedContainer(
                          context, CustomText(text: name ?? " -- "),
                          padding: const EdgeInsets.all(20),
                          color: kGrey.shade200),
                    ),
                  ],
                ),
              ),
              Divider(
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.phone_outlined),
                        Gap(10),
                        CustomText(text: "Phone :"),
                      ],
                    ),
                    const Gap(10),
                    const UnitsPage().roundedContainer(
                      context,
                      CustomText(
                        text: phone ?? " --",
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      invert: true,
                    ),
                    const Gap(10),
                    const Row(
                      children: [
                        Icon(Icons.email_outlined),
                        Gap(10),
                        CustomText(text: "Email :"),
                      ],
                    ),
                    const Gap(10),
                    const UnitsPage().roundedContainer(
                      context,
                      CustomText(
                        text: email ?? " -- ",
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        maxLines: 1,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      invert: true,
                    ),
                  ],
                ),
              ),
              if (customWidget != null) customWidget
            ],
          ),
        ),
      ],
    );
  }

  Widget supportingDocuments(BuildContext context, List<Map> data) {
    return Column(
      children: [
        headingText("Supporting Documents"),
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
            children: data
                .map(
                  (e) => const OwnersPage()
                      .documentInfo(context, e["name"], url: e["url"]),
                )
                .toList(),
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
        if (title != null) headingText(title),
        if (title == null) const Gap(10),
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
                  children: columnName
                      .map(
                        (e) => Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CustomText(
                            text: e,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                          ),
                        )),
                      )
                      .toList()),
              Divider(
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              ListView.separated(
                itemCount: data?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  List<String>? info = data?[index];
                  return Row(
                    children: info
                            ?.map((e) => Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: CustomText(
                                    text: e,
                                    textAlign: TextAlign.left,
                                  ),
                                )))
                            .toList() ??
                        [],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
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

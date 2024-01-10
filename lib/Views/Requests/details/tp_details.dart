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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(context,
                  text:
                      "${const AdDetailsPage().getRequestName(type)}\n${reference ?? ""}"),
            ),
            Expanded(
              child: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.tpDetailsModel?.record != null) {
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
                          const AdDetailsPage().header(
                            context,
                            state.tpDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.tpDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.tpDetailsModel?.record?.createdAt,
                            state.tpDetailsModel?.record?.status,
                            [
                              {
                                "icon": Icons.email_outlined,
                                "title": "Noc Fee",
                                "subTitle": (state.tpDetailsModel?.record
                                            ?.application?.transferFee ??
                                        " -- ")
                                    .toString(),
                              },
                              {
                                "icon": Icons.email_outlined,
                                "title": "Noc Fee status",
                                "subTitle": state.tpDetailsModel?.record
                                        ?.application?.transferFeeStatus ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.calendar_today_outlined,
                                "title": " Security Deposit",
                                "subTitle": (state
                                            .tpDetailsModel
                                            ?.record
                                            ?.application
                                            ?.transferSecurityDeposit ??
                                        " -- ")
                                    .toString(),
                              },
                              {
                                "icon": Icons.calendar_today_outlined,
                                "title": " Security Deposit status",
                                "subTitle": state.tpDetailsModel?.record
                                        ?.application?.transferSecurityStatus ??
                                    " -- ",
                              },
                            ],
                          ),
                          const AdDetailsPage().applicationDetails(
                              context,
                              state.tpDetailsModel?.record?.clientName,
                              state.tpDetailsModel?.record?.clientPhone,
                              state.tpDetailsModel?.record?.clientEmail),
                          const AdDetailsPage().supportingDocuments(
                            context,
                            [
                              {
                                "name": "Title Deed/Ownership Document",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.ownershipFileUrl,
                              },
                              {
                                "name": "Undertaking Letter",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.undertakingUrl,
                              },
                              {
                                "name": "Attorney's Passport",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.attorneyPassportUrl,
                              },
                              {
                                "name": "Attorney's File",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.attorneyIdFileUrl,
                              },
                              {
                                "name": "Power of Attorney",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.attorneyPoaUrl,
                              },
                              {
                                "name": "Seller Trade License",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.sellerCompanyTradeLicenseUrl,
                              },
                              {
                                "name": "Buyer company Trade License",
                                "url": state.tpDetailsModel?.record?.application
                                    ?.buyerCompanyTradeLicenseUrl,
                              },
                            ],
                          ),
                          const Gap(20),
                          Divider(
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.tpDetailsModel?.record?.application
                                ?.sellers?.length,
                            itemBuilder: (BuildContext context, int index) {
                              Seller? seller = state.tpDetailsModel?.record
                                  ?.application?.sellers?[index];
                              return Column(
                                children: [
                                  const AdDetailsPage().headingText(
                                      context, "Seller ${index + 1} Details"),
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
                                        "value": state.tpDetailsModel?.record
                                            ?.application?.sellerRequesterType,
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
                                        "value": seller?.sellerResidenceNumber,
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
                                        "value": seller?.sellerCellularNumber,
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
                                        "value": seller?.sellerOfficeNumber,
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
                                        "value": seller?.sellerPassportNumber,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.calendar_month_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Passport Expiry",
                                        "value": const OccupantPage()
                                            .dateTimeFormatter(
                                                seller?.sellerPassportExpiry),
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
                                          Icons.location_city_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Citizenship",
                                        "value": seller?.sellerCitizenship,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.card_membership_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Passport Copy",
                                        "url": true,
                                        "value": seller?.sellerPassportUrl,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.card_membership_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Visa Copy",
                                        "url": true,
                                        "value": seller?.sellerVisaUrl,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.card_membership_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Emirates ID Copy",
                                        "url": true,
                                        "value": seller?.sellerEmiratesIdUrl,
                                      },
                                    ]
                                        .map(
                                          (Map<String, dynamic> e) => ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            leading: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: kGrey.shade200),
                                              child: e["icon"],
                                            ),
                                            title: CustomText(
                                              text: e["key"] ?? "",
                                              textAlign: TextAlign.left,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            subtitle: CustomText(
                                              text: e["url"] == true ||
                                                      e["url"] != null
                                                  ? " "
                                                  : e["value"] ?? " -- ",
                                              textAlign: TextAlign.left,
                                              color: kGrey,
                                              fontSize: 15,
                                            ),
                                            trailing: e["url"] == false ||
                                                    e["url"] == null
                                                ? null
                                                : const OwnersPage().viewButton(
                                                    context, e["value"]),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              );
                            },
                          ),
                          Divider(
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.tpDetailsModel?.record?.application
                                ?.buyers?.length,
                            itemBuilder: (BuildContext context, int index) {
                              Buyer? buyer = state.tpDetailsModel?.record
                                  ?.application?.buyers?[index];
                              return Column(
                                children: [
                                  const AdDetailsPage().headingText(
                                      context, "Buyer ${index + 1} Details"),
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
                                        "key": "Buyer Type",
                                        "value": state.tpDetailsModel?.record
                                            ?.application?.buyerRequesterType,
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
                                        "value": buyer?.buyerResidenceNumber,
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
                                        "value": buyer?.buyerCellularNumber,
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
                                        "value": buyer?.buyerOfficeNumber,
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
                                        "value": buyer?.buyerPassportNumber,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.calendar_month_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Passport Expiry",
                                        "value": const OccupantPage()
                                            .dateTimeFormatter(
                                                buyer?.buyerPassportExpiry),
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
                                          Icons.location_city_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Citizenship",
                                        "value": buyer?.buyerCitizenship,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.card_membership_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Passport Copy",
                                        "url": true,
                                        "value": buyer?.buyerPassportUrl,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.card_membership_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Visa Copy",
                                        "url": true,
                                        "value": buyer?.buyerVisaUrl,
                                      },
                                      {
                                        "icon": Icon(
                                          Icons.card_membership_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        "key": "Emirates ID Copy",
                                        "url": true,
                                        "value": buyer?.buyerEmiratesIdUrl,
                                      },
                                    ]
                                        .map(
                                          (Map<String, dynamic> e) => ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            leading: e["icon"],
                                            title: CustomText(
                                              text: e["key"] ?? "",
                                              textAlign: TextAlign.left,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            subtitle: CustomText(
                                              text: e["url"] == true ||
                                                      e["url"] != null
                                                  ? ""
                                                  : e["value"] ?? " -- ",
                                              textAlign: TextAlign.left,
                                              color: kGrey,
                                              fontSize: 15,
                                            ),
                                            trailing: e["url"] == false ||
                                                    e["url"] == null
                                                ? null
                                                : const OwnersPage().viewButton(
                                                    context, e["value"]),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
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
}

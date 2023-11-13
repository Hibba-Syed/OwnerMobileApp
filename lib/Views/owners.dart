import 'package:iskaanowner/Blocs/Owners/owners_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/owners.dart';
import '../Utils/utils.dart';

class OwnersPage extends StatelessWidget {
  const OwnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Owners",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: BlocBuilder<OwnersCubit, OwnersState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }

          return ListView.builder(
            itemCount: state.ownersModel?.units?.owners?.length,
            itemBuilder: (BuildContext context, int index) {
              Owner? owner = state.ownersModel?.units?.owners?[index];
              List<Map<String, String?>> ownerData = [
                {
                  "key": "Arabic Name",
                  "value": owner?.detail?.arabicName,
                },
                {
                  "key": "Mollak Owner Name",
                  "value": owner?.detail?.name,
                },
                {
                  "key": "Primary Email",
                  "value": owner?.detail?.primaryEmail,
                },
                {
                  "key": "Secondary Email",
                  "value": owner?.detail?.secondaryEmail,
                },
                {
                  "key": "Primary Phone",
                  "value": owner?.detail?.primaryPhone,
                },
                {
                  "key": "Secondary Phone",
                  "value": owner?.detail?.secondaryPhone,
                },
                {
                  "key": "Passport No.",
                  "value": owner?.detail?.passportNumber,
                },
                {
                  "key": "Passport Expiry",
                  "value": owner?.detail?.passportExpiry,
                },
                {
                  "key": "Emirates ID No.",
                  "value": owner?.detail?.emiratesIdNumber,
                },
                {
                  "key": "Emirates ID Expiry",
                  "value": owner?.detail?.emiratesIdExpiry,
                },
                {
                  "key": "TRN",
                  "value": owner?.detail?.trnNumber,
                },
                {
                  "key": "Title Deed No.",
                  "value": owner?.detail?.titleDeedNumber,
                },
                {
                  "key": "Date of Birth",
                  "value": owner?.detail?.dob,
                },
                {
                  "key": "Country",
                  "value": owner?.detail?.country,
                },
                {
                  "key": "State",
                  "value": owner?.detail?.state,
                },
                {
                  "key": "City",
                  "value": owner?.detail?.city,
                },
                {
                  "key": "Address",
                  "value": owner?.detail?.fullAddress,
                },
              ];
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(1, 1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: kGrey.shade200),
                    ],
                    color: kWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const CustomText(
                                text: "Owner : ",
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: "${owner?.detail?.name}",
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (owner?.detail?.isPrimary == 1)
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const UnitsPage().roundedContainer(
                                  const CustomText(
                                    text: "Primary Owner",
                                    color: kWhite,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10)),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Table(
                      border: TableBorder.all(color: primaryColor),
                      columnWidths: const {
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth(1),
                      },
                      children: ownerData
                          .map(
                            (e) => tableRow(
                              e["key"] ?? "",
                              e["value"] ?? "not provided",
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      text: "Documents",
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    documentInfo("Title Deed",
                        url: owner?.documents?.titleDeed),
                    documentInfo("Passport",
                        url: owner?.documents?.passportFile),
                    documentInfo("ID", url: owner?.documents?.idFile),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget documentInfo(String text, {String? url}) {
    return const UnitsPage().roundedContainer(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: text),
          InkWell(
            onTap: () {
              if (url != null) {
                launchUrl(Uri.parse("$baseUrl/$url"));
              }
            },
            child: const UnitsPage().roundedContainer(
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      color: url == null ? kGrey : primaryColor,
                    ),
                    CustomText(
                      text: " View",
                      color: url == null ? kGrey : primaryColor,
                    )
                  ],
                ),
                invert: true,
                color: kWhite,
                padding: const EdgeInsets.symmetric(horizontal: 10)),
          ),
        ],
      ),
      color: kGrey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
    );
  }

  TableRow tableRow(String key, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: primaryColor.withOpacity(0.1),
            child: Center(child: CustomText(text: key)),
          ),
        ),
        TableCell(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: value,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}

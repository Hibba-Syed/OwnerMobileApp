import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class UnitDetailsPage extends StatelessWidget {
  const UnitDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? communityName =
        (ModalRoute.of(context)?.settings.arguments as List)[0];
    String? unitNo = (ModalRoute.of(context)?.settings.arguments as List)[1];
    int? unitId = (ModalRoute.of(context)?.settings.arguments as List)[2];
    String? unitSlug = (ModalRoute.of(context)?.settings.arguments as List)[3];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            context.read<AppThemeCubit>().state.primaryColor.withOpacity(0.8),
        onPressed: () async {
          if (unitSlug?.isEmpty ?? true) {
            Fluttertoast.showToast(msg: 'No service available');
          } else {
            await launchUrl(Uri.parse(
              "http://${context.read<ProfileCubit>().state.profileModel?.record?.company?.slug}.synergic360.com/$unitSlug",
            ));
          }
        },
        label: Row(
          children: [
            Image.asset(
              "assets/eServices.png",
              width: 25,
            ),
            const Gap(10),
            const CustomText(
              text: " E-Services",
              color: kWhite,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const DashboardPage().appBar(
                      context,
            
                        text: "Unit ${unitNo ?? ""}",
                    
                    ),
                    const Gap(10),
                    CustomText(
                      text: "$communityName",
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                    const Gap(20),
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
                                    text: "Unit Info",
                                    color: DefaultTabController.of(context)
                                                .index ==
                                            0
                                        ? kWhite
                                        : context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                    maxLines: 1,
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
                                    text: "Accounts",
                                    color: DefaultTabController.of(context)
                                                .index ==
                                            1
                                        ? kWhite
                                        : context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    unitDetailsUnitInfo(context, unitNo, unitId),
                    unitDetailsAccounts(context, unitNo, unitId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget unitDetailsUnitInfo(
      BuildContext context, String? unitNo, int? unitId) {
    List detailTabs = [
      {
        "name": "Owners",
        "icon": "assets/owners.png",
        "onTap": () {
          context.read<OwnersCubit>().getOwners(context, unitId);
          return Navigator.pushNamed(
            context,
            AppRoutes.owners,
            arguments: {
              'unit_id': unitId,
              'unit_no': unitNo,
            },
          );
        }
      },
      {
        "name": "Occupant",
        "icon": "assets/occupant.png",
        "onTap": () {
          context.read<OccupantCubit>().getOccupant(context, unitId);
          return Navigator.pushNamed(
            context,
            AppRoutes.occupant,
            arguments: {
              'unit_id': unitId,
              'unit_no': unitNo,
            },
          );
        }
      },
      {
        "name": "Requests",
        "icon": "assets/request.png",
        "onTap": () {
          context.read<RequestsCubit>().onChangeKeyword("");
          context.read<RequestsCubit>().resetFilters();
          context.read<RequestsCubit>().getRequests(context, unitId);
          return Navigator.pushNamed(
            context,
            AppRoutes.requests,
            arguments: {
              'unit_id': unitId,
              'unit_no': unitNo,
            },
          );
        }
      },
      {
        "name": "Compliances",
        "icon": "assets/compliances.png",
        "onTap": () {
          context.read<CompliancesCubit>().onChangeKeyword("");
          context.read<CompliancesCubit>().getCompliances(context, unitId);
          return Navigator.pushNamed(
            context,
            AppRoutes.compliances,
            arguments: {
              'unit_id': unitId,
              'unit_no': unitNo,
            },
          );
        }
      },
    ];
    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: detailTabs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return gridCard(context, detailTabs[index]);
          },
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomButton(
              text: "Shared Documents",
              icon: Image.asset(
                "assets/document.png",
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              height: MediaQuery.of(context).size.height * 0.06,
              fontSize: MediaQuery.of(context).size.width * 0.035,
              buttonColor: context
                  .read<AppThemeCubit>()
                  .state
                  .primaryColor
                  .withOpacity(0.8),
              function: () {
                context
                    .read<SharedDocumentsCubit>()
                    .getSharedDocuments(context, unitId: unitId);
                Navigator.pushNamed(context, AppRoutes.sharedDocument,
                    arguments: unitId);
              }),
        )
      ],
    );
  }

  Widget unitDetailsAccounts(
      BuildContext context, String? unitNo, int? unitId) {
    List detailTabs = [
      {
        "name": "Ledger",
        "icon": "assets/ledger.png",
        "onTap": () {
          context.read<LedgerCubit>().reset(context);
          context.read<LedgerCubit>().getLedgerByStatement(context, unitId);
          context.read<LedgerCubit>().getLedgerByDate(context, unitId);
          context.read<LedgerCubit>().getLedgerByAccount(context, unitId);
          return Navigator.pushNamed(
            context,
            AppRoutes.ledger,
            arguments: {
              'unit_id': unitId,
              'unit_no': unitNo,
            },
          );
        }
      },
      if (context
              .read<ProfileCubit>()
              .state
              .profileModel
              ?.record
              ?.company
              ?.showOwnerInvoices ==
          1)
        {
          "name": "Invoices",
          "icon": "assets/invoice.png",
          "onTap": () {
            context.read<InvoicesCubit>().onChangeKeyword("");
            context.read<InvoicesCubit>().reset();
            context.read<InvoicesCubit>().getInvoices(context, unitId);
            return Navigator.pushNamed(
              context,
              AppRoutes.invoices,
              arguments: {
                'unit_id': unitId,
                'unit_no': unitNo,
              },
            );
          }
        },
      if (context
              .read<ProfileCubit>()
              .state
              .profileModel
              ?.record
              ?.company
              ?.showOwnerReceipts ==
          1)
        {
          "name": "Receipts",
          "icon": "assets/receipt.png",
          "onTap": () {
            context.read<ReceiptsCubit>().onChangeKeyword("");
            context.read<ReceiptsCubit>().reset();
            context.read<ReceiptsCubit>().getReceipts(context, unitId);
            return Navigator.pushNamed(
              context,
              AppRoutes.receipts,
              arguments: {
                'unit_id': unitId,
                'unit_no': unitNo,
              },
            );
          }
        },
      if (context
              .read<ProfileCubit>()
              .state
              .profileModel
              ?.record
              ?.company
              ?.showOwnerInvoices ==
          1)
        {
          "name": "Credit Notes",
          "icon": "assets/creditNote.png",
          "onTap": () {
            context.read<CreditNotesCubit>().onChangeKeyword("");
            context.read<CreditNotesCubit>().reset();
            context.read<CreditNotesCubit>().getCreditNotes(context, unitId);
            return Navigator.pushNamed(
              context,
              AppRoutes.creditNotes,
              arguments: {
                'unit_id': unitId,
                'unit_no': unitNo,
              },
            );
          }
        },
    ];
    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: detailTabs.length,
          itemBuilder: (BuildContext context, int index) {
            return gridCard(context, detailTabs[index]);
          },
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomButton(
              text: "Shared Documents",
              icon: Image.asset(
                "assets/document.png",
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              height: MediaQuery.of(context).size.height * 0.06,
              fontSize: MediaQuery.of(context).size.width * 0.035,
              buttonColor: context
                  .read<AppThemeCubit>()
                  .state
                  .primaryColor
                  .withOpacity(0.8),
              function: () {
                context
                    .read<SharedDocumentsCubit>()
                    .getSharedDocuments(context, unitId: unitId);
                Navigator.pushNamed(context, AppRoutes.sharedDocument,
                    arguments: unitId);
              }),
        )
      ],
    );
  }

  Widget gridCard(BuildContext context, Map tab) {
    return InkWell(
      onTap: tab["onTap"],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhite,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              tab["icon"],
              color: context
                  .read<AppThemeCubit>()
                  .state
                  .primaryColor
                  .withOpacity(0.8),
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            const Gap(10),
            CustomText(
              text: tab["name"],
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

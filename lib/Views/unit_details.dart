import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class UnitDetailsPage extends StatelessWidget {
  const UnitDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? communityName =
        (ModalRoute.of(context)?.settings.arguments as List)[0];
    String? unitNo = (ModalRoute.of(context)?.settings.arguments as List)[1];
    int? unitId = (ModalRoute.of(context)?.settings.arguments as List)[2];
    String? unitSlug = (ModalRoute.of(context)?.settings.arguments as List)[3];
    final tabList = ["Unit Info", "Accounts"];
    return Scaffold(
      appBar: BaseAppBar(
        title: "Unit - $unitNo",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await launchUrl(
              Uri.parse("http://onlinistfze.synergic360.com/$unitSlug"));
        },
        label: const Row(
          children: [Icon(Icons.link), CustomText(text: " E-Services")],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Gap(10),
              unitDetailHeader(context, communityName, unitId),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kGrey.shade200),
                child: TabBar(
                  isScrollable: false,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.read<AppThemeCubit>().state.primaryColor),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: kWhite,
                  dividerColor: kTransparent,
                  indicatorColor:
                      context.read<AppThemeCubit>().state.primaryColor,
                  tabs: List.generate(
                      tabList.length,
                      (index) => Tab(
                            text: tabList[index],
                          )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
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

  Widget unitDetailHeader(
      BuildContext context, String? communityName, int? unitId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_city,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            CustomText(
              text: " $communityName",
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        const UnitsPage().roundedContainer(
            context,
            InkWell(
              onTap: () {
                context
                    .read<SharedDocumentsCubit>()
                    .getSharedDocuments(context, unitId: unitId);
                Navigator.pushNamed(context, AppRoutes.sharedDocument);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.document_scanner_outlined,
                    color: kWhite,
                    size: 18,
                  ),
                  CustomText(
                    text: " Shared Documents",
                    color: kWhite,
                    fontsize: 15,
                  )
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
      ],
    );
  }

  Widget unitDetailsUnitInfo(
      BuildContext context, String? unitNo, int? unitId) {
    List detailTabs = [
      {
        "name": "Owner",
        "icon": Icons.person_outline,
        "onTap": () {
          context.read<OwnersCubit>().getOwners(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.owners,
              arguments: unitNo);
        }
      },
      {
        "name": "Occupant",
        "icon": Icons.person_4_outlined,
        "onTap": () {
          context.read<OccupantCubit>().getOccupant(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.occupant,
              arguments: unitNo);
        }
      },
      {
        "name": "Requests",
        "icon": Icons.request_page_outlined,
        "onTap": () {
          context.read<RequestsCubit>().resetFilters();
          context.read<RequestsCubit>().getRequests(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.requests,
              arguments: [unitNo, unitId]);
        }
      },
      {
        "name": "Complainces",
        "icon": Icons.done,
        "onTap": () {
          context.read<CompliancesCubit>().getCompliances(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.compliances,
              arguments: [unitNo, unitId]);
        }
      },
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: detailTabs.length,
      itemBuilder: (BuildContext context, int index) {
        return gridCard(context, detailTabs[index]);
      },
    );
  }

  Widget unitDetailsAccounts(
      BuildContext context, String? unitNo, int? unitId) {
    List detailTabs = [
      {
        "name": "Ledger",
        "icon": Icons.account_balance,
        "onTap": () {
          context.read<LedgerCubit>().reset(context);
          context.read<LedgerCubit>().getLedgerByStatement(context, unitId);
          context.read<LedgerCubit>().getLedgerByDate(context, unitId);
          context.read<LedgerCubit>().getLedgerByAccount(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.ledger,
              arguments: [unitNo, unitId]);
        }
      },
      {
        "name": "Invoices",
        "icon": Icons.receipt_long,
        "onTap": () {
          context.read<InvoicesCubit>().reset();
          context.read<InvoicesCubit>().getInvoices(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.invoices,
              arguments: [unitNo, unitId]);
        }
      },
      {
        "name": "Receipts",
        "icon": Icons.receipt,
        "onTap": () {
          context.read<ReceiptsCubit>().reset();
          context.read<ReceiptsCubit>().getReceipts(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.receipts,
              arguments: [unitNo, unitId]);
        }
      },
      {
        "name": "Credit Notes",
        "icon": Icons.note,
        "onTap": () {
          context.read<CreditNotesCubit>().reset();
          context.read<CreditNotesCubit>().getCreditNotes(context, unitId);
          return Navigator.pushNamed(context, AppRoutes.creditNotes,
              arguments: [unitNo, unitId]);
        }
      },
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: detailTabs.length,
      itemBuilder: (BuildContext context, int index) {
        return gridCard(context, detailTabs[index]);
      },
    );
  }

  Widget gridCard(BuildContext context, Map tab) {
    return InkWell(
      onTap: tab["onTap"],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kGrey.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UnitsPage().roundedContainer(
              context,
              Icon(
                tab["icon"],
                color: context.read<AppThemeCubit>().state.primaryColor,
                size: 40,
              ),
              color: kWhite,
              invert: true,
              padding: const EdgeInsets.all(20),
            ),
            const SizedBox(
              height: 10,
            ),
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

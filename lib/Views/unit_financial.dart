import 'package:iskaanowner/Blocs/Unit%20Financials/unit_financials_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/unit_financials.dart';
import '../Utils/utils.dart';

class UnitFinancialPage extends StatelessWidget {
  const UnitFinancialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Financial summary",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<UnitFinancialsCubit, UnitFinancialsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<DownloadLedgerCubit, DownloadLedgerState>(
                    builder: (context, downloadLedgerState) {
                      return CustomButton(
                        buttonColor: state.selectedUnits.isEmpty
                            ? kGrey
                            : context.read<AppThemeCubit>().state.primaryColor,
                        width: MediaQuery.of(context).size.width * 0.4,
                        text: "Export",
                        function: () {
                          if (state.selectedUnits.isNotEmpty) {
                            String filter = "";
                            for (var element in context
                                .read<UnitFinancialsCubit>()
                                .state
                                .selectedUnits) {
                              filter = "$filter&propertyIds[]=$element";
                            }
                            context.read<DownloadLedgerCubit>().downloadDocument(
                                context,
                                "$baseUrl/mobile/owner/property/accounting/ledgers/units-ledger-export?ledgerIds[]=${context.read<LedgerCubit>().state.ledgerType?.id}&export=excel$filter");
                            return;
                          }
                          Fluttertoast.showToast(
                              msg: "Long press and select units to export");
                        },
                        icon: downloadLedgerState.loadingState ==
                                LoadingState.loading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: kWhite,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.import_export_outlined,
                                color: kWhite,
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.unitFinancialsModel?.record?.length,
                    itemBuilder: (BuildContext context, int index) {
                      UnitFinancialsRecord? unitFinancialsRecord =
                          state.unitFinancialsModel?.record?[index];
                      var modifedList = List.from(state.selectedUnits);
                      int? checkboxIndex = modifedList.indexWhere(
                          (element) => element == unitFinancialsRecord?.unitId);
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite,
                            boxShadow: [
                              BoxShadow(
                                color: kGrey.shade200,
                                spreadRadius: 2,
                                blurRadius: 2,
                              )
                            ]),
                        child: ListTile(
                          onLongPress: () {
                            context
                                .read<UnitFinancialsCubit>()
                                .onChangeSelectedUnits(
                                    [unitFinancialsRecord?.unitId]);
                          },
                          onTap: () {
                            if (state.selectedUnits.isNotEmpty) {
                              if (checkboxIndex != -1) {
                                modifedList.removeAt(checkboxIndex);
                              } else {
                                modifedList.add(unitFinancialsRecord?.unitId);
                              }
                              context
                                  .read<UnitFinancialsCubit>()
                                  .onChangeSelectedUnits(modifedList);
                            }
                          },
                          leading: AnimatedCrossFade(
                              firstChild: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kGrey.shade200),
                                  child: Icon(
                                    Icons.place,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor,
                                  )),
                              secondChild: Checkbox(
                                visualDensity: VisualDensity.comfortable,
                                value: checkboxIndex != -1 ? true : false,
                                onChanged: (value) {
                                  if (checkboxIndex != -1) {
                                    modifedList.removeAt(checkboxIndex);
                                  } else {
                                    modifedList
                                        .add(unitFinancialsRecord?.unitId);
                                  }
                                  context
                                      .read<UnitFinancialsCubit>()
                                      .onChangeSelectedUnits(modifedList);
                                },
                              ),
                              crossFadeState: state.selectedUnits.isEmpty
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(seconds: 1)),
                          title: CustomText(
                            text: unitFinancialsRecord?.communityName ?? " -- ",
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text:
                                    unitFinancialsRecord?.unitNumber ?? " -- ",
                                textAlign: TextAlign.left,
                                fontsize: 14,
                                color: kGrey,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor
                                        .withOpacity(0.2)),
                                child: CustomText(
                                  text: formatCurrency(
                                      unitFinancialsRecord?.balance ?? 0),
                                  fontsize: 12,
                                ),
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
          );
        },
      ),
    );
  }
}

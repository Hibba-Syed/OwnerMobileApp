import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/compliances.dart';
import '../Utils/utils.dart';

class CompliancesPage extends StatelessWidget {
  const CompliancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String?;
    int? unitId =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Compliances",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomSearch(
              initialValue: context.read<CompliancesCubit>().state.keyword,
              onChanged: (value) =>
                  context.read<CompliancesCubit>().onChangeKeyword(value),
              onSubmitted: (value) => context
                  .read<CompliancesCubit>()
                  .getCompliances(context, unitId),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<CompliancesCubit, CompliancesState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.compliancesModel?.compliance?.isEmpty ?? true) {
                    return const CreditNotesPage().emptyList();
                  }
                  return ListView.builder(
                    itemCount: state.compliancesModel?.compliance?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ComplianceElement? complianceElement =
                          state.compliancesModel?.compliance?[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(
                                1,
                                1,
                              ),
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: kGrey.shade200,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.task_outlined,
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                  size: 18,
                                ),
                                CustomText(
                                  text:
                                      "Compliance: ${complianceElement?.name ?? "not provided"}",
                                  fontWeight: FontWeight.bold,
                                  fontsize: 15,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 18,
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    CustomText(
                                      text:
                                          "Date: ${const OccupantPage().dateTimeFormatter(complianceElement?.compliance?.datetime)}",
                                      fontsize: 14,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 18,
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    CustomText(
                                      text:
                                          "Expiry Date: ${const OccupantPage().dateTimeFormatter(complianceElement?.compliance?.expiry)}",
                                      fontsize: 14,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const UnitsPage().roundedContainer(
                                  context,
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility_outlined,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                        size: 18,
                                      ),
                                      const CustomText(
                                        text: " Certificate",
                                        fontsize: 14,
                                      )
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  invert: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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

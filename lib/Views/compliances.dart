import '../Utils/utils.dart';
import '../Widgets/compliances_list_page.dart';

class CompliancesPage extends StatelessWidget {
  const CompliancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      appBar: BaseAppBar(
        title: (unitNumber?.isEmpty ?? true) ? "" : "$unitNumber - Compliances",
        appBar: AppBar(),
        widgets: [const DashboardPage().notificationIcon(context)],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomSearch(
              initialValue: context.read<CompliancesCubit>().state.keyword,
              onSubmitted: (value) {
                context.read<CompliancesCubit>().onChangeKeyword(value);
                context
                    .read<CompliancesCubit>()
                    .getCompliances(context, unitId);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CompliancesListPage(
                unitId: unitId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

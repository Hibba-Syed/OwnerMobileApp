import '../../Utils/utils.dart';
import '../../Widgets/compliances_list_page.dart';

class CompliancesPage extends StatelessWidget {
  const CompliancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const DashboardPage().appBar(
                context,
                text: "Unit $unitNumber - Compliances",
              ),
              CustomSearch(
                fillColor: kWhite,
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
      ),
    );
  }
}

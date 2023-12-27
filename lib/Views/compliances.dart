import '../Utils/utils.dart';
import '../Widgets/compliances_list_page.dart';

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
                child: CompliancesListPage(
              unitId: unitId,
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:iskaanowner/Widgets/shared_document_list_page.dart';

import '../Utils/utils.dart';

class SharedDocumentPage extends StatelessWidget {
  const SharedDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? unitId = ModalRoute.of(context)?.settings.arguments as int?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
            
                  text: "Shared Documents",
             
              ),
            ),
            Expanded(
              child: SharedDocumentsListPage(
                unitId: unitId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

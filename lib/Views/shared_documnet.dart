import '../Utils/utils.dart';

class SharedDocumentPage extends StatelessWidget {
  const SharedDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? unitId = ModalRoute.of(context)?.settings.arguments as int?;
    return Scaffold(
        appBar: BaseAppBar(
          title: "Shared Documnets",
          appBar: AppBar(),
          widgets: const [],
          appBarHeight: 50,
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<SharedDocumentsCubit, SharedDocumentsState>(
          builder: (context, state) {
            if (state.loadingState == LoadingState.loading) {
              return const CustomLoader();
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => primaryColor.withOpacity(0.1)),
                  border: TableBorder.all(color: primaryColor),
                  columns: [
                    "Document Name",
                    unitId == null ? "Community" : "Unit",
                    "Expiry Date",
                    "Tags",
                    "Documnet"
                  ].map((e) => sharedDocumentDataColumn(e)).toList(),
                  rows: state.sharedDocumentsModel?.record?.map((e) {
                        Map data = e.toJson();
                        return sharedDocumentTableRow(
                          data["document_name"] as String? ?? " -- ",
                          data["title"] as String? ?? " -- ",
                          data["expDate"] as String? ?? " -- ",
                          (data["tags"] as List? ?? [])
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""),
                        );
                      }).toList() ??
                      [],
                ),
              ),
            );
          },
        ));
  }

  DataColumn sharedDocumentDataColumn(String text) {
    return DataColumn(
        label: CustomText(
      text: text,
      fontWeight: FontWeight.bold,
    ));
  }

  DataRow sharedDocumentTableRow(
    String docName,
    String community,
    String expDate,
    String tags,
  ) {
    return DataRow(cells: <DataCell>[
      DataCell(
        CustomText(text: docName),
      ),
      DataCell(
        CustomText(
          text: community,
        ),
      ),
      DataCell(
        CustomText(text: expDate),
      ),
      DataCell(
        CustomText(
          text: tags,
        ),
      ),
      const DataCell(Row(
        children: [
          Icon(
            Icons.visibility_outlined,
            color: primaryColor,
          ),
          Gap(10),
          CustomText(
            text: "View",
            color: primaryColor,
          )
        ],
      )),
    ]);
  }
}

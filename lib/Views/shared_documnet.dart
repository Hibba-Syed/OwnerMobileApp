import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/shared_document.dart';
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
            if (state.sharedDocumentsModel?.record?.isEmpty ?? true) {
              return const CreditNotesPage()
                  .emptyList(lottie: "assets/document.json");
            }
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.sharedDocumentsModel?.record?.length,
              itemBuilder: (BuildContext context, int index) {
                SharedDocumentsRecord? sharedDocumentsRecord =
                    state.sharedDocumentsModel?.record?[index];
                return Container(
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: kGrey.shade300,
                            blurRadius: 2,
                            spreadRadius: 2)
                      ]),
                  child: sharedDocumentWidget(
                      context, sharedDocumentsRecord, unitId),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 16 / 20),
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

  Widget sharedDocumentWidget(BuildContext context,
      SharedDocumentsRecord? sharedDocumentsRecord, int? unitId) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Builder(builder: (context) {
                String? url = sharedDocumentsRecord?.documents;
                String asset = "assets/file.png";
                String fileExtension = extension(url ?? "");
                fileExtension = fileExtension.toLowerCase();
                if (fileExtension == ".png" ||
                    fileExtension == ".jpeg" ||
                    fileExtension == ".jpg") {
                  asset = "assets/image.png";
                }
                if (fileExtension == ".doc" ||
                    fileExtension == ".xlsx" ||
                    fileExtension == ".docx") {
                  asset = "assets/doc.png";
                }
                if (fileExtension == ".pdf") {
                  asset = "assets/pdf.png";
                }
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: context
                          .read<AppThemeCubit>()
                          .state
                          .primaryColor
                          .withOpacity(0.05)),
                  child: Image.asset(
                    asset,
                  ),
                );
              }),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.read<AppThemeCubit>().state.primaryColor),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: CustomText(
                  text: sharedDocumentsRecord?.title ?? " -- ",
                  color: kWhite,
                  fontsize: 13,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: kWhite),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: sharedDocumentsRecord?.documentName ?? "",
                        fontWeight: FontWeight.bold,
                        fontsize: 17,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                      CustomText(
                        text: const OccupantPage().dateTimeFormatter(
                            sharedDocumentsRecord?.expiryDate),
                        color: kGrey,
                        fontsize: 14,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (sharedDocumentsRecord?.documents != null) {
                        launchUrl(
                            Uri.parse(sharedDocumentsRecord?.documents ?? ""));
                      }
                    },
                    icon: Icon(
                      Icons.download_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

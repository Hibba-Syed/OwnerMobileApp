import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/shared_document.dart';
import '../Utils/utils.dart';

class SharedDocumentsListPage extends StatefulWidget {
  final int? unitId;
  const SharedDocumentsListPage({super.key, this.unitId});

  @override
  State<SharedDocumentsListPage> createState() =>
      _SharedDocumentsListPageState();
}

class _SharedDocumentsListPageState extends State<SharedDocumentsListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      SharedDocumentsCubit sharedDocumentsCubit =
          context.read<SharedDocumentsCubit>();
      if (sharedDocumentsCubit.state.loadMoreState != LoadingState.loading) {
        sharedDocumentsCubit.getMoreSharedDocuments(context,
            unitId: widget.unitId);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedDocumentsCubit, SharedDocumentsState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.sharedDocumentsModel?.sharedDocuments?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
            lottie: "assets/document.json",
            ontap: () {
              context
                  .read<SharedDocumentsCubit>()
                  .getSharedDocuments(context, unitId: widget.unitId);
            },
          );
        }

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<SharedDocumentsCubit>()
                      .getSharedDocuments(context, unitId: widget.unitId);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount:
                      state.sharedDocumentsModel?.sharedDocuments?.length,
                  itemBuilder: (BuildContext context, int index) {
                    SharedDocument? sharedDocumentsRecord =
                        state.sharedDocumentsModel?.sharedDocuments?[index];
                    String? url = sharedDocumentsRecord?.documents;
                    String type = "File";
                    String fileExtension = path.extension(url ?? "");
                    fileExtension = fileExtension.toLowerCase();
                    if (fileExtension == ".png" ||
                        fileExtension == ".jpeg" ||
                        fileExtension == ".jpg") {
                      type = "Image";
                    }
                    if (fileExtension == ".doc" ||
                        fileExtension == ".xlsx" ||
                        fileExtension == ".docx") {
                      type = "Document";
                    }
                    if (fileExtension == ".pdf") {
                      type = "Pdf";
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(1, 1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: kGrey.shade200),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Builder(builder: (context) {
                                  if (type.toLowerCase() == "pdf") {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                      width: double.infinity,
                                      child: const PDF(
                                        swipeHorizontal: true,
                                      ).cachedFromUrl(
                                          sharedDocumentsRecord?.documents ??
                                              ""),
                                    );
                                  }
                                  return ImageBuilder(
                                    url: sharedDocumentsRecord?.documents ?? "",
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                    width: double.infinity,
                                  );
                                }),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: kWhite,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor
                                          .withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: CustomText(
                                      text: type,
                                      color: kWhite,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            widget.unitId != null
                                                ? "assets/unit.png"
                                                : "assets/community.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            color: const Color(0xff575757),
                                          ),
                                          const Gap(5),
                                          Flexible(
                                            child: CustomText(
                                              text: sharedDocumentsRecord?.title
                                                      ?.capitalize() ??
                                                  "",
                                              color: const Color(0xffB2B1B1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(10),
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/calender.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            color: const Color(0xff575757),
                                          ),
                                          const Gap(5),
                                          Flexible(
                                            child: CustomText(
                                              text: const OccupantPage()
                                                  .dateTimeFormatter(
                                                      sharedDocumentsRecord
                                                          ?.expiryDate),
                                              color: const Color(0xffB2B1B1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: sharedDocumentsRecord?.documentName
                                              ?.capitalize() ??
                                          " -- ",
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                    ),
                                    Flexible(
                                      child: CustomButton(
                                        text: "Download",
                                        padding: EdgeInsets.zero,
                                        function: () {
                                          if (sharedDocumentsRecord
                                                  ?.documents !=
                                              null) {
                                            launchUrl(Uri.parse(
                                                sharedDocumentsRecord
                                                        ?.documents ??
                                                    ""));
                                          }
                                        },
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        buttonColor: const Color(0xff65D024)
                                            .withOpacity(0.1),
                                        textColor: const Color(0xff65D024),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        icon: Image.asset(
                                          "assets/download_summary.png",
                                          color: const Color(0xff65D024),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            if (state.loadMoreState == LoadingState.loading)
              const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}

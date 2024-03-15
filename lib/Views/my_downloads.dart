import 'dart:io' as io;
import 'dart:io';

import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/file_icons.dart';
import 'package:iconify_flutter_plus/icons/uil.dart';
import 'package:iconify_flutter_plus/icons/vaadin.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:slideable/slideable.dart';

import '../Utils/utils.dart';

class MyDownloadsPage extends StatelessWidget {
  const MyDownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                text: "My Downloads",
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getApplicationDocumentsDirectory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CustomLoader();
                  }
                  return StatefulBuilder(builder: (context, setState) {
                    List<FileSystemEntity> file =
                        io.Directory("${snapshot.data?.path ?? ""}/downloads")
                            .listSync();
                    if (file.isEmpty) {
                      return const CreditNotesPage().emptyList();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Total files (${file.length})",
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: kGrey,
                          ),
                          const Gap(20),
                          Expanded(
                            child: ListView.separated(
                              itemCount: file.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Slideable(
                                  items: [
                                    ActionItems(
                                        icon: const Icon(Icons.delete_outline),
                                        onPress: () {
                                          setState(() {
                                            file[index].delete();
                                          });
                                        },
                                        backgroundColor: kTransparent)
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      try {
                                        OpenFilex.open(file[index].path);
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Make sure you have a program to open files with the extension '${extension(file[index].path).replaceAll(".", "")}'.");
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: kGrey.shade100,
                                                shape: BoxShape.circle),
                                            child: Iconify(
                                              extension(file[index].path) ==
                                                      ".xlsx"
                                                  ? FileIcons.microsoft_excel
                                                  : extension(file[index]
                                                              .path) ==
                                                          ".zip"
                                                      ? Vaadin.file_zip
                                                      : Uil.file_alt,
                                              color: context
                                                  .read<AppThemeCubit>()
                                                  .state
                                                  .primaryColor,
                                            ),
                                          ),
                                          const Gap(10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: file[index]
                                                      .path
                                                      .split("/")
                                                      .last,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  maxLines: 2,
                                                ),
                                                CustomText(
                                                  text: const OccupantPage()
                                                      .dateTimeFormatter(
                                                          io.FileStat.statSync(
                                                                  file[index]
                                                                      .path)
                                                              .modified),
                                                  color: kGrey,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Gap(10),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

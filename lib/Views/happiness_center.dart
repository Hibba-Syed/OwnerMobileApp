import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class HappinessCenterPage extends StatelessWidget {
  HappinessCenterPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<String> unitList = ["Select"];
    List<String> commonAreaList = ["Select"];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<HappinessCenterCubit, HappinessCenterState>(
            builder: (context, state) {
              if (state.loadingState == LoadingState.loading) {
                return const SizedBox(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return CustomButton(
                  text: "Submit",
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  height: MediaQuery.of(context).size.width * 0.12,
                  buttonColor: context
                      .read<AppThemeCubit>()
                      .state
                      .primaryColor
                      .withOpacity(0.8),
                  function: () {
                    if (state.communityId == null || state.communityId == 0) {
                      Fluttertoast.showToast(msg: "Select a community");
                      return;
                    }
                    if (state.unitId == null || state.unitId == 0) {
                      Fluttertoast.showToast(msg: "Select a unit");
                      return;
                    }
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    context.read<HappinessCenterCubit>().submitQuery(context);
                  },
                  icon: Image.asset(
                    "assets/send.png",
                    width: MediaQuery.of(context).size.width * 0.06,
                    color: kWhite,
                  ));
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: const DashboardPage().appBar(
                  context,
                  text: "Happiness Center",
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<HappinessCenterCubit,
                              HappinessCenterState>(
                            builder: (context, state) {
                              return const DashboardPage()
                                  .categoriesRow(context, [
                                const DashboardPage().iconButton(
                                  context,
                                  "assets/inquiry.png",
                                  "Inquiry",
                                  color: state.complaintType.toLowerCase() ==
                                          "inquiry"
                                      ? context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor
                                          .withOpacity(0.05)
                                      : kWhite,
                                  onTap: () {
                                    context
                                        .read<HappinessCenterCubit>()
                                        .onChangeComplaintType("Inquiry");
                                  },
                                ),
                                const DashboardPage().iconButton(
                                  context,
                                  "assets/complaint.png",
                                  "Complaint",
                                  color: state.complaintType.toLowerCase() ==
                                          "complaint"
                                      ? context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor
                                          .withOpacity(0.05)
                                      : kWhite,
                                  onTap: () {
                                    context
                                        .read<HappinessCenterCubit>()
                                        .onChangeComplaintType("Complaint");
                                  },
                                ),
                                const DashboardPage().iconButton(
                                  context,
                                  "assets/suggestion.png",
                                  "Suggestion",
                                  color: state.complaintType.toLowerCase() ==
                                          "suggestion"
                                      ? context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor
                                          .withOpacity(0.05)
                                      : kWhite,
                                  onTap: () {
                                    context
                                        .read<HappinessCenterCubit>()
                                        .onChangeComplaintType("Suggestion");
                                  },
                                ),
                              ]);
                            },
                          ),
                          const Gap(10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
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
                                BlocBuilder<DropdownCommunitiesCubit,
                                    DropdownCommunitiesState>(
                                  builder: (context, state) {
                                    return inputDropDown(
                                      context,
                                      "Community*",
                                      (state.communitiesModel?.associations
                                              ?.map((e) => e.name ?? " -- ")
                                              .toList() ??
                                          [])
                                        ..insert(0, "Select"),
                                      onSelected: (value) {
                                        if (value?.toLowerCase() == "select") {
                                          context
                                              .read<DropdownUnitsCubit>()
                                              .resetList();
                                        }
                                        context
                                            .read<HappinessCenterCubit>()
                                            .onChangeUnitId(0);
                                        int? index = state
                                            .communitiesModel?.associations
                                            ?.indexWhere((element) =>
                                                element.name == value);
                                        if (index != null && index != -1) {
                                          context
                                              .read<HappinessCenterCubit>()
                                              .onChangeCommunityId(state
                                                  .communitiesModel
                                                  ?.associations?[index]
                                                  .id);
                                          context
                                              .read<DropdownUnitsCubit>()
                                              .getUnits(
                                                  context,
                                                  state
                                                      .communitiesModel
                                                      ?.associations?[index]
                                                      .id);
                                        }
                                      },
                                      loadingState: state.loadingState,
                                    );
                                  },
                                ),
                                BlocBuilder<DropdownUnitsCubit,
                                    DropdownUnitsState>(
                                  builder: (context, state) {
                                    return inputDropDown(
                                      context,
                                      "Unit*",
                                      (state.unitsModel?.record
                                              ?.map((e) => e.unitNumber ?? "")
                                              .toList() ??
                                          [])
                                        ..insert(0, "Select"),
                                      loadingState: state.loadingState,
                                      onSelected: (value) {
                                        int? index = state.unitsModel?.record
                                            ?.indexWhere((element) =>
                                                element.unitNumber == value);
                                        if (index != null && index != -1) {
                                          context
                                              .read<HappinessCenterCubit>()
                                              .onChangeUnitId(state.unitsModel
                                                  ?.record?[index].id);
                                          unitList = ["Select"];
                                          unitList.addAll(
                                            state.unitsModel?.record?[index]
                                                    .happinessCenterConfig?.unit
                                                    ?.map((e) =>
                                                        e.serviceName ?? "")
                                                    .toList() ??
                                                [],
                                          );
                                          commonAreaList = ["Select"];
                                          commonAreaList.addAll(
                                            state
                                                    .unitsModel
                                                    ?.record?[index]
                                                    .happinessCenterConfig
                                                    ?.commonArea
                                                    ?.map((e) =>
                                                        e.serviceName ?? "")
                                                    .toList() ??
                                                [],
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                BlocBuilder<HappinessCenterCubit,
                                    HappinessCenterState>(
                                  builder: (context, state) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (state.complaintType.toLowerCase() ==
                                            "complaint")
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              HappinessCenterCubit>()
                                                          .onChangeRadioValue(
                                                              "Unit");
                                                    },
                                                    child: AnimatedContainer(
                                                      duration: 400.ms,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .read<
                                                                AppThemeCubit>()
                                                            .state
                                                            .primaryColor
                                                            .withOpacity(state
                                                                        .radioValue
                                                                        .toLowerCase() ==
                                                                    "unit"
                                                                ? 0.8
                                                                : 0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: CustomText(
                                                        text: "Unit Info",
                                                        color: state.radioValue
                                                                    .toLowerCase() ==
                                                                "unit"
                                                            ? kWhite
                                                            : context
                                                                .read<
                                                                    AppThemeCubit>()
                                                                .state
                                                                .primaryColor,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Gap(10),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              HappinessCenterCubit>()
                                                          .onChangeRadioValue(
                                                              "Common Area");
                                                    },
                                                    child: AnimatedContainer(
                                                      duration: 400.ms,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .read<
                                                                AppThemeCubit>()
                                                            .state
                                                            .primaryColor
                                                            .withOpacity(state
                                                                        .radioValue
                                                                        .toLowerCase() ==
                                                                    "common area"
                                                                ? 0.8
                                                                : 0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: CustomText(
                                                        text: "Common Area",
                                                        color: state.radioValue
                                                                    .toLowerCase() ==
                                                                "common area"
                                                            ? kWhite
                                                            : context
                                                                .read<
                                                                    AppThemeCubit>()
                                                                .state
                                                                .primaryColor,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Builder(builder: (context) {
                                          if (state.complaintType
                                                  .toLowerCase() !=
                                              "complaint") {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CustomText(
                                                  text: "Subject*",
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xffB2B1B1),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.032,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CustomTextField(
                                                  initialValue: state.service,
                                                  hintText: "Enter subject",
                                                  validator: (value) {
                                                    if (state.complaintType
                                                            .toLowerCase() !=
                                                        "complaint") {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Please enter a subject";
                                                      }
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) => context
                                                      .read<
                                                          HappinessCenterCubit>()
                                                      .onChangeService(value),
                                                ),
                                              ],
                                            );
                                          }
                                          return BlocBuilder<DropdownUnitsCubit,
                                              DropdownUnitsState>(
                                            builder: (context, dropDownState) {
                                              return inputDropDown(
                                                context,
                                                "Service",
                                                state.radioValue
                                                            .toLowerCase() ==
                                                        "unit"
                                                    ? unitList
                                                    : commonAreaList,
                                                loadingState:
                                                    dropDownState.loadingState,
                                                onSelected: (value) {
                                                  if (value?.toLowerCase() !=
                                                      "select") {
                                                    context
                                                        .read<
                                                            HappinessCenterCubit>()
                                                        .onChangeService(value);
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: state.complaintType
                                                      .toLowerCase() ==
                                                  "complaint"
                                              ? "Complaint*"
                                              : state.complaintType
                                                          .toLowerCase() ==
                                                      "inquiry"
                                                  ? "Inquiry*"
                                                  : "Suggestion*",
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xffB2B1B1),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.032,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
                                          hintText:
                                              "Enter your ${state.complaintType.toLowerCase() == "complaint" ? "complaint" : state.complaintType.toLowerCase() == "inquiry" ? "inquiry" : "suggestion"} here",
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your ${state.complaintType.toLowerCase() == "complaint" ? "complaint" : state.complaintType.toLowerCase() == "inquiry" ? "inquiry" : "suggestion"} here";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 5,
                                          onChanged: (value) => context
                                              .read<HappinessCenterCubit>()
                                              .onChangeMessage(value),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: "Attachments",
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xffB2B1B1),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.032,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            text: "Upload",
                                            function: () async {
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      allowedExtensions: [
                                                    ".png",
                                                    ".jpg",
                                                    "jpeg",
                                                    ".pdf",
                                                    ".gif"
                                                  ],
                                                      allowMultiple: true,
                                                      type:
                                                          FileType.custom).then(
                                                      (value) {
                                                if (value != null) {
                                                  if (value.count > 3 ||
                                                      (context
                                                                  .read<
                                                                      HappinessCenterCubit>()
                                                                  .state
                                                                  .fileList
                                                                  ?.length ??
                                                              0) ==
                                                          3) {
                                                    return Fluttertoast.showToast(
                                                        msg:
                                                            "You can attach only three files");
                                                  }
                                                  context
                                                      .read<
                                                          HappinessCenterCubit>()
                                                      .onChangeFiles(value.files
                                                          .map((e) => File(
                                                              e.path ?? ""))
                                                          .toList());
                                                }
                                              });
                                            },
                                            textColor: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                            invert: true,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035,
                                            icon: Image.asset(
                                              "assets/upload.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: context
                                                  .read<AppThemeCubit>()
                                                  .state
                                                  .primaryColor,
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: state.fileList
                                                  ?.map((e) => Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: kGrey.shade200,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: CustomText(
                                                                text: e.path
                                                                    .split("/")
                                                                    .last,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            const Gap(10),
                                                            IconButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          HappinessCenterCubit>()
                                                                      .removeFile(
                                                                          e);
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close))
                                                          ],
                                                        ),
                                                      ))
                                                  .toList() ??
                                              [],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputDropDown(
    BuildContext context,
    String text,
    List<String> list, {
    bool enabled = true,
    LoadingState loadingState = LoadingState.none,
    void Function(String?)? onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: text,
          fontWeight: FontWeight.bold,
          color: const Color(0xffB2B1B1),
          fontSize: MediaQuery.of(context).size.width * 0.032,
        ),
        const SizedBox(
          height: 10,
        ),
        Builder(builder: (context) {
          if (loadingState == LoadingState.loading) {
            return CustomTextField(
              hintText: "....",
              readOnly: true,
              suffix: Builder(builder: (context) {
                if (loadingState == LoadingState.loading) {
                  return const SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const Icon(Icons.arrow_drop_down);
              }),
            );
          }
          return DropdownMenu<String>(
            initialSelection: list.first,
            expandedInsets: const EdgeInsets.all(0),
            onSelected: onSelected,
            enabled: loadingState == LoadingState.loading ? false : enabled,
            inputDecorationTheme:
                const InputDecorationTheme(border: UnderlineInputBorder()),
            trailingIcon: Builder(builder: (context) {
              if (loadingState == LoadingState.loading) {
                return const SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const Icon(Icons.arrow_drop_down);
            }),
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          );
        }),
      ],
    );
  }
}

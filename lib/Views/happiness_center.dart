import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class HappinessCenterPage extends StatelessWidget {
  const HappinessCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Happiness Center",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
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
              function: () {
                context.read<HappinessCenterCubit>().submitQuery(context);
              },
              icon: const Icon(
                Icons.telegram,
                color: kWhite,
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputDropDown(
                context,
                "Enquiry Type",
                enquiryTypeList,
                onSelected: (value) => context
                    .read<HappinessCenterCubit>()
                    .onChangeComplaintType(value),
              ),
              BlocBuilder<DropdownCommunitiesCubit, DropdownCommunitiesState>(
                builder: (context, state) {
                  return inputDropDown(
                      context,
                      "Comumnity",
                      (state.communitiesModel?.associations
                              ?.map((e) => e.name ?? "Not Provided")
                              .toList() ??
                          [])
                        ..insert(0, "Select"), onSelected: (value) {
                    int? index = state.communitiesModel?.associations
                        ?.indexWhere((element) => element.name == value);
                    if (index != null && index != -1) {
                      context.read<HappinessCenterCubit>().onChangeCommunityId(
                          state.communitiesModel?.associations?[index].id);
                      context.read<DropdownUnitsCubit>().getUnits(context,
                          state.communitiesModel?.associations?[index].id);
                    }
                  }, loadingState: state.loadingState);
                },
              ),
              BlocBuilder<DropdownUnitsCubit, DropdownUnitsState>(
                builder: (context, state) {
                  return inputDropDown(
                    context,
                    "Unit",
                    (state.unitsModel?.units
                            ?.map((e) => e.unitNumber ?? "")
                            .toList() ??
                        [])
                      ..insert(0, "Select"),
                    loadingState: state.loadingState,
                    onSelected: (value) {
                      int? index = state.unitsModel?.units?.indexWhere(
                          (element) => element.unitNumber == value);
                      if (index != null && index != -1) {
                        context.read<HappinessCenterCubit>().onChangeUnitId(
                            state.unitsModel?.units?[index].unitId);
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<HappinessCenterCubit, HappinessCenterState>(
                builder: (context, state) {
                  return Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.complaintType?.toLowerCase() == "complaint")
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<HappinessCenterCubit>()
                                        .onChangeRadioValue("Unit");
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(
                                            10,
                                          ),
                                          bottomLeft: Radius.circular(
                                            10,
                                          ),
                                        ),
                                        color: state.radioValue.toLowerCase() ==
                                                "unit"
                                            ? context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor
                                            : kGrey.shade200),
                                    child: CustomText(
                                      text: "Unit",
                                      color: state.radioValue.toLowerCase() ==
                                              "unit"
                                          ? kWhite
                                          : kBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<HappinessCenterCubit>()
                                        .onChangeRadioValue("Common area");
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(
                                            10,
                                          ),
                                          bottomRight: Radius.circular(
                                            10,
                                          ),
                                        ),
                                        color: state.radioValue.toLowerCase() ==
                                                "common area"
                                            ? context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor
                                            : kGrey.shade200),
                                    child: CustomText(
                                      text: "Common area",
                                      color: state.radioValue.toLowerCase() ==
                                              "common area"
                                          ? kWhite
                                          : kBlack,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Row(
                        //       children: <Widget>[
                        //         Radio(
                        //           value: 'Unit',
                        //           groupValue: state.radioValue,
                        //           onChanged: (value) {
                        //             context
                        //                 .read<HappinessCenterCubit>()
                        //                 .onChangeRadioValue(value);
                        //           },
                        //         ),
                        //          Text('Unit'),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: <Widget>[
                        //         Radio(
                        //           value: 'Common area',
                        //           groupValue: state.radioValue,
                        //           onChanged: (value) {
                        //             context
                        //                 .read<HappinessCenterCubit>()
                        //                 .onChangeRadioValue(value);
                        //           },
                        //         ),
                        //          Text('Common Area'),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        Builder(builder: (context) {
                          if (state.complaintType?.toLowerCase() !=
                              "complaint") {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: "Subject",
                                  fontWeight: FontWeight.bold,
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  initialValue: state.service,
                                  hintText: "Enter subject",
                                  fillColor: kGrey.shade200,
                                  onChanged: (value) => context
                                      .read<HappinessCenterCubit>()
                                      .onChangeService(value),
                                ),
                              ],
                            );
                          }
                          return inputDropDown(
                            context,
                            "Service",
                            state.radioValue.toLowerCase() == "unit"
                                ? ["Select", "Repair"]
                                : ["Select", "Cleaning"],
                            onSelected: (value) => context
                                .read<HappinessCenterCubit>()
                                .onChangeService(value),
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Complaints",
                          fontWeight: FontWeight.bold,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          fillColor: kGrey.shade200,
                          hintText: "Enter your complaint here",
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          onChanged: (value) => context
                              .read<HappinessCenterCubit>()
                              .onChangeMessage(value),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Attachment",
                          fontWeight: FontWeight.bold,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          width: MediaQuery.of(context).size.width / 2,
                          text: "Upload",
                          function: () async {
                            await FilePicker.platform.pickFiles(
                                allowedExtensions: [
                                  ".png",
                                  ".jpg",
                                  "jpeg",
                                  ".pdf",
                                  ".gif"
                                ],
                                allowMultiple: true,
                                type: FileType.custom).then((value) {
                              if (value != null) {
                                if (value.count > 3 ||
                                    (context
                                                .read<HappinessCenterCubit>()
                                                .state
                                                .fileList
                                                ?.length ??
                                            0) ==
                                        3) {
                                  return Fluttertoast.showToast(
                                      msg: "You can attach only three files");
                                }
                                context
                                    .read<HappinessCenterCubit>()
                                    .onChangeFiles(value.files
                                        .map((e) => File(e.path ?? ""))
                                        .toList());
                              }
                            });
                          },
                          textColor:
                              context.read<AppThemeCubit>().state.primaryColor,
                          invert: true,
                          icon: Icon(
                            Icons.upload_outlined,
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: state.fileList
                                  ?.map((e) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kGrey.shade200,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                text: e.path.split("/").last,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            const Gap(10),
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          HappinessCenterCubit>()
                                                      .removeFile(e);
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                      ))
                                  .toList() ??
                              [],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
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
          color: context.read<AppThemeCubit>().state.primaryColor,
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownMenu<String>(
          initialSelection: list.first,
          expandedInsets: const EdgeInsets.all(0),
          onSelected: onSelected,
          enabled: loadingState == LoadingState.loading ? false : enabled,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
            ),
          ),
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
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:iskaanowner/Blocs/Edit%20Compliance/edit_compliance_cubit.dart';
import 'package:iskaanowner/Models/compliances.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class EditCompliancePage extends StatefulWidget {
  const EditCompliancePage({super.key});

  @override
  State<EditCompliancePage> createState() => _EditCompliancePageState();
}

class _EditCompliancePageState extends State<EditCompliancePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int? unitId = arguments['unit_id'];
    Compliance? compliance = arguments['compliance'];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocBuilder<EditComplianceCubit, EditComplianceState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: state.loadingState == LoadingState.loading
                  ? const SizedBox(height: 50.0, child: CustomLoader())
                  : CustomButton(
                      text: "Save",
                      height: MediaQuery.of(context).size.width * 0.12,
                      function: () {
                        EditComplianceCubit editComplianceCubit =
                            context.read<EditComplianceCubit>();
                        if (editComplianceCubit.state.notApplicable == false) {
                          if (_formKey.currentState!.validate()) {
                            if (editComplianceCubit.state.customDateRange ==
                                null) {
                              Fluttertoast.showToast(
                                  msg: 'Please select date range to continue');
                              return;
                            }
                            if ((editComplianceCubit.state.file?.path.isEmpty ??
                                    true) &&
                                (editComplianceCubit
                                        .state.certificateUrl?.isEmpty ??
                                    true)) {
                              Fluttertoast.showToast(
                                  msg: 'Please select attachments to continue');
                              return;
                            }
                            editComplianceCubit.updateCompliance(
                              context,
                              id: compliance?.id ?? 0,
                              complianceAbleId: unitId ?? 0,
                            );
                          }
                        } else {
                          editComplianceCubit.updateCompliance(
                            context,
                            id: compliance?.id ?? 0,
                            complianceAbleId: unitId ?? 0,
                          );
                        }
                      },
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      buttonColor: context
                          .read<AppThemeCubit>()
                          .state
                          .primaryColor
                          .withOpacity(0.8),
                    ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: const DashboardPage().appBar(
                      context,
                      text: "Edit Compliance",
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Not Applicable?",
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffB2B1B1),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.032,
                                  ),
                                  const Gap(10),
                                  Switch.adaptive(
                                    value: state.notApplicable,
                                    onChanged: (value) {
                                      if (state.loadingState ==
                                          LoadingState.loading) {
                                        return;
                                      }
                                      context
                                          .read<EditComplianceCubit>()
                                          .onChangeNotApplicable(value);
                                    },
                                  ),
                                ],
                              ),
                              const Gap(10),
                              CustomText(
                                text: "Name*",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffB2B1B1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                              const Gap(10),
                              CustomTextField(
                                readOnly: true,
                                hintText: "Enter your certificate name",
                                initialValue: state.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a Name";
                                  }
                                  return null;
                                },
                                onChanged: (value) => context
                                    .read<EditComplianceCubit>()
                                    .onChangeName(value),
                              ),
                              const Gap(10),
                              CustomText(
                                text: "Date and Expiry*",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffB2B1B1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                              const Gap(10),
                              CustomTextField(
                                hintText: state.customDateRange == null
                                    ? "Select a validity date range"
                                    : "${const OccupantPage().dateTimeFormatter(state.customDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.customDateRange?.end)}",
                                readOnly: true,
                                onTap: state.notApplicable
                                    ? null
                                    : () {
                                        if (state.loadingState ==
                                            LoadingState.loading) {
                                          return;
                                        }
                                        showDateRangePicker(
                                          context: context,
                                          firstDate: DateTime(1900, 01, 01),
                                          lastDate: DateTime(
                                              DateTime.now().year, 12, 31),
                                          currentDate: DateTime.now(),
                                        ).then(
                                          (value) => context
                                              .read<EditComplianceCubit>()
                                              .onChangeCustomDateRange(value),
                                        );
                                      },
                              ),
                              const Gap(10),
                              CustomText(
                                text: "Description*",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffB2B1B1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                              const Gap(10),
                              CustomTextField(
                                readOnly:
                                    state.loadingState == LoadingState.loading
                                        ? true
                                        : state.notApplicable,
                                hintText: "Enter your description here",
                                initialValue: state.description,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your Description";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                onChanged: (value) => context
                                    .read<EditComplianceCubit>()
                                    .onChangeDescription(value),
                              ),
                              const Gap(10),
                              CustomText(
                                text: "Attachments*",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffB2B1B1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                  width: MediaQuery.of(context).size.width / 2,
                                  text: "Upload",
                                  function: state.notApplicable
                                      ? null
                                      : () async {
                                          if (state.loadingState ==
                                              LoadingState.loading) {
                                            return;
                                          }
                                          await FilePicker.platform
                                              .pickFiles(allowedExtensions: [
                                            ".png",
                                            ".jpg",
                                            "jpeg",
                                            ".pdf",
                                            ".gif"
                                          ], type: FileType.custom).then(
                                                  (value) {
                                            if (value != null) {
                                              context
                                                  .read<EditComplianceCubit>()
                                                  .onChangeFile(File(
                                                      value.files.first.path ??
                                                          ""));
                                            }
                                          });
                                        },
                                  textColor: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                  invert: true,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  icon: Image.asset(
                                    "assets/upload.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              state.file != null
                                  ? _fileWidget(
                                      title: state.file!.path.split("/").last,
                                      onClosePressed: state.notApplicable
                                          ? null
                                          : () {
                                              if (state.loadingState ==
                                                  LoadingState.loading) {
                                                return;
                                              }
                                              context
                                                  .read<EditComplianceCubit>()
                                                  .removeFile();
                                            },
                                    )
                                  : (state.certificateUrl?.isNotEmpty ?? false)
                                      ? _fileWidget(
                                          title: state.certificateUrl ?? '',
                                          onClosePressed: null)
                                      : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _fileWidget({
    required String title,
    required void Function()? onClosePressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kGrey.shade200,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text: title,
              textAlign: TextAlign.left,
            ),
          ),
          if (onClosePressed != null) const Gap(10),
          if (onClosePressed != null)
            IconButton(
              onPressed: onClosePressed,
              icon: const Icon(Icons.close),
            )
        ],
      ),
    );
  }
}

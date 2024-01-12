import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:iskaanowner/Blocs/Edit%20Compliance/edit_compliance_cubit.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class EditCompliancePage extends StatelessWidget {
  const EditCompliancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
          text: "Save",
          height: MediaQuery.of(context).size.width * 0.12,
          function: () {},
          fontSize: MediaQuery.of(context).size.width * 0.035,
          buttonColor:
              context.read<AppThemeCubit>().state.primaryColor.withOpacity(0.8),
        ),
      ),
      body:
          SafeArea(child: BlocBuilder<EditComplianceCubit, EditComplianceState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: const DashboardPage().appBar(
                  context,
                  text: "Edit Compliance",
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: kWhite),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Not Applicable?*",
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffB2B1B1),
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                          ),
                          const Gap(10),
                          Switch.adaptive(
                              value: state.applicable,
                              onChanged: (value) {
                                context
                                    .read<EditComplianceCubit>()
                                    .onChangeApplicable(value);
                              })
                        ],
                      ),
                      const Gap(10),
                      CustomText(
                        text: "Name*",
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffB2B1B1),
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                      ),
                      const Gap(10),
                      CustomTextField(
                        hintText: "Enter your certificate name",
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
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                      ),
                      const Gap(10),
                      CustomTextField(
                        hintText: state.customDateRange == null
                            ? "Select a validity date range"
                            : "${const OccupantPage().dateTimeFormatter(state.customDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.customDateRange?.end)}",
                        readOnly: true,
                        onTap: () => showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1900, 01, 01),
                          lastDate: DateTime(DateTime.now().year, 12, 31),
                          currentDate: DateTime.now(),
                        ).then(
                          (value) => context
                              .read<EditComplianceCubit>()
                              .onChangeCustomDateRange(value),
                        ),
                      ),
                      const Gap(10),
                      CustomText(
                        text: "Description*",
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffB2B1B1),
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                      ),
                      const Gap(10),
                      CustomTextField(
                        hintText: "Enter your description here",
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
                        text: "Attachments",
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffB2B1B1),
                        fontSize: MediaQuery.of(context).size.width * 0.032,
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
                                type: FileType.custom).then((value) {
                              if (value != null) {
                                context
                                    .read<EditComplianceCubit>()
                                    .onChangeFile(
                                        File(value.files.first.path ?? ""));
                              }
                            });
                          },
                          textColor:
                              context.read<AppThemeCubit>().state.primaryColor,
                          invert: true,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          icon: Image.asset(
                            "assets/upload.png",
                            width: MediaQuery.of(context).size.width * 0.05,
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state.file != null)
                        Container(
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
                                  text: state.file!.path.split("/").last,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<EditComplianceCubit>()
                                        .removeFile();
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ))
            ],
          );
        },
      )),
    );
  }
}

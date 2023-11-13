import 'package:iskaanowner/Blocs/Dropdown%20Communities/dropdown_communities_cubit.dart';
import 'package:iskaanowner/Blocs/Dropdown%20Units/dropdown_units_cubit.dart';
import 'package:iskaanowner/Blocs/Happiness%20Center/happiness_center_cubit.dart';
import 'package:iskaanowner/Blocs/Verify%20Email%20/verify_email_cubit.dart';

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
        child: CustomButton(
          text: "Submit",
          function: () {},
          icon: const Icon(
            Icons.telegram,
            color: kWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputDropDown(
                "Enquiry Type",
                enquiryTypeList,
                onSelected: (value) => context
                    .read<HappinessCenterCubit>()
                    .onChangeComplaintType(value),
              ),
              BlocBuilder<DropdownCommunitiesCubit, DropdownCommunitiesState>(
                builder: (context, state) {
                  return inputDropDown(
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
              inputDropDown("Requestor", ["Owner"], enabled: false),
              BlocBuilder<DropdownUnitsCubit, DropdownUnitsState>(
                builder: (context, state) {
                  return inputDropDown(
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
              const CustomText(
                text: "Email",
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                suffix: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                  builder: (context, state) {
                    if (state.loadingState == LoadingState.loading) {
                      return SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return CustomButton(
                      text: "Verify",
                      function: () {
                        context.read<VerifyEmailCubit>().verifyUser(
                            context,
                            context.read<HappinessCenterCubit>().state.unitId,
                            context.read<HappinessCenterCubit>().state.email);
                      },
                      width: MediaQuery.of(context).size.width * 0.2,
                    );
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                fillColor: kGrey.shade200,
                hintText: "Enter your email address",
                onChanged: (email) =>
                    context.read<HappinessCenterCubit>().onChangeEmail(email),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<HappinessCenterCubit, HappinessCenterState>(
                builder: (context, state) {
                  if (state.verifiedUser) {
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 'unit',
                                      groupValue: state.radioValue,
                                      onChanged: (value) {
                                        context
                                            .read<HappinessCenterCubit>()
                                            .onChangeRadioValue(value);
                                      },
                                    ),
                                    const Text('Unit'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 'common area',
                                      groupValue: state.radioValue,
                                      onChanged: (value) {
                                        context
                                            .read<HappinessCenterCubit>()
                                            .onChangeRadioValue(value);
                                      },
                                    ),
                                    const Text('Common Area'),
                                  ],
                                ),
                              ],
                            ),
                          inputDropDown(
                            "Service",
                            state.radioValue.toLowerCase() == "unit"
                                ? ["Select", "Repair"]
                                : ["Select", "Cleaning"],
                            onSelected: (value) => context
                                .read<HappinessCenterCubit>()
                                .onChangeService(value),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            text: "Complaints",
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                          const CustomText(
                            text: "Attachment",
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            width: MediaQuery.of(context).size.width / 2,
                            text: "Upload",
                            function: () {},
                            textColor: primaryColor,
                            invert: true,
                            icon: const Icon(
                              Icons.upload_outlined,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputDropDown(
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
          color: primaryColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: DropdownMenu<String>(
                initialSelection: list.first,
                onSelected: onSelected,
                enabled: loadingState == LoadingState.loading ? false : enabled,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: primaryColor,
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
            ),
          ],
        ),
      ],
    );
  }
}

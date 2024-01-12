import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';
import 'package:iskaanowner/Widgets/image_builder.dart';

class CompanySelectionWidget extends StatelessWidget {
  final bool isSelected;
  final String? title;
  final String? description;
  final String? profilePictureUrl;
  final VoidCallback? onTap;
  const CompanySelectionWidget({
    super.key,
    this.isSelected = false,
    this.title,
    this.description,
    this.profilePictureUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print(profilePictureUrl);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(bottom: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: kWhite),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ImageBuilder(
                url: profilePictureUrl ?? "",
                isFit: true,
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(5),
                  CustomText(
                    text: title ?? '',
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                  CustomText(
                    text: 'Account Managed By',
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB2B1B1),
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                  const Gap(10),
                  CustomText(
                    text: description ?? '',
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB2B1B1),
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const Gap(5),
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    width: 1),
              ),
              child: Checkbox(
                value: isSelected,
                fillColor: const MaterialStatePropertyAll(kTransparent),
                checkColor: context.read<AppThemeCubit>().state.primaryColor,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide.none),
                onChanged: (value) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

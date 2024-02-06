import 'package:iskaanowner/Utils/utils.dart';

class ImageBuilder extends StatelessWidget {
  final double? width;
  final double? height;
  final String? url;
  final bool? isFit;
  const ImageBuilder({
    this.height,
    this.width,
    this.url,
    this.isFit = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return errorImage();
    }
    return FadeInImage(
      width: width,
      height: height,
      placeholder: const AssetImage('assets/loader.gif'),
      image: NetworkImage(url ?? ""),
      imageErrorBuilder: (context, error, stackTrace) => errorImage(),
      placeholderFit: BoxFit.contain,
      fit: (isFit ?? false)
          ? BoxFit.contain
          : (url?.isNotEmpty ?? false)
              ? BoxFit.cover
              : BoxFit.contain,
    );
  }

  Widget errorImage() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: kGrey.shade200),
      width: width,
      height: height,
      child: Center(
        child: Image.asset(
          'assets/placeHolder.png',
          width: width != null && width != 0 ? (width ?? 0) / 2 : null,
          height: height != null && height != 0 ? (height ?? 0) / 2 : null,
          fit: BoxFit.contain,
          color: kGrey.shade300,
        ),
      ),
    );
  }
}

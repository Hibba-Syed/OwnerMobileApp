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
    return FadeInImage(
        width: width,
        height: height,
        placeholder: const AssetImage('assets/loader.gif'),
        image: const AssetImage('assets/placeHolder.png'),
        placeholderFit: BoxFit.contain,
        fit: BoxFit.contain);
  }
}

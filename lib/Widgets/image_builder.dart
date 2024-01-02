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
    return FadeInImage(
      width: width,
      height: height,
      placeholder: const AssetImage('assets/placeHolder.png'),
      image: (url?.isEmpty ?? true)
          ? const AssetImage('assets/placeHolder.png')
          : NetworkImage(url ?? "") as ImageProvider,
      placeholderFit: BoxFit.contain,
      fit: (isFit ?? false)
          ? BoxFit.contain
          : (url?.isNotEmpty ?? false)
              ? BoxFit.cover
              : BoxFit.contain,
    );
  }
}

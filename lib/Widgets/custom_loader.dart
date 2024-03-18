import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';

class CustomLoader extends StatelessWidget {
  final double width;
  final bool applyCenter;
  final Color? color;
  const CustomLoader(
      {Key? key, this.width = 100, this.applyCenter = true, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (applyCenter) {
      return Center(
          child: CircularProgressIndicator(
        color: color ?? context.read<AppThemeCubit>().state.primaryColor,
      ));
    }
    return CircularProgressIndicator(
      color: color ?? context.read<AppThemeCubit>().state.primaryColor,
    );
  }
}

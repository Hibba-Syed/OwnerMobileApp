import '../Utils/utils.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? backArrowColor;
  final String title;
  final AppBar appBar;
  final bool automaticallyImplyLeading, centerTitle;
  final List<Widget> widgets;
  final double appBarHeight;
  final Widget? leading;
  final Color titleColor;
  final double? elevation;
  final double? fontSize;
  final PreferredSizeWidget? bottom;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      required this.widgets,
      this.automaticallyImplyLeading = false,
      this.backgroundColor,
      this.backArrowColor,
      this.centerTitle = true,
      required this.appBarHeight,
      this.titleColor = primaryColor,
      this.bottom,
      this.elevation,
      this.fontSize,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? primaryColor.withOpacity(0.1),
      elevation: elevation,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      leading: automaticallyImplyLeading == false
          ? null
          : leading ??
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: backArrowColor ?? primaryColor,
                  )),
      actions: widgets,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

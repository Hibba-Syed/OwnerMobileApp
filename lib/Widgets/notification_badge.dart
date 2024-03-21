import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.read<AppThemeCubit>().state.primaryColor),
      padding: const EdgeInsets.all(6),
    );
  }
}
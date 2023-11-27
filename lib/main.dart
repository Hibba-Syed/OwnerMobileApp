import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Notification/firebase_service.dart';

import 'Utils/utils.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.notification?.title}");
    print("Handling a background message: ${message.notification?.body}");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Global.init();
  await FirebaseNotificationService().getPermissions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Iskaan Owner',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: context.watch<AppThemeCubit>().state.primaryColor),
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          onGenerateRoute: AppPages.generateRouteSettings,
        );
      }),
    );
  }
}

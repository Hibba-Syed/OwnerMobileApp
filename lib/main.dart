import 'package:firebase_core/firebase_core.dart';

import 'Utils/utils.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: MaterialApp(
        title: 'Iskaan Owner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        onGenerateRoute: AppPages.generateRouteSettings,
      ),
    );
  }
}

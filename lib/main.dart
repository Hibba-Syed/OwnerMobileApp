import 'Utils/utils.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: 
      MaterialApp(
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

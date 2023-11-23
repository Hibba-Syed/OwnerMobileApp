import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';
import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';
import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';
import 'package:iskaanowner/Blocs/Send%20OTP/send_otp_cubit.dart';
import 'package:iskaanowner/Blocs/Unit%20Financials/unit_financials_cubit.dart';

import '../Utils/utils.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.splash,
        page: const SplashPage(),
      ),
      PageEntity(
          route: AppRoutes.authorization,
          page: const AuthenticationPage(),
          bloc: BlocProvider(
            create: (context) => AuthenticationCubit(),
          )),
      PageEntity(
        route: AppRoutes.login,
        page: const LoginPage(),
        bloc: BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ),
      PageEntity(
          route: AppRoutes.dashboard,
          page: const DashboardPage(),
          bloc: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DownloadSummaryCubit(),
              ),
              BlocProvider(
                create: (context) => CommunitiesCubit(),
              ),
              BlocProvider(
                create: (context) => SendOtpCubit(),
              ),
            ],
            child: Container(),
          )),
      PageEntity(
          route: AppRoutes.units,
          page: const UnitsPage(),
          bloc: BlocProvider(
            create: (context) => UnitsCubit(),
          )),
      PageEntity(
        route: AppRoutes.unitDetails,
        page: const UnitDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.owners,
        page: const OwnersPage(),
        bloc: BlocProvider(
          create: (context) => OwnersCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.occupant,
        page: const OccupantPage(),
        bloc: BlocProvider(
          create: (context) => OccupantCubit(),
        ),
      ),
      PageEntity(
          route: AppRoutes.requests,
          page: const RequestsPage(),
          bloc: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RequestsCubit(),
              ),
              BlocProvider(
                create: (context) => RequestsFiltersCubit(),
              ),
            ],
            child: const RequestsPage(),
          )),
      PageEntity(
          route: AppRoutes.requestDetails,
          page: const RequestDetailPage(),
          bloc: BlocProvider(
            create: (context) => RequestDetailsCubit(),
          )),
      PageEntity(
          route: AppRoutes.compliances,
          page: const CompliancesPage(),
          bloc: BlocProvider(
            create: (context) => CompliancesCubit(),
          )),
      PageEntity(
          route: AppRoutes.happinessCenter,
          page: const HappinessCenterPage(),
          bloc: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DropdownCommunitiesCubit(),
              ),
              BlocProvider(
                create: (context) => DropdownUnitsCubit(),
              ),
              BlocProvider(
                create: (context) => VerifyEmailCubit(),
              ),
              BlocProvider(
                create: (context) => HappinessCenterCubit(),
              ),
            ],
            child: const HappinessCenterPage(),
          )),
      PageEntity(
          route: AppRoutes.changePassword,
          page: const ChangePasswordPage(),
          bloc: BlocProvider(
            create: (context) => ChangePasswordCubit(),
          )),
      PageEntity(
          route: AppRoutes.notifications,
          page: const NotificationsPage(),
          bloc: BlocProvider(
            create: (context) => NotificationsCubit(),
          )),
      PageEntity(
          route: AppRoutes.unitFinancial,
          page: const UnitFinancialPage(),
          bloc: BlocProvider(
            create: (context) => UnitFinancialsCubit(),
          )),
      PageEntity(
          route: AppRoutes.sharedDocument,
          page: const SharedDocumentPage(),
          bloc: BlocProvider(
            create: (context) => SharedDocumentsCubit(),
          )),
      PageEntity(
          route: AppRoutes.ledger,
          page: const LedgerPage(),
          bloc: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LedgerTypesCubit(),
              ),
              BlocProvider(
                create: (context) => LedgerCubit(),
              ),
              BlocProvider(
                create: (context) => DownloadLedgerCubit(),
              ),
            ],
            child: const LedgerPage(),
          )),
      PageEntity(
        route: AppRoutes.creditNotes,
        page: const CreditNotesPage(),
        bloc: BlocProvider(
          create: (context) => CreditNotesCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.creditNoteDetails,
        page: const CreditNoteDetailsPage(),
        bloc: BlocProvider(create: (context) => CreditNoteDetailsCubit()),
      ),
      PageEntity(
        route: AppRoutes.receipts,
        page: const ReceiptsPage(),
        bloc: BlocProvider(
          create: (context) => ReceiptsCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.invoices,
        page: const InvoicesPage(),
        bloc: BlocProvider(
          create: (context) => InvoicesCubit(),
        ),
      ),
      PageEntity(
          route: AppRoutes.invoiceDetails,
          page: const InvoiceDetailsPage(),
          bloc: BlocProvider(
            create: (context) => InvoiceDetailsCubit(),
          )),
      PageEntity(
          route: AppRoutes.receiptDetails,
          page: const ReceiptDetailsPage(),
          bloc: BlocProvider(
            create: (context) => ReceiptDetailsCubit(),
          )),
      PageEntity(
        route: AppRoutes.profile,
        page: const ProfilePage(),
        bloc: BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = [];
    for (var element in routes()) {
      if (element.bloc != null) {
        blocProviders.add(element.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (context) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (context) => const SplashPage(), settings: settings);
  }
}

class PageEntity {
  final String route;
  final Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}

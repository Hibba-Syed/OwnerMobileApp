import 'package:iskaanowner/Blocs/Authentication/authentication_cubit.dart';
import 'package:iskaanowner/Blocs/Change%20Password/change_password_cubit.dart';
import 'package:iskaanowner/Blocs/Communities/comunities_cubit.dart';
import 'package:iskaanowner/Blocs/Compliances/compliances_cubit.dart';
import 'package:iskaanowner/Blocs/Credit%20Notes/credit_notes_cubit.dart';
import 'package:iskaanowner/Blocs/Download%20Ledger/download_ledger_cubit.dart';
import 'package:iskaanowner/Blocs/Download%20Summary/download_summary_cubit.dart';
import 'package:iskaanowner/Blocs/Dropdown%20Communities/dropdown_communities_cubit.dart';
import 'package:iskaanowner/Blocs/Dropdown%20Units/dropdown_units_cubit.dart';
import 'package:iskaanowner/Blocs/Happiness%20Center/happiness_center_cubit.dart';
import 'package:iskaanowner/Blocs/Invoices/invoices_cubit.dart';
import 'package:iskaanowner/Blocs/Ledger%20Types/ledger_types_cubit.dart';
import 'package:iskaanowner/Blocs/Ledger/ledger_cubit.dart';
import 'package:iskaanowner/Blocs/Occupant/occupant_cubit.dart';
import 'package:iskaanowner/Blocs/Owners/owners_cubit.dart';
import 'package:iskaanowner/Blocs/Profile/profile_cubit.dart';
import 'package:iskaanowner/Blocs/Receipts/receipts_cubit.dart';
import 'package:iskaanowner/Blocs/Request%20Details/request_details_cubit.dart';
import 'package:iskaanowner/Blocs/Request%20Filters/request_filters_cubit.dart';
import 'package:iskaanowner/Blocs/Requests/requests_cubit.dart';
import 'package:iskaanowner/Blocs/Shared%20Documents/shared_documnets_cubit.dart';
import 'package:iskaanowner/Blocs/Units/units_cubit.dart';
import 'package:iskaanowner/Blocs/Verify%20Email%20/verify_email_cubit.dart';
import 'package:iskaanowner/Views/authentication.dart';
import 'package:iskaanowner/Views/change_password.dart';
import 'package:iskaanowner/Views/credit_notes.dart';
import 'package:iskaanowner/Views/invoices.dart';
import 'package:iskaanowner/Views/ledger.dart';
import 'package:iskaanowner/Views/notifications.dart';
import 'package:iskaanowner/Views/receipts.dart';
import 'package:iskaanowner/Views/request_detail.dart';
import 'package:iskaanowner/Views/shared_documnet.dart';
import 'package:iskaanowner/Views/splash.dart';
import 'package:iskaanowner/Views/unit_financial.dart';

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
      ),
      PageEntity(
        route: AppRoutes.unitFinancial,
        page: const UnitFinancialPage(),
      ),
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

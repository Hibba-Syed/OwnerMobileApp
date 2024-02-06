import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Blocs/Companies/companies_cubit.dart';
import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';
import 'package:iskaanowner/Blocs/Edit%20Compliance/edit_compliance_cubit.dart';
import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';
import 'package:iskaanowner/Blocs/Logout/logout_cubit.dart';
import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Blocs/Primary%20Owner%20Activity/primary_owner_activity_cubit.dart';
import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';
import 'package:iskaanowner/Blocs/Reset%20Password/reset_password_cubit.dart';
import 'package:iskaanowner/Blocs/Send%20OTP/send_otp_cubit.dart';
import 'package:iskaanowner/Blocs/Unit%20Financials/unit_financials_cubit.dart';
import 'package:iskaanowner/Blocs/Verify%20Otp/verify_otp_cubit.dart';
import 'package:iskaanowner/Views/Auth/forgot_password.dart';
import 'package:iskaanowner/Views/Auth/otp_verification.dart';
import 'package:iskaanowner/Views/Auth/reset_password.dart';
import 'package:iskaanowner/Views/Compliances/edit_compliance.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';
import 'package:iskaanowner/Views/Requests/details/cs_details.dart';
import 'package:iskaanowner/Views/Requests/details/dp_details.dart';
import 'package:iskaanowner/Views/Requests/details/fo_details.dart';
import 'package:iskaanowner/Views/Requests/details/hb_details.dart';
import 'package:iskaanowner/Views/Requests/details/mi_details.dart';
import 'package:iskaanowner/Views/Requests/details/ri_details.dart';
import 'package:iskaanowner/Views/Requests/details/ss_details.dart';
import 'package:iskaanowner/Views/Requests/details/tp_details.dart';
import 'package:iskaanowner/Views/Requests/details/wp_details.dart';
import 'package:iskaanowner/Views/companies.dart';
import 'package:iskaanowner/Views/ledger/ledger_by_account_details.dart';
import 'package:iskaanowner/Views/verify_documents.dart';
import 'package:iskaanowner/Views/web_view.dart';

import '../Blocs/Compliance Details/compliance_details_cubit.dart';
import '../Utils/utils.dart';
import '../Views/Compliances/compliance_details.dart';
import '../Views/Requests/details/mo_details.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.splash,
          page: const SplashPage(),
          bloc: BlocProvider(create: (context) => AppThemeCubit())),
      PageEntity(
          route: AppRoutes.authorization,
          page: const AuthenticationPage(),
          bloc: BlocProvider(
            create: (context) => AuthenticationCubit(),
          )),
      PageEntity(
        route: AppRoutes.companies,
        page: const CompaniesPage(),
      ),
      PageEntity(
        route: AppRoutes.myWebView,
        page: const MyWebView(),
      ),
      PageEntity(
        route: AppRoutes.login,
        page: LoginPage(),
        bloc: BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.otpVerification,
        page: const OtpVerificationPage(),
        bloc: BlocProvider(
          create: (context) => VerifyOtpCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.resetPassword,
        page: ResetPasswordPage(),
        bloc: BlocProvider(
          create: (context) => ResetPasswordCubit(),
        ),
      ),
      PageEntity(
          route: AppRoutes.dashboard,
          page: const DashboardPage(),
          bloc: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CompaniesCubit(),
              ),
              BlocProvider(
                create: (context) => DownloadSummaryCubit(),
              ),
              BlocProvider(
                create: (context) => CommunitiesCubit(),
              ),
              BlocProvider(
                create: (context) => SendOtpCubit(),
              ),
              BlocProvider(
                create: (context) => LogoutCubit(),
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
        bloc: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OwnersCubit(),
            ),
            BlocProvider(
              create: (context) => PrimaryOwnerActivityCubit(),
            ),
          ],
          child: const OwnersPage(),
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
              BlocProvider(
                create: (context) => RequestDetailsCubit(),
              ),
            ],
            child: const RequestsPage(),
          )),
      PageEntity(
        route: AppRoutes.adDetails,
        page: const AdDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.foDetails,
        page: const FoDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.riDetails,
        page: const RiDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.wpDetails,
        page: const WpDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.ssDetails,
        page: const SsDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.csDetails,
        page: const CsDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.hbDetails,
        page: const HbDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.moDetails,
        page: const MoDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.dpDetails,
        page: const DpDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.tpDetails,
        page: const TpDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.miDetails,
        page: const MiDetailsPage(),
      ),
      PageEntity(
        route: AppRoutes.compliances,
        page: const CompliancesPage(),
        bloc: BlocProvider(
          create: (context) => CompliancesCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.complianceDetails,
        page: const ComplianceDetailsPage(),
        bloc: BlocProvider(
          create: (context) => ComplianceDetailsCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.editCompliances,
        page: const EditCompliancePage(),
        bloc: BlocProvider(
          create: (context) => EditComplianceCubit(),
        ),
      ),
      PageEntity(
          route: AppRoutes.happinessCenter,
          page: HappinessCenterPage(),
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
            child: HappinessCenterPage(),
          )),
      PageEntity(
        route: AppRoutes.forgotPassword,
        page: ForgotPasswordPage(),
      ),
      PageEntity(
        route: AppRoutes.verifyDocuments,
        page: const VerifyDocumentsPage(),
      ),
      PageEntity(
          route: AppRoutes.changePassword,
          page: ChangePasswordPage(),
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
        route: AppRoutes.ledgerByAccountDetail,
        page: const LedgerByAccountDetailsPage(),
      ),
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

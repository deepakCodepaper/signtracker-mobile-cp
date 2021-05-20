import 'package:flutter/material.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/help/help_page.dart';
import 'package:signtracker/feature/landing/landing_page.dart';
import 'package:signtracker/feature/login/login_page.dart';
import 'package:signtracker/feature/members/invite_members.dart';
import 'package:signtracker/feature/project/adjust_settings/adjust_settings_page.dart';
import 'package:signtracker/feature/project/create/choose_template2_page.dart';
import 'package:signtracker/feature/project/create/choose_template_page.dart';
import 'package:signtracker/feature/project/create/create_project_page.dart';
import 'package:signtracker/feature/project/create/new_project_page.dart';
import 'package:signtracker/feature/register/register_page.dart';
import 'package:signtracker/feature/sign_library/sign_library_template_page.dart';
import 'package:signtracker/feature/template/template_parameters_page.dart';
import 'package:signtracker/feature/project/email_recipients/email_recipient_views.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/feature/project/logs/project_logs_page.dart';
import 'package:signtracker/feature/project/save/save_project_page.dart';
import 'package:signtracker/feature/project/signs/sign_traffic_page.dart';
import 'package:signtracker/feature/project/signs/update_signs_dialog.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/feature/sign_library/add_sign_library_page.dart';
import 'package:signtracker/feature/sign_library/sign_library_page.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/project/signs/add_signs_page.dart';
import 'package:signtracker/feature/project/signs/sign_list_page.dart';
import 'package:signtracker/feature/project/create/template_page.dart';
import 'package:signtracker/feature/project/upload/upload_project_page.dart';
import 'package:signtracker/feature/splash/splash_page.dart';
import 'package:signtracker/feature/sub_project/create_sub_project.dart';
import 'package:signtracker/feature/sub_project/create_sub_project_confirmation.dart';
import 'package:signtracker/feature/template/template_list_item_page.dart';
import 'package:signtracker/feature/template/template_list_page.dart';
import 'package:signtracker/feature/template/template_plan_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.route:
        final args = settings.arguments as SplashPageArgs;
        return MaterialPageRoute(
            settings: RouteSettings(name: SplashPage.route),
            builder: (_) => SplashPage(isLoggedIn: args.isLoggedIn));
      case LoginPage.route:
        return MaterialPageRoute(
            settings: RouteSettings(name: LoginPage.route),
            builder: (_) => LoginPage());
      case RegisterPage.route:
        return MaterialPageRoute(
            settings: RouteSettings(name: LoginPage.route),
            builder: (_) => RegisterPage());
      case DashboardPage.route:
        return MaterialPageRoute(
            settings: RouteSettings(name: DashboardPage.route),
            builder: (_) => DashboardPage());
      case NewProjectPage.route:
        return MaterialPageRoute(
            settings: RouteSettings(name: NewProjectPage.route),
            builder: (_) => NewProjectPage());
      case ChooseTemplatePage.route:
        return MaterialPageRoute(builder: (_) => ChooseTemplatePage());
      case TemplatePage.route:
        final args = settings.arguments as TemplatePageArgs;
        return MaterialPageRoute(
            builder: (_) => TemplatePage(title: args.title));
      case InitializeProjectPage.route:
        final args = settings.arguments as InitializeProjectArgs;
        return MaterialPageRoute(
          builder: (_) => InitializeProjectPage(),
        );
      case InviteMembersPage.route:
        final args = settings.arguments as InviteMemberPageArgs;
        return MaterialPageRoute<List<int>>(
          builder: (_) => InviteMembersPage(projectId: args.projectId),
        );
      case CreateSubProjectPage.route:
        final args = settings.arguments as CreateSubProjectPageArgs;
        return MaterialPageRoute(
          builder: (_) =>
              CreateSubProjectPage(parentProject: args.parentProject),
        );
      case CreateSubProjectPageConfirmation.route:
        final args = settings.arguments as CreateSubProjectPageConfirmationArgs;
        return MaterialPageRoute(
          builder: (_) => CreateSubProjectPageConfirmation(
            project: args.project,
            mainProject: args.project,
          ),
        );
      case UploadProjectPage.route:
        return MaterialPageRoute(builder: (_) => UploadProjectPage());
      case ProjectMapPage.route:
        final args = settings.arguments as ProjectMapPageArgs;
        return MaterialPageRoute(
          builder: (_) => ProjectMapPage(
            imagePlan: args.imagePlan,
            project: args.project,
            shouldReturnToDashboard: args.shouldReturnToDashboard,
            checkSigns: args.checkSigns,
            addRemoveSigns: args.addRemoveSigns,
            editSigns: args.editSigns,
          ),
        );
      case AddSignsPage.route:
        final args = settings.arguments as AddSignsPageArgs;
        return MaterialPageRoute<dynamic>(
          builder: (_) => AddSignsPage(
            projectId: args.projectId,
            signSelected: args.signSelected,
            latitude: args.latitude,
            longitude: args.longitude,
            withTraffic: args.withTraffic,
            project: args.project,
            signFilePath: args.signFilePath,
            directory: args.directory,
          ),
        );
      case SignLibraryPage.route:
        return MaterialPageRoute(builder: (_) => SignLibraryPage());
      case SignLibraryTemplatePage.route:
        final args = settings.arguments as SignLibraryTemplatePageArgs;
        return MaterialPageRoute(
            builder: (_) => SignLibraryTemplatePage(
                project: args.project, method: args.method));
      case AddSignLibraryPage.route:
        final args = settings.arguments as AddSignLibraryArguments;
        return MaterialPageRoute<dynamic>(
            builder: (_) => AddSignLibraryPage(sign: args.sign));
      case SignListPage.route:
        final args = settings.arguments as SignListPageArgs;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignListPage(
            projectId: args.projectId,
            userLocation: args.userLocation,
            withTraffic: args.withTraffic,
            project: args.project,
          ),
        );
      case CheckSignsPage.route:
        final args = settings.arguments as CheckSignsPageArgs;
        return MaterialPageRoute(
            builder: (_) => CheckSignsPage(args.isFromNotification));
      case HelpPage.route:
        return MaterialPageRoute(builder: (_) => HelpPage());
      case SaveProjectPage.route:
        final args = settings.arguments as SaveProjectPageArgs;
        return MaterialPageRoute<bool>(
            builder: (_) => SaveProjectPage(
                  project: args.project,
                  returnToDashboard: args.returnToDashboard,
                ));
      case AdjustSettingsPage.route:
        final args = settings.arguments as AdjustSettingsPageArgs;
        return MaterialPageRoute<dynamic>(
            builder: (_) => AdjustSettingsPage(args.project, args.initial));
      case TrafficPage.route:
        final args = settings.arguments as TrafficPageArgs;
        return MaterialPageRoute<dynamic>(
          builder: (_) => TrafficPage(
            projectId: args.projectId,
            userLocation: args.userLocation,
            project: args.project,
          ),
        );
      case ProjectListPage.route:
        final args = settings.arguments as ProjectListPageArgs;
        return MaterialPageRoute(
          builder: (_) => ProjectListPage(
            projectId: args.projectId,
          ),
        );
      case OpenProjectPage.route:
        final args = settings.arguments as OpenProjectPageArgs;
        return MaterialPageRoute(
          builder: (_) => OpenProjectPage(args.project, args.fromAddingSign),
        );
      case ProjectLogsPage.route:
        final args = settings.arguments as ProjectLogsArgs;
        return MaterialPageRoute<bool>(
            builder: (_) => ProjectLogsPage(project: args.project));
      case LandingPage.route:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case FeaturesMultiPopup.route:
        return MaterialPageRoute(builder: (_) => FeaturesMultiPopup());
      case CreateProjectPage.route:
        return MaterialPageRoute(builder: (_) => CreateProjectPage());
      case ChooseTemplate2Page.route:
        return MaterialPageRoute(builder: (_) => ChooseTemplate2Page());
      case TemplateParametersPage.route:
        final args = settings.arguments as TemplateParametersPageArgs;
        return MaterialPageRoute(
            builder: (_) => TemplateParametersPage(args.project, args.page));
      case TemplatePlanListPage.route:
        final args = settings.arguments as TemplateListPageArgs;
        return MaterialPageRoute(
            builder: (_) => TemplatePlanListPage(args.project, args.templates,
                args.isLoadMyTemplates, args.page));
      case TemplatePlanListItemViewPage.route:
        final args = settings.arguments as TemplateListArgs;
        return MaterialPageRoute(
            builder: (_) => TemplatePlanListItemViewPage(
                args.signProject, args.selectedTemplate, args.page));
      case EmailRecipientPage.route:
        final args = settings.arguments as AddEmailRecipientArgs;
        return MaterialPageRoute(
            builder: (_) => EmailRecipientPage(
                  project: args.project,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('Error: No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}

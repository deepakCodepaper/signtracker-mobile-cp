import 'package:built_collection/built_collection.dart';
import 'package:signtracker/api/model/check_sign_project.dart';
import 'package:signtracker/api/model/emails.dart';
import 'package:signtracker/api/model/project_logs.dart';
import 'package:signtracker/api/model/request/close_project_request.dart';
import 'package:signtracker/api/model/request/emails_request.dart';
import 'package:signtracker/api/model/request/project_create_request.dart';
import 'package:signtracker/api/model/request/update_project_request.dart';
import 'package:signtracker/api/model/schedule.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/network/sign_tracker_client.dart';
import 'package:signtracker/utilities/token_helper.dart';

class ProjectRepository {
  final _signTrackerClient = SignTrackerClient();

  Future<List<SignProject>> getProjects() async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.getProjects();
  }

  Future<List<SignProject>> getSubProjects(int parentId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.getProjects(parentId: parentId);
  }

  Future<SignProject> getProject(int id) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.getProject(id);
  }

  Future<SignProject> createProject(SignProject project) async {
    if (project == null) throw Exception('Project is required.');

    final api = await _signTrackerClient.getProjectAPI();
    return await api.createProject(ProjectCreateRequest().copy(project));
  }

  Future<SignProject> createSubProject(SignProject project) async {
    if (project == null) throw Exception('Project is required.');

    final api = await _signTrackerClient.getProjectAPI();
    return await api
        .createProject(ProjectCreateRequest().copySubProject(project));
  }

  Future<SignProject> updatePropject(SignProject project) async {
    if (project == null) throw Exception('Project is required.');

    final api = await _signTrackerClient.getProjectAPI();
    return await api.updateProject(
        UpdateProjectRequest().createUpdateProjectRequest(project), project.id);
  }

  Future<SignProject> updateProjectWithImage(SignProject project) async {
    if (project == null) throw Exception('Project is required.');

    final api = await _signTrackerClient.getProjectAPI();
    return await api.uploadProjectPlan(project, project.id, project.plan);
  }

  Future<SignProject> createProjectWithImage(
      ProjectCreateRequest project) async {
    if (project == null) throw Exception('Project is required.');

    final api = await _signTrackerClient.getProjectAPI();
    return await api.createProjectWithProjectPlan(project);
  }

  Future<bool> closeProject(
      int projectId, bool existingsSignsUncovered, bool signsRemoved) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.closeProject(
      CloseProjectRequest().copy(
        existingsSignsUncovered: existingsSignsUncovered,
        signsRemoved: signsRemoved,
      ),
      projectId,
    );
  }

  Future<List<CheckSignProject>> getUpcomingChecks() async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.fetchUpcomingChecks();
  }

  Future<CheckSignProject> startSignCheck(int checkId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.startCheck(checkId);
  }

  Future<List<ProjectLogs>> getProjectLogs(int projectId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.fetchProjectLogs(projectId);
  }

  Future<Emails> getEmailsFromProject(int projectId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.fetchEmailRecipients(projectId);
  }

  Future<Emails> updateEmailsFromProject(
      BuiltList<String> emails, int projectId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.updateEmailRecipients(
        EmailsRequest().copy(emails), projectId);
  }

  Future<List<Template>> getTemplate(String template) async {
    final api = await _signTrackerClient.getTemplatesApi();
    final countryCode = await TokenHelper().getCountryCode();
    final stateCode = await TokenHelper().getStateCode();
    return await api.fetchTemplatesByName(template, countryCode, stateCode);
  }

  Future<List<Template>> getTemplateParams(
      String duration, String lanes, String closure) async {
    final api = await _signTrackerClient.getTemplatesApi();
    final countryCode = await TokenHelper().getCountryCode();
    final stateCode = await TokenHelper().getStateCode();
    return await api.filterTemplates(
        duration, lanes, closure, countryCode, stateCode);
  }

  Future<List<Template>> getTemplateDrawingNumber(String drawingNumber) async {
    final api = await _signTrackerClient.getTemplatesApi();
    final countryCode = await TokenHelper().getCountryCode();
    final stateCode = await TokenHelper().getStateCode();
    return await api.filterByDrawingNumber(
        drawingNumber, countryCode, stateCode);
  }

  Future<Schedule> getReportSchedule(int projectId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.getScheduleReport(projectId);
  }

  Future<Schedule> setReportSchedule(
      int projectId,
      String daily,
      String weekly,
      String time,
      String day,
      String hour,
      String minute,
      String meridian) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.setScheduleReport(
        projectId, daily, weekly, time, day, hour, minute, meridian);
  }

  Future<bool> sendReportNow(int projectId) async {
    final api = await _signTrackerClient.getProjectAPI();
    return await api.sendReportNow(projectId);
  }
}

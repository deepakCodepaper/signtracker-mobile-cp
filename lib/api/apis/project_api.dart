import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/base_model.dart';
import 'package:signtracker/api/model/check_sign_project.dart';
import 'package:signtracker/api/model/emails.dart';
import 'package:signtracker/api/model/project_logs.dart';
import 'package:signtracker/api/model/request/emails_request.dart';
import 'package:signtracker/api/model/request/project_create_request.dart';
import 'package:signtracker/api/model/request/project_notification_request.dart';
import 'package:signtracker/api/model/request/update_project_request.dart';
import 'package:signtracker/api/model/request/close_project_request.dart';
import 'package:signtracker/api/model/schedule.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/api/serializers.dart';

import '../model/project_notification.dart';

class ProjectApi {
  const ProjectApi({this.apiClient});

  final ApiClient apiClient;

  final String apiPath = 'projects';

  Future<List<SignProject>> getProjects({int parentId = 0}) async {
    //var path = 'admin/$apiPath';
    var path = apiPath;
    if (parentId != 0) {
      path = '$apiPath?parent=$parentId';
    }

    try {
      final response = await apiClient.dio.get(path,
          options: buildCacheOptions(Duration(hours: 1), forceRefresh: true));

      if (response.data != null) {
        return deserializeListOf<SignProject>(response.data['data']['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<SignProject>> getProjectList({int page = 1}) async {
    //var path = 'admin/$apiPath';
    var path = '$apiPath?page=$page&per_page=20';

    try {
      final response = await apiClient.dio.get(path,
          options: buildCacheOptions(Duration(hours: 1), forceRefresh: true));



      if (response.data != null) {
        return deserializeListOf<SignProject>(response.data['data']['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<SignProject> getProject(int id) async {
    final path = '$apiPath/$id';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeOf<SignProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<SignProject> createProject(ProjectCreateRequest signProject) async {
    if (signProject == null) throw Exception('SignProject is required.');

    final path = '$apiPath';

    final body = standardSerializers.serialize(signProject);

    print("POST DATA IN PROJECT=============" + body.toString());

    try {
      final response = await apiClient.dio.post(
        path,
        data: jsonEncode(body),
      );

      if (response.data != null) {
        return deserializeOf<SignProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  //Future<List<ProjectNotification>> addProjectNotification(ProjectNotificationRequest projectNotificationRequest,int id) async {
  Future<List<ProjectNotification>> addProjectNotification(ProjectNotificationRequest request) async {
    if (request == null) throw Exception('SignProject is required.');

    final id = request.projectId;
    final path = '$apiPath/$id/save-schedules-notification';

    print("path============" + path.toString());

    final body = standardSerializers.serialize(request);

    print("POST DATA IN PROJECT=============" + body.toString());

    try {
      final response = await apiClient.dio.post(
        path,
        data: jsonEncode(body),
      );

      if (response.data != null) {
        print("RESPONSE DATA============ " + response.data.toString());
        //return deserializeOf<List<ProjectNotification>>(response.data['data']);
        return deserializeListOf<ProjectNotification>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<SignProject> updateProject(
      UpdateProjectRequest signProject,
      int projectId,
      ) async {
    if (signProject == null) throw Exception('SignProject is required.');

    print("UpdateProject");
    final path = '$apiPath/$projectId';

    final body = standardSerializers.serialize(signProject);

    try {
      final response = await apiClient.dio.post(
        path,
        data: jsonEncode(body),
      );

      if (response.data != null) {
        return deserializeOf<SignProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<SignProject> createProjectWithProjectPlan(
      ProjectCreateRequest signProject) async {
    if (signProject == null) throw Exception('SignProject is required.');

    print("CreateProjectPlan");
    final path = '$apiPath';

    FormData formData = new FormData.fromMap({
      "identifier": signProject.identifier,
      "type": signProject.type,
      "commissioned_by": signProject.commissionedBy,
      "description": signProject.description,
      "plan": await MultipartFile.fromFile(signProject.plan),
      "highway": signProject.highway,
      "intersection": signProject.intersection,
      "distance": signProject.distance,
      "template_id": signProject.templateId,
      "start_date": signProject.startDate,
      "end_date": signProject.endDate,
      "notify_frequency": signProject.notifyFrequency,
      "inactive_notify_frequency": signProject.inactiveNotifyFrequency,
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return deserializeOf<SignProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<SignProject> uploadProjectPlan(
      SignProject signProject, int projectId, String plan) async {
    if (projectId == null) throw Exception('SignProject is required.');

    print("UploadProjectPlan");
    final path = '$apiPath/$projectId';

    print("PLANNN====" + plan.toString());
    print("TEMPLATE ID====" + signProject.templateId.toString());

    FormData formData = new FormData.fromMap({
      "_method": 'PUT',
      "plan": await MultipartFile.fromFile(plan),
      "identifier": signProject.identifier != null
          ? signProject.identifier
          : signProject.contractNumber,
      "type": signProject.type,
      "highway": signProject.highway,
      "intersection": signProject.intersection,
      "speed": signProject.speed,
      "distance": signProject.distance,
      "template_id": signProject.templateId,
      "start_date": signProject.startDate,
      "end_date": signProject.endDate,
      "notify_frequency": signProject.notifyFrequency,
      "inactive_notify_frequency": signProject.inactiveNotifyFrequency,
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      print("RESPONSE=====" + response.data.toString());
      if (response.data != null) {
        return deserializeOf<SignProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<bool> closeProject(
      CloseProjectRequest closeProject, int projectId) async {
    if (projectId == null) throw Exception('project id is required.');

    final path = '$apiPath/$projectId/close';
    final body = standardSerializers.serialize(closeProject);

    try {
      final response = await apiClient.dio.post(
        path,
        data: jsonEncode(body),
      );
      if (response.data != null) {
        return response.data['success'];
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<List<ProjectLogs>> fetchProjectLogs(int projectId) async {
    final path = '$apiPath/$projectId/logs';

    try {
      final response = await apiClient.dio.get(path,
          options: buildCacheOptions(Duration(minutes: 1), forceRefresh: true));
      if (response.data != null) {
        return deserializeListOf<ProjectLogs>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<CheckSignProject>> fetchUpcomingChecks() async {
    final path = '$apiPath/upcoming_checks';

    try {
      final response = await apiClient.dio.get(path,
          options: buildCacheOptions(Duration(minutes: 1), forceRefresh: true));
      if (response.data != null) {
        return deserializeListOf<CheckSignProject>(response.data['data'])
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<CheckSignProject> startCheck(int checkId) async {
    final path = '$apiPath/upcoming_checks/$checkId';

    try {
      final response = await apiClient.dio.post(path,
          options: buildCacheOptions(Duration(minutes: 1), forceRefresh: true));
      if (response.data != null) {
        return deserializeOf<CheckSignProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Emails> fetchEmailRecipients(int projectId) async {
    final path = '$apiPath/$projectId/email_recipients';

    try {
      final response = await apiClient.dio.get(path);
      if (response.data != null) {
        return deserializeOf<Emails>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Emails> updateEmailRecipients(
      EmailsRequest emailsrequest, int projectId) async {
    final path = '$apiPath/$projectId/email_recipients';

    final body = standardSerializers.serialize(emailsrequest);

    try {
      final response = await apiClient.dio.post(
        path,
        data: jsonEncode(body),
      );
      if (response.data != null) {
        return deserializeOf<Emails>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Schedule> getScheduleReport(int projectId) async {
    final path = '$apiPath/$projectId/report_schedule';

    try {
      final response = await apiClient.dio.get(path);
      if (response.data != null) {
        return deserializeOf<Schedule>(response.data['data']['schedule']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Schedule> setScheduleReport(
      int projectId,
      String daily,
      String weekly,
      String time,
      String day,
      String hour,
      String minute,
      String meridian) async {
    final path = '$apiPath/$projectId/report_schedule';

    FormData formData = new FormData.fromMap({
      "every_n_days": int.parse(daily),
      "every_n_weeks": int.parse(weekly),
      "day": day,
      "time": time,
      "time_hour": hour,
      "time_minute": minute,
      "time_meridian": meridian
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return deserializeOf<Schedule>(response.data['data']['schedule']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  /*Future<bool> sendReportNow(int projectId) async {
    final path = '$apiPath/$projectId/send_now';

    //FormData formData = new FormData.fromMap({});

    final email = await fetchEmailRecipients(projectId);

    FormData formData = new FormData.fromMap({
      'from': null,
      'to': null,
      //'emails':[{'email':'deepak.codepaper@gmail.com'}]
      'emails':[{'email': email.emails.toList()}]
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }*/

  Future<bool> sendReportNow(int projectId, String fromDate, String endDate) async {
    final path = '$apiPath/$projectId/send_now';

    final email = await fetchEmailRecipients(projectId);

    print("EMAIL LIST====" + email.toString());
    FormData formData;
    if(fromDate != null && endDate != null)
    {
       formData = new FormData.fromMap({
        'from': fromDate,
        'to': endDate,
        //'emails':[{'email':'deepak.codepaper@gmail.com'}]
        'emails': [{'email': email.emails.toList()}]
      });
    }else {
      print("Recurring $fromDate && $endDate");
      formData = new FormData.fromMap({
        'from': null,
        'to': null,
        //'emails':[{'email':'deepak.codepaper@gmail.com'}]
        'emails': [{'email': email.emails.toList()}]
      });
    }

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<ProjectNotification>> deleteNotificationTime(int id) async {
    final path = '$apiPath/$id/delete-schedules-notification';

    //final response = await apiClient.dio.delete(path);

    /*if (response.data != null) {
      return true;
    }*/
    try {
      final response = await apiClient.dio.delete(path,
          options: buildCacheOptions(Duration(hours: 1), forceRefresh: true));

      if (response.data != null) {
        return deserializeListOf<ProjectNotification>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<ProjectNotification>> getProjectNotificationList(int id) async {
    final path = '$apiPath/$id/get-schedules-notification';

    try {
      final response = await apiClient.dio.get(path,
          options: buildCacheOptions(Duration(hours: 1), forceRefresh: true));

      if (response.data != null) {
        return deserializeListOf<ProjectNotification>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}
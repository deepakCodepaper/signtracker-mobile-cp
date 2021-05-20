import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/company.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/invite_project.dart';
import 'package:signtracker/api/model/members.dart';
import 'package:signtracker/api/model/request/company_invite_request.dart';
import 'package:signtracker/api/model/request/send_invite_request.dart';
import 'package:signtracker/api/serializers.dart';

class InvitationApi {
  const InvitationApi({this.apiClient});

  final ApiClient apiClient;

  final String _apiPath = 'invitations';

  Future<List<Invitation>> fetchInvitations() async {
    final path = '$_apiPath';

    try {
      final response = await apiClient.dio.get(
        path,
        options: buildCacheOptions(
          Duration(hours: 1),
          forceRefresh: true,
        ),
      );

      if (response.data != null) {
        return deserializeListOf<Invitation>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<Members>> getInviteList() async {
    final path = 'invite_list/';

    try {
      final response = await apiClient.dio.get(
        path,
        options: buildCacheOptions(
          Duration(hours: 1),
          forceRefresh: true,
        ),
      );

      if (response.data != null) {
        return deserializeListOf<Members>(response.data['data']['users'])
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<Members>> getInviteListFromProject(int projectId) async {
    final path = 'invite_list/?project_id=$projectId';

    try {
      final response = await apiClient.dio.get(
        path,
        options: buildCacheOptions(
          Duration(hours: 1),
          forceRefresh: true,
        ),
      );

      if (response.data != null) {
        return deserializeListOf<Members>(response.data['data']['users'])
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<Company>> getCompanyInviteList() async {
    final path = 'admin/select/companies/all';

    try {
      final response = await apiClient.dio.get(
        path,
        options: buildCacheOptions(
          Duration(hours: 1),
          forceRefresh: true,
        ),
      );

      if (response.data != null) {
        return deserializeListOf<Company>(response.data).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<InviteProject> sendInvite(SendInviteRequest sendInviteRequest) async {
    if (sendInviteRequest == null) throw Exception('Invite is required');

    final path = '$_apiPath';

    final body = standardSerializers.serialize(sendInviteRequest);

    try {
      final response = await apiClient.dio.post(path, data: jsonEncode(body));
      if (response.data != null) {
        return deserializeOf<InviteProject>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return InviteProject();
  }

  Future<bool> sendCompanyInvite(
      CompanyInviteRequest sendInviteRequest, int projectId) async {
    if (sendInviteRequest == null) throw Exception('Invite is required');

    final path = 'admin/projects/$projectId/invite_by_company';

    final body = standardSerializers.serialize(sendInviteRequest);

    try {
      final response = await apiClient.dio.post(path, data: jsonEncode(body));
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

  Future<InviteProject> acceptInvite(int inviteId) async {
    var path = '$_apiPath';

    path = '$_apiPath/$inviteId/accept';

    try {
      final response = await apiClient.dio.post(path);

      if (response.data != null) {
        return deserializeOf(InviteProject)(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<InviteProject> dismissInvite(int inviteId) async {
    var path = '$_apiPath';

    path = '$_apiPath/$inviteId/dismiss';

    try {
      final response = await apiClient.dio.post(path);

      if (response.data != null) {
        return deserializeOf(InviteProject)(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}

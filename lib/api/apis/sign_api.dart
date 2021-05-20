import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/base_model.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/request/sign_request.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/api/serializers.dart';

class SignApi {
  const SignApi({this.apiClient});

  final ApiClient apiClient;

  final String _apiPath = 'signs';

  Future<List<SignMasters>> fetchAllSigns(int templateId) async {
    final path = '$_apiPath/search?page=1&per_page=0&template_id=$templateId';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeListOf<SignMasters>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<SignMasters>> fetchSignMasters() async {
    final path = '$_apiPath/search?page=1&per_page=0';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeListOf<SignMasters>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<Sign>> fetchAllSignsByProjectId(int projectId) async {
    final path = '$_apiPath?pid=$projectId';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeListOf<Sign>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Sign> createSign(SignRequest sign) async {
    if (sign == null) throw Exception('Sign is required');

    final path = '$_apiPath';

    final body = standardSerializers.serialize(sign);

    try {
      final response = await apiClient.dio.post(
        path,
        data: jsonEncode(body),
      );

      if (response.data != null) {
        return deserializeOf<Sign>(response.data['data']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Sign> updateSign(SignRequest sign, signId) async {
    if (sign == null) throw Exception('Sign is required');

    final path = '$_apiPath/$signId';

    final body = standardSerializers.serialize(sign);

    final response = await apiClient.dio.put(
      path,
      data: jsonEncode(body),
    );

    if (response.data != null) {
      return deserializeOf<Sign>(response.data['data']);
    }

    return null;
  }

  Future<bool> deleteSign(int signId) async {
    final path = '$_apiPath/$signId';

    final response = await apiClient.dio.delete(path);

    if (response.data != null) {
      return true;
    }

    return false;
  }

  Future<Template> addSignToTemplate(SignProject project, int signId,
      bool addToMyTemplate, bool favouriteThisSign) async {
    final path = '$_apiPath/add';

    FormData formData = new FormData.fromMap({
      "template_id": project.templateId,
      "sign_ids": signId,
      "add_to_my_template": addToMyTemplate,
      "favourite_this_sign": favouriteThisSign,
      "project_id": project.id,
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return deserializeOf<Template>(response.data['data']['template']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Template> unFavouriteSign(SignProject project, int signId) async {
    final path = 'signs/$signId/unfavourite_sign';

    FormData formData = new FormData.fromMap({
      "template_id": project.templateId,
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return deserializeOf<Template>(response.data['data']['template']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<Template> deleteSignFromTemplate(
      SignProject project, int signId) async {
    final path = '$_apiPath/remove';

    FormData formData = new FormData.fromMap({
      "template_id": project.templateId,
      "sign_ids": signId,
      "project_id": project.id,
    });

    try {
      final response = await apiClient.dio.post(path, data: formData);
      if (response.data != null) {
        return deserializeOf<Template>(response.data['data']['template']);
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}

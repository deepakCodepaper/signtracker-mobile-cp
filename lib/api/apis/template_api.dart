import 'dart:convert';

import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/api/model/user_device.dart';
import 'package:signtracker/api/serializers.dart';
import 'package:dio/dio.dart';

class TemplateApi {
  TemplateApi({this.apiClient});

  final ApiClient apiClient;

  Future<List<Template>> fetchTemplatesByName(String templateName) async {
    final path = 'templates?template_name=$templateName';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeListOf<Template>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<Template>> filterTemplates(
      String duration, String lanes, String closure) async {
    final path =
        'templates?duration=$duration&number_of_lanes=$lanes&closure=$closure';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeListOf<Template>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<List<Template>> filterByDrawingNumber(String drawingNumber) async {
    final path = 'templates?drawing_number=$drawingNumber';

    try {
      final response = await apiClient.dio.get(path);

      if (response.data != null) {
        return deserializeListOf<Template>(response.data['data']).toList();
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}

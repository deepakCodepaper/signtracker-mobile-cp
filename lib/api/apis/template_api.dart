import 'package:dio/dio.dart';
import 'package:signtracker/api/api_client.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/api/serializers.dart';

class TemplateApi {
  TemplateApi({this.apiClient});

  final ApiClient apiClient;

  Future<List<Template>> fetchTemplatesByName(
      String templateName, String countryCode, String stateCode) async {
    var path = 'templates?template_name=$templateName';

    if (countryCode != null && countryCode.isNotEmpty) {
      path = "$path&country_code=$countryCode";
    }
    if (stateCode != null && stateCode.isNotEmpty) {
      path = "$path&state_code=$stateCode";
    }
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

  Future<List<Template>> filterTemplates(String duration, String lanes,
      String closure, String countryCode, String stateCode) async {
    var path =
        'templates?duration=$duration&number_of_lanes=$lanes&closure=$closure';

    if (countryCode != null && countryCode.isNotEmpty) {
      path = "$path&country_code=$countryCode";
    }
    if (stateCode != null && stateCode.isNotEmpty) {
      path = "$path&state_code=$stateCode";
    }

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

  Future<List<Template>> filterByDrawingNumber(
      String drawingNumber, String countryCode, String stateCode) async {
    var path = 'templates?drawing_number=$drawingNumber';
    if (countryCode != null && countryCode.isNotEmpty) {
      path = "$path&country_code=$countryCode";
    }
    if (stateCode != null && stateCode.isNotEmpty) {
      path = "$path&state_code=$stateCode";
    }
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

import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/request/sign_request.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/network/sign_tracker_client.dart';

class SignRepository {
  final _signTrackerClient = SignTrackerClient();

  Future<List<SignMasters>> fetchSigns(int templateId) async {
    final api = await _signTrackerClient.getSignApi();
    return await api.fetchAllSigns(templateId);
  }

  Future<List<SignMasters>> fetchAllSigns() async {
    final api = await _signTrackerClient.getSignApi();
    return await api.fetchSignMasters();
  }

  Future<List<Sign>> fetchSignsByProject(int projectId) async {
    final api = await _signTrackerClient.getSignApi();
    return await api.fetchAllSignsByProjectId(projectId);
  }

  Future<Sign> createSign(SignRequest sign) async {
    if (sign == null) throw Exception('Sign is required.');

    final api = await _signTrackerClient.getSignApi();
    return await api.createSign(sign);
  }

  Future<Sign> updateSign(SignRequest sign, int signId) async {
    if (sign == null) throw Exception('Sign is required.');
    sign.rebuild((b) => b.method = 'PUT');
    final api = await _signTrackerClient.getSignApi();
    return await api.updateSign(sign, signId);
  }

  Future<bool> deleteSign(int signId) async {
    final api = await _signTrackerClient.getSignApi();
    return await api.deleteSign(signId);
  }

  Future<Template> addSignToTemplate(SignProject project, int signId,
      bool addToMyTemplate, bool favouriteThisSign) async {
    final api = await _signTrackerClient.getSignApi();
    return await api.addSignToTemplate(
        project, signId, addToMyTemplate, favouriteThisSign);
  }

  Future<Template> unFavouriteSign(SignProject project, int signId) async {
    final api = await _signTrackerClient.getSignApi();
    return await api.unFavouriteSign(project, signId);
  }

  Future<Template> deleteSignFromTemplate(
      SignProject project, int signId) async {
    final api = await _signTrackerClient.getSignApi();
    return await api.deleteSignFromTemplate(project, signId);
  }
}

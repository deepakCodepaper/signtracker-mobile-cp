import 'package:built_collection/built_collection.dart';
import 'package:signtracker/api/model/company.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/invite.dart';
import 'package:signtracker/api/model/invite_project.dart';
import 'package:signtracker/api/model/members.dart';
import 'package:signtracker/api/model/request/company_invite_request.dart';
import 'package:signtracker/api/model/request/send_invite_request.dart';
import 'package:signtracker/network/sign_tracker_client.dart';

class InvitationRepository {
  final _signTrackerClient = SignTrackerClient();

  Future<List<Invitation>> getInvitations() async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.fetchInvitations();
  }

  Future<List<Members>> getInviteList() async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.getInviteList();
  }

  Future<List<Members>> getInviteListFromProject(int projectId) async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.getInviteListFromProject(projectId);
  }

  Future<List<Company>> getCompaniesForInvite() async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.getCompanyInviteList();
  }

  Future<InviteProject> acceptInvite(int inviteId) async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.acceptInvite(inviteId);
    return null;
  }

  Future<InviteProject> dismissInvite(int inviteId) async {
    final api = await _signTrackerClient.getInvitationApi();
//    return await api.dismissInvite(inviteId);
    return null;
  }

  Future<InviteProject> sendInvite(Invite invite) async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.sendInvite(SendInviteRequest().copy(invite));
  }

  Future<bool> sendInviteForCompany(
      BuiltList<int> companies, int projectId) async {
    final api = await _signTrackerClient.getInvitationApi();
    return await api.sendCompanyInvite(
        CompanyInviteRequest().copy(companies), projectId);
  }
}

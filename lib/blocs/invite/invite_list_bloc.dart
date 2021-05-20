import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:signtracker/api/model/company.dart';
import 'package:signtracker/repository/invitation_repository.dart';

import 'invite_list_events.dart';
import 'invite_list_states.dart';

class InviteListBloc extends Bloc<InviteListEvent, InviteListState> {
  InviteListBloc(this.invitationRepository);

  final InvitationRepository invitationRepository;

  @override
  InviteListState get initialState => InviteListInitial();

  void getMemembers() {
    add(LoadMembers());
  }

  void getMemembersFromProject(int projectId) {
    add(LoadMembersFromProject(projectId));
  }

  void getCompaniesForInvite() {
    add(GetCompanyForInvite());
  }

  void sendCompanyInvite(
    BuiltList<int> companies,
    int projectId,
  ) {
    add(SendCompanyInvite(companies, projectId));
  }

  @override
  Stream<InviteListState> mapEventToState(InviteListEvent event) async* {
    if (event is LoadMembers) {
      yield InviteListLoading();
      final members = await invitationRepository.getInviteList();
      if (members == null) {
        yield InviteListError('Unable to load members');
      } else {
        yield InviteListLoaded(members);
      }
    } else if (event is LoadMembersFromProject) {
      yield InviteListLoading();
      final members =
          await invitationRepository.getInviteListFromProject(event.projectId);
      if (members == null) {
        yield InviteListError('Unable to load members');
      } else {
        yield InviteListLoaded(members);
      }
    } else if (event is GetCompanyForInvite) {
      yield InviteListLoading();
      final companies = await invitationRepository.getCompaniesForInvite();
      if (companies == null) {
        yield InviteListError('Unable to load company');
      } else {
        yield CompanyInvitesLoaded(companies);
      }
    } else if (event is SendCompanyInvite) {
      yield SendCompanyInviteLoading();
      final success = await invitationRepository.sendInviteForCompany(
          event.companies, event.projectId);
      if (success == null) {
        yield InviteListError('Unable to load company');
      } else {
        yield CompanyInviteSent(success);
      }
    }
  }
}

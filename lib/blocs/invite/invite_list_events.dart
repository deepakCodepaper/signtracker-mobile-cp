import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';

abstract class InviteListEvent extends Equatable {
  InviteListEvent([List props]) : super(props);
}

class LoadMembers extends InviteListEvent {
  @override
  String toString() => 'LoadMembers';
}

class LoadMembersFromProject extends InviteListEvent {
  LoadMembersFromProject(this.projectId);
  final int projectId;

  @override
  String toString() => 'LoadMembersFromProject';
}

class GetCompanyForInvite extends InviteListEvent {
  GetCompanyForInvite();

  @override
  String toString() => 'GetCompanyForInvite';
}

class SendCompanyInvite extends InviteListEvent {
  SendCompanyInvite(this.companies, this.projectId);

  final BuiltList<int> companies;
  final int projectId;

  @override
  String toString() => 'SendCompanyInvite';
}

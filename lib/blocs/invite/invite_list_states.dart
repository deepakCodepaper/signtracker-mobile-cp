import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/company.dart';
import 'package:signtracker/api/model/members.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class InviteListState extends Equatable {
  InviteListState([List props]) : super(props);
}

class InviteListInitial extends InviteListState {
  @override
  String toString() => 'InviteListInitial';
}

class InviteListLoading extends InviteListState {
  @override
  String toString() => 'InviteListLoading';
}

class SendCompanyInviteLoading extends InviteListState {
  @override
  String toString() => 'SendCompanyInviteLoading';
}

class InviteListError extends InviteListState {
  InviteListError(this.error);
  final String error;

  @override
  String toString() => 'Projects Error $error';
}

class InviteListLoaded extends InviteListState {
  InviteListLoaded(this.members);
  final List<Members> members;

  @override
  String toString() => 'ProjectsLoaded';
}

class CompanyInvitesLoaded extends InviteListState {
  CompanyInvitesLoaded(this.company);
  final List<Company> company;

  @override
  String toString() => 'CompanyInvitesLoaded';
}

class CompanyInviteSent extends InviteListState {
  CompanyInviteSent(this.success);
  final bool success;

  @override
  String toString() => 'CompanyInviteSent';
}

import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/check_sign_project.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class CheckSignsState extends Equatable {
  CheckSignsState([List props]) : super(props);
}

class CheckSignsInitial extends CheckSignsState {
  @override
  String toString() => 'CheckSignsInitial';
}

class LoadingInvitations extends CheckSignsState {
  @override
  String toString() => 'LoadingInvitations';
}

class InvitationsLoadingError extends CheckSignsState {
  InvitationsLoadingError(this.error);
  final String error;

  @override
  String toString() => 'InvitationsLoadingError $error';
}

class InvitationsLoaded extends CheckSignsState {
  InvitationsLoaded(this.invitations);
  final Map<String, List<Invitation>> invitations;

  @override
  String toString() => 'InvitationsLoaded';
}

class AcceptingInvitation extends CheckSignsState {
  @override
  String toString() => 'AcceptingInvitation';
}

class AcceptingInvitationSuccess extends CheckSignsState {
  @override
  String toString() => 'AcceptingInvitationSuccess';
}

class AcceptingInvitationFailed extends CheckSignsState {
  @override
  String toString() => 'AcceptingInvitationSuccess';
}

class AcceptingInvitationDismissed extends CheckSignsState {
  @override
  String toString() => 'AcceptingInvitationDismissed';
}

class DismissingInvitation extends CheckSignsState {
  @override
  String toString() => 'DismissingInvitation';
}

class DismissingInvitationSuccess extends CheckSignsState {
  @override
  String toString() => 'DismissingInvitationSuccess';
}

class DismissingInvitationFailed extends CheckSignsState {
  @override
  String toString() => 'DismissingInvitationFailed';
}

class ProjectLoadingError extends CheckSignsState {
  ProjectLoadingError(this.error);
  final String error;

  @override
  String toString() => 'ProjectLoadingError $error';
}

class ProjectsLoaded extends CheckSignsState {
  ProjectsLoaded(this.projects);
  final Map<String, List<SignProject>> projects;

  @override
  String toString() => 'ProjectsLoaded';
}

class CheckSignsProjectLoaded extends CheckSignsState {
  CheckSignsProjectLoaded(this.projects);
  final Map<String, List<CheckSignProject>> projects;

  @override
  String toString() => 'ProjectsLoaded';
}

class StartCheckLoading extends CheckSignsState {
  @override
  String toString() => 'StartCheckLoading';
}

class StartCheckError extends CheckSignsState {
  StartCheckError(this.error);
  final String error;

  @override
  String toString() => 'StartCheckError $error';
}

class StartCheckLoaded extends CheckSignsState {
  StartCheckLoaded(this.signChecked);
  final CheckSignProject signChecked;
  @override
  String toString() => 'StartCheckLoaded';
}

import 'package:equatable/equatable.dart';

abstract class CheckSignsEvent extends Equatable {
  CheckSignsEvent([List props]) : super(props);
}

class LoadInvitations extends CheckSignsEvent {
  @override
  String toString() => 'LoadInvitations';
}

class AcceptInvitation extends CheckSignsEvent {
  AcceptInvitation(this.inviteId) : super([inviteId]);

  final int inviteId;

  @override
  String toString() => 'AcceptInvitation';
}

class DismissInvitation extends CheckSignsEvent {
  DismissInvitation(this.inviteId) : super([inviteId]);

  final int inviteId;
  @override
  String toString() => 'DismissInvitation';
}

class LoadProjects extends CheckSignsEvent {
  @override
  String toString() => 'LoadProjects';
}

class LoadUpcomingChecks extends CheckSignsEvent {
  @override
  String toString() => 'LoadUpcomingChecks';
}

class StartCheck extends CheckSignsEvent {
  StartCheck(this.checkId) : super([checkId]);

  final int checkId;

  @override
  String toString() => 'StartCheck';
}

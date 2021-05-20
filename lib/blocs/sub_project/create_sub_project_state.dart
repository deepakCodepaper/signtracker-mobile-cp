part of 'create_sub_project_bloc.dart';

@immutable
abstract class CreateSubProjectState extends Equatable {
  CreateSubProjectState([List props = const []]) : super([props]);

  @override
  String toString() => 'CreateProjectState';
}

class InitialCreateProjectState extends CreateSubProjectState {}

class CreateProjectUploadingState extends CreateSubProjectState {
  @override
  String toString() => 'CreateProjectUploadingState';
}

class GettingRecipientsState extends CreateSubProjectState {
  @override
  String toString() => 'GettingRecipientsState';
}

class CreateProjectUploadedState extends CreateSubProjectState {
  CreateProjectUploadedState(this.project) : super([project]);

  final SignProject project;

  @override
  String toString() => 'CreateProjectUploadedState $project';
}

class RecipientsReceived extends CreateSubProjectState {
  RecipientsReceived(this.emails) : super([emails]);

  final Emails emails;

  @override
  String toString() => 'RecipientsReceived $emails';
}

class CreateProjectNotUploadedState extends CreateSubProjectState {
  CreateProjectNotUploadedState(this.error) : super([error]);
  final String error;

  @override
  String toString() => 'CreateProjectNotUploadedState $error';
}

class RecipientsFailed extends CreateSubProjectState {
  RecipientsFailed(this.error) : super([error]);
  final String error;

  @override
  String toString() => 'RecepientsFailed $error';
}

class GetScheduleLoading extends CreateSubProjectState {
  @override
  String toString() => 'GetScheduleLoading';
}

class GetScheduleLoaded extends CreateSubProjectState {
  GetScheduleLoaded(this.schedule) : super([schedule]);

  final Schedule schedule;

  @override
  String toString() => 'GetScheduleLoaded: $schedule';
}

class GetScheduleError extends CreateSubProjectState {
  @override
  String toString() => 'GetScheduleError';
}

class SetScheduleLoaded extends CreateSubProjectState {
  SetScheduleLoaded(this.schedule) : super([schedule]);

  final Schedule schedule;

  @override
  String toString() => 'GetScheduleLoaded: $schedule';
}

class SendReportNowLoaded extends CreateSubProjectState {
  SendReportNowLoaded(this.success) : super([success]);

  final bool success;

  @override
  String toString() => 'GetScheduleLoaded: $success';
}

class SendReportNowFailed extends CreateSubProjectState {
  @override
  String toString() => 'SendReportNowFailed:';
}

class SetScheduleError extends CreateSubProjectState {
  @override
  String toString() => 'SetScheduleError';
}

part of 'create_sub_project_bloc.dart';

@immutable
abstract class CreateSubProjectEvent extends Equatable {
  CreateSubProjectEvent([List props = const []]) : super([props]);
  @override
  String toString() => 'CreateProjectEvent';
}

class CreateCreateSubProjectEvent extends CreateSubProjectEvent {
  CreateCreateSubProjectEvent(this.project) : super([project]);

  final SignProject project;

  @override
  String toString() => 'CreateCreateProjectEvent $project';
}

class UpdateEmailRecipient extends CreateSubProjectEvent {
  UpdateEmailRecipient(this.emails, this.project) : super([emails, project]);

  final BuiltList<String> emails;
  final SignProject project;

  @override
  String toString() => 'CreateCreateProjectEvent $project';
}

class GetEmailRecipients extends CreateSubProjectEvent {
  GetEmailRecipients(this.project) : super([project]);

  final SignProject project;

  @override
  String toString() => 'GetRecipients';
}

class GetScheduleReports extends CreateSubProjectEvent {
  GetScheduleReports(this.project) : super([project]);

  final SignProject project;

  @override
  String toString() => 'GetScheduleReports';
}

class SetScheduleReports extends CreateSubProjectEvent {
  SetScheduleReports(this.signProject, this.daily, this.weekly, this.time,
      this.day, this.hour, this.minute, this.meridian)
      : super([daily, weekly, day, time, hour, minute, meridian]);

  final SignProject signProject;
  final String daily;
  final String weekly;
  final String day;
  final String time;
  final String hour;
  final String minute;
  final String meridian;

  @override
  String toString() => 'SetScheduleReports';
}

class SendReportNow extends CreateSubProjectEvent {
  SendReportNow(this.signProject,this.fromDate,this.endDate) : super([]);

  final SignProject signProject;
  String fromDate;
  String endDate;

  @override
  String toString() => 'SendReportNow';
}

import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/project_logs.dart';
import 'package:signtracker/api/model/sign.dart';

abstract class ProjectLogsState extends Equatable {
  ProjectLogsState([List props]) : super(props);
}

class ProjectLogsInitial extends ProjectLogsState {
  @override
  String toString() => 'ProjectLogsInitial';
}

class LogsLoading extends ProjectLogsState {
  @override
  String toString() => 'SignsLoading';
}

class LogsLoaded extends ProjectLogsState {
  LogsLoaded(this.projectLogs);

  final List<ProjectLogs> projectLogs;

  @override
  String toString() => 'SignsLoaded';
}

class LogsErrorLoading extends ProjectLogsState {
  LogsErrorLoading(this.error);

  final String error;

  @override
  String toString() => 'SignsErrorLoading $error';
}

class ClosingProject extends ProjectLogsState {
  String toString() => 'ClosingProject';
}

class ProjectClosed extends ProjectLogsState {
  @override
  String toString() => 'ProjectClosed';
}

class ProjectClosingError extends ProjectLogsState {
  ProjectClosingError(this.error);
  final String error;
  @override
  String toString() => 'ProjectClosingError';
}

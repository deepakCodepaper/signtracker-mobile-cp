import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class ProjectLogsEvent extends Equatable {
  ProjectLogsEvent([List props]) : super(props);
}

class LoadProjectLogs extends ProjectLogsEvent {
  LoadProjectLogs(this.projectId);

  final int projectId;

  @override
  String toString() => 'LoadProjectLogs $projectId';
}

class CloseProject extends ProjectLogsEvent {
  CloseProject(
    this.projectId,
    this.existingsSignsUncovered,
    this.signsRemoved,
  );

  final int projectId;
  final bool existingsSignsUncovered;
  final bool signsRemoved;

  @override
  String toString() => 'Close Project';
}

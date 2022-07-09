part of 'project_notification_bloc.dart';

abstract class ProjectNotificationState extends Equatable {
  ProjectNotificationState([List props = const []]) : super([props]);

  @override
  String toString() => 'ProjectNotificationState';
}

class ProjectNotificationInitialState extends ProjectNotificationState {
  @override
  String toString() => 'ProjectNotificationInitialState';

  @override
  List<Object> get props => [];
}

class ProjectNotificationAddState extends ProjectNotificationState{
  @override
  String toString() => 'ProjectNotificationAddState';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProjectNotificationDeleteState extends ProjectNotificationState{
  @override
  String toString() => 'ProjectNotificationDeleteState';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProjectNotificationSuccess extends ProjectNotificationState {
  ProjectNotificationSuccess(this.project);
  final List<ProjectNotification> project;

  @override
  String toString() => 'ProjectNotificationSuccess';
}

class ProjectNotificationFailure extends ProjectNotificationState {
  ProjectNotificationFailure(this.error);
  final String error;

  @override
  String toString() => 'ProjectNotificationFailure $error';
}

class ProjectNotificationDelete extends ProjectNotificationState {
  ProjectNotificationDelete(this.result);
  final bool result;

  @override
  String toString() => 'ProjectNotificationDelete $result';
}

class ProjectNotificationLoaded extends ProjectNotificationState {
  final List<ProjectNotification> projects;
  final bool status;
  ProjectNotificationLoaded(this.projects,this.status);

  @override
  String toString() => 'ProjectNotificationLoaded';
}

class ProjectNotificationLoading extends ProjectNotificationState {
  @override
  String toString() => 'ProjectNotificationLoading';
}

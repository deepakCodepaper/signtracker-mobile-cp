part of 'project_notification_bloc.dart';

abstract class ProjectNotificationEvent extends Equatable {
  ProjectNotificationEvent([List props = const []]) : super([props]);
  @override
  String toString() => 'ProjectNotificationEvent';
}

class AddIsClicked extends ProjectNotificationEvent {
  AddIsClicked(this.request);
  final ProjectNotificationRequest request;

  @override
  String toString() => 'AddIsClicked';
}

class DeleteIsClicked extends ProjectNotificationEvent {
  DeleteIsClicked(this.id);
  final int id;

  @override
  String toString() => 'DeleteIsClicked';
}

class InitialLoading extends ProjectNotificationEvent {
  InitialLoading(this.id);
  final int id;

  @override
  String toString() => 'InitialLoading';
}

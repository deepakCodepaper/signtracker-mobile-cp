import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class ProjectListState extends Equatable {
  ProjectListState([List props]) : super(props);
}

class ProjectListInitial extends ProjectListState {
  @override
  String toString() => 'ProjectListInitial';
}

class ProjectsLoading extends ProjectListState {
  @override
  String toString() => 'ProjectsLoading';
}

class ReloadingProjects extends ProjectListState {
  @override
  String toString() => 'ReloadingProjects';
}

class ProjectsError extends ProjectListState {
  ProjectsError(this.error);
  final String error;

  @override
  String toString() => 'Projects Error $error';
}
class ProjectsLoaded extends ProjectListState {
  final List<SignProject> projects;
  ProjectsLoaded(this.projects);

  @override
  String toString() => 'ProjectsLoaded';
}

class ProjectsListEmpty extends ProjectListState {
  ProjectsListEmpty(this.msg);
  final String msg;

  @override
  String toString() => 'Projects Error $msg';
}

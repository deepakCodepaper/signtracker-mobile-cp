import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class ProjectState extends Equatable {
  ProjectState([List props]) : super(props);
}

class ProjectInitial extends ProjectState {
  @override
  String toString() => 'ProjectInitial';
}

class ProjectNotLoaded extends ProjectState {
  ProjectNotLoaded(this.error);

  final String error;

  @override
  String toString() => 'ProjectNotLoaded $error';
}

class ProjectLoaded extends ProjectState {
  ProjectLoaded(this.project);

  final SignProject project;

  @override
  String toString() => 'ProjectLoaded';
}

class SignsLoading extends ProjectState {
  @override
  String toString() => 'SignsLoading';
}

class SignsLoaded extends ProjectState {
  SignsLoaded(this.signs);

  final List<Sign> signs;

  @override
  String toString() => 'SignsLoaded';
}

class SignsNotLoaded extends ProjectState {
  SignsNotLoaded(this.error);

  final String error;

  @override
  String toString() => 'SignsNotLoaded $error';
}

class SignUpdated extends ProjectState {
  SignUpdated(this.sign);

  final Sign sign;

  @override
  String toString() => 'SignUpdated';
}

class SignNotUpdated extends ProjectState {
  SignNotUpdated(this.error);

  final String error;

  @override
  String toString() => 'SignNotUpdated $error';
}

class SignsUpdating extends ProjectState {
  SignsUpdating();

  @override
  String toString() => 'SignsUpdating';
}

class SignDeleted extends ProjectState {
  SignDeleted(this.deleteSignId);

  final int deleteSignId;

  @override
  String toString() => 'SignDeleted';
}

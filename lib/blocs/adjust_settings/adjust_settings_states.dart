import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class AdjustSettingsState extends Equatable {
  AdjustSettingsState([List props = const []]) : super(props);
}

class AdjustSettingsInitial extends AdjustSettingsState {
  @override
  String toString() => 'AdjustSettingsInitial';
}

class AdjustSettingsLoading extends AdjustSettingsState {
  @override
  String toString() => 'AdjustSettingsLoading';
}

class AdjustSettingsFailure extends AdjustSettingsState {
  AdjustSettingsFailure(this.error);
  final String error;

  @override
  String toString() => 'AdjustSettingsFailure $error';
}

class AdjustSettingsSuccess extends AdjustSettingsState {
  AdjustSettingsSuccess(this.project);
  final SignProject project;

  @override
  String toString() => 'AdjustSettingsSuccess';
}

class ClosingProject extends AdjustSettingsState {
  String toString() => 'ClosingProject';
}

class ProjectClosed extends AdjustSettingsState {
  @override
  String toString() => 'ProjectClosed';
}

class ProjectClosingError extends AdjustSettingsState {
  ProjectClosingError(this.error);
  final String error;
  @override
  String toString() => 'ProjectClosingError';
}

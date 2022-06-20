import 'package:equatable/equatable.dart';

abstract class ProjectListEvent extends Equatable {
  ProjectListEvent([List props]) : super(props);
}

class LoadProjects extends ProjectListEvent {
  @override
  String toString() => 'LoadProjects';
}

class ReloadProjects extends ProjectListEvent {
  @override
  String toString() => 'ReloadProjects';
}

class FetchNextPage extends ProjectListEvent {
  @override
  String toString() => 'FetchNextPage';
}

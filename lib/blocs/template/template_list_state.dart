import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/template.dart';

abstract class TemplateListState extends Equatable {
  TemplateListState([List props = const []]) : super([props]);

  @override
  String toString() => 'TemplateListState';
}

class InitialTemplateListState extends TemplateListState {}

class LoadingTemplatesState extends TemplateListState {
  @override
  String toString() => 'LoadingTemplatesState';
}

class LoadingTemplatesSuccessState extends TemplateListState {
  LoadingTemplatesSuccessState(this.template) : super([template]);

  final List<Template> template;

  @override
  List<Object> get props => [template];

  @override
  String toString() => 'LoadingTemplatesSuccessState';
}

class LoadingTemplatesFailedState extends TemplateListState {
  @override
  String toString() => 'LoadingTemplatesFailedState';
}

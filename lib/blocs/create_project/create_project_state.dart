part of 'create_project_bloc.dart';

@immutable
abstract class CreateProjectState extends Equatable {
  CreateProjectState([List props = const []]) : super([props]);

  @override
  String toString() => 'CreateProjectState';
}

class InitialCreateProjectState extends CreateProjectState {}

class CreateProjectUploadingState extends CreateProjectState {
  @override
  String toString() => 'CreateProjectUploadingState';
}

class CreateProjectUploadedState extends CreateProjectState {
  CreateProjectUploadedState(this.project) : super([project]);

  final SignProject project;

  @override
  String toString() => 'CreateProjectUploadedState $project';
}

class CreateProjectNotUploadedState extends CreateProjectState {
  CreateProjectNotUploadedState(this.error) : super([error]);
  final String error;

  @override
  String toString() => 'CreateProjectNotUploadedState $error';
}

class SendingMemberInviteForProjectState extends CreateProjectState {
  SendingMemberInviteForProjectState(this.invite) : super([invite]);

  final Invite invite;

  @override
  List<Object> get props => [invite];

  @override
  String toString() => 'MemberInviteState';
}

class SendMemberInviteSuccessState extends CreateProjectState {
  @override
  String toString() => 'MemberInviteSuccessState';
}

class SendMemberInviteFailedState extends CreateProjectState {
  @override
  String toString() => 'MemberInviteFailedState';
}

class LoadingTemplateIdState extends CreateProjectState {
  @override
  String toString() => 'LoadingTemplateNameState';
}

class LoadingTemplateIdSuccessState extends CreateProjectState {
  LoadingTemplateIdSuccessState(this.template) : super([template]);

  final List<Template> template;

  @override
  List<Object> get props => [template];

  @override
  String toString() => 'LoadingTemplateNameState';
}

class LoadingTemplateIdFailedState extends CreateProjectState {
  @override
  String toString() => 'LoadingTemplateIdFailedState';
}

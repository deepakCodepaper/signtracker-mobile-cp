part of 'create_project_bloc.dart';

@immutable
abstract class CreateProjectEvent extends Equatable {
  CreateProjectEvent([List props = const []]) : super([props]);
  @override
  String toString() => 'CreateProjectEvent';
}

class ImageReceivedFromGallery extends CreateProjectEvent {
  ImageReceivedFromGallery(this.project);
  final SignProject project;

  @override
  String toString() => 'ImageReceivedFromGallery';
}

class DoneIsClicked extends CreateProjectEvent {
  DoneIsClicked(this.project);
  final SignProject project;

  @override
  String toString() => 'ConfirmIsClicked';
}

class CreateCreateProjectEvent extends CreateProjectEvent {
  CreateCreateProjectEvent(this.project) : super([project]);

  final SignProject project;

  @override
  String toString() => 'CreateCreateProjectEvent $project';
}

class CreateCreateProjectWithImageEvent extends CreateProjectEvent {
  CreateCreateProjectWithImageEvent(this.project) : super([project]);

  final ProjectCreateRequest project;

  @override
  String toString() => 'CreateCreateProjectEvent $project';
}

class SendMemberInviteForProjectEvent extends CreateProjectEvent {
  SendMemberInviteForProjectEvent(this.invite) : super([invite]);

  final Invite invite;

  @override
  String toString() {
    return 'SendMemberInviteProjectEvent for $invite';
  }
}

class GetTemplateNameEvent extends CreateProjectEvent {
  GetTemplateNameEvent(this.templateName) : super([templateName]);

  final String templateName;

  @override
  String toString() {
    return 'GetTemplateNameEvent for $templateName';
  }
}

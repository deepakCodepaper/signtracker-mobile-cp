import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class AdjustSettingsEvent extends Equatable {
  AdjustSettingsEvent([List props = const []]) : super(props);
}

class DoneIsClicked extends AdjustSettingsEvent {
  DoneIsClicked(this.project);
  final SignProject project;

  @override
  String toString() => 'ConfirmIsClicked';
}

class ImageReceivedFromGallery extends AdjustSettingsEvent {
  ImageReceivedFromGallery(this.project);
  final SignProject project;

  @override
  String toString() => 'ImageReceivedFromGallery';
}

class ImageFromTemplate extends AdjustSettingsEvent {
  ImageFromTemplate(this.project);
  final SignProject project;

  @override
  String toString() => 'ImageFromTemplate';
}

class CloseProject extends AdjustSettingsEvent {
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

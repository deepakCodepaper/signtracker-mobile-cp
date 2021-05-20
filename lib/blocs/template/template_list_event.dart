import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class TemplateListEvent extends Equatable {
  TemplateListEvent([List props = const []]) : super([props]);
  @override
  String toString() => 'CreateProjectEvent';
}

class GetTemplatesByParameterEvent extends TemplateListEvent {
  GetTemplatesByParameterEvent(this.duration, this.lanes, this.closure)
      : super([duration, lanes, closure]);

  final String duration;
  final String lanes;
  final String closure;

  @override
  String toString() {
    return 'GetTemplateNameEvent for $duration $lanes $closure';
  }
}

class GetTemplatesByDrawingNumberEvent extends TemplateListEvent {
  GetTemplatesByDrawingNumberEvent(this.drawingNumber) : super([drawingNumber]);

  final String drawingNumber;

  @override
  String toString() {
    return 'GetTemplateNameEvent for $drawingNumber';
  }
}

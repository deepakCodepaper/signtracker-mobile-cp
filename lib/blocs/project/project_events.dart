import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign.dart';

abstract class ProjectEvent extends Equatable {
  ProjectEvent([List props]) : super(props);
}

class GetProjectDetails extends ProjectEvent {
  GetProjectDetails(this.id);
  final int id;

  @override
  String toString() => 'GetProjectDetails $id';
}

class LoadSigns extends ProjectEvent {
  LoadSigns(this.id);
  final int id;

  @override
  String toString() => 'LoadSigns $id';
}

class UpdateSign extends ProjectEvent {
  UpdateSign(this.sign);
  final Sign sign;

  @override
  String toString() => 'Update Sign ${sign.id}';
}

class DeleteSign extends ProjectEvent {
  DeleteSign(this.signId);
  final int signId;

  @override
  String toString() => 'DeleteSign ${signId}';
}

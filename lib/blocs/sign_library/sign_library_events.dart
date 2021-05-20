import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign_project.dart';

abstract class SignLibraryEvent extends Equatable {
  SignLibraryEvent([List props = const []]) : super(props);
}

class FetchSigns extends SignLibraryEvent {
  FetchSigns(this.templateId);
  final int templateId;
  @override
  String toString() => 'FetchSigns';
}

class FetchAllSigns extends SignLibraryEvent {
  @override
  String toString() => 'FetchAllSigns';
}

class AddSignToTemplate extends SignLibraryEvent {
  AddSignToTemplate(
      this.project, this.signId, this.addToTemplate, this.favouriteThisSign);
  final SignProject project;
  final int signId;
  final bool addToTemplate;
  final bool favouriteThisSign;

  @override
  String toString() => 'AddSignToTemplate';
}

class DeleteSignFromTemplate extends SignLibraryEvent {
  DeleteSignFromTemplate(this.project, this.signId);
  final SignProject project;
  final int signId;

  @override
  String toString() => 'DeleteSignFromTemplate';
}

class UnFavouriteSign extends SignLibraryEvent {
  UnFavouriteSign(this.project, this.signId);
  final SignProject project;
  final int signId;

  @override
  String toString() => 'UnFavouriteSign';
}

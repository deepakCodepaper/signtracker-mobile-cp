import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/template.dart';

abstract class SignLibraryState extends Equatable {
  SignLibraryState([List props = const []]) : super(props);
}

class SignsLibaryInitial extends SignLibraryState {
  @override
  String toString() => 'Initial';
}

class SignsLibraryLoading extends SignLibraryState {
  @override
  String toString() => 'Loading';
}

class SignsLibraryLoaded extends SignLibraryState {
  SignsLibraryLoaded(this.signs) : super([signs]);
  final List<SignMasters> signs;

  @override
  String toString() => 'SignsLoaded { signs $signs }';
}

class SignLibraryError extends SignLibraryState {
  SignLibraryError(this.error) : super([error]);
  final String error;

  @override
  String toString() => 'SignLibraryError { error $error }';
}

class SignAddTemplateLoading extends SignLibraryState {
  @override
  String toString() => 'Loading';
}

class SignAddTemplateLoaded extends SignLibraryState {
  SignAddTemplateLoaded(this.template) : super([template]);
  final Template template;
  @override
  String toString() => 'SignAddTemplateLoaded { template $template }';
}

class SignAddTemplateError extends SignLibraryState {
  @override
  String toString() => 'SignAddTemplateError';
}

class DeleteSignFromTemplateLoading extends SignLibraryState {
  @override
  String toString() => 'Loading';
}

class DeleteSignFromTemplateLoaded extends SignLibraryState {
  DeleteSignFromTemplateLoaded(this.template) : super([template]);
  final Template template;
  @override
  String toString() => 'DeleteSignFromTemplateLoaded { template $template }';
}

class DeleteSignFromTemplateError extends SignLibraryState {
  @override
  String toString() => 'DeleteSignFromTemplateError';
}

class UnFavouriteSignLoading extends SignLibraryState {
  @override
  String toString() => 'UnFavouriteSignLoading';
}

class UnFavouriteSignError extends SignLibraryState {
  @override
  String toString() => 'UnFavouriteSignError';
}

class UnFavouriteSignLoaded extends SignLibraryState {
  UnFavouriteSignLoaded(this.template) : super([template]);
  final Template template;
  @override
  String toString() => 'UnFavouriteSignLoaded { template $template }';
}

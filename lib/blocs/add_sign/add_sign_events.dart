import 'package:equatable/equatable.dart';
import 'package:signtracker/api/model/request/sign_request.dart';

abstract class AddSignEvent extends Equatable {
  AddSignEvent([List props = const []]) : super([props]);
  @override
  String toString() => 'AddSignEvent';
}

class AddSignAddSignEvent extends AddSignEvent {
  AddSignAddSignEvent(this.sign) : super([sign]);

  final SignRequest sign;

  @override
  String toString() => 'AddSignAddSignEvent $sign';
}

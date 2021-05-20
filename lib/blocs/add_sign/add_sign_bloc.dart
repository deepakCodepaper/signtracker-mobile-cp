import 'package:bloc/bloc.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/request/sign_request.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/blocs/add_sign/add_sign_events.dart';
import 'package:signtracker/blocs/add_sign/add_sign_states.dart';
import 'package:signtracker/repository/sign_repository.dart';

class AddSignBloc extends Bloc<AddSignEvent, AddSignState> {
  AddSignBloc(this.signRepository);

  final SignRepository signRepository;

  void addSign(Sign sign, int projectId, double latitude, double longitude,
      SignMasters signSelected, String status, bool withTraffic) {
    add(AddSignAddSignEvent(SignRequest().copy(sign.rebuild((b) {
      b
        ..projectId = projectId
        ..name = signSelected.name
        ..nameId = signSelected.idName
        ..signMasterId = signSelected.id
        ..lat = latitude
        ..lng = longitude
        ..status = status
        ..traffic = withTraffic ? 1 : 0;
    }))));
  }

  @override
  AddSignState get initialState => AddSignInitialState();

  @override
  Stream<AddSignState> mapEventToState(AddSignEvent event) async* {
    if (event is AddSignAddSignEvent) {
      yield AddSignUploadingState();
      final sign = await signRepository.createSign(event.sign);
      if (sign == null) {
        yield AddSignNotUploadedState('Unable to create sign');
      } else {
        yield AddSignUploadedState(sign);
      }
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signtracker/blocs/template/template_list_event.dart';
import 'package:signtracker/blocs/template/template_list_state.dart';
import 'package:signtracker/repository/project_repository.dart';

class TemplateListBloc extends Bloc<TemplateListEvent, TemplateListState> {
  TemplateListBloc(this.projectRepository);

  final ProjectRepository projectRepository;

  @override
  TemplateListState get initialState => InitialTemplateListState();

  void getTemplateListByParameters(
      String duration, String lanes, String closure) {
    add(GetTemplatesByParameterEvent(duration, lanes, closure));
  }

  void getTemplateListByDrawingNumber(String drawingNumber) {
    add(GetTemplatesByDrawingNumberEvent(drawingNumber));
  }

  @override
  Stream<TemplateListState> mapEventToState(TemplateListEvent event) async* {
    if (event is GetTemplatesByParameterEvent) {
      yield LoadingTemplatesState();
      final templates = await projectRepository.getTemplateParams(
          event.duration, event.lanes, event.closure);
      if (templates == null) {
        yield LoadingTemplatesFailedState();
      } else {
        yield LoadingTemplatesSuccessState(templates);
      }
    } else if (event is GetTemplatesByDrawingNumberEvent) {
      final templates =
          await projectRepository.getTemplateDrawingNumber(event.drawingNumber);
      if (templates == null) {
        yield LoadingTemplatesFailedState();
      } else {
        yield LoadingTemplatesSuccessState(templates);
      }
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:signtracker/api/model/request/sign_request.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/blocs/project/project_events.dart';
import 'package:signtracker/blocs/project/project_states.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/sign_repository.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc(this.projectRepository, this.signRepository);

  final ProjectRepository projectRepository;
  final SignRepository signRepository;

  void getProjectDetails(int id) {
    add(GetProjectDetails(id));
  }

  void loadProjectSigns(int id) {
    add(LoadSigns(id));
  }

  void completeSign(Sign sign) {
    add(UpdateSign(sign.rebuild((b) => b..status = 'completed')));
  }

  void deleteSign(int id) {
    add(DeleteSign(id));
  }

  void updateSignLocation(Sign sign, double lat, double lng) {
    add(UpdateSign(sign.rebuild((b) {
      b
        ..lat = lat
        ..lng = lng;
    })));
  }

  void updateSignStatus(Sign sign, String status) {
    add(UpdateSign(sign.rebuild((b) => b..status = status)));
  }

  @override
  ProjectState get initialState => ProjectInitial();

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    if (event is GetProjectDetails) {
      final project = await projectRepository.getProject(event.id);
      if (project == null) {
        yield ProjectNotLoaded('Unable to load project');
      } else {
        yield ProjectLoaded(project);
      }
    } else if (event is LoadSigns) {
      yield SignsLoading();
      final signs = await signRepository.fetchSignsByProject(event.id);
      if (signs?.isNotEmpty == true) {
        yield SignsLoaded(signs);
      } else {
        yield SignsNotLoaded('Unable to load project signs');
      }
    } else if (event is UpdateSign) {
      yield* _mapUpdateSign(event.sign);
    } else if (event is DeleteSign) {
      yield* _mapDeleteSign(event.signId);
    }
  }

  Stream<ProjectState> _mapUpdateSign(Sign sign) async* {
    final request = SignRequest().copy(sign);
    final updatedSign = await signRepository.updateSign(request, sign.id);
    yield SignsUpdating();
    if (updatedSign != null) {
      yield SignUpdated(updatedSign);
    } else {
      yield SignNotUpdated('Sign Not Updated');
    }
  }

  Stream<ProjectState> _mapDeleteSign(int signId) async* {
    final updatedSign = await signRepository.deleteSign(signId);
    yield SignsUpdating();
    if (updatedSign != null) {
      yield SignDeleted(signId);
    } else {
      yield SignNotUpdated('Sign Not Updated');
    }
  }
}

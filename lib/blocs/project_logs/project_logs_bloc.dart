import 'package:bloc/bloc.dart';
import 'package:signtracker/blocs/project_logs/project_logs_events.dart';
import 'package:signtracker/blocs/project_logs/project_logs_states.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/sign_repository.dart';

class ProjectLogsBloc extends Bloc<ProjectLogsEvent, ProjectLogsState> {
  ProjectLogsBloc(this.signRepository, this.projectRepository);

  SignRepository signRepository;
  ProjectRepository projectRepository;

  void loadLogs(int projectId) {
    add(LoadProjectLogs(projectId));
  }

  void closeProject(
      int projectId, bool existingsSignsUncovered, bool signsRemoved) {
    add(CloseProject(projectId, existingsSignsUncovered, signsRemoved));
  }

  @override
  ProjectLogsState get initialState => ProjectLogsInitial();

  @override
  Stream<ProjectLogsState> mapEventToState(ProjectLogsEvent event) async* {
    if (event is LoadProjectLogs) {
      yield LogsLoading();
      final projectlogs =
          await projectRepository.getProjectLogs(event.projectId);
      if (projectlogs?.isNotEmpty == true) {
        yield LogsLoaded(projectlogs.reversed.toList());
      } else {
        yield LogsErrorLoading('No logs available.');
      }
    } else if (event is CloseProject) {
      yield ClosingProject();
      final result = await projectRepository.closeProject(
          event.projectId, event.existingsSignsUncovered, event.signsRemoved);
      if (result == true) {
        yield ProjectClosed();
      } else {
        yield ProjectClosingError('Unable to close project.');
      }
    }
  }
}

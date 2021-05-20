import 'package:bloc/bloc.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/adjust_settings/adjust_settings_events.dart';
import 'package:signtracker/blocs/adjust_settings/adjust_settings_states.dart';
import 'package:signtracker/repository/project_repository.dart';

class AdjustSettingsBloc
    extends Bloc<AdjustSettingsEvent, AdjustSettingsState> {
  AdjustSettingsBloc(this.projectRepository);

  final ProjectRepository projectRepository;

  void saveSettings(
    SignProject project,
    double notifyFrequency,
    double inactiveNotifyFrequency,
    double signPlacement,
    String startDate,
    String endDate,
    String comment,
  ) {
    add(DoneIsClicked(project.rebuild((b) => b
      ..method = 'PUT'
      ..notifyFrequency = notifyFrequency.toInt()
      ..inactiveNotifyFrequency = inactiveNotifyFrequency.toInt()
      ..distance = signPlacement
      ..signPlacement = signPlacement.toString()
      ..startDate = startDate
      ..endDate = endDate
      ..shortSummary = comment)));
  }

  void uploadImage(SignProject project, String image) {
    add(ImageReceivedFromGallery(project.rebuild((b) => b
      ..method = 'PUT'
      ..plan = image
      ..templateId = 1
      ..type = 'Default')));
  }

  void changePlanUrl(SignProject project, String image) {
    add(ImageFromTemplate(project.rebuild((b) => b
      ..method = 'PUT'
      ..plan = image)));
  }

  void closeProject(
      int projectId, bool existingsSignsUncovered, bool signsRemoved) {
    add(CloseProject(projectId, existingsSignsUncovered, signsRemoved));
  }

  @override
  AdjustSettingsState get initialState => AdjustSettingsInitial();

  @override
  Stream<AdjustSettingsState> mapEventToState(
      AdjustSettingsEvent event) async* {
    if (event is DoneIsClicked) {
      yield AdjustSettingsLoading();
      final result = await projectRepository.updatePropject(event.project);
      if (result == null) {
        yield AdjustSettingsFailure('Unable to update project');
      } else {
        yield AdjustSettingsSuccess(result);
      }
    } else if (event is ImageReceivedFromGallery) {
      yield AdjustSettingsLoading();
      final result =
          await projectRepository.updateProjectWithImage(event.project);
      if (result == null) {
        yield AdjustSettingsFailure('Unable to update project');
      } else {
        yield AdjustSettingsSuccess(result);
      }
    } else if (event is ImageFromTemplate) {
      yield AdjustSettingsLoading();
      final result =
          await projectRepository.updateProjectWithImage(event.project);
      if (result == null) {
        yield AdjustSettingsFailure('Unable to update project');
      } else {
        yield AdjustSettingsSuccess(result);
      }
    } else if (event is CloseProject) {
      yield ClosingProject();
      final result = await projectRepository.closeProject(
        event.projectId,
        event.existingsSignsUncovered,
        event.signsRemoved,
      );
      if (result == true) {
        yield ProjectClosed();
      } else {
        yield ProjectClosingError('Unable to close project.');
      }
    }
  }
}

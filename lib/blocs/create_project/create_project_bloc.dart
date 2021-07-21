import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:signtracker/api/model/invite.dart';
import 'package:signtracker/api/model/request/project_create_request.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';

part 'create_project_event.dart';

part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc(this.projectRepository, this.invitationRepository);

  final ProjectRepository projectRepository;
  final InvitationRepository invitationRepository;

  void saveSettings(
    SignProject project,
    String projectname,
  ) {
    add(DoneIsClicked(project.rebuild(
      (b) => b
        ..method = 'PUT'
        ..contractNumber = projectname
        ..identifier = projectname,
    )));
  }

  void uploadImage(SignProject project, String image) {
    add(ImageReceivedFromGallery(project.rebuild((b) => b
      ..method = 'PUT'
      ..plan = image
      ..type = 'Default'
      ..templateId = 1)));
  }

  void createProject(
      SignProject signProject,
      String projectId,
      String type,
      String highway,
      String intersection,
      int templateId,
      double distance,
      String commissionedBy) {
    if (projectId != null && projectId.isNotEmpty) {
      add(CreateCreateProjectEvent(signProject.rebuild((b) {
        b
          ..identifier = projectId
          ..contractNumber = projectId
          ..commissionedBy = commissionedBy
          ..type = type
          ..highway = highway
          ..intersection = intersection
          ..templateId = templateId
          ..distance = distance
          ..startDate = signProject.startDate
          ..endDate = signProject.endDate
          ..notifyFrequency = 120
          ..inactiveNotifyFrequency = 240;
      })));
    } else {
      add(CreateCreateProjectEvent(signProject.rebuild((b) {
        b
          ..commissionedBy = commissionedBy
          ..type = type
          ..highway = highway
          ..intersection = intersection
          ..templateId = templateId
          ..distance = distance
          ..startDate = signProject.startDate
          ..endDate = signProject.endDate
          ..notifyFrequency = 120
          ..inactiveNotifyFrequency = 240;
      })));
    }
  }

  void createProjectWithImage(
    SignProject signProject,
    String projectId,
    String plan,
    String type,
    String highway,
    String intersection,
    int templateId,
    double distance,
    String commissionedBy,
  ) {
    add(CreateCreateProjectWithImageEvent(
        ProjectCreateRequest().copyWithImage(signProject.rebuild((b) {
      b
        ..identifier = projectId
        ..contractNumber = projectId
        ..commissionedBy = commissionedBy
        ..plan = plan
        ..type = type
        ..highway = highway
        ..intersection = intersection
        ..templateId = templateId
        ..distance = distance
        ..startDate = signProject.startDate
        ..endDate = signProject.endDate
        ..notifyFrequency = 120
        ..inactiveNotifyFrequency = 240;
    }))));
  }

  void createSubProject(
    SignProject signProject,
    int parentId,
    File plan,
    String type,
    int highway,
    int intersection,
    int templateId,
  ) {
    add(CreateCreateProjectEvent(signProject));
  }

  void sendMemberInvite(int projectId, int memberId) {
    add(SendMemberInviteForProjectEvent(new Invite().rebuild((b) {
      b
        ..userId = memberId
        ..projectId = projectId
        ..notes = '';
    })));
  }

  void getTemplateId(String templateName) {
    add(GetTemplateNameEvent(templateName));
  }

  @override
  CreateProjectState get initialState => InitialCreateProjectState();

  @override
  Stream<CreateProjectState> mapEventToState(CreateProjectEvent event) async* {
    if (event is CreateCreateProjectEvent) {
      yield CreateProjectUploadingState();
      final project = await projectRepository.createProject(event.project);
      if (project == null) {
        yield CreateProjectNotUploadedState('Unable to create project');
      } else {
        yield CreateProjectUploadedState(project);
      }
    } else if (event is CreateCreateProjectWithImageEvent) {
      yield CreateProjectUploadingState();
      final project =
          await projectRepository.createProjectWithImage(event.project);
      if (project == null) {
        yield CreateProjectNotUploadedState('Unable to create project');
      } else {
        yield CreateProjectUploadedState(project);
      }
    } else if (event is SendMemberInviteForProjectEvent) {
      yield SendingMemberInviteForProjectState(event.invite);
      final inviteProject = await invitationRepository.sendInvite(event.invite);
      if (inviteProject == null) {
        yield SendMemberInviteFailedState();
      } else {
        yield SendMemberInviteSuccessState();
      }
    } else if (event is ImageReceivedFromGallery) {
      yield CreateProjectUploadingState();
      final result =
          await projectRepository.updateProjectWithImage(event.project);
      if (result == null) {
        yield CreateProjectNotUploadedState('Unable to update project');
      } else {
        yield CreateProjectUploadedState(result);
      }
    } else if (event is DoneIsClicked) {
      yield CreateProjectUploadingState();
      final project = await projectRepository.updatePropject(event.project);
      if (project == null) {
        yield CreateProjectNotUploadedState('Unable to create project');
      } else {
        yield CreateProjectUploadedState(project);
      }
    } else if (event is GetTemplateNameEvent) {
      yield LoadingTemplateIdState();
      final templates = await projectRepository.getTemplate(event.templateName);
      if (templates == null) {
        yield LoadingTemplateIdFailedState();
      } else {
        yield LoadingTemplateIdSuccessState(templates);
      }
    }
  }
}

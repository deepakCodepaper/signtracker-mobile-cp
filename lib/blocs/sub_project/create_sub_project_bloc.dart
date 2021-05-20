import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:signtracker/api/model/emails.dart';
import 'package:signtracker/api/model/request/project_create_request.dart';
import 'package:signtracker/api/model/schedule.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/repository/project_repository.dart';

part 'create_sub_project_event.dart';

part 'create_sub_project_state.dart';

class CreateSubProjectBloc
    extends Bloc<CreateSubProjectEvent, CreateSubProjectState> {
  CreateSubProjectBloc(this.projectRepository);

  final ProjectRepository projectRepository;

  void createProject(SignProject signProject, int parentId, String projectId,
      String type, String highway, String intersection, int templateId) {
    add(CreateCreateSubProjectEvent(signProject.rebuild((b) {
      b
        ..parent = parentId
        ..identifier = projectId
        ..type = type
        ..highway = highway
        ..intersection = intersection
        ..templateId = templateId;
    })));
  }

  void getEmailRecipients(SignProject signProject) {
    add(GetEmailRecipients(signProject));
  }

  void updateEmailRecipients(
      BuiltList<String> emails, SignProject signProject) {
    add(UpdateEmailRecipient(emails, signProject));
  }

  void getSchedule(SignProject signProject) {
    add(GetScheduleReports(signProject));
  }

  void setSchedule(SignProject signProject, String daily, String weekly,
      String time, String day, String hourly, String minute, String meridian) {
    add(SetScheduleReports(
        signProject, daily, weekly, time, day, hourly, minute, meridian));
  }

  void sendNow(SignProject signProject) {
    add(SendReportNow(signProject));
  }

  @override
  CreateSubProjectState get initialState => InitialCreateProjectState();

  @override
  Stream<CreateSubProjectState> mapEventToState(
      CreateSubProjectEvent event) async* {
    if (event is CreateCreateSubProjectEvent) {
      yield CreateProjectUploadingState();
      final project = await projectRepository.createSubProject(event.project);
      if (project == null) {
        yield CreateProjectNotUploadedState('Unable to create project');
      } else {
        yield CreateProjectUploadedState(project);
      }
    } else if (event is GetEmailRecipients) {
      yield GettingRecipientsState();
      final emails =
          await projectRepository.getEmailsFromProject(event.project.id);
      if (emails == null) {
        yield RecipientsFailed('Failed to fetch recipients');
      } else {
        yield RecipientsReceived(emails);
      }
    } else if (event is UpdateEmailRecipient) {
      yield GettingRecipientsState();
      final updatedEmails = await projectRepository.updateEmailsFromProject(
          event.emails, event.project.id);
      if (updatedEmails == null) {
        yield RecipientsFailed('Failed to fetch recipients');
      } else {
        yield RecipientsReceived(updatedEmails);
      }
    } else if (event is GetScheduleReports) {
      yield GetScheduleLoading();
      final schedule =
          await projectRepository.getReportSchedule(event.project.id);
      if (schedule == null) {
        yield GetScheduleError();
      } else {
        yield GetScheduleLoaded(schedule);
      }
    } else if (event is SetScheduleReports) {
      yield GetScheduleLoading();
      final schedule = await projectRepository.setReportSchedule(
          event.signProject.id,
          event.daily,
          event.weekly,
          event.time,
          event.day,
          event.hour,
          event.minute,
          event.meridian);
      if (schedule == null) {
        yield SetScheduleError();
      } else {
        yield SetScheduleLoaded(schedule);
      }
    } else if (event is SendReportNow) {
      yield GetScheduleLoading();
      final schedule =
          await projectRepository.sendReportNow(event.signProject.id);
      if (schedule == null) {
        yield SendReportNowFailed();
      } else {
        yield SendReportNowLoaded(schedule);
      }
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:signtracker/api/model/project_notification.dart';
import 'package:signtracker/api/model/request/project_notification_request.dart';
import '../../repository/project_repository.dart';

part 'project_notification_event.dart';
part 'project_notification_state.dart';

class ProjectNotificationBloc extends Bloc<ProjectNotificationEvent, ProjectNotificationState> {

  ProjectNotificationBloc(this.projectRepository);

  final ProjectRepository projectRepository;
  List<ProjectNotification> projectNotification;

  void addNotificationTime(
      int id,
      String day,
      String time
      ){
    add(AddIsClicked(ProjectNotificationRequest().rebuild((b) => b
      ..projectId = id
      ..day = day
      ..time = time)));
  }

  void deleteNotificationTime(int id){
    add(DeleteIsClicked(id));
  }

  void getNotificationTime(int id) async{
    add(InitialLoading(id));
  }

  @override
  ProjectNotificationState get initialState => ProjectNotificationInitialState();

  @override
  Stream<ProjectNotificationState> mapEventToState(ProjectNotificationEvent event) async* {

    if(event is AddIsClicked){
      yield ProjectNotificationLoading();
      final result = await projectRepository.addProjectNotification(event.request);
      if(result == null){
        yield ProjectNotificationFailure("unable to add time");
      }else{
        yield ProjectNotificationLoaded(result,false);
      }
    }else if(event is DeleteIsClicked){
      yield ProjectNotificationLoading();
      final result = await projectRepository.deleteNotificationTime(event.id);
      if(result == null){
        yield ProjectNotificationFailure("unable to delete time");
      }else{
        yield ProjectNotificationLoaded(result,false);
      }
    }else if(event is InitialLoading){
      yield ProjectNotificationLoading();
      projectNotification = await projectRepository.getProjectNotificationList(event.id);
      if(projectNotification == null){
        yield ProjectNotificationFailure("unable to delete time");
      }else{
        yield ProjectNotificationLoaded(projectNotification,true);
      }
    }
  }

}

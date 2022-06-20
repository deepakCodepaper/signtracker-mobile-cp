import 'package:bloc/bloc.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/project_list/project_list_events.dart';
import 'package:signtracker/blocs/project_list/project_list_states.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/user_repository.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc(
    this.projectRepository,
    this.invitationRepository,
    this.userRepository,
  );

  final ProjectRepository projectRepository;
  final InvitationRepository invitationRepository;
  final UserRepository userRepository;
  int page = 1;
  List<SignProject> projectList = [];
  List<SignProject> projects;

  @override
  ProjectListState get initialState => ProjectListInitial();

  void getProjects() {
    print("========Call get pro======");
    add(LoadProjects());
  }

  void reloadProjects() {
    print("========Call get REpro======");
    add(ReloadProjects());
  }

  void fetchProjectList(){
  print("========Call get Fetch======");
  add(FetchNextPage());
}

  @override
  Stream<ProjectListState> mapEventToState(ProjectListEvent event) async* {
    if (event is LoadProjects || event is ReloadProjects || event is FetchNextPage) {
      print("========Call Method======");
      if (event is ReloadProjects) {
        print("========Call RELoad Project======");
        projectList = [];
        page = 1;
          yield ReloadingProjects();
      } else if(event is FetchNextPage){
        print("========Call Fetch Project======");
        if(page!=0) {
          page++;
          yield ProjectsLoading();
        }
      }else{
        print("========Call Load Project======");
        print("Call Load Project=========" + page.toString());
        yield ProjectsLoading();
      }

      //print("PAGE NO============ " + page.toString());
      if(page!=0) {
        projects = await projectRepository.getProjectList(page);
        //print("PROJECT LENGHT============ " + projects.length.toString());
        if (projects == null) {
          //print("========Call IF Project======");
          yield ProjectsError('Unable to load projects');
        } else if (projects.length == 0) {
          yield ProjectsListEmpty('No More Projects');
          page = 0;
        } else {
          //print("========Call Else Project======");
          projectList.addAll(projects);
          //print("PROJECT LENGHT updated============ " +projectList.length.toString());
          //print("PROJECT DATA+======" + projectList.toString());
          yield ProjectsLoaded(projectList);
        }
      }
//      final invitations = await invitationRepository.getInvitations();
//      if (invitations == null) {
//        yield ProjectsError('Unable to load project list.');
//      }
//      final user = await userRepository.getUserDetails();
//      if (user == null) {
//        yield ProjectsError('Unable to load projects');
//      }

//      final userProjects = <SignProject>[];
//
//      projects.forEach((project) {
//        if (user.id == project.startedBy && project.status != 'completed')
//          userProjects.add(project);
//      });
//
//      final userInvitations = invitations.where((invitation) {
//        return invitation.userId == user.id;
//      });
//      userInvitations.forEach((invitation) {
//        final userProject = projects.where((project) {
//          return project.userIds?.isEmpty != false ||
//              user.id == project.startedBy;
//        }).firstWhere((project) {
//          return project.id == invitation.projectId;
//        });
//        if (userProject != null) userProjects.add(userProject);
//      });

//      yield ProjectsLoaded(userProjects);
    }
  }
}

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

  @override
  ProjectListState get initialState => ProjectListInitial();

  void getProjects() {
    add(LoadProjects());
  }

  void reloadProjects() {
    add(ReloadProjects());
  }

  @override
  Stream<ProjectListState> mapEventToState(ProjectListEvent event) async* {
    if (event is LoadProjects || event is ReloadProjects) {
      if (event is ReloadProjects) {
        yield ReloadingProjects();
      } else {
        yield ProjectsLoading();
      }

      final projects = await projectRepository.getProjects();
      if (projects == null) {
        yield ProjectsError('Unable to load projects');
      } else {
        yield ProjectsLoaded(projects);
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

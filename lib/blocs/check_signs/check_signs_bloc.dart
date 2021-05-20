import 'package:bloc/bloc.dart';
import 'package:signtracker/api/model/check_sign_project.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/check_signs/check_signs_events.dart';
import 'package:signtracker/blocs/check_signs/check_signs_states.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/user_repository.dart';

class CheckSignsBloc extends Bloc<CheckSignsEvent, CheckSignsState> {
  CheckSignsBloc(
    this.projectRepository,
    this.invitationRepository,
    this.userRepository,
  );

  final ProjectRepository projectRepository;
  final InvitationRepository invitationRepository;
  final UserRepository userRepository;

  @override
  CheckSignsState get initialState => CheckSignsInitial();

  void loadInvitations() {
    add(LoadInvitations());
  }

  void loadProjects() {
    add(LoadProjects());
  }

  void acceptInvitation(int invitationId) {
    add(AcceptInvitation(invitationId));
  }

  void dismissInvitation(int invitationId) {
    add(DismissInvitation(invitationId));
  }

  void loadUpComingChecks() {
    add(LoadUpcomingChecks());
  }

  void startCheck(int checkId) {
    add(StartCheck(checkId));
  }

  Map<String, List<Invitation>> groupInvitations(List<Invitation> invitations) {
    final todayProjects = <Invitation>[];
    final yesterdayProjects = <Invitation>[];
    final thisWeekProjects = <Invitation>[];
    final thisMonthProjects = <Invitation>[];
    final thisYearProjects = <Invitation>[];
    final otherProjects = <Invitation>[];
    final dayToday = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    var weeksStartingDate = DateTime.now();
    if (DateTime.now().weekday < DateTime.sunday) {
      weeksStartingDate =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    }
    invitations.forEach((invitation) {
      if (invitation.updatedAt.day == dayToday &&
          invitation.updatedAt.month == month &&
          invitation.updatedAt.year == year) {
        todayProjects.add(invitation);
      } else if (invitation.updatedAt.day == dayToday - 1 &&
          invitation.updatedAt.month == month &&
          invitation.updatedAt.year == year) {
        yesterdayProjects.add(invitation);
      } else if (invitation.updatedAt.isAfter(weeksStartingDate)) {
        thisWeekProjects.add(invitation);
      } else if (invitation.updatedAt.month == month) {
        thisMonthProjects.add(invitation);
      } else if (invitation.updatedAt.year == year) {
        thisYearProjects.add(invitation);
      } else {
        otherProjects.add(invitation);
      }
    });
    final map = Map<String, List<Invitation>>();
    if (todayProjects.isNotEmpty) {
      map['Today'] = todayProjects;
    }
    if (yesterdayProjects.isNotEmpty) {
      map['Yesterday'] = yesterdayProjects;
    }
    if (thisWeekProjects.isNotEmpty) {
      map['This Week'] = thisWeekProjects;
    }
    if (thisMonthProjects.isNotEmpty) {
      map['This Month'] = thisMonthProjects;
    }
    if (thisYearProjects.isNotEmpty) {
      map['This Year'] = thisYearProjects;
    }
    if (otherProjects.isNotEmpty) {
      map['Other'] = otherProjects;
    }
    return map;
  }

  Map<String, List<SignProject>> groupSignProjects(List<SignProject> projects) {
    final todayProjects = <SignProject>[];
    final yesterdayProjects = <SignProject>[];
    final thisWeekProjects = <SignProject>[];
    final thisMonthProjects = <SignProject>[];
    final thisYearProjects = <SignProject>[];
    final otherProjects = <SignProject>[];
    final dayToday = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    var weeksStartingDate = DateTime.now();
    if (DateTime.now().weekday < DateTime.sunday) {
      weeksStartingDate =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    }
    projects.forEach((project) {
      if (project.updatedAt.day == dayToday &&
          project.updatedAt.month == month &&
          project.updatedAt.year == year) {
        todayProjects.add(project);
      } else if (project.updatedAt.day == dayToday - 1 &&
          project.updatedAt.month == month &&
          project.updatedAt.year == year) {
        yesterdayProjects.add(project);
      } else if (project.updatedAt.isAfter(weeksStartingDate)) {
        thisWeekProjects.add(project);
      } else if (project.updatedAt.month == month) {
        thisMonthProjects.add(project);
      } else if (project.updatedAt.year == year) {
        thisYearProjects.add(project);
      } else {
        otherProjects.add(project);
      }
    });
    final map = Map<String, List<SignProject>>();
    if (todayProjects.isNotEmpty) {
      map['Today'] = todayProjects;
    }
    if (yesterdayProjects.isNotEmpty) {
      map['Yesterday'] = yesterdayProjects;
    }
    if (thisWeekProjects.isNotEmpty) {
      map['This Week'] = thisWeekProjects;
    }
    if (thisMonthProjects.isNotEmpty) {
      map['This Month'] = thisMonthProjects;
    }
    if (thisYearProjects.isNotEmpty) {
      map['This Year'] = thisYearProjects;
    }
    if (otherProjects.isNotEmpty) {
      map['Other'] = otherProjects;
    }
    return map;
  }

  Map<String, List<CheckSignProject>> groupCheckSigns(
      List<CheckSignProject> projects) {
//    projects = projects.reversed.toList();

    var upcomingSignChecks = <CheckSignProject>[];
    final pastDueSignChecks = <CheckSignProject>[];

    projects.forEach((project) {
      if (project.status == 'upcoming') {
        upcomingSignChecks.add(project);
      } else {
        pastDueSignChecks.add(project);
      }
    });
    upcomingSignChecks = upcomingSignChecks.reversed.toList();
    final map = Map<String, List<CheckSignProject>>();
    if (upcomingSignChecks.isNotEmpty) {
      map['Upcoming'] = upcomingSignChecks;
    }
    if (pastDueSignChecks.isNotEmpty) {
      map['Missed Sign Checks'] = pastDueSignChecks;
    }

    return map;
  }

  @override
  Stream<CheckSignsState> mapEventToState(CheckSignsEvent event) async* {
    if (event is LoadInvitations) {
      yield LoadingInvitations();

      final invitations = await invitationRepository.getInvitations();

      if (invitations == null) {
        yield InvitationsLoadingError('Unable to load invitations.');
      } else {
        final userInvitations = <Invitation>[];

        invitations.forEach((invitation) async {
          final project =
              await projectRepository.getProject(invitation.projectId);
          if (project != null) {
            userInvitations
                .add(invitation.rebuild((b) => b.project.replace(project)));
          }
        });

        yield InvitationsLoaded(groupInvitations(userInvitations));
      }
    }
    if (event is AcceptInvitation) {
      yield AcceptingInvitation();
      final accepted = await invitationRepository.acceptInvite(event.inviteId);
      if (accepted == null) {
        yield AcceptingInvitationFailed();
      } else {
        yield AcceptingInvitationSuccess();
      }
    }

    if (event is DismissInvitation) {
      yield DismissingInvitation();
      final dismissed =
          await invitationRepository.dismissInvite(event.inviteId);
      if (dismissed == null) {
        yield DismissingInvitationFailed();
      } else {
        yield DismissingInvitationSuccess();
      }
    }

    if (event is LoadProjects) {
      yield LoadingInvitations();
      final projects = await projectRepository.getProjects();
      if (projects == null) {
        yield ProjectLoadingError('Unable to load projects');
      } else {
//      final invitations = await invitationRepository.getInvitations();
//      if (invitations == null) {
//        yield ProjectLoadingError('Unable to load projects');
//      }
//      final user = await userRepository.getUserDetails();
//      if (user == null) {
//        yield ProjectLoadingError('Unable to load projects');
//      }
//        final userProjects = <SignProject>[];
//        final userInvitations =
//            invitations.where((invitation) => invitation.userId == user.id);
//        userInvitations.forEach((invitation) {
//          final userProject = projects
//              .where((project) => project.userIds?.isEmpty != false)
//              .firstWhere((project) => project.id == invitation.projectId);
//          if (userProject != null) userProjects.add(userProject);
//        });
//        projects.forEach((project) {
//          if (user.id == project.startedBy) userProjects.add(project);
//        });
        yield ProjectsLoaded(groupSignProjects(projects));
      }
    }

    if (event is LoadUpcomingChecks) {
      yield LoadingInvitations();
      final projects = await projectRepository.getUpcomingChecks();
      if (projects == null) {
        yield ProjectLoadingError('Unable to load projects');
      } else {
//      final invitations = await invitationRepository.getInvitations();
//      if (invitations == null) {
//        yield ProjectLoadingError('Unable to load projects');
//      }
//      final user = await userRepository.getUserDetails();
//      if (user == null) {
//        yield ProjectLoadingError('Unable to load projects');
//      }
//        final userProjects = <SignProject>[];
//        final userInvitations =
//            invitations.where((invitation) => invitation.userId == user.id);
//        userInvitations.forEach((invitation) {
//          final userProject = projects
//              .where((project) => project.userIds?.isEmpty != false)
//              .firstWhere((project) => project.id == invitation.projectId);
//          if (userProject != null) userProjects.add(userProject);
//        });
//        projects.forEach((project) {
//          if (user.id == project.startedBy) userProjects.add(project);
//        });
        yield CheckSignsProjectLoaded(groupCheckSigns(projects));
      }
    }

    if (event is StartCheck) {
      yield StartCheckLoading();
      final project = await projectRepository.startSignCheck(event.checkId);
      if (project == null) {
        yield StartCheckError('Schedule sign started by another user');
      } else {
//      final invitations = await invitationRepository.getInvitations();
//      if (invitations == null) {
//        yield ProjectLoadingError('Unable to load projects');
//      }
//      final user = await userRepository.getUserDetails();
//      if (user == null) {
//        yield ProjectLoadingError('Unable to load projects');
//      }
//        final userProjects = <SignProject>[];
//        final userInvitations =
//            invitations.where((invitation) => invitation.userId == user.id);
//        userInvitations.forEach((invitation) {
//          final userProject = projects
//              .where((project) => project.userIds?.isEmpty != false)
//              .firstWhere((project) => project.id == invitation.projectId);
//          if (userProject != null) userProjects.add(userProject);
//        });
//        projects.forEach((project) {
//          if (user.id == project.startedBy) userProjects.add(project);
//        });
        yield StartCheckLoaded(project);
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:signtracker/api/model/check_sign_project.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/check_signs/check_signs_bloc.dart';
import 'package:signtracker/blocs/check_signs/check_signs_states.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/widgets/app_bar.dart';

class CheckSignsPageArgs {
  CheckSignsPageArgs(this.isFromNotification);

  final bool isFromNotification;
}

class CheckSignsPage extends StatefulWidget {
  const CheckSignsPage(this.isFromNotification);

  static const String route = '/check-signs';

  final bool isFromNotification;

  @override
  State<StatefulWidget> createState() => _CheckSignsPageState();
}

class _CheckSignsPageState extends State<CheckSignsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat dateFormat = DateFormat('dd MMM yyyy HH:mm');
  CheckSignsBloc bloc;
  ProgressDialog pr;
  SignProject selectedSignProject;

  List<int> startedCheckSignProjects = new List<int>();
  List<_ListItem> list = <_ListItem>[];
  CheckSignProject selectedProjectToStart;
  int selectedIndex;

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  @override
  void initState() {
    bloc = CheckSignsBloc(
        ProjectRepository(), InvitationRepository(), UserRepository());

    bloc.loadUpComingChecks();
    pr = new ProgressDialog(context);

    super.initState();
  }

  Future<void> routeToMapPage(SignProject project) async {
    await Navigator.pushNamed(
      context,
      ProjectMapPage.route,
      arguments: ProjectMapPageArgs(null, project, false, true, false, false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SignTrackerAppBar.createAppBar(context, 'Check Signs'),
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) async {
          if (state is InvitationsLoadingError) {
            showMessage(state.error);
          }
          if (state is AcceptingInvitation) {
            pr.show();
          }
          if (state is AcceptingInvitationFailed) {
            pr.hide();
            showMessage("Invitation acceptance failed");
          }
          if (state is AcceptingInvitationSuccess) {
            pr.hide();
            routeToMapPage(selectedSignProject);
          }
          if (state is DismissingInvitation) {
            pr.show();
          }
          if (state is DismissingInvitationFailed) {
            pr.hide().then((isHidden) {
              print(isHidden);
              showMessage("Invitation acceptance failed");
            });
          }
          if (state is DismissingInvitationSuccess) {
            pr.hide();
          }
          if (state is ProjectLoadingError) {
            showMessage(state.error);
          }

          if (state is StartCheckLoading) {
            pr.show();
          }

          if (state is StartCheckError) {
            pr.hide();
            showMessage(
                "A user has already started the sign check for this schedule.");
          }

          if (state is CheckSignsProjectLoaded &&
              state.projects?.isNotEmpty == true) {
            state.projects.forEach(
              (title, projects) {
                list.add(_HeadingItem(title));
                list.addAll(projects.map((project) =>
                    !startedCheckSignProjects.contains(project.id)
                        ? _CheckSignsItem2(project)
                        : null));
              },
            );
          }

          if (state is StartCheckLoaded) {
            pr.hide();
            await routeToMapPage(selectedProjectToStart.project);

            setState(() {
              list.removeAt(selectedIndex);
            });
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
//            if (state is InvitationsLoaded &&
//                state.invitations?.isNotEmpty == true) {
//              final list = <_ListItem>[];
//              state.invitations.forEach((title, invitations) {
//                list.add(_HeadingItem(title));
//                list.addAll(invitations
//                    .map((invitation) => _CheckSignsItem(invitation)));
//              });
//
//              return ListView.separated(
//                itemBuilder: (context, index) {
//                  if (list[index] is _HeadingItem) {
//                    final item = list[index] as _HeadingItem;
//                    return Container(
//                      color: Colors.grey,
//                      padding:
//                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                      child: Text(
//                        item.heading,
//                        style: GoogleFonts.karla(
//                            fontWeight: FontWeight.w700,
//                            textStyle:
//                                TextStyle(color: Colors.white, fontSize: 15)),
//                      ),
//                    );
//                  } else {
//                    final item = list[index] as _CheckSignsItem;
//                    return Slidable(
//                      actionPane: SlidableDrawerActionPane(),
//                      actionExtentRatio: 0.25,
//                      child: Container(
//                        padding:
//                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                        child: Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Container(
//                              margin: EdgeInsets.only(top: 5),
//                              height: 12,
//                              width: 12,
//                              decoration: BoxDecoration(
//                                shape: BoxShape.circle,
//                                color: Colors.green,
//                              ),
//                            ),
//                            SizedBox(width: 20),
//                            Text(
//                              'Project ${item.invitation.project?.identifier ?? '${item.invitation.project?.contractNumber}'}',
//                              style: GoogleFonts.karla(
//                                  fontWeight: FontWeight.w700,
//                                  textStyle: TextStyle(
//                                      color: Colors.black, fontSize: 15)),
//                            ),
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                SizedBox(height: 5),
//                                Expanded(
//                                  child: Text(
//                                    '${item.invitation.project?.subProjects?.length ?? 0} Sub Projects',
//                                    style: GoogleFonts.karla(
//                                        textStyle: TextStyle(
//                                            color: Colors.grey, fontSize: 12)),
//                                    overflow: TextOverflow.visible,
//                                  ),
//                                ),
//                                Text(
//                                  dateFormat.format(item.invitation.updatedAt ??
//                                      item.invitation.createdAt),
//                                  style: GoogleFonts.karla(
//                                      textStyle: TextStyle(
//                                          color: Colors.grey, fontSize: 12)),
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                      secondaryActions: [
//                        SlideAction(
//                          onTap: () => {
////                            dismissProjectInvite(item.invitation),
////                            selectedSignProject = item.invitation.project,
//                          },
//                          decoration: BoxDecoration(
//                            color: Colors.grey,
//                          ),
//                          child: Text(
//                            'Close',
//                            style: GoogleFonts.karla(
//                                fontStyle: FontStyle.normal,
//                                textStyle: TextStyle(
//                                    color: Colors.black, fontSize: 14)),
//                          ),
//                        ),
//                        SlideAction(
//                          onTap: () => {
//                            routeToMapPage(
//                              item.invitation.project,
//                            ),
//                          },
//                          color: AppColors.yellowPrimary,
//                          child: Text(
//                            'Open',
//                            style: GoogleFonts.karla(
//                                fontStyle: FontStyle.normal,
//                                textStyle: TextStyle(
//                                    color: Colors.black, fontSize: 14)),
//                          ),
//                        ),
//                      ],
//                    );
//                  }
//                },
//                separatorBuilder: (context, index) => Divider(
//                  color: Colors.grey,
//                  height: 1,
//                ),
//                itemCount: list.length,
//              );
//            }

            if (state is LoadingInvitations) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CheckSignsProjectLoaded &&
                state.projects?.isEmpty == true) {
              return Center(
                child: Text('No Sign Checks Available'),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                if (list[index] is _HeadingItem) {
                  final item = list[index] as _HeadingItem;
                  return Container(
                    color: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      item.heading,
                      style: GoogleFonts.karla(
                          fontWeight: FontWeight.w700,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  );
                } else {
                  final item = list[index] as _CheckSignsItem2;
                  return Slidable(
                    startActionPane: ActionPane(
                        motion: DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        InkWell(
                          onTap: () => {
                            selectedIndex = index,
                            selectedProjectToStart = item.project,
                            bloc.startCheck(item.project.id),
                          },
                          child: Container(
                            height: 90,
                            padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${item.project.project.identifier ?? '${item.project.project.contractNumber}'}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${item.project.project.highway}:${item.project.project.intersection}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Schedule:',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            dateFormat
                                                .format(item.project.schedule),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //actionPane: SlidableDrawerActionPane(),
                    //actionExtentRatio: 0.25,
                    /*child: InkWell(
                      onTap: () => {
                        selectedIndex = index,
                        selectedProjectToStart = item.project,
                        bloc.startCheck(item.project.id),
                      },
                      child: Container(
                        height: 90,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${item.project.project.identifier ?? '${item.project.project.contractNumber}'}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${item.project.project.highway}:${item.project.project.intersection}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Schedule:',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        dateFormat
                                            .format(item.project.schedule),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),*/
//                    secondaryActions: [
//                      SlideAction(
//                        onTap: () => {
//                          selectedIndex = index,
//                          selectedProjectToStart = item.project,
//                          bloc.startCheck(item.project.id),
//                        },
//                        color: AppColors.yellowPrimary,
//                        child: Text(
//                          'Start',
//                          style: GoogleFonts.karla(
//                              fontStyle: FontStyle.normal,
//                              textStyle:
//                                  TextStyle(color: Colors.black, fontSize: 14)),
//                        ),
//                      ),
//                    ],
                  );
                }
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 1,
              ),
              itemCount: list.length,
            );
          },
        ),
      ),
    );
  }

  void acceptProjectInvite(Invitation invitation) {
    bloc.acceptInvitation(invitation.id);
  }

  void dismissProjectInvite(Invitation invitation) {
    bloc.dismissInvitation(invitation.id);
  }
}

abstract class _ListItem {}

class _HeadingItem implements _ListItem {
  const _HeadingItem(this.heading);

  final String heading;
}

class _CheckSignsItem implements _ListItem {
  const _CheckSignsItem(this.invitation);

  final Invitation invitation;
}

class _CheckSignsItem2 implements _ListItem {
  const _CheckSignsItem2(this.project);

  final CheckSignProject project;
}

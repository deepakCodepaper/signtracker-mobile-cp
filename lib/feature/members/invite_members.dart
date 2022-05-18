import 'package:built_collection/built_collection.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:signtracker/blocs/invite/invite_list_bloc.dart';
import 'package:signtracker/blocs/invite/invite_list_states.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/widgets/app_bar.dart';

class InviteMemberPageArgs {
  const InviteMemberPageArgs(this.projectId);

  final int projectId;
}

class InviteMembersPage extends StatefulWidget {
  const InviteMembersPage({this.projectId});

  final int projectId;

  static const String route = '/invite-members';

  @override
  _InviteMembersPageState createState() => new _InviteMembersPageState();
}

class _InviteMembersPageState extends State<InviteMembersPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProgressDialog pr;

  bool isMembers = true;
  InviteListBloc bloc;
  var _currentIndex = 0;
  var companiesToInvite = BuiltList<int>();
  List<int> _selectedMembers = List<int>();
  var list = List();

  @override
  void initState() {
    bloc = InviteListBloc(InvitationRepository());
    pr = new ProgressDialog(context);
    pr.style(message: 'Loading');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.projectId == null
          ? bloc.getMemembers()
          : bloc.getMemembersFromProject(widget.projectId);
    });
  }

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  void showSuccessSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(8),
      message: message,
      icon: Icon(
        Icons.check_circle_outline,
        color: Colors.yellow[700],
        size: 20.0,
      ),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'Invite Members'),
      body: BlocListener<InviteListBloc, InviteListState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is InviteListLoading) {
            pr.show();
          }

          if (state is SendCompanyInviteLoading) {
            pr.show();
          }
          if (state is CompanyInviteSent) {
            pr.hide();
            showSuccessSnackBar('Invite sent to companies selected.');
          }

          if (state is InviteListLoaded) {
            pr.hide();
            list = state.members;
          }

          if (state is CompanyInvitesLoaded) {
            pr.hide();
            list = state.company;
          }
        },
        child: BlocBuilder<InviteListBloc, InviteListState>(
            bloc: bloc,
            builder: (context, state) {
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      activeColor: Colors.yellow[700],
                      value: list[index].isInvited != null
                          ? list[index].isInvited
                          : false,
                      onChanged: (bool selected) {
                        if (selected == true) {
                          setState(() {
                            list[index] =
                                list[index].rebuild((b) => b..isInvited = true);
                            if (isMembers) {
                              _selectedMembers.add(list[index].id);
                            } else {
                              companiesToInvite = companiesToInvite
                                  .rebuild((b) => b..add(list[index].id));
                            }
                          });
                        } else {
                          setState(() {
                            list[index] = list[index]
                                .rebuild((b) => b..isInvited = false);
                            if (isMembers) {
                              _selectedMembers.remove(list[index].id);
                            } else {
                              companiesToInvite = companiesToInvite.rebuild(
                                  (b) => companiesToInvite
                                      .where((val) => val == list[index].id)
                                      .forEach(b.remove));
                            }
                          });
                        }
                      },
                      title: Text(list[index].name,
                          style: GoogleFonts.karla(fontSize: 15)),
                    );
                  });

//                final list = state.company;

//                return ListView.builder(
//                    itemCount: list.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      return CheckboxListTile(
//                        activeColor: Colors.yellow[700],
//                        value: state.company[index].isInvited != null
//                            ? state.company[index].isInvited
//                            : false,
//                        onChanged: (bool selected) {
//                          if (selected == true) {
//                            setState(() {
//                              state.company[index] = state.company[index]
//                                  .rebuild((b) => b..isInvited = true);
//                              companiesToInvite = companiesToInvite.rebuild(
//                                  (b) => b..add(state.company[index].id));
//                            });
//                          } else {
//                            setState(() {
//                              state.company[index] = state.company[index]
//                                  .rebuild((b) => b..isInvited = false);
//                              companiesToInvite = companiesToInvite.rebuild(
//                                  (b) => companiesToInvite
//                                      .where((val) =>
//                                          val == state.company[index].id)
//                                      .forEach(b.remove));
//                            });
//                          }
//                        },
//                        title: Text(list[index].name,
//                            style: GoogleFonts.karla(fontSize: 15)),
//                      );
//                    });
//              }
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        // new
        currentIndex: _currentIndex,
        // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: isMembers ? 'Invite Company' : 'Invite Members',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: 'Cancel',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.insert_invitation),
            label: 'Invite',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int value) {
    if (value == 0) {
      if (isMembers) {
        setState(() {
          isMembers = false;
        });
        bloc.getCompaniesForInvite();
      } else {
        setState(() {
          isMembers = true;
        });
        widget.projectId == null
            ? bloc.getMemembers()
            : bloc.getMemembersFromProject(widget.projectId);
      }
    } else if (value == 2) {
      if (!isMembers) {
        bloc.sendCompanyInvite(companiesToInvite, widget.projectId);
      } else {
        Navigator.pop(context, _selectedMembers);
      }
    } else {
      Navigator.pop(context);
    }
  }
}

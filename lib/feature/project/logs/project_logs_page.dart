import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:signtracker/api/model/project_logs.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/project_logs/project_logs_bloc.dart';
import 'package:signtracker/blocs/project_logs/project_logs_states.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class ProjectLogsArgs {
  const ProjectLogsArgs(this.project);

  final SignProject project;
}

class ProjectLogsPage extends StatefulWidget {
  const ProjectLogsPage({this.project});

  static const String route = '/project-logs';
  final SignProject project;

  @override
  State<StatefulWidget> createState() => _ProjectLogsPageState();
}

class _ProjectLogsPageState extends State<ProjectLogsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProjectLogsBloc bloc;
  bool isSignsLoading = false;
  bool isProjectClosing = false;
  List<ProjectLogs> projectLogs = List();

  void showMessage(String message) {
    scaffoldKey.currentState
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
  }

  void showSuccessMessage(String message) {
    scaffoldKey.currentState
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  void initState() {
    bloc = ProjectLogsBloc(SignRepository(), ProjectRepository());
    super.initState();
    bloc.loadLogs(widget.project.id);
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      _GeneralInfo(
        onClosePressed: () => showCloseProjectDialog(),
        project: widget.project,
        isProjectClosing: isProjectClosing,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          'Project Logs'.toUpperCase(),
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: 17, color: Colors.black),
              fontWeight: FontWeight.w700),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Divider(color: Colors.grey),
      ),
      if (isSignsLoading) ...[
        Center(
          child: Theme(
            data: ThemeData(accentColor: Colors.blue),
            child: CircularProgressIndicator(),
          ),
        ),
      ] else if (projectLogs.isEmpty) ...[
        Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Text(
              'No logs available.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ] else
        ...projectLogs.map(
          (sign) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _ProjectLog(projectLogs: sign),
          ),
        ),
    ];

    return Scaffold(
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'Project Activity'),
      backgroundColor: AppColors.grayBackground,
      body: BlocListener<ProjectLogsBloc, ProjectLogsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is LogsLoading) {
            setState(() {
              isSignsLoading = true;
            });
          } else if (state is LogsLoaded) {
            setState(() {
              projectLogs = state.projectLogs;
              isSignsLoading = false;
            });
          } else if (state is LogsErrorLoading) {
            showMessage(state.error);
            setState(() {
              isSignsLoading = false;
            });
          }

          if (state is ClosingProject) {
            setState(() {
              isProjectClosing = true;
            });
          } else if (state is ProjectClosed) {
            showSuccessMessage('Project Closed Successfully!');
          } else if (state is ProjectClosingError) {
            showMessage(state.error);
            setState(() {
              isProjectClosing = false;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemBuilder: (context, index) => list[index],
            itemCount: list.length,
          ),
        ),
      ),
    );
  }

  showCloseProjectDialog() {
    bool allSignsRemoved = false;
    bool allExistingSignsUncovered = false;

    showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              title: Text(
                'Close Project',
                style: GoogleFonts.karla(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 250,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: AppColors.grayLight,
                      child: ListTile(
                        title: Text('All signs were removed from this project.',
                            style: GoogleFonts.karla(fontSize: 15)),
                        trailing: Checkbox(
                          value: allSignsRemoved,
                          activeColor: Colors.green,
                          onChanged: (bool newValue) {
                            setState(
                              () {
                                allSignsRemoved = newValue;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text(
                          'All existing signs before the project started has been uncovered.',
                          style: GoogleFonts.karla(fontSize: 15)),
                      trailing: Checkbox(
                        value: allExistingSignsUncovered,
                        activeColor: Colors.green,
                        onChanged: (bool newValue) {
                          setState(
                            () {
                              allExistingSignsUncovered = newValue;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 48,
                      width: 140,
                      child: FlatButton(
                        color: AppColors.blueDialogButton,
                        child: new Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          bloc.closeProject(widget.project.id,
                              allExistingSignsUncovered, allSignsRemoved);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

String formatDate(DateTime dateTime) {
  DateFormat dateFormat = DateFormat.yMMMMd();
  return dateFormat.format(dateTime);
}

DateTime stringToDateTime(String dateTime) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.parse(dateTime);
}

String formatTime(DateTime dateTime) {
  return DateFormat.jm().format(dateTime);
}

Widget getStatus(String status) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color:
          status.toLowerCase() == 'active' || status.toLowerCase() == 'on time'
              ? Colors.green
              : Colors.red,
    ),
    height: 10,
    width: 10,
  );
}

class _GeneralInfo extends StatelessWidget {
  const _GeneralInfo({
    @required this.onClosePressed,
    this.project,
    this.isProjectClosing = false,
  });

  final SignProject project;
  final bool isProjectClosing;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'General Information'.toUpperCase(),
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(fontSize: 17, color: Colors.black),
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  info(
                      'Project #:',
                      project.identifier != null
                          ? project.identifier
                          : project.contractNumber,
                      null),
                  SizedBox(height: 10),
                  info(
                      'Location:',
                      '${project.highway.toString()}:${project.intersection.toString()}',
                      null),
                  SizedBox(height: 10),
                  info('Template:',
                      project.type != null ? project.type : 'None', null),
                  SizedBox(height: 10),
                  info(
                      'Status:',
                      project.status == 'completed' ? 'Closed' : project.status,
                      getStatus(project.status)),
                  SizedBox(height: project.status != 'completed' ? 30 : 0),
                  if (isProjectClosing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Theme(
                          data: ThemeData(accentColor: Colors.blue),
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  else
                    Visibility(
                      visible: project.status != 'completed',
                      child: RoundedButton(
                        radius: 5.0,
                        height: 50,
                        text: 'Close Project'.toUpperCase(),
                        onPressed: this.onClosePressed,
                        color: AppColors.yellowPrimary,
                        textColor: Colors.black,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectLog extends StatelessWidget {
  const _ProjectLog({this.projectLogs});

  final ProjectLogs projectLogs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayBackground,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          if (!projectLogs.message.contains('Project Closed')) ...[
            info(
                'Sign:',
                projectLogs.details != null
                    ? (projectLogs.details?.sign?.name != null
                        ? projectLogs.details.sign.name
                        : '')
                    : '',
                null),
            SizedBox(height: 10),
            info(
                'GPS:',
                projectLogs.details != null
                    ? (projectLogs.details?.sign?.lat != null
                        ? '${projectLogs.details?.sign?.lat?.toStringAsFixed(3)}:${projectLogs.details?.sign?.lng?.toStringAsFixed(3)}'
                        : '')
                    : '',
                null),
            SizedBox(height: 10),
            info(
                'Date:',
                projectLogs.updatedAt != null
                    ? formatDate(projectLogs.updatedAt)
                    : '',
                null),
            SizedBox(height: 10),
            info(
                'Time:',
                projectLogs.updatedAt != null
                    ? formatTime(projectLogs.updatedAt)
                    : '',
                null),
//            if (projectLogs.details.sign.status != 'completed') ...[
//              SizedBox(height: 10),
//              info('Sign Status:', '${projectLogs.details.sign.status}', null),
//            ],
            SizedBox(height: 10),
            info(
                'Details:',
                projectLogs.message == "Sign Updated" &&
                        projectLogs.details.sign.status == "completed".trim()
                    ? "Checked"
                    : projectLogs.message == "Sign Moved"
                        ? projectLogs.message
                        : projectLogs.message == "Sign Added"
                            ? 'Sign Created'
                            : projectLogs.message == "Sign Deleted"
                                ? 'Sign Removed'
                                : projectLogs.details.sign.status == 'fixed'
                                    ? 'Status: Fixed/Replaced'
                                    : 'Status: ' +
                                        projectLogs.details?.sign?.status,
                null),
            if (projectLogs.updatedBy != null) ...[
              SizedBox(height: 10),
              info('Updated by:', projectLogs.updatedBy.name, null),
            ],
          ] else ...[
            info(
                'Date:',
                projectLogs.updatedAt != null
                    ? formatDate(projectLogs.updatedAt)
                    : '',
                null),
            SizedBox(height: 10),
            info('Project:', projectLogs.message, null),
          ],
        ],
      ),
    );
  }
}

Widget info(String label, String info, Widget leadingInfo) {
  return Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: GoogleFonts.karla(
              textStyle: TextStyle(fontSize: 14, color: Colors.black),
              fontWeight: FontWeight.w700),
        ),
      ),
      Expanded(
        child: Row(
          children: [
            if (leadingInfo != null) ...[
              leadingInfo,
              SizedBox(width: 5),
            ],
            Expanded(
              child: Text(
                info ?? "",
                maxLines: 10,
                style: GoogleFonts.karla(
                    textStyle: TextStyle(fontSize: 14, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

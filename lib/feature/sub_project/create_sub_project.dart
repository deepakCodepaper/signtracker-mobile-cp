import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/sub_project/create_sub_project_bloc.dart';
import 'package:signtracker/feature/sub_project/create_sub_project_confirmation.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/widgets/app_bar.dart';

class CreateSubProjectPageArgs {
  const CreateSubProjectPageArgs(this.parentProject);

  final SignProject parentProject;
}

class CreateSubProjectPage extends StatefulWidget {
  const CreateSubProjectPage({@required this.parentProject});

  static const String route = '/create-subproject';
  final SignProject parentProject;

  @override
  State<StatefulWidget> createState() => _CreateSubProjectPageState();
}

class _CreateSubProjectPageState extends State<CreateSubProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final intersectionNumber1 = TextEditingController();
  final intersectionNumber2 = TextEditingController();

  ProgressDialog pr;
  CreateSubProjectBloc bloc;

  @override
  void initState() {
    bloc =
        CreateSubProjectBloc(RepositoryProvider.of<ProjectRepository>(context));
    pr = new ProgressDialog(context);
    super.initState();
  }

  void showErrorSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  void validateForm() {
    final inNr1 = intersectionNumber1.text;
    if (inNr1?.isEmpty == true) {
      showMessage('Complete intersection number.');
      return;
    }
    final inNr2 = intersectionNumber2.text;
    if (inNr2?.isEmpty == true) {
      showMessage('Complete intersection number.');
      return;
    }

    bloc.createProject(
        widget.parentProject,
        widget.parentProject.id,
        widget.parentProject.identifier != null
            ? widget.parentProject.identifier
            : widget.parentProject.contractNumber,
        widget.parentProject.type,
        inNr1,
        inNr2,
        widget.parentProject.templateId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'Create Sub Project'),
      body: BlocListener<CreateSubProjectBloc, CreateSubProjectState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CreateProjectNotUploadedState) {
            pr.hide().then((isHidden) {
              print(isHidden);
              showSuccessSnackBar("Project creation failed.");
            });
          }
          if (state is CreateProjectUploadedState) {
            pr.hide().then((isHidden) {
              print(isHidden);
              intersectionNumber1.text = '';
              intersectionNumber2.text = '';
              routeToSuccessPage(state.project, widget.parentProject);
            });
          }
          if (state is CreateProjectUploadingState) {
            pr.show();
          }
        },
        child: BlocBuilder<CreateSubProjectBloc, CreateSubProjectState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Project ${(widget.parentProject.identifier != null ? widget.parentProject.identifier : widget.parentProject.contractNumber + ' ' + widget.parentProject.intersection.toString() + ':' + widget.parentProject.highway.toString())}' ??
                          'Project 1124123 43:22',
                      style: GoogleFonts.karla(
                          textStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Sub Project \nIntersection ID',
                        style: GoogleFonts.karla(
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                        width: 50,
                        child: TextField(
                          controller: intersectionNumber1,
                          decoration: InputDecoration(
                            hintText: '000',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: intersectionNumber2,
                        decoration: InputDecoration(
                          hintText: '000',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.karla(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.karla(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () => validateForm(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void routeToSuccessPage(SignProject subproject, SignProject mainProject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSubProjectPageConfirmation(
            project: subproject, mainProject: mainProject),
      ),
    );
  }
}

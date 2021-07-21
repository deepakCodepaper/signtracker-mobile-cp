import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/create_project/create_project_bloc.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/members/invite_members.dart';
import 'package:signtracker/feature/project/adjust_settings/adjust_settings_page.dart';
import 'package:signtracker/feature/project/email_recipients/email_recipient_views.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/sub_project/create_sub_project.dart';
import 'package:signtracker/feature/template/template_parameters_page.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/color_helper.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class SaveProjectPageArgs {
  const SaveProjectPageArgs(this.project, this.returnToDashboard);

  final SignProject project;
  final bool returnToDashboard;
}

class SaveProjectPage extends StatefulWidget {
  const SaveProjectPage({@required this.project, this.returnToDashboard});

  static const String route = '/save-project';

  final SignProject project;
  final bool returnToDashboard;

  @override
  State<StatefulWidget> createState() => _SaveProjectPageState();
}

class _SaveProjectPageState extends State<SaveProjectPage> {
  List<int> selectedMembers = new List<int>();
  CreateProjectBloc bloc;
  ProgressDialog pr;
  SignProject project;

  Directory _appDocsDir;
  String appDocPath = '';
  File image;
  String imagepath;
  String projectName = '';

  var _currentIndex = 0;
  var _counter = 0;

  TextEditingController _nameProjectController = TextEditingController();

  loadMembers() async {
    final members = await Navigator.pushNamed(context, InviteMembersPage.route,
        arguments: InviteMemberPageArgs(project.id));

    setState(() {
      if (members != null) {
        selectedMembers = members;
        if (selectedMembers.length > 0) {
          sendMemberInvites(project.id);
        }
        showSnackBar('Invite sent successfully');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    bloc = CreateProjectBloc(RepositoryProvider.of<ProjectRepository>(context),
        RepositoryProvider.of<InvitationRepository>(context));
    pr = new ProgressDialog(context);

    project = widget.project;
    projectName = project.identifier != null
        ? project.identifier
        : project.contractNumber;
    _nameProjectController.text = projectName;

    if (widget.returnToDashboard) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showProjectCreated(context));
    }
  }

  void showSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      icon: Icon(
        Icons.info,
        color: Colors.yellow[700],
        size: 20.0,
      ),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  void showSuccessSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(5),
      borderRadius: 8,
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
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context,
          widget.returnToDashboard ? 'Project Created' : 'Edit Project'),
      body: BlocListener<CreateProjectBloc, CreateProjectState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CreateProjectUploadingState) {
            pr.show();
          }
          if (state is SendingMemberInviteForProjectState) {
            pr.show();
          }
          if (state is SendMemberInviteSuccessState) {
            print('InviteSuccessState');
            print(_counter);
            _counter++;
            print(_counter);
            print(selectedMembers.length);
            if (_counter >= selectedMembers.length) {
              pr.hide().then((isHidden) {
                _counter = 0;
              });
            }
          }
          if (state is CreateProjectUploadedState) {
            pr.hide().then((isHidden) {
              pr.hide();
            });
            setState(() {
              project = project.rebuild((b) => b
                ..identifier = state.project.identifier
                ..plan = state.project.plan);
            });
          }
          if (state is CreateProjectNotUploadedState) {
            pr.hide().then((isHidden) {
              pr.hide();
            });
          }
          if (state is SendMemberInviteFailedState) {
            print('InviteFailedState');
            _counter++;
            if (_counter >= selectedMembers.length) {
              pr.hide().then((isHidden) {});
            }
          }
        },
        child: BlocBuilder<CreateProjectBloc, CreateProjectState>(
          bloc: bloc,
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () => returnDashboard(),
              child: Stack(
                children: [
                  Container(
                    color: AppColors.grayBackground,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Project Name:',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text(
                                projectName ?? "",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Intersection ID:',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text(
                                '${project.highway} : ${project.intersection}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        RoundedButton(
                            height: 48,
                            radius: 5.0,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () => loadMembers(),
                            textColor: Colors.black,
                            text: 'Invite Users'.toUpperCase(),
                            borderColor: AppColors.yellowPrimary,
                            borderWidth: 2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        SizedBox(height: 10),
                        RoundedButton(
                          height: 48,
                          radius: 5.0,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () => viewPlan(),
                          textColor: Colors.black,
                          text: 'Project Template'.toUpperCase(),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          borderWidth: 2,
                          borderColor: AppColors.yellowPrimary,
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                          height: 48,
                          radius: 5.0,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () => navigateToCreateSubProject(project),
                          textColor: Colors.black,
                          text: 'Add Sub-Project'.toUpperCase(),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          borderWidth: 2,
                          borderColor: AppColors.yellowPrimary,
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                          height: 48,
                          radius: 5.0,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              AdjustSettingsPage.route,
                              arguments: AdjustSettingsPageArgs(project, false),
                            );
                            if (result != null) {
                              showSuccessSnackBar(
                                  'Settings saved successfully!');
                              project = result;
                            }
                          },
                          textColor: Colors.black,
                          text: 'Adjust Settings'.toUpperCase(),
                          color: Colors.white,
                          borderWidth: 2,
                          fontWeight: FontWeight.w700,
                          borderColor: AppColors.yellowPrimary,
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                          height: 48,
                          radius: 5.0,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () => displayCommentDialog(context),
                          textColor: Colors.black,
                          text: 'Edit Project Name'.toUpperCase(),
                          color: Colors.white,
                          borderWidth: 2,
                          fontWeight: FontWeight.w700,
                          borderColor: AppColors.yellowPrimary,
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                          height: 48,
                          radius: 5.0,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () => openEmailRecipientsPage(),
                          textColor: Colors.black,
                          text: 'Report Recipients'.toUpperCase(),
                          color: Colors.white,
                          borderWidth: 2,
                          fontWeight: FontWeight.w700,
                          borderColor: AppColors.yellowPrimary,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.returnToDashboard,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: RoundedButton(
                        height: 48,
                        radius: 5.0,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ProjectMapPage.route,
                            arguments: ProjectMapPageArgs(
                              null,
                              project,
                              false,
                              false,
                              false,
                              true,
                            ),
                          );
                        },
                        textColor: Colors.white,
                        text: 'Start Adding Sign '.toUpperCase(),
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> viewPlanOnline(BuildContext context, String projectPlan) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ViewProjectPlanPageOnline(projectPlan),
      ),
    );
  }

  Future<bool> viewPlanOffline(BuildContext context, String projectPlan) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ViewProjectPlanPageOffline(projectPlan),
      ),
    );
  }

  Future getImage() async {
    image = await FilePicker.getFile(
        allowedExtensions: ['jpg', 'pdf', 'png'], type: FileType.custom);
    imagepath = image.path;

    Navigator.pop(context);
    print(imagepath);
    bloc.uploadImage(project, imagepath);
  }

  void sendMemberInvites(int projectId) {
    selectedMembers.forEach((f) => bloc.sendMemberInvite(projectId, f));
  }

  void navigateToCreateSubProject(SignProject project) {
    Navigator.pushNamed(
      context,
      CreateSubProjectPage.route,
      arguments: CreateSubProjectPageArgs(project),
    );
  }

  void openEmailRecipientsPage() {
    Navigator.pushNamed(
      context,
      EmailRecipientPage.route,
      arguments: AddEmailRecipientArgs(project),
    );
  }

  Future<void> routeToMapPage(SignProject project) async {
    await Navigator.pushNamed(
      context,
      ProjectMapPage.route,
      arguments: ProjectMapPageArgs(null, project, false, true, false, false),
    );
  }

  showWhereToUse(BuildContext context) {
    Alert(
      style: AlertStyle(
        titleStyle: GoogleFonts.karla(
            color: AppColors.blueDialogButton,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 22.0),
      ),
      context: context,
      type: AlertType.info,
      title: "Information",
      desc: "Upload from Device or Upload from Template?",
      buttons: [
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "DEVICE",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () => getImage(),
          width: 120,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Center(
            child: Text(
              "TEMPLATE",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () => goToProjectTemplateList(),
          width: 120,
        )
      ],
    ).show();
  }

  String getDescription() {
    if (project.identifier != null) return "Project ${project.identifier}";
    if (project.contractNumber != null)
      return "Project ${project.contractNumber}";
    return "Project";
  }

  showProjectCreated(BuildContext context) {
    String description = getDescription();
    double heightDialog = 140;
    if (project.plan != null) {
      heightDialog = 250;
      description =
          '${getDescription()} with Template ${project.type == null ? 'Custom' : project.type}';
    }

    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            title: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: HexColor("#4CAF50"),
                    size: 75,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Project Created',
                    style: GoogleFonts.karla(
                        color: HexColor("#4CAF50"),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            content: Container(
              height: heightDialog,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      description ?? "",
                      style: GoogleFonts.karla(
                          fontSize: 16, fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Created Successfully!',
                      style: GoogleFonts.karla(
                          fontSize: 14, fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    Container(
                      height: 48,
                      width: 140,
                      child: FlatButton(
                        color: AppColors.blueDialogButton,
                        child: new Text(
                          'OK',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showErrorMessage(BuildContext context) {
    Alert(
      style: AlertStyle(
        titleStyle: GoogleFonts.karla(
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 22.0),
      ),
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: "“No template selected\nDo you want to Add?”",
      buttons: [
        DialogButton(
          color: AppColors.grayCheckSignsHeader,
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "UPLOAD",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.pop(context);
            showWhereToUse(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  void displayCommentDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Project Name'),
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
            content: TextField(
              controller: _nameProjectController,
              decoration: InputDecoration(
                hintText: "Project Name",
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'SAVE',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (_nameProjectController.text != '') {
                    projectName = _nameProjectController.text;
                    bloc.saveSettings(project, projectName);
                  }
                },
              )
            ],
          );
        });
  }

  viewPlan() async {
    var isChangePlan;
    if (project.plan != 'https://api.thesigntracker.com/storage') {
      isChangePlan = await viewPlanOnline(context, project.plan);
      print(isChangePlan);
    } else if (imagepath != null) {
      isChangePlan = await viewPlanOffline(context, imagepath);
      print(isChangePlan);
    } else {
      showErrorMessage(context);
    }

    if (isChangePlan) {
      showWhereToUse(context);
    }
  }

  Future<Directory> getAppDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  void loadAppDirectory() async {
    _appDocsDir = await getAppDirectory();
    appDocPath = _appDocsDir.path;
    uploadTemplatePlan(project);
  }

  File fileFromDocsDir(String filename) {
    if (appDocPath == '') {
      loadAppDirectory();
      print('no app directory');
    } else {
      print(p.join(appDocPath, filename));
      print('$appDocPath/$filename');
      return File('$appDocPath/$filename');
    }
  }

  uploadTemplatePlan(SignProject updatedSignProject) {
    File imageExist = fileFromDocsDir(updatedSignProject.identifier != null
        ? updatedSignProject.identifier
        : updatedSignProject.contractNumber);

    if (imageExist != null && imageExist.existsSync()) {
      print('Exist');
      imagepath = imageExist.path;
      bloc.uploadImage(project, imageExist.path);
    } else {
      print('Template not downloaded');
    }
  }

  goToProjectTemplateList() async {
    Navigator.pop(context);

    Navigator.of(context)
        .pushNamed(TemplateParametersPage.route,
            arguments:
                TemplateParametersPageArgs(project, SaveProjectPage.route))
        .then((results) async {
      if (results is PopWithResults) {
        PopWithResults popResult = results;
        if (popResult.toPage == SaveProjectPage.route) {
          SignProject updatedSignProject = popResult.results['pop_result'];
          project = project.rebuild((b) =>
              b..templateId = (popResult.results["template"] as Template).id);
          uploadTemplatePlan(updatedSignProject);
        } else {
          // pop to previous page
          Navigator.of(context).pop(results);
        }
      }
    });
  }

  returnDashboard() {
    if (widget.returnToDashboard) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
        ModalRoute.withName(DashboardPage.route),
      );
    } else {
      Navigator.pop(context, project);
    }
  }

  void showSucess() async {
    showProjectCreated(context);
  }
}

class _ViewProjectPlanPageOnline extends StatelessWidget {
  const _ViewProjectPlanPageOnline(this.imagePlan);

  final String imagePlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Project Template'),
      body: Stack(
        children: <Widget>[
          Container(
            child: PhotoView(imageProvider: NetworkImage(imagePlan)),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            height: 50,
            child: FlatButton(
              color: Colors.yellow[700],
              child: Text(
                'Change Template',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          )
        ],
      ),
    );
  }
}

class _ViewProjectPlanPageOffline extends StatelessWidget {
  const _ViewProjectPlanPageOffline(this.imagePlan);

  final String imagePlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Project Template'),
      body: Stack(
        children: <Widget>[
          Container(
            child: PhotoView(imageProvider: FileImage(new File(imagePlan))),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            height: 50,
            child: FlatButton(
              color: Colors.yellow[700],
              child: Text(
                'Change Template',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          )
        ],
      ),
    );
  }
}

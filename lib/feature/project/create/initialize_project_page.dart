import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/create_project/create_project_bloc.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/members/invite_members.dart';
import 'package:signtracker/feature/project/adjust_settings/adjust_settings_page.dart';
import 'package:signtracker/feature/template/template_parameters_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/feature/project/save/save_project_page.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/feature/template/template_list_page.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:path/path.dart' as p;
import 'package:signtracker/widgets/timer.dart';

class InitializeProjectArgs {
//  const InitializeProjectArgs(this.speed, this.distance, this.type);

//  final double speed;
//  final double distance;
//  final String type;
}

class InitializeProjectPage extends StatefulWidget {
//  const InitializeProjectPage({this.speed, this.distance, this.type});

  static const String route = '/initialize-project';

//  final double speed;
//  final double distance;
//  final String type;

  @override
  State<StatefulWidget> createState() => _InitializeProjectPageState();
}

class _InitializeProjectPageState extends State<InitializeProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final projectNumber = TextEditingController();
  final commissionedBy = TextEditingController();
  final intersectionNumber1 = TextEditingController();
  final intersectionNumber2 = TextEditingController();

  final FocusNode nodeProjectNumber = FocusNode();
  final FocusNode nodeComissionedBy = FocusNode();
  final FocusNode nodeIntersectionNumber1 = FocusNode();
  final FocusNode nodeIntersectionNumber2 = FocusNode();
  List<int> selectedMembers = new List<int>();

  ProgressDialog pr;

  SignProject initialProject;
  SignProject finalProject;
  CreateProjectBloc bloc;
  File image;
  String imagepath;
  var _currentIndex = 0;
  var _counter = 0;
  Directory _appDocsDir;
  String appDocPath = '';

  String drawingNumber = '';
  String templateType = 'Default';
  int templateId = 1;
  bool isSkipTemplate = false;
  double distance = 100;

  bool enableSignCheckSchedule = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: nodeProjectNumber,
          displayDoneButton: true,
          displayArrows: true,
        ),
        KeyboardActionsItem(
          focusNode: nodeComissionedBy,
          displayDoneButton: true,
          displayArrows: true,
        ),
        KeyboardActionsItem(
          focusNode: nodeIntersectionNumber1,
          displayDoneButton: true,
          displayArrows: true,
        ),
        KeyboardActionsItem(
          focusNode: nodeIntersectionNumber2,
          displayDoneButton: true,
          displayArrows: true,
        ),
      ],
    );
  }

  void showSnackBar(String message, Color color) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      icon: Icon(
        Icons.info,
        color: color,
        size: 20.0,
      ),
      duration: Duration(seconds: 3),
    ).show(context);
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

  void routeToEditProjectPage(SignProject project) {
    if (!enableSignCheckSchedule) {
      Navigator.pushNamed(context, SaveProjectPage.route,
          arguments: SaveProjectPageArgs(finalProject, true));
    } else {
      Navigator.pushReplacementNamed(
        context,
        AdjustSettingsPage.route,
        arguments: AdjustSettingsPageArgs(finalProject, true),
      );
    }
  }

  @override
  void initState() {
    bloc = CreateProjectBloc(RepositoryProvider.of<ProjectRepository>(context),
        RepositoryProvider.of<InvitationRepository>(context));
    pr = new ProgressDialog(context);
    pr.style(message: 'Creating Project...');
    initialProject = SignProject();
    finalProject = SignProject();
    super.initState();
  }

  void validateForm() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final prNumber = projectNumber.text;
    /*if (prNumber?.isEmpty == true) {
      showMessage('Enter Project Number.');
      return;
    }*/
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

    String comissioned = commissionedBy.text;
    if (comissioned?.isEmpty == true) {
      comissioned = '';
    }

    if ((image == null || imagepath.isEmpty) && !isSkipTemplate) {
      showConfirmCustomTemplateDialog(context);
      return;
    }

    if (drawingNumber == '' && !isSkipTemplate) {
      showConfirmNoTemplateDialog(context);
      return;
    }

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (image == null) {
      bloc.createProject(initialProject, prNumber, templateType, inNr1, inNr2,
          templateId, distance, comissioned);
    } else {
      bloc.createProjectWithImage(initialProject, prNumber, imagepath,
          templateType, inNr1, inNr2, templateId, distance, comissioned);
    }

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Future getImage() async {
    image = await FilePicker.getFile(
        allowedExtensions: ['jpg', 'pdf', 'png'], type: FileType.custom);
    Navigator.pop(context);
    if (!allowedFileSize(image)) {
      showSnackBar('File exceeds limit of 1 MB', Colors.redAccent);
    } else {
      imagepath = image.path;
      isSkipTemplate = true;
      showSnackBar('Custom Template from Device Selected', Colors.yellow[700]);
      pr.style(message: 'Creating Project...');
      await Future<void>.delayed(Duration(milliseconds: 3000));
      validateForm();
    }
  }

  showConfirmCustomTemplateDialog(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc:
          'Custom template selected from device. Click "Template" to select, or "Continue" and add your template at a later date.',
      buttons: [
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "CONTINUE",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
            isSkipTemplate = true;
            validateForm();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          width: 150,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Center(
            child: Text(
              "TEMPLATE",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            showWhereToUse(context);
          },
          width: 150,
        ),
      ],
    ).show();
  }

  showConfirmNoTemplateDialog(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc:
          'No template selected. Click "Template" to select, or "Continue" and add your template at a later date.',
      buttons: [
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "CONTINUE",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
            isSkipTemplate = true;
            validateForm();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          width: 150,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Center(
            child: Text(
              "TEMPLATE",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            showWhereToUse(context);
          },
          width: 150,
        ),
      ],
    ).show();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'New Project'),
      body: BlocListener<CreateProjectBloc, CreateProjectState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CreateProjectNotUploadedState) {
            pr.hide().then((isHidden) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              print(isHidden);
              showSnackBar(
                  "Either the contract number is a duplicate or there was an error on the internet connection, please try again.",
                  Colors.red);

              SystemChannels.textInput.invokeMethod('TextInput.hide');
            });
          }
          if (state is CreateProjectUploadedState) {
            pr.hide().then((isHidden) {
              print(isHidden);

              finalProject = state.project;

              if (selectedMembers.length > 0) {
                sendMemberInvites(finalProject.id);
              } else {
                routeToEditProjectPage(finalProject);
              }
            });
          }
          if (state is CreateProjectUploadingState) {
            pr.show();
          }

          //INVITATION STATE

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
                routeToEditProjectPage(finalProject);
              });
            }
          }
          if (state is SendMemberInviteFailedState) {
            print('InviteFailedState');
            _counter++;
            if (_counter >= selectedMembers.length) {
              pr.hide().then((isHidden) {
                routeToEditProjectPage(finalProject);
              });
            }
          }

          //TEMPLATE STATES

          if (state is LoadingTemplateIdState) {
            print('loading');
          }
          if (state is LoadingTemplateIdSuccessState) {
            if (state.template.length > 1) {
              state.template.forEach((element) {
                if (element.drawingNumber == drawingNumber) {
                  templateType = element.name;
                  templateId = element.id;
                  return;
                }
              });
            } else if (state.template.length == 1) {
              templateId = state.template[0].id;
              templateType = state.template[0].name;
            } else {
              templateType = 'Default';
            }
          }
          if (state is LoadingTemplateIdFailedState) {
            print(state.toString());
          }
        },
        child: BlocBuilder<CreateProjectBloc, CreateProjectState>(
          bloc: bloc,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: KeyboardActions(
                config: _buildConfig(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Enter Contract Number',
                        style: GoogleFonts.karla(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 220,
                        child: TextField(
                          focusNode: nodeProjectNumber,
                          controller: projectNumber,
                          decoration: InputDecoration(
                            hintText: '123456',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            BlacklistingTextInputFormatter(new RegExp('[ ]'))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Enter Commissioned By:',
                        style: GoogleFonts.karla(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 220,
                        child: TextField(
                          focusNode: nodeComissionedBy,
                          controller: commissionedBy,
                          decoration: InputDecoration(
                            hintText: 'Commissioned By',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text('Enter Intersection ID',
                          style: GoogleFonts.karla(
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 65,
                            child: TextField(
                              focusNode: nodeIntersectionNumber1,
                              controller: intersectionNumber1,
                              decoration: InputDecoration(
                                hintText: '000',
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(':'),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 65,
                            child: TextField(
                              focusNode: nodeIntersectionNumber2,
                              controller: intersectionNumber2,
                              decoration: InputDecoration(
                                hintText: '000',
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text('Enter Distance from each signs',
                          style: GoogleFonts.karla(
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TimerWidget(
                          title: '',
                          time: '$distance meters',
                          interval: '+ 10 meters -',
                          onPlusPressed: () => incrementSignPlacement(),
                          onMinusPressed: distance > 10
                              ? () => decrementSignPlacement()
                              : null,
                        ),
                      ),
                    ),
//                    SizedBox(height: 10),
//                    SizedBox(
//                      width: 65,
//                      child: TextField(
//                        focusNode: nodeDistance,
//                        controller: distance,
//                        decoration: InputDecoration(
//                          hintText: '15',
//                          border: OutlineInputBorder(),
//                          contentPadding: EdgeInsets.symmetric(vertical: 10),
//                        ),
//                        textAlign: TextAlign.center,
//                        keyboardType: TextInputType.number,
//                        inputFormatters: [
//                          BlacklistingTextInputFormatter(new RegExp('[ ]'))
//                        ],
//                      ),
//                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Invite Members",
                                style: GoogleFonts.montserrat(
                                  color: Colors.yellow[700],
                                  fontSize: 18,
                                ),
                              ),
                            ),
//                            Column(
//                              children: [
//                                ListView.builder(
//                                  scrollDirection: Axis.horizontal,
//                                  itemCount: 3,
//                                  itemBuilder: (context, index) => Icon(
//                                    Icons.account_circle,
//                                    size: 50,
//                                    color: Colors.yellow[700],
//                                  )
                          ),
                        ),
                        IconButton(
                          onPressed: () => loadMembers(),
                          icon: Icon(
                            Icons.add_circle,
                            size: 45,
                            color: Colors.grey,
                          ),
                          iconSize: 45,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
//                      child: RoundedButton(
//                        onPressed: () async {
//                          final result = await Navigator.pushNamed<SignProject>(
//                            context,
//                            AdjustSettingsPage.route,
//                            arguments:
//                                AdjustSettingsPageArgs(initialProject, true),
//                          );
//                          if (result != null) {
//                            showSuccessSnackBar('Schedule saved successfully!');
//                            initialProject = result;
//                          }
//                        },
//                        text: 'Schedule Sign Checks'.toUpperCase(),
//                        radius: 5.0,
//                        color: AppColors.yellowPrimary,
//                        textColor: Colors.black,
//                      ),

                      child: ListTile(
                        title: Text('Schedule Sign Checks',
                            style: GoogleFonts.karla(fontSize: 15)),
                        trailing: Checkbox(
                          value: enableSignCheckSchedule,
                          activeColor: Colors.green,
                          onChanged: (bool newValue) {
                            setState(
                              () {
                                enableSignCheckSchedule = newValue;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: RoundedButton(
                        onPressed: () => showWhereToUse(context),
                        text: 'Project Template'.toUpperCase(),
                        radius: 5.0,
                        color: AppColors.yellowPrimary,
                        textColor: Colors.black,
                      ),
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: RoundedButton(
                        onPressed: state is CreateProjectUploadingState
                            ? null
                            : validateForm,
                        text: state is CreateProjectUploadingState
                            ? 'Creating Project'.toUpperCase()
                            : 'Next'.toUpperCase(),
                        radius: 5.0,
                        color: AppColors.yellowPrimary,
                        textColor: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.yellowPrimary,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) => onTabTapped(context, index),
        // new
        currentIndex: _currentIndex,
        // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            title: Text('New'),
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/drawables/open-project.svg',
              fit: BoxFit.fill,
              color: Colors.black,
            ),
            title: Text('Open'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.flag,
              color: Colors.black,
            ),
            title: Text('Check'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text('Home'),
          )
        ],
      ),
    );
  }

  void onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectListPage(),
          ),
          ModalRoute.withName(DashboardPage.route),
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CheckSignsPage(false),
          ),
          ModalRoute.withName(DashboardPage.route),
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
          ModalRoute.withName(DashboardPage.route),
        );

        break;
    }
  }

  @override
  void dispose() {
    projectNumber.dispose();
    intersectionNumber1.dispose();
    intersectionNumber2.dispose();
    super.dispose();
  }

  loadMembers() async {
    final members = await Navigator.pushNamed(context, InviteMembersPage.route,
        arguments: InviteMemberPageArgs(0));

    setState(() {
      if (members != null) {
        selectedMembers = members;
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        showSnackBar(
            'Invite will be sent when project is created successfully!',
            Colors.yellow[700]);
      }
    });
  }

  void sendMemberInvites(int projectId) {
    selectedMembers.forEach((f) => bloc.sendMemberInvite(projectId, f));
  }

  Future<Directory> getAppDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  void loadAppDirectory() async {
    _appDocsDir = await getAppDirectory();
    appDocPath = _appDocsDir.path;

    getTemplatePlanPath(finalProject);
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

  getTemplatePlanPath(SignProject updatedSignProject) {
    File imageExist = fileFromDocsDir('initialProject');
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (imageExist != null && imageExist.existsSync()) {
      print('Exist');
      image = imageExist;
      imagepath = imageExist.path;
    } else {
      print('Template not downloaded');
    }
  }

  goToProjectTemplateList() async {
//    Navigator.pushNamed(context, TemplateParametersPage.route);

    Navigator.of(context)
        .pushNamed(TemplateParametersPage.route,
            arguments: TemplateParametersPageArgs(
                initialProject, InitializeProjectPage.route))
        .then((results) async {
      if (results is PopWithResults) {
        PopWithResults popResult = results;
        if (popResult.toPage == InitializeProjectPage.route) {
          Navigator.pop(context);
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          SignProject updatedSignProject = popResult.results['pop_result'];
          getTemplatePlanPath(updatedSignProject);
          getTemplateId(popResult.results['template']);
          showSnackBar('Template $templateType selected', Colors.yellow[700]);
          pr.style(message: 'Creating Project...');
          await Future<void>.delayed(Duration(milliseconds: 3000));
          validateForm();
        } else {
          // pop to previous page
          Navigator.of(context).pop(results);
        }
      }
    });
  }

  void getTemplateId(Template template) {
    drawingNumber = template.drawingNumber;
    templateId = template.id;
    templateType = template.name;
  }

  void incrementSignPlacement() {
    setState(() {
      distance += 10;
    });
  }

  void decrementSignPlacement() {
    setState(() {
      distance -= 10;
    });
  }

  bool allowedFileSize(File file) {
    String size = filesize(file.length);
    if (size.contains('KB')) {
      return true;
    } else if (size == '1 MB') {
      return true;
    } else {
      return false;
    }
  }
}

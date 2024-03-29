import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/adjust_settings/adjust_settings_bloc.dart';
import 'package:signtracker/blocs/adjust_settings/adjust_settings_states.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/adjust_settings/adjust_settings_page.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/feature/project/logs/project_logs_page.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/project/save/save_project_page.dart';
import 'package:signtracker/feature/sign_library/sign_library_template_page.dart';
import 'package:signtracker/feature/template/template_parameters_page.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/card.dart';

import '../../../utilities/constants.dart';
import '../../template/template_list_item_page.dart';
import '../../template/template_plan_view.dart';

class OpenProjectPageArgs {
  OpenProjectPageArgs(this.project, this.fromAddingSign);

  final SignProject project;
  final bool fromAddingSign;
}

class OpenProjectPage extends StatefulWidget {
  const OpenProjectPage(this.project, this.fromAddingSign);

  static const String route = "/open-project-info";
  final SignProject project;
  final bool fromAddingSign;

  @override
  State<StatefulWidget> createState() => OpenProjectPageState();
}

class OpenProjectPageState extends State<OpenProjectPage> {
  SignProject project;

  ProgressDialog pr;
  AdjustSettingsBloc bloc;
  FilePickerResult image;
  String imagepath;
  Directory _appDocsDir;
  String appDocPath = '';

  var _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    project = widget.project;

    pr = new ProgressDialog(context);
    bloc = AdjustSettingsBloc(ProjectRepository());
  }

  Future<void> proceedAdjustSettings(
      BuildContext context, SignProject project) async {
    final newProject = await Navigator.pushNamed(
      context,
      AdjustSettingsPage.route,
      arguments: AdjustSettingsPageArgs(project, false),
    );

    if (newProject != null) {
      project = newProject;
      showSnackBar(context, 'Settings saved successfully!');
    }
  }

  void navigateToProjectLogs(BuildContext context, SignProject project) async {
    final isClosed = await Navigator.pushNamed<bool>(
      context,
      ProjectLogsPage.route,
      arguments: ProjectLogsArgs(project),
    );
    if (isClosed == true) {
      Navigator.pop(context);
    }
  }

  Future getImage() async {
    image = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
      allowMultiple: false,
    ));
    imagepath = image.paths.first;

    PlatformFile file = image.files.first;
    print("SIZE IN SIZE============" + file.size.toString());
    //print("SIZE IN BYTES============" + file.bytes.toString());

    var fileSize = (image.files.first.size) / 1024;


    if(fileSize <= 1024){
      print("IF");
      print("SIZE IN SIZE============222----   " + file.size.toString());
      Navigator.pop(context);
      var fromTemplate = false;
      print("IMAGE PATH====" + imagepath);
      bloc.uploadImage(project, imagepath, fromTemplate);
    }else{
      print("ELSE");
      print("SIZE IN SIZE============224----   " + file.size.toString());
      Navigator.pop(context);
      var fromTemplate = false;
      print("IMAGE PATH====" + imagepath);
      showSnackBar(context, "File size limit exceeded.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      CardButtons(
//        backgroundGradient: LinearGradient(colors: [
//          HexColor.fromHex('#FF8A1B'),
//          HexColor.fromHex('#FFD01B'),
//          HexColor.fromHex('#FFD01B'),
//        ]),
        text: 'Edit Project',
        imagePath: 'assets/drawables/editsign-1.svg',
        onPressed: () => openEditProjectPage(),
      ),
      CardButtons(
//        backgroundGradient: LinearGradient(colors: [
//          HexColor.fromHex('#FF8A1B'),
//          HexColor.fromHex('#FFD01B'),
//          HexColor.fromHex('#FFD01B'),
//        ]),
        text: 'Project Template',
        imagePath: 'assets/drawables/viewproject-1.svg',
        onPressed: () => viewPlan(),
      ),
      CardButtons(
        text: 'Project Activity',
        imagePath: 'assets/drawables/projectactivity-1.svg',
        onPressed: () => navigateToProjectLogs(context, project),
      ),
      CardButtons(
        text: 'Signs',
        imagePath: 'assets/drawables/add_sign.svg',
        onPressed: () => navigateToProjectMapPage(),
      ),
      CardButtons(
          text: 'Check Signs',
          imagePath: 'assets/drawables/check_signs.svg',
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProjectMapPage.route,
              arguments:
                  ProjectMapPageArgs(null, project, false, true, false, false),
            );
          }),
      CardButtons(
        text: 'Adjust Settings',
        imagePath: 'assets/drawables/adjust_settings.svg',
        //onPressed: () => proceedAdjustSettings(context, project),
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              AdjustSettingsPage.route,
              arguments: AdjustSettingsPageArgs(project, false),
            );
            if (result != null) {
              showSnackBar(context,
                  'Settings saved successfully!');
              project = result;
            }
          }
      ),
      CardButtons(
        text: 'Close Project',
        imagePath: 'assets/drawables/close_project.svg',
        onPressed: () => showCloseProjectDialog(),
      ),
      if (project.templateId != 0) ...[
        CardButtons(
          text: 'Sign Library',
          imagePath: 'assets/drawables/create_subproj.svg',
          onPressed: () => showDialogSignLibrary(),
        ),
      ],
    ];
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, project.identifier),
      body: BlocListener<AdjustSettingsBloc, AdjustSettingsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AdjustSettingsLoading) {
            pr.show();
          }
          if (state is AdjustSettingsFailure) {
            pr.hide();
          }
          if (state is AdjustSettingsSuccess) {
            setState(() {
              print(state.project.plan);
              project = project.rebuild((b) => b..plan = state.project.plan);
            });
            pr.hide();
            showSnackBar(context, 'Project Template Selected');
          }
          if (state is ClosingProject) {
            pr.style(message: 'Updating');
            pr.show();
          }
          if (state is ProjectClosed) {
            navigateBackToProjectList();
          }
        },
        child: BlocBuilder<AdjustSettingsBloc, AdjustSettingsState>(
            bloc: bloc,
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () => returnToProjectList(),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: list,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                ),
              );
            }),
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
            label: 'New',
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/drawables/open-project.svg',
              fit: BoxFit.fill,
              color: Colors.black,
            ),
            label: 'Open',
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.flag,
              color: Colors.black,
            ),
            label: 'Check',
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          )
        ],
      ),
    );
  }

  void onTabTapped(BuildContext context, int index) async {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, InitializeProjectPage.route);
        break;
      case 1:
        Navigator.pop(context);
        break;
      case 2:
        Navigator.pushNamed(context, CheckSignsPage.route,
            arguments: CheckSignsPageArgs(false));
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
          ModalRoute.withName(DashboardPage.route),
        );
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

  uploadTemplatePlan(SignProject updatedSignProject) {
    File imageExist = fileFromDocsDir(updatedSignProject.identifier != null
        ? updatedSignProject.identifier
        : updatedSignProject.contractNumber);

    print("UPDATED SIGN PROJECT === " + updatedSignProject.toString());

    if (imageExist != null && imageExist.existsSync()) {
      print('Exist');
      print('Exist====' + imageExist.path);
      var fromTemplate = true;
      imagepath = imageExist.path;
      bloc.uploadImage(updatedSignProject, imageExist.path, fromTemplate);
    } else {
      print('Template not downloaded');
    }
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

  goToTemplateListItems(SignProject project) {
    String page = "/open-project-info";
    Navigator.of(context)
        .pushNamed(TemplatePlanListItemViewPage.route,
        arguments: TemplateListArgs(project, project.template, page))
        .then((results) {
      if (results is PopWithResults) {
        PopWithResults popResult = results;
        if (popResult.toPage == OpenProjectPage.route) {
          SignProject updatedSignProject = popResult.results['pop_result'];

          project = project.rebuild((b) =>
          b..templateId = (popResult.results["template"] as Template).id);

          print("call final method");

          pr.style(message: 'Loading');
          uploadTemplatePlan(updatedSignProject);
        } else {
          // pop to previous page
          Navigator.of(context).pop(results);
        }
      }
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

  showDialogSignLibrary() {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 15),
            title: Center(
              child: Text(
                'Customize Project Sign Library',
                style: GoogleFonts.karla(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
            ),
            content: Container(
              height: 200,
              width: 292,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: AppColors.blueDialogButton,
                      child: new Text(
                        'View Sign Library of Current Template',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        proceedSignLibraryTemplate('view');
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: AppColors.blueDialogButton,
                      child: new Text(
                        'Add Signs to Template Library',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        proceedSignLibraryTemplate('add');
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: Colors.redAccent,
                      child: new Text(
                        'Delete Signs from Template Library',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        proceedSignLibraryTemplate('delete');
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
  }

  viewPlan() async {
    print("HERE+++++++++");
    var isChangePlan;
    bool defaultPlan = false;
    if(project.plan != null) {
      print("HERE+++++++++00");
      if(project.plan.toString() == project.templateImageUrl.toString()) {
        print("HERE+++++++++001");
        defaultPlan = true;
      }
      if (project.plan != storageUrl) {
        print("HERE+++++++1");
        print(project.plan);
        print("DATA====" + project.templateImageUrl.toString());
        print("DATA====1" + defaultPlan.toString());
        isChangePlan = await viewPlanOnline(context, project.plan, defaultPlan, project);
        print(isChangePlan);
      } else if (imagepath != null) {
        print("HERE+++++++2");
        isChangePlan = await viewPlanOffline(context, imagepath);
        print(isChangePlan);
      } else {
        print("HERE+++++++3");
        showErrorMessage(context);
      }
    }else{
      print("HERE+++++++4");
      showErrorMessage(context);
    }
    if (isChangePlan) {
      print("helllo call this");
      showWhereToUse(context);
    }else{
      goToTemplateListItems(project);
    }

  }

  Future<bool> viewPlanOffline(BuildContext context, String projectPlan) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ViewProjectPlanPageOffline(projectPlan),
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
                          confirmCloseProject(
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

  void confirmCloseProject(bool existingsSignsUncovered, bool signsRemoved) {
    bloc.closeProject(project.id, existingsSignsUncovered, signsRemoved);
  }

  goToProjectTemplateList() async {
    Navigator.pop(context);

    Navigator.of(context)
        .pushNamed(TemplateParametersPage.route,
            arguments:
                TemplateParametersPageArgs(project, OpenProjectPage.route))
        .then((results) async {
      if (results is PopWithResults) {
        PopWithResults popResult = results;
        if (popResult.toPage == OpenProjectPage.route) {
          SignProject updatedSignProject = popResult.results['pop_result'];

          project = project.rebuild((b) =>
              b..templateId = (popResult.results["template"] as Template).id);

          pr.style(message: 'Loading');
          uploadTemplatePlan(updatedSignProject);
        } else {
          // pop to previous page
          Navigator.of(context).pop(results);
        }
      }
    });
  }

  returnToProjectList() {
    if (widget.fromAddingSign) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectListPage(),
        ),
        ModalRoute.withName(ProjectListPage.route),
      );
    } else {
      Navigator.pop(context);
    }
  }

  openEditProjectPage() async {
//    final result = await Navigator.pushNamed<SignProject>(
//      context,
//      SaveProjectPage.route,
//      arguments: SaveProjectPageArgs(project, false),
//    );
//    if (result != null) {
//      project = result;
//    }

    final result = await Navigator.push<SignProject>(
      context,
      MaterialPageRoute(
        builder: (_) => SaveProjectPage(
          project: project,
          returnToDashboard: false,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        project = result;
        print(project.identifier);
      });
    }
  }

  proceedSignLibraryTemplate(String method) async {
    print('old-----------------');
    print(project.templateId);

    var newTemplateId = await Navigator.pushNamed(
        context, SignLibraryTemplatePage.route,
        arguments: SignLibraryTemplatePageArgs(project, method));

    project = project.rebuild((b) => b..templateId = newTemplateId);

    print('new-----------------');
    print(project.templateId);
  }

  navigateToProjectMapPage() async {
    print('old-----------------');
    print(project.templateId);
    var templateId = await Navigator.pushNamed(
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

    project = project.rebuild((b) => b..templateId = templateId);

    print('new-----------------');
    print(project.templateId);
  }

  Future<void> navigateBackToProjectList() async {
    await pr.hide();
    pr.style(message: 'Loading');
    showSnackBar(context
        , 'Project Closed Successfully!');
    await Future<void>.delayed(Duration(milliseconds: 2000));
    Navigator.pop(context);
  }
}

Future<bool> viewPlanOnline(BuildContext context, String projectPlan, bool defaultPlan, SignProject project) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ViewProjectPlanPageOnline(projectPlan,defaultPlan, project),
    ),
  );
}

class ViewProjectPlanPageOnline extends StatefulWidget {
  const ViewProjectPlanPageOnline(this.imagePlan,this.dPlan,this.project);

  final String imagePlan;
  final bool dPlan;
  final SignProject project;

  @override
  State<ViewProjectPlanPageOnline> createState() => ViewProjectPlanPageOnlineState();
}

class ViewProjectPlanPageOnlineState extends State<ViewProjectPlanPageOnline> {

  bool defaultPlan = false;

  @override
  void initState(){
    super.initState();
    if(widget.dPlan){
      setState((){
        defaultPlan = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: SignTrackerAppBar.createAppBar(context, 'Project Template'),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            top: 30,
            child: Container(
              //child: PhotoView(imageProvider: NetworkImage(widget.imagePlan)),
              child: Image.network(widget.imagePlan, frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                return child;
              },
                loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                      } else {
                      return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                },
              ),
            ),
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
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Checkbox(
                  value: defaultPlan,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(width: 1.0, color: Colors.white),
                  ),
                  onChanged: (bool val){
                    setState((){
                      if(defaultPlan == false) {
                        if(widget.project.templateId != null) {
                          defaultPlan = val;
                          Navigator.pop(context, false);
                        }else{
                          defaultPlan = val;
                          Navigator.pop(context);
                          showSnackBar(context, "No Project Plan Template");
                        }
                      }
                    });
                  },
                ),
                Text('Use for project plan', style: TextStyle(color: Colors.yellow,fontSize: 16.0),),
              ],
            ),
          ),
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

void showSnackBar(BuildContext context, String message) {
  Flushbar(
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    message: message,
    icon: Icon(
      Icons.info,
      color: Colors.yellow[700],
      size: 20.0,
    ),
    duration: Duration(seconds: 1),
  ).show(context);
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/check_signs/check_signs_bloc.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';

import '../../utilities/constants.dart';

class TemplatePlanListItemViewPage extends StatefulWidget {
  const TemplatePlanListItemViewPage(
      this.signProject, this.selectedTemplate, this.page);

  static const String route = '/template-plans-item-view-page';

  final SignProject signProject;
  final Template selectedTemplate;
  final String page;

  @override
  State<StatefulWidget> createState() => _TemplatePlanListItemViewPageState();
}

class _TemplatePlanListItemViewPageState
    extends State<TemplatePlanListItemViewPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  CheckSignsBloc bloc;
  ProgressDialog pr;
  SignProject selectedSignProject;
  bool imageSaved = false;
  Directory _appDocsDir;
  String appDocPath = '';

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.yellow[700],
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  @override
  void initState() {

    print("PAGE LAST ======" + widget.page.toString());
    print("Template LAST======" + widget.selectedTemplate.toString());

    bloc = CheckSignsBloc(
        ProjectRepository(), InvitationRepository(), UserRepository());
    pr = ProgressDialog(context);

    loadAppDirectory();

    super.initState();
  }

  Future<void> routeToMapPage(SignProject project) async {
    await Navigator.pushNamed(
      context,
      ProjectMapPage.route,
      arguments: ProjectMapPageArgs(null, project, false, true, false, false),
    );
  }

  File fileFromDocsDir(String filename) {
    if (appDocPath == '') {
      loadAppDirectory();
    } else {
      print(p.join(appDocPath, filename));
      print('$appDocPath/$filename');
      return File('$appDocPath/$filename');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SignTrackerAppBar.createAppBar(context, 'Template Plan'),
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: PhotoView(
                    imageProvider: NetworkImage(widget.selectedTemplate.imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  height: 50,
                  child: FlatButton(
                    color: imageSaved ? Colors.yellow[700] : Colors.grey,
                    child: Text(
                      'Use Template',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () =>
                        imageSaved ? goBackToOpenProjectPage() : {},
                  ),
                ),
                Visibility(
                  visible: !imageSaved,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  goToTemplateListItems() {
    Navigator.pushNamed(context, TemplatePlanListItemViewPage.route);
  }

  loadTemplates() {
    downloadImageToFile();
  }

  goBackToOpenProjectPage() {
    if (imageSaved) {
      print("IMAGE SAVE CODE ===" + widget.selectedTemplate.id.toString());
      SignProject signProject = widget.signProject;
      signProject = signProject.rebuild((b) => b
        //..plan = '$portalImagesUrl/plans/${widget.selectedTemplate.drawingNumber}.jpg'
        ..plan = widget.selectedTemplate.imageUrl
        ..templateId = widget.selectedTemplate.id
        ..type = '${widget.selectedTemplate.name}');

      String identifier = '';
      if (widget.page == InitializeProjectPage.route) {
        identifier = 'initialProject';
      } else {
        print("else" );
        identifier = widget.signProject.identifier != null
            ? widget.signProject.identifier
            : widget.signProject.contractNumber;
      }

      Future.delayed(Duration.zero, () {
        print("future" );
        Navigator.pop(
          context,
          PopWithResults(
            fromPage: TemplatePlanListItemViewPage.route,
            toPage: widget.page,
            results: {
              "pop_result": signProject,
              "template": widget.selectedTemplate
            },
          ),
        );
      });
    } else {
      showMessage(
          'Please wait a few seconds as we download the template plan, then retry.');
    }
  }

  void showActualControl() {}

  Future<Directory> getAppDirectory() async {
    print("123" );
    return await getApplicationDocumentsDirectory();
  }

  void downloadImageToFile() async {
    print("246" );
    String identifier = '';
    if (widget.page == InitializeProjectPage.route) {
      identifier = 'initialProject';
    } else {
      identifier = widget.signProject.identifier != null
          ? widget.signProject.identifier
          : widget.signProject.contractNumber;
    }

    File imageTest = await _downloadFile(
        /*'$portalImagesUrl/plans/${widget.selectedTemplate.drawingNumber}.jpg',*/
        widget.selectedTemplate.imageUrl,
        '$identifier',
        appDocPath);

    print("IMAGE TEST===" + imageTest.toString());
    print("IMAGE TEST===" + imageTest.toString());
    print("IMAGE TEST===" + imageTest.toString());

    if (imageTest != null) {
      setState(() {
        imageSaved = true;
      });
      print('success');
      pr.hide();
      showActualControl();
    } else {
      print('failed');
      pr.hide();
      loadTemplates();
    }
  }

  Future<File> _downloadFile(String url, String filename, String dir) async {
    var req = await http.Client().get(Uri.parse(url));
    print('$dir/$filename');
    var file = File('$dir/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }

  void loadAppDirectory() async {
    _appDocsDir = await getAppDirectory();
    appDocPath = _appDocsDir.path;
    loadTemplates();
  }
}

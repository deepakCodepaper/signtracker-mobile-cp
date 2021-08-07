import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/add_sign/add_sign_bloc.dart';
import 'package:signtracker/blocs/add_sign/add_sign_states.dart';
import 'package:signtracker/feature/project/adjust_settings/adjust_settings_page.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/project/save/save_project_page.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';
import 'package:signtracker/widgets/success_box.dart';

class AddSignsPageArgs {
  const AddSignsPageArgs(
      this.projectId,
      this.signSelected,
      this.latitude,
      this.longitude,
      this.withTraffic,
      this.project,
      this.signFilePath,
      this.directory);

  final int projectId;
  final SignMasters signSelected;
  final double latitude;
  final double longitude;
  final bool withTraffic;
  final SignProject project;
  final String signFilePath;
  final String directory;
}

class AddSignsPage extends StatefulWidget {
  const AddSignsPage({
    @required this.projectId,
    @required this.signSelected,
    @required this.latitude,
    @required this.longitude,
    @required this.withTraffic,
    @required this.project,
    @required this.signFilePath,
    @required this.directory,
  });

  static const String route = '/create-project-add-signs';

  final int projectId;
  final double latitude;
  final double longitude;
  final SignMasters signSelected;
  final bool withTraffic;
  final SignProject project;
  final String signFilePath;
  final String directory;

  @override
  State<StatefulWidget> createState() => _AddSignsPageState();
}

class _AddSignsPageState extends State<AddSignsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AddSignBloc bloc;
  ProgressDialog pr;
  String status = 'active';
  bool withTraffic = true;
  bool isEnableControl = false;
  bool isExistingSign = false;
  Directory dir;

  @override
  void initState() {
    bloc = AddSignBloc(RepositoryProvider.of<SignRepository>(context));
    pr = new ProgressDialog(context);
    pr.style(message: 'Uploading Sign');
    print(widget.signFilePath);

    if (widget.signSelected.idName == 'existing-sign') {
      status = 'covered';
      isExistingSign = true;
    }

    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      print('lock');
    });

    super.initState();
  }

  void showMessage(String message) {
    scaffoldKey.currentState
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
  }

  String getSignName(String signtype) {
    switch (signtype) {
//      case 'barricade':
//        return 'Barricade';
//        break;
//      case 'be-prepared-to-stop':
//        return 'Be Prepared to Stop';
//        break;
//      case 'begin-detour-300m':
//        return 'Begin Detour 300m';
//        break;
//      case 'bridge-construction':
//        return 'Bridge Construction';
//        break;
//      case 'construction':
//        return 'Construction';
//        break;
//      case 'detour':
//        return 'Detour';
//        break;
//      case 'one-lane-traffic':
//        return 'One Lane Traffic';
//        break;
//      case 'utility-construction':
//        return 'Utility Construction';
//        break;
      case 'RB-31':
        return 'RB-31';
        break;
      case 'RB-1-80':
        return 'RB-1-80';
        break;
      case 'RB-1-50':
        return 'RB-1-50';
        break;
      case 'RB-1-110':
        return 'RB-1-110';
        break;

      default:
    }
  }

  void goToSuccessfulPage(Sign sign) async {
    final signWithImageName =
        sign.rebuild((b) => b.image = widget.signSelected.imageUrl);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _SuccessfulPage(project: widget.project, sign: sign),
      ),
    );

    Future.delayed(
      Duration.zero,
      () {
        Navigator.pop(
          context,
          PopWithResults(
            fromPage: AddSignsPage.route,
            toPage: ProjectMapPage.route,
            results: {
              "isSignAdded": true,
              "project": widget.project,
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'Add Signs'),
      body: BlocListener<AddSignBloc, AddSignState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AddSignUploadingState) {
            setState(() {
              isEnableControl = true;
            });
          }
          if (state is AddSignNotUploadedState) {
            showMessage(state.error);
          }
          if (state is AddSignUploadedState) {
            Future.delayed(
              Duration.zero,
              () {
                Navigator.pop(
                  context,
                  PopWithResults(
                    fromPage: AddSignsPage.route,
                    toPage: ProjectMapPage.route,
                    results: {
                      "isSignAdded": true,
                      "project": widget.project,
                    },
                  ),
                );
              },
            );
          }
        },
        child: BlocBuilder<AddSignBloc, AddSignState>(
          bloc: bloc,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.signSelected.imageUrl,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Image.asset(
                                          'assets/drawables/no-sign.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.signSelected.name,
                              style: GoogleFonts.karla(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Sign Status:',
                              style: GoogleFonts.karla(color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  RoundedButton(
                                    height: 35,
                                    width: 200,
                                    onPressed: (!isEnableControl &&
                                            !isExistingSign)
                                        ? () =>
                                            setState(() => status = 'active')
                                        : () {},
                                    text: 'Active'.toUpperCase(),
                                    textSize: 11.0,
                                    color: status == 'active'
                                        ? Colors.yellow[700]
                                        : Colors.white,
                                    textColor: Colors.black,
                                    borderColor: status == 'active'
                                        ? null
                                        : Colors.yellow[700],
                                    elevation: 0.0,
                                  ),
                                  SizedBox(height: 14),
                                  RoundedButton(
                                    height: 35,
                                    width: 200,
                                    onPressed: (!isEnableControl &&
                                            !isExistingSign)
                                        ? () =>
                                            setState(() => status = 'inactive')
                                        : () {},
                                    text: 'Inactive'.toUpperCase(),
                                    textSize: 11.0,
                                    color: status == 'inactive'
                                        ? Colors.yellow[700]
                                        : Colors.white,
                                    textColor: Colors.black,
                                    borderColor: status == 'inactive'
                                        ? null
                                        : Colors.yellow[700],
                                    elevation: 0.0,
                                  ),
                                  SizedBox(height: 14),
                                  RoundedButton(
                                    height: 35,
                                    width: 200,
                                    onPressed: !isEnableControl
                                        ? () =>
                                            setState(() => status = 'covered')
                                        : () {},
                                    text: 'Covered'.toUpperCase(),
                                    textSize: 11.0,
                                    color: status == 'covered'
                                        ? Colors.yellow[700]
                                        : Colors.white,
                                    textColor: Colors.black,
                                    borderColor: status == 'covered'
                                        ? null
                                        : Colors.yellow[700],
                                    elevation: 0.0,
                                  ),
                                  SizedBox(height: 14),
                                  RoundedButton(
                                    height: 35,
                                    width: 200,
                                    onPressed: !isEnableControl
                                        ? () =>
                                            setState(() => status = 'uncovered')
                                        : () {},
                                    text: 'Uncovered'.toUpperCase(),
                                    textSize: 11.0,
                                    color: status == 'uncovered'
                                        ? Colors.yellow[700]
                                        : Colors.white,
                                    textColor: Colors.black,
                                    borderColor: status == 'uncovered'
                                        ? null
                                        : Colors.yellow[700],
                                    elevation: 0.0,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.karla(
                                  color: Colors.black, fontSize: 17),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text(
                              !isEnableControl ? 'Confirm' : 'Uploading...',
                              style: GoogleFonts.karla(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: !isEnableControl
                                ? () async {
                                    var isDownloaded =
                                        await downloadDifferentImageStatuses(
                                            widget.signSelected);
                                    await pr.hide();
                                    if (isDownloaded) {
                                      bloc.addSign(
                                          new Sign(),
                                          widget.projectId,
                                          widget.latitude,
                                          widget.longitude,
                                          widget.signSelected,
                                          status,
                                          widget.withTraffic);
                                    }
                                  }
                                : () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> downloadDifferentImageStatuses(SignMasters sign) async {
    String fileName =
        (sign.idName != null ? sign.idName : sign.name).replaceAll(' ', '');

    await pr.show();

    await _downloadFile(sign.imageUrl, '$fileName', widget.directory);
    print('downloaded sign-normal');

    if (fileName != 'existing-sign') {
      await _downloadFile(
          'https://portal.thesigntracker.com/images/signs-check/$fileName.png',
          '${fileName}check',
          widget.directory);
      print('downloaded sign-check');
      await _downloadFile(
          'https://portal.thesigntracker.com/images/signs-check-against/$fileName.png',
          '${fileName}checkagainst',
          widget.directory);
      print('downloaded check-against');
      await _downloadFile(
          'https://portal.thesigntracker.com/images/signs-shaded/$fileName.png',
          '${fileName}shaded',
          widget.directory);
      print('downloaded shaded');
      await _downloadFile(
          'https://portal.thesigntracker.com/images/signs-shaded-check/$fileName.png',
          '${fileName}shadedcheck',
          widget.directory);
      print('downloaded shaded-check');
      await _downloadFile(
          'https://portal.thesigntracker.com/images/signs-shaded-check-against/$fileName.png',
          '${fileName}shadedcheckagainst',
          widget.directory);
      print('downloaded shadedcheckagainst');
    }

    return true;
  }

  Future<File> _downloadFile(String url, String filename, String dir) async {
    bool isExist = File('$dir/$filename').existsSync();
    if (!isExist) {
      var req = await http.Client().get(Uri.parse(url));
      print('$dir/$filename');
      var file = File('$dir/$filename');
      return file.writeAsBytes(req.bodyBytes);
    } else {
      print('$filename exists');
    }
  }
}

//class _SuccessfulPageArgs {
//  const _SuccessfulPageArgs(
//      this.signName, this.status, this.nextSignDistance, this.time);
//
//  final String signName;
//  final String status;
//  final String nextSignDistance;
//  final String time;
//}

class _SuccessfulPage extends StatelessWidget {
  const _SuccessfulPage({@required this.project, @required this.sign});

  final Sign sign;
  final SignProject project;

  @override
  Widget build(BuildContext context) {
    void backToProjectMapPage() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: Colors.blueGrey[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                height: 380,
                child: SuccessBox(
                  details: Column(
                    children: [
                      Text(
                        sign.name + ' is added',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            'GPS:      ',
                            style: GoogleFonts.karla(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Text(
                              sign.lat.toStringAsFixed(3) +
                                  ':' +
                                  sign.lng.toStringAsFixed(3),
                              style: GoogleFonts.karla(color: Colors.black),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Status:      ',
                            style: GoogleFonts.karla(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Text(
                              sign.status.toUpperCase(),
                              style: GoogleFonts.karla(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  onClosePressed: () => backToProjectMapPage(),
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible:
                    (project.signPlacement != null && project.distance != null)
                        ? true
                        : false,
                child: Text(
                  'Next Sign: ${project.signPlacement ?? project.distance} Meters',
                  style: GoogleFonts.karla(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RoundedButton(
                radius: 5.0,
                onPressed: () async {
                  final result = await Navigator.pushNamed<SignProject>(
                    context,
                    AdjustSettingsPage.route,
                    arguments: AdjustSettingsPageArgs(project, false),
                  );
                  if (result != null) {
                    Navigator.pop(context, true);
                  }
                },
                text: 'Add Schedule'.toUpperCase(),
                borderColor: AppColors.yellowPrimary,
                borderWidth: 3,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 10),
              RoundedButton(
                radius: 5.0,
                onPressed: () => backToProjectMapPage(),
                text: 'Next Sign'.toUpperCase(),
                borderColor: AppColors.yellowPrimary,
                borderWidth: 3,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 10),
              RoundedButton(
                radius: 5.0,
                onPressed: () async {
                  final result = Navigator.pushNamed<bool>(
                    context,
                    SaveProjectPage.route,
                    arguments: SaveProjectPageArgs(project, false),
                  );
                  if (result as bool == true) {
                    Navigator.pop(context);
                  }
                },
                text: 'Edit Project'.toUpperCase(),
                borderColor: AppColors.yellowPrimary,
                borderWidth: 3,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 10),
              RoundedButton(
                radius: 5.0,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpenProjectPage(project, true),
                    ),
                    ModalRoute.withName(OpenProjectPage.route),
                  );
                },
                text: 'Done'.toUpperCase(),
                borderColor: AppColors.yellowPrimary,
                borderWidth: 3,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

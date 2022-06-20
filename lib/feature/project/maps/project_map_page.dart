import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/project/project_bloc.dart';
import 'package:signtracker/blocs/project/project_states.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/signs/sign_list_page.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/calculator.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/maps.dart';
import 'package:signtracker/widgets/rounded_button.dart';

import '../../../utilities/constants.dart';

enum ProjectMapStatus { Initial, ToStart, Started, Stopped }
enum SignStatus { active, inactive, covered, uncovered, fixed }

class ProjectMapPageArgs {
  const ProjectMapPageArgs(
      this.imagePlan,
      this.project,
      this.shouldReturnToDashboard,
      this.checkSigns,
      this.editSigns,
      this.addRemoveSigns,
      );

  //TODO: temporary, should be loaded from server
  final bool shouldReturnToDashboard;
  final String imagePlan;
  final SignProject project;
  final bool checkSigns;
  final bool editSigns;
  final bool addRemoveSigns;
}

class ProjectMapPage extends StatefulWidget {
  const ProjectMapPage({
    @required this.imagePlan,
    @required this.project,
    this.shouldReturnToDashboard = false,
    this.checkSigns = false,
    this.addRemoveSigns = true,
    this.editSigns = false,
  });

  static const String route = '/project-map';

  final String imagePlan;
  final SignProject project;
  final bool shouldReturnToDashboard;
  final bool checkSigns;
  final bool editSigns;
  final bool addRemoveSigns;

  @override
  State<StatefulWidget> createState() => _ProjectMapPageState();
}

class _ProjectMapPageState extends State<ProjectMapPage> {
  ProjectMapStatus _projectMapStatus = ProjectMapStatus.Initial;
  final signNotes = TextEditingController();

  Set<Marker> markers = <Marker>{};
  List<Sign> signs = List<Sign>();
  List<int> signsWithMarkers = List<int>();
  List<int> signsChecked = List<int>();

  GoogleMapController mapController;
  double remainingDistance;
  LatLng latlngLocation;
  LatLng lastLatLng;
  double currentLat;
  double currentLng;
  BitmapDescriptor bitmapImage;
  SignProject project;
  ProjectBloc bloc;
  ProgressDialog pr;

  Sign updatedSign;
  Sign adjustedSign;
  MarkerId updatedMarkerId;
  bool isUpdatingSign = false;
  bool isAdjustSign;
  bool isFirstLoad = true;
  bool isClickOnStartButton = false;
  double screenHeight;
  double screenWidth;
  var location;
  Directory appDirectory;
  Flushbar loadingLocation;
  RoundedLoadingButtonController withTrafficController;
  RoundedLoadingButtonController againstTrafficController;

  //Checks what method was used.
  String method = '';

  @override
  void initState() {
    bloc = ProjectBloc(
        RepositoryProvider.of<ProjectRepository>(context), SignRepository());

    project = widget.project;
    remainingDistance = project.distance != null ? project.distance : 0;
    pr = new ProgressDialog(context, isDismissible: true);
    location = Location();

    if (widget.checkSigns) _projectMapStatus = ProjectMapStatus.ToStart;

    if (widget.addRemoveSigns) {
      isAdjustSign = true;
    }

    super.initState();

    loadAppDirectory();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.loadProjectSigns(project.id);
      if (Platform.isIOS) {
        getScreenSize();
      }
    });

    loadingLocation = Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      showProgressIndicator: true,
      message: 'Loading Accurate Location',
      icon: Icon(
        Icons.info,
        color: Colors.yellow[700],
        size: 20.0,
      ),
    );
    withTrafficController = new RoundedLoadingButtonController();
    againstTrafficController = new RoundedLoadingButtonController();
  }

  void loadAppDirectory() async {
    appDirectory = await getApplicationDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) async {
        print('========================');
        print(state);
        print('========================');
        if (state is ProjectInitial) {
          await pr.hide();
        }
        if (state is ProjectLoaded) {
          setState(() => isUpdatingSign = false);
        }
        if (state is SignsLoading) {
          setState(() => isUpdatingSign = true);
          if (!widget.shouldReturnToDashboard) {
            showSnackBar('Loading Updates on Map');
          }
        }
        if (state is SignsNotLoaded) {
          setState(() => isUpdatingSign = false);
        }
        if (state is SignsLoaded) {
          if (method != 'add-sign') {
            setState(() => isUpdatingSign = false);
          }

          if (state.signs.isNotEmpty) {
            _projectMapStatus = widget.checkSigns
                ? ProjectMapStatus.ToStart
                : ProjectMapStatus.Started;

            signs = state.signs;
            reloadPins();
            print("Location DATA CLat====" +currentLat.toString());
            print("Location DATA CLng====" +currentLng.toString());
           // latlngLocation = LatLng(21.1874561, 72.9672019);
            if (signs?.isNotEmpty == true) {
              print("SIGNS LENGTH====" + signs.length.toString());
              print("SIGNS LAT====" + signs.last.lat.toString());
              print("SIGNS LONG====" + signs.last.lng.toString());
                  latlngLocation = LatLng(currentLat, currentLng);
              recalculateDistance(
                  latlngLocation, LatLng(signs.last.lat, signs.last.lng));
            }
          } else {
            await pr.hide();
          }
        }
        if (state is SignsUpdating) {
          setState(() => isUpdatingSign = true);
        }
        if (state is SignNotUpdated) {
          await pr.hide();
          setState(() {
            isUpdatingSign = false;
          });
        }
        if (state is SignUpdated) {
          await pr.hide();
          setState(() {
            isUpdatingSign = false;

            if (method == 'update-sign') {
              updatedSign = state.sign;
              showSnackBar('Sign Updated Successfully!');
            } else if (method == 'sign-adjusted') {
              adjustedSign = state.sign;
              showSnackBar('Sign Location Updated Successfully!');
            }

            if (widget.checkSigns) {
              print("RINGTONE PLAY===================");
              FlutterRingtonePlayer.play(
                android: AndroidSounds.notification,
                ios: IosSounds.glass,
                looping: false,
                // Android only - API >= 28
                volume: 1.0,
                // Android only - API >= 28
                asAlarm: false, // Android only - all APIs
              );
              print("RINGTONE PLAY1===================");
              showSnackBar('Signs within a 50m radius checked');
            }
            reloadPins();
          });
        }
        if (state is SignDeleted) {
          setState(() => isUpdatingSign = false);
          showSnackBar('Sign removed successfully!');
          setState(() {
            markers.remove(markers.firstWhere((Marker marker) =>
            marker.markerId.value == state.deleteSignId.toString()));
          });
        }
      },
      child: WillPopScope(
        onWillPop: () => returnDashboard(),
        child: Scaffold(
          appBar: SignTrackerAppBar.createAppBar(
              context, widget.checkSigns ? 'Check Signs' : 'Project'),
          body: Stack(
            children: [
              Maps(
                onMapLoaded: (controller) {
                  mapController = controller;
                  observerLocationChanges();
                },
                onMapTapped: (latLng) {
                  if (method == 'adjust-sign') {
                    setState(() => isUpdatingSign = true);
                    adjustSignLocation(latLng, adjustedSign);
                    method = 'sign-adjusted';
                  }
                },
                markers: markers,
                showMyLocationButton:
                _projectMapStatus != ProjectMapStatus.Started,
              ),
              if (_projectMapStatus == ProjectMapStatus.Initial) ...[
                Positioned(
                  top: 50,
                  left: 30,
                  right: 30,
                  child: RoundedButton(
                    onPressed: () => viewPlan(),
                    text: 'Open Project Template'.toUpperCase(),
                    radius: 5.0,
                    color: AppColors.yellowPrimary,
                    textColor: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 50,
                  right: 50,
                  child: RoundedButton(
                    onPressed: () {
                      markStartingPoint();
                    },
                    text: 'Mark Starting Point'.toUpperCase(),
                    radius: 5.0,
                    color: AppColors.yellowPrimary,
                    textColor: Colors.black,
                  ),
                ),
              ],
              if (_projectMapStatus == ProjectMapStatus.ToStart) ...[
                Positioned(
                  bottom: 150,
                  left: 50,
                  right: 50,
                  child: RoundedButton(
                    onPressed: () {
                      isClickOnStartButton = true;
                      setStarted();
                      },
                    text: 'Start'.toUpperCase(),
                    radius: 5.0,
                    color: AppColors.yellowPrimary,
                    textColor: Colors.black,
                  ),
                ),
              ],
              if (_projectMapStatus == ProjectMapStatus.Started &&
                  widget.checkSigns == false) ...[
                Positioned(
                  top: 50,
                  left: 30,
                  right: 30,
                  child: Column(
                    children: [
                      Visibility(
                        visible: widget.addRemoveSigns,
                        child: Row(
                          children: [
                            Expanded(
                              child: RoundedLoadingButton(
                                color: Colors.yellow[700],
                                height: 40,
                                child: Text(
                                  'With Traffic',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                controller: withTrafficController,
                                onPressed: () => routeTraffic(true),
                              ),
//                          child: RoundedButton(
//                            onPressed: () => routeTraffic(),
//                            text: 'Add Sign'.toUpperCase(),
//                            radius: 5.0,
//                            color: AppColors.yellowPrimary,
//                            textColor: Colors.black,
//                          ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: widget.addRemoveSigns,
                        child: Row(
                          children: [
                            Expanded(
                              child: RoundedLoadingButton(
                                color: Colors.yellow[700],
                                height: 40,
                                child: Text(
                                  'Against Traffic',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                controller: againstTrafficController,
                                onPressed: () => routeTraffic(false),
                              ),
//                          child: RoundedButton(
//                            onPressed: () => routeTraffic(),
//                            text: 'Add Sign'.toUpperCase(),
//                            radius: 5.0,
//                            color: AppColors.yellowPrimary,
//                            textColor: Colors.black,
//                          ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 30,
                  right: 30,
                  child: Visibility(
                    visible: widget.project.distance != null &&
                        widget.editSigns != true,
                    child: Text(
                      'Distance to next sign: ${remainingDistance.toInt() < 0 ? 0 : remainingDistance.toInt()} meters',
                      style: GoogleFonts.karla(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              if (_projectMapStatus == ProjectMapStatus.Started &&
                  widget.editSigns == true) ...[
                Positioned(
                  top: 50,
                  left: 30,
                  right: 30,
                  child: Visibility(
                    visible: isAdjustSign != null ? false : true,
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedButton(
                            onPressed: () => setEditModeAdjustSign(true),
                            text: 'Adjust Sign'.toUpperCase(),
                            radius: 5.0,
                            color: AppColors.yellowPrimary,
                            textColor: Colors.black,
                          ),
                          flex: 2,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: RoundedButton(
                            onPressed: () => setEditModeAdjustSign(false),
                            text: 'Update Status'.toUpperCase(),
                            radius: 5.0,
                            color: AppColors.yellowPrimary,
                            textColor: Colors.black,
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 30,
                  right: 30,
                  child: Visibility(
                    visible: widget.project.distance != null &&
                        widget.editSigns != true,
                    child: Text(
                      'Distance to next sign: ${remainingDistance.toInt()} meters',
                      style: GoogleFonts.karla(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              if (_projectMapStatus == ProjectMapStatus.Started) ...[
                Positioned(
                  bottom: widget.editSigns == true ? 50 : 100,
                  left: 50,
                  right: 50,
                  child: RoundedButton(
                    onPressed: () async {
                      if (widget.checkSigns || widget.editSigns) {
                        setState(
                                () => _projectMapStatus = ProjectMapStatus.ToStart);
                        Navigator.of(context).pop();
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OpenProjectPage(widget.project, false),
                          ),
                          ModalRoute.withName(DashboardPage.route),
                        );
                      }
                    },
                    text: widget.checkSigns == true
                        ? 'Done'.toUpperCase()
                        : 'Stop'.toUpperCase(),
                    radius: 5.0,
                    color: AppColors.yellowPrimary,
                    textColor: Colors.black,
                  ),
                ),
              ],
              if (isUpdatingSign)
                Positioned(
                  bottom: 230,
                  left: MediaQuery.of(context).size.width * 0.45,
                  right: MediaQuery.of(context).size.width * 0.45,
                  child: Theme(
                    data: ThemeData(accentColor: Colors.yellow[700]),
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void observerLocationChanges() {
    print("observe Location Changed");
    location.onLocationChanged().listen((data) {
      print("ONCHANGED LOCATION ----- " + data.toString());
      loadUserLocation(data);
    });
  }

  void routeTraffic(bool withTraffic) async {
    pr.style(message: 'Loading accurate location...');
    //showLoadingLocation();
    final currentLocation = await Location().getLocation();
//    final currentLocation = latlngLocation;
    if (withTraffic) {
      withTrafficController.success();
      withTrafficController.reset();
    } else {
      againstTrafficController.success();
      againstTrafficController.reset();
    }
    //hideLoadingLocation();
    print("PROJECT ID ====" + project.id.toString());
    print("PROJECT ID ====" + withTraffic.toString());
    print("PROJECT ID ====" + widget.project.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamed(SignListPage.route,
          arguments: SignListPageArgs(project.id,
              LatLng(currentLocation.latitude, currentLocation.longitude), withTraffic, widget.project))
          .then((results) async {
        if (results is PopWithResults) {
          PopWithResults popResult = results;
          if (popResult.toPage == ProjectMapPage.route) {
            if (popResult.results['isSignAdded']) {
              //add sign here
              method = 'add-sign';
              print('METHOD:  $method');
              bloc.loadProjectSigns(project.id);
              showSnackBar('Sign Added Succesfullly!');
              print(
                  '===================== ${popResult.results['project'] as SignProject}');
              project = project.rebuild((b) => b
                ..templateId =
                    (popResult.results['project'] as SignProject).templateId);
            }
          } else {
            // pop to previous page
            Navigator.of(context).pop(results);
          }
        }
      });
    });


//    var templateId = await Navigator.pushNamed(
//      context,
//      TrafficPage.route,
//      arguments: TrafficPageArgs(
//        project.id,
//        LatLng(currentLat, currentLng),
////        LatLng(currentLocation.latitude, currentLocation.longitude),
//        widget.project,
//      ),
//    );
//    if (templateId != 'signAdded') {
//      print('template Id rebuild');
//
//      project = project.rebuild((b) => b..templateId = templateId);
//    } else if (templateId == null) {
//      print('template Id == null');
//    } else if (templateId == 'signAdded') {
//      //add sign here
//      method = 'add-sign';
//      print('METHOD:  $method');
//      bloc.loadProjectSigns(project.id);
//    }
  }

  void showLoadingLocation() {
    loadingLocation.show(context);
  }

  void hideLoadingLocation() {
    loadingLocation.dismiss();
  }

  void showSnackBar(String message) {
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
      duration: Duration(seconds: 2),
    ).show(context);
  }

  void loadUserLocation(LocationData currentLocation) async {
    currentLat = currentLocation.latitude;
    currentLng = currentLocation.longitude;

    print("CCC1=====" + currentLat.toString());
    print("CCC2=====" + currentLng.toString());

    print("HERE=====");

    if (isFirstLoad) {
      await new Future.delayed(const Duration(seconds: 3));
      print("HERE1=====");

      double lat;
      double lng;

      if (widget.checkSigns) {
        print("HERE2====");
        if (signs.length > 2) {
          int middle = (signs.length ~/ 2);
          lat = signs[middle].lat;
          lng = signs[middle].lng;
        } else if (signs.length > 0) {
          lat = signs[0].lat;
          lng = signs[0].lng;
        } else {
          lat = currentLocation.latitude;
          lng = currentLocation.longitude;
        }
        await mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(lat, lng),
              zoom: 12.0,
            ),
          ),
        );
      } else {
        if (signs.length > 0) {
          lat = signs[0].lat;
          lng = signs[0].lng;
          debugPrint('animate to starting point');
        } else {
          lat = currentLocation.latitude;
          lng = currentLocation.longitude;
          debugPrint('animate to location');
        }
        await mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(lat, lng),
              zoom: 20.0,
            ),
          ),
        );
      }
      setState(() {
        isFirstLoad = false;
      });
    } else {
      if (widget.checkSigns && _projectMapStatus == ProjectMapStatus.Started) {
        await mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
              LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 20.0,
            ),
          ),
        );
      }
    }

    if (lastLatLng == null) {
      lastLatLng = markers.last.position;
    }
    latlngLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
    recalculateDistance(latlngLocation, lastLatLng);

    //only perform check signs if under check signs

    //if (widget.checkSigns) checkSigns(currentLocation);
  }

  void recalculateDistance(LatLng currentLocation, LatLng lastSignedLocation) {
    // compares last current location and current location
    print("DATA========" + currentLocation.toString());
    print("DATA2========" + lastSignedLocation.toString());
    //currentLocation = lastSignedLocation;
    if (!Calculator.isTwoPointsEqual(lastSignedLocation, currentLocation)) {
      final lastPinLocation = markers.last.position;
      // calculates distance between last pin location and current location
      final distanceRendered = Calculator.calculateDistanceBetweenTwoPoints(
        lastPinLocation,
        latlngLocation,
      );
      // saves current location to last current location variable
      lastLatLng = latlngLocation;
      setState(() => remainingDistance =
      project.distance != null ? (project.distance - distanceRendered) : 0);
    }
  }

  @override
  void dispose() {
    location = null;
    super.dispose();
  }

  void checkSigns(LocationData currentLocation,Sign sign) {
    print("CALL=======");
    //signs.forEach((sign) {
      bool shouldUpdateSign = widget.checkSigns &&
          _projectMapStatus == ProjectMapStatus.Started &&
          Calculator.calculateDistanceBetweenTwoPoints(
              LatLng(currentLocation.latitude, currentLocation.longitude),
              LatLng(sign.lat, sign.lng)) <
              20.0;

      if (!isUpdatingSign && shouldUpdateSign && !isChecked(sign)) {
        bloc.completeSign(sign,signNotes.text);
        updateToComplete(sign);
      }
   // });
  }

  void markStartingPoint() async {
    pr.style(message: 'Loading accurate location...');
    await pr.show();
    final currentLocation = await Location().getLocation();
    //final currentLocation = latlngLocation;
    await pr.hide();
    setStarted();
    setState(() {
      print("CUrrent LAT=====" + currentLat.toString());
      print("CUrrent LANG=====" + currentLng.toString());
      // print("CUrrent LAT11=====" + currentLocation.latitude.toString());
      //print("CUrrent LANG11=====" + currentLocation.longitude.toString());
      markers.add(Marker(
        draggable: true,
        markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
      ));
    });
  }

  void checkSigntoMap(Sign sign) async{
    final currentLocation = await Location().getLocation();
    checkSigns(currentLocation,sign);
  }

  void addSignMarkerToMap(Sign sign) async {
    print("SIGN DATA == == == " +  sign.toString());
    await getIconDirectory(sign).then((onValue) async {
      print("SIGN DATA222 == == == " +  onValue.toString());
      var iconDirectory = onValue;
      print('=============================');
      print(iconDirectory);
      print('=============================');

      int iconSize = 160;

      if (Platform.isIOS) {
        if (screenHeight == 812 ||
            screenWidth == 812 ||
            screenHeight == 896 ||
            screenWidth == 896) {
          print('isIphoneX');
          iconSize = 250;
        } else {
          print('notIphone');
          iconSize = 160;
        }
      } else {
        print("ICONSIZE=========");
        iconSize = 220;
      }

//      ByteData data = await rootBundle.load(iconDirectory);
      ByteData data =
      new File(iconDirectory).readAsBytesSync().buffer.asByteData();
//      Uint8List byteData = new File(iconDirectory).readAsBytesSync();
//      ByteData data = ByteData.view(byteData.buffer);
      try {
        print("ICONSIZE222=========");
        await instantiateImageCodec(data.buffer.asUint8List(),
            targetWidth: iconSize);
      } catch (e) {
        print("ICONSIZE444444444=========");
        print(e);
        print("---------------");
        iconDirectory = 'assets/drawables/no-sign.png';
      }

      await getBytesFromAsset(iconDirectory, iconSize).then((onValue) {
        BitmapDescriptor icon = BitmapDescriptor.fromBytes(onValue);
        setState(() {
          print("SIGN DATA==============" + sign.id.toString());
          print("SIGN DATA==============" + sign.lat.toString());
          print("SIGN DATA==============" + sign.lng.toString());
          print("SIGN DATA==============" + widget.checkSigns.toString());
          markers.add(Marker(
            onTap: () =>
            widget.checkSigns == false ? showSignOptionsDialog(sign) : !isChecked(sign) && isClickOnStartButton ? showSignUpdateDialog(sign) : '',
            icon: icon,
            draggable: true,
            markerId: MarkerId(sign.id.toString()),
            position: LatLng(sign.lat, sign.lng),
            rotation: sign.traffic == 0 ? 180 : 0,
            onDragEnd: ((value) {
              adjustSignLocation(value, sign);
            }),
            infoWindow: widget.checkSigns && (isChecked(sign))
                ? InfoWindow(title: 'Checked')
                : InfoWindow(title: ''),
          ));
        });
      });
    });

    signsWithMarkers.add(sign.id);
  }

  void reloadPins() {
    setState(() {
      print("LENGHT SIGNS========" +signs.length.toString());
      print("LENGHT SIGNS22========" +signs.reversed.toList().toString());
      signs.reversed.toList();
      if (method == 'add-sign') {
        print("IN HERE===========");
        print('METHOD:  $method');
        signs.forEach((sign) {
          if (!signsWithMarkers.contains(sign.id)) {
            setState(() {
              addSignMarkerToMap(sign);
              isUpdatingSign = false;
            });

            Future.delayed(const Duration(seconds: 1));
            setState(() {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(sign.lat, sign.lng),
                    zoom: 20.0,
                  ),
                ),
              );
            });
          }
        });
        //end add-sign
        method = '';
        print('METHOD:  $method');
      } else if (method == 'update-sign') {
        print("IN HERE22===========");
        print('METHOD:  $method');

        markers.remove(markers.firstWhere((Marker marker) =>
        marker.markerId.value == updatedSign.id.toString()));

        addSignMarkerToMap(updatedSign);

        Future.delayed(const Duration(seconds: 1));
        setState(() {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(updatedSign.lat, updatedSign.lng),
                zoom: 20.0,
              ),
            ),
          );
        });

        //end update-sign
        method = '';
        updatedSign = null;
        print('METHOD:  $method');
      } else if (method == 'sign-adjusted') {
        print("IN HERE33===========");
        print('METHOD:  $method');

        markers.remove(markers.firstWhere((Marker marker) =>
        marker.markerId.value == adjustedSign.id.toString()));

        addSignMarkerToMap(adjustedSign);

        Future.delayed(const Duration(seconds: 1));
        setState(() {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(adjustedSign.lat, adjustedSign.lng),
                zoom: 20.0,
              ),
            ),
          );
        });

        //end update-sign
        method = '';
        updatedSign = null;
        print('METHOD:  $method');
      } else {
        print("IN HERE44===========");
        markers.clear();
        signsWithMarkers.clear();
        signs.forEach((sign) {
          addSignMarkerToMap(sign);
        });
      }
    });
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    //ByteData data = await rootBundle.load(path);
    ByteData data = new File(path).readAsBytesSync().buffer.asByteData();
//    Uint8List byteData = new File(path).readAsBytesSync();
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getClusterMarker(
      int clusterSize,
      Color clusterColor,
      Color textColor,
      int width,
      ) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = clusterColor;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final double radius = width / 2;
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint,
    );
    textPainter.text = TextSpan(
      text: clusterSize.toString(),
      style: TextStyle(
        fontSize: radius - 5,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        radius - textPainter.width / 2,
        radius - textPainter.height / 2,
      ),
    );
    final image = await pictureRecorder.endRecording().toImage(
      radius.toInt() * 2,
      radius.toInt() * 2,
    );
    final data = await image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  viewPlan() async {
    if (widget.imagePlan != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _ViewProjectPlanPage(widget.imagePlan),
        ),
      );
    } else {
      viewPlanOnline(context, project.plan);
    }
  }

  returnDashboard() {
    if (widget.shouldReturnToDashboard) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
        ModalRoute.withName(DashboardPage.route),
      );
    } else {
      Navigator.pop(context, project.templateId);
    }
  }

  void adjustSignLocation(LatLng value, Sign sign) {
    bloc.updateSignLocation(sign, value.latitude, value.longitude);
    sign = sign.rebuild((b) => b..lat = value.latitude);
    sign = sign.rebuild((b) => b..lng = value.latitude);
  }

  void showDeleteSignConfirmationDialog(Sign sign) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'Remove Sign?',
      desc: 'Continue removal of the sign?',
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: GoogleFonts.karla(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
        ),
        DialogButton(
          child: Text(
            "CONFIRM",
            style: GoogleFonts.karla(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            deleteSign(sign);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void showUpdateSignStatusDialog(Sign sign) {
    String value = sign.status;

    SignStatus _status = value == 'active'
        ? SignStatus.active
        : value == 'inactive'
        ? SignStatus.inactive
        : value == 'covered'
        ? SignStatus.covered
        : value == 'uncovered'
        ? SignStatus.uncovered
        : SignStatus.fixed;

    double dialogHeight = 370;
    if (sign.idName == 'existing-sign') {
      dialogHeight = 200;
    }

    showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              title: Text(
                'Update Sign Status',
                style: GoogleFonts.karla(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: dialogHeight,
                child: Column(
                  children: <Widget>[
                    if (sign.idName != 'existing-sign') ...[
                      Container(
                        color: AppColors.grayLight,
                        child: ListTile(
                          title: Text('Active',
                              style: GoogleFonts.karla(fontSize: 15)),
                          leading: Radio(
                            activeColor: Colors.grey,
                            value: SignStatus.active,
                            groupValue: _status,
                            onChanged: (SignStatus value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Inactive',
                            style: GoogleFonts.karla(fontSize: 15)),
                        leading: Radio(
                          activeColor: Colors.grey,
                          value: SignStatus.inactive,
                          groupValue: _status,
                          onChanged: (SignStatus value) {
                            setState(() {
                              _status = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: AppColors.grayLight,
                        child: ListTile(
                          title: Text('Covered',
                              style: GoogleFonts.karla(fontSize: 15)),
                          leading: Radio(
                            activeColor: Colors.grey,
                            value: SignStatus.covered,
                            groupValue: _status,
                            onChanged: (SignStatus value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Uncovered',
                            style: GoogleFonts.karla(fontSize: 15)),
                        leading: Radio(
                          activeColor: Colors.grey,
                          value: SignStatus.uncovered,
                          groupValue: _status,
                          onChanged: (SignStatus value) {
                            setState(() {
                              _status = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: AppColors.grayLight,
                        child: ListTile(
                          title: Text('Fixed/Replaced',
                              style: GoogleFonts.karla(fontSize: 15)),
                          leading: Radio(
                            activeColor: Colors.grey,
                            value: SignStatus.fixed,
                            groupValue: _status,
                            onChanged: (SignStatus value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ] else ...[
                      Container(
                        color: AppColors.grayLight,
                        child: ListTile(
                          title: Text('Covered',
                              style: GoogleFonts.karla(fontSize: 15)),
                          leading: Radio(
                            activeColor: Colors.grey,
                            value: SignStatus.covered,
                            groupValue: _status,
                            onChanged: (SignStatus value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Uncovered',
                            style: GoogleFonts.karla(fontSize: 15)),
                        leading: Radio(
                          activeColor: Colors.grey,
                          value: SignStatus.uncovered,
                          groupValue: _status,
                          onChanged: (SignStatus value) {
                            setState(() {
                              _status = value;
                            });
                          },
                        ),
                      ),
                    ],
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
                          if (_status.toString().split('.').last != value) {
                            showSnackBar('Updating Sign Status');
                            updateSignStatus(
                                sign, _status.toString().split('.').last);
                          }
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

  void updateSignStatus(Sign sign, String finalStatus) {
    method = 'update-sign';
    bloc.updateSignStatus(sign, finalStatus);
  }

  void deleteSign(Sign sign) {
    showSnackBar('Removing sign');
    bloc.deleteSign(sign.id);
  }

  setEditModeAdjustSign(bool isMethodAdjustSign) {
    if (isMethodAdjustSign) {
      Alert(
        context: context,
        type: AlertType.info,
        title: "Adjust Sign",
        desc: "Tap and hold at the sign you wish to adjust the location.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: GoogleFonts.karla(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.info,
        title: "Update Sign Status",
        desc: "Tap at the sign to update the status.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: GoogleFonts.karla(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    setState(() {
      isAdjustSign = isMethodAdjustSign;
      if (isAdjustSign) {
        reloadPins();
        showSnackBar('Updating signs to be draggable');
      }
    });
  }

  Future<void> setStarted() async {
    print("==============Call Start Method============");
    setState(() => _projectMapStatus = ProjectMapStatus.Started);
    if (widget.checkSigns) {
      print("==============Call Start Method1============");
      Future.delayed(const Duration(seconds: 1));
      await mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLat, currentLng),
            zoom: 20.0,
          ),
        ),
      );
    }
  }

  List<Sign> setPreviouslyCheckedSigns(List<Sign> newSigns) {
    newSigns.forEach((f) {
      f = f.rebuild((b) => b..status = 'active');
    });

    signs.forEach((f) {
      f = f.rebuild((b) => b..status = 'active');
    });

    return newSigns;
  }

  Future<File> _downloadFile(String url, String filename, String dir) async {
    var req = await http.Client().get(Uri.parse(url));
    print('$dir/$filename');
    var file = File('$dir/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }

  Future<String> getIconDirectory(Sign sign) async {
    String fileName =
    (sign.idName != null ? sign.idName : sign.name).replaceAll(' ', '');

    print('-----------------STATUS------------------- ${sign.status}');
    if (widget.checkSigns) {
      if (isChecked(sign)) {
        if ((sign.status == 'active') ||
            sign.status == 'uncovered' ||
            sign.status == 'fixed') {
          if (sign.traffic == 1) {
            await downloadIfNotExist(
                sign, '${p.join(appDirectory.path, fileName)}check', 'check');
            print('${p.join(appDirectory.path, fileName)}check');
            return '${p.join(appDirectory.path, fileName)}check';
          } else {
            await downloadIfNotExist(
                sign,
                '${p.join(appDirectory.path, fileName)}checkagainst',
                'checkagainst');
            return '${p.join(appDirectory.path, fileName)}checkagainst';
          }
        } else {
          if (sign.traffic == 1) {
            await downloadIfNotExist(
                sign,
                '${p.join(appDirectory.path, fileName)}shadedcheck',
                'shadedcheck');
            return '${p.join(appDirectory.path, fileName)}shadedcheck';
          } else {
            await downloadIfNotExist(
                sign,
                '${p.join(appDirectory.path, fileName)}shadedcheckagainst',
                'shadedcheckagainst');
            return '${p.join(appDirectory.path, fileName)}shadedcheckagainst';
          }
        }
      } else {
        if ((sign.status == 'active') ||
            sign.status == 'uncovered' ||
            sign.status == 'fixed') {
          await downloadIfNotExist(
              sign, '${p.join(appDirectory.path, fileName)}', '');
          return p.join(appDirectory.path, fileName);
        } else {
          await downloadIfNotExist(
              sign, '${p.join(appDirectory.path, fileName)}shaded', 'shaded');
          return '${p.join(appDirectory.path, fileName)}shaded';
        }
      }
    } else {
      if ((sign.status == 'active') ||
          sign.status == 'uncovered' ||
          sign.status == 'fixed') {
        await downloadIfNotExist(
            sign, '${p.join(appDirectory.path, fileName)}', '');
        print('TEST------');
        print(p.join(appDirectory.path, fileName));
        return p.join(appDirectory.path, fileName);
      } else {
        await downloadIfNotExist(
            sign, '${p.join(appDirectory.path, fileName)}shaded', 'shaded');
        print('TEST------');
        print('${p.join(appDirectory.path, fileName)}shaded');
        return '${p.join(appDirectory.path, fileName)}shaded';
      }
    }
  }

  void updateToComplete(sign) {
    signs.forEach((f) {
      if (sign.id == f.id) {
        f = f.rebuild((b){
          b..status = 'completed';
        } );
      }
    });

    signsChecked.add(sign.id);
  }

  bool isChecked(Sign sign) {
    return signsChecked.contains(sign.id);
  }

  void getScreenSize() {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    print('Screen Height: $screenHeight');
    print('Screen Width: $screenWidth');
  }

  showSignOptionsDialog(Sign sign) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 15),
            title: Center(
              child: Text(
                'What do you want to do with the sign?',
                style: GoogleFonts.karla(
                    fontSize: 16,
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
                        'Adjust Sign Location',
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        adjustedSign = sign;
                        method = 'adjust-sign';
                        showSnackBar(
                            'Tap on the part of the map where you want it moved.');
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: AppColors.blueDialogButton,
                      child: new Text(
                        'Update Sign Status',
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showUpdateSignStatusDialog(sign);
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: Colors.redAccent,
                      child: new Text(
                        'Remove Sign',
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDeleteSignConfirmationDialog(sign);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  showSignUpdateDialog(Sign sign) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 15),
            title: Center(
              child: Text(
                'Check signs',
                style: GoogleFonts.karla(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
            ),
            content: Container(
              height: 130,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           Row(
                             children: [
                               CircleAvatar(
                                 backgroundColor: Colors.green,
                                 child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30.0,
                          ),
                               ),
                               SizedBox(width: 20.0,),
                               Text('Checked')
                             ],
                           ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        checkSigntoMap(sign);
                        //checkSigns(currentLocation);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                          SizedBox(width: 20.0,),
                          Text('Report Issue')
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showNotesDialog(sign);
                        //Navigator.pop(context);
                        //checkSigntoMap();
                        //checkSigns(currentLocation);
                      },
                    ),
                  ),
                  /*SizedBox(height: 15),
                  Container(
                    height: 48,
                    child: FlatButton(
                      color: Colors.blueAccent,
                      child: new Text(
                        'Add Note',
                        style: GoogleFonts.karla(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDeleteSignConfirmationDialog(sign);
                      },
                    ),
                  )*/
                ],
              ),
            ),
          );
        });
  }

  showNotesDialog(Sign sign) {
    Alert(
      context: context,
      type: AlertType.none,
      content: TextField(
        controller: signNotes,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Sign Notes',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        onChanged: (value) {

        },
      ),
      buttons: [
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
            checkSigntoMap(sign);
            //validateForm();
            //SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          width: 150,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Center(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () {
            signNotes.text="";
            Navigator.pop(context);

          },
          width: 150,
        ),
      ],
    ).show();
  }

  downloadIfNotExist(Sign sign, String file, String status) async {
    String fileName =
    (sign.idName != null ? sign.idName : sign.name).replaceAll(' ', '');
    String folder = '';
    if (status == 'check') {
      folder = 'signs-check';
    } else if (status == 'checkagainst') {
      folder = 'signs-check-against';
    } else if (status == 'shaded') {
      folder = 'signs-shaded';
    } else if (status == 'shadedcheck') {
      folder = 'signs-shaded-check';
    } else if (status == 'shadedcheckagainst') {
      folder = 'signs-shaded-check-against';
    } else {
      folder = 'signs';
    }

    bool isExist = File(file).existsSync();
    if (!isExist) {
      print('================download====================$folder');
      print('$portalImagesUrl/$folder/$fileName.png');
      print('$fileName$status');
      await _downloadFile('$portalImagesUrl/$folder/$fileName.png',
          '$fileName$status', appDirectory.path);
    } else {
      print('no need to download');
    }
  }
}

Future<bool> viewPlanOnline(BuildContext context, String projectPlan) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => _ViewProjectPlanPageOnline(projectPlan),
    ),
  );
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

class _ViewProjectPlanPageArgs {
  const _ViewProjectPlanPageArgs(this.imagePlan);

  final String imagePlan;
}

class _ViewProjectPlanPage extends StatelessWidget {
  const _ViewProjectPlanPage(this.imagePlan);

  final String imagePlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Project Template'),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: 300,
            child: Image.file(
              new File(imagePlan),
            ),
          ),
        ),
      ),
    );
  }
}
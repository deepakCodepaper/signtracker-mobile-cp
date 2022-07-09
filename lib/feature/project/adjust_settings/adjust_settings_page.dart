import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/adjust_settings/adjust_settings_bloc.dart';
import 'package:signtracker/blocs/adjust_settings/adjust_settings_states.dart';
import 'package:signtracker/blocs/project_notification/project_notification_bloc.dart';
import 'package:signtracker/feature/project/save/save_project_page.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/timer.dart';
import 'package:signtracker/widgets/weekly.dart';

class AdjustSettingsPageArgs {
  AdjustSettingsPageArgs(this.project, this.initial);

  final SignProject project;
  final bool initial;
}

class AdjustSettingsPage extends StatefulWidget {
  const AdjustSettingsPage(this.project, this.initial);

  static const String route = '/adjust-settings';

  final SignProject project;
  final bool initial;

  @override
  State<StatefulWidget> createState() => _AdjustSettingsPageState();
}

class _AdjustSettingsPageState extends State<AdjustSettingsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  SignProject project;
  String signPlacement;
  double signPlacementValue;
  double activeNotifyFrequency;
  double inactiveNotifyFrequency;
  DateTime startDate;
  DateTime endDate;
  AdjustSettingsBloc bloc;

  int START_DATE = 0;
  int END_DATE = 1;
  String comment = '';

  TextEditingController _commentFieldController = TextEditingController();

  @override
  void initState() {
    bloc = AdjustSettingsBloc(ProjectRepository());
    project = widget.project;
//    if (!widget.initial) {
    signPlacement = widget.project.distance != null
        ? widget.project.distance.toString()
        : 0;
    signPlacementValue = widget.project.distance;
//    }
    if (widget.project.notifyFrequency != null) {
      activeNotifyFrequency = widget.project.notifyFrequency.toDouble();
    } else {
      activeNotifyFrequency = 120;
    }

    if (widget.project.notifyFrequency != null) {
      inactiveNotifyFrequency =
          widget.project.inactiveNotifyFrequency.toDouble();
    } else {
      inactiveNotifyFrequency = 240;
    }

    if (widget.project.startDate != null) {
      startDate = stringToDateTime(widget.project.startDate);
      endDate = stringToDateTime(widget.project.endDate);

//      setState(() {
//        startDate = DateTime(startDate.year, startDate.month, startDate.day,
//            startDate.hour, startDate.minute);
//
//        endDate = DateTime(endDate.year, endDate.month, endDate.day,
//            endDate.hour, endDate.minute);
//      });
    } else {
      startDate = DateTime.now();
      endDate = DateTime.now();
    }

    comment = widget.project.shortSummary ?? '';
    _commentFieldController.text = comment;

    super.initState();
  }

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  void showSuccessSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  DateTime stringToDateTime(String dateTime) {
    //final formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    final formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return formatter.parse(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String formatTimeForAPI(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  void displayTimePicker(TimeOfDay timeOfDay, int type) async {
    final selectedTimeOfDay = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: new ThemeData(
              primaryColor: Colors.black,
              buttonTheme: new ButtonThemeData(buttonColor: Colors.black)),
          child: child,
        );
      },
    );
    if (selectedTimeOfDay != null) {
      if (type == START_DATE) {
        setState(() {
          startDate = DateTime(startDate.year, startDate.month, startDate.day,
              selectedTimeOfDay.hour, selectedTimeOfDay.minute);
        });
      } else {
        setState(() {
          endDate = DateTime(endDate.year, endDate.month, endDate.day,
              selectedTimeOfDay.hour, selectedTimeOfDay.minute);
        });
      }
    }
  }

  void displayCommentDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Project remarks'),
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
            content: TextField(
              controller: _commentFieldController,
              decoration: InputDecoration(hintText: "Remarks..."),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  comment = _commentFieldController.text;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void displayDatePicker(DateTime dateTime, int type) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(
        days: 365,
      )),
      lastDate: DateTime.now().add(Duration(
        days: 365,
      )),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: new ThemeData(
              primaryColor: Colors.black,
              buttonTheme: new ButtonThemeData(buttonColor: Colors.black)),
          child: child,
        );
      },
    );
    if (selectedDate != null) {
      if (type == START_DATE) {
        setState(() {
          startDate = DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, dateTime.hour, dateTime.minute);
        });
      } else {
        setState(() {
          endDate = DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, dateTime.hour, dateTime.minute);
        });
      }
    }
  }

  void incrementSignPlacement() {
    signPlacementValue += 10;

    setState(() {
      signPlacement = signPlacementValue.toString();
    });
  }

  void decrementSignPlacement() {
    signPlacementValue -= 10;

    setState(() {
      signPlacement = signPlacementValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => checkIfInitial(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.grayBackground,
        appBar: SignTrackerAppBar.createAppBar(
            context, widget.initial ? 'Schedule Check' : 'Adjust Settings'),
        body: BlocListener<AdjustSettingsBloc, AdjustSettingsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is AdjustSettingsFailure) {
              showMessage(state.error);
            } else if (state is AdjustSettingsSuccess) {
              showSuccessSnackBar('Settings updated successfully');
              if (!widget.initial) {
                Timer(Duration(seconds: 0), () {
                  Navigator.pop(context, state.project);
                });
              } else {
                Navigator.pushReplacementNamed(context, SaveProjectPage.route,
                    arguments: SaveProjectPageArgs(state.project, true));
              }
            }
          },
          child: BlocBuilder<AdjustSettingsBloc, AdjustSettingsState>(
            bloc: bloc,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  height: widget.initial
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 1.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!widget.initial) ...[
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              'Project ${(widget.project.identifier != null ? widget.project.identifier : (widget.project.contractNumber ?? "") + ' ' + widget.project.intersection.toString() + ':' + widget.project.highway.toString())}' ??
                                  'Project 1124123 43:22',
                              style: GoogleFonts.karla(
                                  textStyle: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: _DateTimePicker(
                                title: 'Start Date',
                                selectedDate: formatDate(startDate),
                                selectedTime: formatTime(startDate),
                                onTimePressed: () => displayTimePicker(
                                    TimeOfDay.fromDateTime(startDate),
                                    START_DATE),
                                onDatePressed: () =>
                                    displayDatePicker(startDate, START_DATE),
                              ),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: _DateTimePicker(
                                title: 'End Date',
                                selectedDate: formatDate(endDate),
                                selectedTime: formatTime(endDate),
                                onTimePressed: () => displayTimePicker(
                                    TimeOfDay.fromDateTime(endDate), END_DATE),
                                onDatePressed: () =>
                                    displayDatePicker(endDate, END_DATE),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      if (!widget.initial) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: BlocProvider(
                            create: (context) => ProjectNotificationBloc(ProjectRepository()),
                            child: weeklyWidget(project),
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      if (!widget.initial) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TimerWidget(
                            titleIcon: Icons.flag,
                            title: 'Sign Placements',
                            time: '$signPlacement meters',
                            interval: '+ 10 meters -',
                            onPlusPressed: () => incrementSignPlacement(),
                            onMinusPressed: double.tryParse(
                                signPlacement != null
                                    ? signPlacement
                                    : 0) >
                                16
                                ? () => decrementSignPlacement()
                                : null,
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TimerWidget(
                          titleIcon: Icons.notifications_active,
                          title: 'Active Notification \nFrequency',
                          time: '$activeNotifyFrequency minutes',
                          interval: '+ 30 minutes -',
                          onPlusPressed: () =>
                              setState(() => activeNotifyFrequency += 30),
                          onMinusPressed: activeNotifyFrequency > 31
                              ? () =>
                                  setState(() => activeNotifyFrequency -= 30)
                              : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TimerWidget(
                          titleIcon: Icons.notifications_active,
                          title: 'Inactive Notification \nFrequency',
                          time: '$inactiveNotifyFrequency minutes',
                          interval: '+ 30 minutes -',
                          onPlusPressed: () =>
                              setState(() => inactiveNotifyFrequency += 30),
                          onMinusPressed: inactiveNotifyFrequency > 31
                              ? () =>
                                  setState(() => inactiveNotifyFrequency -= 30)
                              : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      if (!widget.initial) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: () => displayCommentDialog(context),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.comment,
                                  size: 15,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Comments',
                                  style: GoogleFonts.karla(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 40,),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.karla(
                                  textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              )),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text(
                              state is AdjustSettingsLoading
                                  ? 'Updating'
                                  : 'Done',
                              style: GoogleFonts.karla(
                                  textStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ),
                            onPressed: () {
                              if (!(state is AdjustSettingsLoading)) {
                                bloc.saveSettings(
                                    widget.project,
                                    activeNotifyFrequency,
                                    inactiveNotifyFrequency,
                                    double.tryParse(signPlacement),
                                    formatTimeForAPI(startDate),
                                    formatTimeForAPI(endDate),
                                    comment);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  checkIfInitial() {
    if (widget.initial) {
      showConfirmNoScheduleSet(context);
    } else {
      Navigator.pop(context);
    }
  }

  showConfirmNoScheduleSet(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc: 'Do you want to skip adding sign check schedule?',
      buttons: [
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "SKIP",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, SaveProjectPage.route,
                arguments: SaveProjectPageArgs(widget.project, true));
          },
          width: 150,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Center(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () {
            checkIfInitial();
          },
          width: 150,
        ),
      ],
    ).show();
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    this.title,
    this.selectedDate,
    this.onDatePressed,
    this.selectedTime,
    this.onTimePressed,
  });

  final String title;
  final String selectedDate;
  final VoidCallback onDatePressed;
  final String selectedTime;
  final VoidCallback onTimePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 15,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              this.title,
              style: GoogleFonts.karla(
                  textStyle: TextStyle(fontSize: 16, color: Colors.black),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: this.onDatePressed,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      this.selectedDate,
                      style: GoogleFonts.karla(
                          textStyle:
                              TextStyle(fontSize: 14, color: Colors.black)),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 10,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: this.onTimePressed,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: SizedBox(
              height: 25,
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 15,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      this.selectedTime,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.karla(
                          textStyle:
                              TextStyle(fontSize: 14, color: Colors.black)),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 10,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

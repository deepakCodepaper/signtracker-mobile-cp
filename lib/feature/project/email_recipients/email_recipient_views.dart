import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/sub_project/create_sub_project_bloc.dart';
import 'package:signtracker/feature/sub_project/create_sub_project_confirmation.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/widgets/app_bar.dart';

enum Report { daily, weekly }

class AddEmailRecipientArgs {
  const AddEmailRecipientArgs(this.project);

  final SignProject project;
}

class EmailRecipientPage extends StatefulWidget {
  const EmailRecipientPage({@required this.project});

  static const String route = '/add-recipient';
  final SignProject project;

  @override
  State<StatefulWidget> createState() => _EmailRecipientPageState();
}

class _EmailRecipientPageState extends State<EmailRecipientPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProgressDialog pr;
  CreateSubProjectBloc bloc;
  var _emails = BuiltList<String>();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberOfDaysController = TextEditingController();
  TextEditingController numberOfWeeksController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  RoundedLoadingButtonController saveScheduleController;

  final FocusNode nodeNumberOfDays = FocusNode();
  final FocusNode nodeNumberOfWeeks = FocusNode();
  final FocusNode nodeDay = FocusNode();
  Report isDays = Report.daily;

  DateTime startDate;
  bool enableSchedule = false;
  bool isWeeklyFrequency = false;
  String weekday = '';
  String hour = '';
  String minute = '';
  String meridian = '';

  List weekdays = [
    {
      "display": "Monday",
      "value": "Monday",
    },
    {
      "display": "Tuesday",
      "value": "Tuesday",
    },
    {
      "display": "Wednesday",
      "value": "Wednesday",
    },
    {
      "display": "Thursday",
      "value": "Thursday",
    },
    {
      "display": "Friday",
      "value": "Friday",
    },
    {
      "display": "Saturday",
      "value": "Saturday",
    },
    {
      "display": "Sunday",
      "value": "Sunday",
    },
  ];

  @override
  void initState() {
    bloc =
        CreateSubProjectBloc(RepositoryProvider.of<ProjectRepository>(context));
    pr = new ProgressDialog(context);
    pr.style(message: 'Loading...');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.getEmailRecipients(widget.project);
    });

    saveScheduleController = new RoundedLoadingButtonController();

//    if (widget.project.startDate != null) {
//      startDate = stringToDateTime(widget.project.startDate);
//    } else {
    startDate = DateTime.now();
//    }

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'Report Recipients'),
      body: BlocListener<CreateSubProjectBloc, CreateSubProjectState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is GettingRecipientsState) {
            pr.show();
          }
          if (state is GetScheduleLoading) {}
          if (state is RecipientsFailed) {
            pr.hide();
            showErrorSnackBar('Failed to fetch email recipients.');
          }
          if (state is GetScheduleError) {
            pr.hide();
            showErrorSnackBar('Failed to load schedule for reports.');
          }
          if (state is RecipientsReceived) {
            bloc.getSchedule(widget.project);

            setState(() {
              _emails = state.emails.emails;
            });
          }
          if (state is GetScheduleLoaded) {
            pr.hide();
            print('=================== ${state.schedule.daily}');
            print(state.schedule.weekly);

            if ((state.schedule.daily != 0 && state.schedule.daily != null) ||
                (state.schedule.weekly != 0 && state.schedule.weekly != null)) {
              setState(() {
                enableSchedule = true;
                numberOfDaysController.text =
                    state.schedule.daily != null && state.schedule.daily != 0
                        ? state.schedule.daily.toString()
                        : '';
                numberOfWeeksController.text =
                    state.schedule.weekly != null && state.schedule.weekly != 0
                        ? state.schedule.weekly.toString()
                        : '';
                weekday = state.schedule.day;
                timeController.text = state.schedule.time;
                hour = state.schedule.time.split(':')[0];
                minute = state.schedule.time.split(':')[1].split(' ')[0];
                meridian = state.schedule.time.split(' ')[1];
              });
            }
          }

          if (state is SetScheduleLoaded) {
            saveScheduleController.success();
            saveScheduleController.reset();
            showSuccessSnackBar('Schedule Saved!');
          }
          if (state is SendReportNowLoaded) {
            showSuccessSnackBar('Report Sent!');
          }
          if (state is SendReportNowFailed) {
            showErrorSnackBar('Report Sending Failed');
          }
        },
        child: BlocBuilder<CreateSubProjectBloc, CreateSubProjectState>(
          bloc: bloc,
          builder: (context, state) {
            return KeyboardActions(
              config: _buildConfig(context),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'Project ${(widget.project.identifier != null ? widget.project.identifier : widget.project.contractNumber + ' ' + widget.project.intersection.toString() + ':' + widget.project.highway.toString())}' ??
                              'Project 1124123 43:22',
                          style: GoogleFonts.karla(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Email Address:',
                        style: GoogleFonts.karla(
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'email@provider.com',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          controller: emailController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FlatButton(
                          color: Colors.black,
                          child: Text(
                            'Add Recipient(s)',
                            style: GoogleFonts.karla(
                                textStyle: TextStyle(
                                    fontSize: 16, color: Colors.yellow[700]),
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () => validateEmail(emailController.text),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          child: ListView.builder(
                            itemCount: _emails.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(children: [
                                Text(
                                  _emails[index],
                                  style: GoogleFonts.karla(fontSize: 15),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      deleteFromList(_emails[index]),
                                )
                              ]);
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: FlatButton(
                            color: Colors.black,
                            child: Text(
                              'Send Now',
                              style: GoogleFonts.karla(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.yellow[700]),
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: () => bloc.sendNow(widget.project),
                          ),
                        ),
                      ),
                    ),
//                    if (_emails.isNot ) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color: Colors.black),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Center(
                            child: Text('Scheduled Reports',
                                style: GoogleFonts.karla(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
//                            trailing: Checkbox(
//                              value: enableSchedule,
//                              activeColor: Colors.green,
//                              onChanged: (bool newValue) {
//                                setState(
//                                  () {
//                                    enableSchedule = newValue;
//                                  },
//                                );
//                              },
//                            ),
                          ),
                        ),
//                        if (enableSchedule) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                          child: Container(
                            height: 50,
                            width: 200,
                            child: Row(
                              children: [
                                Radio<Report>(
                                  value: Report.daily,
                                  groupValue: isDays,
                                  onChanged: (Report newValue) {
                                    setState(() {
                                      isDays = newValue;
                                    });
                                  },
                                ),
                                Text(
                                  'Every',
                                  style: GoogleFonts.karla(fontSize: 15),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    width: 20,
                                    child: TextField(
                                      focusNode: nodeNumberOfDays,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                      ),
                                      controller: numberOfDaysController,
                                      textAlign: TextAlign.center,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      enabled:
                                          isDays == Report.daily ? true : false,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'day/s',
                                  style: GoogleFonts.karla(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                            'or',
                            style: GoogleFonts.karla(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Container(
                            height: 50,
                            width: 204,
                            child: Row(
                              children: [
                                Radio<Report>(
                                  value: Report.weekly,
                                  groupValue: isDays,
                                  onChanged: (Report newValue) {
                                    setState(() {
                                      isDays = newValue;
                                    });
                                  },
                                ),
                                Text(
                                  'Every',
                                  style: GoogleFonts.karla(fontSize: 15),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    width: 22,
                                    child: TextField(
                                      focusNode: nodeNumberOfWeeks,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                      ),
                                      controller: numberOfWeeksController,
                                      textAlign: TextAlign.center,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      enabled: isDays == Report.weekly
                                          ? true
                                          : false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'weeks',
                                  style: GoogleFonts.karla(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'on',
                                style: GoogleFonts.karla(fontSize: 15),
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Text(
                                            'Select',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: weekday == '' ? null : weekday,
                                    onChanged: (newValue) {
                                      setState(() {
                                        weekday = newValue;
                                      });
                                    },
                                    items: weekdays.map((item) {
                                      return DropdownMenuItem(
                                        value: item['value'],
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Text(
                                                item['display'],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Container(
                            height: 50,
                            width: 150,
                            child: Row(
                              children: [
                                Text(
                                  'at',
                                  style: GoogleFonts.karla(fontSize: 15),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: '10:00 am',
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                    readOnly: true,
                                    controller: timeController,
                                    textAlign: TextAlign.center,
                                    onTap: () => displayTimePicker(
                                        TimeOfDay.fromDateTime(startDate)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            height: 40,
                            width: 200,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RoundedLoadingButton(
                                controller: saveScheduleController,
                                color: Colors.yellow[700],
                                child: Text(
                                  'Save Schedule',
                                  style: GoogleFonts.karla(
                                      textStyle: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () => saveSchedule(),
                              ),
                            ),
                          ),
                        ),
//                        ],
                      ],
                    ),
//                    ],
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void deleteFromList(String email) {
    print('delete $email');
    setState(() {
      _emails = _emails.rebuild(
          (b) => _emails.where((val) => val == email).forEach(b.remove));
      print(_emails);

      bloc.projectRepository
          .updateEmailsFromProject(_emails, widget.project.id);
    });
  }

  void addToList(String email) {
    print('add $email');
    setState(() {
      _emails = _emails.rebuild((b) => b..add(email));
      print('test $_emails');
      print('testlength ${_emails.length}');

      bloc.projectRepository
          .updateEmailsFromProject(_emails, widget.project.id);
    });
  }

  validateEmail(String text) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z-]+")
        .hasMatch(text);
    if (emailValid) {
      addToList(text);
      emailController.text = '';
    } else {
      showErrorSnackBar('Invalid email');
    }
  }

  void displayTimePicker(TimeOfDay timeOfDay) async {
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
      setState(() {
        startDate = DateTime(startDate.year, startDate.month, startDate.day,
            selectedTimeOfDay.hour, selectedTimeOfDay.minute);
        timeController.text = formatTime(startDate);
        hour = selectedTimeOfDay.hour.toString();
        minute = selectedTimeOfDay.minute.toString();
        meridian = timeController.text.split(' ')[1];
        print(meridian);
      });
    }
  }

  String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: nodeNumberOfDays,
          displayDoneButton: true,
          displayArrows: true,
        ),
        KeyboardActionsItem(
          focusNode: nodeNumberOfWeeks,
          displayDoneButton: true,
          displayArrows: true,
        ),
        KeyboardActionsItem(
          focusNode: nodeDay,
          displayDoneButton: true,
          displayArrows: true,
        ),
      ],
    );
  }

  saveSchedule() async {
    if ((numberOfDaysController.text.isNotEmpty ||
            numberOfWeeksController.text.isNotEmpty) ||
        weekday != 'Select' ||
        timeController.text != '') {
      String day = isDays == Report.daily ? numberOfDaysController.text : '';
      String weekly =
          isDays == Report.weekly ? numberOfWeeksController.text : '';
      if (day == '') {
        day = '0';
      }
      if (weekly == '') {
        weekly = '0';
      }

      bloc.setSchedule(widget.project, day, weekly, timeController.text,
          weekday, hour, minute, meridian);
    } else {
      saveScheduleController.error();
      showErrorSnackBar('Empty Schedule not allowed!');
      await Future<void>.delayed(Duration(milliseconds: 1500));
      saveScheduleController.reset();
    }
  }
}

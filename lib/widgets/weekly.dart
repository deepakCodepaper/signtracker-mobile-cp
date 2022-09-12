import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signtracker/api/model/project_notification.dart';
import 'package:signtracker/api/model/request/project_notification_request.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/project_notification/project_notification_bloc.dart';
import 'package:signtracker/repository/project_repository.dart';

import '../styles/values/values.dart';

class weeklyWidget extends StatefulWidget {
  const weeklyWidget(this.project);

  final SignProject project;

  @override
  State<weeklyWidget> createState() => _weeklyWidgetState();
}

class _weeklyWidgetState extends State<weeklyWidget> {
  List<String> weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  ProjectNotificationBloc bloc;

  List<ProjectNotification> projectNotification;
  List<ProjectNotification> timeNotification = [];
  int weekIndex = 0;
  int projectId;

  Color activeCardColor = Colors.black;
  Color inactiveCardColor = Colors.black26;

  Color activeTextColor = Colors.white;
  Color inactiveTextColor = Colors.white;

  List<List<Color>> cardColorList = [
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
  ];

  void updateDayColor(int index) {
    setState(() {
      //time.clear();
      timeNotification.clear();
      weekIndex = 0;
      weekIndex = index+1;
      print("INDEX========" + index.toString());
      print("WEEKINDEX========" + weekIndex.toString());
      print("Length========" + projectNotification.length.toString());
      for (int i = 0; i < cardColorList.length; i++) {
        cardColorList[i][0] = inactiveCardColor;
        cardColorList[i][1] = inactiveTextColor;
      }

      cardColorList[index][0] = activeCardColor;
      cardColorList[index][1] = activeTextColor;

      for(int i=0;i<projectNotification.length;i++){
        if(weekIndex == projectNotification[i].day){
          timeNotification.add(projectNotification[i]);
          //time.add(projectNotification[i].time);
        }
      }
    });
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
        String tm = selectedTimeOfDay.hour.toString() + ":" + selectedTimeOfDay.minute.toString();
        bloc.addNotificationTime(projectId, weekIndex.toString(), tm);
      });
    }
  }

  void deleteNotificationTime(int id){
    bloc.deleteNotificationTime(id);
    setState((){
      timeNotification.removeWhere((id) => id == id);
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    bloc = ProjectNotificationBloc(ProjectRepository());
    projectId = widget.project.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.getNotificationTime(projectId);
    });
    super.initState();
  }

  showDeleteDialog(BuildContext context,int id) {
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
      desc: "Delete this schedule time?",
      buttons: [
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () => deleteNotificationTime(id),
          width: 120,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Center(
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
          width: 120,
        )
      ],
    ).show();
  }

  /* void changeWeekday(String newDay) {
    setState(() {
      weekday = newDay;
    });
    print("changed, $weekday");

    updateList();
  }*/

  /*String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.follow_the_signs,
              size: 15,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              "Schedule Sign Checks",
              style: GoogleFonts.karla(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weekdays.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  updateDayColor(index);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 3, right: 3),
                  height: MediaQuery.of(context).size.width / 8.3,
                  width: MediaQuery.of(context).size.width / 8.3,
                  decoration: BoxDecoration(
                      color: cardColorList[index][0],
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(weekdays[index], style: TextStyle(fontSize: 14, color: cardColorList[index][1], fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  weekIndex != 0 ?
                  displayTimePicker(TimeOfDay.fromDateTime(DateTime.now())) : '';
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  width: 80,
                  decoration: BoxDecoration(
                    color: activeCardColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ProjectNotificationBloc, ProjectNotificationState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is ProjectNotificationLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if(state is ProjectNotificationLoaded){
                      projectNotification = state.projects;
                      if(state.status == false) {
                        timeNotification.clear();
                        for (int i = 0; i < projectNotification.length; i++) {
                          if (weekIndex == projectNotification[i].day) {
                            timeNotification.add(projectNotification[i]);
                          }
                        }
                      }
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: timeNotification.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPress: (){
                            showDeleteDialog(context,timeNotification[index].id);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            width: MediaQuery.of(context).size.width / 4.5,
                            decoration: BoxDecoration(
                              color: inactiveCardColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(timeNotification[index].time??'', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


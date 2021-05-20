import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/feature/project/signs/sign_list_page.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class TrafficPageArgs {
  const TrafficPageArgs(this.projectId, this.userLocation, this.project);

  final int projectId;
  final LatLng userLocation;
  final SignProject project;
}

class TrafficPage extends StatelessWidget {
  const TrafficPage({
    @required this.projectId,
    @required this.userLocation,
    @required this.project,
  });

  final int projectId;
  final LatLng userLocation;
  final SignProject project;

  static const String route = '/create-project-traffic-type';

  @override
  Widget build(BuildContext context) {
    void routeSignList(bool withTraffic) async {
      Navigator.of(context)
          .pushNamed(
        SignListPage.route,
        arguments: SignListPageArgs(
          projectId,
          userLocation,
          withTraffic,
          project,
        ),
      )
          .then((results) async {
        if (results is PopWithResults) {
          PopWithResults popResult = results;
          if (popResult.toPage == TrafficPage.route) {
          } else {
            // pop to previous page
            Navigator.of(context).pop(results);
          }
        }
      });

//      var templateId = await Navigator.pushNamed(
//        context,
//        SignListPage.route,
//        arguments: SignListPageArgs(
//          projectId,
//          userLocation,
//          withTraffic,
//          project,
//        ),
//      );
//      if (templateId != null) {
//        Navigator.pop(context, templateId);
//      } else {
//        Navigator.pop(context, null);
//      }
    }

    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'New Project'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
              onPressed: () => routeSignList(true),
              text: 'With Traffic'.toUpperCase(),
              radius: 5.0,
              color: AppColors.yellowPrimary,
              textColor: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
              onPressed: () => routeSignList(false),
              text: 'Against Traffic'.toUpperCase(),
              radius: 5.0,
              color: AppColors.yellowPrimary,
              textColor: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

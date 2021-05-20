import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/sub_project/create_sub_project_bloc.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/styles/values/text_styles.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class CreateSubProjectPageConfirmationArgs {
  const CreateSubProjectPageConfirmationArgs(this.project, this.mainProject);

  final SignProject project;
  final SignProject mainProject;
}

class CreateSubProjectPageConfirmation extends StatefulWidget {
  const CreateSubProjectPageConfirmation(
      {@required this.project, @required this.mainProject});

  final SignProject project;
  final SignProject mainProject;
  static const String route = '/create-subproject-confirmation';

  @override
  State<StatefulWidget> createState() =>
      _CreateSubProjectPageConfirmationState();
}

class _CreateSubProjectPageConfirmationState
    extends State<CreateSubProjectPageConfirmation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProgressDialog pr;

  @override
  void initState() {
    pr = new ProgressDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Save Project'),
      body: Container(
        color: AppColors.grayBackground,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
                child: Text('Sub-project created successfully!',
                    style:
                        GoogleFonts.karla(color: Colors.black, fontSize: 26))),
            SizedBox(height: 60),
            RoundedButton(
              height: 48,
              radius: 5.0,
              padding: EdgeInsets.symmetric(horizontal: 20),
              textColor: Colors.black,
              text: 'Edit Sub-Project'.toUpperCase(),
              color: Colors.white,
              fontWeight: FontWeight.w700,
              borderWidth: 3,
              borderColor: AppColors.yellowPrimary,
              onPressed: () => routeToEditProjectPage(),
            ),
            SizedBox(height: 20),
            RoundedButton(
              height: 48,
              radius: 5.0,
              padding: EdgeInsets.symmetric(horizontal: 20),
              textColor: Colors.black,
              text: 'Create another subproject'.toUpperCase(),
              color: Colors.white,
              fontWeight: FontWeight.w700,
              borderWidth: 3,
              borderColor: AppColors.yellowPrimary,
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(height: 20),
            RoundedButton(
              height: 48,
              radius: 5.0,
              padding: EdgeInsets.symmetric(horizontal: 20),
              textColor: Colors.black,
              text: 'Go back to project list'.toUpperCase(),
              color: Colors.white,
              borderWidth: 3,
              fontWeight: FontWeight.w700,
              borderColor: AppColors.yellowPrimary,
              onPressed: () => backToProjectList(),
            ),
            SizedBox(height: 20),
            RoundedButton(
              height: 48,
              radius: 5.0,
              padding: EdgeInsets.symmetric(horizontal: 20),
              textColor: Colors.black,
              text: 'Edit Parent Project'.toUpperCase(),
              color: Colors.white,
              borderWidth: 3,
              fontWeight: FontWeight.w700,
              borderColor: AppColors.yellowPrimary,
              onPressed: () => routeToEditMainProjectPage(),
            ),
          ],
        ),
      ),
    );
  }

  routeToEditProjectPage() {
    Navigator.pushNamed(
      context,
      OpenProjectPage.route,
      arguments: OpenProjectPageArgs(widget.project, false),
    );
  }

  routeToEditMainProjectPage() {
    Navigator.pushNamed(
      context,
      OpenProjectPage.route,
      arguments: OpenProjectPageArgs(widget.mainProject, false),
    );
  }

  backToProjectList() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectListPage(),
        ),
        ModalRoute.withName(ProjectListPage.route));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/color_helper.dart';
import 'package:signtracker/widgets/app_bar.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage();

  static const String route = '/create-project';

  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'New Project'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              _Card(
                backgroundColor: Colors.white,
//              backgroundGradient: LinearGradient(colors: [
//                HexColor.fromHex('#FF8A1B'),
//                HexColor.fromHex('#FFD01B'),
//                HexColor.fromHex('#FFD01B'),
//              ]),
                text: 'Choose Template',
                imagePath: 'assets/drawables/choose_template.svg',
                arrowColor: Colors.black,
                arrowBoxColor: HexColor('#FFCC33'),
                onPressed: () =>
                    Navigator.pushNamed(context, InitializeProjectPage.route),
              ),
              SizedBox(height: 20),
              _Card(
                backgroundColor: Colors.white,
                text: 'Create Sub Project',
                imagePath: 'assets/drawables/create_subproj.svg',
                arrowColor: Colors.black,
                arrowBoxColor: HexColor('#FFCC33'),
                onPressed: () =>
                    Navigator.pushNamed(context, ProjectListPage.route),
              ),
            ],
          ),
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
        Navigator.pushNamed(context, ProjectListPage.route,
            arguments: ProjectListPageArgs(0));
        break;
      case 2:
        Navigator.pushNamed(context, CheckSignsPage.route,
            arguments: CheckSignsPageArgs(false));
        break;
      case 3:
        Navigator.pop(context);
    }
  }
}

class _Card extends StatelessWidget {
  const _Card({
    this.backgroundGradient,
    this.backgroundColor = Colors.white,
    this.imagePath,
    this.text,
    this.arrowBoxColor,
    this.arrowColor,
    this.onPressed,
  });

  final LinearGradient backgroundGradient;
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final Color arrowColor;
  final Color arrowBoxColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: backgroundGradient,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                SvgPicture.asset(imagePath, fit: BoxFit.fill),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      textStyle: textTheme.bodyText1.copyWith(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: arrowBoxColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.chevron_right,
                  color: arrowColor,
                  size: 25.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

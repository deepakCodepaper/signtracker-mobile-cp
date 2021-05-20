import 'package:flutter/material.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/create/template_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';

import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/card.dart';

@Deprecated('Not used anymore')
class ChooseTemplate2Page extends StatelessWidget {
  static const String route = '/choose-templete-2-page';

  final int _currentIndex = 0;

  void proceedTemplate(context, title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplatePage(title: title),
      ),
    );
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
        text: 'Speed limit',
        imagePath: 'assets/drawables/speedlimit.svg',
        onPressed: () => proceedTemplate(context, 'Speed Limit'),
      ),
      CardButtons(
        text: 'School Zone',
        imagePath: 'assets/drawables/schoolzone.svg',
        onPressed: () => proceedTemplate(context, 'School Zone'),
      ),
      CardButtons(
        text: 'Playground Zone',
        imagePath: 'assets/drawables/playground.svg',
        onPressed: () => proceedTemplate(context, 'Playground Zone'),
      ),
      CardButtons(
        text: 'Construction Zone',
        imagePath: 'assets/drawables/construction_zone.svg',
        onPressed: () => proceedTemplate(context, 'Construction Zone'),
      ),
      CardButtons(
        text: 'Work Zone',
        imagePath: 'assets/drawables/work_zone.svg',
        onPressed: () => proceedTemplate(context, 'Work Zone'),
      ),
    ];

    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Choose Template'),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: list,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
          ModalRoute.withName(DashboardPage.route),
        );
    }
  }
}

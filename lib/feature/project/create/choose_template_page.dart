import 'package:flutter/material.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/create/template_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/menu_button.dart';

@Deprecated('Not used anymore')
class ChooseTemplatePage extends StatefulWidget {
  static const String route = "/choose-template";

  @override
  State<StatefulWidget> createState() => _ChooseTemplatePageState();

  const ChooseTemplatePage();
}

void proceedTemplate(context, title) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TemplatePage(title: title),
    ),
  );
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final menuList = [
      MenuButton(
        text: 'Speed Limit',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => proceedTemplate(context, 'Speed Limit'),
      ),
      MenuButton(
        text: 'School Zone',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => proceedTemplate(context, 'School Zone'),
      ),
      MenuButton(
        text: 'Playground Zone',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => proceedTemplate(context, 'Playground Zone'),
      ),
      MenuButton(
        text: 'Construction Zone',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => proceedTemplate(context, 'Construction Zone'),
      ),
      MenuButton(
        text: 'Work Zone',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => proceedTemplate(context, 'Work Zone'),
      ),
    ];

    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'New Project'),
      backgroundColor: Colors.white,
      body: ListView.builder(
        //Creating a ListView builder and sending the data set in menuList to create a list
        padding: const EdgeInsets.fromLTRB(0.0, 50, 0, 0),
        // Giving space from top
        itemCount: menuList.length,
        itemBuilder: (context, index) => menuList[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTabTapped,
        // new
        currentIndex: _currentIndex,
        // new
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), title: Text('Add')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Open')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.flag), title: Text('Create')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Home'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    switch (index) {
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectListPage(),
          ),
          ModalRoute.withName(DashboardPage.route),
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CheckSignsPage(false),
          ),
          ModalRoute.withName(DashboardPage.route),
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
          ModalRoute.withName(DashboardPage.route),
        );

        break;
    }
  }
}

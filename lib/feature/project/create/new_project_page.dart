import 'package:flutter/material.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/create/choose_template_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/menu_button.dart';

@Deprecated('this is no longer used')
class NewProjectPage extends StatefulWidget {
  static const String route = "/new-project";

  @override
  State<StatefulWidget> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final menuList = [
      MenuButton(
        text: 'Choose Template',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, ChooseTemplatePage.route),
      ),
      MenuButton(
        text: 'Create Sub Project',
        leading: Icon(Icons.add_circle_outline, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, ProjectListPage.route,
            arguments: ProjectListPageArgs(0)),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SignTrackerAppBar.createAppBar(context, 'New Project'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Expanded(
                flex: 2,
                child: ListView.builder(
                  //Creating a ListView builder and sending the data set in menuList to create a list
                  padding: const EdgeInsets.fromLTRB(0.0, 50, 0, 0),
                  // Giving space from top
                  itemCount: menuList.length,
                  itemBuilder: (context, index) => menuList[index],
                )),
          ),
        ),
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
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Open',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Create',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          )
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
        Navigator.of(context).pop();
        break;
    }
  }
}

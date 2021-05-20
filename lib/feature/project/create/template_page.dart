import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/list/project_list_page.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/widgets/app_bar.dart';

@Deprecated('Not used anymore')
class TemplatePageArgs {
  const TemplatePageArgs(this.title);

  final String title;
}

class TemplatePage extends StatefulWidget {
  const TemplatePage({Key key, this.title}) : super(key: key);

  static const String route = "/speed-limit";

  final String title;

  @override
  State<StatefulWidget> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int selectedSpeedLimit = 0;
  TextEditingController kmhr = TextEditingController();
  TextEditingController meters = TextEditingController();
  String title;

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      resizeToAvoidBottomInset: false,
      appBar: SignTrackerAppBar.createAppBar(
          context, widget.title ?? 'Template Page'),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SpeedLimitOption(
                text: '20km/hr : 20 meters',
                value: 0,
                groupValue: selectedSpeedLimit,
                onGroupValueChanged: _onSpeedLimitChanged,
              ),
              SizedBox(height: 10),
              _SpeedLimitOption(
                text: '30km/hr : 30 meters',
                value: 1,
                groupValue: selectedSpeedLimit,
                onGroupValueChanged: _onSpeedLimitChanged,
              ),
              SizedBox(height: 10),
//              _SpeedLimitOption(
//                text: '40km/hr : 40 meters',
//                value: 2,
//                groupValue: selectedSpeedLimit,
//                onGroupValueChanged: _onSpeedLimitChanged,
//              ),
//              SizedBox(height: 10),
//              _SpeedLimitOption(
//                text: '60km/hr : 60 meters',
//                value: 3,
//                groupValue: selectedSpeedLimit,
//                onGroupValueChanged: _onSpeedLimitChanged,
//              ),
//              SizedBox(height: 10),
//              _SpeedLimitOption(
//                text: '80km/hr : 80 meters',
//                value: 4,
//                groupValue: selectedSpeedLimit,
//                onGroupValueChanged: _onSpeedLimitChanged,
//              ),
//              SizedBox(height: 10),
//              _SpeedLimitOption(
//                text: '110km/hr : 110 meters',
//                value: 5,
//                groupValue: selectedSpeedLimit,
//                onGroupValueChanged: _onSpeedLimitChanged,
//              ),
              SizedBox(height: 10),
              _SpeedLimitOption(
                text: 'Custom speed and meters',
                value: 5,
                groupValue: selectedSpeedLimit,
                onGroupValueChanged: _onSpeedLimitChanged,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CustomEditText(
                        label: 'km/hr',
                        controller: kmhr,
                        isEnabled: selectedSpeedLimit == 5 ? true : false,
                      ),
                      SizedBox(width: 20),
                      Text(':'),
                      SizedBox(width: 20),
                      _CustomEditText(
                        label: 'meters',
                        controller: meters,
                        isEnabled: selectedSpeedLimit == 5 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.karla(color: Colors.black),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.karla(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        InitializeProjectPage.route,
                        arguments: InitializeProjectArgs(),
                      ),
                    ),
                  ],
                ),
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

  void _onSpeedLimitChanged(int newSpeedLimitSelection) {
    setState(() => selectedSpeedLimit = newSpeedLimitSelection);
  }

  double getSpeed() {
    switch (selectedSpeedLimit) {
      case 0:
        return 20.0;
      case 1:
        return 30.0;
      case 2:
        return 40.0;
      case 3:
        return 60.0;
      case 4:
        return 80.0;
      case 5:
        return 110.0;
    }
    return double.tryParse(kmhr.text) ?? 20.0;
  }

  double getDistance() {
    switch (selectedSpeedLimit) {
      case 0:
        return 20.0;
      case 1:
        return 30.0;
      case 2:
        return 40.0;
      case 3:
        return 60.0;
      case 4:
        return 80.0;
      case 5:
        return 110.0;
    }
    return double.tryParse(meters.text) ?? 20.0;
  }

  @override
  void dispose() {
    kmhr.dispose();
    meters.dispose();
    super.dispose();
  }
}

class _SpeedLimitOption extends StatelessWidget {
  _SpeedLimitOption({
    @required this.text,
    @required this.value,
    @required this.groupValue,
    @required this.onGroupValueChanged,
  });

  final String text;
  final int value;
  final int groupValue;
  final Function(int) onGroupValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(width: 30),
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onGroupValueChanged,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(text, style: GoogleFonts.karla(fontSize: 18)),
          )
        ],
      ),
    );
  }
}

class _CustomEditText extends StatelessWidget {
  const _CustomEditText({this.label, this.controller, this.isEnabled});

  final String label;
  final TextEditingController controller;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: GoogleFonts.karla(fontSize: 18)),
        SizedBox(height: 10),
        SizedBox(
          width: 65,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '000',
              border: OutlineInputBorder(),
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            enabled: isEnabled,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:signtracker/api/model/invitation.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/check_signs/check_signs_bloc.dart';
import 'package:signtracker/blocs/check_signs/check_signs_states.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/template/template_plan_view.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';

class TemplateListArgs {
  const TemplateListArgs(this.signProject, this.selectedTemplate, this.page);
  final SignProject signProject;
  final Template selectedTemplate;
  final String page;
}

@Deprecated('no longer used')
class TemplatePlanListItemPage extends StatefulWidget {
  const TemplatePlanListItemPage(
      {this.signProject, this.selectedTemplate, this.page});
  static const String route = '/template-plans-item';

  final SignProject signProject;
  final Template selectedTemplate;
  final String page;

  @override
  State<StatefulWidget> createState() => _TemplatePlanListItemPageState();
}

class _TemplatePlanListItemPageState extends State<TemplatePlanListItemPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  CheckSignsBloc bloc;
  ProgressDialog pr;
  SignProject selectedSignProject;

  List _templates = [];

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  @override
  void initState() {
    bloc = CheckSignsBloc(
        ProjectRepository(), InvitationRepository(), UserRepository());
    pr = ProgressDialog(context);

    loadTemplateItems();

    super.initState();
  }

  Future<void> routeToMapPage(SignProject project) async {
    await Navigator.pushNamed(
      context,
      ProjectMapPage.route,
      arguments: ProjectMapPageArgs(null, project, false, true, false, false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SignTrackerAppBar.createAppBar(context, 'Template Plans'),
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is InvitationsLoaded &&
                state.invitations?.isNotEmpty == true) {
              final list = <_ListItem>[];
              state.invitations.forEach((title, invitations) {
                list.add(_HeadingItem(title));
                list.addAll(invitations
                    .map((invitation) => _CheckSignsItem(invitation)));
              });
            }

            return GroupedListView<dynamic, String>(
              elements: _templates,
              groupBy: (element) => element['group'],
              groupSeparatorBuilder: (String value) => Container(
                height: 50,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              itemBuilder: (c, element) {
                return Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    child: ListTile(
                      onTap: () => goToTemplateListItems(element['name']),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      title: Text(element['name']),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
              order: GroupedListOrder.DESC,
            );
          },
        ),
      ),
    );
  }

  void acceptProjectInvite(Invitation invitation) {
    bloc.acceptInvitation(invitation.id);
  }

  void dismissProjectInvite(Invitation invitation) {
    bloc.dismissInvitation(invitation.id);
  }

  Widget _buildGroupSeparator(dynamic groupByValue) {
    return Text('$groupByValue');
  }

  goToTemplateListItems(element) {
    Navigator.of(context)
        .pushNamed(TemplatePlanListItemViewPage.route,
            arguments:
                TemplateListArgs(widget.signProject, element, widget.page))
        .then((results) {
      if (results is PopWithResults) {
        PopWithResults popResult = results;
        if (popResult.toPage == TemplatePlanListItemPage.route) {
          print('=====================');
        } else {
          // pop to previous page
          Navigator.of(context).pop(results);
        }
      }
    });
  }

  void loadTemplateItems() {
    switch (widget.selectedTemplate.name) {
      case 'Low Speed/Low Volume':
        _templates = [
          {'name': '7.9B-One Lane Closure', 'group': 'Low Speed/Low Volume'},
          {
            'name': '7.4A-Shoulder Drop-off (Within Work Zone)',
            'group': 'Low Speed/Low Volume'
          },
          {
            'name': '7.1A-One Lane Closure (One Lane Alternating Traffic)',
            'group': 'Low Speed/Low Volume'
          },
          {
            'name': '7.4B-Shoulder Drop-off (Within Work Zone)',
            'group': 'Low Speed/Low Volume'
          },
          {'name': '7.3A-Work on Shoulder', 'group': 'Low Speed/Low Volume'},
          {'name': '7.2B-Right Lane Closure', 'group': 'Low Speed/Low Volume'},
          {
            'name': '7.9A-One Lane Closure (One Lane Alternating Traffic)',
            'group': 'Low Speed/Low Volume'
          },
          {'name': '7.2B-Right Lane Closure', 'group': 'Low Speed/Low Volume'},
          {'name': '7.5B-Intersecting Roads', 'group': 'Low Speed/Low Volume'},
          {
            'name': '7.10B-Two Lane Closure with 2-Way Traffic',
            'group': 'Low Speed/Low Volume'
          },
          {'name': '7.5A-Intersecting Roads', 'group': 'Low Speed/Low Volume'},
          {
            'name': '7.8B-Embankment and Fixed Objects',
            'group': 'Low Speed/Low Volume'
          },
          {'name': '7.3B-Work on Shoulder', 'group': 'Low Speed/Low Volume'},
          {
            'name': '7.8A-Embankment and Fixed Objects',
            'group': 'Low Speed/Low Volume'
          },
          {
            'name': '7.6A-Work on Centreline Two Lane Traffic',
            'group': 'Low Speed/Low Volume'
          },
          {'name': '7.7A-Detour', 'group': 'Low Speed/Low Volume'},
        ];

        break;

      case 'High Speed/High Volume':
        _templates = [
          {
            'name': '6.4B-Centre and Left Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.3B-Centre and Right Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.9B-Ramp to Two Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.11B-Full Closure to Detour',
            'group': 'High Speed/High Volume'
          },
          {'name': '6.1B-Left Lane Closure', 'group': 'High Speed/High Volume'},
          {
            'name': '6.10B-3 Lane Closure to Off-Ramp',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.2B-Right Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {'name': '6.12A-Detour', 'group': 'High Speed/High Volume'},
          {
            'name': '6.5B-Detour Four Lane to Opposing Traffic',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.8B-Ramp to One-Lane Closure (Free-Flow)',
            'group': 'High Speed/High Volume'
          },
          {'name': '6.6B-Work on Shoulder', 'group': 'High Speed/High Volume'},
          {
            'name':
                '6.7B-Localized Excavation Adjacent to Shoulder (Within Work Zone)',
            'group': 'High Speed/High Volume'
          },
        ];

        break;

      case 'High Speed/High Volume':
        _templates = [
          {
            'name': '6.4B-Centre and Left Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.3B-Centre and Right Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.9B-Ramp to Two Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.11B-Full Closure to Detour',
            'group': 'High Speed/High Volume'
          },
          {'name': '6.1B-Left Lane Closure', 'group': 'High Speed/High Volume'},
          {
            'name': '6.10B-3 Lane Closure to Off-Ramp',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.2B-Right Lane Closure',
            'group': 'High Speed/High Volume'
          },
          {'name': '6.12A-Detour', 'group': 'High Speed/High Volume'},
          {
            'name': '6.5B-Detour Four Lane to Opposing Traffic',
            'group': 'High Speed/High Volume'
          },
          {
            'name': '6.8B-Ramp to One-Lane Closure (Free-Flow)',
            'group': 'High Speed/High Volume'
          },
          {'name': '6.6B-Work on Shoulder', 'group': 'High Speed/High Volume'},
          {
            'name':
                '6.7B-Localized Excavation Adjacent to Shoulder (Within Work Zone)',
            'group': 'High Speed/High Volume'
          },
        ];

        break;

      case 'Long Duration':
        _templates = [
          {
            'name':
                '1.26A-Work Zone Speed<60km/h and Work Area<300mm Drop One Lane Alternating Traffic',
            'group': '2 Lane Undivided'
          },
          {
            'name': '1.17B-Chip Seat Coating Operations',
            'group': '4 Lane Divided'
          },
          {
            'name': '1.3A-Two Way Traffic(Reduced Roadway Width)',
            'group': '2 Lane Undivided'
          },
          {
            'name': '1.7B-No Centre Pavement Marking',
            'group': '4 Lane Divided'
          },
          {
            'name': '1.23B-Work Zone Speed<60km per hour',
            'group': '4 Lane Divided'
          },
          {
            'name': '1.22A-Work Zone Speed<60km per hour Two Way Traffic',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.21B-Work Zone Speed>60km per hour or Work Area>300mm Drop One Lane Closure',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.24B-Work Zone Speed<60km per hour and Work Area<300mm Drop',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.11A-Delineation for Embarkments and Fixed Objects (Within the Work Zone)',
            'group': '2 Lane Undivided'
          },
          {'name': '1.2B-No Lane Closure', 'group': '4 Lane Divided'},
          {
            'name': '1.17A-Chip Seat Coating Operations',
            'group': '2 Lane Undivided'
          },
          {'name': '1.2A-No Lane Closure.pdf', 'group': '2 Lane Undivided'},
          {'name': '1.8A-Detour', 'group': '2 Lane Undivided'},
          {
            'name': '1.6A-Truck Entrance (haul Route)',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.28-Example of Clear Zone Application for Work Area Two Lane Undivided Highway (One Lade Alternating Traffic)',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.15B-Bridge Deck Repair (Outside Lane) Clover Leaf Interchanges',
            'group': '4 Lane Divided'
          },
          {
            'name': '1.9A-Shoulder Drop-Off (Within Work Zone)',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.28B-Localized Excavation Adjacent to Shoulder (Within Work Zone)',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.18A-Double Seal and Graded Aggregate Seal Coating Operations',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.29B-Highway Tansition from Four Lane Divided to Two Lane Undivided',
            'group': ''
          },
          {
            'name':
                '1.27A-Work Zone Speed<60km per hour and Work Area<300mm Drop One Lane Alternating Traffic',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.28A-Localized Excavation Adjacent to Shoulder (Within Work Zone)',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                '1.20B-Work Zone Speed>60km per hour or Work Area>300mm Drop Reduce Bridge Width',
            'group': '4 Lane Divided'
          },
          {'name': '1.4A-Intersecting Roads', 'group': '2 Lane Undivided'},
          {
            'name': '1.19B-Work Zone Speed>60km per hour',
            'group': '4 Lane Divided'
          },
          {
            'name': '1.7A-No Centre Line Pavement Marking',
            'group': '2 Lane Undivided'
          },
          {'name': '1.4B-Intersecting Roads', 'group': '4 Lane Divided'},
          {
            'name': '1.1A-One Lane Closure-One Lane Alternating traffic',
            'group': '2 Lane Undivided'
          },
          {
            'name': '1.6B-Truck Entrance (Haul Route)',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.25B-Work Zone Speed<60km per hour and Work Area<300mm Drop One Lane Closure',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.16B-Bridge Deck Repair (Inside Lane) Clover Leaf Interchanges',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.29-Example of Clear Zone Application for Work Area Four Lane Divided Highway',
            'group': '4 Lane Divided'
          },
          {
            'name':
                '1.11B-Delineation for Embarkments and Fixed Objects (Within the Work Zone)',
            'group': '4 Lane Divided'
          },
          {
            'name': '1.5A-Obstruction Within Work Area',
            'group': '2 Lane Undivided'
          },
          {'name': '1.1B-One Lane Closure', 'group': '4 Lane Divided'},
        ];

        break;

      case 'Short Duration':
        _templates = [
          {'name': '2.7A-Work on Centreline', 'group': '2 Lane Undivided'},
          {'name': '2.2A-Work on Shoulder', 'group': '4 or 6 Lane Divided'},
          {
            'name':
                '2.5B-Right Lane Closure Repair Survey Testing Inspection Crews',
            'group': '4 or 6 Lane Divided'
          },
          {'name': '2.3A-Work off Road Surface', 'group': '2 Lane Undivided'},
          {
            'name':
                '2.4B-Centre and Right Lane Closure Repair Survey Testing Inspection Crews',
            'group': '4 or 6 Lane Divided'
          },
          {'name': '2.6A-Road Top Shaping', 'group': '2 Lane Undivided'},
          {'name': '2.1B-One Lane Closure', 'group': '4 or 6 Lane Divided'},
          {'name': '2.2B-Work on Shoulder', 'group': '4 or 6 Lane Divided'},
          {
            'name': '2.3B-Work off Road Surface',
            'group': '4 or 6 Lane Divided'
          },
          {'name': '2.3A-Work off Road Surface', 'group': '2 Lane Undivided'},
          {
            'name': '2.1A-One Lane Closure(One Lane Alternating Traffic)',
            'group': '2 Lane Undivided'
          },
        ];
        break;

      case 'Testing, Surveying and Other Short Duration Activities':
        _templates = [
          {'name': '3.1A-Traffic Survey', 'group': '2 Lane Undivided'},
          {'name': '3.2A-Mobile Testing', 'group': '2 Lane Undivided'},
          {
            'name': '3.5A-Chemical Vegetation Control',
            'group': '2 Lane Undivided'
          },
          {'name': '3.4A-Line Painting', 'group': '2 Lane Undivided'},
          {
            'name': '3.3A-Gravel-Oil-Road Maintenance',
            'group': '2 Lane Undivided'
          },
          {'name': '3.1B-Traffic Survey', 'group': '4 Lane Divided'},
          {'name': '3.2B-Mobile Testing', 'group': '4 Lane Divided'},
          {
            'name': '3.5B-Chemical Vegetation Controle',
            'group': '4 Lane Divided'
          },
          {'name': '3.4B-Line Painting', 'group': '4 Lane Divided'},
        ];
        break;

      case 'Utilities Construction':
        _templates = [
          {'name': '5.1A-Work Off Road Surface', 'group': '2 Lane Undivided'},
          {'name': '5.2A-Work on Shoulder', 'group': '2 Lane Undivided'},
          {
            'name': '5.3A-One Lane Closure(One Lane Alternating Traffic)',
            'group': '2 Lane Undivided'
          },
          {'name': '5.1B-Work Off Road Surface', 'group': '4 Lane Divided'},
          {'name': '5.2B-Work on Shoulder', 'group': '4 Lane Divided'},
          {'name': '5.3B-One Lane Closure', 'group': '4 Lane Divided'},
        ];
        break;

      case 'Emergency Activities':
        _templates = [
          {
            'name':
                'TCS-B-8.3A-Emergency Agency Response One Lane Closure Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name': 'TCS-B-8.1-Four Lane to Two Lane Emergency Detour',
            'group': ''
          },
          {
            'name':
                'TCS-B-8.3B-Emergency Agency Response One Lane Closure Four Lane Divided Highway',
            'group': '4 Lane Divided'
          },
        ];
        break;

      case 'Standard Drawings for Traffic Control Devices':
        _templates = [
          {'name': '4.1-Standard Barricade', 'group': ''},
          {'name': '4.3-Traffic Barrel Drum', 'group': ''},
          {'name': '4.2-Traffic Control Paddle', 'group': ''}
        ];
        break;

      case 'Work Zone Bulletin Drawings':
        _templates = [
          {
            'name':
                'TCS-B-4.4-Typical Signing One Lane Closure with Speed Fines Double Signage Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.8D-Typical Signing One Lane Closure (With Gateway Assemblies) Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.6B-Typical Signing One Lane Closure (Wiht Transition Speedy ZOne on Approach and Exit) Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.7A-Typical Signing Portable Rumble Strips (In Advance of Flagperson or Other Stop Condition) Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.9-Typical Signing One Lane Closure 9With Workers Present When Flashing Signs) Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.7C-Typical Signing Portable Rumble Strips (In Advance of Stop and Go Traffic Condition) Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name': 'TCS-B-4.8B-Gateway Assemblies Rural Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.6A-Typical Signing One Lane Closure (With Transition Speed Zone on Approach Only) Two Lane Undivided Highway',
            'group': '2 Lane Undivided'
          },
          {
            'name':
                'TCS-B-4.5-Typical Signing One Lane Closure with Speed Fines Double Signage Two Lane Undivided Highway',
            'group': '4 Lane Divided'
          },
          {
            'name':
                'TCS-B-4.8C-Gateway Assemblies Rural Divided Highway With Depressed Median',
            'group': '4 Lane Divided'
          },
          {
            'name':
                'TCS-B-4.7D-Typical Signing Portable Rumble Strips (In Advance of Stop and Go Traffic Condition) Four Lane Divided Highway',
            'group': '4 Lane Divided'
          },
          {'name': 'TCS-B-4.8A-Gateway Assemblies', 'group': '4 Lane Divided'},
          {
            'name':
                'TCS-B-4.7B-Typical Signing Portable Rumble Strips (In Advance of Flagperson or Other Stop Condition) Four Lane Divided Highway',
            'group': '4 Lane Divided'
          },
          {
            'name':
                'TCS-B-4.5-Typical Signing One Lane Closure Using zipper Merge Signage Strategy Four Lane Divided Highway',
            'group': '4 Lane Divided'
          },
        ];
        break;
    }
  }
}

abstract class _ListItem {}

class _HeadingItem implements _ListItem {
  const _HeadingItem(this.heading);

  final String heading;
}

class _CheckSignsItem implements _ListItem {
  const _CheckSignsItem(this.invitation);

  final Invitation invitation;
}

class _CheckSignsItem2 implements _ListItem {
  const _CheckSignsItem2(this.project);

  final SignProject project;
}

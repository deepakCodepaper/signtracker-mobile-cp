import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/project_list/project_list_bloc.dart';
import 'package:signtracker/blocs/project_list/project_list_events.dart';
import 'package:signtracker/blocs/project_list/project_list_states.dart';
import 'package:signtracker/feature/check_signs/check_signs_page.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/project/create/initialize_project_page.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/repository/invitation_repository.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'expandable_item/expandable_project_item.dart';

DateFormat dateFormat = DateFormat('dd MMM yyyy');

class ProjectListPageArgs {
  const ProjectListPageArgs(this.projectId);

  final int projectId;
}

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({this.projectId});

  static const String route = '/project-list';
  final int projectId;

  @override
  State<StatefulWidget> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProjectListBloc bloc;
  TextEditingController searchController;
  String queryText = "";
  List<SignProject> projects;
  int projectId;
  bool isFirstTime = true;

  var _currentIndex = 1;

  @override
  void initState() {
    if (widget.projectId != 0) {
      projectId = widget.projectId;
    }
    searchController = TextEditingController();
    bloc = ProjectListBloc(
      ProjectRepository(),
      InvitationRepository(),
      UserRepository(),
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.getProjects();
      searchController.addListener(() {
        print("Search Field================" + searchController.text);
        setState(() => queryText = searchController.text);
      });
    });
  }

  void showMessage(String message,[Color color]) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(milliseconds: 700),
      backgroundColor: color ?? Colors.red,
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: SignTrackerAppBar.createAppBar(context, 'Open Project'),
      body: BlocListener<ProjectListBloc, ProjectListState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ProjectsError) {
            showMessage(state.error);
          } else if (state is ReloadingProjects) {
            showMessage('Reloading Projects...',Colors.green);
          } else if (state is ProjectsListEmpty) {
            showMessage(state.msg);
          } else if (state is ProjectsLoaded) {
            showMessage('Fetch Projects...',Colors.green);
            setState(() => projects = state.projects);
          }
        },
        child: BlocBuilder<ProjectListBloc, ProjectListState>(
          bloc: bloc,
          builder: (context, state) {
            if(isFirstTime) {
              if (state is ProjectsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            if (projects?.isNotEmpty == true) {
                var tempList = List<SignProject>();
                isFirstTime = false;
                projects.forEach((f) {
                  if (f.status == 'active') {
                    tempList.add(f);
                  }
                });

                print("LST DATA=============================" + projects.toString());
                print("LST DATA2=============================" + projects.first.projectNotifications.toString());
                print("LST DATA2=============================" + projects.first.id.toString());

                projects = tempList;
                projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                final list = projects.where((projects){ return  projects.contractNumber?.contains(queryText) ?? false;})
                //final list = projects
                    .map(
                      (project) =>
                      ExpandableProjectItem(
                        onPressed: () => routeOpenProject(project),
                        project: project,
                        children: <Widget>[
                          ...project.subProjects.map(
                                (subProject) =>
                                _SubProjectItem(
                                  onPressed: () => routeOpenProject(subProject),
                                  project: subProject,
                                ),
                          )
                        ],
                      ),
                ).toList();

                return Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Select a Project',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50.0,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              gapPadding: 0.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              gapPadding: 0.0,
                            ),
                            hintText: 'Project Name',
                          ),
                          style: textTheme.bodyText1.copyWith(
                            color: Colors.yellow[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: LazyLoadScrollView(
                            onEndOfPage: () => bloc.add(FetchNextPage()),
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                if(index == list.length){
                                  if(state is ProjectsLoading) {
                                    return Center(child: CupertinoActivityIndicator());
                                  }
                                }else {
                                  return list[index];
                                }
                                },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemCount: list.length+1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

            return Center(
              child: Text('No Projects Found'),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.yellowPrimary,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) => onTabTapped(context, index),
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            label: 'New',
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/drawables/open-project.svg',
              fit: BoxFit.fill,
              color: Colors.black,
            ),
            label: 'Open',
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.flag,
              color: Colors.black,
            ),
            label: 'Check',
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          )
        ],
      ),
    );
  }

  void onTabTapped(BuildContext context, int index) async {
    switch (index) {
      case 0:
        await Navigator.pushNamed(context, InitializeProjectPage.route);
        bloc.reloadProjects();
        break;
      case 2:
        Navigator.pushNamed(context, CheckSignsPage.route,
            arguments: CheckSignsPageArgs(false));
        bloc.reloadProjects();
        break;
      case 3:
        Navigator.pushReplacementNamed(context, DashboardPage.route);
        bloc.reloadProjects();
    }
  }

  void routeOpenProject(SignProject signProject) async {
    await Navigator.pushNamed(
      context,
      OpenProjectPage.route,
      arguments: OpenProjectPageArgs(signProject, false),
    );
    bloc.reloadProjects();
  }
}

class _SubProjectItem extends StatelessWidget {
  const _SubProjectItem({
    @required this.onPressed,
    this.project,
  });

  final VoidCallback onPressed;
  final SignProject project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        color: AppColors.grayBackground,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${project.identifier != null ? project.identifier : project.contractNumber} ',
                    style: GoogleFonts.karla(
                        textStyle: TextStyle(fontSize: 14, color: Colors.black),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${project.highway} : ${project.intersection}',
                    style: GoogleFonts.karla(
                        textStyle: TextStyle(fontSize: 14, color: Colors.black),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              flex: 1,
            ),
//            Text(
//              'Added ${dateFormat.format(project.createdAt)}',
//              style: GoogleFonts.karla(
//                textStyle: TextStyle(
//                  fontSize: 14,
//                  color: Colors.grey,
//                ),
//              ),
//            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.black,
              ),
              onPressed: this.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

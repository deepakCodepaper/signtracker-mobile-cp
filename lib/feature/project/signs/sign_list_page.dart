import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/sign_library/sign_library_bloc.dart';
import 'package:signtracker/blocs/sign_library/sign_library_states.dart';
import 'package:signtracker/feature/project/signs/add_signs_page.dart';
import 'package:signtracker/feature/sign_library/sign_library_template_page.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/utilities/validators.dart';
import 'package:signtracker/widgets/app_bar.dart';

class SignListPageArgs {
  const SignListPageArgs(
      this.projectId, this.userLocation, this.withTraffic, this.project);

  final int projectId;
  final bool withTraffic;
  final LatLng userLocation;
  final SignProject project;
}

class SignListPage extends StatefulWidget {
  const SignListPage({
    @required this.projectId,
    @required this.userLocation,
    @required this.withTraffic,
    @required this.project,
  });

  static const String route = '/create-project-sign-list';
  final int projectId;
  final LatLng userLocation;
  final bool withTraffic;
  final SignProject project;

  @override
  State<StatefulWidget> createState() => _SignListPageState();
}

class _SignListPageState extends State<SignListPage> {
  SignLibraryBloc bloc;
  SignProject project;
  List<SignMasters> signs = List<SignMasters>();
  TextEditingController searchController;
  String queryText = "";
  Directory dir;
  String path = '';
  bool noChange = true;

  @override
  void initState() {
    bloc = SignLibraryBloc(RepositoryProvider.of<SignRepository>(context));
    project = widget.project;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (project.templateId == null || project.templateId == 0) {
        bloc.getallSignMasters();
      } else {
        bloc.fetchSigns(project.templateId);
      }
    });
    searchController = TextEditingController();

    loadAppDirectory();

    searchController.addListener(() {
      setState(() => queryText = searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Add Signs'),
      body: BlocListener<SignLibraryBloc, SignLibraryState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SignsLibraryLoaded) {
            setState(() {
              signs = state.signs;
            });
          }
        },
        child: BlocBuilder<SignLibraryBloc, SignLibraryState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SignsLibraryLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (signs?.isNotEmpty == true) {
              return Container(
                color: AppColors.grayBackground,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: 50,
                        color: Colors.white,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              gapPadding: 0.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              gapPadding: 0.0,
                            ),
                            hintText: 'Sign Name',
                          ),
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.all(5),
                        crossAxisCount: 2,
                        children: [
                          ...signs
                              .where((sign) =>
                                  sign.name.startsWith(queryText) &&
                                  sign.idName != null)
                              .map(
                                (sign) => GestureDetector(
                                  child: Stack(
                                    children: [
                                      Card(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .stretch, //add this
                                          children: <Widget>[
                                            Expanded(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    Validators.getSignImageLink(
                                                        sign.imageUrl),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Center(
                                                  child: Image.asset(
                                                      'assets/drawables/no-sign.png'),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  sign.name,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (sign.isFavorite == 1) ...[
                                        Positioned(
                                          top: 2,
                                          right: 5,
                                          child: Icon(Icons.favorite,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ],
                                  ),
                                  onTap: () async {
                                    path = pathName(sign.idName != null
                                        ? sign.idName
                                        : sign.name);

                                    Navigator.of(context)
                                        .pushNamed(
                                      AddSignsPage.route,
                                      arguments: AddSignsPageArgs(
                                        widget.projectId,
                                        sign,
                                        widget.userLocation.latitude,
                                        widget.userLocation.longitude,
                                        widget.withTraffic,
                                        project,
                                        path,
                                        dir.path,
                                      ),
                                    )
                                        .then((results) async {
                                      if (results is PopWithResults) {
                                        PopWithResults popResult = results;
                                        if (popResult.toPage ==
                                            SignListPage.route) {
                                        } else {
                                          // pop to previous page
                                          Navigator.of(context).pop(results);
                                        }
                                      }
                                    });
//                                    var result = await Navigator.pushNamed(
//                                      context,
//                                      AddSignsPage.route,
//                                      arguments: AddSignsPageArgs(
//                                        widget.projectId,
//                                        sign,
//                                        widget.userLocation.latitude,
//                                        widget.userLocation.longitude,
//                                        widget.withTraffic,
//                                        widget.project,
//                                        path,
//                                        dir.path,
//                                      ),
//                                    );
//                                    print(
//                                        '============================================= $result');
//                                    if (result == 'signAdded') {
//                                      print('SIGN ADDED');
//                                      Navigator.pop(context, 'signAdded');
//                                    } else {
//                                      print('NADA');
//                                      Navigator.pop(context, null);
//                                    }
                                  },
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text('No Signs Found for Project Template'),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: project.templateId != 0,
        child: FloatingActionButton(
          onPressed: () => proceedSignLibraryTemplate(),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.blueDialogButton,
        ),
      ),
    );
  }

  proceedSignLibraryTemplate() async {
    int oldTemplateId = project.templateId;
    var templateId = await Navigator.pushNamed(
        context, SignLibraryTemplatePage.route,
        arguments: SignLibraryTemplatePageArgs(project, 'add'));

    if (oldTemplateId != templateId) {
      noChange = false;
      project = project.rebuild((b) => b..templateId = templateId);
    } else {
      noChange = true;
    }

    if (project.templateId == null || project.templateId == 0) {
      bloc.getallSignMasters();
    } else {
      bloc.fetchSigns(project.templateId);
    }
  }

  File file(String filename) {
    String path = p.join(dir.path, filename);
    return File(path);
  }

  String pathName(String filename) {
    return p.join(dir.path, filename);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void loadAppDirectory() async {
    dir = await getApplicationDocumentsDirectory();
  }

  navigateWithNewTemplateId() {
//    if (noChange) {
//      Navigator.pop(context, null);
//    } else {
//      Navigator.pop(context, project.templateId);
//    }
  }
}

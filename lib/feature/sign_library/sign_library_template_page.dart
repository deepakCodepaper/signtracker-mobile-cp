import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/blocs/sign_library/sign_library_bloc.dart';
import 'package:signtracker/blocs/sign_library/sign_library_states.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/validators.dart';
import 'package:signtracker/widgets/app_bar.dart';

class SignLibraryTemplatePageArgs {
  const SignLibraryTemplatePageArgs(this.project, this.method);

  final SignProject project;
  final String method;
}

class SignLibraryTemplatePage extends StatefulWidget {
  const SignLibraryTemplatePage({
    @required this.project,
    @required this.method,
  });

  static const String route = '/sign-library-template';

  final SignProject project;
  final String method;

  @override
  State<StatefulWidget> createState() => _SignLibraryTemplatePageState();
}

class _SignLibraryTemplatePageState extends State<SignLibraryTemplatePage> {
  SignLibraryBloc bloc;
  SignProject currentProject;
  List<SignMasters> finalListOfSigns = List<SignMasters>();
  List<SignMasters> allSigns = List<SignMasters>();
  List<int> currentSigns = List<int>();
  List<int> favoritedSign = List<int>();
  TextEditingController searchController;
  String queryText = "";
  Directory dir;
  ProgressDialog pr;

  bool isFavorieMethod = false;
  SignMasters tappedSignId;

  @override
  void initState() {
    bloc = SignLibraryBloc(RepositoryProvider.of<SignRepository>(context));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.method == 'add'
        ? bloc.getallSignMasters()
        : bloc.fetchSigns(widget.project.templateId));

    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        queryText = searchController.text;
      });

    });
    pr = new ProgressDialog(context);
    pr.style(message: 'Loading...');
    currentProject = widget.project;
    loadAppDirectory();
  }

  void showErrorSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      message: message,
      icon: Icon(
        Icons.error,
        color: Colors.red,
        size: 20.0,
      ),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  void showSuccessSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      message: message,
      icon: Icon(
        Icons.info,
        color: Colors.green,
        size: 20.0,
      ),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(
          context,
          widget.method == 'add' || widget.method == 'view'
              ? 'Add to Library'
              : 'Delete from Library'),
      body: WillPopScope(
        onWillPop: () => navigateBackAndUpdateTemplate(),
        child: BlocListener<SignLibraryBloc, SignLibraryState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is SignsLibraryLoaded) {
              if (widget.method == 'add') {
                if (finalListOfSigns.isEmpty) {
                  finalListOfSigns = state.signs;
                  bloc.fetchSigns(widget.project.templateId);
                  print(allSigns);
                  print(
                      '------------------------' + allSigns.length.toString());
                } else {
                  state.signs.forEach((f) {
                    if (f.isFavorite != 1) {
                      currentSigns.add(f.id);
                    } else {
                      favoritedSign.add(f.id);
                    }
                  });
                  print(currentSigns);
                }
              } else {
                finalListOfSigns = state.signs;
                state.signs.forEach((f) {
                  if (f.isFavorite == 1) {
                    favoritedSign.add(f.id);
                  }
                });
              }
            }

            if (state is SignAddTemplateLoading) {
              pr.show();
            }

            if (state is SignAddTemplateLoaded) {
              pr.hide();
              showSuccessSnackBar('Sign added to template');
              print('=================');
              print(state.template.id);
              print(state.template);

              setState(() {
                if (isFavorieMethod) {
                  favoritedSign.add(tappedSignId.id);
                } else {
                  currentSigns.add(tappedSignId.id);
                }
              });

              currentProject = currentProject
                  .rebuild((b) => b..templateId = state.template.id);
            }

            if (state is SignAddTemplateError) {
              pr.hide();
              showErrorSnackBar(
                  'Either the sign already exist on the template or there was an internet connection error. Please try again.');
            }

            if (state is DeleteSignFromTemplateLoading) {
              pr.show();
            }

            if (state is DeleteSignFromTemplateLoaded) {
              pr.hide();
              showSuccessSnackBar(
                  'Sign deleted from template. Reloading Signs. Please wait.');

              currentProject = currentProject
                  .rebuild((b) => b..templateId = state.template.id);

              bloc.fetchSigns(currentProject.templateId);
            }

            if (state is DeleteSignFromTemplateError) {
              pr.hide();
              showErrorSnackBar(
                  'Either the sign was already deleted from the template or there was an internet connection error. Please try again.');
            }

            if (state is UnFavouriteSignLoading) {
              pr.show();
            }

            if (state is UnFavouriteSignLoaded) {
              pr.hide();
              showSuccessSnackBar(
                  'Sign unfavourited! Reloading Signs. Please wait.');

              currentProject = currentProject
                  .rebuild((b) => b..templateId = state.template.id);

              setState(() {
                favoritedSign.remove(tappedSignId.id);
              });
            }

            if (state is UnFavouriteSignError) {
              pr.hide();
              showErrorSnackBar(
                  'Either the sign was already unfavourited or there was an internet connection error. Please try again.');
            }
          },
          child: BlocBuilder<SignLibraryBloc, SignLibraryState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SignsLibraryLoading) {
                return Center(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: AppColors.yellowPrimary,
                    ),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is SignLibraryError) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                              gapPadding: 0.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
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
                        padding: EdgeInsets.all(10),
                        crossAxisCount: 2,
                        children: [
                          ...finalListOfSigns
                              .where((sign) =>
                                  sign.name.toLowerCase().startsWith(queryText.toLowerCase()))
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
                                                    'assets/drawables/no-sign.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(sign.name),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (currentSigns.contains(sign.id)) ...[
                                        Positioned(
                                          top: 2,
                                          right: 5,
                                          child: Icon(Icons.check_circle,
                                              color: Colors.green),
                                        ),
                                      ] else if (favoritedSign
                                          .contains(sign.id)) ...[
                                        Positioned(
                                          top: 2,
                                          right: 5,
                                          child: IconButton(
                                            icon: Icon(Icons.favorite,
                                                color: Colors.red),
                                            onPressed: () {
                                              bloc.unFavouriteSign(
                                                  currentProject, sign.id);
                                            },
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  onTap: () {
                                    print('${sign.name}');
                                    if (widget.method == 'add') {
                                      if (!currentSigns.contains(sign.id)) {
                                        tappedSignId = sign;
                                        showDialogConfirmationToAddSign(sign);
                                      } else {
                                        showErrorSnackBar(
                                            'Sign is either part of the library or favorited.');
                                      }
                                    } else if (widget.method == 'delete')
                                      showDialogConfirmationToRemoveSign(
                                          context, sign);
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
            },
          ),
        ),
      ),
    );
  }

  File file(String filename) {
    String pathName = p.join(dir.path, filename);
    return File(pathName);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void loadAppDirectory() async {
    dir = await getApplicationDocumentsDirectory();
  }

  showDialogConfirmationToAddSign(SignMasters sign) {
    showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
              title: Text(
                'Add Sign to Template',
                style: GoogleFonts.karla(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 200,
                width: 292,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Continue to add sign ${sign.name}?',
                      style: GoogleFonts.karla(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 48,
                      child: FlatButton(
                        color: AppColors.blueDialogButton,
                        child: Text(
                          'Add this sign to my TEMPLATE'.toUpperCase(),
                          style: GoogleFonts.karla(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          isFavorieMethod = false;
                          bloc.addSignToTemplate(
                              currentProject, sign.id, true, false);
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 48,
                      child: FlatButton(
                        color: AppColors.blueDialogButton,
                        child: Text(
                          'FAVOURITE THIS SIGN'.toUpperCase(),
                          style: GoogleFonts.karla(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          isFavorieMethod = true;
                          bloc.addSignToTemplate(
                              currentProject, sign.id, false, true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  showDialogConfirmationToRemoveSign(BuildContext context, SignMasters sign) {
    Alert(
      style: AlertStyle(
        titleStyle: GoogleFonts.karla(
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 22.0),
      ),
      context: context,
      type: AlertType.error,
      title: "Delete Sign from Template",
      desc: "Continue to delete sign ${sign.name}?",
      buttons: [
        DialogButton(
          color: AppColors.grayCheckSignsHeader,
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          color: AppColors.blueDialogButton,
          child: Text(
            "DELETE",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.pop(context);
            bloc.deleteSignFromTemplate(currentProject, sign.id);
          },
          width: 120,
        )
      ],
    ).show();
  }

  navigateBackAndUpdateTemplate() {
    Navigator.pop(context, currentProject.templateId);
  }
}

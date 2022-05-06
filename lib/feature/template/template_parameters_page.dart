import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/template/template_list_bloc.dart';
import 'package:signtracker/blocs/template/template_list_state.dart';
import 'package:signtracker/feature/template/template_list_page.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class TemplateParametersPageArgs {
  const TemplateParametersPageArgs(this.project, this.page);

  final SignProject project;
  final String page;
}

class TemplateParametersPage extends StatefulWidget {
  const TemplateParametersPage(this.project, this.page);

  static const String route = '/template-parameter';
  final SignProject project;
  final String page;

  @override
  _TemplateParametersPageState createState() => _TemplateParametersPageState();
}

class _TemplateParametersPageState extends State<TemplateParametersPage> {
  TemplateListBloc templateListBloc;
  ProgressDialog progressDialog;
  TextEditingController searchController;

  bool byParameters = true;
  bool loadMyTemplates = false;
  String duration = '';
  String lanes = '';
  String closure = '';
  bool loadByParameters = false;
  bool loadByDrawingNumber = false;

  List durations = [
    {
      "display": "All",
      "value": " ",
    },
    {
      "display": "Short Duration",
      "value": "short duration",
    },
    {
      "display": "Long Duration",
      "value": "long duration",
    },
  ];

  List numberOfLanes = [
    {
      "display": "All",
      "value": " ",
    },
    {
      "display": "2 Lanes",
      "value": "2",
    },
    {
      "display": "3 Lanes",
      "value": "2 Undivided",
    },
    {
      "display": "4 Lanes",
      "value": "4",
    },
  ];

  List closures = [
    {
      "display": "No Closure",
      "value": "none",
    },
    {
      "display": "One Lane Closure",
      "value": "1",
    },
    {
      "display": "Two Lane Closure",
      "value": "2",
    },
    {
      "display": "Three Lane Closure",
      "value": "3",
    },
    {
      "display": "Full Closure to Detour",
      "value": "Full",
    },
  ];

  @override
  void initState() {
    templateListBloc =
        TemplateListBloc(RepositoryProvider.of<ProjectRepository>(context));
    progressDialog = new ProgressDialog(context, isDismissible: true);
    progressDialog.style(message: 'Loading Templates');

    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Template'),
      body: BlocListener<TemplateListBloc, TemplateListState>(
        bloc: templateListBloc,
        listener: (context, state) async {
          if (state is LoadingTemplatesState) {
            await progressDialog.show();
          }
          if (state is LoadingTemplatesSuccessState) {
            await progressDialog.hide();
            setState(() {
              loadByDrawingNumber = false;
              loadByParameters = false;
            });
            if (state.template.length < 1) {
              showSnackBar('No templates found based on query');
            } else {
              if (!loadMyTemplates) {
                print(' do not load my templates');
                var temporaryList = new List<Template>();

                state.template.forEach((template) {
                  if (template.companyId == null) {
                    temporaryList.add(template);
                  }
                });
                Navigator.of(context)
                    .pushNamed(TemplatePlanListPage.route,
                        arguments: TemplateListPageArgs(
                            widget.project, temporaryList, false, widget.page))
                    .then((results) async {
                  if (results is PopWithResults) {
                    PopWithResults popResult = results;
                    if (popResult.toPage == TemplateParametersPage.route) {
                      print('==================');
                    } else {
                      // pop to previous page
                      Navigator.of(context).pop(results);
                    }
                  }
                });
              } else {
                var temporaryList = new List<Template>();

                state.template.forEach((template) {
                  if (template.companyId != null) {
                    temporaryList.add(template);
                  }
                });

                print('load my templates');
                Navigator.of(context)
                    .pushNamed(TemplatePlanListPage.route,
                        arguments: TemplateListPageArgs(
                            widget.project, temporaryList, true, widget.page))
                    .then((results) async {
                  if (results is PopWithResults) {
                    PopWithResults popResult = results;
                    if (popResult.toPage == TemplateParametersPage.route) {
                      print('==================');
                    } else {
                      // pop to previous page
                      Navigator.of(context).pop(results);
                    }
                  }
                });
              }
            }
          }
          if (state is LoadingTemplatesFailedState) {
            await progressDialog.hide().then((isHidden) {
              print(isHidden);
            });
            setState(() {
              loadByDrawingNumber = false;
              loadByParameters = false;
            });
          }
        },
        child: BlocBuilder<TemplateListBloc, TemplateListState>(
          bloc: templateListBloc,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RoundedButton(
                      height: 50,
                      onPressed: () => navigateToMyTemplateListPage(),
                      text: 'My Templates'.toUpperCase(),
                      radius: 5.0,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          hint: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Duration',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          value: duration == '' ? null : duration,
                          onChanged: (newValue) {
                            setState(() {
                              duration = newValue;
                            });
                          },
                          items: durations.map((item) {
                            return DropdownMenuItem(
                              value: item['value'],
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      item['display'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          hint: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.compare_arrows,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Lanes',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          value: lanes == '' ? null : lanes,
                          onChanged: (newValue) {
                            setState(() {
                              lanes = newValue;
                            });
                          },
                          items: numberOfLanes.map((item) {
                            return DropdownMenuItem(
                              value: item['value'],
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Icon(
                                      Icons.compare_arrows,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      item['display'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          hint: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.do_not_disturb_on,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Closure',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          value: closure == '' ? null : closure,
                          onChanged: (newValue) {
                            setState(() {
                              closure = newValue;
                            });
                          },
                          items: closures.map((item) {
                            return DropdownMenuItem(
                              value: item['value'],
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Icon(
                                      Icons.do_not_disturb_on,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      item['display'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RoundedButton(
                      height: 50,
                      onPressed: () => validateParameters(),
                      text: !loadByParameters
                          ? 'Search'.toUpperCase()
                          : 'Searching...'.toUpperCase(),
                      radius: 5.0,
                      color: Colors.black,
                      textColor: Colors.yellow[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.black),
                        Text(
                          'Search by Template ID',
                          style: GoogleFonts.montserrat(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                          gapPadding: 0.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                          gapPadding: 0.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RoundedButton(
                      onPressed: () => {
                        if (searchController.text.length > 0)
                          {
                            navigateToTemplateListPage(false),
                          }
                        else
                          {showSnackBar('Please enter a search query.')}
                      },
                      text: !loadByDrawingNumber
                          ? 'Search'.toUpperCase()
                          : 'Searching...'.toUpperCase(),
                      radius: 5.0,
                      color: AppColors.yellowPrimary,
                      textColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      message: message,
      icon: Icon(
        Icons.info,
        color: Colors.yellow[700],
        size: 20.0,
      ),
      duration: Duration(seconds: 2),
    ).show(context);
  }

  validateParameters() {
    if (duration == '') {
      showSnackBar('Please identify the duration of the project');
      return;
    }
    if (lanes == '') {
      showSnackBar('Please idenfity the number of lanes of the project');
      return;
    }
    if (closure == '') {
      showSnackBar('Please identify the closure type of the project');
      return;
    }

    navigateToTemplateListPage(true);
  }

  navigateToTemplateListPage(bool withParameters) async {
    loadMyTemplates = false;
    if (withParameters) {
      setState(() {
        loadByDrawingNumber = false;
        loadByParameters = true;
      });
      byParameters = true;
      templateListBloc.getTemplateListByParameters(duration, lanes, closure);
    } else {
      setState(() {
        loadByParameters = false;
        loadByDrawingNumber = true;
      });
      byParameters = false;
      templateListBloc.getTemplateListByDrawingNumber(searchController.text);
    }
  }

  navigateToMyTemplateListPage() async {
    loadMyTemplates = true;
    templateListBloc.getTemplateListByParameters(' ', ' ', 'none');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

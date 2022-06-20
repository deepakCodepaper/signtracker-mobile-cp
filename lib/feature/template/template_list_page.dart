import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/api/model/template.dart';
import 'package:signtracker/blocs/template/template_list_bloc.dart';
import 'package:signtracker/blocs/template/template_list_state.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/template/template_list_item_page.dart';
import 'package:signtracker/feature/template/template_plan_view.dart';
import 'package:signtracker/repository/project_repository.dart';
import 'package:signtracker/utilities/pop_result.dart';
import 'package:signtracker/widgets/app_bar.dart';

class TemplateListPageArgs {
  TemplateListPageArgs(
      this.project, this.templates, this.isLoadMyTemplates, this.page);

  final SignProject project;
  final List<Template> templates;
  final bool isLoadMyTemplates;
  final String page;
}

class TemplatePlanListPage extends StatefulWidget {
  const TemplatePlanListPage(
      this.project, this.templates, this.isLoadMyTemplates, this.page);

  static const String route = '/template-plans';
  final SignProject project;
  final List<Template> templates;
  final bool isLoadMyTemplates;
  final String page;

  @override
  State<StatefulWidget> createState() => _TemplatePlanListPageState();
}

class _TemplatePlanListPageState extends State<TemplatePlanListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  TemplateListBloc bloc;
  ProgressDialog pr;
  TextEditingController searchController;
  List<Template> templateList;
  String queryText = "";
  Timer _debounce;

  double paddingSearch = 50;

  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.length > 3) {
        bloc.getTemplateListByDrawingNumber(searchController.text);
      }
    });
  }

  @override
  void initState() {
    bloc = TemplateListBloc(RepositoryProvider.of<ProjectRepository>(context));
    templateList = widget.templates;
    pr = ProgressDialog(context);

    super.initState();

    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
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
        listener: (context, state) {
          if (state is LoadingTemplatesState) {
            pr.show();
          }
          if (state is LoadingTemplatesSuccessState) {
            print(widget.isLoadMyTemplates);
            pr.hide().then((isHidden) {
              print(isHidden);
            });
            if (state.template.length < 1) {
              showSnackBar('No templates found based on parameters');
            } else {
              print(widget.isLoadMyTemplates);
              if (widget.isLoadMyTemplates) {
                var temporaryList = new List<Template>();

                state.template.forEach((template) {
                  if (template.companyId != null) {
                    temporaryList.add(template);
                  }
                });

                templateList = temporaryList;
              }

              setState(() {
                templateList = state.template;
              });
            }
          }
          if (state is LoadingTemplatesFailedState) {
            pr.hide().then((isHidden) {
              print(isHidden);
            });
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GroupedListView<dynamic, String>(
                      elements: templateList,
                      groupBy: (element) => '',
                      groupSeparatorBuilder: (String value) => Container(
                        height: 0,
                        color: Colors.yellow[700],
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
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            child: ListTile(
                              onTap: () => goToTemplateListItems(element),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              title: Text(
                                  '${element.drawingNumber} ${element.name}'),
                              trailing: Icon(Icons.arrow_forward),
                            ),
                          ),
                        );
                      },
                      order: GroupedListOrder.DESC,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGroupSeparator(dynamic groupByValue) {
    return Text('$groupByValue');
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

  goToTemplateListItems(element) {
    print("HERERERERERERE" + element.toString());
    print("PAGE " + widget.page.toString());
    Navigator.of(context)
        .pushNamed(TemplatePlanListItemViewPage.route,
            arguments: TemplateListArgs(widget.project, element, widget.page))
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
}

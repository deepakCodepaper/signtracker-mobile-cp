import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:signtracker/api/model/sign_project.dart';
import 'package:signtracker/feature/project/maps/project_map_page.dart';
import 'package:signtracker/feature/project/update/open_project_page.dart';
import 'package:signtracker/feature/sub_project/create_sub_project.dart';
import 'package:signtracker/styles/values/values.dart';

const Duration _kExpand = const Duration(milliseconds: 200);

class ExpandableProjectItem extends StatefulWidget {
  const ExpandableProjectItem({
    Key key,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.project,
    this.onPressed,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Color backgroundColor;
  final Widget trailing;
  final bool initiallyExpanded;
  final SignProject project;
  final Function onPressed;

  @override
  State<ExpandableProjectItem> createState() => _ExpandableProjectItemState();
}

class _ExpandableProjectItemState extends State<ExpandableProjectItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _headerColor;
  ColorTween _iconColor;
  ColorTween _backgroundColor;

  bool _isExpanded = false;
  DateFormat dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeInAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _headerColor = new ColorTween();
    _iconColor = new ColorTween();
    _backgroundColor = new ColorTween();

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged(_isExpanded);
      }
    }
  }

  void navigateToProjectMap(SignProject project) {
    Navigator.pushNamed(
      context,
      ProjectMapPage.route,
      arguments: ProjectMapPageArgs(null, project, false, false, false, false),
    );
  }

  void navigateToCreateSubProject(SignProject project) {
    Navigator.pushNamed(
      context,
      CreateSubProjectPage.route,
      arguments: CreateSubProjectPageArgs(project),
    );
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return new Material(
        color: Colors.white.withOpacity(0.0),
        child: Ink(
          child: InkWell(
            onTap: widget.onPressed,
            child: Container(
              decoration: new BoxDecoration(
                color: AppColors.grayButtonsBackground,
              ),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  IconTheme.merge(
                    data: new IconThemeData(
                      color: _iconColor.evaluate(_easeInAnimation),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.project.identifier != null ? widget.project.identifier : widget.project.contractNumber} ',
                                style: GoogleFonts.karla(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '${widget.project.highway} : ${widget.project.intersection}',
                                style: GoogleFonts.karla(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: widget.project.subProjects.length > 0,
                                child: SizedBox(
                                  child: FlatButton(
                                    color: AppColors.yellowPrimary,
                                    padding: EdgeInsets.only(
                                        right: 10, top: 4, bottom: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      side: BorderSide(
                                          color: AppColors.yellowPrimary),
                                    ),
                                    onPressed: toggle,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${widget.project.subProjects?.length ?? 0} Sub Projects',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.karla(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 30),
//                                child: Text(
//                                  'Added ${dateFormat.format(widget.project.createdAt)}',
//                                  style: GoogleFonts.karla(
//                                      textStyle: TextStyle(
//                                          fontSize: 15, color: Colors.grey)),
//                                ),
//                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () =>
                              navigateToCreateSubProject(widget.project),
                        ),
                      ],
                    ),
                  ),
                  new ClipRect(
                    child: new Align(
                      heightFactor: _easeInAnimation.value,
                      child: child,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: omit_local_variable_types
    final ThemeData theme = Theme.of(context);
    _borderColor.end = theme.dividerColor;
    _headerColor
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColor.end = widget.backgroundColor;

    // ignore: omit_local_variable_types
    final bool closed = !_isExpanded && _controller.isDismissed;
    return new AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : new Column(children: widget.children),
    );
  }
}

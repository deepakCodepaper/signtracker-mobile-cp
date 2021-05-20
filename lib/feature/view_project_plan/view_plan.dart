import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signtracker/widgets/app_bar.dart';

class _ViewProjectPlanPageArgs {
  const _ViewProjectPlanPageArgs(this.imagePlan);

  final String imagePlan;
}

class _ViewProjectPlanPage extends StatelessWidget {
  const _ViewProjectPlanPage(this.imagePlan);

  final String imagePlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Project Template'),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: 300,
            child: Image.file(
              new File(imagePlan),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadProjectPage extends StatefulWidget {
  static const String route = '/upload-project';

  @override
  State<StatefulWidget> createState() => _UploadProjectPageState();
}

class _UploadProjectPageState extends State<UploadProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 50),
          Text(
            'Upload Project Template...\nPlease wait while we redirect you to the website',
            style: TextStyle(
              inherit: false,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

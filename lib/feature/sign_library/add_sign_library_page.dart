import 'package:flutter/material.dart';
import 'package:signtracker/api/model/sign.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:signtracker/widgets/rounded_button.dart';
import 'package:signtracker/widgets/success_box.dart';

class AddSignLibraryArguments {
  AddSignLibraryArguments(this.sign);
  final Sign sign;
}

class AddSignLibraryPage extends StatefulWidget {
  const AddSignLibraryPage({@required this.sign});

  final Sign sign;

  static const String route = '/add-sign-library';

  @override
  State<StatefulWidget> createState() => _AddSignLibraryPageState();
}

class _AddSignLibraryPageState extends State<AddSignLibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context,'Sign Library'),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.lightBlue,
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.width * 0.65,
                      child: Image.network(
                        widget.sign.image,
                        color: Colors.lightBlue,
                        loadingBuilder: (_, __, ___) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.sign.name,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            RoundedButton(
              padding: EdgeInsets.symmetric(horizontal: 10),
              text: 'Add Sign to Library'.toUpperCase(),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_) => _AddedToLibraryPage()));
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _AddedToLibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          height: 300,
          child: SuccessBox(
            details: Text(
              'Sign Name 1 added to Library',
              style: TextStyle(color: Colors.blue),
            ),
            onClosePressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

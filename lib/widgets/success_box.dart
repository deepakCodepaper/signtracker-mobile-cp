import 'package:flutter/material.dart';

class SuccessBox extends StatelessWidget {
  const SuccessBox({
    this.details,
    this.onClosePressed,
  });

  final Widget details;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 30,
                  bottom: 50,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.yellow[700],
                      size: 145,
                    ),
                    details ?? Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 18,
          top: 15,
          child: SizedBox(
            width: 30,
            height: 30,
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              onPressed: onClosePressed,
              shape: CircleBorder(),
              child: Icon(
                Icons.close,
                color: Colors.grey,
                size: 20,
              ),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

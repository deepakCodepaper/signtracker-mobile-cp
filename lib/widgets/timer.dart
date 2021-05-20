import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    this.titleIcon,
    this.title,
    this.time,
    this.interval,
    this.onPlusPressed,
    this.onMinusPressed,
  });

  final IconData titleIcon;
  final String title;
  final String time;
  final String interval;
  final VoidCallback onPlusPressed;
  final VoidCallback onMinusPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              this.titleIcon,
              size: 15,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              this.title,
              style: GoogleFonts.karla(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  time,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.karla(
                      textStyle: TextStyle(fontSize: 14, color: Colors.black)),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    interval,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.karla(
                        textStyle:
                            TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: this.onPlusPressed,
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: this.onMinusPressed,
                        icon: Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../constants.dart';

class OfferCounterTimer extends StatelessWidget {
  const OfferCounterTimer({
    Key? key,
    required this.endTime,
  }) : super(key: key);

  final int endTime;

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
        endTime: endTime,
        endWidget: Container(),
        widgetBuilder: (BuildContext context, time) {
          if (time!.days != null) {
            int hourNow = time.days! * 24;
          }
          if (time == null) {
            return Container();
          }
          return Row(
            children: [
              //sec box
              Container(
                padding: EdgeInsets.only(top: 2),
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(1),
                      ),
                      const BoxShadow(
                        color: kPrimaryColor,
                        spreadRadius: -24.5,
                        blurRadius: 1.2,
                      ),
                    ],
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    '${time.sec}',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              //min box
              Container(
                padding: EdgeInsets.only(top: 2),
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(1),
                      ),
                      BoxShadow(
                        color: kPrimaryColor,
                        spreadRadius: -24.5,
                        blurRadius: 1.2,
                      ),
                    ],
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    isNullMin(time.min) ? "0" : '${time.min}',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              //hour Box
              Container(
                padding: EdgeInsets.only(top: 2, left: 1),
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(1),
                      ),
                      const BoxShadow(
                        color: kPrimaryColor,
                        spreadRadius: -24.5,
                        blurRadius: 1.2,
                      ),
                    ],
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    '${time.hours! + (isNullHour(time.days) ? 0 : time.days)! * 24.toInt()}',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        });
  }

  isNullMin(int? min) {
    if (min == null)
      return true;
    else
      return false;
  }

  isNullHour(int? hour) {
    if (hour == null)
      return true;
    else
      return false;
  }

  isNullDay(int day) {
    if (day == null)
      return true;
    else
      return false;
  }
}

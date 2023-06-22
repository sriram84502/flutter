import 'package:flutter/material.dart';

class GetTime {
  static String getFormatedDate(
      {required BuildContext context, required String time}) {
    // ignore: unused_local_variable
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}

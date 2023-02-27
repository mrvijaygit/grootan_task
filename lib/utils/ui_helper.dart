import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'globals.dart';
import 'package:grootan_task/utils/styles.dart';

class UiHelper {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool keyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy, HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  static void openLoadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: <Widget>[
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation(
                  Globals.primary,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Styles.headingStyle4(
                    isBold: true
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
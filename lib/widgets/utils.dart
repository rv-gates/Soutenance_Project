import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger
        .of(context)
        .showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        elevation: 7.0,
        content: Row(
          children: [
            Text(message),
            const Spacer(),
            const Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
    }

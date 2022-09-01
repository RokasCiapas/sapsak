import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool?> displayDialogOKCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title, style: const TextStyle(fontSize: 16),),),
          content:  Text(message),
          actions: <Widget>[
            TextButton(
              child:  const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child:  const Text('Cancel',),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
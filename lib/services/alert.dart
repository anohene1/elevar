import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context) {

  if (Platform.isIOS) {
    showCupertinoModalPopup(context: context, builder: (context) => CupertinoAlertDialog(
      title: const Text('Image saved successfully'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ));
  } else {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Image saved successfully'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text('OK'))
      ],
    ));
  }
}
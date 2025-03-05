import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CupertinoAlertDialog dialog(String message, BuildContext context) {
  return CupertinoAlertDialog(
  title: Text('Xác nhận hành động này ?'),
    actions: [
      CupertinoDialogAction(
        child: Text('Hủy'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      CupertinoDialogAction(
        child: Text('Xác nhận'),
        onPressed: () {
          // Xử lý hành động xác nhận ở đây
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
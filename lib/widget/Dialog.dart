import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CupertinoAlertDialog dialog(String message, BuildContext context) {
  return CupertinoAlertDialog(
  title: const Text('Xác nhận hành động này ?'),
    actions: [
      CupertinoDialogAction(
        child: const Text('Hủy'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      CupertinoDialogAction(
        child: const Text('Xác nhận'),
        onPressed: () {
          // Xử lý hành động xác nhận ở đây
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
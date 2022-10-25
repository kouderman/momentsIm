import 'package:flutter/material.dart';

class RenameDialog extends AlertDialog {
  RenameDialog({Widget contentWidget})
      : super(
          content: contentWidget,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey, width: 1)),
        );
}


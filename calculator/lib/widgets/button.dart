import 'package:flutter/material.dart';

buttonCustom({required Function() onPressed, required String text, Color? colors}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: colors == null ? Colors.brown[900] : colors,
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    onPressed: onPressed,
    child: Text(
      text,
    ),
  );
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:calculator/widgets/button.dart';

void showDialogGeneral({
  context,
  String? title,
  String? subtitle,
  Color? buttonOne,
  Color? buttonTwo,
  bool? dismissible,
  String? firstAction,
  String? secondAction,
  Function? firstCallback,
  Function? secondCallback,
}) {
  showGeneralDialog(
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (ctx, anim1, anim2) => AlertDialog(
      content: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    textScaleFactor: 1.3,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Text(
                      subtitle!,
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: buttonCustom(
                    onPressed: () {
                      firstCallback!();
                    },
                    text: firstAction!,
                    colors: buttonOne,
                  ),
                ),
              ],
            ),
          ),
          if (secondAction != null)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: buttonCustom(
                      onPressed: () {
                        secondCallback!();
                      },
                      text: secondAction,
                      colors: buttonTwo,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      backgroundColor: Colors.white,
    ),
  );
}

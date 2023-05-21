// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppKeyboardHiderWrapper extends StatelessWidget {
  final Widget child;
  const AppKeyboardHiderWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    ///return widget
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );

    //return Listener(
    //  behavior: HitTestBehavior.opaque,
    //  onPointerDown: (_) {
    //    //FocusManager.instance.primaryFocus?.unfocus();
    //  },
    //  child: child,
    //);
  }
}

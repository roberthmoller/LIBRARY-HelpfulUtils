import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_utils/logger/logger.dart';

abstract class Popup<R> {
  Future<R?> show(BuildContext context);

  bool pop(BuildContext context, [R? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
      return true;
    }
    return false;
  }
}

abstract class HasBaseWidget {
  Widget base(BuildContext context, {required Widget child});
}

abstract class StatelessPopup<R> extends StatelessWidget with PrettyLogger<StatelessPopup<R>> implements Popup<R>, HasBaseWidget {
  Widget build(BuildContext context);

  Future<R?> show(BuildContext context) async {
    if (Platform.isIOS) {
      // VibrationHandler().popup(); todo: should vibrate
    }
    return showModalBottomSheet<R>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => base(
        context,
        child: build(context),
      ),
    ).catchError(log.e);
  }
}

abstract class StatefulPopup<R> extends StatefulWidget with PrettyLogger<StatelessPopup<R>>, HasBaseWidget {
  Widget self(BuildContext context);

  Future<R?> show(BuildContext context) async {
    if (Platform.isIOS) {
      // VibrationHandler().popup(); todo: should vibrate
    }
    return showModalBottomSheet<R>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => base(
        context,
        child: self(context),
      ),
    ).catchError(log.e);
  }

  bool pop(BuildContext context, [R? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
      return true;
    }
    return false;
  }
}

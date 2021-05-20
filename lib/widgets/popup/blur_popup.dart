import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_utils/widgets/popup/popup.dart';

mixin BlurSheet<R> implements HasBaseWidget, Popup<R> {
  static const double BORDER_RADIUS = 15;

  Widget base(BuildContext context, {required Widget child}) {
    return Dismissible(
      key: Key('dismissiblePopup'),
      direction: DismissDirection.down,
      onDismissed: (_) => this.pop(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.6),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: child,
          ),
        ),
      ),
    );
  }
}

mixin DraggableBlurSheet<R> implements HasBaseWidget, Popup<R> {
  static const double BORDER_RADIUS = 15;
  ScrollController? controller;
  final minChildSize = 0.4;
  final initialChildSize = 0.6;

  Widget base(BuildContext context, {required Widget child}) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: minChildSize,
      initialChildSize: initialChildSize,
      maxChildSize: 1,
      builder: (context, controller) {
        this.controller = controller;
        return ClipRRect(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(initialChildSize),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

mixin BlurPrompt<R> implements HasBaseWidget, Popup<R> {
  Widget base(BuildContext context, {required Widget child}) {
    return Center(
      child: Dismissible(
        key: Key('dismissiblePopup'),
        direction: DismissDirection.down,
        onDismissed: (_) => this.pop(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.6),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

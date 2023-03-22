import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(
        color: Colors
            .red),
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

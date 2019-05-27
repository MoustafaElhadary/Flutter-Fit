import 'package:flutter/material.dart';

abstract class StatelessPageBase extends StatelessWidget {
  String pageTitle;

  StatelessPageBase();
  @override
  Widget build(BuildContext context) {}
}

abstract class StatelfulPageBase extends StatefulWidget {
  String pageTitle;
  StatelfulPageBase();
}

class _StatelfulPageBaseState extends State<StatelfulPageBase> {
  @override
  Widget build(BuildContext context) {}
}

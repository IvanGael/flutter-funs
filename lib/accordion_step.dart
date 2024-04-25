import 'package:flutter/material.dart';

class AccordionStep {
  String title;
  Widget content;
  bool isExpanded;

  AccordionStep({required this.title, required this.content, this.isExpanded = false});
}

import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/accordion_step.dart';

class AccordionStepper extends StatefulWidget {
  final List<AccordionStep> steps;

  const AccordionStepper({super.key, required this.steps});

  @override
  // ignore: library_private_types_in_public_api
  _AccordionStepperState createState() => _AccordionStepperState();
}

class _AccordionStepperState extends State<AccordionStepper> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.steps[index].isExpanded = !isExpanded;
        });
      },
      children: widget.steps.map<ExpansionPanel>((AccordionStep step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: step.content,
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
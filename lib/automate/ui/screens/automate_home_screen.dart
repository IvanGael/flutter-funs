
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/drag_provider.dart';
import 'widgets/automate_app_bar.dart';
import 'widgets/drag_zone.dart';

class AutomateHomeScreen extends StatelessWidget {
  const AutomateHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AutomateAppBar(),
            Expanded(
                child: ChangeNotifierProvider<DragProvider>(
                    create: (context) => DragProvider()..init(),
                    child: const MyHomeScreenDragZone())),
          ],
        ),
      ),
    );
  }
}

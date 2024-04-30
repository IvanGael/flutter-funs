import 'package:flutter/material.dart';

import '../../../enum/state_enum.dart';
import '../../../models/state.dart';

class AutomateAppBar extends StatefulWidget {
  const AutomateAppBar({Key? key}) : super(key: key);

  static const Size etatSize = Size(70, 70);

  @override
  State<AutomateAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<AutomateAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration:  BoxDecoration(
            color: Colors.pink,
            border: Border(bottom: BorderSide(color: Colors.cyan[600]!, width: 4))
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Automate drawing board',
                style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: kToolbarHeight * 1.5,
          decoration:  BoxDecoration(
            color: Colors.blue[50],
              border: Border(bottom: BorderSide(color: Colors.cyan[600]!, width: 3))),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: StateType.values.length,
            separatorBuilder: (BuildContext context, int index) {
              return VerticalDivider(
                color: Colors.cyan[600]!,
                width: 3.0,
                thickness: 3.0,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(margin: const EdgeInsets.only(right: 10), child: _buildItem(StateType.values[index]));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(StateType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Draggable<StateType>(
        data: type,
        feedback: Image.asset(
          Etat.imageByType(type),
          width: AutomateAppBar.etatSize.width,
          height: AutomateAppBar.etatSize.height,
        ),
        child: Image.asset(
          Etat.imageByType(type),
          width: AutomateAppBar.etatSize.width,
          height: AutomateAppBar.etatSize.height,
        ),
      ),
    );
  }
}

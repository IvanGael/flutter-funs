// ignore_for_file: library_private_types_in_public_api

// Creates an application in Flutter that allows you to make a visual representation
//  of the tables in a database with the different relationships 
//  (1-to-many relationships, many-to-many relationships) between these tables using 
//  drag-n-drop. You can drag and drop a table, enter the information concerning the table, 
//  then drag and drop another table, also fill in the information for this table and finally 
//  create a relationship between these two tables.

import 'package:flutter/material.dart';

class TableInfo {
  String name;
  List<String> columns;
  Offset position;

  TableInfo(this.name, this.columns, {required this.position});
}

class Relationship {
  String fromTable;
  String toTable;

  Relationship(this.fromTable, this.toTable);
}

class DatabaseVisualizer extends StatefulWidget {
  const DatabaseVisualizer({Key? key}) : super(key: key);

  @override
  _DatabaseVisualizerState createState() => _DatabaseVisualizerState();
}

class _DatabaseVisualizerState extends State<DatabaseVisualizer> {
  List<TableInfo> tables = [];
  List<Relationship> relationships = [];


  void _showMenu(BuildContext context, TableInfo table) {
    final RelativeRect positionRect = RelativeRect.fromRect(
      Rect.fromPoints(table.position, table.position),
      Rect.fromPoints(table.position, table.position)
    );

    showMenu(
      context: context,
      position: positionRect,
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add a relationship'),
            onTap: (){
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddRelationshipDialog(
                  fromTable: table.name,
                  tables: tables,
                  onRelationshipAdded: (Relationship relationship) {
                    setState(() {
                      relationships.add(relationship);
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.delete_rounded),
            title: const Text('Delete the table'),
            onTap: (){
              setState(() {
              tables.remove(table);
              // Remove any relationships associated with this table
              relationships.removeWhere((rel) =>
                  rel.fromTable == table.name || rel.toTable == table.name);
            });
            Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }

  Widget _buildFloatingMenu() {
    return Container(
      width: 50,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTableDialog(
                    onTableAdded: (TableInfo table) {
                      setState(() {
                        tables.add(TableInfo(table.name, table.columns,
                            position: const Offset(0, 0)));
                      });
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: tables.isEmpty ? null : () {
              setState(() {
                tables.clear();
                relationships.clear();
              });
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
    );
  }


  // Widget _buildPopupMenu(TableInfo table) {
  //   return Positioned(
  //     top: table.position.dy,
  //     left: table.position.dx + 4,
  //     child: PopupMenuButton(
  //     itemBuilder: (BuildContext context) => [
  //       PopupMenuItem(
  //         value: 'add_relationship',
  //         child: Text('Add a relationship'),
  //       ),
  //       PopupMenuItem(
  //         value: 'delete_table',
  //         child: Text('Delete the table'),
  //       ),
  //     ],
  //     onSelected: (String value) {
  //       switch (value) {
  //         case 'add_relationship':
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AddRelationshipDialog(
  //                 fromTable: table.name,
  //                 tables: tables,
  //                 onRelationshipAdded: (Relationship relationship) {
  //                   setState(() {
  //                     relationships.add(relationship);
  //                   });
  //                 },
  //               );
  //             },
  //           );
  //           break;
  //         case 'delete_table':
  //           setState(() {
  //             tables.remove(table);
  //             // Remove any relationships associated with this table
  //             relationships.removeWhere((rel) =>
  //                 rel.fromTable == table.name || rel.toTable == table.name);
  //           });
  //           break;
  //       }
  //     },
  //   )
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  for (var i = 0; i < tables.length; i++)
                    Positioned(
                      left: tables[i].position.dx,
                      top: tables[i].position.dy,
                      child: Draggable(
                        feedback: TableWidget(
                          tables[i].name,
                          tables[i].columns,
                          onTap: (tableName) {},
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: TableWidget(tables[i].name, tables[i].columns,
                              onTap: (tableName) {}),
                        ),
                        onDragEnd: (details) {
                          setState(() {
                            tables[i].position = details.offset;
                          });
                        },
                        child: GestureDetector(
                          onLongPressStart: (details){
                            _showMenu(context, tables[i]);
                          },
                          child: TableWidget(
                          tables[i].name,
                          tables[i].columns,
                          onTap: (tableName) {
                            // _buildPopupMenu(tables[i]);
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return AddRelationshipDialog(
                            //       fromTable: tableName,
                            //       tables: tables,
                            //       onRelationshipAdded:
                            //           (Relationship relationship) {
                            //         setState(() {
                            //           relationships.add(relationship);
                            //         });
                            //       },
                            //     );
                            //   },
                            // );
                          },
                        ),
                        ),
                      ),
                    ),
                  for (var relation in relationships)
                    RelationshipLine(
                      fromTable: relation.fromTable,
                      toTable: relation.toTable,
                      tables: tables,
                    )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingMenu(),
    );
  }
}

class TableWidget extends StatelessWidget {
  final String name;
  final List<String> columns;
  final Function(String) onTap;

  const TableWidget(this.name, this.columns, {required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(name);
      },
      child: Card(
        elevation: 12,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  for (var column in columns) Text(column),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RelationshipLine extends StatelessWidget {
  final String fromTable;
  final String toTable;
  final List<TableInfo> tables;

  const RelationshipLine({
    Key? key,
    required this.fromTable,
    required this.toTable,
    required this.tables,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fromTableRef = tables.singleWhere((table) => table.name == fromTable);
    final toTableRef = tables.singleWhere((table) => table.name == toTable);

    return CustomPaint(
      painter: RelationshipPainter(
        from: Offset(fromTableRef.position.dx + 10, 0),
        to: Offset(toTableRef.position.dx - 10, 0),
        label: ""
      ),
    );
  }
}


class RelationshipPainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final String label;

  RelationshipPainter({
    required this.from,
    required this.to,
    required this.label,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw the line between 'from' and 'to' points
    canvas.drawLine(from, to, paint);

    // Calculate the midpoint between 'from' and 'to' points
    final midPoint = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2);

    // Draw the label at the midpoint
    final textSpan = TextSpan(
      text: label,
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, midPoint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AddTableDialog extends StatefulWidget {
  final Function(TableInfo) onTableAdded;

  const AddTableDialog({Key? key, required this.onTableAdded})
      : super(key: key);

  @override
  _AddTableDialogState createState() => _AddTableDialogState();
}

class _AddTableDialogState extends State<AddTableDialog> {
  late TextEditingController _nameController;
  late TextEditingController _columnsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _columnsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Table'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Table Name'),
          ),
          TextField(
            controller: _columnsController,
            decoration:
                const InputDecoration(labelText: 'Columns (comma separated)'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text;
            final columns = _columnsController.text.split(',');
            if(name.isNotEmpty && columns.isNotEmpty){
              final table = TableInfo(
              name,
              columns,
              position: const Offset(0, 0),
            );
            widget.onTableAdded(table);
            Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _columnsController.dispose();
    super.dispose();
  }
}

class AddRelationshipDialog extends StatefulWidget {
  final String fromTable;
  final List<TableInfo> tables;
  final Function(Relationship) onRelationshipAdded;

  const AddRelationshipDialog({
    required this.fromTable,
    required this.tables,
    required this.onRelationshipAdded,
    Key? key,
  }) : super(key: key);

  @override
  _AddRelationshipDialogState createState() => _AddRelationshipDialogState();
}

class _AddRelationshipDialogState extends State<AddRelationshipDialog> {
  String? _toTable;
  String? _cardinality;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Relationship'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _toTable,
            onChanged: (String? newValue) {
              setState(() {
                _toTable = newValue;
              });
            },
            items: widget.tables
                .where((table) => table.name != widget.fromTable)
                .map((table) {
              return DropdownMenuItem<String>(
                value: table.name,
                child: Text(table.name),
              );
            }).toList(),
            hint: const Text('To Table'),
          ),
          DropdownButtonFormField<String>(
            value: _cardinality,
            onChanged: (String? newValue) {
              setState(() {
                _cardinality = newValue;
              });
            },
            items: ['1 to N', 'N to N', 'N to 1'].map((cardinality) {
              return DropdownMenuItem<String>(
                value: cardinality,
                child: Text(cardinality),
              );
            }).toList(),
            hint: const Text('Cardinality'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_toTable != null && _cardinality != null) {
              final relationship = Relationship(widget.fromTable, _toTable!);
              widget.onRelationshipAdded(relationship);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

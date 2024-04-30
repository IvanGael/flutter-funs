import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8,
        Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class SlateDrawingScreen extends StatefulWidget {
  const SlateDrawingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<SlateDrawingScreen> {
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 200,
              color: Colors.black26,
              child: Signature(
                color: color,
                key: _sign,
                onSign: () {
                  final sign = _sign.currentState;
                  debugPrint('${sign?.points.length} points in the signature');
                },
                // backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                strokeWidth: strokeWidth,
              ),
            ),
            _img.buffer.lengthInBytes == 0
                ? Container()
                : LimitedBox(
                    maxHeight: 200.0,
                    child: Image.memory(_img.buffer.asUint8List())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final sign = _sign.currentState;
                sign?.clear();
                setState(() {
                  _img = ByteData(0);
                });
                debugPrint("cleared");
              },
              child: const Text('Clear'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final sign = _sign.currentState;
                //retrieve image data, do whatever you want with it (send to server, save locally...)
                final image = await sign?.getData();
                var data =
                    await image?.toByteData(format: ui.ImageByteFormat.png);
                sign?.clear();
                final encoded = base64.encode(data!.buffer.asUint8List());
                setState(() {
                  _img = data;
                });
                debugPrint("onPressed $encoded");
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

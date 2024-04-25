import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TorchScreen extends StatefulWidget {
  const TorchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TorchScreenState createState() => _TorchScreenState();
}

class _TorchScreenState extends State<TorchScreen> {
  late CameraController _controller;
  bool isTorchOn = false;

  late List<CameraDescription> cameras;

  getAvailableCameras() async {
    cameras = await availableCameras();
    availableCameras()
    .then((value) => {
      cameras = value,
      _controller = CameraController(cameras[0], ResolutionPreset.low),
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      })
    });
  }

  @override
  void initState() {
    super.initState();
    getAvailableCameras();
  }

  void toggleTorch() {
    setState(() {
      isTorchOn = !isTorchOn;
      _controller.setFlashMode(
        isTorchOn ? FlashMode.torch : FlashMode.off,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Torch App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.easeInOut,
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isTorchOn ? Colors.yellow : Colors.grey,
                ),
                child: Icon(
                  isTorchOn ? Icons.flash_on : Icons.flash_off,
                  size: 100.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: toggleTorch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isTorchOn ? Colors.red : Colors.green,
                ),
                child: Text(isTorchOn ? 'Turn Off' : 'Turn On'),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';


class ThreeDModelScreen extends StatefulWidget {
  const ThreeDModelScreen({super.key, required this.title});
  final String title;

  @override
  State<ThreeDModelScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ThreeDModelScreen> {

  Flutter3DController controller = Flutter3DController();
  String? chosenAnimation;
  String? chosenTexture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: (){
              controller.playAnimation();
            },
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: (){
              controller.pauseAnimation();
            },
            child: const Icon(Icons.pause),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: (){
              controller.resetAnimation();
            },
            child: const Icon(Icons.replay_circle_filled),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: ()async{
              List<String> availableAnimations = await controller.getAvailableAnimations();
              print('Animations : $availableAnimations -- Length : ${availableAnimations.length}' );
              chosenAnimation = await showPickerDialog(availableAnimations,chosenAnimation);
              controller.playAnimation(animationName: chosenAnimation);
            },
            child: const Icon(Icons.format_list_bulleted_outlined),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: ()async{
              List<String> availableTextures = await controller.getAvailableTextures();
              print('Textures : $availableTextures -- Length : ${availableTextures.length}' );
              chosenTexture = await showPickerDialog(availableTextures,chosenTexture);
              controller.setTexture(textureName: chosenTexture ?? '');
            },
            child: const Icon(Icons.list_alt_rounded),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: (){
              controller.setCameraOrbit(20, 20, 5);
              //controller.setCameraTarget(0.3, 0.2, 0.4);
            },
            child: const Icon(Icons.camera_alt),
          ),const SizedBox(height: 4,),
          FloatingActionButton.small(
            onPressed: (){
              controller.resetCameraOrbit();
              //controller.resetCameraTarget();
            },
            child: const Icon(Icons.cameraswitch_outlined),
          )
        ],
      ),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flutter3DViewer(
          controller: controller,
          src: 'assets/big_city_2.glb',
          //src: 'assets/sheen_chair.glb',
        ),
      ),
    );
  }

  Future<String?> showPickerDialog(List<String> inputList,[String? chosenItem])async{
    return await showModalBottomSheet<String>(context: context, builder: (ctx){
      return SizedBox(
        height: 250,
        child: ListView.separated(
          itemCount: inputList.length,
          padding: const EdgeInsets.only(top: 16),
          itemBuilder: (ctx,index){
            return InkWell(
              onTap: (){
                Navigator.pop(context,inputList[index]);
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${index+1}'),
                    Text(inputList[index]),
                    Icon(chosenItem == inputList[index] ? Icons.check_box : Icons.check_box_outline_blank)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx,index){
            return const Divider(color: Colors.grey,thickness: 0.6,indent: 10,endIndent: 10,);
          },
        ),
      );
    });
  }





}
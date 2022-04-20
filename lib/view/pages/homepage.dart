import 'dart:io';

import 'package:elevar/services/upscaler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final ImagePicker _picker = ImagePicker();
  File? image;
  late List? output;
  File? newImage;
  bool loading = false;

  pickImage() async {
    image = File(await _picker.pickImage(source: ImageSource.gallery).then((pickedImage) => pickedImage!.path));
    setState(() {});
  }

  upscaleImage() async {
    setState(() {
      loading = true;
    });
    Upscaler upscaler = Upscaler(image: image, modelPath: "esrgan.tflite");
    newImage = await upscaler.upscale();
    loading = false;
    setState(() {});
  }  //
  // upscaleImage() async {
  //   print('Upscale started');
  //   output = await Tflite.runModelOnImage(path: image!.path);
  //   print(output);
  // }
  //
  // loadModel() async {
  //   await Tflite.loadModel(model: 'assets/esrgan.tflite', useGpuDelegate: true);
  // }
  //
  // closeModel() async {
  //   await Tflite.close();
  // }
  //
  // @override
  // void initState() {
  //   loadModel();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   closeModel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null ? Container() : Image.file(image!, height: 200,),
            ElevatedButton(
                onPressed: () {
                    pickImage();
                },
                child: const Text('Pick Image')),
            ElevatedButton(
                onPressed: () {
                  upscaleImage();
                },
                child: const Text('Upscale Image')),
            // loading == true ? CircularProgressIndicator() : Image.file(newImage!, height: 200,),
            newImage == null ? Container() : Image.file(newImage!, height: 200,),


          ],
        ),
      ),
    );
  }
}

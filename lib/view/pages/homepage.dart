import 'dart:io';

import 'package:elevar/services/upscaler.dart';
import 'package:elevar/view/pages/preview_page.dart';
import 'package:elevar/view/widgets/big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  upscaleImage(BuildContext context) async {
    setState(() {
      loading = true;
    });
    Upscaler upscaler = Upscaler(image: image, modelPath: "model.tflite");
    newImage = await upscaler.upscale();
    loading = false;
    setState(() {});
    Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewPage(newImage: newImage!, oldImage: image!,)));
  }  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0282d34),
        elevation: 0,
        title: const Text('Elevar'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            showAboutDialog(context: context, children: [
              Text("Elevar uses Enhanced Super-Resolution Generative Adversarial Network (ESRGAN) to increase the resolution of images by 4 times.")
            ],
            );
          }, icon: Icon(CupertinoIcons.info))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image == null ? const Icon(Icons.photo, size: 50, color: Colors.white,) : Image.file(image!,),
                  const SizedBox(height: 30,),
                  BigButton(
                      label: 'Pick Image',
                      icon: CupertinoIcons.photo,
                    onTap: () {
                        pickImage();
                    },
                  ),
                  const SizedBox(height: 20,),
                  BigButton(
                      label: 'Upscale Image',
                      icon: Icons.arrow_circle_up_sharp,
                    onTap: () {
                        upscaleImage(context);
                    },
                  ),
              loading ? const CircularProgressIndicator.adaptive() : Container()

            ],
          ),
        ),
      ),
    );
  }
}

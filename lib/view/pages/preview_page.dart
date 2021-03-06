import 'package:elevar/services/alert.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';

import 'package:juxtapose/juxtapose.dart';

class PreviewPage extends StatelessWidget {
  final File newImage;
  final File oldImage;
  const PreviewPage({Key? key, required this.newImage, required this.oldImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0282d34),
        elevation: 0,
        title: const Text('Preview Image'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('New', style: TextStyle(fontSize: 18, color: Colors.white),),
                Text('Old', style: TextStyle(fontSize: 18, color: Colors.white),),
              ],
            ),
          ),
          Expanded(
            child: Center(
                child:
                Juxtapose(
                  backgroundWidget: Image.file(oldImage),
                  foregroundWidget: Image.file(newImage),
                  backgroundColor: const Color(0xff0282d34),)),
          ),
          InkWell(
            onTap: () {
              GallerySaver.saveImage(newImage.path, albumName: 'Elevar').then((value) => showAlert(context));
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF246CFE)
                ),
                child: const Text('Save Image', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            )
          )
        ],
      )
    );
  }
}

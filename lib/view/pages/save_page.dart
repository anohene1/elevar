import 'package:elevar/services/alert.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';

import 'package:juxtapose/juxtapose.dart';

class SavePage extends StatelessWidget {
  final File newImage;
  final File oldImage;
  const SavePage({Key? key, required this.newImage, required this.oldImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0282D34),
        elevation: 0,
        title: Text('Preview Image'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New', style: TextStyle(fontSize: 18, color: Colors.white),),
              Text('Old', style: TextStyle(fontSize: 18, color: Colors.white),),
            ],
          ),
          Expanded(
            child: Center(
                child:
                Juxtapose(
                  backgroundWidget: Image.file(oldImage),
                  foregroundWidget: Image.file(newImage),
                  backgroundColor: Color(0xff0282D34),)),
          ),
          InkWell(
            onTap: () {
              GallerySaver.saveImage(newImage.path, albumName: 'Elevar');
              showAlert(context);
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF246CFE)
                ),
                child: Text('Save Image', style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
            )
          )
        ],
      )
    );
  }
}

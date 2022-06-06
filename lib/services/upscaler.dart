import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as imagePackage;

class Upscaler {
  final String modelPath;
  final File? image;

  Upscaler({required this.modelPath, required this.image});


  Future upscale() async {
    TensorImage tensorImage = TensorImage.fromFile(image!);

    //Prepares to reshapes img buffer to [1,m,n,3]  
    TensorBuffer reShapeImgBuffer = TensorBuffer.createFrom(tensorImage.getTensorBuffer(), TfLiteType.float32);

    //Creates outputTensor as [1,m*2,n*2,3]
    TensorBuffer probabilityBuffer = TensorBuffer.createFixedSize([1, tensorImage.height.toInt() * 4, tensorImage.width.toInt() * 4, 3], TfLiteType.float32);

    //creates model interpreter
    Interpreter interpreter = await Interpreter.fromAsset(modelPath);

    //resize interpreter input to match [1,m*2,n*2,3]
    interpreter.resizeInputTensor(0, [1, tensorImage.height.toInt(), tensorImage.width.toInt(), 3]);

    //run model
    print('running model...');
    interpreter.run(reShapeImgBuffer.buffer, probabilityBuffer.buffer);
    //interpreter.
    interpreter.close();

    //prepares image from tensor
    SequentialProcessor<TensorBuffer> outputProcessor = TensorProcessorBuilder()
        .build();

    TensorBuffer outCasted = outputProcessor.process(probabilityBuffer);
    TensorImage output = TensorImage.fromTensorBuffer(outCasted);

    var imgPath = await getTemporaryDirectory();
    File twoXimage = new File('${imgPath.path}/resizedImg.png')..writeAsBytesSync(imagePackage.encodePng(output.image));
    print('done');
    return twoXimage;
  }
}
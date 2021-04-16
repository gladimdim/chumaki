import 'dart:typed_data';
import "dart:ui" as ui;
import 'package:async/async.dart';
import 'package:flutter/services.dart';

class ImageOnCanvas {
  final String imagePath;
  ui.Image? image;
  final AsyncMemoizer<ui.Image> _memoizer = AsyncMemoizer<ui.Image>();

  ImageOnCanvas(this.imagePath);

  Future asBytes() async {
    return _memoizer.runOnce(()  async{
      ByteData data = await rootBundle.load(imagePath);
      final Uint8List bytes = Uint8List.view(data.buffer);
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);

      image = (await codec.getNextFrame()).image;

      return Future.value(image);
    });
  }

  static WagonImage wagonImage = WagonImage();
}

class WagonImage extends ImageOnCanvas {
  WagonImage() : super("images/wagon/cart_64.png");
}
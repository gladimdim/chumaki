import 'package:flutter/material.dart';

class ResizedImage extends StatelessWidget {
  final String imagePath;
  final int? width;
  final int? height;
  final BoxFit? fit;
  const ResizedImage(this.imagePath, {Key? key, this.width, this.height, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: fit,
      image: ResizeImage(AssetImage(imagePath), width: width, height: height),
    );
  }
}

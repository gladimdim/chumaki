import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

int calledTimes = 0;

abstract class ShareTo {
  Future launch(String text) async {
    final canLaunchIt = await urlLauncher.canLaunch(getFullUrl(text));
    print("called times: ${calledTimes++}");
    if (canLaunchIt) {
      return urlLauncher.launch(getFullUrl(text));
    } else {
      return Future.value();
    }
  }

  String getFullUrl(String payload);
}

class TwitterShareTo extends ShareTo {
  @override
  String getFullUrl(String payload) {
    return "http://twitter.com/share?text=Я виконав ачівку '$payload'. В супер грі Чумаки! &url=https://locadeserta.com/locadesertachumaki";
  }
}

class FacebookShareTo extends ShareTo {
  @override
  String getFullUrl(String payload) {
    return "https://www.facebook.com/sharer/sharer.php?u=#https://locadeserta.com/locadesertachumaki&t=Я виконав ачівку '$payload'. В супер грі Чумаки!";
  }
}

class ShareImage {
  static String fileName = "share.png";

  static shareWidgetImageAtKey(GlobalKey key, String subject) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      Timer(Duration(seconds: 1),
          () => ShareImage.shareWidgetImageAtKey(key, subject));
      return;
    }
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final dir = (await getExternalStorageDirectory())!.path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File("$dir/$fileName");
    await imgFile.writeAsBytes(pngBytes);
    Share.shareFiles(
      ["$dir/$fileName"],
      mimeTypes: ["image/png"],
      subject: subject,
    );
  }
}

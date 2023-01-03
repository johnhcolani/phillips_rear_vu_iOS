import 'package:flutter/cupertino.dart';
import 'package:phillips_rear_vu/utils/app_background.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart' as webby;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'package:flutter/material.dart';


class WebviewCheck extends StatelessWidget {
  WebviewCheck({Key? key, required this.urls}) : super(key: key);

  String urls;

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    var widgets;

    if (Platform.isAndroid) {
      String newUrl = urls.substring(7);

      widgets = Scaffold(
          appBar: AppBar(
            title: Text(newUrl.toString()),
          ),
          body: Center(
              child: webby.WebView(
                initialUrl: Uri.encodeFull(newUrl),
                userAgent:
                "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17",
              )));
    }
    if (Platform.isIOS) {
      widgets = Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.darkBlue,
            title: Text(urls.toString()),
          ),
          body: Stack(
            children: [
              AppBackground(),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: he * 0.05,
                      left: wi * 0.05,
                      right: wi * 0.05,
                      bottom: 80),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(urls)),
                  ),
                ),
              ),
            ],
          ));
    }

    return widgets;
  }
}

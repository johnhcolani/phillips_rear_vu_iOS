import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:onboarding/onboarding.dart';
import 'package:phillips_rear_vu/utils/app_background.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart' as webby;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class WebviewCheck extends StatefulWidget {
  WebviewCheck({
    Key? key,
    required this.urls,
  }) : super(key: key);

  String urls;

  @override
  State<WebviewCheck> createState() => _WebviewCheckState();
}

class _WebviewCheckState extends State<WebviewCheck> {
  late InAppWebViewController webView;
  late final webby.WebViewController controller;
  double webProgress = 0;



  AssetImage _image = const AssetImage('assets/images/rearviewline6.png');
  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    var widgets;

    if (Platform.isAndroid) {
      String newUrl = widget.urls.substring(7);

      widgets = Scaffold(
          backgroundColor: AppColor.midBlue,
          appBar: AppBar(
            backgroundColor: AppColor.darkBlue,
            title: const Text(
              'Test_Camera_One',
              textAlign: TextAlign.center,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: FloatingActionButton(
              backgroundColor: Color(0xFFFFBF00),
              onPressed: () => {AppSettings.openWIFISettings()},
              shape: const StadiumBorder(
                  side: BorderSide(color: Colors.white, width: 0.5)),
              child: Icon(
                Icons.settings,
                color: AppColor.midBlue,
                size: 4.h,
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 1.h,
            shape: const CircularNotchedRectangle(),
            color: AppColor.darkBlue,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text('Make sure if you need Wifi for next time',
                      style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                    height: he * 0.8,
                    child: Expanded(
                      child: webby.WebView(
                        initialUrl: Uri.encodeFull(newUrl),
                        javascriptMode: JavascriptMode.unrestricted,

                        gestureNavigationEnabled: false,
                        userAgent:
                        "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17",

                        onWebViewCreated: (webby.WebViewController controller){

                        },
                        onProgress: (progress)=> setState(() {
                          this.webProgress =progress/100;
                        }),
                      ),

                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: webProgress < 1 ?  SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(
                    value: webProgress,
                    color: const Color(0xFFFFBF00),
                    backgroundColor: Colors.white,
                  ),
                ) : SizedBox(),
              ),
              // Center(
              //   child: Opacity(opacity: 0.6, child: Container(
              //     decoration: const BoxDecoration(
              //         image: DecorationImage(
              //             image:AssetImage("assets/images/rearviewspace.png"),
              //             fit: BoxFit.fill
              //         )
              //     ),
              //     height: 40.h,
              //     width: 100.h,
              //   ),),
              // ),
              // Column(
              //   children: [
              //     // ElevatedButton(onPressed: (){},
              //     //     child: Text('Screenshot')),
              //     Expanded(
              //       child: Padding(
              //         padding: EdgeInsets.only(top: 12.8.h),
              //         child: Image(image: _image),
              //       ),
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //               shape: RoundedRectangleBorder(
              //                   side: BorderSide(
              //                       width: 1, // thickness
              //                       color: AppColor.whiteBlue // color
              //                   ),
              //                   // border radius
              //                   borderRadius:
              //                   BorderRadius.circular(1.h)),
              //               primary: AppColor.buttonBlue),
              //           onPressed: () {
              //             setState(() {
              //               _image = AssetImage('assets/images/rearviewguidline.png');
              //             });
              //           },
              //           child: Padding(
              //             padding:  EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
              //             child: Text(
              //               '10.5"',
              //               style: TextStyle(
              //                 fontFamily: 'Lobster',
              //                 //fontStyle: FontStyle.italic,
              //                 color: Colors.white,
              //                 fontSize: 12.sp,
              //               ),
              //               textAlign: TextAlign.center,
              //             ),
              //           ),
              //
              //         ),
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //               shape: RoundedRectangleBorder(
              //                   side: BorderSide(
              //                       width: 1, // thickness
              //                       color: AppColor.whiteBlue // color
              //                   ),
              //                   // border radius
              //                   borderRadius:
              //                   BorderRadius.circular(1.h)),
              //               primary: AppColor.buttonBlue),
              //           onPressed: () {
              //             setState(() {
              //               _image = AssetImage('assets/images/rearviewguidline.png');
              //             });
              //           },
              //           child: Padding(
              //             padding:  EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
              //             child: Text(
              //               '12"',
              //               style: TextStyle(
              //                 fontFamily: 'Lobster',
              //                 //fontStyle: FontStyle.italic,
              //                 color: Colors.white,
              //                 fontSize: 12.sp,
              //               ),
              //               textAlign: TextAlign.center,
              //             ),
              //           ),
              //
              //         ),
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //               shape: RoundedRectangleBorder(
              //                   side: BorderSide(
              //                       width: 1, // thickness
              //                       color: AppColor.whiteBlue // color
              //                   ),
              //                   // border radius
              //                   borderRadius:
              //                   BorderRadius.circular(1.h)),
              //               primary: AppColor.buttonBlue),
              //           onPressed: () {
              //             setState(() {
              //               _image = const AssetImage('assets/images/rearviewguidline.png');
              //             });
              //           },
              //           child: Padding(
              //             padding:  EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
              //             child: Text(
              //               '13.6"',
              //               style: TextStyle(
              //                 fontFamily: 'Lobster',
              //                 //fontStyle: FontStyle.italic,
              //                 color: Colors.white,
              //                 fontSize: 12.sp,
              //               ),
              //               textAlign: TextAlign.center,
              //             ),
              //           ),
              //
              //         ),
              //
              //
              //
              //
              //       ],
              //     ),
              //     SizedBox(height: 50,)
              //   ],
              // ),
            ],
          ));
    }
    if (Platform.isIOS) {
      widgets = MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColor.midBlue,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppColor.darkBlue,
            title: Text('Test_Camera_One'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: FloatingActionButton(
              backgroundColor: Color(0xFFFFBF00),
              onPressed: () => {AppSettings.openWIFISettings()},
              shape: const StadiumBorder(
                  side: BorderSide(color: Colors.white, width: 0.5)),
              child: Icon(
                Icons.settings,
                color: AppColor.darkBlue,
                size: 4.h,
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 1.h,
            shape: const CircularNotchedRectangle(),
            color: AppColor.darkBlue,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text('Disconnect from the Camera',
                      style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              const AppBackground(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(widget.urls),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        transparentBackground: true,
                        supportZoom: true,
                      )),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      webProgress = progress / 100;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(
                    color:Color(0xFFFFBF00),
                    value: webProgress,
                    backgroundColor: Colors.lime.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }
}

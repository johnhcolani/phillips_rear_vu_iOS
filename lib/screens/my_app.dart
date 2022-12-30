import 'package:flutter/cupertino.dart';
import 'package:phillips_rear_vu/utils/app_background.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart' as webby;
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'Phillips RearVu');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}

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

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var canShowQRScanner = false;

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.midBlue,
      key: _scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: AppColor.darkBlue,
      //   title: Text(widget.title,style: TextStyle(
      //     fontSize: 32
      //   ),),
      // ),
      body: Stack(
        children: [
          const AppBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 32, color: AppColor.midBlueLight),
                ),
                SizedBox(
                  height: he * 0.05,
                ),
                Image.asset("assets/images/phillips_logo.png"),
                SizedBox(
                  height: he * 0.2,
                ),
                Image.asset("assets/images/splash_screen_camera.png",scale: 1.3),
                // SizedBox(
                //   height: he * 0.03,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: wi * 0.1, right: wi * 0.1),
                //   child: Text(
                //     'Please press the scanner button to get started.',
                //     style: TextStyle(color: AppColor.whiteBlue, fontSize: 20.0),
                //     textAlign: TextAlign.center,
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkBlue,
        onPressed: () => {
          setState(() {
            // getCameraPermission();
            // if(canShowQRScanner){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ScannerPage(),
              ),
            );
          }),
        },
        shape: StadiumBorder(side: BorderSide(color: AppColor.grey, width: 2)),
        child: const Icon(
          Icons.qr_code_2,
          size: 32,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        color: AppColor.darkBlue,
        child: Padding(
          padding: EdgeInsets.all(24.0),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void getCameraPermission() async {
    print(await Permission.camera.status); // prints PermissionStatus.granted
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() {
          canShowQRScanner = true;
        });
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //    const SnackBar(content: Text('Please enable camera to scan barcodes')));
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        canShowQRScanner = true;
      });
    }
  }
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    bool check = true;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Scanner'),
      ),
      backgroundColor: AppColor.midBlue,
      key: _scaffoldKey,
      body:Stack(
        children: [
          Column(
            children: <Widget>[

              Expanded(flex: 5, child: _buildQrView(context)),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      if (result != null)
                        Text("Code detected",
                            style: TextStyle(color: AppColor.whiteBlue))
                      else
                        Text(
                          'Scan the QR code on the device.',
                          style: TextStyle(color: AppColor.whiteBlue),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Container(
                          //   margin: const EdgeInsets.all(8),
                          //   child: ElevatedButton(
                          //     onPressed: () async {
                          //       await controller?.toggleFlash();
                          //       setState(() {});
                          //     },
                          //     child: FutureBuilder(
                          //       future: controller?.getFlashStatus(),
                          //       builder: (context, snapshot) {
                          //         return Text('Flash: ${snapshot.data}');
                          //       },
                          //     ),
                          //   ),
                          // ),
                          if (result != null)
                            Container(
                              margin: const EdgeInsets.only(
                                right: 8,
                                left: 8,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2, // thickness
                                            color: AppColor.whiteBlue // color
                                        ),
                                        // border radius
                                        borderRadius: BorderRadius.circular(8)),
                                    primary: AppColor.buttonBlue),
                                onPressed: () async {
                                  showConnectionDialog(context, result!);
                                },
                                child: FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    return const Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      child: Text('Continue'),
                                    );
                                  },
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 20.0,
                          ),

                          Center(
                            child: FloatingActionButton.small(

                              backgroundColor: AppColor.grey,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/images/flash_light.png"),
                              ),
                              shape: StadiumBorder(side: BorderSide(color: AppColor.whiteBlue, width: 1)),
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {


                                });
                              },
                            ),

                          ),
                        ],
                      ),
                      Container(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(left: wi*0.1,right: wi*0.1,top: he*0.62),
           child: Text(
              "The QR code will be detected automatically when it's positioned within the guide lines.",
              style: TextStyle(color: AppColor.whiteBlue),
             textAlign: TextAlign.center,
            ),)
        ],
      )
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ? 250.0 : 250.0);
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColor.lightBlue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyHomePage(
          title: "Untitled Philips App",
        ),
      ));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: const Text("Connection was not successful."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showConnectionDialog(BuildContext context, Barcode result) {
  Map<String, dynamic> map = jsonDecode(result.code.toString());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Network Discovered'),
        content: Text("Please change your wifi network to " +
            map['ssid'].toString().trim() +
            " in order to access this camera. If already connection, select open camera"),
        actions: <Widget>[
          TextButton(
            child: const Text("Open Settings"),
            onPressed: () {
              if (Platform.isIOS) {
                AppSettings.openWIFISettings();
              } else {
                AppSettings.openWIFISettings();
              }
              connection(context, map);
               Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Open Camera"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebviewCheck(urls: map['url'].toString().trim()),
              ));
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              // showUrlDialog(context, map);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

showUrlDialog(BuildContext context, Map map) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Stream Page Ready'),
        content: Text(
            "Would you like to connect to " + map['url'].toString().trim()),
        actions: <Widget>[
          TextButton(
            child: const Text("YES"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebviewCheck(urls: map['url'].toString().trim()),
              ));
            },
          ),
          TextButton(
            child: const Text("NO"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> connection(BuildContext context, Map map) async {
  print("Connection starter");

  Future.delayed(const Duration(seconds: 0), () {
    // WifiConnector.connectToWifi(ssid: map['ssid'].toString().trim());
    print("Connector Started");
  });

  Future.delayed(const Duration(seconds: 10), () {
    NetworkInfo().getWifiName();
    print("getCurrent Started");
  });

  Future.delayed(const Duration(seconds: 15), () {
    print("Show Dialog Started");
    // current.then((data) {
    //   if (data == map["ssid"].toString().trim()){
    //   showUrlDialog(context, map);
    // }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebviewCheck(urls: map['url'].toString().trim()),
    ));
    // else{
    // showAlertDialog(context);
    // }
    // });
  });
}

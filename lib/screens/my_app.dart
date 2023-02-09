import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:phillips_rear_vu/screens/on_boarding.dart';
import 'package:phillips_rear_vu/screens/scanner_page.dart';
import 'package:phillips_rear_vu/screens/web_view_check.dart';

import 'package:phillips_rear_vu/utils/app_background.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      title: 'Phillips RearVu',
      scannedData: '',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.scannedData,
  }) : super(key: key);
  MyHomePage.Scanned(this.scannedData, this.title);
  final String title;
  final String scannedData;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "";
  String? result;

  MobileScannerController cameraController = MobileScannerController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const colorizeColors = [
    Colors.white,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 20.sp,
    fontFamily: 'Horizon',
  );
  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.midBlue,
      key: _scaffoldKey,

      body: Stack(
        children: [
          const AppBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: he * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/phillips_logo.png"),
                          fit: BoxFit.fill)),
                  height: 8.h,
                  width: 36.h,
                ),
                SizedBox(
                  height: he * 0.02,
                ),
                Text(
                  ' Rear-VU',
                  style: TextStyle(
                      fontFamily: 'Trade_Gothic',
                      //fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 4.h),
                ),
                SizedBox(
                  height: he * 0.05,
                ),
                Container(
                  width: wi * 0.32,
                  height: wi * 0.32,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(wi * 0.06)),
                  child: Image.asset(
                    "assets/images/splash_screen_camera.png",
                    scale: wi * 0.0006,
                  ),
                ),
                SizedBox(
                  height: he * 0.15,
                ),
                Center(
                  child: SizedBox(

                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'Product',
                          textStyle: colorizeTextStyle,
                          colors: colorizeColors,
                        ),

                        ColorizeAnimatedText(
                          'Information',
                          textStyle: colorizeTextStyle,
                          colors: colorizeColors,
                        ),
                      ],
                      isRepeatingAnimation: true,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => OnBoarding()));
                      },
                    ),
                  ),
                ),
                //  ElevatedButton(
                //    style: ElevatedButton.styleFrom(
                //        shape: RoundedRectangleBorder(
                //            side: BorderSide(
                //                width: 1, // thickness
                //                color: AppColor.whiteBlue // color
                //                ),
                //            // border radius
                //            borderRadius: BorderRadius.circular(wi * 0.02)),
                //        primary: Colors.transparent),
                //    onPressed: () {
                //      Navigator.of(context).pushReplacement(
                //          MaterialPageRoute(builder: (context) => OnBoarding()));
                //    },
                //    child: Padding(
                //      padding: const EdgeInsets.all(8.0),
                //      child: Text(
                //        'PRODUCT INFORMATION',
                //        style: TextStyle(
                //          fontFamily: 'Trade_Gothic',
                //          //fontStyle: FontStyle.italic,
                //          color: Colors.white,
                //          fontSize: 2.3.h,
                //        ),
                //        textAlign: TextAlign.center,
                //      ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: FloatingActionButton(
          backgroundColor: Color(0xFFFFBF00),
          onPressed: () => {
            cameraController.switchCamera(),
            setState(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScannerPage(),
                ),
              );
            }),
          },
          shape:
          StadiumBorder(side: BorderSide(color: Colors.white, width: 0.5)),
          child: Icon(
            Icons.qr_code_2,
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
            // IconButton(icon: Icon(Icons.info_outline,color: Colors.white,), onPressed: () {
            //   Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => WifiPage()));
            // },),

            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void getCameraPermission(BuildContext context) async {
    print(await Permission.camera.status); // prints PermissionStatus.granted
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() {});
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //    const SnackBar(content: Text('Please enable camera to scan barcodes')));
        Navigator.of(context).pop();
      }
    } else {
      setState(() {});
    }
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(
          title: "Untitled Philips App",
          scannedData: '',
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

showConnectionDialog(BuildContext context, String result) {
  Map<String, dynamic> map = jsonDecode(result.toString());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Platform.isAndroid
          ? AlertDialog(
        title: const Text('Network Discovered'),
        content: Text("Please change your wifi network to "
            "${map['ssid'].toString().trim()} in order to access this camera. "
            "If already connection, select open camera"),
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
              var newResult = map['url'].toString().trim();

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebviewCheck(urls: map['url'].toString().trim()),
              ));
              debugPrint('This is my URL ${newResult}');
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
      )
          : CupertinoAlertDialog(
        title: const Text('Network Discovered'),
        content: Text("Please change your wifi network to " +
            map['ssid'].toString().trim() +
            " in order to access this camera. If already connection, select open camera"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Open Settings"),
            onPressed: () {
              AppSettings.openWIFISettings();

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
            "Would you like to connect to ${map['url'].toString().trim()}"),
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

Future<void> checkConnectivity(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Please Connect to Wi-Fi'),
        content: Text(
            'This app requires a Wi-Fi connection to display the web view properly. Please connect to Wi-Fi.'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
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

class ScannerHasData extends StatelessWidget {
  Map map;
  ScannerHasData({Key? key, required this.map}) : super(key: key);

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
        allowDuplicates: false,
        controller: cameraController,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            MaterialPageRoute(
              builder: (context) => const ScannerPage(),
            );
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  WebviewCheck(urls: map['url'].toString().trim()),
            ));
          }
        });
  }
}

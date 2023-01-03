import 'package:flutter/cupertino.dart';
import 'package:phillips_rear_vu/screens/scanner_page.dart';
import 'package:phillips_rear_vu/screens/web_view_check.dart';
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

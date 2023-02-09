import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phillips_rear_vu/data/data_manager.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_app.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? result;
  String? scannedData ;
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  // Function to load the saved value from SharedPreferences
  @override
  void initState() {
    cameraController;
    print('PRINTING RESULT DATA1 $result');
    print('PRINTING SCANNEDDATA1  $scannedData');

    _loadScannedData();


    super.initState();
  }


  Future<void> _loadScannedData() async {
    final dataManager = DataManager();
    final data = await dataManager.getData();
    print('Loaded data from scanner page is: $data');
    setState(() {
      scannedData = data;

    });
  }

  Future<void> _savedScannedData(String data) async {
    final dataManager = DataManager();
    await dataManager.saveData(data);
    print('Scanned Data from Scanner Page is: $data');
    setState(() {
      scannedData = data;

    });
  }



  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Scanner'),
      ),
      backgroundColor: AppColor.midBlue,
      key: _scaffoldKey,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(flex: 5, child: mLScannerView(context)),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      if (
                      result != null
                      //    &&
                      // scannedData!=null
                      )
                        Text(" Code detected  ",
                            style: TextStyle(
                                color: AppColor.whiteBlue, fontSize: 18))
                      else
                        Text(
                          'Scan the QR code on the device.',
                          style: TextStyle(color: AppColor.whiteBlue),
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (
                          result != null
                          //    &&
                          // scannedData!=null
                          )
                            Container(
                              margin: const EdgeInsets.only(
                                right: 8,
                                left: 8,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, // thickness
                                            color: AppColor.whiteBlue // color
                                        ),
                                        // border radius
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    primary: AppColor.buttonBlue),
                                onPressed: () async {
                                  showConnectionDialog(
                                      context,
                                      //scannedData!
                                      result!
                                  );
                                },
                                child: FutureBuilder(
                                  future: null,
                                  builder: (context, snapshot) {
                                    return const Padding(
                                      padding:
                                      EdgeInsets.only(left: 20, right: 20),
                                      child: Text('Continue'),
                                    );
                                  },
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Center(
                            child: IconButton(
                              color: Colors.white,
                              icon: ValueListenableBuilder(
                                valueListenable: cameraController.torchState,
                                builder: (context, state, child) {
                                  switch (state) {
                                    case TorchState.off:
                                      return Tab(
                                        icon: Container(
                                            height: he * 0.1,
                                            width: he * 0.1,
                                            decoration: BoxDecoration(
                                                color: AppColor.darkGrey,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(6.0),
                                              child: Image.asset(
                                                  "assets/images/flash_light.png"),
                                            )),
                                      );
                                    case TorchState.on:
                                      return Tab(
                                        icon: Container(
                                            height: he * 0.1,
                                            width: he * 0.1,
                                            decoration: BoxDecoration(
                                                color: AppColor.whiteBlue,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(2.0),
                                              child: Image.asset(
                                                  "assets/images/flash_light_on.png"),
                                            )),
                                      );
                                  }
                                },
                              ),
                              iconSize: 32.0,
                              onPressed: () => cameraController.toggleTorch(),
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
          Padding(
            padding:
            EdgeInsets.only(left: wi * 0.1, right: wi * 0.1, top: he * 0.6),
            child: Text(
              "The QR code will be detected automatically when it's positioned within the guide lines.",
              style: TextStyle(
                  color: AppColor.whiteBlue,
                  fontSize: wi > 384 ? wi * 0.03 : wi * 0.05),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: wi * 0.1, right: wi * 0.1, top: he * 0.72),
            child: Divider(
              thickness: 0.5,
              color: AppColor.lightBlue,
            ),
          )
        ],
      ),
    );
  }

  Widget mLScannerView(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: he * 0.01, bottom: he * 0.2),
          child: MobileScanner(

              allowDuplicates: true,

              controller: cameraController,

              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to find barcode")));
                } else {
                  final String code = barcode.rawValue!;
                  //SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
                  //prefs.setString("saved_value", code);


                  debugPrint('Barcode found! $code');
                  setState(() {

                    _savedScannedData(scannedData!);

                    result = barcode.rawValue.toString();

                  });

                }
              }),
        ),

        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: he * 0.19),
            child: Container(
              height: wi * 0.5,
              width: wi * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(wi * 0.03),
                border: Border.all(width: he * 0.006, color: Color(0xFF8CCDE5)),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: he * 0.19),
            child: Container(
              height: wi * 0.55,
              width: wi * 0.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(wi * 0.03),
                border:
                Border.all(width: he * 0.0007, color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: he * 0.19),
            child: Container(
              height: wi * 0.6,
              width: wi * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(wi * 0.05),
                border: Border.all(width: he * 0.01, color: Color(0x308CCDE5)),
              ),
            ),
          ),
        ),
      ],
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
  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }
}

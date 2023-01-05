import 'package:flutter/cupertino.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'my_app.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}
class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  bool isFlashOn = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  
  setState(() {


  });}

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
                        const SizedBox(
                          height: 16,
                        ),
                        if (result != null)
                          Text("😀 Code detected 😀",
                              style: TextStyle(color: AppColor.whiteBlue))
                        else
                          Text(
                            'Scan the QR code on the device.',
                            style: TextStyle(color: AppColor.whiteBlue),
                          ),
                        SizedBox(
                          height: he*0.02,
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
                            const SizedBox(
                              width: 20.0,
                            ),

                            Center(
                              child: FloatingActionButton.small(

                                backgroundColor: isFlashOn ? AppColor.whiteBlue :AppColor.darkGrey,
                                shape: StadiumBorder(side: BorderSide(color: AppColor.whiteBlue, width: 1)),
                                onPressed: () async {
                                  await controller?.toggleFlash();
                                  setState(() {
isFlashOn = !isFlashOn;

                                  });
                                },
                                child: !isFlashOn
                                    ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("assets/images/flash_light.png"),
                                    )
                                    : Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset("assets/images/flash_light_on.png"),
                                    )
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
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:phillips_rear_vu/utils/paddind.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import 'my_app.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  //double he = MediaQuery.of(context).size.height;
  //double wi = MediaQuery.of(context).size.width;
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color:const Color(0xFF002f6c),
          border: Border.all(
            width: 0.0,
            color:const Color(0xFF002f6c),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: AppPaddingH.p4,
                  vertical: AppPaddingV.p6,
                ),
                child: Image.asset("assets/images/ads_pics/Ads2.png"),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4,vertical: AppPaddingV.p1),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SECURED BACKUP CAMERA',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Offers increased backup visibility and safety for drivers and pedestrians:',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: Color(0xff05ed0f),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Creates a new level of situational awareness for increased yard safety.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '180 degree view allows for visibility of rear bumpers, doors and over 20 feet behind the trailer.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Allows driver to see docking position and alignment to make maneuvering in reverse easier and prevent trailer damage from hard hits.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Protects trailer owner\'s assets:',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: Color(0xff05ed0f),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Increased visibility decreases accidental damage during backup, avoiding costly repairs and downtime.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Added functionality when paired with a Phillips Connect Bluetooth Device:',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: Color(0xff05ed0f),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Still image uploads to cloud storage when impact or other extreme events are detected.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Functional/Diagnostic information provided to telematics to ensure proper operation and monitor driver usage.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color:const Color(0xFF002f6c),
          border: Border.all(
            width: 0.0,
            color:const Color(0xFF002f6c),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: AppPaddingH.p4,
                  vertical: AppPaddingV.p6,
                ),
                child: Image.asset("assets/images/ads_pics/Ads1.png"),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4,vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'INSTALLATION:',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s16),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Camera is installed at the top rear center of the trailer.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Internal battery charged from center marker light circuit when trailer lights are on.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lights in front face of camera replace the marker light used for power, works on standard and offset door configurations.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Program the camera with the trailer number using the free Android or iOS application and apply the unique QR code decal to the front of the trailer nose for simple identification later.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Free software development kit allows an ELD provider with WiFi capability to integrate the Phillips Rear-Vu backup camera application to their system without any licensing agreements.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              SizedBox(height: 15.h,),

            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color:const Color(0xFF002f6c),
          border: Border.all(
            width: 0.0,
            color:const Color(0xFF002f6c),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: AppPaddingH.p4,
                  vertical: AppPaddingV.p6,
                ),
                child:Platform.isAndroid
                    ? Image.asset("assets/images/ads_pics/Android_ads.png")
                    :  Image.asset("assets/images/ads_pics/ios_ads.png"),

              ),

              const SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Free IOS or Android application works on any smart device:',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s16),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Access to streaming backup camera video for ANY truck driver, regardless of company affiliation.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),




              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingH.p4, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Adaptive algorithm provides list of available cameras to sync to in most likely order to allow driver to easily find the correct camera when there are many nearby.',
                    style: TextStyle(fontFamily: 'Trade_Gothic',color: const Color(0xffdcf1dd),fontSize: AppFontSize.s10),

                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyAppView()));
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Return',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color:const Color(0xFF002f6c),
                border: Border.all(
                  width: 0.0,
                  color:const Color(0xff031336),
                ),
              ),
              child: ColoredBox(
                color:const Color(0xff031336),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.line(
                            lineDesign: LineDesign(
                              lineSpacer: 10,
                              lineType: DesignType.line_uniform,
                              lineWidth: 50,
                            ),
                          ),
                        ),
                      ),
                      _skipButton()
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

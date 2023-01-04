import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phillips_rear_vu/utils/app_background.dart';
import 'my_app.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController oneSecondController;
  late Animation<Offset> movingLogoAnimation;
  Timer? _timer;
  _startDelay(){
    _timer=Timer(const Duration(seconds: 2),_goNext);
  }
  _goNext(){
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=> const MyAppView()));
    // '/MyApp'; (context) => const MyApp();
  }
  @override
  void initState() {
    oneSecondController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    movingLogoAnimation = Tween(begin: const Offset(0, 0.05), end: const Offset(0, 0.3)).animate(
        oneSecondController.drive(CurveTween(curve: Curves.elasticIn)));

    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    _timer?.cancel();
    oneSecondController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return  Scaffold(

        body: Stack(
            children: <Widget>[
              const AppBackground(),

              Center(
                child: SlideTransition(
                  position: movingLogoAnimation,
                  child: Padding(
                    padding:  EdgeInsets.only(top: he * 0.4),
                    child: Center(
                      child: Column(
                      children: [
                        Image.asset("assets/images/phillips_logo.png",scale: 1.2,),
                         SizedBox(
                          height: he*0.06,
                        ),
                        Container(
                          width: wi*0.29,
                          height: wi*0.29,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2,
                                color: Colors.white,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Image.asset("assets/images/splash_screen_camera.png",scale: 1.5,),
                        )
                      ],
                      ),
                    ),
                  ),),
              ),



            ]));
  }
  }




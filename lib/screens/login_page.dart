import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phillips_rear_vu/screens/my_app.dart';

import 'package:phillips_rear_vu/utils/app_background.dart';
import 'package:phillips_rear_vu/utils/app_color.dart';
import 'package:sizer/sizer.dart';
import '../utils/constant.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Stack(children: [
      AppBackground(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: wi*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _passwordController,
                  style:  TextStyle(fontSize:16.sp,color: Colors.white),
                  obscureText: _obscureText,
                  maxLength: 4,
                  cursorHeight: 5.h,
                  cursorColor: AppColor.lightBlue,
                  textAlign: TextAlign.center,


                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                  counterStyle: TextStyle(color: Colors.lightBlueAccent),
                    hintText: 'Enter your password',
                    hintStyle:
                    TextStyle(fontSize: 11.sp,color: AppColor.lightBlue.withOpacity(0.2)),
                    labelText: 'Password * ',
                    labelStyle:
                    TextStyle(fontSize: 11.sp,color: AppColor.lightBlue.withOpacity(0.5)),

                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;

                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        )),


                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, // thickness
                            color: AppColor.whiteBlue // color
                        ),
                        // border radius
                        borderRadius:
                        BorderRadius.circular(wi*0.01)),
                    primary: AppColor.buttonBlue),
                onPressed: () {
                  if (_passwordController.text == '1022') {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyAppView(),
                      ),
                    );
                  } else {
                    showToast2(

                    );
                  }
                },
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 3.h,vertical: 1.h),
                  child: Text(
                    'Submit',
                    style: TextStyle(

                      //fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              ),

            ],
          ),
        ),
      ),
    ]);
  }
}
void showToast2() {
  Fluttertoast.showToast(
      msg:
      'Invalid password, Try again please!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.blue[800],
      textColor: Colors.white);
}
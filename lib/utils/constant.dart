
import 'package:flutter/Material.dart';

const kTextFieldDecoration = InputDecoration(

  hintText: 'Enter a value',hintStyle:TextStyle(fontSize: 20.0) ,

  contentPadding:
  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 1,color: Colors.orange),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 2,color: Colors.orangeAccent)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),


);
import 'package:exam/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main(){
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => Home_Screen(),

        },
      )
  );
}
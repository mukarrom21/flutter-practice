import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/app.dart';
import 'package:getx_demo/counter_controller.dart';

void main(){
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      home: const HomePage(),
    );
  }
}


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}
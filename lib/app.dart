import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'counter_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<CounterController>(builder: (counter) {
          return Text('${counter.counter}');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<CounterController>().increment();
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

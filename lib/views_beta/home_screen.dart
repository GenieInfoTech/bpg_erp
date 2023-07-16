import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0096b5),
        title: const Text(
          'Dashboard Activity',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/sky.png",
            fit: BoxFit.cover,
          ),
          Image.asset("assets/images/leaves.png"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  height: 180,
                  width: 180,
                  widget: Text('asd'),
                  navigation: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  height: 180,
                  width: 180,
                  widget: Text('sdf'),
                  navigation: null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

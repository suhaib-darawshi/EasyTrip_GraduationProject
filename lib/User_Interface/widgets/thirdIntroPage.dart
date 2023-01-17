import 'package:flutter/material.dart';

class ThirdIntroPage extends StatelessWidget {
  const ThirdIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/imgs/gpay.png'),
        Text(
          'An easy and secure way to pay by your google account',
          style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
        )
      ],
    );
  }
}

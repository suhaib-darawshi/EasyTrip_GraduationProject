import 'package:flutter/material.dart';

class SecondIntroPage extends StatelessWidget {
  const SecondIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/imgs/flight.jpg'),
        Text(
          'Here you can search and book trips from companies from your home',
          style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
        ),
        
      ],
    );
  }
}

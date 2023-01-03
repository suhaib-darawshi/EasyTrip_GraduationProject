import 'package:demo/provider/CompanyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CPersonalPage extends StatelessWidget {
  const CPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context,provider,c) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(),
        );
      }
    );
  }
}
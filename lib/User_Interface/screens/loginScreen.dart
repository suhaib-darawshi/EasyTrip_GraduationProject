import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rive/rive.dart';

import '../../date_repo/enum.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtboard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String testEmail = "mohamed.hassan@gmail.com";
  String testPassword = "123456";
  final passwordFocusNode = FocusNode();

  bool isLookingLeft = false;
  bool isLookingRight = false;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerIdle);
    debugPrint("idleee");
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsUp);
    debugPrint("hands up");
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsDown);
    debugPrint("hands down");
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerSuccess);
    debugPrint("Success");
  }

  void addFailController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerFail);
    debugPrint("Faillll");
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtboard?.artboard.addController(controllerLookRight);
    debugPrint("Righttt");
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerLookLeft);
    debugPrint("Leftttttt");
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    rootBundle.load('assets/animation/animated_login_screen.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      setState(() {
        riveArtboard = artboard;
      });
    });

    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addSuccessController();
      } else {
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text(
          ' Login page',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: riveArtboard == null
                    ? const SizedBox.shrink()
                    : Rive(
                        artboard: riveArtboard!,
                      ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: 700.w,
                      height: 100.h,
                      child: Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            filled: true,
                            fillColor: Colors.blue.shade300,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue.shade300),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          validator: (value) =>
                              value != testEmail ? "Wrong email" : null,
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                value.length < 16 &&
                                !isLookingLeft) {
                              addLookLeftController();
                            } else if (value.isNotEmpty &&
                                value.length > 16 &&
                                !isLookingRight) {
                              addLookRightController();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Container(
                      width: 700.w,
                      height: 100.h,
                      child: Expanded(
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.blue.shade300,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue.shade300),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          focusNode: passwordFocusNode,
                          validator: (value) =>
                              value != testPassword ? "Wrong password" : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Container(
                      width: 700.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 8,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.blue.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          passwordFocusNode.unfocus();

                          validateEmailAndPassword();
                        },
                        child: Opacity(
                          opacity: 0.5,
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

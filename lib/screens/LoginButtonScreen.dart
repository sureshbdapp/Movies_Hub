import 'package:flutter/material.dart';
import 'package:pixeltrue/screens/Dashboard.dart';
import 'package:pixeltrue/screens/LoginScreen.dart';
import 'package:pixeltrue/utils/Constant.dart';

class LoginButtonScreen extends StatefulWidget {
  const LoginButtonScreen({super.key});

  @override
  State<LoginButtonScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginButtonScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(
      begin: 0,
      end: 2 * 3.141,
    ).animate(_controller);
    _controller.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login_bg.jpeg"),
                    fit: BoxFit.fitHeight)),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.blue;
                        }
                        return Colors.red;
                      })),
                  onPressed: () {
                    // Navigator.of(context).push(createRoute(Dashboard()));
                    navigation(context, const Dashboard());
                  },
                  child: const Text(
                    'GUEST LOGIN',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blue;
                      }
                      return Colors.red;
                    }),
                    textStyle: MaterialStateProperty.resolveWith((states) {
                      // If the button is pressed, return size 40, otherwise 20
                      if (states.contains(MaterialState.pressed)) {
                        return TextStyle(fontSize: 40);
                      }
                      return TextStyle(fontSize: 20);
                    }),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(createRoute(LoginScreen()));
                    //  navigation(context, const Dashboard());
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
            ],
          )),
        ]));
  }
}

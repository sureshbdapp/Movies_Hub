import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixeltrue/api/ApiClient.dart';
import 'package:pixeltrue/screens/Dashboard.dart';
import 'package:pixeltrue/utils/Constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 100,
                    child: Image.asset('assets/images/netflix_logo.png')),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: usernameController,
                style: TextStyle(fontSize: 14, color: Colors.white),
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Phone number, email or username',
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter here...',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                style: TextStyle(fontSize: 14, color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter secure password',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 65,
              width: 360,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: ElevatedButton(
                    child: const Text(
                      'Log in ',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      _submitForm(context);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot your login details? ',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  InkWell(
                      onTap: () {},
                      child: const Text(
                        'Get help logging in.',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                    onTap: () {},
                    child: const Text(
                      'Use Credential For Login :-\nUserName - hbingley1\nPassword - CQutx25i8r',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    Map<String, String> map = {
      "username": usernameController.text.toString(),
      "password": passwordController.text.toString()
    };

    Map<String, dynamic> response = await ApiClient.loginApi(map);
    if (usernameController.text.toString().isNotEmpty &&
        passwordController.text.toString().isNotEmpty) {
      if (response["username"] != null &&
          (!response["username"].toString().contains("null"))) {
        if (kDebugMode) {
          print(response);
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Successfully")));
        navigation(context, Dashboard());
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid Credential")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid Credential")));
    }
  }
}

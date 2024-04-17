import 'package:flutter/material.dart';
import 'package:pixeltrue/api/ApiClient.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Map<String, String> _formData = {};
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
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: usernameController,
                style: TextStyle(fontSize: 14, color: Colors.white),
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                      _submitForm();
                      ApiClient.loginApi(_formData);
                      print(ApiClient.loginApi(_formData));
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Center(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text('Forgot your login details? ',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                        onTap: () {},
                        child: const Text(
                          'Get help logging in.',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    final username = usernameController.text;
    final password = passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _formData = {
          'username': username,
          'password': password,
        };
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter username and password'),
      ));
    }
  }
}

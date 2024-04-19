import 'package:flutter/material.dart';
import 'package:pixeltrue/screens/LoginScreen.dart';
import '../screens/Dashboard.dart';
import 'Constant.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        children: <Widget>[
          SizedBox(
            height: 120,
            width: 20,
            child: DrawerHeader(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue;
                    }
                    return Colors.red;
                  }),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 12);
                    }
                    return TextStyle(fontSize: 15);
                  }),
                ),
                onPressed: () {
                  Navigator.of(context).push(createRoute(LoginScreen()));
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ),

          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Welcome'),
          //   onTap: () => {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Profile'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.border_color),
          //   title: Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
        ],
      ),
    );
  }
}

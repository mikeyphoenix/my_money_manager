import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:my_money_manager/page/homepage/homepage.dart';
/*import 'package:firebase_auth/src/auth_provider/facebook_auth_provider.dart';*/


class FacebookLoginPage extends StatefulWidget {

  @override
  State createState() => FacebookLoginPageState();
}


class FacebookLoginPageState extends State<FacebookLoginPage> {

  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Facebook Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text("You are not currently signed in."),
              RaisedButton(
                child: const Text('SIGN IN'),
                onPressed: () {
                  _facebookLogin.logInWithReadPermissions(['email', 'public_profile']).then((result) {
                    switch(result.status) {
                      case FacebookLoginStatus.loggedIn:
                        AuthCredential authCredentials = FacebookAuthProvider.getCredential( accessToken: result.accessToken.token);
                        _auth.signInWithCredential(authCredentials).then((signedInUser){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Logged in ${signedInUser.displayName}",)));
                        }).catchError((error) {
                          print(error);
                        });
                    }
                  }).catchError((error) {
                    print(error);
                  });
                },
              ),
            ],
          ),
        ));
  }
}


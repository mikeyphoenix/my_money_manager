import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class FacebookLoginPage extends StatefulWidget {

  @override
  State createState() => FacebookLoginPageState();
}


class FacebookLoginPageState extends State<FacebookLoginPage> {

  FacebookLogin _facebookLogin = FacebookLogin();

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
                        FirebaseAuth.instance.signInWithCustomToken(
                            token: result.accessToken.token
                        ).then((signedInUser) {
                          print('Signed in as ${signedInUser.displayName}');
                        }).catchError((error){
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


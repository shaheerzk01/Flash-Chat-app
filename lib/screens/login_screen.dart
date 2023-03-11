import 'package:flutter/material.dart';
import 'package:flashchat/components/round_button.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  bool wrongEmail = false;
  bool wrongPassword = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextfeildDecoration.copyWith(
                    hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextfeildDecoration.copyWith(
                    hintText: 'Enter your password')),
            RoundButton(
              btittle: 'Log in',
              color: Colors.lightBlueAccent,
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  setState(() {
                    wrongEmail = false;
                    wrongPassword = false;
                  });
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                  if (e.code == 'ERROR_WRONG_PASSWORD') {
                    setState(
                      () {
                        wrongPassword = true;
                        showSpinner = false;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                  child: Text(
                                "Alert!!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              content: Text(
                                "Wrong password/email try again",
                                style: TextStyle(color: Colors.red.shade300),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showSpinner = false;
                                    wrongPassword = false;
                                    wrongEmail = false;
                                  },
                                ),
                              ],
                            );
                            setState(() {
                              wrongEmail = false;
                              wrongPassword = false;
                            });
                          },
                        );
                      },
                    );
                  } else {
                    setState(() {
                      email = 'User doesn\'t exist';
                      password = 'Please check your email';

                      wrongPassword = true;
                      wrongEmail = true;
                      showSpinner = false;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  "Alert!!",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              content: Text(
                                "Wrong password/email try again",
                                style: TextStyle(color: Colors.red.shade300),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showSpinner = false;
                                    wrongPassword = false;
                                    wrongEmail = false;
                                  },
                                ),
                              ],
                            );
                            setState(() {
                              wrongPassword  = false;
                              wrongEmail = false;
                            });
                          });
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}

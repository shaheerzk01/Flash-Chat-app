import 'package:flutter/material.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat/components/round_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id =
      'welcome_screen'; //static is a class wide variable and in order to access it we don't need to create an object of the class.
  //when we want to create a const value of class it has to be static otherwise it does not make any sense like for circle class value of pi is const so it must be with static variable.
  //methods of class can also become static.

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //Mixins are the way of reusing a class code in multiple class hierarchies means if we want to inherit from two class dart wont allow it so create mixins which can be inherited multiple in same classes

  late AnimationController controller;
  late Animation animation;
  late Animation kanimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    kanimation = ColorTween(begin: Colors.white).animate(controller);

    controller
        .forward(); //if we want to reverse the animation use .reverse(from: 1.0)

    // this is for the animation to go forward and reverse continously
    // animation.addStatusListener((status) {
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from: 1.0);
    //   }else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kanimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 80,
                  ),
                ),
                AnimatedTextKit(
                  pause: Duration(milliseconds: 500),
                  animatedTexts: [
                    FlickerAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFf9c954)),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  totalRepeatCount: 1000,
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              color: Colors.lightBlueAccent,
              btittle: 'Log in',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(
              color: Colors.blueAccent,
              btittle: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

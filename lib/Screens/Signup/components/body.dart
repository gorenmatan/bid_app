import 'package:flutter/material.dart';
import 'package:flutterbidapp/Screens/Login/login_screen.dart';
import 'package:flutterbidapp/Screens/Signup/components/background.dart';
import 'package:flutterbidapp/Screens/Signup/components/or_divider.dart';
import 'package:flutterbidapp/Screens/Signup/components/social_icon.dart';
import 'package:flutterbidapp/components/already_have_an_account_acheck.dart';
import 'package:flutterbidapp/components/rounded_button.dart';
import 'package:flutterbidapp/components/rounded_input_field.dart';
import 'package:flutterbidapp/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.02),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.2,
              ),
              SizedBox(height: size.height * 0.02),
              RoundedInputField(
                hintText: "Name",
                onChanged: (value) {},
                icon: Icons.person
              ),
              RoundedInputField(
                  hintText: "Phone number",
                  onChanged: (value) {},
                  icon: Icons.phone
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
                icon: Icons.mail
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {},
              ),
              SizedBox(height: size.height * 0.02),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

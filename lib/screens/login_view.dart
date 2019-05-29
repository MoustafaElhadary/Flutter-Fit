import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          setState(() {
            Navigator.pushReplacementNamed(context, '/home');
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(
              size: 150,
            ),
            Text(
              'The Moustafa Quiz',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LoginButton(
                  text: 'LOGIN WITH GOOGLE',
                  icon: FontAwesomeIcons.google,
                  color: Colors.green,
                  loginMethod: auth.googleSignIn,
                  textColor: Colors.white,
                ),
                LoginButton(
                  text: 'LOGIN WITH FACEBOOK',
                  icon: FontAwesomeIcons.facebookF,
                  color: Colors.blue[900],
                  loginMethod: auth.facebookSignIn,
                  textColor: Colors.white,
                ),
                LoginButton(
                  text: 'Continue as Guest',
                  loginMethod: auth.anonLogin,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key,
      this.text,
      this.icon,
      this.color,
      this.textColor,
      this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: RaisedButton(
        padding: EdgeInsets.all(15),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.white),
            Expanded(
              child: Text(
                '$text',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
}

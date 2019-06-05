import 'package:flutter/material.dart';
import 'package:ungproduct/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Container(
      alignment: Alignment(0, -1),
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        'Ung Product',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.green[900],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.green[400],
            ),
            labelText: 'Email :',
            helperText: 'you@email.com',
            labelStyle: TextStyle(color: Colors.green[400]),
            helperStyle: TextStyle(color: Colors.yellow[800]),
          ),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.green[400],
            ),
            labelText: 'Password :',
            helperText: 'More 6 Charactor',
            labelStyle: TextStyle(color: Colors.green[400]),
            helperStyle: TextStyle(color: Colors.yellow[800]),
          ),
        ),
      ),
    );
  }

  Widget signInButton() {
    return Expanded(
      child: FlatButton(
        color: Colors.green[800],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(
          color: Colors.green[800],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.green[800]),
        ),
        onPressed: () {
          print('Click Sign Up');
          var routeRegister =
              MaterialPageRoute(builder: (BuildContext context) => Register());
              Navigator.of(context).push(routeRegister);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0),
            colors: [Colors.white, Colors.green[800]],
            radius: 1.5,
          ),
        ),
        alignment: Alignment(0, -1),
        padding: EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
        child: Column(
          children: <Widget>[
            showLogo(),
            showAppName(),
            emailTextFormField(),
            passwordTextFormField(),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              alignment: Alignment(0, -1),
              child: Container(
                width: 250.0,
                child: Row(
                  children: <Widget>[
                    signInButton(),
                    signUpButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

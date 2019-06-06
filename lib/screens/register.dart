import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ungproduct/screens/product_list_view.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String name, email, password;

  Widget uploadButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.cloud_upload,
        size: 30.0,
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          uploadValueToFirebase(context);
        }
      },
    );
  }

  void uploadValueToFirebase(BuildContext conetxt) async {
    print('name = $name, email = $email, password = $password');
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      String uid = value.uid.toString();
      print('uid ==> $uid');
      updateUserToFirebase(uid, conetxt);
    }).catchError((String error) {
      print('Error ==> $error');
    });
  }

  void updateUserToFirebase(String uidString, BuildContext context) async {
    Map<String, String> map = Map();
    map['Name'] = name;
    map['Email'] = email;
    map['Uid'] = uidString;

    await firebaseDatabase
        .reference()
        .child('User')
        .child(uidString)
        .set(map)
        .then((value) {
      print('Update Success');

      // Create Route WithOut ArrowBack
      var productRoute = MaterialPageRoute(
          builder: (BuildContext context) => ProductListView());
      Navigator.of(context)
          .pushAndRemoveUntil(productRoute, (Route<dynamic> route) => false);
    }).catchError((String error) {
      print('Error on up Database ==>>> $error');
    });
  }

  Widget nameTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(
              Icons.face,
              color: Colors.green[400],
            ),
            labelText: 'Name :',
            helperText: 'Type Your Display Name',
            labelStyle: TextStyle(color: Colors.green[400]),
            helperStyle: TextStyle(color: Colors.yellow[800]),
            errorStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          validator: (String value) {
            if (value.length == 0) {
              return 'Please Fill in Blank Name';
            }
          },
          onSaved: (String value) {
            name = value;
          },
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
          validator: (String value) {
            if (!((value.contains('@')) && (value.contains('.')))) {
              return 'Please Email Format you@email.com';
            }
          },
          onSaved: (String value) {
            email = value;
          },
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
          validator: (String value) {
            if (value.length <= 5) {
              return 'Password Mush More 6 Charactor';
            }
          },
          onSaved: (String value) {
            password = value;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('Register'),
        actions: <Widget>[uploadButton(context)],
      ),
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment(0, -1),
          padding: EdgeInsets.only(top: 50.0),
          child: Container(
            width: 250.0,
            child: Column(
              children: <Widget>[
                nameTextFormField(),
                emailTextFormField(),
                passwordTextFormField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

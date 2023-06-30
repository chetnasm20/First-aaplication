import 'package:careercounselling/helper/functions.dart';
import 'package:careercounselling/services/auth.dart';
import 'package:careercounselling/views/home.dart';
import 'package:careercounselling/views/signup.dart';
import 'package:careercounselling/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;

  SignIn({required this.toogleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.signInEmailAndPass(email, password).then((val){
        if(val != null){
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter E-mail" : null;
                      },
                      decoration: InputDecoration(hintText: "Email"),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Password" : null;
                      },
                      decoration: InputDecoration(hintText: "Password"),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: blueButton(context: context, label: "Sign In"),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toogleView();
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 15.5,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

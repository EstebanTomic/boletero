import 'package:boletero/pages/pages.dart';
import 'package:boletero/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../providers/firebase_auth_provider.dart';
import '../widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routerName = 'Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthProvider _auth = FirebaseAuthProvider();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/newIcon2.png',
                height: 150,
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(205, 0, 115, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'O continua con',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _signUpGoogle,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(
                        'assets/googleIcon.png',
                        height: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(
                        'assets/macIcon.png',
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿No tienes cuenta?,"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                            (route) => false);
                      },
                      child: Text(
                        "Inscríbete aquí",
                        style: TextStyle(
                            color: Color.fromARGB(205, 0, 115, 198), fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        print("User is successfully signedIn");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {}
    } catch (e) {
      print("Some error happend ${e}");
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("${e}"),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _signUpGoogle() async {
    final user = await _auth.signInWithGoogle();
    if (user != null) {
      print("User is successfully created");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print("Some error happend");
    }
  }
}

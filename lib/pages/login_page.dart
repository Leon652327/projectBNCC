import 'package:actualprojectforril/firebase_service.dart';
import 'package:actualprojectforril/pages/home_page.dart';
import 'package:actualprojectforril/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _afk = false;
  bool visible1 = true;

  void login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _afk = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(curremail: _emailController.text)));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An error occured')));
      } finally {
        setState(() {
          _afk = false;
        });
      }
    }
  }

  void togglePassword1() {
    setState(() {
      visible1 = !visible1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Texture.jpg"),
              fit: BoxFit.cover,
              opacity: 1.0,
              colorFilter:
                  ColorFilter.mode(Colors.black87, BlendMode.multiply)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image(image: AssetImage("assets/Logo2.png"))),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.orange, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // email form
                        TextFormField(
                          style: const TextStyle(color: Colors.orange),
                          controller: _emailController,
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            hintText: "Input your email",
                            errorStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 161, 154)),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 161, 154))),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 161, 154))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (value.length < 6) {
                              return "Email is too short";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        // password form
                        TextFormField(
                          style: const TextStyle(color: Colors.orange),
                          controller: _passwordController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Input your password",
                            errorStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 161, 154)),
                            focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 161, 154))),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 161, 154))),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                            suffix: IconButton(
                              onPressed: () {
                                togglePassword1();
                              },
                              color: Colors.white,
                              icon: visible1
                                  ? const Icon(
                                      Icons.visibility_off,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                    ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          obscureText: visible1,
                        ),
                        
                        _afk
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  0.0,
                                  20.0,
                                  0.0,
                                  10.0,
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      login();
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Don't have an account ?", style: TextStyle(color: Colors.white),),
                            TextButton(
                                onPressed: () {
                                  
                                  Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => RegisterPage()));
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.orange,
                                      color: Colors.orange),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

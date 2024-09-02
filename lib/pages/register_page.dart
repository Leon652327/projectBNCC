import 'package:actualprojectforril/firebase_service.dart';
import 'package:actualprojectforril/pages/home_page.dart';
import 'package:actualprojectforril/pages/login_page.dart';
import 'package:actualprojectforril/widgets/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  bool _afk = false;
  bool visible1 = true;
  bool visible2 = true;

  void register() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _afk = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        Data newData = Data(
          email: _emailController.text,
          name: _usernameController.text,
          age: int.parse(_ageController.text),
          number: int.parse(_numberController.text),
          balance: 10000,
        );
        firebaseService.addData(newData);
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

  void togglePassword2() {
    setState(() {
      visible2 = !visible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Texture.jpg"),
              fit: BoxFit.cover,
              opacity: 1.0,
              colorFilter:
                  ColorFilter.mode(Colors.black87, BlendMode.multiply)),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
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
                      "Welcome to Foxet",
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
                          // name form
                          TextFormField(
                            style: const TextStyle(color: Colors.orange),
                            controller: _usernameController,
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              hintText: "Input your name",
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 161, 154)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your full name";
                              }
                              if (value.length < 6) {
                                return "Your name length is too short";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                          ),
                          // age form
                          TextFormField(
                            style: const TextStyle(color: Colors.orange),
                            controller: _ageController,
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              hintText: "Input your age",
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 161, 154)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              prefixIcon: Icon(
                                Icons.hourglass_bottom_sharp,
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your age";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          // number form
                          TextFormField(
                            style: const TextStyle(color: Colors.orange),
                            controller: _numberController,
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              hintText: "Input your number",
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 161, 154)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your number";
                              }
                              if (value.length < 6) {
                                return "number is invalid";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
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
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
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
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
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
                          // c password form
                          TextFormField(
                            style: const TextStyle(color: Colors.orange),
                            controller: _cpasswordController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Confirm your password",
                              errorStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 161, 154)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 161, 154))),
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
                                  togglePassword2();
                                },
                                color: Colors.white,
                                icon: visible2
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
                                return "Please confirm your password";
                              }
                              if (value != _passwordController.text) {
                                return "Please enter the same password";
                              }
                              return null;
                            },
                            obscureText: visible2,
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
                                        register();
                                      },
                                      child: const Text(
                                        "register",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account ?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  child: const Text(
                                    "Login",
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
      ),
    ]);
  }
}

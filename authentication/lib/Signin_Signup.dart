import 'package:authentication/forgotpassword.dart';
import 'package:authentication/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final _formkey = GlobalKey<FormState>();

class SigninSignup extends StatefulWidget {
  const SigninSignup({super.key});

  @override
  State<SigninSignup> createState() => _SigninSignupState();
}

class _SigninSignupState extends State<SigninSignup> {
  bool _isObscure3 = true;
  bool isSignupScreen = false;
  bool isChecked = false;

  var options = [
    'Client',
    'Counselor',
  ];

  var _currentItemSelected = "Client";
  var role = "Client";

  String selectedTextFieldItem = "Interested In";
  final List<String> _dropDownItems = [
    'Interested In',
    'Batik',
    'Handloom',
    'Masks',
  ];

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController specialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(55),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  // Color.fromARGB(255, 197, 85, 188),
                  Color.fromARGB(255, 73, 170, 212),
                  Color.fromARGB(255, 197, 85, 188),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSignupScreen = false;
                    });
                  },
                  child: Column(
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Calistoga',
                          color: Color.fromARGB(255, 1, 64, 62),
                        ),
                      ),
                      if (!isSignupScreen)
                        Container(
                            height: 2,
                            width: 100,
                            color: const Color.fromARGB(255, 2, 88, 85))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSignupScreen = true;
                    });
                  },
                  child: Column(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Calistoga',
                          color: Color.fromARGB(255, 1, 64, 62),
                        ),
                      ),
                      if (isSignupScreen)
                        Container(
                          height: 2,
                          width: 100,
                          color: const Color.fromARGB(255, 2, 88, 85),
                        )
                    ],
                  ),
                )
              ],
            ),
            if (!isSignupScreen)
              Container(
                margin: const EdgeInsets.only(top: 190),
                child: Form(
                  key: _formkey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF3F3F3),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 60, 188, 183),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 1, 64, 62)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Calistoga',
                            color: Color(0xFFB1A4A4),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF3F3F3),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            },
                            child: Icon(_isObscure3
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 60, 188, 183),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 1, 64, 62)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Calistoga',
                            color: Color(0xFFB1A4A4),
                          ),
                        ),
                        validator: (value) {
                          RegExp regExp = RegExp(r'^.{6}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regExp.hasMatch(value)) {
                            return ("Please enter valid password min. 6 character");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            }),
                        const Text(
                          "Remember password",
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 64, 62),
                            fontSize: 15,
                            fontFamily: 'Calistoga',
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 70,
                      right: 50,
                      left: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 140.0, right: 40.0, left: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Container(
                            height: 59,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 60, 188, 183),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Lalezar',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 50,
                      left: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ForgotPassword()));
                          },
                          child: const Center(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 64, 62),
                                fontSize: 16,
                                fontFamily: 'Calistoga',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 1, 64, 62),
                            fontSize: 16,
                            fontFamily: 'Calistoga',
                          ),
                          children: [
                            TextSpan(
                              text: " Sign Up",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 16, 22, 131),
                                fontSize: 16,
                                fontFamily: 'Calistoga',
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isSignupScreen = true;
                                  });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            if (isSignupScreen)
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Role :  ",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Calistoga',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 28, 45, 142),
                      ),
                    ),
                    DropdownButton<String>(
                      dropdownColor: const Color.fromARGB(255, 164, 199, 237),
                      isDense: true,
                      isExpanded: false,
                      iconDisabledColor:
                          const Color.fromARGB(255, 60, 188, 183),
                      underline: const SizedBox(),
                      focusColor: const Color.fromARGB(255, 164, 199, 237),
                      items: options.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 54, 5, 84),
                              fontSize: 18,
                              fontFamily: 'Calistoga',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected!;
                          role = newValueSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                  ],
                ),
              ),
            if (isSignupScreen)
              Container(
                margin: const EdgeInsets.only(top: 35.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: fnameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF3F3F3),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: "First Name",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'First name is required';
                          //   }
                          //   if (value.length < 3) {
                          //     return 'First name must be at least 3 characters';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextField(
                          controller: lnameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Last Name",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: mailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Email",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: DropdownButtonFormField(
                          value: selectedTextFieldItem,
                          items: _dropDownItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                  color: items == 'Interested In'
                                      ? Colors.grey
                                      : Colors.black,
                                  fontFamily: items == 'Interested In'
                                      ? 'Calistoga'
                                      : 'DefaultFontFamily',
                                  fontSize: items == 'Interested In' ? 12 : 16,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedTextFieldItem = value!;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF3F3F3),
                            prefixIcon: Icon(
                              Icons.thumb_up,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Interested In",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == 'Interested In') {
                              return 'Interested In is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: numberController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Mobile Number (for both)",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mobile number is required';
                            }
                            if (value.length != 10) {
                              return 'Mobile number should be 10 digits';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: passController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Create Password",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                          ),
                          validator: (value) {
                            RegExp regExp = RegExp(r'^.{6}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regExp.hasMatch(value)) {
                              return ("Please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 60, 188, 183),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 64, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Confirm Password",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Calistoga',
                              color: Color(0xFFB1A4A4),
                            ),
                          ),
                          validator: (value) {
                            if (confirmPasswordController.text !=
                                passController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              }),
                          const Text(
                            "Remember password",
                            style: TextStyle(
                              color: Color.fromARGB(255, 1, 64, 62),
                              fontSize: 15,
                              fontFamily: 'Calistoga',
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 50,
                        left: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 35.0, left: 40.0, right: 40.0, bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              _formkey.currentState!.validate();
                              signUp(
                                  role,
                                  fnameController.text,
                                  lnameController.text,
                                  mailController.text,
                                  selectedTextFieldItem,
                                  numberController.text,
                                  passController.text);
                            },
                            child: Container(
                              height: 59,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 60, 188, 183),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Lalezar',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: 500,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Already have an account?",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 1, 64, 62),
                                fontSize: 16,
                                fontFamily: 'Calistoga',
                              ),
                              children: [
                                TextSpan(
                                  text: " Sign In",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 16, 22, 131),
                                    fontSize: 16,
                                    fontFamily: 'Calistoga',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        isSignupScreen = false;
                                      });
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the next screen upon successful sign-in
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Home()));
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // Handle user not found error (user not registered)
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Sign-In Error'),
                content:
                    const Text('No user found with the provided credentials.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other FirebaseAuthException errors
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Sign-In Error'),
                content: const Text(
                    'An error occurred during sign-in. Please try again later.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle other types of exceptions
        print('Error signing in: $e');
      }
    }
  }

  void signUp(String role, String fname, String lname, String email,
      String interestedIn, String mobileNumber, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user data in Firestore based on the user's role
      if (role == 'Client') {
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('Clients');
        await collectionReference.doc(userCredential.user!.uid).set({
          'FirstName': fname,
          'LastName': lname,
          'email': email,
          'mobilenumber': mobileNumber,
          'interestedin': interestedIn,
          'create password': passController.text,
          'confirm password': confirmPasswordController.text,
        });
      } else if (role == 'Counselor') {
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('Counselors');
        await collectionReference.doc(userCredential.user!.uid).set({
          'FirstName': fname,
          'LastName': lname,
          'email': email,
          'mobilenumber': mobileNumber,
          'interestedin': interestedIn,
          'create password': passController.text,
          'confirm password': confirmPasswordController.text,
        });
      }

      // Navigate to the next screen upon successful sign-up
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Home()));
    } catch (e) {
      // Handle sign-up errors
      print('Error signing up: $e');
      // Show an error message to the user or perform any other error handling logic
    }
  }
}

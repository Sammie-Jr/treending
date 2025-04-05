// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:treending/main.dart';
import 'package:treending/register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formField = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formField,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 310),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => RegistrationView(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 300, top: 60),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: textField(
                  'Email',
                  '@example.com',
                  emailController,
                  // Function to create a text field with the specified label and hint text
                  TextInputType.emailAddress,
                  (emailController) {
                    if (emailController == null || emailController.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(emailController)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              textField(
                'Password',
                'Enter 6 digits password',
                passController,
                TextInputType.visiblePassword,
                (passController) {
                  // Function to validate the password field
                  if (passController == null || passController.isEmpty) {
                    return 'Please enter your password';
                  } else if (passController.length < 6) {
                    return 'Password must be at least 6 characters long';
                  } else if (passController.length >= 8) {
                    return 'Password must not be 8 characters long';
                  } else if (!RegExp(
                    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                  ).hasMatch(passController)) {
                    return 'Password must contain at least one letter and one number';
                  }
                  return null;
                },
                passToggle,
                '●',
                IconButton(
                  icon: Icon(
                    passToggle ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 235),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login action here

                    if (_formField.currentState!.validate()) {
                      // Perform login logic here
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    }

                    // print the email and password to the console
                    print('Email: ${emailController.text}');
                    print('Password: ${passController.text}');

                    // after successful login.

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.grey[300],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        margin: EdgeInsets.only(
                          bottom: 50,
                          left: 40,
                          right: 40,
                        ),
                        // Show a success message
                        content: Center(
                          child: Text(
                            'Login successful!',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.black,

                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 120,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textField(
  String label,
  String hintText, [
  controller,
  keyboardType,
  validator,
  obsecureText,
  obsecureCharacter,
  suffixIcon,
]) {
  // Function to create a text field with the specified label and hint text
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
    child: TextFormField(
      cursorColor: Colors.black,
      obscuringCharacter: obsecureCharacter ?? '●',
      obscureText: obsecureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      validator: validator,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusColor: Colors.black,

        label: Text(label, style: TextStyle(color: Colors.black, fontSize: 14)),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    ),
  );
}

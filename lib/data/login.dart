import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:save2woproj/main.dart';

//STATEFUL WIDGET FOR THE LOGIN SCREEN
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//STATE FOR THE LOGIN SCREEN
class _LoginScreenState extends State<LoginScreen> {
  //SHOW OR HIDE THE PASSWORD INPUT
  bool _isPasswordVisible = false;
  //Key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Controllers for the email and password textbox
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //function to authenticate user
  Future<void> authenticate(String email, String password) async {
    try {
      //make the POST request to the REST API login
      final response = await http.post(
        Uri.parse('https://save2wo-api.vercel.app/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
        }),
      );

      // Debugging prints
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      //if the response is successful
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'authorized') {
          //If authorized, navigate to the dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Panel()),
          );
        } else {
          //If not authorized, show an error message. E di wag ka maglagay ng tamang input hmp.
          _showErrorDialog(data['message'] ?? 'Unknown error');
        }
      } else {
        // If the response was not successful, show an error dialog. Dito ako nahirapan kasi laging nag error yung promise hayst so nag try catch ako to handle the exception.
        _showErrorDialog('Failed to login. Please try again.');
      }
    } catch (e) {
      // Catch any exceptions that occur during the authentication process
      print('Error occurred: $e');
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    // Show an error dialog with the given message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed\nKindly recheck your email and password'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // Close the dialog when the OK button is pressed
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the login form
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) {
                // Validate the email input. Feel ko kahit di na kasama to pero to show respect kay Allendog di ko na tinaggal HAHAHA pero pede sya if gagawa signin
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: const Color(0xff108494),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  // Submit the form when the Sign in button is pressed
                  if (_formKey.currentState?.validate() ?? false) {
                    authenticate(emailController.text, passwordController.text);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}

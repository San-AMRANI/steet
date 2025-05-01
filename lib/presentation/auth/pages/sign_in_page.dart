import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData? passwordIcon = CupertinoIcons.eye_slash_fill;
  bool obscurePassword = true;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              labelText: 'Email',
              hintText: 'Email',
              controller: emailController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: CupertinoIcons.mail,
              errorMsg: _errorMessage,
              onChanged: (value) {
                setState(() {
                  _errorMessage = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              labelText: 'Password',
              hintText: 'Password',
              controller: passwordController,
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: CupertinoIcons.lock,
              suffixIcon: IconButton(
                  onPressed: () => setState(() {
                        obscurePassword = !obscurePassword;
                        passwordIcon = obscurePassword
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye;
                      }),
                  icon: Icon(passwordIcon)),
              errorMsg: _errorMessage,
              onChanged: (value) {
                setState(() {
                  _errorMessage = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                    .hasMatch(value)) {
                  return 'Password must be at least 8 characters long and include both letters and numbers';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          !signInRequired
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform sign-in action
                        setState(() {
                          signInRequired = true;
                        });
                      } else {
                        setState(() {
                          _errorMessage =
                              'Please fill in all fields correctly.';
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      elevation: 3.0,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : const CircularProgressIndicator(),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Navigate to the forgot password page
            },
            child: Text(
              'Forgot Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

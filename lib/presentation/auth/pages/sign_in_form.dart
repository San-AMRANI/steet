import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/providers/auth_provider.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final passwordController = TextEditingController();
  final emailOrUsernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData? passwordIcon = CupertinoIcons.eye_slash_fill;
  bool obscurePassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    emailOrUsernameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Reset the sign-in required state when the form is initialized
      WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(authProvider.notifier).resetResponseStatus();
  });
    
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    

    // When authentication is successful, navigate to home screen
    if (authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/mobile');
      });
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              labelText: 'Email or username',
              hintText: 'email@example.com or username',
              controller: emailOrUsernameController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: CupertinoIcons.mail,
              errorMsg: authState.error,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email or username';
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
              errorMsg: authState.error,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextButton(
              onPressed: authState.isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).signIn(
                            emailOrUsernameController.text,
                            passwordController.text);
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
              child: authState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ))
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ),
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

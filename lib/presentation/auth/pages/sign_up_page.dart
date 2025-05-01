import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

class SignUpPages extends StatefulWidget {
  const SignUpPages({super.key});

  @override
  State<SignUpPages> createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final majorController = TextEditingController();
  final dobController = TextEditingController();

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
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: MyTextField(
                    labelText: 'Last Name',
                    hintText: 'Last Name',
                    controller: nameController,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: CupertinoIcons.person,
                    errorMsg: _errorMessage,
                    onChanged: (value) {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: MyTextField(
                    labelText: 'First Name',
                    hintText: 'First Name',
                    controller: nameController,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    // prefixIcon: CupertinoIcons.person_fill,
                    errorMsg: _errorMessage,
                    onChanged: (value) {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              labelText: 'Major',
              hintText: 'Major',
              controller: majorController,
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: CupertinoIcons.book,
              errorMsg: _errorMessage,
              onChanged: (value) {
                setState(() {
                  _errorMessage = null;
                });
              },
              validator: (value) {
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    dobController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  });
                }
              },
              child: AbsorbPointer(
                child: MyTextField(
                  labelText: 'Date of Birth',
                  hintText: 'Date of Birth',
                  controller: dobController,
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  prefixIcon: CupertinoIcons.calendar,
                  errorMsg: _errorMessage,
                  onChanged: (value) {
                    setState(() {
                      _errorMessage = null;
                    });
                  },
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Perform sign-in action
                setState(() {
                  signInRequired = true;
                });
              } else {
                setState(() {
                  _errorMessage = 'Please fill in all fields correctly.';
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
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

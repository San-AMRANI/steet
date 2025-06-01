
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/widgets/my_select_field.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';
import 'package:steet/presentation/widgets/new_password.dart';
import 'package:steet/presentation/providers/auth_provider.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final majorController = TextEditingController();
  final dobController = TextEditingController();
  String? selectedMajor;

  final _formKey = GlobalKey<FormState>(); // Main form key
  final _passwordFormKey = GlobalKey<FormState>(); // Password modal form key
  IconData? passwordIcon = CupertinoIcons.eye_slash_fill;
  bool obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    majorController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth state to reflect UI changes
    final authState = ref.watch(authProvider);


    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              labelText: 'Email *',
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
                    labelText: 'Last Name *',
                    hintText: 'Last Name',
                    controller: lastNameController,
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
                      if (value == null || value.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: MyTextField(
                    labelText: 'First Name *',
                    hintText: 'First Name',
                    controller: firstNameController,
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
                      if (value == null || value.isEmpty) {
                        return 'First name is required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Replace the existing Major TextField (around line 116)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MySelectField<String>(
              labelText: 'Major',
              hintText: 'Select your major',
              prefixIcon: CupertinoIcons.book,
              value: selectedMajor,
              items: const [
                DropdownMenuItem(
                    value: 'COMPUTER_SCIENCE', child: Text('Computer Science')),
                DropdownMenuItem(
                    value: 'MATHEMATICS', child: Text('Mathematics')),
                DropdownMenuItem(value: 'PHYSICS', child: Text('Physics')),
                DropdownMenuItem(value: 'CHEMISTRY', child: Text('Chemistry')),
                DropdownMenuItem(value: 'BIOLOGY', child: Text('Biology')),
                DropdownMenuItem(value: 'HISTORY', child: Text('History')),
                DropdownMenuItem(value: 'ART', child: Text('Art')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedMajor = value;
                  majorController.text = value ??
                      ''; // Update the controller to maintain compatibility
                  _errorMessage = null;
                });
              },
              errorMsg: _errorMessage,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a major';
                }
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
                  labelText: 'Date of Birth *',
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
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: authState.isLoading
                ? null
                : () {
                    _showModalBottomSheet();
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: Text(
                      'Create Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet() {
    // Validate main form fields before showing password modal
    if (!_formKey.currentState!.validate() ||
        selectedMajor == null || selectedMajor!.isEmpty ||
        dobController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields before creating a password.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Form(
          key: _passwordFormKey,
          child: SizedBox(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create a new password",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                NewPasswordWidget(
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  showOldPassword: false,
                  formKey: _passwordFormKey,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Consumer(builder: (context, ref, _) {
                    final authState = ref.watch(authProvider);
                    return TextButton(
                      onPressed: authState.isLoading
                          ? null
                          : () {
                              // Validate password fields before signup
                              if (_passwordFormKey.currentState!.validate()) {
                                final userData = {
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                  'username': emailController.text.split('@').first,
                                  'firstName': firstNameController.text,
                                  'lastName': lastNameController.text,
                                  'dob': dobController.text,
                                  'major': selectedMajor,
                                };
                                ref.read(authProvider.notifier).signUp(userData).then((_) {
                                  Navigator.pop(context);
                                  final nextState = ref.watch(authProvider);
                                  if (nextState.isRegistred) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text((nextState.success != null) ? 'Registration successful!' : 'Registration failed!'),
                                        backgroundColor: (nextState.success != null) ? Colors.green : Colors.red,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Sign up failed , please try again."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  ref.read(authProvider.notifier).resetResponseStatus();
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
                      child: authState.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 0),
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

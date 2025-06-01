import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:steet/presentation/auth/pages/sign_in_form.dart';
import 'package:steet/presentation/auth/pages/sign_up_form.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                  alignment: AlignmentDirectional(20, -1.2),
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  )),
              Align(
                  alignment: AlignmentDirectional(-2.7, -1.2),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 1.3,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )),
              Align(
                  alignment: AlignmentDirectional(2.7, -1.2),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 1.3,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 80.0),
                    alignment: Alignment.center,
                    child: Text("Welcome to Steet",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Where all students meet",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Image.asset(
                      'lib/assets/images/logo.png',
                      height: 100.0,
                      width: 100.0,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.65,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          labelColor: Theme.of(context).colorScheme.onSurface,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child:
                              TabBarView(controller: tabController, children: [
                        // Sign In Page
                        const SignInForm(),
                        // Sign Up Page
                        const SignUpForm(),
                      ])),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

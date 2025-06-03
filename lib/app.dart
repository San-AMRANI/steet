import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/dashboard/pages/dashHome.dart';
import 'package:steet/presentation/rooms/pages/welcome_page.dart';
import 'package:steet/presentation/screens/admin_scafold.dart';
import 'package:steet/presentation/screens/mobile_scafold.dart';
import 'package:steet/presentation/providers/auth_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the auth state
    
    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Steet',
      theme: ThemeData(
          fontFamily: 'CascadiaMono',
          useMaterial3: true,
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 37, 77, 255),
            secondary: Color.fromARGB(255, 13, 155, 221),
            surface: Color.fromARGB(255, 237, 244, 250),
            error: Color(0xFFB00020),
            tertiary: Color.fromARGB(255, 88, 125, 248),
            onPrimary: Color(0xFFFFFFFF),
            onSecondary: Color(0xFF000000),
            onSurface: Color(0xFF000000),
            onError: Color.fromARGB(255, 0, 0, 0),
          )),
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/mobile': (context) => const MobileScafold(),
      },
      home: authState.isAuthenticated
          ? (authState.isAdmin
              ? const AdminScafold()
              : const MobileScafold())
          : const WelcomePage(),
    );
  }
}

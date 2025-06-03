import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/providers/auth_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          Future.microtask(() {
            // Check authentication status when the app starts
            ref.read(authProvider.notifier).checkAuthStatus();
          });
          return const MyApp();
        }
      ),
    ),
  );
}


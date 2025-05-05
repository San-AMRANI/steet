import 'package:flutter/material.dart';
import 'package:steet/presentation/widgets/subpage_appbar.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(title: "New Password", avatarUrl: "https://www.amranihassan.site/avatar.png"),
      body: const Center(
        child: Text('New Password Page Content'),
      ),
    );
  }
}
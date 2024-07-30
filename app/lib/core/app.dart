import 'package:flutter/widgets.dart';

class MainApp extends StatefulWidget {
  final String? role;
  final String? token;
  const MainApp({super.key, required this.role, required this.token});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

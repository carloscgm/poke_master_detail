import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 10),
      () {
        context.go(NavigationRoutes.pokemonRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: 500,
        color: const Color.fromRGBO(205, 183, 247, 1),
        child: Center(
          child: Image.asset('images/Icon.png'),
        ),
      ), // Empty page
    );
  }

  @override
  void dispose() {
    super.dispose(); // Avoid memory leaks
  }
}

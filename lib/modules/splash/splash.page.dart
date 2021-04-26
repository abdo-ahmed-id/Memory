import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/helpers/routes.dart';
import 'package:memories/modules/app/bloc/app.bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Modular.get<AppBloc>().initState();
    Timer(Duration(seconds: 3),
        () => Modular.to.pushReplacementNamed(AppRoutes.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'flutter',
          child: FlutterLogo(
            size: 200,
          ),
        ),
      ),
    );
  }
}

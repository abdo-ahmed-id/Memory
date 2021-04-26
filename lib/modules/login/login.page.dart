import 'package:builders/builders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/modules/app/bloc/app.bloc.dart';
import 'package:memories/modules/app/bloc/app.state.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatelessWidget {
  String _userName;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AppBloc, AppState>(
            buildWhen: (p, c) => p.newAccount != c.newAccount,
            builder: (_, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Text(
                      state.newAccount ? 'Login' : 'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 7),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'enter your UserName'),
                      onChanged: (value) {
                        _userName = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          InputDecoration(hintText: 'enter your password'),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          validationInput(context);
                        },
                        child: Text(state.newAccount ? 'Sign In' : 'Register')),
                    SizedBox(height: 10),
                    Text('OR'),
                    TextButton(
                      onPressed: () {
                        Modular.get<AppBloc>().toggleNewAccount();
                      },
                      child: Text(state.newAccount
                          ? 'Create New Account'
                          : 'Sign In With Account'),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void validationInput(BuildContext context) {
    if ((_userName == null || _password == null) ||
        (_userName.isEmpty || _password.isEmpty)) {
      Toast.show('please enter data', context,
          duration: 2, gravity: Toast.CENTER);
    } else {
      Modular.get<AppBloc>()
          .loginOrCreateAccount(context, _userName, _password);
    }
  }
}

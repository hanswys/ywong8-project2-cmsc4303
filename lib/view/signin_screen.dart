import 'package:flutter/material.dart';
import 'package:lesson6/controller/signinscreen_controller.dart';
import 'package:lesson6/model/sigin_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignInScreen> {
  late SignInModel model;
  late SignInScreenController con;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    model = SignInModel();
    con = SignInScreenController(this);
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: model.inProgress
          ? const Center(child: CircularProgressIndicator())
          : signInForm(),
    );
  }

  Widget signInForm() {
    return Column(
      children: [
        Text(
          'My Inventory',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email address:',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: model.validateEmail,
                    onSaved: model.saveEmail,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'password:',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    validator: model.validatePassword,
                    onSaved: model.savePassword,
                  ),
                  FilledButton.tonal(
                    onPressed: con.signIn,
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
    return Padding(
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
                validator: null,
                onSaved: null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'password:',
                ),
                obscureText: true,
                autocorrect: false,
                validator: null,
                onSaved: null,
              ),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

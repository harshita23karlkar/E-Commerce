import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (emailController.text.isEmpty) {
                    return "Enter a valid email";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "Enter Your Email"),
              ),
              TextFormField(
                controller: passController,
                decoration: const InputDecoration(
                    labelText: "Password", hintText: "Enter Your Password"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setString("email", emailController.text);
                  prefs.setString("password", passController.text);
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

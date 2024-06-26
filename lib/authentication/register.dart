// ignore_for_file: prefer_const_constructors, unused_import
import 'package:calc_firebase_login/authentication/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../calculator.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool yes = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('--Register--',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2
          ),),
        centerTitle: true,

      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val){},
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder()

                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Enter an E-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (val){},
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder()

                ),
                validator: (value) => value!.length < 6 ? 'Pass should be at least 6 characters' : null,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    try{
                      setState(() => yes = !yes);
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Calculator() ));
                    }
                    catch(e){
                      setState(() {
                        error = e.toString();
                      });
                    }
                  }
                  else{
                    setState(() => error = 'Error in Registering');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                        color: Colors.white
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 60),
              Text('Existing User?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              const SizedBox(height: 20),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'SIGN-IN',
                    style: TextStyle(
                        color: Colors.white
                    ),

                  ),
                ),
              ),
              SizedBox(height: 60),
              Visibility(
                visible: !yes,
                child: SpinKitCubeGrid(
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(error,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 30
                ),)


            ],
          ),
        ),
      ),
    );
  }
}

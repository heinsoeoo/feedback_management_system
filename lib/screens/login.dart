import 'package:feedback_management_system/controllers/auth_controller.dart';
import 'package:feedback_management_system/screens/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.2),
                  )
                ]
            ),
            width: w*0.8,
            height: h*0.6,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(
                      width: w*0.5,
                      height: h*0.1,
                      child: const Image(
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.deepPurple,
                          ),
                          labelText: "Email",
                          hintText: "Enter your email address",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.deepPurple,
                          ),
                          focusColor: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.deepPurple,
                          ),
                          labelText: "Password",
                          hintText: "Enter your password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.deepPurple,
                          ),
                          focusColor: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: w*0.4,
                      height: h*0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                        children: [
                          TextSpan(
                              text: " Create",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>Register())
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


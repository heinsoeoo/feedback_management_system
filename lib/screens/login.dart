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
        child: Column(
          children: [
            Expanded(
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
                          SizedBox(height: h*0.03),
                          Expanded(
                            child: SizedBox(
                              width: w*0.5,
                              height: h*0.1,
                              child: const Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            ),
                          ),
                          SizedBox(height: h*0.01),
                          Expanded(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13,
                                ),
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
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13,
                                ),
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
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: SizedBox(
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
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                        text: " Create",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>Register())
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



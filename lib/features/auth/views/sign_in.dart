import 'package:auth_app/common/colors.dart';
import 'package:auth_app/common/paths.dart';
import 'package:auth_app/features/auth/controller/auth_controller.dart';
import 'package:auth_app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(signInImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: scaffoldBGColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: whiteColor, fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: whiteColor,
                                filled: true,
                                hintText: "Email",
                                hintStyle: const TextStyle(color: activeColor),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        const BorderSide(color: borderColor))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: whiteColor,
                                filled: true,
                                hintText: "Password",
                                hintStyle: const TextStyle(color: activeColor),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        const BorderSide(color: borderColor))),
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref
                                        .read(authControllerProvider)
                                        .signInWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        )
                                        .then(
                                          (value) =>
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRouteNames.home,
                                                  (route) => false),
                                        );
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                color: activeColor,
                                minWidth: double.infinity,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                              onTap: () {},
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(color: textButtonTextColor),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRouteNames.signUp,
                                  (route) => false,
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't haven't an account ?",
                                    style: TextStyle(
                                        color: textButtonTextColor,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: activeColor, fontSize: 14),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

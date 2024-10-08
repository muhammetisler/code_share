import 'package:auth_app/common/colors.dart';
import 'package:auth_app/common/paths.dart';
import 'package:auth_app/features/auth/controller/auth_controller.dart';
import 'package:auth_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/route_names.dart';

class SignUpContinue extends StatefulWidget {
  const SignUpContinue({super.key, required this.email});

  final String email;

  @override
  State<SignUpContinue> createState() => _SignUpContinueState();
}

class _SignUpContinueState extends State<SignUpContinue> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _userNameController.dispose();
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
                  image: AssetImage(signUpInfo),
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
                            "Sign Up",
                            style: TextStyle(color: whiteColor, fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: whiteColor,
                                filled: true,
                                hintText: "Name",
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
                            controller: _surnameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Surname is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: whiteColor,
                                filled: true,
                                hintText: "Surname",
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
                            controller: _userNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: whiteColor,
                                filled: true,
                                hintText: "Username",
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
                                    UserModel userModel = UserModel(
                                        name: _nameController.text,
                                        surname: _surnameController.text,
                                        email: widget.email,
                                        username: _userNameController.text);
                                    ref
                                        .read(authControllerProvider)
                                        .storeUserInfoToFirebase(userModel)
                                        .whenComplete(
                                          () =>
                                              Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRouteNames.home,
                                            (route) => false,
                                          ),
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
                                    "Continue",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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

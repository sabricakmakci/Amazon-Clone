import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/utils/helpers/validators/string_validators.dart';
import 'package:amazon_clone/utils/regexp/regexp_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.nameFocus = FocusNode();
    authService.nameFocus!.addListener(() => authService.checkName());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authService.nameFocus!.dispose();
    authService.emailController.dispose();
    authService.passwordController.dispose();
    authService.nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: authService.emailController.text,
      password: authService.passwordController.text,
      name: authService.nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: authService.emailController.text,
      password: authService.passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor:
                      _auth == Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Creat Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            focusNode: authService.nameFocus,
                            controller: authService.nameController,
                            hintText: 'Name',
                            keyboardType: TextInputType.text,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(50),
                              RegexpHelper.textRegex(),
                            ],
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "This Field Is Required";
                              }
                              if (!StringValidators.isValidName(value)) {
                                return "Name Is Not Valid";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: authService.emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: authService.passwordController,
                            hintText: 'Password',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                                _signUpFormKey.currentState!.reset();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor:
                      _auth == Auth.signin ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signinFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: authService.emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: authService.passwordController,
                            hintText: 'Password',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                              text: 'Sign Up',
                              onTap: () {
                                if (_signinFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

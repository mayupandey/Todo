import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todoapp/src/constant/StaticImageAssets.dart';
import 'package:todoapp/src/constant/constants.dart';
import 'package:todoapp/src/provider/FirebaseProvider.dart';
import 'package:todoapp/src/provider/LoadingProvider.dart';
import 'package:todoapp/src/views/LoadingScreen.dart';
import 'package:todoapp/src/widget/commonwidget.dart';

import '../constant/RouteName.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loadingProvider.state);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: loading.state == LoadingState.loaded
              ? Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: const Text(
                          "Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 34),
                        ),
                        subtitle: const Text(
                          "Todo App  place to store Task",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: LottieBuilder.asset(loadingLottie),
                      ),
                      spaceHeight(MediaQuery.of(context).size.height * 0.085),
                      bottomContainers(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: bottomSheet("Email"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.isValidEmail() == false) {
                                return 'Please enter an email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                        ),
                      ),
                      spaceHeight(20),
                      bottomContainers(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: bottomSheet("Password"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length <= 6) {
                                return value!.length <= 6
                                    ? "Enter password greator than 6"
                                    : 'Please enter a password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ButtonStyle(
                            maximumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            loading.state = LoadingState.loading;
                            ref
                                .watch(firebaseAuthProvider)
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password)
                                .catchError((e) {

                              loading.state = LoadingState.loaded;
                              toast(e.toString());
                            });
                          }
                        },
                        child: const SizedBox(
                            width: double.infinity,
                            child: Center(child: Text('Sign In'))),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                          style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.green)))),
                          onPressed: () {
                            context.pushNamed(RouteName.SignupScreenRoute);
                          },
                          child: const SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text('Create Account',
                                    style: TextStyle(color: Colors.green)),
                              ))),
                    ],
                  ),
                )
              : const Loading(),
        ),
      ),
    );
  }
}

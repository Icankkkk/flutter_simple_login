import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_login/components/my_button.dart';
import 'package:simple_login/components/square_tile.dart';
import 'package:simple_login/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // exception code
  final String userNotFoundCode = 'user-not-found';

  final String wrongPasswordCode = 'wrong-password';

  // Text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user method
  void signUser() async {
    // show loading circle
    showLoading();

    // try sign ini
    try {
      final email = emailController.text;
      final password = passwordController.text;

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // hide loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // hide loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      // handle errors
      if (e.code == userNotFoundCode) {
        showErrorMessage('EMAIL NOT FOUND', 'No user found for that email.');
      } else if (e.code == wrongPasswordCode) {
        showErrorMessage(
            'WRONG PASSWORD', 'Wrong password provided for that user.');
      }
    }
  }

  void showErrorMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.poppins(),
          ),
          content: Text(
            message,
            style: GoogleFonts.poppins(),
          ),
        );
      },
    );
  }

  void showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 34),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 25),

                // Welcome back, you'v been missed!
                Text(
                  "Welcome back, you've been missed!",
                  style: GoogleFonts.poppins(
                      color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign button
                MyElevatedButton(onPress: signUser),

                const SizedBox(height: 35),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // google + facebook sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/google_logo.png'),

                    SizedBox(width: 25),

                    // facebook button
                    SquareTile(imagePath: 'assets/facebook_logo.png'),
                  ],
                ),

                // not a member? register now
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: GoogleFonts.poppins(),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: GoogleFonts.poppins(
                        color: Colors.blue.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

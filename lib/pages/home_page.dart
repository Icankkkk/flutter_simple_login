import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // method for sign out
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // atributs
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOut(),
        child: const Icon(Icons.logout),
      ),

      // body of layout / page
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            'LOGGED IN AS: ${user.email}',
            style: GoogleFonts.poppins(),
          ),
        ),
      ),
    );
  }
}

import 'package:chat2/signInpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: .6,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
            ),
            Text(
              user.displayName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(user.metadata.creationTime!.toString()),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              ),
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const SignInPage();
                }), (route) => false);
              },
              child: const Text('SignOut'),
            ),
          ],
        ),
      ),
    );
  }
}

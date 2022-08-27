import 'package:chat2/firebase_options.dart';
import 'package:chat2/home_page.dart';
import 'package:chat2/post.dart';
import 'package:chat2/signInpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const MaterialApp(
        home: SignInPage(),
      );
    } else {
      return MaterialApp(
        home: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: const Home(),
        ),
      );
    }
  }
}

final postsReference =
    FirebaseFirestore.instance.collection('posts').withConverter<Post>(
  // <> ここに変換したい型名をいれます。今回は Post です。
  fromFirestore: ((snapshot, _) {
    // 第二引数は使わないのでその場合は _ で不使用であることを分かりやすくしています。
    return Post.fromFirestore(snapshot); // 先ほど定期着した fromFirestore がここで活躍します。
  }),
  toFirestore: ((value, _) {
    return value.toMap(); // 先ほど適宜した toMap がここで活躍します。
  }),
);

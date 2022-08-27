import 'package:chat2/my_postwidge.dart';
import 'package:chat2/post.dart';
import 'package:chat2/post_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'my_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: .6,
          title: const Text(
            'Messages',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyPage();
                    },
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot<Post>>(
                    stream: postsReference.orderBy('createdAt').snapshots(),
                    builder: (context, snapshot) {
                      final docs = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final post = docs[index].data();
                          if (post.posterId !=
                              FirebaseAuth.instance.currentUser!.uid)
                            return PostWidget(post: post);
                          else
                            return MyPostWidget(post: post);
                        },
                      );
                    }),
              ),
              Container(
                height: 45,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                      iconSize: 20,
                      color: Colors.black54,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_outlined),
                      iconSize: 20,
                      color: Colors.black54,
                    ),
                    Flexible(
                      child: Expanded(
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 214, 214),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: TextFormField(
                            autofocus: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (text) {
                              final user = FirebaseAuth.instance.currentUser!;

                              final posterId = user.uid;
                              final posterName = user.displayName!;
                              final posterImageUrl = user.photoURL!;

                              final newDocumentReference = postsReference.doc();

                              final newPost = Post(
                                text: text,
                                posterName: posterName,
                                posterImageUrl: posterImageUrl,
                                posterId: posterId,
                                createdAt: Timestamp.now(),
                                reference: newDocumentReference,
                              );
                              newDocumentReference.set(newPost);
                            },
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mic),
                      iconSize: 20,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

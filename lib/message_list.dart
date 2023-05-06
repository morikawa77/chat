import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/message.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class MessageListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessageListPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();

  final _scrollController = ScrollController(); // auto scroll

  @override
  Widget build(BuildContext context) {
    Query messagesQuery = _db.collection('messages').orderBy('datetime');

    return Scaffold(
      appBar: AppBar(
        title: const Text("AnonChat"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messagesQuery.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
            return Text('Erro: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // auto scroll
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          });

          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          final List<Message> messages = documents
              .map((doc) => Message(
                  doc.id, doc['message'], doc['userID'], doc['datetime']))
              .toList();

          return Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    controller: _scrollController, // auto scroll
                    children: messages.map((message) {
                      bool isCurrentUser =
                          message.userid == user?.uid.toString();
                      Color backgroundColor =
                          isCurrentUser ? Color(0xFF03A9F4) : Color(0xFF616161);

                      return ListTile(
                        leading: null,
                        title: Wrap(
                          alignment: isCurrentUser
                              ? WrapAlignment.end
                              : WrapAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.only(
                                  topRight: const Radius.circular(10),
                                  topLeft: const Radius.circular(10),
                                  bottomLeft: isCurrentUser
                                      ? const Radius.circular(10)
                                      : const Radius.circular(0),
                                  bottomRight: isCurrentUser
                                      ? const Radius.circular(0)
                                      : const Radius.circular(10),
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        "${message.message!}\n",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                          color: Color(0xFFF5F5F5),
                                        ),
                                    )),
                                    // ignore: prefer_const_constructors
                                    WidgetSpan(
                                      child: Text(
                                        DateFormat('dd/MM/yyyy - HH:mm:ss')
                                            .format(message.datetime!.toDate()),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFFF5F5F5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: null,
                        trailing: null,
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  color: const Color(0xFF616161),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                // borderSide: const BorderSide(color: Colors.grey),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFBDBDBD),
                            ),
                            style: const TextStyle(
                              // color: Colors.black,
                              // fontSize: 16,
                              // height: 1.5,
                            ),
                            cursorColor: Colors.blue,
                            controller: _messageController,
                            onSubmitted: (text) async {
                              if (text.trim().isNotEmpty) {
                                await sendMessage(text);
                                _messageController.clear();
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.send, color: Color(0xFF03A9F4), size: 30,),
                          tooltip: 'Enviar',
                          onPressed: () async {
                            String text = _messageController.text.trim();
                            if (text.isNotEmpty) {
                              await sendMessage(text);
                              _messageController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> sendMessage(String text) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference messages = firestore.collection('messages');

      DateTime now = DateTime.now().toUtc();
      Timestamp timestamp =
          Timestamp.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch);

      await messages.add({
        'message': text,
        'userID': user?.uid.toString(),
        'datetime': timestamp,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao enviar a mensagem: $e');
    }
  }
}

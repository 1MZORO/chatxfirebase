import 'package:chatxfirebase/Services/ChatService/ChatService.dart';
import 'package:chatxfirebase/Utils/ChatBubble.dart';
import 'package:chatxfirebase/Utils/CustomTF.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Services/Auth_Services.dart';

class ChatScreen extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatScreen(
      {super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController _messageClt = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageClt.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageClt.text);

      _messageClt.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
        stream: _chatService.getMessage(receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error Occur');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('...Loading');
          }

          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          Expanded(
              child: CustomTF(
                  text: "type message here", obscure: false, clt: _messageClt)),
          Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20)
              ),
              child: IconButton(
                  onPressed: sendMessage, icon: Icon(Icons.arrow_upward,color: Colors.white,)))
        ],
      ),
    );
  }
}

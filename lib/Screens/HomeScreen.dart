import 'package:chatxfirebase/Screens/ChatScreen.dart';
import 'package:chatxfirebase/Services/Auth_Services.dart';
import 'package:chatxfirebase/Services/ChatService/ChatService.dart';
import 'package:chatxfirebase/Utils/CustomDrawer.dart';
import 'package:chatxfirebase/Utils/UserTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () async {
                final auth = AuthService();
                await auth.logout();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.logout,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        drawer: CustomDrawer(),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error Occur');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('...Loading');
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()?.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      ChatScreen(receiverEmail: userData['email'], receiverId: userData['uid'],)));
        },
      );
    } else {
      return Container();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';
import 'package:lamie_middle_east/model/user_model.dart';

class ChatCardWidget extends StatelessWidget {
  final List<User> chatList;
  const ChatCardWidget({super.key, required this.chatList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        User? user = chatList[index];
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(AppImageStrings.loginImage),
              ),
              title: Text(user.username),
              subtitle: Text(user.email),
            ),
          ),
        );
      },
    );
  }
}

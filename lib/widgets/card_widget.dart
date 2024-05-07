import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';
import 'package:lamie_middle_east/model/user_model.dart';

class CardWidget extends StatelessWidget {
  final List<Connection> chatList;
  const CardWidget({super.key, required this.chatList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        Connection? connection = chatList[index];
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
              title: Text(connection.username),
              subtitle: Text(connection.email),
            ),
          ),
        );
      },
    );
  }
}

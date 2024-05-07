import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east/controller/login/login_bloc.dart';
import 'package:lamie_middle_east/widgets/appbar_widget.dart';
import 'package:lamie_middle_east/widgets/card_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Chats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('All chats'),
            Expanded(
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is GetUserDataSuccessState) {
                    if (state.chatList.isEmpty) {
                      return const Center(child: Text('No data found'));
                    }
                    return CardWidget(chatList: state.chatList);
                  } else {
                    return const Center(child: Text('No Data Found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

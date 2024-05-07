import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/controller/user/user_bloc.dart';
import 'package:lamie_middle_east/widgets/chat_card_widget.dart';
import 'package:lamie_middle_east/widgets/search_textfield.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            backgroundColor: AppColors.lightGrey,
            centerTitle: true,
            title: const Text("Example"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: SearchTextField(
                  controller: searchController,
                  hintText: "Search here...",
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            print('state is $state');
            if (state is UserSearchingSuccessState) {
              return ChatCardWidget(chatList: state.userList);
            }
            return const Center(
              child: Text('Data Not Found'),
            );
          },
        ));
  }
}

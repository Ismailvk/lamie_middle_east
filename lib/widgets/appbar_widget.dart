import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/data/shared_preference/shared_preference.dart';
import 'package:lamie_middle_east/view/login_screen.dart';
import 'package:lamie_middle_east/view/search_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int notificationCount;

  const CustomAppBar(
      {super.key, required this.title, this.notificationCount = 0});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _buildLeadingAvatar(),
      title: Text(title),
      actions: [
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildLeadingAvatar() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.grey,
            child: const Icon(Icons.person),
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            right: 0,
            bottom: 3,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.red,
              child: Text(
                '$notificationCount+',
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen()));
                  },
                  child: const Icon(Icons.search_outlined)),
              const SizedBox(width: 30),
              GestureDetector(
                child: const Icon(Icons.logout),
                onTap: () {
                  SharedPref.instance.removeToken();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

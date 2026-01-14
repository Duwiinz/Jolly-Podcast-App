import 'package:flutter/material.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';

class JollyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JollyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.color13,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 🔹 Left: Logo
            Image.asset(
              'assets/images/onboardingLogo.png',
              height: 28,
            ),

            // 🔹 Right actions
            Row(
              children: [
                
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(
                      'assets/images/userAvatar.png',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // TODO: search
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: notifications
                  },
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                ),
               

              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/auth/cubit/auth_cubit.dart';
import 'package:jolly_podcast/auth/cubit/auth_state.dart';
import 'package:jolly_podcast/auth/model/user_model.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;

  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    const bgTop = Color(0xFF0E1412);
    const bgBottom = Color(0xFF070A09);

    // Stats not returned by login response yet -> default to 0
    const followingCount = 0;
    const playlistsCount = 0;
    const minutesListenedCount = 0;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthLoggedOut || current is AuthError,
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
          return;
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [bgTop, bgBottom],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Image.asset(
                        'assets/images/onboardingLogo.png',
                        height: 26,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: _Pill(
                      text: "Go back",
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: const CircleAvatar(
                      radius: 38,
                      backgroundImage: AssetImage("assets/images/userAvatar.png"),
                      backgroundColor: Colors.black26,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    user.fullName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _ProfileStat(label: "Following", value: "$followingCount"),
                      _StatDot(),
                      _ProfileStat(label: "Playlists", value: "$playlistsCount"),
                      _StatDot(),
                      _ProfileStat(
                        label: "Minutes listened",
                        value: "$minutesListenedCount",
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Divider(color: Colors.white.withOpacity(0.10), height: 30),

                  const SizedBox(height: 18),

                  _MenuTile(
                    icon: Icons.manage_accounts_outlined,
                    title: "Account settings",
                    onTap: () {},
                  ),
                  _MenuTile(
                    icon: Icons.security_outlined,
                    title: "Security settings",
                    onTap: () {},
                  ),
                  _MenuTile(
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    onTap: () {},
                  ),
                  _MenuTile(
                    icon: Icons.mic_none_outlined,
                    title: "Become a podcast creator",
                    onTap: () {},
                  ),

                  const SizedBox(height: 6),

                  _MenuTile(
                    icon: Icons.logout,
                    title: "Logout",
                    titleColor: const Color(0xFFFF5A5A),
                    iconColor: const Color(0xFFFF5A5A),
                    onTap: () {
                      context.read<AuthCubit>().logout();
                    },
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _FooterLink(text: "Terms", onTap: () {}),
                      const SizedBox(width: 18),
                      _FooterLink(text: "Privacy policy", onTap: () {}),
                    ],
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _Pill({required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.10)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.65),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _StatDot extends StatelessWidget {
  const _StatDot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final cTitle = titleColor ?? Colors.white.withOpacity(0.92);
    final cIcon = iconColor ?? Colors.white.withOpacity(0.85);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: cIcon, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: cTitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.35),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.55),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white.withOpacity(0.30),
        ),
      ),
    );
  }
}

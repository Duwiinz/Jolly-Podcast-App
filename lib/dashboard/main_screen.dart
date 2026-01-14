import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/app_startup.dart';
import 'package:jolly_podcast/dashboard/home_screen/cubit/episode_cubit.dart';
import 'package:jolly_podcast/dashboard/page/category_page.dart';
import 'package:jolly_podcast/dashboard/page/discover_page.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/custom_appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EpisodeCubit>(
      create: (_) => getIt<EpisodeCubit>()..fetchEpisodes(),
      child: const _MainScreenView(),
    );
  }
}

class _MainScreenView extends StatefulWidget {
  const _MainScreenView();

  @override
  State<_MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<_MainScreenView> {
  int _index = 0;

  final pages = const [DiscoverPage(), CategoryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color13,
      appBar: JollyAppBar(),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
        ],
      ),
    );
  }
}

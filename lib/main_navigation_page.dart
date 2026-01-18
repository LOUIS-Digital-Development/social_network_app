import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:bloc_app/features/chat/presentation/pages/chats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const BlogPage(), const ChatsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: _pages, index: _selectedIndex),
      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_filled), label: ''),
          const NavigationDestination(icon: Icon(Icons.chat), label: ''),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:logistics/src/events/views/events_view.dart';
import 'package:logistics/src/navigation/components/keep_alive_page.dart';
import 'package:logistics/src/notices/views/notices_view.dart';
import 'package:logistics/src/profile/views/profile_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final List<Widget> _views = <Widget>[
    KeepAlivePage(child: EventsView()),
    KeepAlivePage(child: ProfileView()),
    KeepAlivePage(child: NoticesView())
  ];
  PageController _pageController = PageController(initialPage: 1);
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 6.0),
              child: AppBar(
                backgroundColor: colorScheme.background.withOpacity(0.6),
                title: Image.asset(
                  colorScheme.brightness == Brightness.dark
                      ? 'assets/logistics/logo-dark.png'
                      : 'assets/logistics/logo-light.png',
                  width: 120,
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.tune,
                      weight: 200,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ],
                elevation: 0.0,
                scrolledUnderElevation: 0.0,
              ),
            ),
          ),
        ),
        preferredSize: const Size(double.infinity, 65.0),
      ),
      body: PageView(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: ((index) {
          setState(() {
            _selectedIndex = index;
          });
        }),
        children: _views,
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: ((index) {
              _pageController.jumpToPage(index);
            }),
            destinations: <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Events',
                selectedIcon: Icon(Icons.explore),
              ),
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                selectedIcon: Icon(Icons.home),
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Notices',
                selectedIcon: Icon(Icons.calendar_month_rounded),
              ),
            ],
            elevation: 0.0,
            backgroundColor: colorScheme.background.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

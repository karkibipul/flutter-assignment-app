import 'package:flutter/material.dart';

class ThemeSwitcherScreen extends StatefulWidget {
  const ThemeSwitcherScreen({Key? key}) : super(key: key);

  @override
  State<ThemeSwitcherScreen> createState() => _ThemeSwitcherScreenState();
}

class _ThemeSwitcherScreenState extends State<ThemeSwitcherScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: isDark ? Colors.black : Colors.white,
        child: Center(
          child: SwitchListTile(
            title: Text(
              isDark ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            value: isDark,
            onChanged: (val) {
              setState(() {
                isDark = val;
              });
            },
          ),
        ),
      ),
    );
  }
}

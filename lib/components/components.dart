import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/themeState.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const MyAppBar({
    this.showBack = false,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    ThemeState themeState = Provider.of<ThemeState>(context);
    return AppBar(
      title: Text(widget.title),
      leading: widget.showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : null,
      actions: [
        IconButton(
          iconSize: 30,
          icon: Icon(Theme.of(context).brightness == Brightness.dark
              ? Icons.wb_sunny
              : Icons.nightlight_outlined),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            themeState.toggleTheme();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBarWidget({this.onChanged, this.onClear, Key? key}) : super(key: key);

  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  @override
  State<SearchAppBarWidget> createState() => _SearchAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  bool isSearchEnabled = false;

  final TextEditingController searchController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearchEnabled
          ? TextField(
              focusNode: focusNode,
              controller: searchController,
              onChanged: (newText) {
                widget.onChanged?.call(newText);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
            )
          : const Text('Test toolbar'),
      actions: [
        !isSearchEnabled
            ? IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearchEnabled = true;
                    focusNode.requestFocus();
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    searchController.clear();
                    isSearchEnabled = false;
                    widget.onClear?.call();
                  });
                },
              ),
      ],
    );
  }
}

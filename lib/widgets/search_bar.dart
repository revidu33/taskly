import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/provider/TaskProvider.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (query) {
          Provider.of<TaskProvider>(context, listen: false)
              .updateSearchQuery(query);
        },
        decoration: const InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../model/user.dart';

class UserListScreen extends StatefulWidget {
  final List<User> users;
  final List<String> sources;

  const UserListScreen({super.key, required this.users, required this.sources});

  @override
  // ignore: library_private_types_in_public_api
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _selectedFilter = 'All';
  late TextEditingController _searchController;
  List<User> filteredList = [];

  String selectedValue = 'Apple';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredList = widget.users.cast<User>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<User> getFilteredUsers() {
    if (_selectedFilter == 'All') {
      return widget.users;
    } else {
      return widget.users
          .where((user) => user.source == _selectedFilter)
          .toList();
    }
  }

  void filterList() {
    setState(() {
      if (searchText.isEmpty) {
        filteredList = widget.users;
      } else {
        filteredList = widget.users;
        filteredList
            .where((item) => item.email.contains(searchText.toLowerCase()))
            .toList();
        filteredList
            .where((item) => item.name.contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  List<User> getSearchedUsers() {
    final searchTerm = _searchController.text.toLowerCase();
    return getFilteredUsers().where((user) {
      return user.name.toLowerCase().contains(searchTerm) ||
          user.email.toLowerCase().contains(searchTerm);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple[200],
          title: const Text(
            'Users List',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        onChanged: (newValue) {
                          _selectedFilter = newValue!;
                          setState(() {});
                        },
                        items: ['All', ...widget.sources].map((source) {
                          return DropdownMenuItem<String>(
                            value: source,
                            child: Text(source),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: getSearchedUsers().length,
                itemBuilder: (context, index) {
                  final user = getSearchedUsers()[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Text(user.source),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //Container(
      //   margin: const EdgeInsets.all(10),
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           DropdownButton<String>(
      //             value: _selectedFilter,
      //             onChanged: (value) {
      //               setState(() {
      //                 _selectedFilter = value!;
      //               });
      //             },
      //             items: ['All', ...widget.sources].map((source) {
      //               return DropdownMenuItem<String>(
      //                 value: source,
      //                 child: Text(source),
      //               );
      //             }).toList(),
      //           ),
      //           const SizedBox(width: 16.0),
      //           Expanded(
      //             child: TextFormField(
      //               controller: _searchController,
      //               decoration: const InputDecoration(labelText: 'Search'),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: getSearchedUsers().length,
      //           itemBuilder: (context, index) {
      //             final user = getSearchedUsers()[index];
      //             return ListTile(
      //               title: Text(user.name),
      //               subtitle: Text(user.email),
      //               trailing: Text(user.source),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

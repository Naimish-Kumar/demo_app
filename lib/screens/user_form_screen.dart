import 'package:demo_app/screens/user_list_screen.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sources = ['Facebook', 'Instagram', 'Organic', 'Friend', 'Google'];
  final List<User> _users = [];

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late String _selectedSource;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _selectedSource = _sources[0];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final newUser = User(
          name: _nameController.text,
          email: _emailController.text,
          source: _selectedSource,
        );
        _users.add(newUser);

        _nameController.clear();
        _emailController.clear();
        _selectedSource = _sources[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text(
          'UserList App',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/imas.png',fit: BoxFit.cover,height: 200,width: double.infinity,),
                const SizedBox(height: 50,),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSource,
                  onChanged: (value) {
                    setState(() {
                      _selectedSource = value!;
                    });
                  },
                  items: _sources.map((source) {
                    return DropdownMenuItem<String>(
                      value: source,
                      child: Text(source),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                      labelText: 'Where are you coming from?',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
                    child: Text(
                      'Add User',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UserListScreen(users: _users, sources: _sources)),
          );
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}

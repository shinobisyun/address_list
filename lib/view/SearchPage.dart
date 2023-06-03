import 'package:address_list/view/contactlist/ContactsCellDetail.dart';
import 'package:flutter/material.dart';
import '../GlobalVariable.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Contact> _searchResults = [];

  void _searchContacts(String query) {
    final searchResults =
        contactList!.where((contact) => contact.name == query).toList();
    setState(() {
      _searchResults = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final contact = _searchResults[index];
            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.phoneNumber),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactsCellDetail(contact: contact),
                  ),
                );
              },
            );
          },
        ));
  }
}

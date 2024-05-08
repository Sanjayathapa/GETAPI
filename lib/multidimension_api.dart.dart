import 'package:flutter/material.dart';
import 'model/model.dart';
import 'service/fetch_service.dart';


class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data?.isEmpty == true) { 
          return Center(child: Text('No data available'));
        } else {
          final usersList = snapshot.data!;
          return ListView.builder(
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              final user = usersList[index];
              return Card(
             child: ListTile(
                title: Text(user.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${user.email}'),
                    Text('Street: ${user.address.street}'),
                    Text('Suite: ${user.address.suite}'),
                    Text('City: ${user.address.city}'),
                    Text('Zipcode: ${user.address.zipcode}'),
                    Text('Geo: Lat ${user.address.geo.lat}, Lng ${user.address.geo.lng}'),
                  ],
                ),
              ));
            },
          );
        }
      },
    );
  }
}

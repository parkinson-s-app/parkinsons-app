import 'package:flutter/material.dart';
import '../../model/User.dart';

class UserListItem extends StatelessWidget {
  final User _user;

  UserListItem(this._user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          child: Text(_user.name[0]),
        ),
        title: Text(_user.name),
        subtitle: Text(_user.email));
  }
}

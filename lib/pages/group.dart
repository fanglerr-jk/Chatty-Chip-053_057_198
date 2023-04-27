import 'package:wireless/pages/home_page.dart';
import 'package:wireless/service/database_service.dart';
import 'package:wireless/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupMembers extends StatelessWidget {
  final String groupName;
  final String adminName;
  final Stream members;

  const GroupMembers({
    Key? key,
    required this.groupName,
    required this.adminName,
    required this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGroupInfo(context),
          const SizedBox(height: 20),
          _buildMemberList(),
        ],
      ),
    );
  }

  Widget _buildGroupInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              groupName.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Group: $groupName',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Text('Admin: ${getName(adminName)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberList() {
    return StreamBuilder<Map>(
      stream: members,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!['members'] == null || snapshot.data!['members'].isEmpty) {
          return const Center(
            child: Text('NO MEMBERS'),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!['members'].length,
          itemBuilder: (context, index) {
            final member = snapshot.data!['members'][index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    getName(member).substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(getName(member)),
                subtitle: Text(getId(member)),
              ),
            );
          },
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../shared_prefs.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);
  OdooSession? session;
  OdooClient? client;

  Future<List<dynamic>> getCustomers(context) async {
    final prefs = SharedPref();
    final sobj = await prefs.readObject('session');
    final baseUrl = await prefs.readString('baseUrl');
    session = OdooSession.fromJson(sobj);
    client = OdooClient(baseUrl.toString(), session);
    try {
      final result = await client?.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': ['id', 'name', 'email', 'phone', 'company_id', 'street'],
          'limit': 100,
          'offset': 0
        },
      });
      return result ?? [];
    } catch (e) {
      client?.close();
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
                children: <Widget>[Center(child: Text(e.toString()))]);
          });
      return [];
    }
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed('/partner/customer/${record['id'].toString()}');
        },
        title: Text(record['name']),
        subtitle: Text(record['email'] ?? 'No email'),
        trailing: Text(record['phone'] ?? 'No phone'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SearchBar(),
            FutureBuilder(
                future: getCustomers(context),
                builder: (context, AsyncSnapshot<dynamic> customerSnapshot) {
                  if (customerSnapshot.hasData) {
                    if (customerSnapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: customerSnapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final record = customerSnapshot.data[index]
                                as Map<String, dynamic>;
                            return buildListItem(record);
                          },
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}

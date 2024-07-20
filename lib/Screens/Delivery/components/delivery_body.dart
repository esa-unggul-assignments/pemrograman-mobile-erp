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

  Future<List<dynamic>> getDeliveries(context) async {
    final prefs = SharedPref();
    final sobj = await prefs.readObject('session');
    final baseUrl = await prefs.readString('baseUrl');
    session = OdooSession.fromJson(sobj);
    client = OdooClient(baseUrl.toString(), session);
    try {
      final result = await client?.callKw({
        'model': 'stock.picking',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'domain': [
            "&",
            ["picking_type_id", "=", 2],
            [
              "state",
              "in",
              ["assigned", "partially_available"]
            ]
          ],
          'fields': [
            "priority",
            "name",
            "location_id",
            "location_dest_id",
            "partner_id",
            "signature",
            "user_id",
            "scheduled_date",
            "date_deadline",
            "origin",
            "group_id",
            "backorder_id",
            "picking_type_id",
            "company_id",
            "state",
            "activity_exception_decoration",
            "activity_exception_icon",
            "json_popover"
          ],
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
    Color stateColor;
    switch (record['state']) {
      case 'assigned':
        stateColor = Colors.blue;
        break;
      case 'partially_available':
        stateColor = Colors.orange;
        break;
      default:
        stateColor = Colors.grey;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed('/stockPickingView/${record['id'].toString()}');
        },
        title: Text(record['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location: ${record['location_id'][1]}'),
            Text('Destination: ${record['location_dest_id'][1]}'),
            if (record['scheduled_date'] != null)
              Text('Scheduled: ${record['scheduled_date']}'),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: stateColor,
          ),
          child: Text(
            record['state'].toString().toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
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
                future: getDeliveries(context),
                builder: (context, AsyncSnapshot<dynamic> customerSnapshot) {
                  if (customerSnapshot.hasData) {
                    print(customerSnapshot.data);
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

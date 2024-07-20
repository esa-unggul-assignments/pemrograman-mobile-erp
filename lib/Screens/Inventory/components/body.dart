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

  getInventories(context) async {
    final prefs = SharedPref();
    final sobj = await prefs.readObject('session');
    final baseUrl = await prefs.readString('baseUrl');
    session = OdooSession.fromJson(sobj);
    client = OdooClient(baseUrl.toString(), session);
    try {
      return await client?.callKw({
        'model': 'product.template',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'domain': [
            [
              "type",
              "in",
              ["consu", "product"]
            ]
          ],
          'fields': [
            "id",
            "product_variant_count",
            "currency_id",
            "activity_state",
            "name",
            "default_code",
            "lst_price",
            "qty_available",
            "uom_id",
            "type",
            "show_on_hand_qty_status_button"
          ],
          'limit': 100,
          'offset': 0
        }
      });
    } catch (e) {
      client?.close();
      print('errorrr ${e.toString()}');
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
                children: <Widget>[Center(child: Text(e.toString()))]);
          });
    }
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed('/productView/${record['id'].toString()}');
        },
        title: Text(record['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Default Code: ${record['default_code'] ?? "N/A"}'),
            Text(
                'Price: ${record['currency_id'][1]} ${record['lst_price'].toString()}'),
            Text(
                'Quantity Available: ${record['qty_available'].toString()} ${record['uom_id'][1]}'),
          ],
        ),
        trailing: record['qty_available'] > 0
            ? Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: const Text(
                  'AVAILABLE',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
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
              future: getInventories(context),
              builder: (context, AsyncSnapshot<dynamic> orderSnapshot) {
                if (orderSnapshot.hasData) {
                  if (orderSnapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: orderSnapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final record = orderSnapshot.data[index]
                                as Map<String, dynamic>;
                            return buildListItem(record);
                          }),
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
    ));
  }
}

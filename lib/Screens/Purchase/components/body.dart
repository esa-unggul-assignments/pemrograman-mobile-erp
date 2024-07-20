import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../shared_prefs.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);
  OdooSession? session;
  OdooClient? client;

  getPurchases(context) async {
    final prefs = SharedPref();
    final sobj = await prefs.readObject('session');
    final baseUrl = await prefs.readString('baseUrl');
    session = OdooSession.fromJson(sobj);
    client = OdooClient(baseUrl.toString(), session);
    try {
      return await client?.callKw({
        'model': 'purchase.order',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          "context": {
            "lang": "en_US",
            "tz": "Europe/Brussels",
            "uid": 2,
            "allowed_company_ids": [1],
            "quotation_only": true
          },
        }
      });
    } catch (e) {
      client?.close();
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
                children: <Widget>[Center(child: Text(e.toString()))]);
          });
    }
  }

  Widget buildListItem(Map<String, dynamic> record) {
    var unique = record['id'].toString();
    unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    final avatarUrl =
        '${client?.baseURL}/web/image?model=res.partner&field=image&id=${record["partner_id"][0]}&unique=$unique';
    var stateColor = Colors.orange;
    switch (record['state']) {
      case 'draft':
        stateColor = Colors.blue;
        break;
      case 'sent':
        stateColor = Colors.purple;
        break;
      case 'purchase':
        stateColor = Colors.green;
        break;
      case 'cancel':
        stateColor = Colors.red;
        break;
    }
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          onTap: () {
            Get.toNamed('/saleOrderView/${record['id'].toString()}');
          },
          leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
          title: Text(record['name']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: stateColor),
                  child: Text(
                    record['state'].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                    ),
                  )),
              Text(record['currency_id'][1] +
                  ' ' +
                  record['amount_total'].toString()),
            ],
          ),
          subtitle: Text(
            record['partner_id'][1],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
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
              future: getPurchases(context),
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

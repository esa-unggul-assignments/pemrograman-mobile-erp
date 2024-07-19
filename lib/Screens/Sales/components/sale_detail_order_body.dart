import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../shared_prefs.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.title,
    required this.orderId,
  }) : super(key: key);
  final String? title;
  final String orderId;
  OdooSession? session;
  OdooClient? client;

  getSaleOrderDetail(context) async {
    final prefs = SharedPref();
    final sobj = await prefs.readObject('session');
    final baseUrl = await prefs.readString('baseUrl');
    session = OdooSession.fromJson(sobj);
    client = OdooClient(baseUrl.toString(), session);
    try {
      return await client?.callKw({
        'model': 'sale.order',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'domain': [
            ['id', '=', orderId]
          ],
          'fields': [
            'id',
            'name',
            'partner_id',
            'state',
            'currency_id',
            'amount_total',
            'date_order',
            'amount_total',
            'source_id',
            'medium_id',
            'pricelist_id'
          ],
          'limit': 1,
          'offset': 0
        },
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
              future: getSaleOrderDetail(context),
              builder: (context, AsyncSnapshot<dynamic> orderSnapshot) {
                if (orderSnapshot.hasData) {
                  if (orderSnapshot.data != null) {
                    final saleOrder = orderSnapshot.data[0]!;
                    print(saleOrder);

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Number: ${saleOrder['name']}',
                              style: Theme.of(context).textTheme.headlineSmall),
                          Text('Partner: ${saleOrder['partner_id'][1]}'),
                          Text(
                              'Total Amount: ${saleOrder['currency_id'][1]} ${saleOrder['amount_total']}'),
                          Text('Date: ${saleOrder['date_order']}'),
                          Text('Source: ${saleOrder['source_id'][1]}'),
                          Text('Medium: ${saleOrder['medium_id'][1]}'),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                    // return Expanded(
                    //   child: ListView.builder(
                    //       itemCount: orderSnapshot.data.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         final record = orderSnapshot.data[index]
                    //             as Map<String, dynamic>;
                    //         return buildListItem(record);
                    //       }),
                    // );
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

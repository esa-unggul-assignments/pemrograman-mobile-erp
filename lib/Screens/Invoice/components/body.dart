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

  getInvoices(context) async {
    final prefs = SharedPref();
    final sobj = await prefs.readObject('session');
    final baseUrl = await prefs.readString('baseUrl');
    session = OdooSession.fromJson(sobj);
    client = OdooClient(baseUrl.toString(), session);
    try {
      return await client?.callKw({
        'model': 'account.move',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          // 'domain': ["move_type", "=", "out_invoice"],
          'fields': [
            "name",
            "partner_id",
            "invoice_source_email",
            "invoice_partner_display_name",
            "invoice_date",
            "invoice_date_due",
            "invoice_origin",
            "payment_reference",
            "ref",
            "invoice_user_id",
            "l10n_id_tax_number",
            "l10n_id_csv_created",
            "team_id",
            "activity_ids",
            "activity_exception_decoration",
            "activity_exception_icon",
            "activity_state",
            "activity_summary",
            "activity_type_id",
            "activity_type_icon",
            "company_id",
            "amount_untaxed_signed",
            "amount_tax_signed",
            "amount_total_signed",
            "amount_residual_signed",
            "currency_id",
            "company_currency_id",
            "state",
            "payment_state",
            "move_type"
          ]
        }
      });
    } catch (e) {
      client?.close();
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
                children: <Widget>[Center(child: Text(e.toString()))]);
          });
    }
  }

  Widget buildListItem(Map<String, dynamic> record) {
    var stateColor = Colors.orange;
    switch (record['state']) {
      case 'draft':
        stateColor = Colors.blue;
        break;
      case 'posted':
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
          // Get.toNamed('/invoiceView/${record['id'].toString()}');
        },
        title: Text(record['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${record['partner_id'][1]}'),
            Text('Invoice Date: ${record['invoice_date'] ?? "N/A"}'),
            Text('Due Date: ${record['invoice_date_due'] ?? "N/A"}'),
            Text(
                'Total: ${record['currency_id'][1]} ${record['amount_total_signed'].toString()}'),
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
              future: getInvoices(context),
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

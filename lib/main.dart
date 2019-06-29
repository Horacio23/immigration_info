import 'package:flutter/material.dart';
import 'package:immigration_info/domain/selected_info.dart';
import 'package:immigration_info/views/transactiondetail.dart';
import 'package:immigration_info/utils/navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Informacion de Immigracion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Informacion de Immigracion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = 'Ciudadano';
  String _transaction = "I-130";
  final _statusList = ['Ciudadano', 'Residente'];
  final _transactionMap = {
    'I-130': 'Reclamaciones Familiares',
    'I-498': 'Residencia',
    'I-765': 'Permiso de Trabajo',
    'I-864': 'Affidavit'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Estado Migratorio:',
                    textScaleFactor: 1.3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: DropdownButton(
                    items: _statusList
                        .map((String value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    value: _status,
                    onChanged: (value) {
                      _onDropDownChange(value);
                    },
                  ),
                ),
              ],
            ),
            Container(
              child: getTransactionList(),
              height: 630,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToContactUs(_status, _transaction, context),
        tooltip: 'Contact Us',
        child: Icon(Icons.contact_mail),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListView getTransactionList() {
    var transactionTypes = _transactionMap.keys.toList();

    return ListView.builder(
      itemCount: _transactionMap.keys.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(transactionTypes[position]),
            subtitle: Text(this._transactionMap[transactionTypes[position]]),
            onTap: () {
              debugPrint("Tapped on " + transactionTypes[position]);
              navigateToDetail(transactionTypes[position], this._status);
            },
          ),
        );
      },
    );
  }

  void _onDropDownChange(String value) {
    setState(() {
      this._status = value;
    });
  }

  void navigateToDetail(String transaction, String status) async {
    SelectedInfo info =
        SelectedInfo(transaction, status, _transactionMap[transaction]);
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TransactionDetail(info)));
  }
}

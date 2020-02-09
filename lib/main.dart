import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          buttonColor: Color.fromRGBO(0xcc, 0x62, 0x00, 1)),
          
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

  Color myPurple = Color.fromRGBO(142, 45, 226, 1);
  Color myIndigo = Color.fromRGBO(74, 0, 224, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [myPurple, myIndigo],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                                              child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('Estado Migratorio:',
                              textScaleFactor: 1.3,
                              style: Theme.of(context).accentTextTheme.title),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(25),
                                  right: Radius.circular(25)),
                              color: Theme.of(context).buttonColor),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: _statusList
                                  .map((String value) => DropdownMenuItem(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 5),
                                          child: Text(
                                            value,
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .title,
                                          ),
                                        ),
                                        value: value,
                                      ))
                                  .toList(),
                              value: _status,
                              onChanged: (value) {
                                _onDropDownChange(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 270,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: getTransactionList(),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0))),
                  ),
                ),
              ),
            ],
          ),
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

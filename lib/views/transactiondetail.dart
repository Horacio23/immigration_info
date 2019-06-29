import 'package:flutter/material.dart';
import 'package:immigration_info/domain/selected_info.dart';
import 'package:immigration_info/utils/navigation.dart';

class TransactionDetail extends StatefulWidget {
  final SelectedInfo selectedInfo;
  TransactionDetail(this.selectedInfo);

  @override
  State<StatefulWidget> createState() => TransactionDetailState(selectedInfo);
}

class TransactionDetailState extends State {
  SelectedInfo _selectedInfo = SelectedInfo('I-130', 'Residente');
  List<String> generalInformation = [
    'Certificacion de Nacimiento',
    'Identificacion',
    'Residencia',
    'Historial de Policia'
  ];
  TransactionDetailState(this._selectedInfo);

  @override
  Widget build(BuildContext context) {
    String transaction = _selectedInfo.transaction;
    String status = _selectedInfo.status + 's';
    String description = _selectedInfo.description;
    return Scaffold(
      appBar: AppBar(
        title: Text('$description'),
      ),
      // body: Text('Documentos Necessarios de $transaction para $status'),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:10.0, bottom: 10.0),
            child: Text( 'Se necesitan los siguentes documentos:',
            textScaleFactor: 1.5,),
          ),
          Expanded(
            child: displayDocumentsNeeded(this._selectedInfo),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToContactUs(
            _selectedInfo.status, _selectedInfo.transaction, context),
        tooltip: 'Contact Us',
        child: Icon(Icons.contact_mail),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListView displayDocumentsNeeded(SelectedInfo info) {
    List<String> requiredDocuments;

    switch (info.transaction) {
      case "I-130":
        if (info.status == "Residente") {
          requiredDocuments = this.generalInformation;
        } else {
          requiredDocuments = List.from(this.generalInformation)
            ..addAll(['Certificado de Ciudadania']);
        }
        break;
      case "I-498":
        requiredDocuments = this.generalInformation;
        break;
      case "I-765":
        requiredDocuments = this.generalInformation;
        break;
      case "I-864":
        requiredDocuments = this.generalInformation;
        break;
    }

    return ListView.builder(
      itemCount: requiredDocuments.length,
      itemBuilder: (BuildContext context, int position) {
        return ListTile(
          leading: Icon(Icons.assignment),
          title: Text(requiredDocuments[position]),
        );
      },
    );
  }
}

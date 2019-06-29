import 'package:flutter/material.dart';
import 'package:immigration_info/domain/selected_info.dart';

class ContactUs extends StatefulWidget {
  final SelectedInfo selectedInfo;
  ContactUs(this.selectedInfo);

  @override
  State<StatefulWidget> createState() => ContactUsState(selectedInfo);
}

class ContactUsState extends State {
  SelectedInfo _selectedInfo = SelectedInfo('I-130', 'Residente');
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ContactUsState(this._selectedInfo);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    String transaction = _selectedInfo.transaction;
    String status = _selectedInfo.status + 's';
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Concactar Agente'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'Nombre',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          labelText: 'Apellido',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Correo Electronico',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: 'Numero de telefono',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text("Enviar"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String name = nameController.text;
                          return AlertDialog(
                            title: Text("Gracias $name. Su informacion a sido enviada"),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ));
  }
}

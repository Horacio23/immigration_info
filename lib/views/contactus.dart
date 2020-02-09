import 'package:flutter/material.dart';
import 'package:immigration_info/domain/selected_info.dart';
import 'package:url_launcher/url_launcher.dart';

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
  var _concactKey = GlobalKey<FormState>();

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
        body: Form(
          key: _concactKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Por favor escriba su nombre";
                          }
                        },
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
                      child: TextFormField(
                        controller: lastNameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Por favor escriba su apellido";
                          }
                        },
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
                  child: TextFormField(
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
                  child: TextFormField(
                    controller: phoneController,
                    validator: (String value) {
                      if(value.isEmpty) {
                        return "Por favor entre su numero de telefono";
                      } else if (value.length < 10) {
                        return "Por favor entre un numbero de telefono valildo";
                      }

                    },
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
                      if (_concactKey.currentState.validate()) {
                        String name = nameController.text;
                        String lastName = lastNameController.text;
                        String phone = phoneController.text;
                        String email = emailController.text;
                        _launchURL(
                            "horacio231292@hotmail.com",
                            "Nuevo Cliente - $lastName, $name",
                            "Informacion del client \n" +
                                "Nombre: $name $lastName\n" +
                                "Correo: $email\n" +
                                "Telefono: $phone\n");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';

    if (await canLaunch(url)) {
      await launch(url);
      String name = nameController.text;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Gracias $name. Su informacion a sido enviada"),
            );
          });
    } else {
      throw 'Could not launch $url';
    }
  }
}

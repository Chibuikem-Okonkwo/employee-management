import 'dart:convert';
import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerEmployeeState();
  }
}

Future<EmployeeModel>RegisterEmployees(
String firstName, String lastName, BuildContext context)async{
  Uri Url=Uri.parse('http://localhost:8080/addemployee');
  var response = await http.post(Url,
headers:<String, String>{"Content-Type":"application/json"},
body: jsonEncode(<String, String>{
   "firstName"  : firstName,
  "lastName"  : lastName,
}));

  String responseString = response.body;
  if(response.statusCode == 200){
    showDialog(context: context,
        barrierDismissible : true,
        builder :(BuildContext dialogContext){
        return MyAlertDialog(title: 'Backend Response', content: response.body);
    },);
    }
  throw '';
  }

class registerEmployeeState extends State<RegisterEmployee> {
  final minimumPadding = 5.0;
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  late EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Employee'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: firstController,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter Your First Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                  )),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: lastController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter Your Last Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(child: Text('Submit'), onPressed: () async{
                String firstName = firstController.text;
                String lastName = lastController.text;
                EmployeeModel employees = await RegisterEmployees(firstName, lastName, context);
                firstController.text = '';
                lastController.text = '';
                setState(() {
                  employee = employees;
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatelessWidget{
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    required this.title ,
    required this.content,
    this.actions = const[],
});

  @override
  Widget build(BuildContext context) {
   return AlertDialog(
     title: Text(
       this.title,
       style: Theme.of(context).textTheme.subtitle1,
     ),
     actions: this.actions,
     content: Text(
       this.content,
       style: Theme.of(context).textTheme.bodyText1,
     ),
   );
  }
}
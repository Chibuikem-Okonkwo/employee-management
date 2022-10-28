import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screen/EmployeeDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateEmployee extends StatefulWidget {
  EmployeeModel employee;

  @override
  State<StatefulWidget> createState() {
    return UpdateEmployeeState(employee);
  }
  UpdateEmployee(this.employee);
}

Future<EmployeeModel> updateEmployees (EmployeeModel employee, BuildContext context)
async{
  Uri Url=Uri.parse('http://localhost:8080/updateemployee');
  var response = await http.put(Url,
  headers: <String, String>{"Content-Type": "application/json"},
    body: jsonEncode(employee));
  String responseString = response.body;
  if(response.statusCode == 200) {
      showDialog(context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext){
        return MyAlertDialog(title: 'Backend Response', content: response.body);
      });
  }
  throw '';
}

class UpdateEmployeeState extends State<UpdateEmployee> {
  EmployeeModel employee;
  final minimumPadding = 5.0;
  final bool _isEnabled = false;
  TextEditingController employeeNumber=TextEditingController();
  TextEditingController firstController=TextEditingController();
  TextEditingController lastController=TextEditingController();
  late Future<List<EmployeeModel>> employees;


  UpdateEmployeeState (this.employee) {
    employeeNumber = TextEditingController(text: this.employee.id.toString());
    firstController = TextEditingController(text: this.employee.firstName);
    lastController = TextEditingController(text: this.employee.lastName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Employee'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmployeeDrawer()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2,
                        controller: employeeNumber,
                        enabled: _isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your ID';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Employee ID',
                            hintText: 'Enter Employee ID',
                            labelStyle: Theme.of(context).textTheme.subtitle2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2,
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
                            labelStyle: Theme.of(context).textTheme.subtitle2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2,
                        controller: lastController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Enter Your Last Name',
                            labelStyle: Theme.of(context).textTheme.subtitle2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Upadate Details'),

                      onPressed: ()async{
                    String firstName = firstController.text;
                    String lastName = lastController.text;
                    EmployeeModel emp = new EmployeeModel();
                    emp.id = employee.id;
                    emp.firstName = firstName;
                    emp.lastName = lastName;

                    EmployeeModel employees =
                    await updateEmployees(emp, context);
                    setState(() {
                      employee = employees;
                    });
                  })
                ]))));
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
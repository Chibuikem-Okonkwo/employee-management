 import 'package:employee_management/Screen/GetEmployees.dart';
import 'package:employee_management/Screen/RegisterEmployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return employeeDrawerState();
  }
}

class employeeDrawerState extends State<EmployeeDrawer>{
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text('Emlpoyee Management'),
     ),
     body: Center(child: Text('Welcome to Employee Management App')),
     drawer: Drawer(
    child: ListView(
      padding: EdgeInsetsDirectional.only(top: minimumPadding, bottom: minimumPadding),
      children: <Widget>[
        DrawerHeader(
          child: Text('Employee Management'),
          decoration: BoxDecoration(
          color: Colors.blue,
    ),
     ),
       ListTile(
            title: Text('Register Employee'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterEmployee()));
            },
    ),
     ListTile(
       title: Text('Get Employees'),
       onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> GetEmployees()));
       },
     )
    ],
    ))
   );
  }

}
import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screen/EmployeeDrawer.dart';
import 'package:employee_management/Screen/UpdateEmployee.dart';
import 'package:employee_management/Screen/DeleteEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GetEmployees extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return GetAllEmployeesState();
  }
}

class GetAllEmployeesState extends State<GetEmployees>{
  var employees = List<EmployeeModel>.generate(200, (index) => EmployeeModel());

  Future <List<EmployeeModel>>getEmployees()async{

    final url = Uri.parse('http://localhost:8080/getallemployees');
    var data = await http.get(url);
    var jsonData = json.decode(data.body);

    List<EmployeeModel> employees = [];

    for (var e in jsonData){
      EmployeeModel employee = new EmployeeModel();
      employee.id = e["id"];
      employee.firstName = e["firstName"];
      employee.lastName = e["lastName"];
      employees.add(employee);
    }
    return employees;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('All Employees Details'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeDrawer()));
          },
        ),
      ),
      body: Container(
        child:  FutureBuilder(
          future: getEmployees(),
          builder: (BuildContext context ,AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                  title: Text(
                  'ID' + ' ' + 'First Name' + ' ' + 'Last Name'
                  ),
                    subtitle: Text(
                  '${snapshot.data[index].id}'+
                      '${snapshot.data[index].firstName}'+
                      '${snapshot.data[index].lastName}'
                  ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index])));
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget{

  EmployeeModel employee;
  DetailPage(this.employee);

  deleteEmployee1(EmployeeModel employee)async{
    final url = Uri.parse('http://localhost:8080/deleteemployee');
    final request = http.Request("DELETE", url);
    request.headers.addAll((<String, String>{
      "Content-type":"application/json"
    }));
    request.body = jsonEncode(employee);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.firstName),
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateEmployee(employee)));
          }, icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))
        ],
      ),
      body: Container(
        child: Text('First Name' + ' ' + employee.firstName + ' ' + 'Last Name' + ' '+ employee.lastname),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          deleteEmployee1(employee);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteEmployee()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }

}
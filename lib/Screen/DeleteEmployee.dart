import 'dart:convert';

import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Screen/GetEmployees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteEmployee extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DeleteEmployeeState();
  }

}

Future<EmployeeModel> deleteEmployees(String firstName, String lastName)async{
  var Url = Uri.http('localhost:8080', 'deleteemployee');;
  var response = await http.delete(
    Url,
    headers:<String, String>{
      "Content-Type":"application/json;charset=UTF-8,"
    },
  );
  return EmployeeModel.fromJson(jsonDecode(response.body));
}

class DeleteEmployeeState extends State<DeleteEmployee>{
  @override
  Widget build(BuildContext context) {
    return GetEmployees();
  }
  
}
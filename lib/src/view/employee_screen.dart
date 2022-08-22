

import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../businesslogic/employee_response.dart';
import '../providers/db_provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override

  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF09A0A0),
            automaticallyImplyLeading: false,
            title: Text(
              'Search Here..',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {}),
            ],
          ),
          body: _scaffoldBody()),
    );
  }




   Future<List<dynamic>> getAllEmployees() async {
    var url = "http://www.mocky.io/v2/5d565297300000680030a986";
    Response response = await Dio().get(url);
    print(response);
    return (response.data as List).map((EmployeeResponse) {
      DBProvider.db.createEmployee(EmployeeResponse.fromJson(EmployeeResponse)
      );
    }).toList();
  }



  Widget _scaffoldBody(){
    return FutureBuilder<List<dynamic>>(
      future:getAllEmployees(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Employee Details : ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return DividerTemplate();
                  },
                  itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(snapshot.data!.elementAt(index).profileImage.toString()),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data!.elementAt(index).name.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),

                                SizedBox(
                                  height: 3,
                                ),

                                Text(
                                  "${snapshot.data!.elementAt(index).company!.name.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade500,
                                  ),
                                ),

                              ],
                            )
                          ],
                        );
                  },
                  itemCount: snapshot.data!.length,
                ),
              ),
            ],
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },

    );
  }
}


class DividerTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      endIndent: 3,
      indent: 60,
      color: Colors.grey.shade300,
    );
  }
}

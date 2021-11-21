import 'dart:convert';

import 'package:cowin_vaccine_availability/slots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //pata nhi
      // theme: ThemeData(
      //     brightness: Brightness.dark, primarySwatch: Colors.teal), //check out
     theme: ThemeData(
         primarySwatch: Colors.red), //check out
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController daycontroller = TextEditingController();
  String dropdownValue = '01';
  List slots = [];

    void fetch()async{
      await http.get(Uri.parse('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode='+
          pincodecontroller.text+
      '&date='+
          daycontroller.text+
          '-'+
          dropdownValue+
          '-2021'
      )).then((value) {
        Map result = jsonDecode(value.body);
        print(result);
        setState(() {
          slots = result['sessions'];
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Slot(slots:slots,)));
      });

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vaccination Slots'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: pincodecontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter PIN CODE',
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 60,
                        child: TextField(
                          controller: daycontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter DAY',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child:Container(
                          height: 53,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValue,
                            icon: const Icon(
                                Icons.arrow_drop_down_sharp,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 1,
                              color: Colors.white38,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                                            '01',
                                            '02',
                                            '03',
                                            '04',
                                            '05',
                                            '06',
                                            '07',
                                            '08',
                                            '09',
                                            '10',
                                            '11',
                                            '12'
                                                ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                        ),),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: (){
                        fetch();
                      },
                      child: Text('Find Slots'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

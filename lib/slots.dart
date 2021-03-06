import 'package:flutter/material.dart';

class Slot extends StatefulWidget {
  final List slots;

  const Slot({Key? key, required this.slots}) : super(key: key);

  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Slots'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage('assets/vaccine_logo.png')),
        ),
        // padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(
                      10.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Center ID - ' +
                        widget.slots[index]['center_id'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Center Name - ' + widget.slots[index]['name'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Center Address - ' +
                        widget.slots[index]['address'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    'Vaccine Name - ' +
                        widget.slots[index]['vaccine'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    'Slots - ' + widget.slots[index]['slots'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

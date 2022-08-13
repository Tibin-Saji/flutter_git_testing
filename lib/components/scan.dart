import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  
  String id = '';
  bool showDetails = false;
  void qrScan() async{
    var result = await BarcodeScanner.scan();
    print(result.type);
    print(result.rawContent);
    setState(() {
      id = result.rawContent;
      showDetails = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                minWidth: 100,
                child:Text('Scan'),
                color: Colors.blue,
                onPressed: () {
                  qrScan();
                },
              ),
            ],
          ),
          Text(id),
          Text('To Fetch Details when fetch by ID is done'),
        ],
      )
    );
  }
}
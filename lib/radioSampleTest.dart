import 'package:flutter/material.dart';

class RadioSample extends StatefulWidget {
  const RadioSample({Key? key}) : super(key: key);

  @override
  _RadioSampleState createState() => _RadioSampleState();
}

class _RadioSampleState extends State<RadioSample> {

  bool _value = false;
  int val = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Sample'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: RadioListTile(
                  value: 1,
                  groupValue: val,
                  onChanged: (value){
                    setState(() {
                      val=value.toString() as int;
                    });
                  },
                  title: Text('Sample'),
              )
            ),
            Icon(
                Icons.circle_outlined,
            )
          ],
        ),
      ),
    );
  }
}

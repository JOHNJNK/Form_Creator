import 'package:flutter/material.dart';

class RadioSample extends StatefulWidget {
  const RadioSample({Key? key}) : super(key: key);

  @override
  _RadioSampleState createState() => _RadioSampleState();
}

class _RadioSampleState extends State<RadioSample> {
  late int d;
  List<dynamic> data = [
    {'type': 'Question', 'pos': 1, 'ques': 'What is your age??'},
    {
      'type': 'radio',
      'pos': 2,
      'ques': 'Gender',
      'choices': ['Male', 'Female', 'Other']
    },
    {
      'type': 'checkbox',
      'pos': 3,
      'ques': 'Languages Known',
      'options': ['Tamil', 'English', 'Hindi']
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    d=0;
  }

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
                child: Flexible(
                  child: ListView.separated(
                      itemCount: 3,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5.0,
                          ),
                      itemBuilder: (context, index) {
                        //return const Text("1");
                        return RadioListTile(
                          value: index,
                          groupValue: d,
                          onChanged: (value) {
                            setState(() {
                              d=value.toString() as int;
                            });
                          },
                          title: Text('Sample $index'),
                        );
                      }),
                )),
            Container(
                child: Flexible(
                  child: ListView.separated(
                      itemCount: 3,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5.0,
                      ),
                      itemBuilder: (context, index) {
                        bool _checked=false;
                        //return const Text("1");
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _checked,
                          onChanged: (bool ) {

                          },
                          title: Text('Sample $index'),
                        );
                      }),
                )),
            Icon(
              Icons.circle_outlined,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert' show JsonEncoder;

import 'package:flutter/material.dart';
import 'package:form_creater/UserCreatedForm.dart';

class RadioTesting extends StatefulWidget {
  const RadioTesting({Key? key}) : super(key: key);

  @override
  _RadioTestingState createState() => _RadioTestingState();
}

class _RadioTestingState extends State<RadioTesting> {
  var box = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  late int _count;
  String _result = '';
  List<Map<String, dynamic>> _values = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> data = {
      'id': 0,
      'value': 'Created Form',
    };
    _count = 1;
    _values = [data];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM DESIGN'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  _count++;
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                setState(() {
                  _count = 1;
                });
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDevelopedForm(_values)));
              },
              icon: const Icon(Icons.send)),
        ],
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          width: size.width * 1,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: box,
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _count,
                    itemBuilder: (context, index) {
                      return Row2(index);
                    }),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(_result),
            ],
          )),
    );
  }

  _row(int key) {
    return Row(
      children: [
        Text('ID $key'),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(child: TextFormField(
          onChanged: (val) {
            _onUpdate(key, val);
          },
        ))
      ],
    );
  }

  _onUpdate(int key, String val) {
    int foundKey = -1;
    for (var map in _values) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _values.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      'id': key,
      'value': val,
    };
    _values.add(json);
    setState(() {
      _result = _prettyPrint(_values);
    });
  }

  String _prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }
}

class Row2 extends StatefulWidget {
  final int index;
  Row2(this.index, {Key? key}) : super(key: key);

  @override
  _Row2State createState() => _Row2State(key: index);
}

class _Row2State extends State<Row2> {
  int key;

  _Row2State({required this.key});

  int Mcount = 0;
  String _result = '';
  late List<Map<String, dynamic>> options;
  void initState() {
    // TODO: implement initState
    super.initState();
    Mcount = 0;
    options = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Wrap(
            children: [
              Text('Question $key'),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(child: TextFormField(
                onChanged: (val) {
                  _onUpdate2(key, val);
                },
              )),
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Mcount,
                    itemBuilder: (context, index) {
                      return _radio(index);
                    }),
              ),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      Mcount++;
                    });
                  },
                  icon: Icon(Icons.add)),
              Text(_result),
            ],
          )
        ],
      ),
    );
  }

  _radio(int key) {
    return Row(
      children: [
        Icon(Icons.circle_outlined),
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Optioin$key',
          ),
          onChanged: (val) {
            _onUpdate2(key, val);
          },
        )),
      ],
    );
  }

  _onUpdate2(int key, String val) {
    int foundKey = -1;
    for (var map in options) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      options.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      'id': key,
      'value': val,
    };
    options.add(json);
    setState(() {
      _result = _prettyPrint(options);
    });
  }

//Multiple Choice Tag
  String _prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }
}

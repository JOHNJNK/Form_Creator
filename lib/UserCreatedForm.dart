import 'dart:convert';

import 'package:flutter/material.dart';

class UserDevelopedForm extends StatefulWidget {
  final List<Map<String, dynamic>> values;
  const UserDevelopedForm(this.values, {Key? key}) : super(key: key);
  @override
  _UserDevelopedFormState createState() =>
      _UserDevelopedFormState(values: values, count: values.length);
}

class _UserDevelopedFormState extends State<UserDevelopedForm> {
  List<Map<String, dynamic>> values;
  int count;
  _UserDevelopedFormState({required this.values, required this.count});
  String _result = '';
  final List<Map<String, dynamic>> _reply = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hi'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return _quesTag(index, values[index]['value']);
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

  _quesTag(int key, String txt) {
    return Column(
      children: [
        Wrap(
          children: [
            Text('Question No. $key'),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              txt,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        TextFormField(
          onChanged: (val) {
            _onUpdate(key, val);
          },
        )
      ],
    );
  }

  _onUpdate(int key, String val) {
    int foundKey = -1;
    for (var map in _reply) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _reply.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      'id': key,
      'answer': val,
    };
    _reply.add(json);
    setState(() {
      _result = _prettyPrint(_reply);
    });
  }

  String _prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }
}

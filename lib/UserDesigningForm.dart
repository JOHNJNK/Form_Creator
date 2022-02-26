import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_creater/DynamicForm.dart';

class FormCreator extends StatefulWidget {
  const FormCreator({Key? key}) : super(key: key);

  @override
  _FormCreatorState createState() => _FormCreatorState();
}

class _FormCreatorState extends State<FormCreator> {
  var box = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  String _result = '';
  List<dynamic> _values = [];
/*
  Future<void> _refresh() async {
    setState(() {

    });
  }
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _values = [
      // {
      //   'type': 'Heading',
      //   'pos': 1,
      //   'head': 'Untitled',
      //   'desc': 'description was untitled'
      // },
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM DESIGNING'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: () {
              dynamic data={'1':_values};
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  Dynamic_Form(data)));
            },
            icon: const Icon(Icons.send_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _values.length,
                itemBuilder: (context, index){
                  dynamic element = _values[index];
                  String type = element['type'];
                  int pos = element['pos'];
                  if(type=='checkbox'){
                    return CTags(pos, index);
                  }
                  if(type=='radio'){
                    return RTags(pos,index);
                  }
                  return QTags(pos, index);
                  //return Tags(element: element);
                }),
          ),
          const SizedBox(
            height: 10.0,
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  _values.removeLast();
                });
              },
              icon: const Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
          ),
          //Flexible(child: ListView(children: [Text(_result)]),),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              label: 'Radio',
              child: const Icon(Icons.radio_button_checked),
              onTap: () {
                setState(() {
                  int d=_values.length+1;
                  dynamic data={
                    'type':'radio',
                    'pos':d,
                    'ques':'',
                    'choices':[''],
                  };
                  _values.add(data);
                });
              }),
          SpeedDialChild(
              label: 'Checkbox',
              child: const Icon(Icons.check_box_rounded),
              onTap: () {
                setState(() {
                  int d=_values.length+1;
                  dynamic data={
                    'type':'checkbox',
                    'pos':d,
                    'ques':'',
                    'options':[''],
                  };
                  _values.add(data);
                });
              }),
          SpeedDialChild(
            label: 'Short answer ',
            child: const Icon(Icons.short_text_rounded),
            onTap: () async {
              setState(() {
                int d=_values.length+1;
                dynamic data={
                  'type':'Question',
                  'pos':d,
                  'ques':''
                };
                _values.add(data);
              });
            },
          ),
          SpeedDialChild(
              label: 'Heading',
              child: const Icon(Icons.title_rounded),
              onTap: () {
                setState(() {
                  int d=_values.length+1;
                  dynamic data={
                    'type':'Heading',
                    'pos':d,
                    'head':'Untitled',
                    'desc':''
                  };
                  _values.add(data);
                });
              }),
        ],
      ),
    );
  }

  //heading



  //CheckBox

  CTags(key,index){
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: box,
      child: Column(
        children: [
          Row(
            children: [
              Text('Question $key'),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: _values[index]['ques'],
                  onChanged: (val) {
                    _onUpdate(val, index);
                  },
                ),
              ),

            ],
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _values[index]['options'].length,
              itemBuilder: (context, pos){
                //int pos= _values[index]['choices'].length;
                //print(pos);
                return _options(pos, index);
                //return Tags(element: element);
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    var d=_values[index]['options'];
                    d.add('');
                    _values[index]['options']=d;
                  });

                },
                icon: const Icon(Icons.add_circle_outline_rounded),),
              IconButton(
                onPressed: (){
                  setState(() {
                    var d=_values[index]['options'];
                    d.removeLast();
                    _values[index]['options']=d;
                  });
                },
                icon: const Icon(Icons.remove_circle_outline_rounded),),
            ],
          ),
        ],
      ),
    );
  }

  //Radio
  RTags(key,index){
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: box,
      child: Column(
        children: [
          Row(
            children: [
              Text('Question $key'),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: TextFormField(
                    initialValue: _values[index]['ques'],
                    onChanged: (val) {
                      _onUpdate(val, index);
                    },
                  ),
              ),

            ],
          ),
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _values[index]['choices'].length,
                itemBuilder: (context, pos){
                  //int pos= _values[index]['choices'].length;
                  //print(pos);
                  return _choices(pos, index);
                  //return Tags(element: element);
                },
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      var d=_values[index]['choices'];
                      d.add('');
                      _values[index]['choices']=d;
                    });

                  },
                  icon: const Icon(Icons.add_circle_outline_rounded),),
              IconButton(
                onPressed: (){
                  setState(() {
                    var d=_values[index]['choices'];
                    d.removeLast();
                    _values[index]['choices']=d;
                  });
                },
                icon: const Icon(Icons.remove_circle_outline_rounded),),
            ],
          ),
        ],
      ),
    );
  }

  //Text
  QTags(key, index) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: box,
      child: Row(
        children: [
          Text('Question $key'),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
              child: TextFormField(
                initialValue: _values[index]['ques'],
              onChanged: (val) {
              _onUpdate(val, index);
            },
          )),

        ],
      ),
    );
  }

  _onUpdate(String val, int index) {
    setState(() {
      _values[index]['ques'] = val;
      _result = _prettyPrint(_values);
    });
  }

  _onUpdateList(val,index,type,pos){
    setState(() {
      _values[index][type][pos]=val;
      _result = _prettyPrint(_values);
    });
  }

  String _prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }

  //choices

  _choices(pos,index){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 3, 0, 3),
      child: Row(
        children: [
          const Icon(Icons.circle_outlined),
          const SizedBox(width: 5,),
          Expanded(
              child: TextFormField(
                initialValue: _values[index]['choices'][pos],
                onChanged: (val) {
                  _onUpdateList(val, index,'choices',pos);
                },
              )),
        ],
      ),
    );
  }

  //options

  _options(pos,index){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 3, 0, 3),
      child: Row(
        children: [
          const Icon(Icons.check_box_outlined),
          const SizedBox(width: 5,),
          Expanded(
              child: TextFormField(
                initialValue: _values[index]['options'][pos],
                onChanged: (val) {
                  _onUpdateList(val, index,'options',pos);
                },
              )),
        ],
      ),
    );
  }

}

class Tags extends StatefulWidget {
  final dynamic element;
  const Tags({Key? key, required this.element}) : super(key: key);
  @override
  _TagsState createState() => _TagsState(element);
}

class _TagsState extends State<Tags> {
  dynamic element;
  _TagsState(this.element);
  @override
  Widget build(BuildContext context) {
    return Text('$element');
  }
}


/*

          IconButton(
              onPressed: () async {
                setState(() {
                  _values.removeAt(index);
                  int d=0;
                  for(var i in _values){
                    i['pos']=d+1;
                    d++;
                  }
                  _refresh();
                });

              },
              icon: Icon(Icons.remove_circle_outline_rounded))
 */
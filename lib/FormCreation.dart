import 'package:flutter/material.dart';

class FormCreation extends StatefulWidget {
  const FormCreation({Key? key}) : super(key: key);

  @override
  _FormCreationState createState() => _FormCreationState();
}

class _FormCreationState extends State<FormCreation> {
  var box = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  late int _count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = 0;
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
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                setState(() {
                  _count = 0;
                });
              },
              icon: Icon(Icons.refresh)),
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text(
                'Here down your are going to design your forms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
          const Divider(
            thickness: 3.0,
            indent: 30,
            endIndent: 30,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
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
                          return _row(index);
                        }),
                  ),
                ],
              ))
        ],
      ),
    );
  }
  
  _row(int index){
    return Row(
      children: [
        Text('ID'),
        SizedBox(width: 20.0,),
        Expanded(child: TextFormField())
      ],
    );
  }
  
}

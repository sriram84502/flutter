import 'package:flutter/material.dart';

import '../../api/firebaseapi.dart';

class YourName extends StatefulWidget {
  const YourName({Key? key}) : super(key: key);

  @override
  State<YourName> createState() => _YourNameState();
}

class _YourNameState extends State<YourName> {
  final formkey = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstname.text = FirebaseAPIs.me?.name ?? FirebaseAPIs.me!.name;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.close)),
          title: Text('Your name'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      initialValue: FirebaseAPIs.me?.name ?? FirebaseAPIs.me!.name,
                      onSaved: (val) => FirebaseAPIs.me!.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty ? null : 'Required field',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('First name'),
                        labelStyle: TextStyle(
                          color: Colors.white54
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      initialValue: FirebaseAPIs.me?.last ?? FirebaseAPIs.me!.last,
                      onSaved: (val) => FirebaseAPIs.me!.last = val ?? '',
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text('Last name (optional)'),
                          labelStyle: TextStyle(
                              color: Colors.white54
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(formkey.currentState!.validate()){
                formkey.currentState!.save();
                FirebaseAPIs.updateUserinfoname();
                Navigator.pop(context);
              }
            },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/components/decoration.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  // text field state
  String phone_no = '';
  String verificationID = "";
  bool otpVisibility = false;
  String opt_code = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 242, 255, 243),
            appBar: AppBar(
              title: const Text('Add Data'),
              backgroundColor: const Color.fromARGB(255, 71, 143, 75),
              elevation: 0.0
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: textInputDecoration.copyWith( hintText: 'Phone Number'),
                            validator: (val) => val!.isEmpty ? 'Enter a Phone Number' : null,
                            onChanged: (val) {
                              setState(() => phone_no = val);
                              setState(() => error = "");
                            },
                          ),

                          const SizedBox(height: 20.0),
                          ElevatedButton(
                              child: const Text('Submit'),
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 71, 143, 75), // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () async {
                                if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                                  setState(() { loading = true; });

                                }
                              }),

                          const SizedBox(height: 12.0),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                    )

            ),
          );
  }

}

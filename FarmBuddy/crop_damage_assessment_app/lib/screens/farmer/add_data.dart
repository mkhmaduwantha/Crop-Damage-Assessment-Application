import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';
import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/components/decoration.dart';

class FarmerAddData extends StatefulWidget {
  const FarmerAddData({Key? key}) : super(key: key);

  @override
  _FarmerAddDataState createState() => _FarmerAddDataState();
}

class _FarmerAddDataState extends State<FarmerAddData> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  // text field state
  String name = "";
  String email = "";
  String phone_no = "";

  String agrarian_division = "";
  String nic = "";
  String address = "";
  String province = "";

  String bank = "";
  String account_name = "";
  String account_no = "";
  String branch = "";

  String profile_image = "";
  static const List<String> _agrarianDivisionOptions = <String>[
    'galle',
    'matara',
    'kandy'
  ];

  static const List<String> _provinceOptions = <String>[
    'southern',
    'western',
    'east',
    'north'
  ];
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 242, 255, 243),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Add Data'),
              backgroundColor: const Color.fromARGB(255, 105, 184, 109),
              elevation: 0.0,
              actions: <Widget>[
                TextButton.icon(
                    icon: const Icon(Icons.person),
                    label: const Text('logout'),
                    style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      await _auth.signout();
                    })
              ],
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Peronal Details',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 32, 196, 100)),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Name'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter your name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                          setState(() => error = "");
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter your email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                          setState(() => error = "");
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Phone Number'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a Phone Number' : null,
                        onChanged: (val) {
                          setState(() => phone_no = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                        // return _agrarianDivisionOptions
                        //   .where((String continent) => continent.toLowerCase()
                        //     .startsWith(textEditingValue.text.toLowerCase())
                        //   )
                        //   .toList();

                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return _agrarianDivisionOptions.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      }, fieldViewBuilder: (BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          keyboardType: TextInputType.text,
                          decoration: textInputDecoration.copyWith( hintText: 'Agrarian Division'),
                          validator: (val) => agrarian_division.isEmpty ? 'Select your agrarian division' : null,
                          onChanged: (val) {
                            setState(() => agrarian_division = "");
                            setState(() => error = "");
                          },
                        );
                      }, onSelected: (String selection) {
                        setState(() => agrarian_division = selection);
                        setState(() => error = "");
                        // debugPrint('You just selected $selection');
                      }),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'NIC'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter your nic' : null,
                        onChanged: (val) {
                          setState(() => nic = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Address'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter your address' : null,
                        onChanged: (val) {
                          setState(() => address = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                        // return _provinceOptions
                        //   .where((String continent) => continent.toLowerCase()
                        //     .startsWith(textEditingValue.text.toLowerCase())
                        //   )
                        //   .toList();

                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return _provinceOptions.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      }, fieldViewBuilder: (BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          keyboardType: TextInputType.text,
                          decoration: textInputDecoration.copyWith( hintText: 'Province'),
                          validator: (val) => province.isEmpty ? 'Select your province' : null,
                          onChanged: (val) {
                            setState(() => province = "");
                            setState(() => error = "");
                          },
                        );
                      }, onSelected: (String selection) {
                        setState(() => province = selection);
                        setState(() => error = "");
                        // debugPrint('You just selected $selection');
                      }),

                      const SizedBox(height: 40.0), 
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Bank Details',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 32, 196, 100)),
                        ),
                      ),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Bank Name'),
                        validator: (val) => val!.isEmpty ? 'Enter your bank name' : null,
                        onChanged: (val) {
                          setState(() => account_name = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Name in Bank Account'),
                        validator: (val) => val!.isEmpty ? 'Enter your name in bank account' : null,
                        onChanged: (val) {
                          setState(() => bank = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Account No'),
                        validator: (val) => val!.isEmpty ? 'Enter your account no' : null,
                        onChanged: (val) {
                          setState(() => account_no = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Branch Name'),
                        validator: (val) => val!.isEmpty ? 'Enter your branch name' : null,
                        onChanged: (val) {
                          setState(() => branch = val);
                          setState(() => error = "");
                        },
                      ),

                      const SizedBox(height: 20.0),
                      ElevatedButton(
                          child: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(
                                255, 71, 143, 75), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            print("agrarian_division {$agrarian_division}");
                            print(agrarian_division.isEmpty);
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                            }
                          }),
                      const SizedBox(height: 12.0),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/screens/officer/home/officer_dashboard.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crop_damage_assessment_app/components/decoration.dart';

class Filter extends StatefulWidget {
  @override
  const Filter({Key? key, required this.uid}) : super(key: key);
  final String? uid;

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = true;

  final List<String> claim_states = ['Pending', 'Approve', 'Reject'];

  // form values
  late String currentState;
  late String agrarian_division;

  static const List<String> _agrarianDivisionOptions = <String>[
    'galle',
    'matara',
    'kandy'
  ];

  void initFilte() async {
    final preference = await SharedPreferences.getInstance();
    currentState =  preference.getString('claim_state')!;
    agrarian_division = preference.getString('agrarian_division')!;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initFilte();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 242, 255, 243),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Update your view claim settings'),
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
                padding: const EdgeInsets.symmetric( vertical: 20.0, horizontal: 50.0),
                child:
                Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40.0),
                DropdownButtonFormField(
                  value: currentState,
                  decoration: textInputDecoration,
                  items: claim_states.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text(sugar),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      currentState = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return _agrarianDivisionOptions.where((String option) {
                        return option.contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    initialValue: TextEditingValue(text: agrarian_division),
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextFormField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Agrarian Division'),
                        validator: (val) => agrarian_division.isEmpty
                            ? 'Select your agrarian division'
                            : null,
                        onChanged: (val) {
                          setState(() => agrarian_division = "");
                          setState(() => error = "");
                        },
                      );
                    },
                    onSelected: (String selection) {
                      setState(() => agrarian_division = selection);
                      setState(() => error = "");
                      // debugPrint('You just selected $selection');
                    }),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        final preference = await SharedPreferences.getInstance();
                        await preference.setString("claim_state", currentState);
                        await preference.setString( "agrarian_division", agrarian_division);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OfficerDashboard(uid: widget.uid)));
                        
                        // Navigator.popAndPushNamed(context, "/");
                      }
                    }),
              ],
            ),
          )),
          );
  }
}

import 'package:crop_damage_assessment_app/screens/officer/home/officer_dashboard.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/components/decoration.dart';

class Filter extends StatefulWidget {
  @override
  const Filter({Key? key, required this.uid, required this.filter}) : super(key: key);
  final String? uid;
  final filter;

  @override
  _FilterState createState() => _FilterState();

}

class _FilterState extends State<Filter> {

  
  final _formKey = GlobalKey<FormState>();
  String error = "";

  final List<String> claim_states = ['Pending', 'Approve', 'Reject'];

  // form values
  late String currentState;
  late String agrarian_division;

  static const List<String> _agrarianDivisionOptions = <String>[
    'galle',
    'matara',
    'kandy'
  ];

  @override
  void initState() {
    super.initState();
    currentState = widget.filter["claim_state"];
    agrarian_division = widget.filter["agrarian_division"];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40.0),
          const Text(
            'Update your view claim settings',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0),
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
              decoration:
                  textInputDecoration.copyWith(hintText: 'Agrarian Division'),
              validator: (val) => agrarian_division.isEmpty
                  ? 'Select your agrarian division'
                  : null,
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
          ElevatedButton(
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState != null && _formKey.currentState!.validate()) {

                  var update = {"claim_state" : currentState, "agrarian_division": agrarian_division};
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute( builder: (context) => OfficerDashboard(uid: widget.uid, filter: update))
                  );
                  // Navigator.pop(context);
                }
                
              }),
        ],
      ),
    );
  }
}

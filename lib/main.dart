import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convert unities',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body:
            Padding(padding: EdgeInsets.all(8.0), child: FormConvertUnities()),
      ),
    );
  }
}

class FormConvertUnities extends StatefulWidget {
  const FormConvertUnities({super.key});
  @override
  FormConvertUnitiesState createState() {
    return FormConvertUnitiesState();
  }
}

class FormConvertUnitiesState extends State<FormConvertUnities> {
  String? entrerValue = '';
  String? selectedValueFrom = 'Mètre';
  String? selectedValueTo = 'Mètre';
  var listMeasures = [
    'Mètre',
    'Kilomètre',
    'Gramme',
    'Kilogramme',
    'Pied',
    'Mile',
    'Livre',
    'Once'
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Center(
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width / 3,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Entrer un nombre"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  entrerValue = value;
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text('FROM'),
              ),
              SizedBox(
                width: 300,
                child: DropdownButton(
                  // Initial Value
                  value: selectedValueFrom,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: listMeasures.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValueFrom = newValue!;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text('TO'),
              ),
              SizedBox(
                width: 300,
                child: DropdownButton(
                  // Initial Value
                  value: selectedValueTo,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: listMeasures.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValueTo = newValue!;
                    });
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(converting(entrerValue,
                                  selectedValueFrom, selectedValueTo))),
                        );
                      }
                    },
                    child: const Text('Convert'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String converting(
      String? entrerValue, String? selectedValueFrom, String? selectedValueTo) {
    double? result;
    // Conversion 1 Mètre : Mètre 1 / Kilomètre 0.001 / Pied 3.28084 / Mile 0.000621371
    if (entrerValue != '' && selectedValueFrom == 'Mètre') {
      if (selectedValueTo == 'Mètre') {
        result = double.parse(entrerValue!);
      } else if (selectedValueTo == 'Kilomètre') {
        result = double.parse(entrerValue!) / 1000;
      } else if (selectedValueTo == 'Pied') {
        result = double.parse(entrerValue!) * 3.28084;
      } else if (selectedValueTo == 'Mile') {
        result = double.parse(entrerValue!) * 0.000621371;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion Kilomètre 1 : Mètre 1000 / Kilomètre 1 / Pied 3280.84/ Mile 0.621371
    if (entrerValue != '' && selectedValueFrom == 'Kilomètre') {
      if (selectedValueTo == 'Mètre') {
        result = double.parse(entrerValue!) * 1000;
      } else if (selectedValueTo == 'Kilomètre') {
        result = double.parse(entrerValue!);
      } else if (selectedValueTo == 'Pied') {
        result = double.parse(entrerValue!) * 3280.84;
      } else if (selectedValueTo == 'Mile') {
        result = double.parse(entrerValue!) * 0.621371;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion Gramme 1 : Gramme 1 / Kilomètre 0.001 / Livre 0.00220462 / Once 0.03527396
    if (entrerValue != '' && selectedValueFrom == 'Gramme') {
      if (selectedValueTo == 'Gramme') {
        result = double.parse(entrerValue!);
      } else if (selectedValueTo == 'Kilomètre') {
        result = double.parse(entrerValue!) / 1000;
      } else if (selectedValueTo == 'Livre') {
        result = double.parse(entrerValue!) * 0.00220462;
      } else if (selectedValueTo == 'Once') {
        result = double.parse(entrerValue!) * 0.03527396;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion KiloGramme 1 : Gramme 1000 / Kilomètre 1 / Livre 2.20462 / Once 35.27396
    if (entrerValue != '' && selectedValueFrom == 'Kilogramme') {
      if (selectedValueTo == 'Gramme') {
        result = double.parse(entrerValue!) * 1000;
      } else if (selectedValueTo == 'Kilomètre') {
        result = double.parse(entrerValue!);
      } else if (selectedValueTo == 'Livre') {
        result = double.parse(entrerValue!) * 2.20462;
      } else if (selectedValueTo == 'Once') {
        result = double.parse(entrerValue!) * 35.27396;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion Pied 1 : Mètre 0.3048 / Kilomètre 1 / Pied 1 / Mile 0.000189394
    if (entrerValue != '' && selectedValueFrom == 'Pied') {
      if (selectedValueTo == 'Gramme') {
        result = double.parse(entrerValue!) * 0.3048;
      } else if (selectedValueTo == 'Kilomètre') {
        result = double.parse(entrerValue!) * 0.0003048;
      } else if (selectedValueTo == 'Pied') {
        result = double.parse(entrerValue!);
      } else if (selectedValueTo == 'Mile') {
        result = double.parse(entrerValue!) * 0.000189394;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion Mile 1 : Mètre 1609.34 / Kilomètre 1.60934 / Pied 5280 / Once 35.27396
    if (entrerValue != '' && selectedValueFrom == 'Mile') {
      if (selectedValueTo == 'Mètre') {
        result = double.parse(entrerValue!) * 1609.34;
      } else if (selectedValueTo == 'Kilomètre') {
        result = double.parse(entrerValue!) * 1.60934;
      } else if (selectedValueTo == 'Pied') {
        result = double.parse(entrerValue!) * 5280;
      } else if (selectedValueTo == 'Mile') {
        result = double.parse(entrerValue!) * 1;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion Livre 1 : Mètre 1609.34 / Kilomètre 1.60934 / Pied 5280 / Once 35.27396
    if (entrerValue != '' && selectedValueFrom == 'Livre') {
      if (selectedValueTo == 'Gramme') {
        result = double.parse(entrerValue!) * 453592;
      } else if (selectedValueTo == 'Kilogramme') {
        result = double.parse(entrerValue!) * 0.453582;
      } else if (selectedValueTo == 'Livre') {
        result = double.parse(entrerValue!);
      } else if (selectedValueTo == 'Once') {
        result = double.parse(entrerValue!) * 16;
      } else {
        return 'This conversion cannot be performed';
      }
    }
    // Conversion Once 1 : Gramme 28.3495 / Kilogramme 0.0283495 / Livre 0.0625 / Once 1
    if (entrerValue != '' && selectedValueFrom == 'Livre') {
      if (selectedValueTo == 'Gramme') {
        result = double.parse(entrerValue!) * 453592;
      } else if (selectedValueTo == 'Kilogramme') {
        result = double.parse(entrerValue!) * 0.0283495;
      } else if (selectedValueTo == 'Livre') {
        result = double.parse(entrerValue!) * 0.0625;
      } else if (selectedValueTo == 'Once') {
        result = double.parse(entrerValue!);
      } else {
        return 'This conversion cannot be performed';
      }
    }
    return '$entrerValue $selectedValueFrom are $result $selectedValueTo';
  }
}

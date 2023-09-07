import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import '../../../../utils/globalVariables.dart';

const List<String> ColorPatterns = <String>['1', '2','3','4'];

class ThemeColorWidget extends StatefulWidget {
  const ThemeColorWidget({super.key});

  @override
  State<ThemeColorWidget> createState() => _ThemeColorWidgetState();
}

class _ThemeColorWidgetState extends State<ThemeColorWidget> {
  String selectedColor = ColorPatterns.first;

  void SetColor() {
    setState(() {
      if(selectedColor == '1') {
        SelectedMainColor = MainColor1;
        SelectedSecondaryColor = SecondaryColor1;
        SelectedHeadlineColor = HeadlineColor1;
        SelectedTextColor = TextColor1;
      } else if(selectedColor == '2') {
        SelectedMainColor = MainColor2;
        SelectedSecondaryColor = SecondaryColor2;
        SelectedHeadlineColor = HeadlineColor2;
        SelectedTextColor = TextColor2;
      } else if(selectedColor == '3') {
        SelectedMainColor = MainColor3;
        SelectedSecondaryColor = SecondaryColor3;
        SelectedHeadlineColor = HeadlineColor3;
        SelectedTextColor = TextColor3;
      } else if(selectedColor == '4') {
        SelectedMainColor = MainColor4;
        SelectedSecondaryColor = SecondaryColor4;
        SelectedHeadlineColor = HeadlineColor4;
        SelectedTextColor = TextColor4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Select Color Theme'),
      backgroundColor: SelectedMainColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: SelectedMainColor,
                      border: Border.all(
                        color: Colors.black,
                        width: 2
                      )
                    ),
                    child: const Text(
                      'Main Color',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: SelectedSecondaryColor,
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: const Text(
                      'Secondary Color',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: SelectedTertiaryColor,
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: const Text(
                      'Tertiary Color',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: SelectedHeadlineColor,
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: const Text(
                        'Headline Color',
                        textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: SelectedTextColor,
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: const Text(
                      'Text Color',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                alignment: Alignment.center,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                    contentPadding: EdgeInsets.only(left: 25),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        dropdownColor: SelectedSecondaryColor,
                        alignment: Alignment.center,
                        value: selectedColor,
                        iconSize: 16,
                        isExpanded: true,
                        iconEnabledColor: SelectedSecondaryColor,
                        style: TextStyle(
                          color: SelectedTextColor,
                        ),
                        items: ColorPatterns
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            // This is called when the user selects an item.
                            selectedColor = value!;
                          });
                        }),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => SetColor(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(SelectedSecondaryColor),
                  ),
                  child: Text(
                    'Try it out',
                    style: TextStyle(
                      color: SelectedTextColor,
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}

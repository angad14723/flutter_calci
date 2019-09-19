import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "calculator",
    home: ISForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class ISForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ISFormState();
  }
}

class _ISFormState extends State<ISForm> {
  var formKey = GlobalKey<FormState>();

  var currencies = ["Rupees", "Dallors", "Pounds"];
  final double _minimumPadding = 5.0;

  var currentSelected = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSelected = currencies[0];
  }

  TextEditingController pTextEditCont = TextEditingController();
  TextEditingController rTextEditCont = TextEditingController();
  TextEditingController tTextEditCont = TextEditingController();

  var displayresult = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest App"),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: pTextEditCont,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "please enter principal amount";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        hintText: "Enter Principal e.g. 1000",
                        labelStyle: textStyle,
                        errorStyle:
                            TextStyle(color: Colors.amber, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(_minimumPadding))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: rTextEditCont,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "please enter rate";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "In percent",
                        labelStyle: textStyle,
                        errorStyle:
                            TextStyle(color: Colors.amber, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(_minimumPadding))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: tTextEditCont,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "please enter time";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Time",
                            hintText: "Time in year",
                            labelStyle: textStyle,
                            errorStyle:
                                TextStyle(color: Colors.amber, fontSize: 15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(_minimumPadding))),
                      )),

                      Container(
                        width: _minimumPadding * 5,
                      ),


                      Expanded(
                          child: DropdownButton<String>(
                        items: currencies.map((String Value) {
                          return DropdownMenuItem<String>(
                            value: Value,
                            child: Text(
                              Value,
                              textScaleFactor: 1.2,
                            ),
                          );
                        }).toList(),

                        value: currentSelected,
                        onChanged: (String newValueSelected) {
                          onDropDownItemSelected(newValueSelected);
                        },
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text(
                                "Calculate",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (formKey.currentState.validate()) {

                                    this.displayresult = calculateTotalReturns();
                                  }
                                });
                              })),
                      Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                "Reset",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                resetAll();
                              }))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Text(
                    this.displayresult,
                    style: textStyle,

                  ),
                )
              ],
            ),
          ),
        ));
  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentSelected = newValueSelected;
    });
  }

  String calculateTotalReturns() {
    double principle = double.parse(pTextEditCont.text);
    double rate = double.parse(rTextEditCont.text);
    double time = double.parse(tTextEditCont.text);

    double totalAmount = principle + (principle * rate * time) / 100;

    String result =
        "After $time years, your investment will be $totalAmount $currentSelected";

    return result;
  }

  void resetAll() {
    pTextEditCont.text = "";
    rTextEditCont.text = "";
    tTextEditCont.text = "";
    displayresult = "";

    currentSelected = currencies[0];
  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage("images/interest.png");
  Image image = Image(
    image: assetImage,
    width: 125.0,
    height: 125.0,
  );

  return Container(
    child: image,
    margin: EdgeInsets.all(_ISFormState()._minimumPadding * 10),
  );
}

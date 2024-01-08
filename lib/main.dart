import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Country Selector'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SingleValueDropDownController _cnt;
  late SingleValueDropDownController _cntState;
  late SingleValueDropDownController _cntCity;

  List stateList = [];
  List cityList = [];

  @override
  void initState() {
    super.initState();
    _cnt = SingleValueDropDownController();
    _cntState = SingleValueDropDownController();
    _cntCity = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    var stateDrop = <DropDownValueModel>[];
    for (var element in stateList) {
      stateDrop.add(DropDownValueModel(name: element, value: element));
    }
    var cityDrop = <DropDownValueModel>[];
    for (var element in cityList) {
      cityDrop.add(DropDownValueModel(name: element, value: element));
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text("Select Country"),
              ),
              DropDownTextField(
                controller: _cnt,
                clearOption: false,
                searchDecoration: const InputDecoration(
                    hintText: "enter your custom hint text here"),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: 2,
                dropDownList: const [
                  DropDownValueModel(name: 'USA', value: "USA"),
                  DropDownValueModel(name: 'India', value: "India"),
                ],
                onChanged: (val) {
                  setState(() {
                    stateList.clear();
                    cityList.clear();
                    _cntState.clearDropDown();
                    _cntCity.clearDropDown();
                    if (val.name == 'USA') {
                      stateList.add("California");
                      stateList.add("New York");
                    } else {
                      stateList.add("Maharashtra");
                    }
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text("Select State"),
              ),
              DropDownTextField(
                controller: _cntState,
                clearOption: false,
                searchDecoration: const InputDecoration(
                    hintText: "enter your custom hint text here"),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: stateList.length,
                dropDownList: stateDrop,
                onChanged: (val) {
                  setState(() {
                    cityList.clear();
                    _cntCity.clearDropDown();
                    if (val.name == 'California') {
                      cityList.add("Los Angeles");
                      cityList.add("San Francisco");
                      cityList.add("San Diego");
                    } else if (val.name == 'New York') {
                      cityList.add("New York City");
                      cityList.add("Buffalo");
                      cityList.add("Albany");
                    } else if (val.name == "Maharashtra") {
                      cityList.add("Mumbai");
                      cityList.add("Pune");
                      cityList.add("Nagpur");
                    }
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text("Select City"),
              ),
              DropDownTextField(
                controller: _cntCity,
                clearOption: false,
                searchDecoration: const InputDecoration(
                    hintText: "enter your custom hint text here"),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: cityDrop.length,
                dropDownList: cityDrop,
                onChanged: (val) {},
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

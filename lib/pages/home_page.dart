// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:actualprojectforril/firebase_service.dart';
import 'package:actualprojectforril/pages/choice_page.dart';
import 'package:actualprojectforril/widgets/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.curremail,
  });
  final String curremail;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateBalance() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _afk = true;
      });
      try {
        currData.balance =
            (currData.balance! + double.parse(_balanceController.text));
        firebaseService.updateData(currData);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('An error occured')));
      } finally {
        setState(() {
          _afk = false;
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _usernameTransferController =
      TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _payController = TextEditingController();
  final TextEditingController _transferController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? nama;
  bool _afk = false;
  late Data currData;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Texture2.jpg"),
            fit: BoxFit.cover,
            opacity: 0.35,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 16.0),
            child: StreamBuilder(
              stream: firebaseService.getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<Data> datas = snapshot.data!;
                Data currData = datas[datas
                    .indexWhere((datas) => datas.email == widget.curremail)];
                nama = currData.name;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22.0),
                                )),
                            Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${currData.name}",
                                      style: const TextStyle(
                                          fontSize: 44.0, color: Colors.orange),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Profile"),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Id : ${currData.id}"),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Name : ${currData.name}"),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  var dialogContext =
                                                                      context;
                                                                  return AlertDialog(
                                                                    title:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(dialogContext);
                                                                            },
                                                                            icon:
                                                                                const Icon(Icons.close)),
                                                                        const Text(
                                                                          "Change \nUsername",
                                                                        )
                                                                      ],
                                                                    ),
                                                                    content: Column(
                                                                        children: [
                                                                          Form(
                                                                              key: _formKey,
                                                                              child: Column(
                                                                                children: [
                                                                                  TextFormField(
                                                                                    controller: _usernameController,
                                                                                    decoration: const InputDecoration(
                                                                                      hintText: "Input your new name here",
                                                                                      hintStyle: TextStyle(fontSize: 12.0),
                                                                                      errorStyle: TextStyle(color: Color.fromARGB(255, 255, 161, 154)),
                                                                                      focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 161, 154))),
                                                                                      errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 161, 154))),
                                                                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                    ),
                                                                                    validator: (value) {
                                                                                      if (value == null || value.isEmpty) {
                                                                                        return "Please input your new name";
                                                                                      }
                                                                                      if (value.length < 6) {
                                                                                        return "Please input a longer username";
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                  _afk
                                                                                      ? const CircularProgressIndicator()
                                                                                      : Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: ElevatedButton(
                                                                                            onPressed: () {
                                                                                              currData.name = _usernameController.text;
                                                                                              firebaseService.updateData(currData);
                                                                                              Navigator.pop(dialogContext);
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                                                                            child: const Text(
                                                                                              "Update",
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                ],
                                                                              )),
                                                                        ]),
                                                                  );
                                                                });
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .drive_file_rename_outline_rounded,
                                                            color: Colors.black,
                                                          ))
                                                    ],
                                                  ),
                                                  Text("Age : ${currData.age}"),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Number : ${currData.number}"),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  var dialogContext =
                                                                      context;
                                                                  return AlertDialog(
                                                                    title:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(dialogContext);
                                                                            },
                                                                            icon:
                                                                                const Icon(Icons.close)),
                                                                        const Text(
                                                                          "Change \nNumber",
                                                                        )
                                                                      ],
                                                                    ),
                                                                    content: Column(
                                                                        children: [
                                                                          Form(
                                                                              key: _formKey,
                                                                              child: Column(
                                                                                children: [
                                                                                  TextFormField(
                                                                                    controller: _numberController,
                                                                                    decoration: const InputDecoration(
                                                                                      hintText: "Input your new number here",
                                                                                      hintStyle: TextStyle(fontSize: 12.0),
                                                                                      errorStyle: TextStyle(color: Color.fromARGB(255, 255, 161, 154)),
                                                                                      focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 161, 154))),
                                                                                      errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 161, 154))),
                                                                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                    ),
                                                                                    validator: (value) {
                                                                                      if (value == null || value.isEmpty) {
                                                                                        return "Please input your new number";
                                                                                      }
                                                                                      if (value.length < 6) {
                                                                                        return "number is invalid";
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                  _afk
                                                                                      ? const CircularProgressIndicator()
                                                                                      : Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: ElevatedButton(
                                                                                            onPressed: () {
                                                                                              currData.number = int.parse(_numberController.text);
                                                                                              firebaseService.updateData(currData);
                                                                                              Navigator.pop(dialogContext);
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                                                                            child: const Text(
                                                                                              "Update",
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                ],
                                                                              )),
                                                                        ]),
                                                                  );
                                                                });
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .drive_file_rename_outline_rounded,
                                                            color: Colors.black,
                                                          ))
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      _auth.signOut();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ChoicePage()));
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .exit_to_app_rounded,
                                                          color: Colors.red,
                                                        ),
                                                        Text(
                                                          " Sign Out Account",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      _auth.currentUser?.delete();
                                                      firebaseService
                                                          .deleteData(
                                                              currData.id!);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ChoicePage()));
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                        Text(
                                                          " Delete Account",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.account_circle,
                                      size: 44.0,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 360.0,
                        height: 240.0,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/card.png"))),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${currData.balance}",
                                        style: const TextStyle(fontSize: 36.0),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          child: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      var dialogContext =
                                                          context;
                                                      return AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    dialogContext);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close),
                                                            ),
                                                            const Text(
                                                                "Add Balance"),
                                                          ],
                                                        ),
                                                        content: Column(
                                                          children: [
                                                            Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  children: [
                                                                    TextFormField(
                                                                      controller:
                                                                          _balanceController,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        hintText:
                                                                            "Input your new income here",
                                                                        hintStyle:
                                                                            TextStyle(fontSize: 12.0),
                                                                        errorStyle: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                161,
                                                                                154)),
                                                                        focusedErrorBorder:
                                                                            UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 161, 154))),
                                                                        errorBorder:
                                                                            UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 161, 154))),
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                      ),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return "Please input your new income here";
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                    _afk
                                                                        ? const CircularProgressIndicator()
                                                                        : Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {
                                                                                currData.balance = (currData.balance! + double.parse(_balanceController.text));
                                                                                firebaseService.updateData(currData);
                                                                                Navigator.pop(dialogContext);
                                                                                // updateBalance();
                                                                              },
                                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                                                              child: const Text(
                                                                                "Add",
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                            ),
                                                                          )
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              )),
                                        ),
                                      )
                                    ],
                                  )),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                                  child: Text(
                                    "Rp",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(122, 0, 0, 0)),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 30.0),
                                  child: Text(
                                    "${currData.email}",
                                    style: const TextStyle(
                                        color: Color.fromARGB(140, 0, 0, 0)),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var dialogContext = context;
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(dialogContext);
                                                },
                                                icon: const Icon(Icons.close)),
                                            const Text("Payment")
                                          ],
                                        ),
                                        content: Column(children: [
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: _payController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Input your transaction amount here",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0),
                                                      errorStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              161,
                                                              154)),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          161,
                                                                          154))),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          161,
                                                                          154))),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Please input your transaction amount";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  _afk
                                                      ? const CircularProgressIndicator()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              currData
                                                                  .balance = (currData
                                                                      .balance! -
                                                                  double.parse(
                                                                      _payController
                                                                          .text));
                                                              firebaseService
                                                                  .updateData(
                                                                      currData);
                                                              Navigator.pop(
                                                                  dialogContext);
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .orange),
                                                            child: const Text(
                                                              "Update",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              )),
                                        ]),
                                      );
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.qr_code_scanner_rounded,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      "Pay",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var dialogContext = context;
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(dialogContext);
                                                },
                                                icon: const Icon(Icons.close)),
                                            const Text("Transfer")
                                          ],
                                        ),
                                        content: Column(children: [
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        _usernameTransferController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Input your username destination here",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0),
                                                      errorStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              161,
                                                              154)),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          161,
                                                                          154))),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          161,
                                                                          154))),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Please input your transfer destination's name";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _transferController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Input your transfer amount here",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0),
                                                      errorStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              161,
                                                              154)),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          161,
                                                                          154))),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          161,
                                                                          154))),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Please input your transfer amount";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  _afk
                                                      ? const CircularProgressIndicator()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Data
                                                                  transferData =
                                                                  datas[datas.indexWhere((datas) =>
                                                                      datas
                                                                          .name ==
                                                                      _usernameTransferController
                                                                          .text)];
                                                              currData
                                                                  .balance = (currData
                                                                      .balance! -
                                                                  double.parse(
                                                                      _transferController
                                                                          .text));
                                                              transferData
                                                                  .balance = (transferData
                                                                      .balance! +
                                                                  double.parse(
                                                                      _transferController
                                                                          .text));
                                                              firebaseService
                                                                  .updateData(
                                                                      currData);
                                                              firebaseService
                                                                  .updateData(
                                                                      transferData);
                                                              Navigator.pop(
                                                                  dialogContext);
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .orange),
                                                            child: const Text(
                                                              "Transfer",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              )),
                                        ]),
                                      );
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.swap_horiz_rounded,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      "Transfer",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // Wanted to use this, but there was no items left, so i settled with a container at the end
          // bottomNavigationBar: BottomNavigationBar(
          //   items: [
          //     BottomNavigationBarItem(icon: Icon(Icons.scanner), label: 'Pay'),
          //     BottomNavigationBarItem(icon: Icon(Icons.scanner), label: 'Pay'),
          //     BottomNavigationBarItem(icon: Icon(Icons.scanner), label: 'Pay'),
          //   ]
          // ),
        ),
      ),
    ]);
  }
}

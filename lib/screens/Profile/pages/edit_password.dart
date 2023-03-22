import 'package:flutter/material.dart';
import '../user/user_data.dart';
import '../widgets/appbar_widget.dart';

class EditPasswordFormPage extends StatefulWidget {
  const EditPasswordFormPage({Key? key}) : super(key: key);
  @override
  EditPasswordFormPageState createState() {
    return EditPasswordFormPageState();
  }
}

class EditPasswordFormPageState extends State<EditPasswordFormPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void updateUserValue(String password) {
    user.Password = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 320,
                    child: Text(
                      "What's Your Password?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red
                          ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(

                          style: TextStyle(color: Colors.red),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 10) {
                              return 'Please enter a VALID password';
                            }
                            return null;
                          },
                          cursorColor:Colors.white60,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Your Password',
                          ),
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                             primary:   Colors.red,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate() ){
                                updateUserValue(passwordController.text);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}

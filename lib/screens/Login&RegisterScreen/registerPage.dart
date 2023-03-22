import 'package:cut/screens/Profile/user/user_data.dart';
import 'package:flutter/material.dart';
import 'package:cut/screens/Login&RegisterScreen/Login.dart';
import 'package:page_transition/page_transition.dart';
import '../../Local/Signin&register/Helper.dart';
import '../../Local/Signin&register/dbHelper.dart';
import 'Textformfield.dart';
import 'UserModel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  final user = UserData.myUser;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = Dbhelper();
  }

  void updateUserEmail(String email) {
    user.email = email;
  }

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  bool validatePassword(String pass) {
    String _password = pass.trim();

    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }

  signUp() async {
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    bool result = validatePassword(passwd);
      if (passwd != cpasswd) {
        alertDialog(this.context, 'Password Mismatch');
      }
      else if(!result){
        alertDialog(this.context,"Password should contains Capital, small letter & Number & Special");
      }
      else {
        _formKey.currentState!.save();
        UserModel uModel = UserModel(uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(this.context, "Successfully Saved");
          updateUserEmail(_conEmail.text);
          Navigator.push(
              this.context, MaterialPageRoute(builder: (_) => const Login()));
        }).catchError((error) {
          print(error);
          alertDialog(this.context, "Error: Data Save Fail");
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 35,),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Icon(Icons.how_to_reg, size: 100, color: Colors.red,),
                  ),
                  const SizedBox(height: 5,),
                  Text('Sign Up Now!', style: TextStyle(fontSize: 50, color: Colors.red),),
                  const SizedBox(height: 15,),
                  GetTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  const SizedBox(height: 10.0),
                  GetTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  const SizedBox(height: 10.0),
                  GetTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  GetTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextButton(
                      onPressed: signUp,
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xffE72626), borderRadius: BorderRadius.circular(12.0)),
                        child:  const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('Register', style: TextStyle(fontSize: 20, color: Colors.white) ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Does you have an account? ', style: Theme.of(context).textTheme.bodySmall,),
                TextButton(
                  child: const Text('Sign In', style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(child: const Login(), type: PageTransitionType.fade),
                            (Route<dynamic> route) => false);
                  },
                )
              ],
            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


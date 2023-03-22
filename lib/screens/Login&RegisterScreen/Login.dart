import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cut/screens/Login&RegisterScreen/registerPage.dart';
import 'package:page_transition/page_transition.dart';
import '../../Local/Signin&register/Helper.dart';
import '../../Local/Signin&register/dbHelper.dart';
import '../Profile/user/user_data.dart';
import '../tabsscreen.dart';
import 'Textformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Duration duration = const Duration(milliseconds: 800);

  String UserName = '';
  String Password = '';

  final _UserNameController = TextEditingController();
  final _PasswordController = TextEditingController();
  var DbHelper;
  final user = UserData.myUser;

  @override
  void initState() {
    DbHelper = Dbhelper();
    super.initState();
  }

  void updateUserValue(String name) {
    user.name = name;
  }

  void updateUserPassword(String Password) {
    user.Password = Password;
  }

  login() async {
    String UserName = _UserNameController.text;
    String Password = _PasswordController.text;

    if (UserName.isEmpty) {
      alertDialog(context, "Please Enter User Name");
    } else if (Password.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await DbHelper.getLoginUser(UserName, Password).then((userData) {
        if (userData != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const TabsScreen()),
          );
          updateUserValue(_UserNameController.text);
          updateUserPassword(_PasswordController.text);
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        alertDialog(context, "Error: Login Fail");
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,
      body:
      SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                 Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[400],
                        radius: 100,
                      backgroundImage: AssetImage('assets/image/log.jpg'),
                ),
                 ),
                const SizedBox(height: 8,),
                GetTextFormField(
                    controller: _UserNameController,
                    icon: Icons.person,
                    hintName: 'User Name'),
                const SizedBox(height: 10.0),
                GetTextFormField(
                  controller: _PasswordController,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextButton(
                    onPressed: login,
                    child: Container(
                      decoration: BoxDecoration(color: const Color(0xffE72626), borderRadius: BorderRadius.circular(12.0)),
                      child:  const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                          child: Text('Sign In', style: TextStyle(fontSize: 20, color: Colors.white) ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children:  [
                       Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('or log in with', style: Theme.of(context).textTheme.titleSmall,),
                      ),
                      /// GOOGLE BTN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInUp(
                            duration: duration,
                            delay: const Duration(milliseconds: 600),
                            child: SButton(
                              size: MediaQuery.of(context).size,
                              borderColor: Colors.grey,
                              color: Colors.white,
                              img: 'assets/image/g.png',
                              textStyle: null,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /// GITHUB BTN
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FadeInUp(
                              duration: duration,
                              delay: const Duration(milliseconds: 200),
                              child: SButton(
                                size: MediaQuery.of(context).size,
                                borderColor: Colors.white,
                                color: const Color.fromARGB(255, 54, 54, 54),
                                img: 'assets/image/Gt.png',
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                  ),
                ),
                 const SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Don't have an account?", style: Theme.of(context).textTheme.bodySmall),
                    TextButton( onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RegisterPage()));
                    }, child: const Text(' Register Now', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),) ,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class SButton extends StatelessWidget {
  const SButton({
    Key? key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.img,
    // required this.text,
    required this.textStyle,
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;
  final String img;
  // final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 60,
          height: size.height / 15,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor, width: 0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    img,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   text,
              //   style: textStyle,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

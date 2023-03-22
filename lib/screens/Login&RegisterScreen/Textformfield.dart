import 'package:flutter/material.dart';

import '../../Local/Signin&register/Helper.dart';



class GetTextFormField extends StatefulWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;

  GetTextFormField(
      {required this.controller,
        required this.hintName,
        required this.icon,
        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.isEnable = true});

  @override
  State<GetTextFormField> createState() => _GetTextFormFieldState();
}

class _GetTextFormFieldState extends State<GetTextFormField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white54),
        controller: widget.controller,
        obscureText: widget.isObscureText,
        enabled: widget.isEnable,
        keyboardType: widget.inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.hintName}';
          }
          if (widget.hintName == "Email" && !validateEmail(value)) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          prefixIcon: Icon(widget.icon, color: Colors.red,),
          hintText: widget.hintName,
          labelText: widget.hintName,
            labelStyle: TextStyle(
                color: Colors.white,
            ),
          fillColor: Color(0xff191A32),
          filled: true,
        ),
      ),
    );
  }
}
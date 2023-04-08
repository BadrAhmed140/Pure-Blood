import 'package:flutter/material.dart';

class DrawerListTitle extends StatelessWidget {
  String text;
   Function ()on_tab;


  String text_icon;
  DrawerListTitle({required this.text,required this.text_icon,required this.on_tab});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(text_icon,height: 30,),
      title:  Text(text,style: TextStyle(fontSize: 20,color: Color(0xff484847)),),
      onTap: on_tab
      ,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pure_blood/blocs/sign_up/sign_up_cubit.dart';

class DropDownButton extends StatelessWidget {
  Widget ?icon;
 List items;
 String bloodTypeController;
 void Function(String?)? onChanged;
 DropDownButton({this.icon,required this.items,required this.onChanged,required this.bloodTypeController});

@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(

        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit =SignUpCubit.get(context);
          return DropdownButtonFormField(
            hint: Center(child: Text('Blood Type',
              textAlign: TextAlign.center,
            ),),
            isExpanded: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(right: 10, left: 10),
prefixIcon: icon,

                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.white, width: 2)),focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: Colors.white, width: 2)), ),

            // Initial Value


            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: cubit.items.map((String items) {
              return DropdownMenuItem(

                  value: items,
                  child: Center(
                    child: Text(items,
                      textAlign: TextAlign.center,
                    ),
                  )
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: onChanged,
          );
        },
      ),
    );
  }


}

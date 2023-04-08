import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodBanksItem extends StatelessWidget {
  String? bankName;
  String ?bankAddress;
  String? bloodPhone;
  String? bloodLate;
  String? bloodLOng;

  BloodBanksItem({required this.bankName,required this.bankAddress,required this.bloodPhone,
      required this.bloodLate,required this.bloodLOng});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(bankName!,
                            style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20) ),
                        SizedBox(height: 10,),
                        Text(bankAddress!,
                            style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color:Colors.grey),maxLines: 2, ),
                        SizedBox(height: 10,),
                        Text(bloodPhone!,
                            style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.grey) ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      IconButton(onPressed: () async{
                        await launchUrl(Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=$bloodLate,$bloodLOng'));
                      },
                        icon:  Icon(Icons.location_on,color: Colors.red,size: 30,),),
                      SizedBox(height: 5,)
                      ,  IconButton(onPressed: (){
                        launchUrl(Uri.parse('tel:0020223067459'));


                      },
                        icon:  Icon(Icons.phone,color: Colors.red,size: 30,),)



                    ],
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          )

      ),
    );
  }


}

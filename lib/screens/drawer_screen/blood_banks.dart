import 'package:flutter/material.dart';
import 'package:pure_blood/components/blood_banks_item.dart';
import 'package:pure_blood/models/blood%20_banks_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodBanks extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Blood Banks'),
        centerTitle: true,
      ),
      body: ListView.builder(itemCount: AllBanks.length,
      itemBuilder:(BuildContext context,int index){
        return BloodBanksItem(bankName:AllBanks[index].bankName ,
            bankAddress:AllBanks[index].bankAddress,
            bloodPhone: AllBanks[index].bloodPhone,
          bloodLate: AllBanks[index].bloodLate,
            bloodLOng: AllBanks[index].bloodLong,
           );
      } ,
      )
    );
  }
List<BloodBanksModel> AllBanks=[
  BloodBanksModel(bankName: 'National Center for Blood Transfusion', bankAddress: '51 Ministry of Agriculture Street, Agouza, Giza',
      bloodPhone:'02 37611111', bloodLate:'30.0503246', bloodLong: '31.2097237'),
  BloodBanksModel(bankName: 'Main Blood Bank - Ain Shams', bankAddress: 'Al-Dumdash Hospital, Abbasiyah Al-Qubayliyah, Waily, Cairo Governorate',
      bloodPhone:'No Number', bloodLate:'30.0681329', bloodLong: '31.2775123'),
  BloodBanksModel(bankName: 'Egyptian Red Crescent', bankAddress: 'CAIRO, EL AZBAKEYA',
      bloodPhone:'02 25761587', bloodLate:'30.0601234', bloodLong: '31.2466433'),
  BloodBanksModel(bankName: 'Armed Forces Laboratory for Medical Research and Blood Bank', bankAddress: 'Caliph al-Maamun, Manshiyet al-Bakri, Heliopolis, Cairo Governorate',
      bloodPhone:'01014705177', bloodLate:'30.0859146', bloodLong: '31.3020149'),
  BloodBanksModel(bankName: 'Regional Center for Blood Transfusion in Dar Al Salam', bankAddress: 'Corniche El Nil, Old Egypt, Cairo Governorate',
      bloodPhone:'02 23619402', bloodLate:'30.012301', bloodLong: '31.2305774'),
  BloodBanksModel(bankName: 'Blood Bank - Agricultural Hospital', bankAddress: 'Dokki, Giza',
      bloodPhone:'02 37493226', bloodLate:'30.0423926', bloodLong: '31.212814'),
  BloodBanksModel(bankName: 'Blood Bank - Banha University Hospital', bankAddress: 'Farid Nada Street',
      bloodPhone:'013 3228632', bloodLate:'30.4702587', bloodLong: '31.1786449'),
  BloodBanksModel(bankName: 'Regional Center for blood transfusion in Shebin El Koum', bankAddress: 'Shebin El Koum Division, Shebein El Kawm, El Monofeya',
      bloodPhone:'04  82441379', bloodLate:'30.5751029', bloodLong: '31.010953'),
  BloodBanksModel(bankName: 'Regional Center for Blood Transfusion in Kafr El - Sheikh', bankAddress: 'Department of Kafr El-Sheikh',
      bloodPhone:'04  73220955', bloodLate:'31.1151892', bloodLong: '30.9436423'),
  BloodBanksModel(bankName: 'Regional Center for blood transfusion in Alexandria', bankAddress: 'Abdel Qader Abou Nodah St., Kom El Dekka Sharq, El Attarin Division, Alexandria',
      bloodPhone:'0106234898', bloodLate:'31.198047', bloodLong: '29.9072782'),
  BloodBanksModel(bankName: 'Regional Center for blood transfusion in Ismailia', bankAddress: 'Ismailia',
      bloodPhone:'064 3103835', bloodLate:'30.5960766', bloodLong: '32.2746441'),
  BloodBanksModel(bankName: 'Regional Center for blood transfusion in Assiut', bankAddress: 'Ring Road, Red 2nd, Assiut Second Division',
      bloodPhone:'0882370015', bloodLate:'27.1794275', bloodLong: '31.1839606'),
  BloodBanksModel(bankName: 'Regional Center for Blood Transfusion in Beni Suef', bankAddress: 'Bayad El Arab, Beni Suef',
      bloodPhone:'0822364904', bloodLate:'29.0419274', bloodLong: '31.1207167'),
  BloodBanksModel(bankName: 'Regional Center for blood transfusion in Aswan', bankAddress: 'Second Division, Aswan Department, Aswan',
      bloodPhone:'0972326629', bloodLate:'24.0579251', bloodLong: '32.8844701'),

  
];
}

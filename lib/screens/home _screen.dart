import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/components/navigation_drawer_widget.dart';
import 'package:pure_blood/screens/blood_donors_screen.dart';
import 'package:pure_blood/screens/blood_request_screen.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    PureBloodCubit.get(context).getUser();
    return Scaffold(
      key: _globalKey,
      drawer: NavigationDrawerWidget(),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_home.jpg'),
                fit: BoxFit.cover),
          ),
          padding:
              EdgeInsets.only(top: device.padding.top, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        _globalKey.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 40.0,
                      )),
                  Image.asset(
                    'assets/images/logo.png',
                    width: device.size.width / 4,
                  ),
                ],
              ),
              SizedBox(
                height: 75,
              ),
              CarouselSlider.builder(
                itemCount: imagesSlider.length,
                options: CarouselOptions(
                    height: 250, autoPlay: true, viewportFraction: 1),
                itemBuilder: (contex, index, realIndex) {
                  final _imagesSlider = imagesSlider[index];
                  return bulidImage(_imagesSlider, index);
                },
              ),
              SizedBox(
                height: 75,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BloodDonorsScreen(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 75),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ))),
                child: Text(
                  'Blood Doner',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BloodRequestScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 75),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ))),
                child: Text(
                  'Blood Request',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }

  Widget bulidImage(String image, int index) => Container(
        //margin: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.grey,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      );
  final imagesSlider = [
    'assets/images/home_slider1.jpg',
    'assets/images/home_slider2.jpg',
    'assets/images/home_slider3.jpg'
  ];
}

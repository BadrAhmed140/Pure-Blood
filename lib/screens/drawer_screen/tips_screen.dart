import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pure_blood/screens/drawer_screen/tip_detail_screen.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tips').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
          if (snapshot.hasData) {
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1 / 1.8),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipDetailScreen(
                            index: index,
                            imgUrl:
                            'https://firebasestorage.googleapis.com/v0/b/purebloodflutter.appspot.com/o/tips%2F$index.jpeg?alt=media',
                            title: snapshot.data.docs[index].data()['title'],
                            subtitle:
                            snapshot.data.docs[index].data()['subtitle']),
                      )),
                  child: Stack(fit: StackFit.expand, children: [
                    Hero(
                      tag: index,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/purebloodflutter.appspot.com/o/tips%2F$index.jpeg?alt=media',
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                                color: Colors.white,
                                value: progress.expectedTotalBytes != null
                                    ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                    : null),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 65,
                        padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        width: double.infinity,
                        color: Colors.red.withOpacity(.6),
                        child: Center(
                          child: Text(
                            snapshot.data.docs[index].data()['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ]),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

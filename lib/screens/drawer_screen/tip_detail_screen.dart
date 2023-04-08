import 'package:flutter/material.dart';

class TipDetailScreen extends StatelessWidget {
  final String imgUrl, title, subtitle;
  final int index;

  TipDetailScreen(
      {Key? key,
        required this.imgUrl,
        required this.title,
        required this.subtitle,
        required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Stack(fit: StackFit.expand, children: [
                  Hero(
                    tag: index,
                    child: Image.network(
                      imgUrl,
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
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      width: double.infinity,
                      color: Colors.red.withOpacity(.6),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  )
                ])),
            Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(8),
                        child: Text(
                          subtitle,
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                  physics: BouncingScrollPhysics(),
                ))
          ],
        ),
      ),
    );
  }
}

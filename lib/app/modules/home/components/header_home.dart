import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15 + 80,
          ),
          Container(
            alignment: Alignment.topRight,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.blueAccent,
                    Colors.blue,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor,width: 5)
              ),
              child: Icon(Icons.person,size: 120,color: Colors.black54,),
            ),
          ),
        ]
    );
  }
}

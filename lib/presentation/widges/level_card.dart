import 'package:flutter/material.dart';

import '../screens/login/passenger_login.dart';


class LevelCard extends StatelessWidget {
  final int difficulty, level;

  const LevelCard({super.key, required this.difficulty, required this.level});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const PassengerLogin()));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: ListTile(
            leading: Image.asset('assets/images/star.png', height: size.height * 0.05,),
            title: const Text('المستوى '),
            trailing:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/openLock.png', height: size.height * 0.04,),
                Text('10',
                    style: Theme.of(context).textTheme.bodyLarge,),
              ],
            )
          ),
        ),
      ),
    );
  }
}

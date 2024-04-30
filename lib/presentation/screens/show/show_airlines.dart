import 'package:flutter/material.dart';


import '../../../core/global/global.dart';
import 'show_flights.dart';

class ShowAirlines extends StatelessWidget {
  const ShowAirlines({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Airlines'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: myAirlines.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowFlights(airline: myAirlines[index])));
          },
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.airplanemode_active),
              title: Text(myAirlines[index].name, style: Theme.of(context).textTheme.titleLarge,),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        padding: EdgeInsets.all(size.height * 0.02),
      ),
    );
  }
}

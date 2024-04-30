import 'package:flutter/material.dart';

class ShowAllPassengersForFlight extends StatelessWidget {
  const ShowAllPassengersForFlight({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passengers'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: (){},
          child: const Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Passenger Name'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        padding: EdgeInsets.all(size.height * 0.02),
      ),
    );
  }
}

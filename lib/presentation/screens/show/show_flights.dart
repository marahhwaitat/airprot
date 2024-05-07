import 'package:airport/core/utils/colors.dart';
import 'package:airport/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/global/global.dart';
import '../../../data/models/airline_model.dart';
import '../add/add_flight.dart';
import '../details/flight_details.dart';

class ShowFlights extends StatelessWidget {
  final Airline airline;
  final bool isAirline;
  const ShowFlights({super.key, required this.airline, this.isAirline = true});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(airline.name, style: context.getThemeTextStyle().titleLarge,),
        centerTitle: true,
        actions: [
          if(!isAirline)TextButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddFlight(airlineId: airline.id)));
            },
            child: Text('Add Flight', style: TextStyle(color: primary),),
          ),
        ],
      ),
      body: airline.flightIds.isEmpty?
        Center(child: Text('empty', style: context.getThemeTextStyle().headlineMedium)):
        ListView.builder(
          itemCount: airline.flightIds.length,
          itemBuilder: (ctx, index) => GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FlightDetails(
                    airlineId: airline.id,
                    flightId: airline.flightIds[index],
                  )));
            },
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.airplane_ticket),
                title: Text(
                  '${myFlights.firstWhere((flight) => flight.flightId == airline.flightIds[index]).flightNum}',
                  style: context.getThemeTextStyle().titleLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          padding: EdgeInsets.all(size.height * 0.02),
      ),
    );
  }
}

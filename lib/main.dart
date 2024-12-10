import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_ki_khajana/modules/home/home.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_event.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/services/database_helper.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/services/network_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NetworkService networkService = NetworkService();
  final IrshadateDbHelper dbHelper = IrshadateDbHelper();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IrshadateBloc(
            networkService: networkService,
            dbHelper: dbHelper,
          )..add(FetchIrshadate()), // Fetch data on app launch
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

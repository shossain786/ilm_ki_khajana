import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_ki_khajana/modules/home/home.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_bloc.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/bloc/irshadate_event.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/services/network_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NetworkService networkService = NetworkService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IrshadateBloc(networkService: networkService)
            ..add(FetchIrshadate()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

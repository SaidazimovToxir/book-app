import 'package:book/blocs/file_bloc.dart';
import 'package:book/service/get_it.dart';
import 'package:book/ui/screens/home_screen/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<FileBloc>(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Schyler',
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

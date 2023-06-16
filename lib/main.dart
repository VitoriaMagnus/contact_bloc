import 'package:contact_bloc/features/bloc/example_bloc.dart';
import 'package:contact_bloc/features/bloc_example_page.dart';
import 'package:contact_bloc/features/bloc_freezed/example_freezed_bloc.dart';
import 'package:contact_bloc/features/bloc_freezed_example.dart';
import 'package:contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:contact_bloc/features/contacts/list/contact_list_page.dart';
import 'package:contact_bloc/home/home_page.dart';
import 'package:contact_bloc/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactRepository(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.amber,
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (_) => const HomePage(),
          '/bloc/example': (_) => BlocProvider(
                create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
                child: const BlocExamplePage(),
              ),
          '/bloc/example/freezed': (context) => BlocProvider(
                create: (context) => ExampleFreezedBloc()
                  ..add(const ExampleFreezedEvent.findNames()),
                child: const BlocFreezedExample(),
              ),
          '/contacts_list': (context) => BlocProvider(
              create: (context) =>
                  ContactListBloc(repository: context.read<ContactRepository>())
                    ..add(const ContactListEvent.findAll()),
              child: const ContactListPage()),
        },
        home: const HomePage(),
      ),
    );
  }
}

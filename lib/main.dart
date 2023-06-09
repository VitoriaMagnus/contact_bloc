import 'package:contact_bloc/features/bloc/example_bloc.dart';
import 'package:contact_bloc/features/bloc_example_page.dart';
import 'package:contact_bloc/features/bloc_freezed/example_freezed_bloc.dart';
import 'package:contact_bloc/features/bloc_freezed_example.dart';
import 'package:contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:contact_bloc/features/contacts/list/contact_list_page.dart';
import 'package:contact_bloc/features/contacts/register/contact_register_page.dart';
import 'package:contact_bloc/features/contacts/update/bloc/contact_update_bloc.dart';
import 'package:contact_bloc/features/contacts/update/contact_update_page.dart';
import 'package:contact_bloc/features/contacts_cubit/list/contacts_list_cubit_page.dart';
import 'package:contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_bloc/home/home_page.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/contacts/register/bloc/contact_register_bloc.dart';

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
          '/contact/list': (context) => BlocProvider(
              create: (context) =>
                  ContactListBloc(repository: context.read<ContactRepository>())
                    ..add(const ContactListEvent.findAll()),
              child: const ContactListPage()),
          'contact/register': (context) => BlocProvider(
                create: (context) =>
                    ContactRegisterBloc(contactsRepository: context.read()),
                child: const ContactRegisterPage(),
              ),
          'contact/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;

            return BlocProvider(
              create: (context) => ContactUpdateBloc(
                contactRepository: context.read(),
              ),
              child: ContactUpdatePage(contact: contact),
            );
          },
          'contact/cubit/list': (context) {
            return BlocProvider(
              create: (context) => ContactListCubit(
                repository: context.read()..findAll(),
              ),
              child: const ContactsListCubitPage(),
            );
          }
        },
        home: const HomePage(),
      ),
    );
  }
}

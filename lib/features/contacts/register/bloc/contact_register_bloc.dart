import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../repositories/contact_repository.dart';

part 'contact_register_state.dart';
part 'contact_register_event.dart';

part 'contact_register_bloc.freezed.dart';

class ContactRegisterBloc
    extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  final ContactRepository _contactsRepository;

  ContactRegisterBloc({required ContactRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(const ContactRegisterState.initial()) {
    on<_Save>(_save);
  }

  FutureOr<void> _save(_Save event, Emitter<ContactRegisterState> emit) async {
    try {
      emit(const ContactRegisterState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final contactModel = ContactModel(
        name: event.name,
        email: event.email,
      );

      await _contactsRepository.create(contactModel);

      emit(const ContactRegisterState.success());
    } catch (e, s) {
      log('Erro ao salvar um novo usuário', error: e, stackTrace: s);
      emit(const ContactRegisterState.error(
          message: 'Erro ao salvar um novo usuário'));
    }
  }
}

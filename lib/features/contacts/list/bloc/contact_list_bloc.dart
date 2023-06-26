import 'dart:async';

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

part 'contact_list_bloc.freezed.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactRepository _repository;

  ContactListBloc({required ContactRepository repository})
      : _repository = repository,
        super(ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
    on<_Delete>(_deleteById);
  }

  Future<void> _findAll(
      _ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());
      final contacts = await _repository.findAll();
      emit(ContactListState.data(contacts: contacts));
    } catch (e) {
      emit(ContactListState.error(message: 'Erro ao buscar contatos'));
    }
  }

  FutureOr<void> _deleteById(
      _Delete event, Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());

      await _repository.delete(event.model);
      add(const ContactListEvent.findAll());
    } catch (e) {
      emit(ContactListState.error(message: 'Erro ao deletar contato.'));
    }
  }
}

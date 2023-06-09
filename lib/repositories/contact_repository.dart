import 'package:contact_bloc/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactRepository {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://10.0.2.2:3031/contacts');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) => Dio().post(
        'http://192.168.1.101:3031/contacts',
        data: model.toMap(),
      );

  Future<void> update(ContactModel model) => Dio()
      .put('http://10.0.2.2:3031/contacts/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) =>
      Dio().delete('http://10.0.2.2:3031/contacts/${model.id}');
}

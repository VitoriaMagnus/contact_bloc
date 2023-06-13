part of 'example_bloc.dart';

abstract class ExampleEvent {}

class ExampleFindNameEvent extends ExampleEvent {}

class ExampleAddNameEvent extends ExampleEvent {
  final String names;

  ExampleAddNameEvent({
    required this.names,
  });
}

class ExampleRemoveNameEvent extends ExampleEvent {
  final String name;

  ExampleRemoveNameEvent({
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExampleRemoveNameEvent && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

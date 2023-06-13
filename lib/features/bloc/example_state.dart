part of 'example_bloc.dart';

@immutable
abstract class ExampleState {}

class ExampleStateInitial extends ExampleState {}

class ExampleStateData extends ExampleState {
  final List<String> names;

  ExampleStateData({
    required this.names,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExampleStateData && listEquals(other.names, names);
  }

  @override
  int get hashCode => names.hashCode;
}

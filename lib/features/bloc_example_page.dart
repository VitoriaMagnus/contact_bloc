import 'package:contact_bloc/features/bloc/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExamplePage extends StatelessWidget {
  const BlocExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Example'),
      ),
      body: BlocListener<ExampleBloc, ExampleState>(
        listenWhen: (previous, current) {
          if (previous is ExampleStateInitial && current is ExampleStateData) {
            if (current.names.length > 3) {
              return true;
            }
          }
          return false;
        },
        listener: (context, state) {
          if (state is ExampleStateData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('A quantidade de nomes é ${state.names.length}'),
              ),
            );
          }
        },
        child: Column(
          children: [
            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }
                return false;
              },
              builder: (context, showLoader) {
                if (showLoader) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            // BlocBuilder<ExampleBloc, ExampleState>(
            //   builder: (context, state) {
            //     if (state is ExampleStateData) {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: state.names.length,
            //         itemBuilder: (context, index) {
            //           final name = state.names[index];
            //           return ListTile(
            //             title: Text(name),
            //           );
            //         },
            //       );
            //     }
            //     return const Text('Nenhum nome encontrado!');
            //   },
            // ),
            BlocSelector<ExampleBloc, ExampleState, List<String>>(
              selector: (state) {
                if (state is ExampleStateData) {
                  return state.names;
                }
                return [];
              },
              builder: (context, names) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        final name = names[index];
                        return ListTile(
                          title: Text(name),
                          onTap: () {
                            context.read<ExampleBloc>().add(
                                  ExampleRemoveNameEvent(name: name),
                                );
                          },
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<ExampleBloc>()
                            .add(ExampleAddNameEvent(names: 'Vitória'));
                      },
                      child: const Text('Adicionar novo nome'),
                    ),
                  ],
                );
              },
            ),
            // BlocConsumer<ExampleBloc, ExampleState>(
            //   listener: (context, state) {
            //     print('Estado alterado para ${state.runtimeType}');
            //   },
            //   builder: (_, state) {
            //     if (state is ExampleStateData) {
            //       return Text('Total de nome é ${state.names.length}');
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
            //
          ],
        ),
      ),
    );
  }
}

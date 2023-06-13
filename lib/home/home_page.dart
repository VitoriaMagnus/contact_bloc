import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Wrap(
              children: [
                _ButtonCard(
                    title: 'Example',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/bloc/example');
                    }),
                _ButtonCard(title: 'Example Freezed', onPressed: () {}),
                _ButtonCard(title: 'Contact', onPressed: () {}),
                _ButtonCard(title: 'Contact Cubit', onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}

class _ButtonCard extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const _ButtonCard({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        width: 180,
        child: TextButton(
          onPressed: onPressed,
          child: Text(title),
        ),
      ),
    );
  }
}

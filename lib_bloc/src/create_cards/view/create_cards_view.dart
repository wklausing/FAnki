import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation_cubit.dart';

class CreateCardsView extends StatelessWidget {
  CreateCardsView({super.key});

  final frontController = TextEditingController();
  final backController = TextEditingController();
  final String front = 'front';
  final String back = 'back';

  void clearTextfields() {
    if (frontController.text != '' || backController.text != '') {
      frontController.clear();
      backController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text('Create Cards View'),
          ElevatedButton(
            onPressed: () => context.read<NavigationCubit>().goToLearning(),
            child: Text('Go to Home Page'),
          ),
        ]),
      ),
    );

    // Column(
    //   children: [
    //     Expanded(
    //       child: Text('LoadDeck2'),
    //     ),
    // SizedBox(
    //   height: 210,
    //   child: Column(
    //     children: [
    //       Spacer(flex: 10),
    //       FractionallySizedBox(
    //         widthFactor: 0.9,
    //         child: TextField(
    //           controller: frontController,
    //           decoration: InputDecoration(
    //             filled: true,
    //             border: OutlineInputBorder(),
    //             hintText: 'Insert front site here.',
    //           ),
    //         ),
    //       ),
    //       Spacer(flex: 10),
    //       FractionallySizedBox(
    //         widthFactor: 0.9,
    //         child: TextField(
    //           controller: backController,
    //           decoration: InputDecoration(
    //             filled: true,
    //             border: OutlineInputBorder(),
    //             hintText: 'Insert back site here.',
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    //   ],
    // );
  }
}

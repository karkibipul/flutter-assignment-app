// -------TASK 1 TEST-----(setState using Provider)

// import 'package:flutter/material.dart';
// import 'package:flutter_assignment_app/features/state_management/provider_counter/provider_screen.dart';
// import 'package:flutter_assignment_app/features/state_management/provider_counter/counter_provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => CounterProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: ProviderScreen());
//   }
// }

// -------Task 1 Test (using BLoC)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_assignment_app/features/state_management/bloc_counter/bloc/counter_bloc.dart';
import 'package:flutter_assignment_app/features/state_management/bloc_counter/bloc/counter_event.dart';
import 'package:flutter_assignment_app/features/state_management/bloc_counter/bloc/counter_state.dart';

void main() {
  runApp(BlocProvider(create: (_) => CounterBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BlocCounterScreen());
  }
}

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BLoC Counter")),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              'Count: ${state.count}',
              style: const TextStyle(fontSize: 40),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'dec',
            onPressed: () {
              context.read<CounterBloc>().add(DecrementEvent());
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'inc',
            onPressed: () {
              context.read<CounterBloc>().add(IncrementEvent());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: () {
              context.read<CounterBloc>().add(ResetEvent());
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

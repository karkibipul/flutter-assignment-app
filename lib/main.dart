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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_assignment_app/features/state_management/bloc_counter/bloc/counter_bloc.dart';
// import 'package:flutter_assignment_app/features/state_management/bloc_counter/bloc/counter_event.dart';
// import 'package:flutter_assignment_app/features/state_management/bloc_counter/bloc/counter_state.dart';

// void main() {
//   runApp(BlocProvider(create: (_) => CounterBloc(), child: const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: BlocCounterScreen());
//   }
// }

// class BlocCounterScreen extends StatelessWidget {
//   const BlocCounterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("BLoC Counter")),
//       body: Center(
//         child: BlocBuilder<CounterBloc, CounterState>(
//           builder: (context, state) {
//             return Text(
//               'Count: ${state.count}',
//               style: const TextStyle(fontSize: 40),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: 'dec',
//             onPressed: () {
//               context.read<CounterBloc>().add(DecrementEvent());
//             },
//             child: const Icon(Icons.remove),
//           ),
//           const SizedBox(width: 16),
//           FloatingActionButton(
//             heroTag: 'inc',
//             onPressed: () {
//               context.read<CounterBloc>().add(IncrementEvent());
//             },
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(width: 16),
//           FloatingActionButton(
//             heroTag: 'reset',
//             onPressed: () {
//               context.read<CounterBloc>().add(ResetEvent());
//             },
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//     );
//   }
// }


// Task 2 Weather APP

// import 'package:flutter/material.dart';
// import 'package:flutter_assignment_app/features/weather/weather_provider.dart';
// import 'package:flutter_assignment_app/features/weather/screens/weather_screen.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => WeatherProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: WeatherScreen());
//   }
// }

// Firebase auth
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/weather/weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA99SDd_RWFgBp_3MbIDT32w2TyoAHEcn4",
      authDomain: "flutter-assignment-bipul.firebaseapp.com",
      projectId: "flutter-assignment-bipul",
      storageBucket: "flutter-assignment-bipul.firebasestorage.app",
      messagingSenderId: "653741363027",
      appId: "1:653741363027:web:e0e11915027cbafa8c9ba6",
      measurementId: "G-L29CJ8JRNX",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}

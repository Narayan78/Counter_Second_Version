import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    }
    return null;
  }
}

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state = (state == null) ? 1 : state + 1;
  void decrement() => state = (state == null) ? -1 : state - 1;
  void reset() => state = 0;
  int? get value => state;
}

final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod'),
        ),
        body: Center(
          child: Column(
          children: [
            TextButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).increment();
                },
                child: const Text("Increment")),
            TextButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).decrement();
                },
                child: const Text("Decrement")),
            TextButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).reset();
                },
                child: const Text("Reset")),
            Consumer(builder: (context, ref, child) {
              final counter = ref.watch(counterProvider);
              return Center(
                child: Text(
                  counter.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
              );
            })
          ],
        ),
        ),
      );
  }
}

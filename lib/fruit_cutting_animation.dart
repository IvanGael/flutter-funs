import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum FruitState { whole, sliced }

class FruitCubit extends Cubit<FruitState> {
  FruitCubit() : super(FruitState.whole);

  void sliceFruit() => emit(FruitState.sliced);
}



class FruitCuttingScreen extends StatelessWidget {
  const FruitCuttingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<FruitCubit, FruitState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<FruitCubit>().sliceFruit();
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: state == FruitState.whole
                    ? Image.asset('assets/lemon.png', key: const ValueKey(1))
                    : Image.asset('assets/lemon-slice.png', key: const ValueKey(2)),
              ),
            );
          },
        ),
      ),
    );
  }
}
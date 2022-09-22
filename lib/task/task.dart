import 'package:beauty_supplies_project/task/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterTask3C extends StatelessWidget {
  const CounterTask3C({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterTaskCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            centerTitle: true,
            title: Text(
              'Counter Task',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${context.read<CounterTaskCubit>().state}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                      color: context.read<CounterTaskCubit>().state > 0
                          ? Colors.blueAccent
                          : Colors.grey,
                      iconData: Icons.remove,
                      onPressed: () {
                        if (context.read<CounterTaskCubit>().state > 0) {
                          context.read<CounterTaskCubit>().decrement();
                        }
                        // setState(() {});
                      },
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    DefaultButton(
                      iconData: Icons.add,
                      onPressed: () {
                        context.read<CounterTaskCubit>().increment();
                        // setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultButton(
                  iconData: Icons.restart_alt,
                  onPressed: () {
                    // cubit.restart();
                    context.read<CounterTaskCubit>().restart();
                    // setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Widget defaultButton({
//   required IconData iconData,
//   required VoidCallback onPressed,
//   Color color = Colors.blueAccent,
// }) =>
//    ;
}

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color color;

  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
    this.color = Colors.blueAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Icon(
        iconData,
      ),
    );
  }
}

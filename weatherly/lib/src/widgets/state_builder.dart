import 'package:flutter/material.dart';

/// Switcher widget that handles the `Error` and `Loading` states of the app.
class StateBuilder extends StatelessWidget {
  /// Whether or not the parent widget has an error.
  final bool hasError;

  /// Whether or not the parent widget is busy.
  final bool isBusy;

  /// Child widget to be rendered on success cases.
  final Widget child;

  /// Callback method for the failed state.
  final VoidCallback onTryAgain;

  /// Creates a new `StateBuilder` instance
  const StateBuilder({
    Key? key,
    this.hasError = false,
    this.isBusy = false,
    required this.child,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasError) return _GenericError(onTryAgain: onTryAgain);
    if (isBusy) return const _Loader();

    return child;
  }
}

class _GenericError extends StatelessWidget {
  final VoidCallback onTryAgain;
  const _GenericError({
    Key? key,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.blue,
            size: 48.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text('Something went wrong!'),
          TextButton(
            child: const Text('Try again'),
            onPressed: onTryAgain,
          )
        ],
      ),
    );
  }
}

///
class _Loader extends StatelessWidget {
  ///
  const _Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

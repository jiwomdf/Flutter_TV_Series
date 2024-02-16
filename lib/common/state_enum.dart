sealed class SealedState<T> {
  const SealedState();

  factory SealedState.loading() = LoadingState;
  factory SealedState.success(T value) = SuccessState;
  factory SealedState.error(String value) = ErrorState;
}

class LoadingState<T> extends SealedState<T> {
  LoadingState();
}

class ErrorState<T> extends SealedState<T> {
  final String msg;
  ErrorState(this.msg);
}

class SuccessState<T> extends SealedState<T> {
  final T value;
  SuccessState(this.value);
}

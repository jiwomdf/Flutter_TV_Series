class SealedState<T> {
  SealedState._();

  factory SealedState.loading() = LoadingState;
  factory SealedState.success(T foo) = SuccessState;
  factory SealedState.error(String foo) = ErrorState;
}

class LoadingState<T> extends SealedState<T> {
  LoadingState(): super._();
}

class ErrorState<T> extends SealedState<T> {
  ErrorState(this.msg): super._();
  final String msg;
}

class SuccessState<T> extends SealedState<T> {
  SuccessState(this.value): super._();
  final T value;
}

class ResultApi<T> {
  final bool isError;
  late final T value;
  ResultApi({
    required this.isError,
    required this.value,
  });
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(<K, List<E>>{}, (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension FileExtension on String {
  String get getFileName => split('/').last.split('.').first;
  String get getFileExtension => split('/').last.split('.').last;
  String get getFileNameWithExtension => split('/').last;
}

extension CombineName on String {
  String getFullName(String? middleName, String lastName) {
    return '$this ${(middleName ?? '').isEmpty ? " " : middleName}$lastName';
  }
}

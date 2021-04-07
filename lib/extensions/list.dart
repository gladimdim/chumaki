import 'dart:math';

extension Divide<T> on List<T> {
  List<List<T>> divideBy(int number) {
    List<T> list = this;
    List<List<T>> result = [];
    while (list.isNotEmpty) {
      result.add([...list.take(number)]);
      try {
        list = list.sublist(number);
      } catch (e) {
        break;
      }
    }

    return result;
  }
}

typedef bool ListIntersectionFilter<T, B>(T a, B b);

extension Intersection on List {
  List<T> intersection<T, B>(
      List<B> anotherList, ListIntersectionFilter<T, B> filter) {
    List<T> result = [];
    for (var element in this) {
      for (var anotherElement in anotherList) {
        if (filter(element, anotherElement)) {
          result.add(element);
        }
      }
    }

    return result;
  }

  List<T> rest<T, B>(List<B> anotherList, ListIntersectionFilter<T, B> filter) {
    List<T> result = [];
    for (var element in this) {
      if (anotherList
          .where((anotherElement) => filter(element, anotherElement))
          .isEmpty) {
        result.add(element);
      }
    }

    return result;
  }
}

extension Takers<T> on List<T> {
  List<T> takeLast(int number) {
    if (number < 0) {
      return List<T>.empty(growable: true);
    }
    if (length <= number) {
      return this;
    }

    return this.sublist(length - number);
  }

  T takeRandom() {
    int max = this.length;
    Random random = Random();
    int next = random.nextInt(max);
    return this[next];
  }
}

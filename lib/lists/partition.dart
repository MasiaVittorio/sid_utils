
extension IterablePartition<T> on Iterable<T> {
  Iterable<List<T>> part(int size) => partition(this, size);
}

/// Partitions the input iterable into lists of the specified size.
Iterable<List<T>> partition<T>(Iterable<T> iterable, int size) {
  return iterable.isEmpty ? [] : new _Partition<T>(iterable, size);
}

class _Partition<T> extends Iterable<List<T>> {
  final Iterable<T> _iterable;
  final int _size;

  _Partition(this._iterable, this._size) {
    if (_size <= 0) throw new ArgumentError(_size);
  }

  Iterator<List<T>> get iterator =>
      new _PartitionIterator<T>(_iterable.iterator, _size);
}

class _PartitionIterator<T> implements Iterator<List<T>> {
  final Iterator<T> _iterator;
  final int _size;
  List<T> _current;

  _PartitionIterator(this._iterator, this._size);

  @override
  List<T> get current => _current;

  @override
  bool moveNext() {
    var newValue = <T>[];
    var count = 0;
    while (count < _size && _iterator.moveNext()) {
      newValue.add(_iterator.current);
      count++;
    }
    _current = (count > 0) ? newValue : null;
    return _current != null;
  }
}


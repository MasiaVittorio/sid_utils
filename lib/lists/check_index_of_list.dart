
bool checkIndexOfList(int index, List list) {
  if(list.length == 0) return false;
  if(index < 0) return false;
  if(index >= list.length) return false;
  return true;
}

extension ListSidIndexCheck<T> on List<T> {
  bool checkIndex(int? index) {
    if(index == null) return false;
    if(isEmpty) return false;
    if(index < 0) return false;
    if(index >= length) return false;
    return true;
  }

  T? safeAt(int? index){
    if(isEmpty) return null;
    if(index == null) return null;
    if(index < 0) return null;
    if(index >= length) return null;
    return elementAt(index);
    
  }
}

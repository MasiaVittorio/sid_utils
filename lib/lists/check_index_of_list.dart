
bool checkIndexOfList(int index, List list) {
  if(list == null) return false;
  if(list.length == 0) return false;
  if(index == null) return false;
  if(index < 0) return false;
  if(index >= list.length) return false;
  return true;
}

extension ListSidIndexCheck on List {
  bool checkIndex(int index) {
    if(this == null) return false;
    if(this.isEmpty) return false;
    if(index == null) return false;
    if(index < 0) return false;
    if(index >= this.length) return false;
    return true;
  }
}

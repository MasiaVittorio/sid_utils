import 'check_index_of_list.dart';

extension ListSidMove on List {
  bool move(int from, int to){
    if(!this.checkIndex(from)) return false;
    if(!this.checkIndex(to)) return false;

    this.insert(to, this.removeAt(from));
    return true;
  }
}
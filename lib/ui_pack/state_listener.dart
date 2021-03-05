import 'package:rxdart/rxdart.dart';

class DrawerListener{
  BehaviorSubject<bool> _isOpen = new BehaviorSubject.seeded(false);
  Stream get stream$ => _isOpen.stream;
  bool get current => _isOpen.value;

  update(bool update){
    _isOpen.add(update);
  }
}

DrawerListener drawerListener = DrawerListener();


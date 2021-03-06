import '../../data/Data.dart';
import 'component.dart';
import 'page.dart';

class ScoutingData {
  String name;
  Map<String, Screen> pages = {};
  List<String> pageNames = [];
  int currPage = 0;

  ScoutingData(Map<String, dynamic> config, {required this.name}) {
    for (String k in config.keys.toList()) {
      pageNames.add(k);
      pages[k] = Screen.fromJson(config[k]);
    }
  }

  List<String> notFilled() {
    return pages[pageNames[currPage]]!.notFilled();
  }

  bool canGoToNextPage() {
    return currPage < pageNames.length - 1;
  }

  bool canGoToPrevPage() {
    return currPage > 0;
  }

  bool nextPage() {
    if (!canGoToNextPage()) {
      return false;
    }
    currPage += 1;
    return true;
  }

  bool prevPage() {
    if (!canGoToPrevPage()) {
      return false;
    }
    currPage -= 1;
    return true;
  }

  String stringfy() {
    String ret = "${name[0].toUpperCase()}\n";

    for (var i in pages.values) {
      ret += i.toJson().toString();
    }
    return ret;
  }

  Screen? getCurrentPage() {
    return pages[pageNames[currPage]];
  }

  void empty() {
    currPage = 0;
    for (var page in pageNames) {
      pages[page]!.empty();
    }
  }

  List<Data> getData() {
    List<Data> data = [];
    for (Screen p in pages.values) {
      for( Data d in p.getValues()) {
        data.add(d);
      }
    }
    return data;
  }

  List<Component> getComponents() {
    List<Component> components = [];
    for ( Screen p in pages.values) {
      for (  Component c in p.getComponents()) {
        components.add(c);
      }
    }
    return components;
  }
}
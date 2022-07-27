import 'package:json_annotation/json_annotation.dart';

import '../../color/hex_color.dart';
import '../../data/Data.dart';
import 'component.dart';

class Section {
  Section(this.title, this.color, this.rows, this.textColor, this.components,
    this.componentsPerRow, this.darkColor, this.darkTextColor, this.values);

  HexColor color;
  int rows;
  HexColor textColor;
  HexColor darkColor;
  HexColor darkTextColor;
  String title;
  List<Component> components;
  List<Data> values = [];
  List<int> componentsPerRow;

  factory Section.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> properties = json["properties"];
    List<Component> components = (json["components"] as List<dynamic>).map((e) => Component.fromJson(e)).toList();  
    List<Data> values = components.map((e) => Data.fromComponent(e)).toList();
    return Section(properties["title"],
        HexColor(properties['color']),
        properties['rows'], 
        HexColor(properties['textColor']),
        components, 
        (properties['componentsInRow'] as List<dynamic>).map((e) => e as int).toList(), 
        HexColor(properties['darkColor']), 
        HexColor(properties['darkTextColor']),
        values);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> res = {};
    for( int i = 0; i<components.length; i++) {
      res[components[i].name] = values[i].get();
    }
    return res;
  }

  void empty() {
    for (int i = 0; i < values.length; ++i) {
      values[i].empty();
    }
  }

  List<String> notFilled () {
    List<String> ret = [];
    for (int i = 0; i < components.length; i++) {
      if (components[i].required && !values[i].setByUser) {
        ret.add(components[i].name);
      }
    }
    return ret;
  }

  HexColor getColor(bool darkMode) => darkMode ? darkColor : color;

  HexColor getTextColor(bool darkMode) => darkMode ? darkTextColor : textColor;

  int numComponents() => components.length;
}
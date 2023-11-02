import 'dart:io';

String readJson(String directory, String name) {
  var dir = Directory.current.path;
  return File('$dir/packages/$directory/test/$name').readAsStringSync();
}

import 'dart:io';

String readJson(String directory, String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('tmdb')) {
    dir = dir.replaceAll('tmdb', 'tmdb/packages');
  }
  return File('$dir/$directory/test/$name').readAsStringSync();
}

import 'package:process_run/shell.dart';
import 'package:tekartik_build_utils/common_import.dart';

Future<bool> generate({@required String dirName, String appName}) async {
  appName ??= dirName;
  assert(dirName != null && appName != null,
      'invalid dir $dirName or app $appName');
  dirName = _fixDirName(dirName);
  var flutterVersion = await getFlutterVersion();
  if (flutterVersion < Version(1, 10, 1)) {
    throw 'invalid flutter version $flutterVersion';
  }
  // var shell = Shell();
  print('Create $appName in $dirName. Continue Y/N?');
  var input = stdin.readLineSync();
  if (input.toLowerCase() != 'y') {
    return false;
  }
  try {
    await Directory(dirName).delete(recursive: true);
  } catch (_) {}
  var shell = Shell(workingDirectory: dirname(dirName));
  await shell.run('flutter config --enable-web');
  await shell.run('flutter create --web --project-name $appName $dirName');
  print('continued');
  return true;
}

String _fixDirName(String dirName) => normalize(absolute(dirName));

Future gitGenerate({String dirName, String appName}) async {
  if (!await generate(dirName: dirName, appName: appName)) {
    return;
  }
  var shell = Shell(workingDirectory: _fixDirName(dirName));
  await shell.run('git checkout .');
}

import 'package:dev_test/test.dart';
import 'package:tekartik_build_utils/net/net.dart';

void main() {
  group('net', () {
    test('get_lan_localhost', () async {
      expect(await getLanLocalhost(), isNotEmpty);
    });
  });
}

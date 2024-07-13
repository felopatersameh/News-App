
import 'package:url_launcher/url_launcher_string.dart';

Future<void> openlink  (articles)
async {
  final String url =articles['url'];
  if (!await launchUrlString(url)) {
     Exception('Could not launch $url');
  }
}
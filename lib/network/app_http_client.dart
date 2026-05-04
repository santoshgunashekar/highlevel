import 'package:http/http.dart' as http;

/// Creates the shared [http.Client] registered in core DI ([configureDependencies]).
http.Client createAppHttpClient() => http.Client();

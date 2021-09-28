import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_config.dart';
import 'locator.dart';
import 'utils/helpers.dart';
import 'flavors/flavor.dart';
import 'flavors/flavor_config.dart';
import 'flavors/flavor_values.dart';

void main() {
  setAppOrientation();
  setupLogging();
  setupLocator();
  {%- if cookiecutter.sentry_dsn_key == "NA" -%}
  //
  //TODO: Add a Sentry DSN Key
  // SentryFlutter.init(
  //       (options) => options.dsn = 'https://{{cookiecutter.sentry_dsn_key}}@o0.ingest.sentry.io/0',
  //   appRunner: () => runApp(FlavoredApp()),
  // );
  runApp(FlavoredApp());
  {% else %}
  SentryFlutter.init(
        (options) => options.dsn = 'https://{{cookiecutter.sentry_dsn_key}}@o0.ingest.sentry.io/0',
    appRunner: () => runApp(FlavoredApp()),
  );
  {% endif %}
}

class FlavoredApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlavorConfig(
      flavor: Flavor.prod,
      values: FlavorValues(baseUrl: 'https://api.revolve.net'),
      child: AppConfig(),
    );
  }

}


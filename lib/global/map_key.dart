import 'package:flutter_dotenv/flutter_dotenv.dart';

String mapKey = dotenv.get('API_URL', fallback: 'API_URL not found');

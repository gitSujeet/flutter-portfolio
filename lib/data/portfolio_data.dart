import '../main.dart';
import 'models.dart';

const projects = <ProjectModel>[
  ProjectModel(
    title: 'Telecom Self-Service App',
    subtitle:
        'Migrated a leading UK telecom provider\'s native Android & iOS codebase to a unified '
        'Flutter app with Speed Test modules, Firebase Analytics (GA4), Crashlytics, '
        'Quantum Metric SDK, Deep Links, and BLoC clean architecture.',
    tag: 'Flutter · BLoC · GA4 · Crashlytics',
    metric: '1M+',
    metricLabel: 'Active Users',
    accentColor: AppTheme.secondaryColor,
    techChips: [
      'Flutter',
      'Dart',
      'BLoC',
      'Firebase GA4',
      'Crashlytics',
      'Quantum Metric',
      'Deep Links',
    ],
  ),
  ProjectModel(
    title: 'AI Healthcare Monitor',
    subtitle:
        'Post-surgery health monitoring with on-device TFLite inference, wearable vitals sync '
        'via Health Connect, Azure Cognitive Services sentiment analysis, OpenEMR / FHIR '
        'integration, and SQLite offline caching.',
    tag: 'TFLite · Azure AI · FHIR · Health Connect',
    metric: '~40%',
    metricLabel: 'Faster Launch',
    accentColor: AppTheme.primaryColor,
    techChips: [
      'TFLite',
      'Azure AI',
      'GetX',
      'FHIR',
      'Health Connect',
      'SQLite',
    ],
  ),
  ProjectModel(
    title: 'Portable ECG Monitor',
    subtitle:
        'Real-time ECG signal acquisition over USB using FTDI D2XX drivers, with '
        'BroadcastReceiver-based data processing, cloud REST API sync for arrhythmia '
        'detection, and RBAC-based user role management.',
    tag: 'Android · Java · USB · FTDI',
    metric: '1ms',
    metricLabel: 'Stream Latency',
    accentColor: AppTheme.accentColor,
    techChips: ['Android', 'Java', 'USB FTDI', 'REST API', 'RBAC'],
  ),
  ProjectModel(
    title: 'BLE & NFC SDK',
    subtitle:
        'Modular internal library for BLE device discovery, GATT operations, and NFC/NDEF '
        'parsing — built with Kotlin Coroutines, sealed classes, and clean architecture '
        'for plug-and-play reuse across projects.',
    tag: 'Kotlin · BLE · NFC · Coroutines',
    metric: '30–40%',
    metricLabel: 'Faster Onboarding',
    accentColor: AppTheme.secondaryColor,
    techChips: ['Kotlin', 'BLE/GATT', 'NFC', 'Coroutines'],
  ),
  ProjectModel(
    title: 'On-Device Sentiment AI',
    subtitle:
        'Reusable Flutter template running MobileBERT via TFLite for multi-class sentiment '
        'classification with a custom Dart WordPiece tokenizer — optimized for mobile '
        'inference with no cloud dependency.',
    tag: 'Flutter · TFLite · MobileBERT',
    metric: '94%',
    metricLabel: 'Model Accuracy',
    accentColor: AppTheme.primaryColor,
    techChips: ['Flutter', 'TFLite', 'MobileBERT', 'Dart NLP'],
  ),
  ProjectModel(
    title: 'Flutter UI Elements Package',
    subtitle:
        'Reusable Flutter component library — buttons, cards, containers, and text fields '
        'with customizable styling parameters — standardizing UI development and reducing '
        'duplicate code across projects.',
    tag: 'Flutter · Dart · Custom Widgets',
    metric: '100%',
    metricLabel: 'Reusable',
    accentColor: AppTheme.secondaryColor,
    techChips: ['Flutter', 'Dart', 'Custom Widgets', 'UI Design'],
  ),
  ProjectModel(
    title: 'MQTT Secure Comm App',
    subtitle:
        'Client POC demonstrating real-time secure device messaging over MQTT with SSL/TLS '
        'via OpenSSL, Mosquitto ACL-based publish/subscribe, and per-device client ID '
        'topic segregation.',
    tag: 'Kotlin · MQTT · SSL/TLS',
    metric: '100%',
    metricLabel: 'Client Approved',
    accentColor: AppTheme.accentColor,
    techChips: ['Kotlin', 'MQTT', 'OpenSSL', 'Mosquitto'],
  ),
];

const experience = ExperienceModel(
  role: 'Flutter Developer',
  company: 'Tata Consultancy Services',
  location: 'Bangalore, India',
  duration: 'May 2022 – Present',
  highlights: [
    'Migrated a large-scale telecom self-service app from native Android (Java/Kotlin) and iOS (Swift) to Flutter, improving maintainability, development efficiency, and cross-platform consistency.',
    'Converted Figma designs into responsive, pixel-perfect Flutter UI using Clean Architecture, BLoC, and Repository Pattern.',
    'Implemented Firebase Analytics (GA4) with screen views, custom events, CTA tracking, navigation events, and user properties — validated with Digital Analytics teams.',
    'Integrated Firebase Crashlytics, Quantum Metric SDK, and Deep Links (Android App Links & iOS Universal Links) for production monitoring, user behavior analytics, and seamless in-app navigation.',
    'Built an AI-powered post-surgery health monitoring app using TFLite, Azure Cognitive Services, Health Connect, FHIR APIs, and SQLite offline caching.',
    'Developed reusable BLE + NFC internal libraries, reducing new project onboarding time by 30–40%.',
    'Implemented real-time ECG signal acquisition via USB FTDI D2XX drivers with BroadcastReceiver processing and cloud sync for arrhythmia detection.',
    'Improved app launch time by ~40% through async initialization and Nginx reverse proxy optimization.',
  ],
  awards: [
    '🏆  TCS Award — Outstanding Technical Contribution',
    '🏆  TCS Award — Innovation & Problem Solving',
  ],
);

const skillGroups = <String, List<String>>{
  'Mobile': [
    'Flutter & Dart',
    'Android (Kotlin / Java)',
    'iOS (Swift)',
    'Method Channels',
    'BLoC / GetX',
    'Clean Architecture',
  ],
  'Analytics & Monitoring': [
    'Firebase Analytics (GA4)',
    'Firebase Crashlytics',
    'Quantum Metric SDK',
    'Deep Links (App Links / Universal Links)',
    'Figma → Flutter',
  ],
  'AI / ML': [
    'TensorFlow Lite',
    'MobileBERT',
    'Azure Cognitive Services',
    'Google Gemini AI',
    'On-Device Inference',
  ],
  'IoT & Hardware': [
    'Bluetooth BLE / GATT',
    'NFC / NDEF',
    'USB (FTDI D2XX)',
    'MQTT',
    'Health Connect API',
    'ESP32',
  ],
  'Backend & Cloud': [
    'Firebase',
    'Azure',
    'REST APIs',
    'OpenEMR / FHIR',
    'SQLite',
    'Nginx',
    'Docker',
  ],
  'Security': ['SSL / TLS', 'OpenSSL', 'RBAC', 'Mosquitto ACL'],
  'Tools & DevOps': [
    'Git / GitHub / SVN',
    'Android Studio / VS Code',
    'Postman / Swagger',
    'BlazeMeter',
    'Amazon Q Developer',
  ],
};

const roles = <String>[
  'Flutter Developer',
  'Android Developer',
  'iOS Developer',
  'AI / ML Integrator',
  'IoT & BLE Developer',
];

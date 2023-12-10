// Dart Packages
import 'dart:async';

// Flutter Packages
import 'package:flutter/material.dart';

// This Package
import 'package:receive_sharing_intent_plus/receive_sharing_intent_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SharedMediaFile>? _sharedFiles;
  String? _sharedText;

  late StreamSubscription _intentMediaStreamSubscription;
  late StreamSubscription _intentTextStreamSubscription;

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentMediaStreamSubscription =
        ReceiveSharingIntentPlus.getMediaStream().listen(
      (List<SharedMediaFile> value) {
        setState(() {
          _sharedFiles = value;
          debugPrint(
            'Shared:${_sharedFiles?.map((f) => f.path).join(',') ?? ''}',
          );
        });
      },
      onError: (err) {
        debugPrint('getIntentDataStream error: $err');
      },
    );

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntentPlus.getInitialMedia().then(
      (List<SharedMediaFile> value) {
        setState(() {
          _sharedFiles = value;
          debugPrint(
            'Shared:${_sharedFiles?.map((f) => f.path).join(',') ?? ''}',
          );
        });
      },
    );

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentTextStreamSubscription =
        ReceiveSharingIntentPlus.getTextStream().listen(
      (String value) {
        setState(() {
          _sharedText = value;
          debugPrint('Shared: $_sharedText');
        });
      },
      onError: (err) {
        debugPrint('getLinkStream error: $err');
      },
    );

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntentPlus.getInitialText().then((String? value) {
      setState(() {
        _sharedText = value;
        debugPrint('Shared: $_sharedText');
      });
    });
  }

  @override
  void dispose() {
    _intentMediaStreamSubscription.cancel();
    _intentTextStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ReceiveSharingIntentPlus Example'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shared files:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...?_sharedFiles?.map(
                (f) => ListTile(
                  title: Text(
                    f.type.toString().replaceFirst('SharedMediaType.', ''),
                  ),
                  subtitle: Text(f.path),
                ),
              ),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shared urls/text:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(_sharedText ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

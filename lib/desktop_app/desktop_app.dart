import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:practice_with_ostad/desktop_app/src/github_summary.dart';
import 'package:window_to_front/window_to_front.dart'; // Add this

import 'github_oauth_credentials.dart';
import 'src/github_login.dart';

void main() {
  runApp(const DesktopApp());
}

class DesktopApp extends StatelessWidget {
  const DesktopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GitHub Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        WindowToFront.activate();
        return Scaffold(
          // Modify from here
          appBar: AppBar(
            title: Text(title),
            elevation: 2,
          ),
          body: GitHubSummary(
            gitHub: _getGitHub(httpClient.credentials.accessToken),
          ),
        );
      }, // to here.
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}

GitHub _getGitHub(String accessToken) {
  // Modify from here
  return GitHub(auth: Authentication.withToken(accessToken));
}                                                                  // to here.
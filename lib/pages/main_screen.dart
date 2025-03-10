import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hallo Hans",
              style: TextTheme.of(context).bodyLarge,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text("Aktualisieren"))
          ],
        ),
      ),
    );
  }
}

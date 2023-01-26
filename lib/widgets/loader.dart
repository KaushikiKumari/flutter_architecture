import 'package:flutter/material.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.white,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )),
                  ),
                  Text('Loading...please wait!')
                ],
              ),
            )
          ],
        ));
  }
}

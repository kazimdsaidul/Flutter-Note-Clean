import 'package:flutter/material.dart';

void snackBarError({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
  scaffoldState!.currentState!.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$msg"),
        ],
      ),
    ),
  );

  void customProgress(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
              child: WillPopScope(
                onWillPop: () async => false,
                child: Container(
                  alignment: FractionalOffset.center,
                  height: 80.0,
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Loading..."),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_clean/app_const.dart';

import 'feature/presentation/pages/sing_in_page.dart';
import 'feature/presentation/pages/sing_up_page.dart';

class OnGenerateRouter {
  static Route<dynamic> route(RouteSettings settings){
    final args=settings.arguments;


    switch(settings.name){
      case PageConst.sigInPage:{
        return materialBuilder(widget: SignInPage());
        break;
      }
      case PageConst.signUpPage:{
        return materialBuilder(widget: SignUpPage());
        break;
      }
      case PageConst.addNotePage:{
        if (args is String) {
          // return materialBuilder(widget: AddNewNotePage(uid: args,));

          return materialBuilder(
            widget: ErrorPage(),
          );
        }
        else {
          return materialBuilder(
            widget: ErrorPage(),
          );
        }
        break;
      }
      // case PageConst.UpdateNotePage:{
      //   if (args is NoteEntity) {
      //     return materialBuilder(widget: UpdateNotePage(noteEntity: args,));
      //   }
      //   else {
      //     return materialBuilder(
      //       widget: ErrorPage(),
      //     );
      //   }
      //   break;
      // }
      default: return materialBuilder(widget: ErrorPage());
    }

  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

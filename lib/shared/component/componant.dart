import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';

pushPage(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

popPage(BuildContext context) {
  Navigator.pop(context);
}

void naigateAndRemove(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
// Form
Widget formFeild({
  @required String label,
  @required String hint,
  @required IconData prefix,
  @required TextEditingController controller,
  @required TextInputType type,
  Function onTap,
  Function onChange,
  @required Function validate,
  Function suffixPressed,
  @required bool isPassword,
  IconData suffix,
  bool isClickable = true,
  Function onSubmit,
}) =>
    Container(
      child: TextFormField(
        decoration: new InputDecoration(
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          prefixIcon: Icon(prefix),
          labelText: label,
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
        ),
        controller: controller,
        keyboardType: type,
        validator: validate,
        onTap: onTap,
        onChanged: onChange,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        obscureText: isPassword,
      ),
    );

Widget defultBottun({
  double height = 40,
  double width = double.infinity,
  @required Function function,
  @required String text,
}) =>
    Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

enum toastStates{ERROR,SUCCESS,WARNING}

Color chooseColor(toastStates state){
  Color color;
  switch(state){
    case toastStates.SUCCESS:
      color=Colors.green;
      break;
      case toastStates.WARNING:
      color=Colors.amber;
      break;
      case toastStates.ERROR:
      color=Colors.red;
      break;
  }
  return color;
}
Future showToast({
  @required String message,
  toastStates state,
  @required Toast time
})=>Fluttertoast.showToast(
    msg:message,
    toastLength: time,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

void signOut(context){
      CacheHelper.removeData(key: 'token').then((value) {
        if (value) {
          naigateAndRemove(context, LoginScreen());
        }
    },);
}

Widget myDivider()=>Container(
  height: 2,
  width: double.infinity,
  color: Colors.grey,
);

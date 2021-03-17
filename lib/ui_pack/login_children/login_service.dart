import 'package:uitemplate/pack/main_pack.dart';

class LoginService {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool showPassword = true;

  TextField get field => TextField(
    controller: this.email,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.person),
      suffixIcon: IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          this.email.clear();
        },
      ),
      labelText: "Email",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.0)
      )
    ),
  );
  TextField passwordField({Function onPress}) => TextField(
    controller: this.password,
    obscureText: this.showPassword,
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon: Icon(this.showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: onPress,
        ),
        labelText: "Password",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0)
        )
    ),
  );

}
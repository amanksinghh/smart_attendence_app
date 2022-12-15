import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController firstname = TextEditingController();
  bool togglevisibilty = false;
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/275623083_4821438907975269_5205010758757629932_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=btOY5t5WkE8AX9fNQWS&_nc_ht=scontent.fktm8-1.fna&oh=00_AT_MWF1G3xHUx19TO37cJyOoTMO3rQPqfkw9py8zkMFIDQ&oe=6235BAE9'),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                enabled: true,
                controller: emailcontroller,
                decoration: InputDecoration(
                    focusColor: Colors.green,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.green)),
                    hintText: " Enter the User Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                enabled: true,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value)) {
                    return 'Enter correct email';
                  } else {
                    return null;
                  }
                },
                controller: emailcontroller,
                decoration: InputDecoration(
                    focusColor: Colors.green,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.green)),
                    hintText: " Enter the Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: togglevisibilty,
                keyboardType: TextInputType.visiblePassword,
                validator: (password) => password != null && password.length < 5
                    ? 'Enter the min 5 password'
                    : null,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  focusColor: Colors.green,
                  labelText: "Enter the Password",
                  hintText: " Enter the password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        togglevisibilty = !togglevisibilty;
                      });
                    },
                    icon: togglevisibilty
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildbutton(),
          ]),
        ),
      ),
    );
  }

  buildbutton() {
    return GestureDetector(
      onTap: () {
        if (formkey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful'),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
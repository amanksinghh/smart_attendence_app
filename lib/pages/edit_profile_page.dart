import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:smart_attendence_app/theme/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_attendence_app/model/user.dart';
import 'package:smart_attendence_app/utils/user_preferences.dart';
import 'package:smart_attendence_app/widgets/numbers_widgets.dart';
import 'package:smart_attendence_app/widgets/profile_edit_widget.dart';
import 'package:smart_attendence_app/widgets/textform_field_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final icon = CupertinoIcons.moon_stars;
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          //backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            ThemeSwitcher(
              builder: (context) => IconButton(
                icon: Icon(icon),
                onPressed: () {
                  final theme =
                      isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

                  final switcher = ThemeSwitcher.of(context)!;
                  switcher.changeTheme(theme: theme);
                },
              ),
            ),
          ],
        ),
        // AppBar(
        //   title: Container(height: 60,child: Image.asset('assets/images/logo.png')),
        // ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 20),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {
                //Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: user.email,
              onChanged: (email) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'About',
              text: user.about,
              maxLines: 5,
              onChanged: (about) {},
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: (){}, child: Container(child: Text('SUBMIT')))
          ],
        ),
      ),
    );
  }
}

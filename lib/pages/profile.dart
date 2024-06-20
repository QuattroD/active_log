import 'dart:io';

import 'package:active_log/pages/auth.dart';
import 'package:active_log/services/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _uploadedFileURL = '';
  String _avatar = '';
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _selectedGender = 'Мужчина';
  String _selectedGoal = 'Сбросить вес';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void loadUserData() async {
    // Получаем документ пользователя из Firestore
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          _ageController.text = snapshot.get('age').toString();
          _weightController.text = snapshot.get('weight').toString();
          _heightController.text = snapshot.get('tall').toString();
          _selectedGender = snapshot.get('gender');
          _selectedGoal = snapshot.get('goal');
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> saveUserData() async {
    // Обновляем данные пользователя в Firestore
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'age': int.parse(_ageController.text),
        'weight': double.parse(_weightController.text),
        'height': double.parse(_heightController.text),
        'gender': _selectedGender,
        'goal': _selectedGoal,
      });

      Navigator.pop(context); // Закрываем модальное окно после сохранения
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;

        setState(() {
          _avatar = data['avatar'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading advertisement data: $e');
    }
  }

  Future chooseFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadFile() async {
    if (_image == null) return;
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;
      String fileURL = await storageReference.getDownloadURL();
      setState(() {
        _uploadedFileURL = fileURL;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 251),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Профиль'),
        leading: const SizedBox(),
        toolbarHeight: 70,
        actions: [
          IconButton(
              onPressed: () async {
                loadUserData();
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      height: 450,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Возраст',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextField(
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Рост',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextField(
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Вес',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: DropdownButtonFormField<String>(
                              value: _selectedGender,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGender = newValue!;
                                });
                              },
                              items: ['Мужской', 'Женский']
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              decoration: const InputDecoration(labelText: 'Пол'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: DropdownButtonFormField<String>(
                              value: _selectedGoal,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGoal = newValue!;
                                });
                              },
                              items: [
                                'Сбросить вес',
                                'Набрать массу',
                                'Поддерживать себя в форме'
                              ]
                                  .map((goal) => DropdownMenuItem(
                                        value: goal,
                                        child: Text(goal),
                                      ))
                                  .toList(),
                              decoration:
                                  const InputDecoration(labelText: 'Цель'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: const BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: TextButton(
                                onPressed: saveUserData,
                                child: const Text('Сохранить', style: TextStyle(color: Colors.white, fontSize: 20),)),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 28,
              )),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await chooseFile();
                        await uploadFile();
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 70, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName
                              .toString(),
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                            FirebaseAuth.instance.currentUser!.email.toString())
                      ],
                    ))
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      FirebaseAuth.instance.currentUser!.email.toString())
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var snap = snapshot.data!;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20)),
                        Container(
                          width: 80,
                          height: 100,
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.grey))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text('Вес',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100)))),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text('${snap['weight']}',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold))),
                              const Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text('Кг',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100))))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20)),
                        Container(
                          width: 80,
                          height: 100,
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1, color: Colors.grey))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text('Возраст',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100)))),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text('${snap['age']}',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold))),
                              const Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text('Лет',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100))))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20)),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text('Рост',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100)))),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text('${snap['tall']}',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold))),
                              const Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text('См',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100))))
                            ],
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('Пол', style: TextStyle(fontSize: 20)))
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 228, 214, 255),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('${snap['gender']}',
                                  style: const TextStyle(fontSize: 20))),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('Цель', style: TextStyle(fontSize: 20)))
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 228, 214, 255),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              Icons.rocket_launch,
                              size: 28,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('${snap['goal']}',
                                  style: const TextStyle(fontSize: 20))),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            GestureDetector(
              onTap: () async {
                await UserPreferences.deleteUserUid();
                firebaseService.logOut();
                Navigator.popAndPushNamed(context, '/');
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 215, 215),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.exit_to_app_outlined,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Выйти из аккаунта',
                            style: TextStyle(fontSize: 20))),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 64)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

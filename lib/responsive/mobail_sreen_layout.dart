import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netschool/screens/profile_screen.dart';
// import 'package:provider/provider.dart';
// import '../model/user.dart' as model;
import '../utils/colors.dart';

class MobailScreenLayout extends StatefulWidget {
  const MobailScreenLayout({super.key});

  @override
  State<MobailScreenLayout> createState() => _MobailScreenLayoutState();
}

class _MobailScreenLayoutState extends State<MobailScreenLayout> {
  int _page = 0;
  late PageController pageController; //контролер для управления страницами

  //происходит инициализация pageController с помощью PageController().
  //Этот метод вызывается при создании виджета и выполняется перед тем,
  //как виджет будет построен на экране.
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  //вызовем  dispose когда виджет удаляется с экрана чтобы отчистить ресурсы
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  //вызывается при нажатии на элемент
  void navigatorBarTapped(int page) {
    pageController.jumpToPage(page);
  }

  //обновляет значение _page и вызывает setState(),
  //чтобы обновить пользовательский интерфейс и отразить изменения текущей страницы.
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const Center(
            child: Text(
              'Вы вошли в аккаунт',
              style: TextStyle(fontFamily: 'WorkSans'),
            ),
          ),
          ProfileScreen(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ], //функция которая во время стейта предает page
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: whiteColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? blueColor : secondaryColor,
            ),
            label: '',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 1 ? blueColor : secondaryColor,
            ),
            label: '',
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: navigatorBarTapped,
      ),
    );
  }
}

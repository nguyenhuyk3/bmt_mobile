part of 'app.main.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: IndexedStack(
              index: selectedIndex,
              children: [
                // Home Tab with its own Navigator
                Navigator(
                  key: GlobalKey<NavigatorState>(),
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => SCREENS[0],
                      settings: settings,
                    );
                  },
                ),
                // Profile Tab with its own Navigator
                Navigator(
                  key: GlobalKey<NavigatorState>(),
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => SCREENS[1],
                      settings: settings,
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Cá nhân',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Color(0xFF0D7C66),
              unselectedItemColor: Colors.grey,
              onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
            ),
          );
        },
      ),
    );
  }
}

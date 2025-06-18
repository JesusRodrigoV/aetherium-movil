import 'package:aetherium_movil/features/home/home_page.dart';
import 'package:aetherium_movil/features/notes/presentation/edit_note.dart';
import 'package:aetherium_movil/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    if (page < 2) {
      setState(() {
        _currentPage = page;
      });
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: myDrawer(context),
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: const Text('Aetherium'),
                floating: true,
                snap: true,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  tooltip: 'Abrir menú',
                ),
              ),
            ],
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: const [HomePage(), Settings()],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            IconButton(
              icon: Icon(Icons.search, color: theme.colorScheme.primary),
              tooltip: 'Buscar notas',
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Buscar notas')));
                // TODO: Implementar lógica de búsqueda
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: theme.colorScheme.primary),
              tooltip: 'Crear nueva nota',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditNote()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.sync, color: theme.colorScheme.primary),
              tooltip: 'Sincronizar notas',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sincronizar notas')),
                );
                // TODO: Implementar lógica de sincronización
              },
            ),
          ],
        ),
      ),
    );
  }

  Drawer myDrawer(BuildContext context) {
    return Drawer(
      width: 280,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Aetherium',
                    style: GoogleFonts.pacifico(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  title: 'Inicio',
                  isActive: _currentPage == 0,
                  onTap: () => _navigateToPage(0),
                ),
                const SizedBox(height: 4),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                  title: 'Ajustes',
                  isActive: _currentPage == 1,
                  onTap: () => _navigateToPage(1),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    IconData? activeIcon,
    required String title,
    bool isActive = false,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: isActive ? colorScheme.primary.withAlpha(70) : Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(
                isActive ? activeIcon ?? icon : icon,
                color:
                    isLogout
                        ? Colors.redAccent
                        : isActive
                        ? colorScheme.primary
                        : Theme.of(context).iconTheme.color,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      isLogout
                          ? Colors.redAccent
                          : isActive
                          ? colorScheme.primary
                          : null,
                  fontWeight: isActive ? FontWeight.w600 : null,
                ),
              ),
              const Spacer(),
              if (!isLogout)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color:
                      isActive
                          ? colorScheme.primary
                          : Theme.of(context).iconTheme.color?.withAlpha(80),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

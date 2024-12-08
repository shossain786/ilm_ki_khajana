// ignore_for_file: must_be_immutable
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:ilm_ki_khajana/error_screen.dart';
import 'package:ilm_ki_khajana/modules/irshadaat/screens/irshadat_e_maula_ali.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.video_library_sharp,
        'label': 'Irshadat',
        'route': '/tafseer'
      },
      {
        'icon': FlutterIslamicIcons.quran,
        'label': 'Dars e Hadis',
        'route': '/send'
      },
      {'icon': Icons.video_collection_sharp, 'label': 'DBS', 'route': '/dbs'},
      {'icon': Icons.library_music_rounded, 'label': 'Naat', 'route': '/naat'},
      {
        'icon': Icons.record_voice_over,
        'label': 'Recorder',
        'route': '/recorder'
      },
      {
        'icon': FlutterIslamicIcons.tasbih3,
        'label': 'Tasbih',
        'route': '/tasbih'
      },
      {
        'icon': FlutterIslamicIcons.prayer,
        'label': 'Masnoon Dua',
        'route': '/dua'
      },
      {'icon': FlutterIslamicIcons.iftar, 'label': 'Tasks', 'route': '/task'},
      {
        'icon': FlutterIslamicIcons.quran2,
        'label': 'Kitaab Library',
        'route': '/library'
      },
      {
        'icon': Icons.local_activity_outlined,
        'label': 'My Activities',
        'route': '/activity'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashbord'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.mode_night))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LiveGrid.options(
          options: const LiveOptions(
            delay: Duration(milliseconds: 100),
            showItemInterval: Duration(milliseconds: 100),
            showItemDuration: Duration(milliseconds: 250),
            visibleFraction: 0.05,
            reAnimateOnVisibility: true,
          ),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index, animation) {
            final item = items[index];
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: _buildGridItem(context, item['icon'] as IconData,
                    item['label'] as String, item['route'] as String),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        switch (route) {
          case '/naat':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IrshadateAliPage()));
            break;
          case '/tafseer':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IrshadateAliPage()));
            break;
          case '/dbs':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IrshadateAliPage()));
            break;
          case '/tasbih':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IrshadateAliPage()));
            break;
          case '/library':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IrshadateAliPage()),
            );
            break;
          case '/task':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IrshadateAliPage()),
            );
          case '/activity':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IrshadateAliPage()),
            );
            break;
          default:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ErrorScreen()));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30.0,
            backgroundColor: const Color.fromARGB(255, 7, 55, 95),
            child: Icon(
              icon,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(label, style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}

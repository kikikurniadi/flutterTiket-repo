import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'event_detail_page.dart';


class HomePage extends StatelessWidget {
  // Daftar event contoh
  final List<Event> events = [
    Event(
      title: 'Playlist Live Festival',
      image: 'assets/images/Musik.jpg',
      date: '09 Nov 2024',
      location: 'Bandung',
      description: 'Diselenggarakan oleh Djojokarsono Group',
    ),
    Event(
      title: 'Scent of Indonesia',
      image: 'assets/images/seminarSeni.jpg',
      date: '1 Jan 2024',
      location: 'Bandung',
      description: 'Diselenggarakan oleh Scent of Indonesia',
    ),
    Event(
      title: 'Loket Musik',
      image: 'assets/images/Banner.jpg',
      date: '9 Jan 2024',
      location: 'Jakarta',
      description: 'Diselenggarakan oleh Loket Musik',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Tambahkan fungsi pencarian
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner atau Carousel
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Image.asset('assets/images/BOM.jpg')
                ),
            ),
            SizedBox(height: 15),
            // Kategori
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard('Musik', Icons.music_note),
                  _buildCategoryCard('Seni', Icons.palette),
                  _buildCategoryCard('Olahraga', Icons.sports_soccer),
                  _buildCategoryCard('Ilmu', Icons.book)
                ],
              ),
            ),
            SizedBox(height: 16),
            // Daftar Event
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: events.map((event) {
                  return EventCard(
                    event: event,
                    onTap: () {
                      // Navigasi ke halaman detail event
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailPage(event: event),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(left: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

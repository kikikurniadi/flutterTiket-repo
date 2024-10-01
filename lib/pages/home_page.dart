import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'event_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Semua';
  List<String> categories = ['Semua', 'Musik', 'Seni', 'Olahraga', 'Ilmu'];
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  
  // Daftar event contoh
  final List<Event> allEvents = [
    Event(
      title: 'Playlist Live Festival',
      image: 'assets/images/Musik.jpg',
      date: '09 Nov 2024',
      location: 'Bandung',
      description: 'Diselenggarakan oleh Djojokarsono Group',
      category: 'Musik',
      price: 150000,
    ),
    Event(
      title: 'Scent of Indonesia',
      image: 'assets/images/seminarSeni.jpg',
      date: '1 Jan 2024',
      location: 'Bandung',
      description: 'Diselenggarakan oleh Scent of Indonesia',
      category: 'Seni',
      price: 100000,
    ),
    Event(
      title: 'Loket Musik',
      image: 'assets/images/Banner.jpg',
      date: '9 Jan 2024',
      location: 'Jakarta',
      description: 'Diselenggarakan oleh Loket Musik',
      category: 'Musik',
      price: 200000,
    ),
  ];

  List<Event> get filteredEvents {
    return allEvents.where((event) {
      final matchesCategory = selectedCategory == 'Semua' || event.category == selectedCategory;
      final matchesSearch = event.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiket'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari event...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Event List
          Expanded(
            child: filteredEvents.isEmpty
                ? const Center(
                    child: Text('Tidak ada event yang ditemukan'),
                  )
                : ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return EventCard(
                        event: event,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailPage(event: event),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
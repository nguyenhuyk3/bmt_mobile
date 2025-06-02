import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Avengers: Infinity War',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '2h29m • 16.12.2022',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  const Text('4.8 ', style: TextStyle(color: Colors.white)),
                  const Text('(1.2k)', style: TextStyle(color: Colors.grey)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Watch trailer'),
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              InfoRow(
                label: 'Movie genre:',
                value:
                    'Action, adventure, sci-fi, superhero, multiverse, drama, comedy',
              ),
              InfoRow(label: 'Censorship:', value: '13+'),
              InfoRow(label: 'Language:', value: 'English'),
              const SizedBox(height: 10),
              const Text(
                'Storyline',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'As the Avengers and their allies have continued to protect the world from threats too large... ',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              buildPeopleSection('Director', [
                {
                  'name': 'Anthony Russo',
                  'img': 'https://i.pravatar.cc/100?img=11',
                },
                {
                  'name': 'Joe Russo',
                  'img': 'https://i.pravatar.cc/100?img=12',
                },
              ]),
              buildPeopleSection('Actor', [
                {
                  'name': 'Robert Downey Jr.',
                  'img': 'https://i.pravatar.cc/100?img=1',
                },
                {
                  'name': 'Chris Hemsworth',
                  'img': 'https://i.pravatar.cc/100?img=2',
                },
                {
                  'name': 'Chris Evans',
                  'img': 'https://i.pravatar.cc/100?img=3',
                },
              ]),
              const SizedBox(height: 10),
              const Text(
                'Cinema',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              buildCinemaItem(
                'Vincom Ocean Park CGV',
                '4.56 km • B1 Tôn Gia Lâm, Hà Nội',
                true,
              ),
              buildCinemaItem(
                'Aeon Mall CGV',
                '9.32 km • 12 Cổ Linh, Long Biên, Hà Nội',
              ),
              buildCinemaItem(
                'Lotte Cinema Long Biên',
                '14.3 km • 7-9 Nguyễn Văn Linh, Long Biên, Hà Nội',
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text('Continue'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPeopleSection(String title, List<Map<String, String>> people) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children:
            people.map((person) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(person['img']!),
                      radius: 24,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 60,
                      child: Text(
                        person['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    ],
  );
}

Widget buildCinemaItem(
  String name,
  String location, [
  bool highlighted = false,
]) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color:
          highlighted
              ? Colors.amber.shade100.withOpacity(0.2)
              : Colors.grey.shade900,
      border: Border.all(
        color: highlighted ? Colors.amber : Colors.transparent,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          location,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    ),
  );
}

class InfoRow extends StatefulWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  State<InfoRow> createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> {
  bool expanded = false;
  bool overflow = false;

  final TextStyle valueStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkOverflow());
  }

  void checkOverflow() {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.value, style: valueStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(
      maxWidth: MediaQuery.of(context).size.width - 150,
    ); // trừ label width + padding

    if (textPainter.didExceedMaxLines) {
      setState(() {
        overflow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              widget.label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.value,
                  style: valueStyle,
                  maxLines: expanded ? null : 1,
                  overflow:
                      expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
                if (overflow && !expanded)
                  GestureDetector(
                    onTap: () => setState(() => expanded = true),
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(color: Colors.amber, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

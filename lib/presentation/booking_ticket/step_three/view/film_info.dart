part of 'view.dart';

class _MovieInfoCard extends StatelessWidget {
  const _MovieInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_FilmPoster(), SizedBox(width: 16), _FilmDetails()],
      ),
    );
  }
}

class _FilmPoster extends StatelessWidget {
  const _FilmPoster();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 120,
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8B0000), Color(0xFFFF4500), Color(0xFFFFD700)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                  ),
                ),
              ),
            ),
            // Avengers logo simulation
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield, color: Colors.white, size: 30),

                  SizedBox(height: 8),

                  Text(
                    'AVENGERS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'INFINITY WAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilmDetails extends StatelessWidget {
  const _FilmDetails();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 12, 0, 10),
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // film title
            Text(
              'Avengers: Infinity War',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // film details with icons
            Column(
              children: [
                _FilmDetailRow(
                  icon: Icons.movie_creation_outlined,
                  text: 'Action, adventure, sci-fi',
                ),

                SizedBox(height: 8),

                _FilmDetailRow(
                  icon: Icons.location_on_outlined,
                  text: 'Vincom Ocean Park CGV',
                ),

                SizedBox(height: 8),

                _FilmDetailRow(
                  icon: Icons.access_time,
                  text: '10.12.2022 • 14:15',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilmDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FilmDetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18),

        SizedBox(width: 10),
        
        Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}

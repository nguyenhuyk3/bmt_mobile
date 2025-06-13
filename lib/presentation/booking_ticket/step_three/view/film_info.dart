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
        children: [_FilmPoster(), SizedBox(width: 8), _FilmDetails()],
      ),
    );
  }
}

class _FilmPoster extends StatelessWidget {
  const _FilmPoster();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTicketBloc, BookingTicketState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 120,
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8B0000),
                  Color(0xFFFF4500),
                  Color(0xFFFFD700),
                ],
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
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                // Display poster from URL or fallback
                if (state.film.posterUrl.isNotEmpty)
                  Positioned.fill(
                    child: Image.network(
                      state.film.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => _FallbackPoster(),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                          ),
                        );
                      },
                    ),
                  )
                else
                  _FallbackPoster(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FallbackPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie, color: Colors.white, size: 30),

          SizedBox(height: 8),

          Text(
            'Poster bị lỗi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilmDetails extends StatelessWidget {
  const _FilmDetails();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTicketBloc, BookingTicketState>(
      builder: (context, state) {
        final film = state.film;

        return Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 10),
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // film title
                Text(
                  film.title.isNotEmpty ? film.title : '',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 4),

                // film details with icons
                Column(
                  children: [
                    _FilmDetailRow(
                      icon: Icons.movie_creation_outlined,
                      text:
                          film.genres.isNotEmpty ? film.genres.join(', ') : '',
                    ),

                    SizedBox(height: 10),

                    _FilmDetailRow(
                      icon: Icons.access_time,
                      text:
                          film.duration.isNotEmpty
                              ? '${state.showDate}  - ${state.startTime}'
                              : '',
                    ),

                    SizedBox(height: 10),

                    _FilmDetailRow(
                      icon: Icons.calendar_today,
                      text: film.releaseDate.isNotEmpty ? film.releaseDate : '',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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

        SizedBox(width: 4),

        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

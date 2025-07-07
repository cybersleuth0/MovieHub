import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AppConstant/urls.dart';
import '../Bloc/MovieDetailsBloc/movieDetailsBloc.dart';
import '../Bloc/MovieDetailsBloc/movieDetailsEvent.dart';
import '../Bloc/MovieDetailsBloc/movieDetailsState.dart';
import '../Bloc/MovieLoadBloc/movies_state.dart'; // Ensure this points to your MovieModel

class MovieDetailsPage extends StatefulWidget {
  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late final int movieID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as int;
      movieID = args;
      context.read<MovieDetailsBloc>().add(
        GetMovieDetailsEvent(movieId: movieID),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsSuccessState) {
          return Scaffold(
            backgroundColor: const Color(0xff121012),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              automaticallyImplyLeading: true,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                state.movieDetails.title ?? 'Movie',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height:20),
                  // Poster with Gradient
                  Stack(
                    children: [
                      Container(
                        height: 500,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              Urls.getPosterImage +
                                  state.movieDetails.posterPath,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      // Top Gradient
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Bottom Gradient & Title
                      Positioned(
                        bottom: -20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(1),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  state.movieDetails.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    height: 1.7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Tagline
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                    child: Text(
                      '"${state.movieDetails.tagline ?? ""}"',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  // Description
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12.0 : 16.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      state.movieDetails.overview.isNotEmpty
                          ? state.movieDetails.overview
                          : "No description available.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                        fontSize: isMobile ? 15 : 17,
                        height: isMobile ? 1.5 : 1.6,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 10 : 20),
                  // Movie Metadata
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          "Release Date",
                          state.movieDetails.releaseDate,
                        ),
                        _buildDivider(),
                        _buildInfoRow("Status", state.movieDetails.status),
                        _buildDivider(),
                        _buildInfoRow(
                          "Adult Content",
                          state.movieDetails.adult ? "Yes" : "No",
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          "Language",
                          state.movieDetails.originalLanguage.toUpperCase(),
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          "Runtime",
                          "${state.movieDetails.runtime} minutes",
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          "Budget",
                          "\$${_formatCurrency(state.movieDetails.budget)}",
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          "Revenue",
                          "\$${_formatCurrency(state.movieDetails.revenue)}",
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          "Popularity",
                          state.movieDetails.popularity.toStringAsFixed(1),
                        ),
                        SizedBox(height: isMobile ? 10 : 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is MovieDetailsErrorState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
        return Container();
      },
    );
  }

  // Helper method to create a divider
  Widget _buildDivider() {
    return Divider(
                          color: Colors.grey.withOpacity(0.7),
                          thickness: 2,
                        );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: GoogleFonts.openSans(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

String _formatCurrency(int value) {
  return value.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}

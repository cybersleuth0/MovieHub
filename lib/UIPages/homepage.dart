import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieshub/AppConstant/urls.dart';
import 'package:movieshub/Bloc/MovieLoadBloc/movies_bloc.dart';
import 'package:movieshub/Bloc/MovieLoadBloc/movies_state.dart';

import '../AppConstant/constant.dart';
import '../Bloc/MovieLoadBloc/movies_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(GetMoviesEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      final bloc = BlocProvider.of<MoviesBloc>(context);
      final currentState = bloc.state;

      if (currentState is HomepageInitailStae && !currentState.isLoadingMore) {
        bloc.add(GetMoreMoviesEvent());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A0F1A), Color(0xFF212121)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("Assets/Images/user.png", fit: BoxFit.cover),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Ayush",
                      style: GoogleFonts.actor(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.notifications_active, color: Colors.white),
                  onPressed: () {
                    // Handle notification icon tap
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          controller: _scrollController,
          children: [
            SizedBox(height: 20),
            // Welcome message
            Text(
              "Find Your\nFavourite Movie!",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            SizedBox(height: 20),
            // Search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFF3A3F47),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search movies...",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state is HomepageInitailStae) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      // Movie Geners Name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Trending Movies",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: screenWidth < 600
                              ? 200
                              : (screenWidth < 900 ? 180 : 200),
                          crossAxisSpacing: 16,
                          mainAxisExtent: screenWidth < 600 ? 220 : 230,
                          mainAxisSpacing: 20,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            state.trendingMovies.length +
                            (state.isLoadingMore ? 1 : 0),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          if (index >= state.trendingMovies.length) {
                            return const Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                          final movie = state.trendingMovies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.ROUTE_MOVIE_DETAILS,
                                arguments: movie.id,
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Movie Poster
                                  Expanded(
                                    child: Image.network(
                                      Urls.getPosterImage + movie.posterPath,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),

                                  // Overlay with title & date
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    color: Colors.black.withOpacity(0.6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          movie.releaseDate,
                                          style: GoogleFonts.lato(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                if (state is ErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<MoviesBloc>().add(GetMoviesEvent()),
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return Container(color: Colors.red);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

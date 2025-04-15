class APIConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String nowPlayingEndpoint = "/movie/now_playing";
  static const String movieDetailsEndpoint = "/movie";

  // imagens
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/";
  static const String posterSizeW200 = "${imageBaseUrl}w200";
  static const String posterSizeW500 = "${imageBaseUrl}w500";
}

abstract class RickAndMortyApiInterface {
  getCharacters({
    int? page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });
  getSingleCharacter({required String id});
}

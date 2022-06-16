import 'package:desafio_eduq/models/result_search_characters_model.dart';
import 'package:desafio_eduq/services/api/rick_and_morty/rick_morty_api_repository.dart';
import 'package:graphql/client.dart';

class RickAndMortyApiRepository implements RickAndMortyApiInterface {
  late GraphQLClient client;

  initRepo() async {
    client = GraphQLClient(
      link: HttpLink('https://rickandmortyapi.com/graphql'),
      cache: GraphQLCache(),
    );
  }

  RickAndMortyApiRepository() {
    initRepo();
  }

  @override
  getCharacters({
    int? page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    var result = await client.query(
      QueryOptions(document: gql(r'''
       query GetCharacters($page: Int, $name: String, $status: String, $species: String, $type: String, $gender: String) {
        characters(page: $page, filter: { name: $name, status: $status, species: $species, type: $type, gender: $gender })  {
          info {
            count
          }
          results {
            id,
            name,
            status,
            species,
            type,
            gender,
            image,
            created
          }
        }
      }
      '''), variables: {
        "page": page,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
      }),
    );
    if (result.data != null) {
      ResultSearchCharacters resultSearchCharacters =
          ResultSearchCharacters.fromJson(result.data!["characters"]);
      return resultSearchCharacters;
    }
    return null;
  }
}

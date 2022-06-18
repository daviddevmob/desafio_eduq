import 'package:desafio_eduq/models/character_model.dart';
import 'package:desafio_eduq/models/result_search_characters_model.dart';
import 'package:desafio_eduq/services/routes/api_endpoints.dart';
import 'package:graphql/client.dart';

import 'rick_morty_api_repository_interface.dart';

class RickAndMortyApiRepository implements RickAndMortyApiInterface {
  late GraphQLClient client;

  initRepo() async {
    client = GraphQLClient(
      link: HttpLink(APIEndPoints.BASE_URL),
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
            image,
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

  @override
  getSingleCharacter({required String id}) async {
    var result = await client.query(
      QueryOptions(document: gql(r'''
      query GetCharacters($id: ID!) {
        character(id: $id){
          id
          name
          status
          species
          type
          gender
          image
          created
          location {
            name
          }
          origin{
            name
          }
          episode{
            id
            name
            air_date
            episode
            characters {
              name
              image
              id
            }
          }
        }
      }
'''), variables: {
        "id": int.parse(id),
      }),
    );
    if (result.data != null) {
      CharacterModel newCharacter =
          CharacterModel.fromJson(result.data!["character"]);
      return newCharacter;
    }
    return null;
  }
}

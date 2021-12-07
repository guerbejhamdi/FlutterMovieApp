import 'package:movie_streaming/model/person_response.dart';
import 'package:movie_streaming/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonListBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
   BehaviorSubject<PersonResponse>(); 


  getPersons() async {
    PersonResponse response = await _repository.getPersons();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personsBloc = PersonListBloc();
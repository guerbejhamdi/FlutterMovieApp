import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_streaming/bloc/get_persons_bloc.dart';
import 'package:movie_streaming/model/person.dart';
import 'package:movie_streaming/model/person_response.dart';
import 'package:movie_streaming/style/theme.dart' as Style;

class PersonsList extends StatefulWidget {
  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personsBloc..getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "TRENDING PERSONS ON THIS WEEK",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<PersonResponse>(
            stream: personsBloc.subject.stream,
            builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error != null &&
                    snapshot.data!.error.length > 0) {
                  return _buildErrorWidget(snapshot.data!.error);
                }
                return _buildPersonsWidget(snapshot.data!);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error.toString());
              } else {
                return _buildLoadingWidget();
              }
            })
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Error Occured : $error")],
      ),
    );
  }

  Widget _buildPersonsWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    return Container(
      height: 130.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
          itemCount: persons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 100.0,
              padding: EdgeInsets.only(top: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  persons[index].profileImg == null
                      ? Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Style.Colors.secondColor),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200" +
                                          persons[index].profileImg),
                                  fit: BoxFit.cover)),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    persons[index].name,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text("Trending for ${persons[index].known}" , style: TextStyle(
                    color: Style.Colors.titleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 7.0
                  ),),
                ],
              ),
            );
          }),
    );
  }
}

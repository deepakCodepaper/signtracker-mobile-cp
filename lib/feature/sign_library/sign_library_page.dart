import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signtracker/api/model/sign_masters.dart';
import 'package:signtracker/blocs/sign_library/sign_library_bloc.dart';
import 'package:signtracker/blocs/sign_library/sign_library_states.dart';
import 'package:signtracker/repository/sign_repository.dart';
import 'package:signtracker/styles/values/values.dart';
import 'package:signtracker/utilities/photo_util.dart';
import 'package:signtracker/widgets/app_bar.dart';
import 'package:path/path.dart' as p;

import 'add_sign_library_page.dart';

class SignLibraryPage extends StatefulWidget {
  static const String route = '/sign-library';

  @override
  State<StatefulWidget> createState() => _SignLibraryPageState();
}

class _SignLibraryPageState extends State<SignLibraryPage> {
  SignLibraryBloc bloc;
  List<SignMasters> signs;
  TextEditingController searchController;
  String queryText = "";
  Directory dir;

  @override
  void initState() {
    bloc = SignLibraryBloc(RepositoryProvider.of<SignRepository>(context));
//    signs.add('barricade.jpg');
//    signs.add('be-prepared-to-stop.jpg');
//    signs.add('begin-detour-300m.jpg');
//    signs.add('bridge-construction.jpg');
//    signs.add('construction.jpg');
//    signs.add('detour.jpg');
//    signs.add('one-lane-traffic.jpg');
//    signs.add('utility-construction.jpg');
//    signs.add('RB-1-110');
//    signs.add('RB-1-50');
//    signs.add('RB-1-80');
//    signs.add('RB-31');
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => bloc.getallSignMasters());

    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() => queryText = searchController.text);
    });

    loadAppDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignTrackerAppBar.createAppBar(context, 'Sign Library'),
      body: BlocBuilder<SignLibraryBloc, SignLibraryState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SignsLibraryLoading) {
            return Center(
              child: Theme(
                data: Theme.of(context).copyWith(
                  accentColor: AppColors.yellowPrimary,
                ),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is SignsLibraryLoaded) {
            signs = state.signs;
            print(signs.length);
          }

          if (state is SignLibraryError) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state is SignsLibraryLoaded) ...[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                            gapPadding: 0.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                            gapPadding: 0.0,
                          ),
                          hintText: 'Sign Name',
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.all(10),
                      crossAxisCount: 2,
                      children: [
                        ...signs
                            .where((sign) =>
                                sign.name.startsWith(queryText.toLowerCase()))
                            .map(
                              (sign) => GestureDetector(
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch, //add this
                                      children: <Widget>[
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: sign.imageUrl != null
                                                ? sign.imageUrl
                                                : 'http://portal.thesigntracker.com/images/signs/no-sign.png',
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) => Center(
                                              child: Image.asset(
                                                'assets/drawables/no-sign.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(sign.name),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print('test');
                                  }),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  File file(String filename) {
    String pathName = p.join(dir.path, filename);
    return File(pathName);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void loadAppDirectory() async {
    dir = await getApplicationDocumentsDirectory();
  }
}

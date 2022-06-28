import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/pokedex_provider.dart';
import '../../menu/menu.dart';
import '../widgets/loading_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: Text(title),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PokedexProvider(),
            )
          ],
          child: const HomeBody(),
        ));
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ScrollController scrollController;
  //Scroll detection when scroll reached bottom
  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      final prov = context.watch<PokedexProvider>();
      if (prov.getFetching == false) {
        prov.setFetching(true);
        prov.getPokemon();
      }
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokedexProv = context.watch<PokedexProvider>();
    if (pokedexProv.getPokedex.isEmpty) {
      pokedexProv.getPokemon();
    }

    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Pokemon List",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            pokedexProv.getPokedex.isNotEmpty
                ? const PokedexList()
                : const Center(
                    child: LoadingAnimation(),
                  )
          ],
        ),
      ),
    );
  }
}

class PokedexList extends StatelessWidget {
  const PokedexList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PokedexProvider>(
      builder: (context, pokedexProv, child) {
        return Column(
          children: <Widget>[
            Container(
              child: ListView.builder(
                itemCount: pokedexProv.getPokedex.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  var data = pokedexProv.getPokedex[index];
                  return Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(11),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Colors.black26,
                                    offset: Offset(5.0, 5.0))
                              ]),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: Colors.blue,
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 15,
                                                color: Colors.black26,
                                                offset: Offset(5.0, 5.0))
                                          ],
                                          gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            stops: [0.1, 0.5, 0.7, 0.9],
                                            colors: [
                                              Color.fromARGB(255, 212, 10, 145),
                                              Color.fromARGB(255, 54, 83, 107),
                                              Color.fromARGB(255, 79, 119, 151),
                                              Color.fromARGB(255, 36, 111, 173),
                                            ],
                                          )),
                                      child: Image.network(
                                        data.image,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              ),
            ),
            pokedexProv.getFetching == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        );
      },
    );
  }
}

import 'package:dictapp/detail_page.dart';
import 'package:dictapp/words.dart';
import 'package:dictapp/wordsdao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isSearchMade = false;
  String searchWord = "";

  Future<List<Words>> showAllWords() async {
    var wordsList = await Wordsdao().allWords();
    return wordsList;
  }

  Future<List<Words>> search(String searchWord) async {
    var wordsList = await Wordsdao().searchWord(searchWord);
    return wordsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchMade
            ? TextField(
                decoration: const InputDecoration(
                    hintText: "Enter the word to the search."),
                onChanged: (searchResult) {
                  debugPrint("Search Result : $searchResult");
                  setState(() {
                    searchWord = searchResult;
                  });
                },
              )
            : const Text("Dictapp"),
        actions: [
          isSearchMade
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearchMade = false;
                      searchWord = "";
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearchMade = true;
                    });
                  },
                )
        ],
      ),
      body: FutureBuilder<List<Words>>(
          future: isSearchMade ? search(searchWord) : showAllWords(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var wordList = snapshot.data;
              return ListView.builder(
                itemCount: wordList?.length,
                itemBuilder: (context, index) {
                  var word = wordList![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(word: word),
                          ));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              word.english,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(word.turkhis),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          }),
    );
  }
}

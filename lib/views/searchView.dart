import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/objects/SearchData.dart';
import 'package:flutter/material.dart';
import 'package:epicture/objects/ImgurTag.dart';
import 'package:epicture/views/widgets/tagCard.dart';
import 'package:epicture/bloc/searchBloc.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ScrollController scrollController = ScrollController();
  final List<Widget> listData = [];
  bool isLoading = false;
  int listIndex = 0;
  List<ImgurTag> tagList = [];
  SearchBloc searchBloc;

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  Future<List<Widget>> getSomeImages(int number) async {
    List<Widget> list = [];
    int tmp = this.listIndex;
    int listSize = this.tagList.length;
    while (tmp < this.listIndex + number && tmp < listSize) {
      list.add(TagCard(
        tag: this.tagList[tmp],
      ));
      tmp++;
    }
    setState(() {
      this.listIndex = tmp;
    });
    return list;
  }

  Future<void> loadMore(int number) async {
    if (!this.isLoading) {
      setState(() {
        isLoading = true;
      });
      this.getSomeImages(number).then((list) {
        setState(() {
          debugPrint('old list lenght : ' + list.length.toString());
          this.listData..addAll(list);
          debugPrint('list length : ' + this.listData.length.toString());
        });
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    this.searchBloc = BlocProvider.of<SearchBloc>(context);
/*    this.scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        this.loadMore(2);
      }
    });*/
    ImgurAPI().getTags().then((tags) {
      setState(() {
        this.tagList = tags;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchData>(
      stream: searchBloc.outSearch,
      initialData: SearchData(toSearch: ''),
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Center(child: Text(snapshot.data.toSearch)),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: FutureBuilder<List<ImgurTag>>(
                future: ImgurAPI().getTags(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 2,
                        child: Center(child: CircularProgressIndicator()));
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return TagCard(tag: this.tagList[index]);
                    }
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
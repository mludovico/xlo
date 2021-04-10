import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/home_bloc.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/home/widgets/product_tile.dart';
import 'package:xlo/screens/home/widgets/search_dialog.dart';
import 'package:xlo/screens/home/widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeBloc _homeBloc;

  _openSearch(String currentText) async {
    final String search = await showDialog(
      context: context,
      builder: (context) => SearchDialog(
        currentSearch: currentText,
      ),
    );
    if(search != null)
      _homeBloc.setSearch(search);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final HomeBloc homeBloc = Provider.of<HomeBloc>(context);
    if(homeBloc != _homeBloc)
      _homeBloc = homeBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<String>(
          stream: _homeBloc.outSearch,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: snapshot.hasData && snapshot.data.isNotEmpty
                ?
              () => _openSearch(snapshot.data??'')
                :
              null,
              child: LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.biggest.width,
                  child: Text(
                    snapshot.hasData && snapshot.data.isNotEmpty ? snapshot.data : 'XLO',
                  ),
                ),
              ),
            );
          }
        ),
        actions: [
          StreamBuilder<String>(
            stream: _homeBloc.outSearch,
            builder: (context, snapshot) {
              if(!snapshot.hasData || snapshot.data.isEmpty)
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    _openSearch('');
                  },
                );
              else
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: (){
                    _homeBloc.setSearch('');
                  },
              );
            }
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          TopBar(),
          Expanded(
            child: StreamBuilder(
              stream: _homeBloc.outAds,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      ad: snapshot.data[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:cryptocurrency_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
 const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: ((context, marketProvider, child) {
        List<CryptoCurrency> favorites = marketProvider.markets.where((element) => element.isFavorite == true).toList();
      if(favorites.isNotEmpty){
        return RefreshIndicator(onRefresh: ()async{
          await marketProvider.fetchData();
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
          ),
          itemCount: favorites.length,
          itemBuilder: (context,index){
            CryptoCurrency currentCrypto = favorites[index];
            return CryptoListTile(currentCrypto: currentCrypto);
          }),
        );
      }else{
        return  Center(
          child: Text('No Favorite added yet!',style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.grey,
            fontSize: 20.0,
          ),),
        );
      }
     
      }),
    );
  }
}
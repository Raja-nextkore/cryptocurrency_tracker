import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/detailed_crypto_page.dart';

class CryptoListTile extends StatefulWidget {
  final CryptoCurrency currentCrypto;
  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  @override
  State<CryptoListTile> createState() => _CryptoListTileState();
}

class _CryptoListTileState extends State<CryptoListTile> {
  @override
  Widget build(BuildContext context) {
    var currentCrypto = widget.currentCrypto;
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailedCryptoPage(id: currentCrypto.id!)),
          ),
        );
      },
      contentPadding: const EdgeInsets.all(0.0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currentCrypto.name!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 18.0,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 18.0,
                    color: Colors.red,
                  ),
                ),
        ],
      ),
      subtitle: Text(
        currentCrypto.symbol!.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
            style: const TextStyle(
              color: Color(0xff0395eb),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Builder(
            builder: (context) {
              double priceChange = currentCrypto.priceChange24!;
              double priceChangePercentage =
                  currentCrypto.priceChangePercentage24!;
              if (priceChange < 0) {
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})',
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})',
                  style: const TextStyle(color: Colors.green),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

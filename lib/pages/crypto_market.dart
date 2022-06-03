import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/market_provider.dart';

class CryptoMarket extends StatefulWidget {
  const CryptoMarket({Key? key}) : super(key: key);

  @override
  State<CryptoMarket> createState() => _CryptoMarketState();
}

class _CryptoMarketState extends State<CryptoMarket> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: ((context, marketProvider, child) {
        if (marketProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }  else if
           (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = marketProvider.markets[index];
                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              ),
            );
          } else {
            return Center(
              child: Text(
                'Data not Found...',
                style: GoogleFonts.baloo2(
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }
}

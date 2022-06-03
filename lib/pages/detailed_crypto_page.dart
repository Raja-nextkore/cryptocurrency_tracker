import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedCryptoPage extends StatefulWidget {
  final String id;
  const DetailedCryptoPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailedCryptoPage> createState() => _DetailedCryptoPageState();
}

class _DetailedCryptoPageState extends State<DetailedCryptoPage> {
  Widget titleAndDetail(
      String? title, String? detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        Text(
          detail!,
          style:
              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Consumer<MarketProvider>(
            builder: ((context, marketProvider, child) {
              CryptoCurrency currentCrypto =
                  marketProvider.fetchCryptoById(widget.id);
              return RefreshIndicator(
                onRefresh: () async {
                  await marketProvider.fetchData();
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(
                        "${currentCrypto.name!}  (${currentCrypto.symbol!.toUpperCase()})",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        "₹  ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 30.0,
                              color: const Color(0xff0395eb),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Price Change (24h)",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Builder(
                          builder: (context) {
                            double priceChange = currentCrypto.priceChange24!;
                            double priceChangePercentage =
                                currentCrypto.priceChangePercentage24!;

                            if (priceChange < 0) {
                              // negative
                              return Text(
                                "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 23.0,
                                      color: Colors.red,
                                    ),
                              );
                            } else {
                              // positive
                              return Text(
                                "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 23.0,
                                      color: Colors.green,
                                    ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Market Cap",
                            "₹   ${currentCrypto.marketCap!.toStringAsFixed(4)}",
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "Market Cap Rank",
                            "# ${currentCrypto.marketCapRank.toString()}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Low 24h",
                            "₹   ${currentCrypto.low24!.toStringAsFixed(4)}",
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "High 24h",
                            "₹   ${currentCrypto.high24!.toStringAsFixed(4)}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Circulating Supply",
                            currentCrypto.circulatingSupply!.toInt().toString(),
                            CrossAxisAlignment.start),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "All Time Low",
                            currentCrypto.atl!.toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "All Time High",
                            currentCrypto.ath!.toStringAsFixed(4),
                            CrossAxisAlignment.start),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

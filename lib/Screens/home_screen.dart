import 'package:flutter/material.dart';
import 'package:btc/Services/reusable_card.dart';
import 'package:btc/Services/crypto_services.dart';
import 'package:btc/Services/list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'USD'; // Default selected currency
  String btcPrice = "";
  String ethPrice = "";
  String dogePrice = "";
  final CryptoService cryptoService =
      CryptoService(); // Create an instance of the service

  @override
  void initState() {
    super.initState();
    // Fetch data for Bitcoin, Ethereum, and Dogecoin in the selected currency
    fetchPrices();
  }

  Future<void> fetchPrices() async {
    try {
      double btcPriceValue =
          await cryptoService.getCryptoPrice("BTC", selectedCurrency);
      double ethPriceValue =
          await cryptoService.getCryptoPrice("ETH", selectedCurrency);
      double dogePriceValue =
          await cryptoService.getCryptoPrice("DOGE", selectedCurrency);

      setState(() {
        // Convert to String and format
        btcPrice = formatPrice(btcPriceValue);
        ethPrice = formatPrice(ethPriceValue);
        dogePrice = formatPrice(dogePriceValue);
      });
    } catch (e) {
      print('Error fetching prices: $e');
      // Handle error gracefully (e.g., show a message to the user)
      setState(() {
        btcPrice = "N/A";
        ethPrice = "N/A";
        dogePrice = "N/A";
      });
    }
  }

  void updateCurrency(String? newCurrency) {
    if (newCurrency != null) {
      setState(() {
        selectedCurrency = newCurrency;
      });
      // Fetch prices for all cryptocurrencies in the new currency
      fetchPrices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto 💰',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Create cards for displaying cryptocurrency prices with icons
            ReusableCard(
              title: 'BITCOIN: $btcPrice',
              icon: Icons.currency_bitcoin_outlined,
              color: Colors.orangeAccent, // Add color to the card
            ),
            SizedBox(height: 30), // Add space between cards
            ReusableCard(
              title: 'ETHEREUM: $ethPrice',
              icon: FontAwesomeIcons.ethereum, // Use FontAwesome icon
              color: Color(0xffE8C29C), // Add color to the card
            ),
            SizedBox(height: 30), // Add space between cards
            ReusableCard(
              title: 'DOGECOIN: $dogePrice',
              icon: FontAwesomeIcons.dog, // Use FontAwesome icon
              color: Color(0xffF1E0BB), // Add color to the card
            ),
            SizedBox(height: 80), // Add space between cards
            // Dropdown menu for currency selection
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 20), // Add vertical padding
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light gray background
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Center(
                child: DropdownButton<String>(
                  value: selectedCurrency,
                  items: currenciesList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: updateCurrency, // Update currency on change
                  isExpanded: true, // Make dropdown take full width
                  underline: Container(), // Remove underline
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to format price
  String formatPrice(double price) {
    return price.toStringAsFixed(3); // Format to 3 decimal places
  }
}

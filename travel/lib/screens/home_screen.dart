import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/widgets/hotdeals.dart';
import 'package:travel/widgets/hotels.dart';
import 'package:travel/widgets/navicons.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Where you \nwanna go?',
                    style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),

                  ),
                  Material(
                    elevation: 4, // Set the desired elevation value
                    shape: CircleBorder(),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.search),
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mq.height*.02,
              ),
              SizedBox(
                height: mq.height*.15,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    NavIcons(icon: Icons.home_outlined,text: 'Hotel',buttoncolor: Colors.blue),
                    NavIcons(icon: Icons.flight_outlined,text: 'Flight',buttoncolor: Colors.white),
                    NavIcons(icon: Icons.location_on_outlined,text: 'Place',buttoncolor: Colors.white),
                    NavIcons(icon: Icons.restaurant_menu_outlined,text: 'food',buttoncolor: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: mq.height*.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular Hotels',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                  TextButton(onPressed: (){}, child: Text('See all',style: TextStyle(color: Colors.orange,fontSize: 16),))
                ],
              ),
              SizedBox(
                height: mq.height*.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Hotels(city: 'Greece',hotel: 'Santorini',price: '488',rating: '4.9',image: 'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2020/11/santorini.jpg',),
                    Hotels(city: 'Spain',hotel: 'Hotel Royal',price: '280',rating: '4.8',image: 'https://foto.hrsstatic.com/fotos/0/2/600/400/100/FFFFFF/http%3A%2F%2Ffoto-origin.hrsstatic.com%2Ffoto%2F1%2F0%2F1%2F4%2F1014485%2F1014485_p_23486242.jpg/a0ea8ePJwhnunt2YdlSPRA%3D%3D/1152%2C886/6/Royal_Palm_Fuerteventura-Las_Palmas_de_Gran_Canaria-Pool-1014485.jpg',),
                    Hotels(city: 'Indonesia',hotel: 'Bali Motel Vung Tau',price: '580',rating: '4.9',image: 'https://fati-boutique-hotel-apartment-vung-tau.ibooked.ca/data/Photos/r1326x761/11823/1182388/1182388315/Fati-Boutique-Hotel-Apartment-Vung-Tau-Exterior.JPEG',),
                  ],
                ),
              ),
              SizedBox(
                height: mq.height*.02,
              ),
              Row(
                children: [
                  Text('Hot Deals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                ],
              ),
              SizedBox(
                height: mq.height*.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    HotDeals(city: 'Greece',hotel: 'Santorini',price: '488',rating: '4.9',image: 'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2020/11/santorini.jpg',),
                    HotDeals(city: 'Spain',hotel: 'Hotel Royal',price: '280',rating: '4.8',image: 'https://foto.hrsstatic.com/fotos/0/2/600/400/100/FFFFFF/http%3A%2F%2Ffoto-origin.hrsstatic.com%2Ffoto%2F1%2F0%2F1%2F4%2F1014485%2F1014485_p_23486242.jpg/a0ea8ePJwhnunt2YdlSPRA%3D%3D/1152%2C886/6/Royal_Palm_Fuerteventura-Las_Palmas_de_Gran_Canaria-Pool-1014485.jpg',),
                    HotDeals(city: 'Greece',hotel: 'Santorini',price: '488',rating: '4.9',image: 'https://www.johansens.com/wp-content/uploads/2019/09/Spain-Santa-Catalina-a-Royal-Hideaway-Hotel-91-e1660222675265.jpg',),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

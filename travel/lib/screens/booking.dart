import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:travel/widgets/navicons.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:travel/widgets/navicons1.dart';

class Booking extends StatefulWidget {
  const Booking(
      {Key? key, this.image, this.hotel, this.city, this.rating, this.price})
      : super(key: key);
  final image;
  final hotel;
  final city;
  final rating;
  final price;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: mq.width,
                height: mq.height * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget
                        .image), // Replace with your desired background image URL
                    fit: BoxFit.cover, // Adjust the fit to your preference
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      height: mq.height * .12,
                      left: mq.width * .04,
                      child: Material(
                        elevation: 4, // Set the desired elevation value
                        shape: CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_backspace_outlined),
                          onPressed: () {
                            Navigator.pop(context);
                            // Add your onPressed logic here
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      height: mq.height * .12,
                      left: mq.width * .65,
                      child: Material(
                        elevation: 4, // Set the desired elevation value
                        shape: CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      height: mq.height * .12,
                      left: mq.width * .83,
                      child: Material(
                        elevation: 4, // Set the desired elevation value
                        shape: CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.favorite_border_rounded),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: mq.height * .05,
                        left: mq.width * .4,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                30), // Set the desired border radius for the container
                            color: Colors
                                .black38, // Set the background color of the container
                          ),
                          padding: EdgeInsets.all(
                              8.0), // Set the desired padding for the container
                          child: Text(
                            '120 photos',
                            style: TextStyle(
                              fontSize: 14, // Adjust the font size as needed
                              color: Colors.white, // Set the text color
                            ),
                          ),
                        )),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        height: 30,
                        child: Center(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.hotel.length > 10
                              ? widget.hotel.substring(0, 10) +
                                  '\n' +
                                  widget.hotel.substring(10)
                              : widget.hotel,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          maxLines: widget.hotel.length > 10 ? 2 : 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          widget.city,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              ' ' + widget.rating,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' (6.8K review)',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$' + widget.price + '/',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 25),
                            ),
                            Text(
                              'night',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1.0,
                    ),
                    SizedBox(height: mq.height*.02,),
                    ExpandableText(
                      "Get your trip off to a great start with a stay at this property, which offers free Wi-Fi in all rooms. Strategically situated in Phường 1, allowing you access and proximity to local attractions and sights. Be sure to set some time aside to visit Vung Tau Light House as well as Front Beach nearby.",
                      expandText: 'Read more',
                      collapseText: 'Read less',
                      maxLines: 3,
                      style: TextStyle(fontSize: 16,color: Colors.black54),
                      linkColor: Colors.orange,
                    ),
                    SizedBox(
                      height: mq.height*.02,
                    ),
                    Row(
                      children: [
                        Text('What we offer',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(
                      height: mq.height*.01,
                    ),
                    SizedBox(
                      height: mq.height*.15,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          NavIcon(icon: Icons.bed_outlined,text: '2 Bed'),
                          NavIcon(icon: Icons.restaurant_menu_outlined,text: 'Dinner'),
                          NavIcon(icon: Icons.bathtub_outlined,text: 'Hot Tub'),
                          NavIcon(icon: Icons.ac_unit,text: '1 Ac'),
                          NavIcon(icon: Icons.ac_unit,text: '1 Ac'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('Hosted by',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    ListTile(
                      leading: CircleAvatar(radius: 30,backgroundImage: NetworkImage('https://hips.hearstapps.com/hmg-prod/images/1-monika-sharma-1654632795.jpg?resize=980:*',),),
                      title: Text('Harleen Smith',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      subtitle: Row(children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          ' ' + widget.rating,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' (6.8K review)',
                          style:
                          TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ],),
                      trailing: CircleAvatar(child: Icon(Icons.message_outlined,color: Colors.white,),radius: 25,backgroundColor: Colors.orange,),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text('Book Now',style: TextStyle(fontSize: 17,color: Colors.white),),
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HotDeals extends StatefulWidget {
  const HotDeals({Key? key, this.image, this.hotel, this.city, this.rating, this.price}) : super(key: key);
  final image;
  final hotel;
  final city;
  final rating;
  final price;
  @override
  State<HotDeals> createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: mq.width*.9,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.image), // Replace with your desired background image URL
              fit: BoxFit.cover, // Adjust the fit to your preference
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                top: mq.height*.02,
                  left: mq.width*.02,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), // Set the desired border radius for the container
                      color: Colors.deepOrange, // Set the background color of the container
                    ),
                    padding: EdgeInsets.all(8.0), // Set the desired padding for the container
                    child: Text(
                      '25% OFF',
                      style: TextStyle(
                        fontSize: 14, // Adjust the font size as needed
                        color: Colors.white, // Set the text color
                      ),
                    ),
                  )
              ),
              Positioned(
                bottom: mq.height*.04,
                left: mq.width*.02,
                child: Text(widget.hotel,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              Positioned(
                bottom: mq.height*.017,
                left: mq.width*.02,
                child: Row(
                  children: [
                    Icon(Icons.place_outlined,color: Colors.white70,size: mq.height*.02,),
                    Text(widget.city,style: TextStyle(color: Colors.white70,fontSize: 17),),
                  ],
                ),
              ),
              Positioned(
                bottom: mq.height*.01,
                left: mq.width*.7,
                child: Row(
                  children: [
                    Text('\$',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Text(widget.price,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('/night',style: TextStyle(color: Colors.white60),),
                  ],
                ),
              ),
              Positioned(
                bottom: mq.height*.035,
                left: mq.width*.75,
                child: Row(
                  children: [
                    Icon(Icons.star,color: Colors.orange,),
                    Text(widget.rating
                        ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

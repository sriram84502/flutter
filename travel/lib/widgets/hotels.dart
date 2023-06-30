import 'package:flutter/material.dart';
import 'package:travel/screens/booking.dart';

class Hotels extends StatefulWidget {
  const Hotels({Key? key, this.image, this.hotel, this.city, this.rating, this.price}) : super(key: key);
  final image;
  final hotel;
  final city;
  final rating;
  final price;
  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: mq.width*.41,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.image), // Replace with your desired background image URL
            fit: BoxFit.cover, // Adjust the fit to your preference
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Booking(image: widget.image,city: widget.city,price: widget.price,hotel: widget.hotel,rating: widget.rating,)));
          },
          child: Stack(
            children: [
              Positioned(
                  bottom: mq.height*.06,
                  left: mq.width*.02,
                  child: Text(widget.hotel,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              Positioned(
                bottom: mq.height*.035,
                left: mq.width*.02,
                child: Row(
                  children: [
                    Icon(Icons.place_outlined,color: Colors.white70,size: mq.height*.02,),
                    Text(widget.city,style: TextStyle(color: Colors.white70),),
                  ],
                ),
              ),
              Positioned(
                bottom: mq.height*.01,
                left: mq.width*.02,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text('\$',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        Text(widget.price,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        Text('/night',style: TextStyle(color: Colors.white60),),
                      ],
                    ),
                    SizedBox(width: mq.width*.07,),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.orange,),
                        Text(widget.rating
                            ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flyin',style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 2),),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded,color: Colors.black,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined,color: Colors.black,)),
        ],
      ),
    );
  }
}

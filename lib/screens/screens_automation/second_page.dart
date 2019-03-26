import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

 
class SecondPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return VideoExample();

  }
}


class VideoExample extends StatefulWidget {
  @override
  _VideoExampleState createState() => _VideoExampleState();
}

class _VideoExampleState extends State<VideoExample> {
  VideoPlayerController playerController;
  VoidCallback listener;
    
     @override
  void initState() {
    
    super.initState();
    listener = (){
       setState(() {
         
       });
   
    };
  }

 void createVideo(){

   if(playerController==null){
     playerController=VideoPlayerController.asset("assets/videos/m.mp3")
     ..addListener(listener)
     ..setVolume(1.0)
     ..initialize();



   }

 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 16/9,
        child: playerController != null?VideoPlayer(playerController):Container()
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
    createVideo();
    playerController.play();


        },
      ) ,
    );
    
  }
}
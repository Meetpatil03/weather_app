import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
   RiveAnimationController? controller;

    void initState() {
        super.initState();
        controller = SimpleAnimation('Animation 1');
         controller?.isActive = true;
      }
  @override
  Widget build(BuildContext context) {
   


      
    
    

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300,
        height: 30,
        child:  Center(
          child: Column(
            children: [
              if(controller != null) 
                Container(
                  height: 80,
                  width: 100,
            child: RiveAnimation.asset(
              'assets/rive/weather.riv',
              fit: BoxFit.contain,
              controllers: [controller!],   // Assign the controller to manage the animation
            ),
          ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'No-Cities-Searched-Yet',
                style: TextStyle(fontSize: 16,color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

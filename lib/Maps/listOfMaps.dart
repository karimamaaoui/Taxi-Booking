import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:taxi2/LocationCustomer/LocationC.dart';
import 'package:taxi2/Widget/DividerWidget.dart';

class listOfMaps{

  Address _address;



  void onBottomPressed(BuildContext context)
  { 
    showModalBottomSheet(
        context: context,backgroundColor: Colors.transparent,
        builder: (context){
          return Container(

            child: Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255,238,120,1),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight:Radius.circular(18.0) ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset:Offset(0.7,0.7),

                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.0,),
                        Text("Hi there ",style: TextStyle(fontSize:14.0),),
                        Text("Where To ? ",style: TextStyle(fontSize:20.0 ,fontFamily: "Brand-Bold"),),
                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(249,184,187,1),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset:Offset(0.7,0.7),

                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.search,color: Colors.black,),
                                  SizedBox(width: 10.0,),
                                  Text("Search Drop Off")
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(253,235,197,1),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset:Offset(0.7,0.7),

                              )
                            ],

                          ),

                          child: Row(
                            children:[
                              Icon(Icons.home, color: Colors.grey,),
                              SizedBox(width: 12.0, ),
                              Text(
                                  "Currently Place",style: TextStyle(color:Colors.black54,fontSize: 12.0)
                              ),
                              SizedBox(width: 30.0,),
                              Text( "-",style: TextStyle(color:Colors.black54,fontSize: 12.0),),

                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        DividerWidget(),
                        SizedBox(height: 16.0,),

                        Container(decoration: BoxDecoration(
                          color: Color.fromRGBO(205,236,169,1),
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset:Offset(0.7,0.7),

                            )
                          ],

                        ),


                          child: Row(
                            children: [
                              Icon(Icons.work, ),
                              SizedBox(width: 12.0,),
                              Text("Add Work  "),
                              SizedBox(height: 4.0,),
                              Text("Your office adresse",style: TextStyle(color:Colors.black54,fontSize: 12.0),),

                            ],
                          ),
                        ),


                      ],

                    ),
                  ),
                )
            ),
          );
        });

  }
}
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF000D15),
      ),


      child: Padding(
        padding: const EdgeInsets.all(32.0),


        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Expanded(
              flex: 7,
              child: Column(
                children: [
                  
                  //=======================
                  // DIAS SEM O.S REALIZADA
                  //=======================
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFF001B29),
                      borderRadius: BorderRadius.circular(16)
                    ),  

                    child: Column(
                      children: [

                        //=======================
                        //       TÍTULO
                        //=======================
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dias sem O.S realizadas', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              
                              SizedBox(width: 8),
                        
                              Icon(Icons.report_gmailerrorred, color: Colors.white,),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Técnico 1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),


                  SizedBox(height: 16),

                  
                  //=======================
                  // IMPLANTADORES EM CAMPO
                  //=======================
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFF001B29),
                      borderRadius: BorderRadius.circular(16)
                    ),  

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Implantadores em campo', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            
                            SizedBox(width: 8),
                      
                            Icon(Icons.report_gmailerrorred, color: Colors.white,),
                          ],
                        ),
                    ),
                   
                  ),
                ],
              ),
            ),

            // ESPASSADOR LATERAL
            SizedBox(width: 16),
            
            //=======================
            // DIAS SEM O.S REALIZADA
            //=======================
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    height: 616,
                    decoration: BoxDecoration(
                      color: Color(0xFF001B29),
                      borderRadius: BorderRadius.circular(16)
                    ),  

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Financeiro', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                                
                                SizedBox(width: 8),
                          
                                Icon(Icons.report_gmailerrorred, color: Colors.white,),
                              ],
                            ),
                        ),
                      ],


                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

}
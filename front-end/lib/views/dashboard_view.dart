import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashboardView>{
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

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          //=======================
                          //       TÍTULO
                          //=======================
                          
                          Row(
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

                          
                          Divider(
                            color: Colors.white60,
                            height: 20,
                            thickness: 1 ,
                          ),

                          

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('Técnico 1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),

                              Text('Técnico 2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),

                              Text('Técnico 3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),

                              Text('Técnico 4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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

                          Divider(
                            color: Colors.white60,
                            height: 20,
                            thickness: 1 ,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Felipe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.view_headline_rounded, color: Colors.white60,),
                                ],
                              ),

                              Row(
                                children: [
                                  Text('Bruno',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text('Paulo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text('Pedrão',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )


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
            //      FINANCEIRO
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
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

                              Divider(
                                  color: Colors.white60,
                                  height: 20,
                                  thickness: 1 ,
                                ),



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
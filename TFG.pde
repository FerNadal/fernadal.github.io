//String nombreFicheroWinMecC = "Cranck-Shaper.Mec";

float resAngulo, resDistancia;
float Thetad, Rd, Theta3d, Thetad4, Theta3, Theta32, Theta4, Theta13, ThetaExcentricidad, ThetaExcentricidad2, PosBRel, PosBRelA;
float pasoAng=1;
float pasoLin=3;
float velocidad=1;
int numlinea=0;
int numlineaDiada;

boolean ficheroCargado=false;

ClaseEslabonMotor eslabonMotor;

ListadePuntos ListaPuntos;
ListadeBarras ListaBarras;
ListadeApoyos ListaApoyos;
ListadeApoyosDeslizantes ListaApoyosDeslizantes;
ListadeDeslizaderas ListaDeslizaderas;
ListadeDeslizaderasFijas ListaDeslizaderasFijas;
ListadeEslabones ListaEslabones;
ListadeExcentricidades ListaExcentricidades;
ListadePuntosExtremos ListaPuntosExtremos;
ListadePuntosFijos ListaPuntosFijos;
ListadeRectas ListaRectas;

ListadeEstructuras ListaEstructuras;

void setup() {
  size(600, 600, JAVA2D);

  noLoop();

  ListaPuntos=new ListadePuntos();
  ListaBarras=new ListadeBarras();
  ListaApoyos=new ListadeApoyos();
  ListaApoyosDeslizantes=new ListadeApoyosDeslizantes();
  ListaDeslizaderas=new ListadeDeslizaderas();
  ListaDeslizaderasFijas=new ListadeDeslizaderasFijas();
  ListaEslabones=new ListadeEslabones();
  ListaExcentricidades=new ListadeExcentricidades();
  ListaPuntosExtremos= new ListadePuntosExtremos();
  ListaPuntosFijos=new ListadePuntosFijos();
  ListaRectas=new ListadeRectas();
  ListaEstructuras=new ListadeEstructuras();

  eslabonMotor= new ClaseEslabonMotor();

  // COMENTAR si se cumplen AMBAS condiciones:
  // *** Se va a compilar para Processing.JS
  // *** Se va leer un fichero de WinMecC externo
  invocacionHTML();
  
  smooth();
}

void invocacionHTML(){
  // DESCOMENTAR si se va leer un fichero de WinMecC externo
  //String mecanismoLeido = LeerarchivoGeneral();
  //LeerFicheroWinMecC(mecanismoLeido);
  //LeerFicheroWinMecC("Deslizaderas.Mec");
  
  
  ///////////////////////////////////////////////////////////////////////////
  //
  // Mecanismos "PROGRAMADOS"
  
  // DESCOMENTAR si se va utilizar un mecanismo PROGRAMADO

  //Mec4Barras();
  //MecanismoPruebaDiadas4Barras();    // NO FUNCIONA [Fernando]ok
  //BielaManivela();
  //DeslizaderaInversion();
  //DeslizaderaInversion2();
  //TheoJansen();                        // GEOMETRÍA INCORRECTA [Fernando]ok
  //CapotaCoche();//No arreglado          // NO FUNCIONA [Fernando]
  //Dedo_mecanismo();                      // GEOMETRÍA INCORRECTA [Fernando]ok
  //LimpiaParabrisas();//no arreglado      // NO FUNCIONA [Fernando]
  //Ruedaslocomotora();

  //MecanismoPruebaDiadasBielasManivelas();
  //MecanismoPruebaDiadaDeslizaderaInversion();
  //MecanismoPruebaDiadaDeslizaderaBase(); 
  //MecanismoPruebaDiadaDeslizaderaBase2();
  //DeslizaderaBase1();
  //DeslizaderaBase();
  //Deslizaderas();
  //pinza2();
  //pinza5();
  //tema14();
  //DobleDeslizadera();
  //Atkinson();
  //Eliptica();                        // GEOMETRÍA INCORRECTA [Fernando]ok
  Rovet();                            // GEOMETRÍA INCORRECTA [Fernando]ok
  //DiadaPrueba();
  
  //
  ///////////////////////////////////////////////////////////////////////////
  
  mecanismoCargado();
}

void mecanismoCargado() {

  eslabonMotor.eslabonMotorEnlace.theta = 0;

  ficheroCargado = true;
  
  loop();
}

void draw() {
  background(255);

  if (ficheroCargado) {
    ListaEstructuras.calcular();

    eslabonMotor.moverse();

    ListaRectas.pintar();
    ListaApoyos.pintar();
    ListaBarras.pintar();
    ListaExcentricidades.pintar();
    ListaDeslizaderas.pintar();
    ListaPuntosExtremos.pintar();
    ListaPuntos.pintar();
    ListaPuntosFijos.pintar();
    ListaDeslizaderasFijas.pintar();
    ListaApoyosDeslizantes.pintar();

    ListaEslabones.ratondentro();
    ListaExcentricidades.ratondentro();
  }
}
ClaseMec4Barras Mec4Barras() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(-1390, 650);
  M4Barras.R2.L=500;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=1240;
  M4Barras.R4.L=450;
  return(M4Barras);
}
void MecanismoPruebaDiadasBielasManivelas() {
  ClaseMec4Barras M4BarrasPrueba= Mec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4BarrasPrueba.R3, 500, 45);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(M4BarrasPrueba.R3, 500, -45);
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(M4BarrasPrueba.R3, 500, 60);
  ClaseDiadaBielaManivelaMovil Diada2=crearDiadaBielaManivelaFija(PuntoB);
  ClaseDiadaBielaManivelaMovil Diada1=crearDiadaBielaManivelaMovil(Diada2.Deslizadera1.PInicial, M4BarrasPrueba.R3);
  ClaseDiadaBielaManivelaMovil Diada7=crearDiadaBielaManivelaFija2(M4BarrasPrueba.R3);
  Diada1.R3.L=1000.3;
  Diada1.R4.L=300;
  Diada1.R4.theta=0;
  Diada2.R3.L=500.5;
  Diada2.R4.L=100;
  Diada2.R4.theta=-90;
  ((ClaseRecta)Diada2.OD3).theta=90;
  ((ClaseRecta)Diada2.OD3).PInicial.Pos=new PVector(290, 0);
  Diada7.OD2.Pos=new PVector(700, 0);
  Diada7.R3.L=1000;
  Diada7.R4.L=0;
  Diada7.R4.theta=90;
}
void MecanismoPruebaDiadas4Barras() {
  ClaseMec4Barras M4BarrasPrueba=Mec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4BarrasPrueba.R3, 500, -45);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(M4BarrasPrueba.R4, 500, -45);
  ClaseDiada4BarrasMovil Diada5=crearDiada4BarrasFija(M4BarrasPrueba.A);
  ClaseDiada4BarrasMovil Diada6=crearDiada4BarrasMovil(Diada5.A, M4BarrasPrueba.B);
  ClaseDiada4BarrasMovil Diada7=crearDiada4BarrasFija(PuntoB);
  Diada5.R2.L=490.5;
  Diada5.R3.L=700.0;
  ((ClasePunto)Diada5.OD2).Pos=new PVector(500.0, 0.0);
  Diada6.R2.L=800.0;
  Diada6.R3.L=1000.0;
  Diada7.R2.L=490.5;
  Diada7.R3.L=700.0;
  ((ClasePunto)Diada7.OD2).Pos=new PVector(-1860.0, 650.0);
}
void MecanismoPruebaDiadaDeslizaderaBase2() {
  ClaseMec4Barras M4Barras=Mec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R3, 1000, -45);
  ClaseDiadaDeslizaderaBaseMovil Diada=crearDiadaDeslizaderaBaseFija(M4Barras.A);
  ClaseDiadaDeslizaderaBaseMovil Diada2=crearDiadaDeslizaderaBaseFija2(M4Barras.A);
  ClaseDiadaDeslizaderaBaseMovil Diada3=crearDiadaDeslizaderaBaseMovil(Diada2.B, PuntoA);
  ((ClaseDeslizadera)Diada.OD3).PInicial.Pos=new PVector(500, 0);
  ((ClaseDeslizadera)Diada.OD3).theta=45;
  Diada.R3.L=1000.3;
  Diada.R4.L=200;
  Diada.R4.theta=90;
  Diada.R5.L=1000;
  Diada.angulo=45;
  ((ClaseApoyo)Diada2.OD2).Pos=new PVector(-700, -100);
  Diada2.R3.L=500;
  Diada2.R4.L=100;
  Diada2.R4.theta=90;
  Diada2.R5.L=3000;
  Diada2.angulo=-60;
  Diada3.R3.L=600;
  Diada3.R4.L=0;
  Diada3.R4.theta=60;
  Diada3.R5.L=2000;
  Diada3.angulo=90;
}
void MecanismoPruebaDiadaDeslizaderaBase() {
  ClaseMec4Barras M4Barras= Mec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R3, 359, 30);
  ClaseDiadaDeslizaderaBaseMovil Diada=crearDiadaDeslizaderaBaseFija(M4Barras.A);
  ClaseDiadaDeslizaderaBaseMovil Diada2=crearDiadaDeslizaderaBaseFija2(M4Barras.A);
  ClaseDiadaDeslizaderaBaseMovil Diada3=crearDiadaDeslizaderaBaseMovil(PuntoA, M4Barras.A);
  ((ClaseDeslizadera)Diada.OD3).PInicial.Pos=new PVector(500, 0);
  ((ClaseDeslizadera)Diada.OD3).theta=45;
  Diada.R3.L=1000.3;
  Diada.R4.L=200;
  Diada.R4.theta=90;
  Diada.R5.L=1000;
  Diada.angulo=45;
  ((ClaseApoyo)Diada2.OD2).Pos=new PVector(-700, -100);
  Diada2.R3.L=500;
  Diada2.R4.L=100;
  Diada2.R4.theta=90;
  Diada2.R5.L=3000;
  Diada2.angulo=-60;
  Diada3.R3.L=265;
  Diada3.R4.L=100;
  Diada3.R4.theta=60;
  Diada3.R5.L=467;
  Diada3.angulo=256;
}
void MecanismoPruebaDiadaDeslizaderaInversion() {
  ClaseMec4Barras M4Barras= Mec4Barras();
  ClaseDiadaDeslizaderaInversionMovil Diada4=crearDiadaDeslizaderaInversionMovil(M4Barras.B, M4Barras.A);
  ClaseDiadaDeslizaderaInversionMovil Diada8=crearDiadaDeslizaderaInversionFija2(M4Barras.A);
  ClaseDiadaDeslizaderaInversionMovil Diada=crearDiadaDeslizaderaInversionFija(M4Barras.B);
  Diada4.EX1.L=500;
  Diada4.EX1.theta=30;
  Diada4.EX2.L=200;
  Diada4.EX2.theta=90;
  Diada4.R3.L=1000;
  Diada8.EX1.L=200;
  Diada8.EX1.theta=30;
  Diada8.EX2.theta=90;
  Diada8.R3.L=1000;
  Diada8.EX2.L=200;
  Diada8.OD2.Pos=new PVector(1000, -100);
  Diada.EX1.L=200;
  Diada.EX1.theta=30;
  Diada.EX2.L=200;
  Diada.EX2.theta=90;
  Diada.R3.L=600;
  ((ClaseApoyo)Diada.OD3).Pos=new PVector(-1000, -100);
}
void DiadaPrueba() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  ClaseDiadaDeslizaderaBase DiadaBase=new ClaseDiadaDeslizaderaBase(M4Barras.A);
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(-1390, 650);
  M4Barras.R2.L=500;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=1240;
  M4Barras.R4.L=450;
  DiadaBase.Deslizadera1.PInicial.Pos=new PVector(2000, 0);
  DiadaBase.Deslizadera1.theta=45;
  DiadaBase.R3.L=2000;
  DiadaBase.R4.L=2000;
  DiadaBase.EX.L=700;
  DiadaBase.EX.theta=45;
}
//ClaseMec4Barras Mec4Barras() {
//  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
//  M4Barras.O2.Pos=new PVector(0, 0);
//  M4Barras.O4.Pos=new PVector(800, 0);
//  M4Barras.R2.L=300;
//  M4Barras.R2.theta=45;
//  M4Barras.R3.L=700;
//  M4Barras.R4.L=500;
//  return(M4Barras);
//}
ClaseBielaManivela BielaManivela() {
  ClaseBielaManivela bielaManivela=new ClaseBielaManivela();
  bielaManivela.O2.Pos=new PVector(+300, -400);
  bielaManivela.recta.PInicial.Pos=new PVector(150, 0);
  bielaManivela.R2.L=280;
  bielaManivela.R2.theta=25;
  bielaManivela.R3.L=500;
  bielaManivela.EX.L=200;
  bielaManivela.EX.theta=90;
  bielaManivela.recta.theta=0;
  return(bielaManivela);
}
ClaseDeslizaderaInversion DeslizaderaInversion() {
  ClaseDeslizaderaInversion deslizaderaInversion=new ClaseDeslizaderaInversion();
  deslizaderaInversion.O2.Pos=new PVector(-200, 0);
  deslizaderaInversion.O4.Pos=new PVector(300, 0);
  deslizaderaInversion.R2.L=100;
  deslizaderaInversion.R2.theta=0;
  deslizaderaInversion.EX1.L=0;
  deslizaderaInversion.R3.L=1000;
  deslizaderaInversion.EX2.L=0;
  deslizaderaInversion.EX1.theta=60;
  deslizaderaInversion.EX2.theta=90;
  return(deslizaderaInversion);
}
ClaseDeslizaderaInversion2 DeslizaderaInversion2() {
  ClaseDeslizaderaInversion2 deslizaderaInversion2=new ClaseDeslizaderaInversion2();
  deslizaderaInversion2.O2.Pos=new PVector(-200, 0);
  deslizaderaInversion2.O4.Pos=new PVector(300, 0);
  deslizaderaInversion2.R2.L=400;
  deslizaderaInversion2.R2.theta=45;
  deslizaderaInversion2.EX1.L=200;
  deslizaderaInversion2.R3.L=500;
  deslizaderaInversion2.EX2.L=200;
  deslizaderaInversion2.EX1.theta=90;
  deslizaderaInversion2.EX2.theta=90;
  return(deslizaderaInversion2);
}
ClaseDeslizaderaBase DeslizaderaBase1() {
  ClaseDeslizaderaBase deslizaderaBase=new ClaseDeslizaderaBase();
  deslizaderaBase.O2.Pos=new PVector(-200, 0);
  deslizaderaBase.Deslizadera.PInicial.Pos=new PVector(200, 0);
  deslizaderaBase.R2.L=200;
  deslizaderaBase.R3.L=800;
  deslizaderaBase.R4.L=800;
  deslizaderaBase.EX.L=200;
  deslizaderaBase.EX.theta=90;
  deslizaderaBase.Deslizadera.theta=0;
  return(deslizaderaBase);
}
ClaseDobleDeslizadera DobleDeslizadera() {
  ClaseDobleDeslizadera dobleDeslizadera=new ClaseDobleDeslizadera();
  dobleDeslizadera.Recta1.PInicial.Pos=new PVector(200, 0);
  dobleDeslizadera.Recta2.PInicial.Pos=new PVector(-200, 0);
  dobleDeslizadera.Recta1.theta=60;
  dobleDeslizadera.Recta2.theta=-45;
  //dobleDeslizadera.Deslizadera1.distancia=900;
  dobleDeslizadera.R.L=500;
  dobleDeslizadera.EX1.L=0;
  dobleDeslizadera.EX1.theta=90+180;
  dobleDeslizadera.EX2.L=0;
  dobleDeslizadera.EX2.theta=90+180;
  return(dobleDeslizadera);
}
void TheoJansen() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  ClasePuntoAdicional Punto=ListaPuntos.crearAdicional(M4Barras.R3, 0, 45.11);
  ClaseDiada4BarrasMovil Diada5= crearDiada4BarrasFija(M4Barras.A);
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(Diada5.R2, 30, 90);
  ClaseDiada4BarrasMovil Diada9= crearDiada4BarrasMovil(PuntoA, M4Barras.B);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(Diada9.R3, 44, 90);
  ClaseDiada4BarrasMovil Diada6=crearDiada4BarrasFija(M4Barras.A); 
  ClaseDiada4BarrasMovil Diada3=crearDiada4BarrasFija(M4Barras.A); 
  ClasePuntoAdicional PuntoD=ListaPuntos.crearAdicional(Diada3.R2, 30, -90);
  ClaseDiada4BarrasMovil Diada11=crearDiada4BarrasMovil(PuntoD, Diada6.A);  
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(Diada11.R3, 44, -90);

  M4Barras.cruzado=false;
  Diada5.cruzado=true;
  Diada9.cruzado=false;
  Diada6.cruzado=true;
  Diada3.cruzado=false;
  Diada11.cruzado=true;

  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(-32, 0);
  M4Barras.R2.L=10;
  M4Barras.R3.L=46;
  M4Barras.R4.L=30;
  Diada5.R3.L=47.0;
  Diada5.R2.L=29.0;
  Diada5.OD2.Pos=new PVector(-32, 0);
  Diada3.R3.L=47.0;
  Diada3.R2.L=29.0;
  Diada3.OD2.Pos=new PVector(32, 0.0);
  Diada6.R3.L=46.0;
  Diada6.R2.L=30.0;
  Diada6.OD2.Pos=new PVector(32, 0.0);
  Diada9.R2.L=30.0;
  Diada9.R3.L=30.0;
  Diada11.R2.L=30.0;
  Diada11.R3.L=30.0;
}
void Atkinson() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R3, 51, 9);
  ClaseDiadaBielaManivelaMovil Diada1=crearDiadaBielaManivelaFija(PuntoA);
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(6, -51);
  M4Barras.R2.L=20;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=51;
  M4Barras.R4.L=36;
  Diada1.R3.L=57;
  Diada1.R4.L=0;
  Diada1.R4.theta=30;
  ((ClaseDireccion)Diada1.OD3).theta=4;
  ((ClaseDireccion)Diada1.OD3).PInicial.Pos=new PVector(-84, -52);
}
void Eliptica() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  M4Barras.cruzado=true;
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R2, 200, 15);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(M4Barras.R4, 500, 160);
  ClaseDiadaBielaManivelaMovil Diada10=crearDiadaBielaManivelaMovil(PuntoA, M4Barras.R3);
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(760, 400);
  M4Barras.R2.L=100;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=820;
  M4Barras.R4.L=440;
  Diada10.R3.L=340;
  Diada10.R4.L=0;
  Diada10.R4.theta=90;
}
void CapotaCoche() {
  ClaseBielaManivela BielaManivela=new ClaseBielaManivela();
  ClaseDiada4BarrasMovil Diada5=crearDiada4BarrasFija(BielaManivela.A);
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(Diada5.R3, 739, 0.038);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(Diada5.R3, 462, 359);
  ClaseDiada4BarrasMovil Diada6=crearDiada4BarrasFija(PuntoB); 
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(Diada6.R2, 281, 188.35);
  ClaseDiada4BarrasMovil Diada9=crearDiada4BarrasMovil(PuntoA, PuntoC);
  ClasePuntoAdicional PuntoD=ListaPuntos.crearAdicional(Diada9.R3, 119, 0.93);
  BielaManivela.O2.Pos=new PVector(0, 0);
  BielaManivela.recta.PInicial.Pos=new PVector(150, 0);
  BielaManivela.R2.L=280;
  BielaManivela.R2.theta=45;
  BielaManivela.R3.L=400;
  BielaManivela.EX.L=0;
  BielaManivela.EX.theta=90;
  BielaManivela.recta.theta=90;
  Diada5.R2.L=340.0;
  Diada5.R3.L=200.0;
  ((ClasePunto)Diada5.OD3).Pos=new PVector(60, 140);
  Diada6.R2.L=350.0;
  Diada6.R3.L=350.0;
  ((ClasePunto)Diada6.OD3).Pos=new PVector(500.0, -100.0);
  Diada9.R2.L=950.0;
  Diada9.R3.L=600.0;
}
void Dedo_mecanismo() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R2, 630, 2);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(M4Barras.R3, 200, 250);
  ClaseDiada4BarrasMovil Diada9=crearDiada4BarrasMovil(PuntoA, PuntoB);
  ClasePuntoAdicional PuntoD=ListaPuntos.crearAdicional(Diada9.R3, 257, 44.71);
  M4Barras.cruzado=true;
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(-80, -130);
  M4Barras.R2.L=530;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=170;
  M4Barras.R4.L=540;
  Diada9.R2.L=138.0;
  Diada9.R3.L=138.0;
}
void LimpiaParabrisas() {

  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R4, 63.13, 159);
  ClaseDiada4BarrasMovil Diada5=crearDiada4BarrasFija(PuntoA);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(Diada5.R2, 112, 4);
  ClaseDiada4BarrasMovil Diada6=crearDiada4BarrasFija(PuntoB); 
  M4Barras.cruzado=false;
  Diada5.cruzado=true;
  Diada6.cruzado=true;
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(214, -25);
  M4Barras.R2.L=51;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=188;
  M4Barras.R4.L=79;
  Diada5.R3.L=473.0;
  Diada5.R2.L=61.0;
  ((ClasePunto)Diada5.OD2).Pos=new PVector(-255, -163);
  Diada6.R3.L=100.0;
  Diada6.R2.L=290.0;
  ((ClasePunto)Diada6.OD2).Pos=new PVector(-532.5, -198.0);
}
void Rovet() {
  ClaseMec4Barras M4Barras= new ClaseMec4Barras();
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(M4Barras.R4, 97.5, 278);
  ClaseDiada4BarrasMovil Diada5=crearDiada4BarrasFija(PuntoC);
  ClasePuntoAdicional PuntoD=ListaPuntos.crearAdicional(Diada5.R2, 87.2, 45);
  ClaseDiadaBielaManivelaMovil Diada1=crearDiadaBielaManivelaFija(PuntoD);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(M4Barras.R4, 78, 310);
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R2, 27, 22.5);
  ClaseDiada4BarrasMovil Diada9=crearDiada4BarrasMovil(PuntoA, PuntoB);
  ClasePuntoAdicional PuntoE=ListaPuntos.crearAdicional(Diada9.R2, 86.1, 67);
  ClaseDiadaBielaManivelaMovil Diada2=crearDiadaBielaManivelaFija(PuntoE);
  M4Barras.cruzado=true;
  Diada9.cruzado=true;
  Diada5.cruzado=true;
  Diada1.cruzado=true;
  Diada2.cruzado=true;
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(-139, 65);
  M4Barras.R2.L=25;
  //M4Barras.R2.theta=45;
  M4Barras.R3.L=154;
  M4Barras.R4.L=45;
  Diada1.R3.L=225.3;
  Diada1.R4.L=0;
  Diada1.R4.theta=30;
  ((ClaseRecta)Diada1.OD3).theta=90;
  ((ClaseRecta)Diada1.OD3).PInicial.Pos=new PVector(0, 0);
  Diada2.R3.L=212.5;
  Diada2.R4.L=0;
  Diada2.R4.theta=45;
  ((ClaseRecta)Diada2.OD3).theta=90;
  ((ClaseRecta)Diada2.OD3).PInicial.Pos=new PVector(28.5, 0);
  Diada5.R3.L=49.5;
  Diada5.R2.L=70.0;
  ((ClasePunto)Diada5.OD2).Pos=new PVector(0, 0);
  Diada9.R2.L=80.9;
  Diada9.R3.L=61;
}
void Ruedaslocomotora() {
  ClaseBielaManivela bielaManivela=new ClaseBielaManivela();
  bielaManivela.O2.Pos=new PVector(-500, 0);
  bielaManivela.recta.PInicial.Pos=new PVector(150, 0);
  bielaManivela.R2.L=200;
  bielaManivela.R2.theta=25;
  bielaManivela.R3.L=750;
  bielaManivela.EX.L=200;
  bielaManivela.EX.theta=0;
  bielaManivela.recta.theta=0;

  ClaseDiada4BarrasMovil Diada=crearDiada4BarrasFija(bielaManivela.A);
  Diada.OD2.Pos=new PVector(-1000, 0);
  Diada.R2.L=200;
  Diada.R3.L=500;
}
void DeslizaderaBase() {
  ClaseDeslizaderaInversion deslizaderaInversion=new ClaseDeslizaderaInversion();
  deslizaderaInversion.O2.Pos=new PVector(0, 0);
  deslizaderaInversion.O4.Pos=new PVector(80, 0);
  deslizaderaInversion.R2.L=30;
  deslizaderaInversion.R2.theta=0;
  deslizaderaInversion.EX1.L=0;
  deslizaderaInversion.R3.L=140;
  deslizaderaInversion.EX2.L=0;
  deslizaderaInversion.EX1.theta=60;
  deslizaderaInversion.EX2.theta=90;
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(deslizaderaInversion.R3, 70, 30);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(deslizaderaInversion.R2, 15, 30);
  ClaseDiadaDeslizaderaBaseMovil Diada=crearDiadaDeslizaderaBaseFija(PuntoB);
  ((ClaseDeslizadera)Diada.OD3).PInicial.Pos=new PVector(-90, 10);
  ((ClaseDeslizadera)Diada.OD3).theta=45;
  Diada.R3.L=60;
  Diada.R4.L=0;
  Diada.R4.theta=90;
  Diada.R5.L=106.7;
  Diada.angulo=144;
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(Diada.R3, 23.65, 47.31);
  ClaseDiadaDeslizaderaBaseMovil Diada3=crearDiadaDeslizaderaBaseMovil(PuntoC, PuntoA);
  Diada3.R3.L=58;
  Diada3.R4.L=0;
  Diada3.R4.theta=60;
  Diada3.R5.L=93;
  Diada3.angulo=64.11;
}
void Deslizaderas() {
  ClaseDeslizaderaInversion2 deslizaderaInversion2=new ClaseDeslizaderaInversion2();
  deslizaderaInversion2.O2.Pos=new PVector(0, 0);
  deslizaderaInversion2.O4.Pos=new PVector(41, -16);
  deslizaderaInversion2.R2.L=30;
  deslizaderaInversion2.R2.theta=45;
  deslizaderaInversion2.EX1.L=0;
  deslizaderaInversion2.R3.L=140;
  deslizaderaInversion2.EX2.L=0;
  deslizaderaInversion2.EX1.theta=90;
  deslizaderaInversion2.EX2.theta=90;
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(deslizaderaInversion2.R3, 102.22, 347.36);
  ClaseDiadaDeslizaderaInversionMovil Diada=crearDiadaDeslizaderaInversionFija2(PuntoA);
  Diada.EX1.L=0;
  Diada.EX1.theta=30;
  Diada.EX2.L=0;
  Diada.EX2.theta=90;
  Diada.R3.L=116;
  Diada.OD2.Pos=new PVector(-26, 46);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(deslizaderaInversion2.R3, 154.86, 7.09);
  ClaseDiadaDeslizaderaInversionMovil Diada2=crearDiadaDeslizaderaInversionMovil(PuntoB, Diada.D);
  Diada2.EX1.L=0;
  Diada2.EX1.theta=30;
  Diada2.EX2.L=0;
  Diada2.EX2.theta=90;
  Diada2.R3.L=132;
}
void pinza2() {
  ClaseBielaManivela bielaManivela=new ClaseBielaManivela();
  bielaManivela.cruzado=true;
  eslabonMotor.eslabonMotorEnlace=bielaManivela.Deslizadera1;
  bielaManivela.O2.Pos=new PVector(0, 25);
  bielaManivela.recta.PInicial.Pos=new PVector(0, 0);
  bielaManivela.R2.L=50;
  bielaManivela.R2.theta=25;
  bielaManivela.R3.L=50;
  bielaManivela.EX.L=0;
  bielaManivela.EX.theta=90;
  bielaManivela.recta.theta=0;
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(bielaManivela.R2, 110, 0);
  ClaseDiada4BarrasMovil Diada=crearDiada4BarrasFija(PuntoA);
  Diada.cruzado=false;
  Diada.R2.L=110;
  Diada.R3.L=30;
  ((ClasePunto)Diada.OD2).Pos=new PVector(0, 55);
  ClaseDiada4BarrasMovil Diada2=crearDiada4BarrasFija(bielaManivela.Deslizadera1.PInicial);
  Diada2.cruzado=true;
  Diada2.R2.L=50;
  Diada2.R3.L=50;
  ((ClasePunto)Diada2.OD2).Pos=new PVector(0, -25);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(Diada2.R2, 110, 0);
  ClaseDiada4BarrasMovil Diada3=crearDiada4BarrasFija(PuntoB);
  Diada3.cruzado=true;
  Diada3.R2.L=110;
  Diada3.R3.L=30;
  ((ClasePunto)Diada3.OD2).Pos=new PVector(0, -55);
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(Diada3.R3, 20, 270);
  ClasePuntoAdicional PuntoD=ListaPuntos.crearAdicional(Diada.R3, 20, 90);
}
void pinza5() {
  ClaseBielaManivela bielaManivela=new ClaseBielaManivela();
  bielaManivela.cruzado=false;
  eslabonMotor.eslabonMotorEnlace=bielaManivela.Deslizadera1;
  bielaManivela.O2.Pos=new PVector(0, 0);
  bielaManivela.recta.PInicial.Pos=new PVector(0, 0);
  bielaManivela.R2.L=40;
  bielaManivela.R2.theta=25;
  bielaManivela.R3.L=85;
  bielaManivela.EX.L=0;
  bielaManivela.EX.theta=90;
  bielaManivela.recta.theta=0;
  ClaseDiada4BarrasMovil Diada=crearDiada4BarrasFija(bielaManivela.A);
  Diada.cruzado=true;
  Diada.R3.L=20;
  Diada.R2.L=50;
  ((ClasePunto)Diada.OD2).Pos=new PVector(20, 0);
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(Diada.R2, 60, 350);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(Diada.R3, 80, 340);
  ClaseDiada4BarrasMovil Diada2=crearDiada4BarrasMovil(PuntoB, PuntoA);
  Diada2.cruzado=false;
  Diada2.R2.L=10;
  Diada2.R3.L=65;
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(Diada2.R2, 20, 300);
  ClaseDiada4BarrasMovil Diada3=crearDiada4BarrasFija(bielaManivela.Deslizadera1.PInicial);
  Diada3.cruzado=false;
  Diada3.R2.L=40;
  Diada3.R3.L=85;
  ((ClasePunto)Diada3.OD2).Pos=new PVector(0, 0);
  ClaseDiada4BarrasMovil Diada4=crearDiada4BarrasFija(Diada3.A);
  Diada4.cruzado=false;
  Diada4.R2.L=50;
  Diada4.R3.L=20;
  ((ClasePunto)Diada4.OD2).Pos=new PVector(20, 0);
  ClasePuntoAdicional PuntoD=ListaPuntos.crearAdicional(Diada4.R2, 60, 10);
  ClasePuntoAdicional PuntoE=ListaPuntos.crearAdicional(Diada4.R3, 80, 20);
  ClaseDiada4BarrasMovil Diada5=crearDiada4BarrasMovil(PuntoE, PuntoD);
  Diada5.cruzado=true;
  Diada5.R2.L=10;
  Diada5.R3.L=65;
  ClasePuntoAdicional PuntoF=ListaPuntos.crearAdicional(Diada5.R2, 20, 60);
}
void tema14() {
  ClaseMec4Barras M4Barras=new ClaseMec4Barras();
  M4Barras.cruzado=false;
  M4Barras.O2.Pos=new PVector(0, 0);
  M4Barras.O4.Pos=new PVector(14.13, -19.63);
  M4Barras.R2.L=13;
  M4Barras.R2.theta=45;
  M4Barras.R3.L=38.5;
  M4Barras.R4.L=25;
  ClasePuntoAdicional PuntoA=ListaPuntos.crearAdicional(M4Barras.R2, 13, 320);
  ClasePuntoAdicional PuntoB=ListaPuntos.crearAdicional(M4Barras.R4, 44, 0);
  ClaseDiada4BarrasMovil Diada=crearDiada4BarrasMovil(PuntoA, PuntoB);
  Diada.cruzado=true;
  Diada.R2.L=47.5;
  Diada.R3.L=28;
  ClasePuntoAdicional PuntoC=ListaPuntos.crearAdicional(Diada.R3, 25.75, 269.71);
}
boolean EsStringVacia(String str){
  return(str.isEmpty());              // SOLO FUNCIONA en Processing
  //return(CompararStrings(str,""));    // SOLO FUNCIONA en Processing
  //return(str);                        // SOLO FUNCIONA en Processing.JS
}
  
boolean CompararStrings(String str1,String str2){
  return(str1.equals(str2));    // SOLO FUNCIONA en Processing
  //return(str1 === str2);    // SOLO FUNCIONA en Processing.JS
}

void LeerFicheroWinMecC(String tmpNombre) {

  //Whitworth
  //P620 Rovetta 800-400
  //Cranck-Shaper

  String[] archivo= loadStrings(tmpNombre);

  if (buscarlinea(archivo, numlinea, "[Mec. 4 Barras]")) {
    ClaseMec4Barras M4Barras=new ClaseMec4Barras();
    M4Barras.leer(archivo, numlinea);
  } else if (buscarlinea(archivo, numlinea, "[Mec. Biela Manivela]")) {
    ClaseBielaManivela bielaManivela=new ClaseBielaManivela();
    bielaManivela.leer(archivo, numlinea);
  } else if (buscarlinea(archivo, numlinea, "[Mec. Deslizadera]")) {
    ClaseDeslizaderaInversion2 deslizaderaInversion2=new ClaseDeslizaderaInversion2();
    deslizaderaInversion2.leer(archivo, numlinea);
  } else if (buscarlinea(archivo, numlinea, "[Mec. Inversi�n 3]")) {
    ClaseDeslizaderaInversion deslizaderaInversion=new ClaseDeslizaderaInversion();
    deslizaderaInversion.leer(archivo, numlinea);
  } else if (buscarlinea(archivo, numlinea, "[Mec. Inversi�n 4]")) {
    ClaseDeslizaderaBase deslizaderaBase=new ClaseDeslizaderaBase();
    deslizaderaBase.leer(archivo, numlinea);//Aún no probada
  } else if (buscarlinea(archivo, numlinea, "[Mec. Doble Deslizadera]")) {
    ClaseDobleDeslizadera dobleDeslizadera=new ClaseDobleDeslizadera();
    dobleDeslizadera.leer(archivo, numlinea);
  }


  for (int i=0; i<archivo.length; i++) {
    if (archivo[i].startsWith("[Dda. 4 Barras Fija")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiada4BarrasMovil Diada=crearDiada4BarrasFija(ListaPuntos.buscar(nombreenlace1));
      //println(numlineaDiada);
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Punto") && (archivo[i+1]).equals("Tipo Entidad=Punto Asociado")) {
      numlinea=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace=splitTokens(archivo[numlinea], "=")[1];
      buscarlinea(archivo, numlinea, "Longitud");
      String longitud=splitTokens(archivo[numlinea], "=")[1];
      buscarlinea(archivo, numlinea, "�ngulo");
      String ang=splitTokens(archivo[numlinea], "=")[1];
      ListaPuntos.crearAdicional(ListaEslabones.buscar(nombreenlace), float(longitud), float(ang));
    } else if (archivo[i].startsWith("[Dda. 4 Barras M�vil")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      buscarlinea(archivo, numlinea, "Enlace(B)");
      String nombreenlace2=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiada4BarrasMovil Diada=crearDiada4BarrasMovil(ListaPuntos.buscar(nombreenlace2), ListaPuntos.buscar(nombreenlace1));
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Dda. Biela Manivela M�vil")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      buscarlinea(archivo, numlinea, "Enlace(B)");
      String nombreenlace2=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaBielaManivelaMovil Diada=crearDiadaBielaManivelaMovil(ListaPuntos.buscar(nombreenlace1), (ListaBarras.buscar(nombreenlace2)));
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Dda. Biela Manivela Fija")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaBielaManivelaMovil Diada=crearDiadaBielaManivelaFija(ListaPuntos.buscar(nombreenlace1));
      Diada.leer(archivo, i);
    } else if (archivo[i].startsWith("[Dda. Biela Manivela Fija 2")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaBielaManivelaMovil Diada=crearDiadaBielaManivelaFija2(ListaBarras.buscar(nombreenlace1));
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Dda. Deslizadera Fija")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaDeslizaderaInversionMovil Diada=crearDiadaDeslizaderaInversionFija2(ListaPuntos.buscar(nombreenlace1));
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Dda. Inversi�n 4 Fija 2")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaDeslizaderaBaseMovil Diada=crearDiadaDeslizaderaBaseFija2(ListaPuntos.buscar(nombreenlace1));
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Dda. Inversi�n 4 Fija")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaDeslizaderaBaseMovil Diada=crearDiadaDeslizaderaBaseFija(ListaPuntos.buscar(nombreenlace1));
      Diada.leer(archivo, numlineaDiada);
    } else if (archivo[i].startsWith("[Dda. Inversi�n 4 M�vil")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      buscarlinea(archivo, numlinea, "Enlace(B)");
      String nombreenlace2=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaDeslizaderaBaseMovil Diada=crearDiadaDeslizaderaBaseMovil(ListaPuntos.buscar(nombreenlace1), ListaPuntos.buscar(nombreenlace2));
      Diada.leer(archivo, numlineaDiada);
      //ListaPuntos.quitarPuntoExnula();
    } else if (archivo[i].startsWith("[Dda. Deslizadera-Inversi�n 3 M�vil")) {
      numlinea=i;
      numlineaDiada=i;
      buscarlinea(archivo, numlinea, "Enlace(A)");
      String nombreenlace1=splitTokens(archivo[numlinea], "=")[1];
      buscarlinea(archivo, numlinea, "Enlace(B)");
      String nombreenlace2=splitTokens(archivo[numlinea], "=")[1];
      ClaseDiadaDeslizaderaInversionMovil Diada=crearDiadaDeslizaderaInversionMovil(ListaPuntos.buscar(nombreenlace1), ListaPuntos.buscar(nombreenlace2));
      Diada.leer(archivo, numlineaDiada);
    }
    /* if (archivo[i].equals("[Visualizaci�n]")) {
     gZoom=gZoom*(float(splitTokens(archivo[i+3], "=")[1]));
     }*/


    /*  for (int n=0; n < ListaPuntos.ListaPuntos.size(); n++) {
     println(ListaPuntos.ListaPuntos.get(n).nombre);
     
     }
     for (int n=0; n < ListaBarras.ListaBarras.size(); n++) {
     println(ListaBarras.ListaBarras.get(n).nombre);
     
     }
     for (int n=0; n < ListaExcentricidades.ListaExcentricidades.size(); n++) {
     println(ListaExcentricidades.ListaExcentricidades.get(n).nombre);
     
     }
     for (int n=0; n < ListaApoyos.ListaApoyos.size(); n++) {
     println(ListaApoyos.ListaApoyos.get(n).nombre);
     
     }
     for (int n=0; n < ListaDeslizaderas.ListaDeslizaderas.size(); n++) {
     println(ListaDeslizaderas.ListaDeslizaderas.get(n).nombre);
     
     }*/
  }
  buscarlinea(archivo, numlinea, "[Visualizaci�n]" );
  buscarlinea(archivo, numlinea, "Posici�n Foco-0");
  gposFoco.x=-float(splitTokens(archivo[numlinea], "= ")[2])/height;
  gposFoco.y=-float(splitTokens(archivo[numlinea], "= ")[3])/height;
  buscarlinea(archivo, numlinea, "Zoom-0");
  float Zoom=float(splitTokens(archivo[numlinea], "=")[1]);
  buscarlinea(archivo, numlinea, "Escala de Posiciones-0");
  float EscPos=float(splitTokens(archivo[numlinea], "=")[1]);
  gZoom=Zoom*height/EscPos;
}
String LeerarchivoGeneral () {
  String[] documento= loadStrings("archivoGeneral.txt");
   return(documento[0]);
  
  
}
PVector calculaPunto(float ln, PVector rOi, float thetaf1) {
  PVector rOf=new PVector(0, 0);
  rOf.x=ln*cos(radians(thetaf1))+rOi.x;
  rOf.y=ln*sin(radians(thetaf1))+rOi.y;
  return(rOf);
}
boolean Diada4BarrasPos(PVector PosA, PVector PosO4, float r3, float r4, boolean cruzado) {
  float Cateto, Hipotenusa;
  EslabonBasePos(PosO4, PosA);
  Thetad=resAngulo;
  Rd=resDistancia;
  if ((Similar(Rd + r4, r3)) || (Similar(Rd + r3, r4))|| (Similar(Rd, r4+r3))) {
    Theta3d=0.0;
    Thetad4=0.0;
    if (Similar(Rd + r4, r3)) {
      Theta3d=0.0;
      Thetad4=180.0;
    }
    if (Similar(Rd + r3, r4)) {
      Theta3d=180.0;
      Thetad4=0.0;
    }
    if (Similar(Rd, r4+r3)) {
      Theta3d=0.0;
      Thetad4=0.0;
    }
  } else {
    Cateto=Rd*Rd+r3*r3-r4*r4;
    Hipotenusa=2.0*Rd*r3;
    if (MenorOIgual(abs(Cateto), Hipotenusa)) {
      Theta3d=degrees(acos(Cateto/Hipotenusa));
    } else {
      return(true);
    }
    Thetad4=degrees(asin(((r3*sin(radians(Theta3d))))/r4));
    if ((r3*cos(radians(Theta3d))) > Rd) {
      Thetad4=180-Thetad4;
    }
  }
  if (!cruzado) {
    Theta3=NormalizaAng(Thetad - Theta3d);
    Theta4=NormalizaAng(Thetad + Thetad4 - 180);
  } else {
    Theta3=NormalizaAng(Thetad + Theta3d);
    Theta4=NormalizaAng(Thetad - Thetad4 - 180);
  }

  return(false);
}
boolean DiadaBielaManivelaPos(PVector PosA, PVector PosO4, float r3, float exmodulo, float exangulo, float thetaDirB, boolean cruzado) {
  float Cateto;
  boolean diadaRota=true;
  EslabonBasePos(PosO4, PosA);
  Thetad=resAngulo;
  Rd=resDistancia;
  Cateto=Rd*sin(radians(Thetad-thetaDirB))-exmodulo*sin(radians(exangulo-thetaDirB));
  if (MenorOIgual(abs(Cateto), r3)) {
    if (cruzado) {
      Theta3=NormalizaAng(thetaDirB +180 - degrees(asin(Cateto/r3)));
      //Theta3=(thetaDirB + PI - asin(Cateto/r3));
    } else {
      Theta3=NormalizaAng(thetaDirB + degrees(asin(Cateto/r3)));
      //Theta3=(thetaDirB + asin(Cateto/r3));
    }
  } else {
    return(diadaRota);
  }
  PosBRel=r3*cos(radians(Theta3 - thetaDirB)) + exmodulo*cos(radians(exangulo-thetaDirB)) - Rd * cos(radians(Thetad - thetaDirB));
  return(!diadaRota);
}
boolean DiadaDeslizderaInversion3Pos(PVector PosA, PVector PosO4, float r3, float desfase2, float l3, float r4, float desfase4) {
  float Cateto;
  boolean diadaRota=false;
  EslabonBasePos(PosO4, PosA);
  Thetad=resAngulo;
  Rd=resDistancia;
  Cateto=r3*sin(radians(desfase2))-r4*sin(radians(desfase4));
  if (abs(Cateto)<=Rd) {
    Theta13=degrees(asin(Cateto/Rd));
  } else {
    diadaRota=true;
    return(diadaRota);
  }
  Theta3=NormalizaAng(Thetad-Theta13);
  PosBRelA=Rd*cos(radians(Theta13))-r3*cos(radians(desfase2))+r4*cos(radians(desfase4));
  if ((PosBRelA < 0.0) || (l3 < PosBRelA)) {
    diadaRota=true;
    return(diadaRota);
  } else {
    ThetaExcentricidad=Theta3+desfase4;
  }
  diadaRota=false;
  return(diadaRota);
}
/*PVector calculaCarrera(float anguloEx, float LongEx, float thetaDirb, float long2, float long3, PVector R1) {
 
 PVector ExtremosCarrera=new PVector();
 float Angulo251;
 float Angulo252;
 
 Angulo251=degrees(asin((-(LongEx*sin(radians(anguloEx)))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2+long3)));
 Angulo252=degrees(asin((-(LongEx*sin(radians(anguloEx)))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2-long3)));
 if (Float.isNaN(Angulo252)) {
 Angulo252=180-Angulo251;
 }
 if (LongEx==0) {
 ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 ExtremosCarrera.y =-((long2+long3)*cos(radians(Angulo252))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb)));
 } else {
 ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 ExtremosCarrera.y =(long2+long3)*cos(radians(Angulo252))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 }
 // println(ExtremosCarrera);
 
 return(ExtremosCarrera);
 }
/* PVector ExtremosCarrera=new PVector();
 float Angulo251;
 float Angulo252;
 
 Angulo251=degrees(asin((-(LongEx*sin(radians(anguloEx)))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2+long3)));
 Angulo252=degrees(asin((-(LongEx*sin(radians(anguloEx)))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2-long3)));
 if (Float.isNaN(Angulo252)) {
 Angulo252=180-Angulo251;
 }
 if (LongEx==0) {
 ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 ExtremosCarrera.y =-((long2+long3)*cos(radians(Angulo252))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb)));
 } else {
 ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 ExtremosCarrera.y =(long2+long3)*cos(radians(Angulo252))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 }
 // println(ExtremosCarrera);
 
 return(ExtremosCarrera);
 }*/


/*PVector calculaCarrera( PVector O2 , PVector PFijo,float anguloEx, float LongEx, float thetaDirb, float long2, float long3, PVector R1){
 
 PVector ExtremosCarrera=new PVector();
 float Angulo251;
 
 
 Angulo251=degrees(asin((-LongEx*sin(radians(anguloEx))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2+long3)));
 
 ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 //println(ExtremosCarrera.x);
 float PFijodist;
 PFijodist=PFijoSimetrico(O2, PFijo, thetaDirb);
 //println(PFijodist);
 //ExtremosCarrera.y= -(2*PFijodist+ExtremosCarrera.x);
 ExtremosCarrera.y= -(ExtremosCarrera.x-2*PFijodist);
 //println(ExtremosCarrera);
 return(ExtremosCarrera);
 
 
 }*/
/* PVector calculaCarrera( PVector O2 , PVector PFijo,float anguloEx, float LongEx, float thetaDirb, float long2, float long3, PVector R1){
 
 PVector ExtremosCarrera=new PVector();
 float Angulo251;
 
 
 Angulo251=degrees(asin((-LongEx*sin(radians(anguloEx))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2+long3)));
 
 ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
 
 //println(ExtremosCarrera.x);
 //pushMatrix();
 //float x=(PFijo.y-O2.y+(1/tan(thetaDirb))*O2.x+PFijo.x*tan(thetaDirb))/((1/tan(thetaDirb))-tan(thetaDirb));
 //float y=O2.y+ (1/tan(thetaDirb))*(x-O2.x);
 //translate(x,y);
 
 float PFijodist;
 PFijodist=PFijoSimetrico(O2, PFijo, thetaDirb);
 //println(PFijodist);
 ExtremosCarrera.y= -(PFijodist+ExtremosCarrera.x);
 //ExtremosCarrera.y= -(ExtremosCarrera.x-2*PFijodist);
 //popMatrix();
 //println(ExtremosCarrera);
 return(ExtremosCarrera);
 
 
 }*/
PVector calculaCarrera( PVector O2, PVector PFijo, float anguloEx, float LongEx, float thetaDirb, float long2, float long3, PVector R1) {

  PVector ExtremosCarrera=new PVector();
  float Angulo251;


  Angulo251=degrees(asin((-LongEx*sin(radians(anguloEx))-R1.x*sin(radians(thetaDirb))+R1.y*cos(radians(thetaDirb)))/(long2+long3)));

  ExtremosCarrera.x =(long2+long3)*cos(radians(Angulo251))+LongEx*cos(radians(anguloEx))-R1.x*cos(radians(thetaDirb))-R1.y*sin(radians(thetaDirb));
  PVector PuntoQ=new PVector();
  if (thetaDirb==0) {  /// ESTO NO VA A FUNCIONAR, hay que utilizar Similar()
    thetaDirb=-180;
  }
  PuntoQ.x=((O2.y-PFijo.y+O2.x/tan(radians(thetaDirb))+PFijo.x*tan(radians(thetaDirb)))/(tan(radians(thetaDirb))+(1/tan(radians(thetaDirb)))));
  PuntoQ.y=PFijo.y+tan(radians(thetaDirb))*(PuntoQ.x-PFijo.x);
  println(PuntoQ.x);
  println(PuntoQ.y);

  float valorcomparado=O2.y-(1/tan(radians(thetaDirb)))*(PFijo.x-O2.x)-PFijo.y;
  float Distancia=dist(PuntoQ.x, PuntoQ.y, PFijo.x, PFijo.y);
  if (thetaDirb > 0 && thetaDirb < 180) {
    if (valorcomparado <= 0) {
      ExtremosCarrera.y=-(2*Distancia+ExtremosCarrera.x);
    } else {
      ExtremosCarrera.y=-(-2*Distancia+ExtremosCarrera.x);
    }
  } else {
    if (valorcomparado >= 0) {
      ExtremosCarrera.y=-(2*Distancia+ExtremosCarrera.x);
    } else {
      ExtremosCarrera.y=-(-2*Distancia+ExtremosCarrera.x);
    }
  }
  //println(ExtremosCarrera);
  return(ExtremosCarrera);
}
PVector a_pixel(PVector mm) {
  PVector pixel=new PVector();
  pixel.x=+0.5*width+gZoom*(mm.x-gposFoco.x);
  pixel.y=+0.5*height-gZoom*(mm.y-gposFoco.y);
  return(pixel);
}
//void aa_pixel(PVector mm) {
//  mm.x=+0.5*width+gZoom*(mm.x-gposFoco.x);
//  mm.y=+0.5*height-gZoom*(mm.y-gposFoco.y);
//}
////Revisar
PVector a_mm(PVector pixel) {
  PVector mm=new PVector();
  mm.x=((pixel.x-0.5*width)/gZoom)+gposFoco.x;
  mm.y=((pixel.y-0.5*height)/-gZoom)+gposFoco.y;
  return(mm);
}
//PVector a_mm_sinZoom(PVector pixel) {
//   PVector mm=new PVector(0, 0);
//  mm.x=((pixel.x-0.5*width)+gposFoco.x);
//  mm.y=((pixel.y-0.5*height)+gposFoco.y);
//  return(mm);
  
//}
//void cambiocoordenadas() {
//  translate(0.5*width+gZoom*(-gposFoco.x), 0.5*height-gZoom*(-gposFoco.y));
//}

PVector raton_a_mm( ) {
  PVector raton=new PVector(mouseX, mouseY);
  return(a_mm(raton));
}
class ClaseApoyo extends ClasePunto {
  //Apoyo() {
  //}
  void pintar() {
    PVector Posp;
    Posp=a_pixel(Pos);
    stroke(colorEslabon);
    strokeWeight(ancholineaDeslizadera);
    fill(colorDeslizadera);
    rectMode(CENTER);
    rect(Posp.x, Posp.y+5.9, 20, 12);
    arc(Posp.x, Posp.y, 20, 20, radians(180), radians(360));
    strokeWeight(ancholineaDeslizadera);
    fill(colorPunto);
    ellipse(Posp.x, Posp.y, SizePunto, SizePunto);
  }
  void escribirnombre() {
    PVector Posp;
    Posp=a_pixel(Pos);
    textSize(letra);
    fill(colorLetra);
    text("O", Posp.x-6, Posp.y+syApoyo);
    textSize(letrachica);
    text(eslabonEnlace.Indice, Posp.x+7, Posp.y+syApoyo+ysubindice);
  }
  void crearnombre() {
    this.nombre=("Apoyo O"+eslabonEnlace.Indice);
  }
  /*void leer(String[] lista_txt, int i) {
   for (int j=i; j < lista_txt.length; j++) {
   if ((lista_txt[j]).equals("["+nombre+"]")== true) {
   // buscarlinea(lista_txt,j,"posicion" );
   String[] posicion=splitTokens(lista_txt[j+3], "= ");
   Pos=new PVector(float (posicion[1]), float(posicion[2]));
   break;
   }
   }
   }*/
  void leer(String[] lista_txt, int i) {
    buscarlinea(lista_txt, i, "["+nombre+"]" );
    buscarlinea(lista_txt, numlinea, "Posici�n" );
    String[] posicion=splitTokens(lista_txt[numlinea], "= ");
    Pos=new PVector(float (posicion[1]), float(posicion[2]));
  }
}
class ClaseApoyoDeslizante extends ClasePunto {

  //ApoyoDeslizante() {
  //}

  void escribirnombre() {
  }
  void crearnombre() {
    nombre=("Apoyo Deslizante AD"+Indice);
  }
}
class ClaseBarra extends ClaseEslabon {
  float L;
  ClasePunto PFinal;
  //Barra() {
  //}
  void pintar() {
    if (L!=0) {
      if (!rota) {
        if (this instanceof ClaseExcentricidad && eslabonMotor.es_este_eslabon(((ClaseExcentricidad)this).eslabonasociado)) {
          stroke(colorEslabon);
        } else if (eslabonMotor.es_este_eslabon(this)) {
          stroke(colorEslabon);
          if (EslabonCogido || EncimaEslabon) {
            stroke(colorEncimaEslabon);
          }
        } else {
          if (enlaceEstructura.cadenaRota(enlaceEstructura)) {
            stroke(colorEslabonRoto);
          } else {
            stroke(colorEslabon);
          }
        }
        PVector PInicialp, PFinalp;
        PInicialp=a_pixel(PInicial.Pos);
        PFinalp=a_pixel(PFinal.Pos);
        strokeWeight(anchoEslabon);
        line(PInicialp.x, PInicialp.y, PFinalp.x, PFinalp.y);
      }
    }
  }

  void pintarTriangulo() {
    for (int i=0; i< ListaPuntosAdicionales.ListaPuntosAdicionales.size(); i++) {
      PVector PInicialp, PFinalp;
      PInicialp=a_pixel(PInicial.Pos);
      PFinalp=a_pixel(PFinal.Pos);
      if (!rota) {
        PVector Posp;
        Posp=a_pixel(ListaPuntosAdicionales.ListaPuntosAdicionales.get(i).Pos);
        strokeWeight(ancholineatriangulo);
        stroke(colorEslabon);
        fill(colorTriangulo);
        triangle(PInicialp.x, PInicialp.y, PFinalp.x, PFinalp.y, Posp.x, Posp.y);
      }
    }
  }
  void escribirnombre() {
    if (!rota) {
      if (eslabonMotor.es_este_eslabon(this)) {
        fill(colorLetra);
      } else {
        if (enlaceEstructura.cadenaRota(enlaceEstructura)) {
          fill(colorLetraRota);
        } else {
          fill(colorLetra);
        }
      }
      textSize(letra);
      PVector Pos;
      PVector Posp;
      Pos=calculaPunto((L/2.0), PInicial.Pos, theta+degrees(atan((ds*L)/(L/2.0))));
      Posp=a_pixel(Pos);
      text(Indice, Posp.x, Posp.y);
    }
  }
  /*void leer(String[] lista_txt, int i) {
   for (int j=i; j < lista_txt.length; j++) {
   if ((lista_txt[j]).equals("["+nombre+"]")== true) {
   String longitud=splitTokens(lista_txt[j+13], "=")[1];
   L=float(longitud);
   break;
   }
   }
   }*/
  void leer(String[] lista_txt, int i) {
    buscarlinea(lista_txt, i, "["+nombre+"]" );
    buscarlinea(lista_txt, numlinea, "Longitud" );
    String longitud=splitTokens(lista_txt[numlinea], "=")[1];
    L=float(longitud);
    println(Indice + " " + L);
  }
}
class ClaseDeslizadera extends ClaseEslabon {
  float distancia;
  PVector limitesCarrera=new PVector();
  ClaseDireccion direccionEnlace;
  //Deslizadera() {
  //}
  void pintar() {
    PVector Op;
    if (!rota) {
      if (eslabonMotor.es_este_eslabon(this)) {
        stroke(colorEslabon);
        fill(colorDeslizadera);
        if (EslabonCogido || EncimaEslabon) {
          fill(colorEncimaEslabon);
          //stroke(colorEncimaEslabon);
        }
      } else {
        fill(colorDeslizadera);
        if (enlaceEstructura.cadenaRota(enlaceEstructura)) {
          stroke(colorEslabonRoto);
        } else {
          stroke(colorEslabon);
        }
      }
      Op=a_pixel(PInicial.Pos);
      strokeWeight(ancholineaDeslizadera);
      //fill(colorDeslizadera);
      rectMode(CENTER);
      pushMatrix();
      translate(Op.x, Op.y);
      rotate(radians(-theta));
      rect(0, 0, DX, DY, 5);
      popMatrix();
      stroke(0);
    }
  }
  void pintarlinea() {
    for (int i=0; i< ListaPuntosAdicionales.ListaPuntosAdicionales.size(); i++) {
      PVector PInicialp;
      PInicialp=a_pixel(PInicial.Pos);
      //if ( !rota) {
      PVector Posp;
      Posp=a_pixel(ListaPuntosAdicionales.ListaPuntosAdicionales.get(i).Pos);
      strokeWeight(anchoEslabon);
      if (rota) {
        stroke(colorEslabonRoto);
      } else {
        stroke(colorEslabon);
      }
      line(PInicialp.x, PInicialp.y, Posp.x, Posp.y);
      // }
    }
  }
  void escribirnombre() {
    if (!rota) {
      PVector Posp;
      Posp=a_pixel(PInicial.Pos);
      if (enlaceEstructura.cadenaRota(enlaceEstructura)) {
        fill(colorEslabonRoto);
      } else {
        fill(colorEslabon);
      }
      textSize(letra);
      text(Indice, Posp.x+sxDeslizadera, Posp.y);
    }
  }
 /* void leerfija(String[] lista_txt, int i) {
    for (int j=i; j < lista_txt.length; j++) {

      if (splitTokens(lista_txt[j])[0].equals("[Apoyo")== true && splitTokens(lista_txt[j])[1].equals("Deslizante")== true) {
        String[] posicion=splitTokens(lista_txt[j+3], "= ");
        PInicial.Pos=new PVector(float (posicion[1]), float(posicion[2]));
      }
      if (splitTokens(lista_txt[j])[0].equals("[Deslizadera")== true) {
        String ang=splitTokens(lista_txt[j+16], "=")[1];
        theta=float(ang); 
        break;
      }
    }
  }*/
void leerfija(String[] lista_txt, int i) {
    for (int j=i; j < lista_txt.length; j++) {

      if (lista_txt[j].startsWith("[Apoyo Deslizante")) {
        buscarlinea(lista_txt, j, "Posici�n" );
        String[] posicion=splitTokens(lista_txt[numlinea], "= ");
        PInicial.Pos=new PVector(float (posicion[1]), float(posicion[2]));
      }
      if (lista_txt[j].startsWith("[Deslizadera")) {
        buscarlinea(lista_txt, j, "�ngulo" );
        String ang=splitTokens(lista_txt[numlinea], "=")[1];
        theta=float(ang); 
        break;
      }
    }
  }
}
class ClaseDeslizaderaFija extends ClaseDeslizadera {

  //DeslizaderaFija() {
  //}

  void escribirnombre() {
    if (!rota) {
      PVector Posp;
      Posp=a_pixel(PInicial.Pos);
      if (enlaceEstructura.cadenaRota(enlaceEstructura)) {
        fill(colorEslabonRoto);
      } else {
        fill(colorEslabon);
      }
      textSize(letra);
      text("DF", Posp.x-2, Posp.y+syApoyo);
      textSize(letrachica);
      text(Indice, Posp.x+17, Posp.y+syApoyo);
    }
  }
  void crearnombre() {
    nombre=("Deslizadera DF"+Indice);
  }
}
class ClaseDiada extends ClaseEstructura {
  ClasePunto OD2;//Primer enganche de la diada siempre es un punto
  ClaseEntidad OD3;//Segundo enganche de la diada puede ser un punto(Diada4Barras) o una Recta o Barra(DiadaBielaManivela)

  //Diada() {
  //}


}
class ClaseDireccion extends ClaseEntidad {
  float theta;
  ClasePunto PInicial;
  //ClaseDireccion(){
  //}
}
class ClaseEntidad {
  boolean rota;
  ClaseEstructura enlaceEstructura;
  //ClaseEntidad(){
  //}
}
class ClaseEslabon extends ClaseDireccion {
  String nombre;
  boolean motorizable;
  int Indice;
  ClaseExcentricidad excentricidadasociada;
  ListadePuntosAdicionales ListaPuntosAdicionales=new ListadePuntosAdicionales();

  //Eslabon() {
  //}
  void crearnombre() {
    if (this instanceof ClaseBarra) {
      nombre=("Barra "+Indice);
    } else if (this instanceof ClaseDeslizadera) {
      nombre=("Deslizadera "+Indice);
    }
  }
}
class ClaseEslabonMotor {
  ClaseEslabon eslabonMotorEnlace;
  //ClaseEslabonMotor() {
  //}
  void moverse() {
    if (eslabonMotorEnlace instanceof ClaseBarra) {
      eslabonMotorEnlace.theta=NormalizaAng(eslabonMotorEnlace.theta + pasoAng);
    } else {
      ClaseDeslizadera tmpDesliz = (ClaseDeslizadera) eslabonMotorEnlace; 
      tmpDesliz.distancia = tmpDesliz.distancia + pasoLin*(velocidad/gZoom);
      if ((tmpDesliz.distancia >= tmpDesliz.limitesCarrera.x) || (tmpDesliz.distancia <= tmpDesliz.limitesCarrera.y)) {
        pasoLin=-pasoLin;
      }
    }
  }
  boolean es_este_eslabon(ClaseEslabon esl) {
    return(eslabonMotorEnlace==esl);
  }
  void leer(String[] lineas_txt, int i) {
    for (int j=i; j < lineas_txt.length; j++) {
      if (CompararStrings(lineas_txt[j],"[Eslab�n Motor]")) {
        String enlace=splitTokens(lineas_txt[j+1], "=")[1];
        eslabonMotorEnlace=ListaEslabones.buscar(enlace);
        break;
      }
    }
  }
}
class ClaseEstructura {
  boolean mecanismoRoto;
  boolean cruzado;
  //Estructura() {
  //}



  boolean cadenaRota(ClaseEstructura estr) {
    if (estr instanceof ClaseMecanismo) {
      return(estr.mecanismoRoto);
    } else {
      ClaseDiada tmpDiada = (ClaseDiada) estr;
      if (tmpDiada.OD2 instanceof ClaseApoyo ) {
        if (tmpDiada.OD3 instanceof ClasePunto ) {
          return(estr.mecanismoRoto || cadenaRota(((ClasePunto) tmpDiada.OD3).eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((ClasePunto) tmpDiada.OD3).eslabonEnlace));
        } else {
          return(estr.mecanismoRoto || cadenaRota(((ClaseDireccion) tmpDiada.OD3).PInicial.eslabonEnlace.enlaceEstructura));
        }
      } else {
        if ((tmpDiada.OD3 instanceof ClaseApoyo) || (tmpDiada.OD3 instanceof ClaseDireccion)) {
          return(estr.mecanismoRoto || cadenaRota(((ClasePunto) tmpDiada.OD2).eslabonEnlace.enlaceEstructura) && !eslabonMotor.es_este_eslabon(((ClasePunto) tmpDiada.OD2).eslabonEnlace));
        } else {
          return(estr.mecanismoRoto || cadenaRota(((ClasePunto) tmpDiada.OD2).eslabonEnlace.enlaceEstructura) && !eslabonMotor.es_este_eslabon(((ClasePunto) tmpDiada.OD2).eslabonEnlace));
        }
      }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /* if (estr instanceof Mecanismo || ((Diada)estr).OD2 instanceof Apoyo || ((Diada)estr).OD3 instanceof Recta) {
     return(estr.mecanismoRoto);
     } else {
     if (((Diada)estr).OD3 instanceof Punto) {
     return(estr.mecanismoRoto || cadenaRota(((Diada)estr).OD2.eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Diada)estr).OD2.eslabonEnlace)) || cadenaRota(((Punto)((Diada)estr).OD3).eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Punto)((Diada)estr).OD3).eslabonEnlace);
     } else {
     return(estr.mecanismoRoto || cadenaRota(((Diada)estr).OD2.eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Diada)estr).OD2.eslabonEnlace));// || cadenaRota(((Direccion)((Diada)estr).OD3).enlaceEstructura));
     }
     }*/
    //////////////////////////////////////////////////////
    /* if (estr instanceof Mecanismo  || ((Diada)estr).OD3 instanceof Recta) {
     return(estr.mecanismoRoto);
     } else if (((Diada)estr).OD2 instanceof Apoyo ) {
     if (((Diada)estr).OD3 instanceof Punto ) {
     return(estr.mecanismoRoto || cadenaRota(((Punto)((Diada)estr).OD3).eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Punto)((Diada)estr).OD3).eslabonEnlace));
     } else {
     return(estr.mecanismoRoto || cadenaRota(((Direccion)((Diada)estr).OD3).enlaceEstructura));
     }
     } else if (((Diada)estr).OD3 instanceof Apoyo ) {
     return(estr.mecanismoRoto || cadenaRota(((Punto)((Diada)estr).OD2).eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Punto)((Diada)estr).OD2).eslabonEnlace));
     } else {
     if (((Diada)estr).OD3 instanceof Punto) {
     return(estr.mecanismoRoto || cadenaRota(((Diada)estr).OD2.eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon((((Diada)estr).OD2.eslabonEnlace)) || cadenaRota(((Punto)((Diada)estr).OD3).eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Punto)((Diada)estr).OD3).eslabonEnlace));
     } else {
     return(estr.mecanismoRoto || cadenaRota(((Diada)estr).OD2.eslabonEnlace.enlaceEstructura)   && !eslabonMotor.es_este_eslabon(((Diada)estr).OD2.eslabonEnlace));// || cadenaRota(((Direccion)((Diada)estr).OD3).enlaceEstructura));
     }
     }*/
  }

  void calcular() {
  }
  void cruzada(String[] lista, int i) {
    buscarlinea(lista, i, "Mecanismo Cruzado" );
    cruzado=CompararStrings(splitTokens(lista[numlinea], "=")[1],"Si");
  }
}
class ClaseExcentricidad extends ClaseBarra {
  ClaseEslabon eslabonasociado;

  //Excentricidad() {
  //}

  void escribirnombre() {
    if (L!=0) {
      if (eslabonMotor.es_este_eslabon(eslabonasociado)) {
        fill(colorLetra);
      } else {
        if (eslabonMotor.es_este_eslabon(this)) {
          stroke(colorEslabon);
          if (EslabonCogido || EncimaEslabon) {
            stroke(colorEncimaEslabon);
          }
        } else {
          if (enlaceEstructura.cadenaRota(enlaceEstructura)) {
            fill(colorEslabonRoto);
          } else {
            fill(colorEslabon);
          }
        }
      }
      if (!rota) {
        textSize(letra);
        textAlign(CENTER);
        PVector Pos;
        PVector Posp;
        Pos=calculaPunto(L/2.0, PInicial.Pos, eslabonasociado.theta+theta);
        Posp=a_pixel(Pos);
        text("EX", Posp.x-19, Posp.y+syExcentricidad);
        textSize(letrachica);
        text(eslabonasociado.Indice, Posp.x+xsubindiceex-19, Posp.y+ysubindice+syExcentricidad);
      }
    }
  }
  void crearnombre() {
    this.nombre=("Excentricidad Ex"+eslabonasociado.Indice);
  }
/*  void leer(String[] lista_txt, int i) {
   for (int j=i; j < lista_txt.length; j++) {
   if ((lista_txt[j]).equals("["+nombre+"]")== true) {
   String longitud=splitTokens(lista_txt[j+13], "=")[1];
   String ang=splitTokens(lista_txt[j+15], "=")[1];
   String nula=splitTokens(lista_txt[j+14], "=")[1];
   if (nula.equals("Si")) {
   longitud="0";
   }
   L=float(longitud);
   theta=degrees(float(ang));
   //ListaPuntos.quitarPuntoExnula();
   break;
   }
   }
   }*/
  void leer(String[] lista_txt, int i) {
    buscarlinea(lista_txt, i, "["+nombre+"]" );
    buscarlinea(lista_txt, numlinea, "Longitud" );
    String longitud=splitTokens(lista_txt[numlinea], "=")[1];
    buscarlinea(lista_txt, numlinea, "Nula" );
    String nula=splitTokens(lista_txt[numlinea], "=")[1];
    buscarlinea(lista_txt, numlinea, "�ngulo" );
    String ang=splitTokens(lista_txt[numlinea], "=")[1];   
    if (CompararStrings(nula,"Si")) {
      longitud="0";
    }
    L=float(longitud);
    theta=degrees(float(ang));
    //ListaPuntos.quitarPuntoExnula();
  }
}
class ClaseMecanismo extends ClaseEstructura {
 
  //Mecanismo() {
  //}
}
class ClasePunto extends ClaseEntidad{
  PVector Pos;
  String nombre;
  int Indice;
  ClaseEslabon eslabonEnlace;//Para que el punto adicional sepa si está asociado a una deslizadera o a una Barra.

  //Punto() {
  //}
  void pintar() {
    if (!rota) {
      if (eslabonMotor.es_este_eslabon(eslabonEnlace)) {
        stroke(colorEslabon);
        fill(colorPunto);
      } else {
        if (eslabonEnlace.enlaceEstructura.cadenaRota(eslabonEnlace.enlaceEstructura)) {
          stroke(colorEslabonRoto);
          fill(colorEslabonRoto);
        } else {
          stroke(colorEslabon);
          fill(colorPunto);
        }
      }
      PVector Posp;
      Posp=a_pixel(Pos);
      strokeWeight(ancholineaDeslizadera);
      ellipse(Posp.x, Posp.y, SizePunto, SizePunto);
    }
  }
  void escribirnombre() {
    if (!rota) {
      if (eslabonMotor.es_este_eslabon(eslabonEnlace)) {
        fill(colorLetra);
      } else {
        if (eslabonEnlace.enlaceEstructura.cadenaRota(eslabonEnlace.enlaceEstructura)) {
          fill(colorLetraRota);
        } else {
          fill(colorLetra);
        }
      }
      PVector Posp;
      Posp=a_pixel(Pos);
      textSize(letra);
      text(char(Indice+63), Posp.x, Posp.y+syPunto);//Falta la función por si pasamos de la z.
    }
  }
 void crearnombre(){
   //
   // *** OJO, NO funciona si el número de puntos del mecanismo es > 26  
   //
   
   char letra = char(Indice+63);
   
   this.nombre=("Punto " + letra);  // char NO funciona en JavaScript 
//   this.nombre=("Punto " + String.fromCharCode(Indice+63)); 
  } 
}
class ClasePuntoAdicional extends ClasePunto {
  float anguloPuntoAdicional;
  float distancia;

  ClasePuntoAdicional(ClaseEslabon Eslabon1, float dist, float angulo) {
    anguloPuntoAdicional=angulo;
    eslabonEnlace=Eslabon1;
    eslabonEnlace.PInicial=Eslabon1.PInicial;
    distancia=dist;
  }
  void calcular() {
    if (eslabonEnlace instanceof ClaseBarra) {
      Pos=calculaPunto( distancia, eslabonEnlace.PInicial.Pos, eslabonEnlace.theta +anguloPuntoAdicional);
    } else {
      Pos=calculaPunto( distancia, eslabonEnlace.PInicial.Pos, -eslabonEnlace.theta +anguloPuntoAdicional);
    }
  }
  void pintar() {
    PVector Posp;
    Posp=a_pixel(Pos);

    if (eslabonEnlace instanceof ClaseBarra) {
      if (!eslabonEnlace.rota) {
        rota=false;
        if (eslabonMotor.es_este_eslabon(eslabonEnlace)) {
          stroke(colorEslabon);
          fill(colorPunto);
        } else {
          if (eslabonEnlace.enlaceEstructura.cadenaRota(eslabonEnlace.enlaceEstructura)) {
            stroke(colorEslabonRoto);
            fill(colorEslabonRoto);
          } else {
            stroke(colorEslabon);
            fill(colorPunto);
          }
        }
        ellipse(Posp.x, Posp.y, SizePunto, SizePunto);
      } else {
        rota=true;
      }
    } else {
      //strokeWeight(ancholineaDeslizadera);
      //fill(colorPunto);
      //ellipse(Posp.x, Posp.y, SizePunto, SizePunto);
      if (eslabonEnlace.enlaceEstructura.cadenaRota(eslabonEnlace.enlaceEstructura)) {
        stroke(colorEslabonRoto);
        fill(colorEslabonRoto);
      } else {
        stroke(colorEslabon);
        fill(colorPunto);
      }
      ellipse(Posp.x, Posp.y, SizePunto, SizePunto);
    }
  }
  ClasePunto Copy() {
    ClasePunto punto=new ClasePunto();
    punto.nombre=nombre;
    punto.Indice=Indice;
    punto.eslabonEnlace=eslabonEnlace;
    punto.Pos=Pos;
    punto.rota=rota;
    punto.enlaceEstructura=enlaceEstructura;
    return(punto);
  }
}
class ClasePuntoExtremo extends ClasePunto {
  ClaseExcentricidad exasociada;
  
  //PuntoExtremo() {
  //}
  
   void escribirnombre() {
     if(exasociada.L !=0)
    if (!rota) {
      if (eslabonMotor.es_este_eslabon(eslabonEnlace)) {
        fill(colorLetra);
      } else {
        if (eslabonEnlace.enlaceEstructura.cadenaRota(eslabonEnlace.enlaceEstructura)) {
          fill(colorLetraRota);
        } else {
          fill(colorLetra);
        }
      }
      PVector Posp;
      Posp=a_pixel(Pos);
      textSize(letra);
      text(char(exasociada.PInicial.Indice+63)+"'", Posp.x, Posp.y+syPunto);
    }
  }
   void crearnombre(){
   this.nombre=("Punto " + char(exasociada.PInicial.Indice+63)+"'"); 
  } 
  
}
class ClasePuntoFijo extends ClasePunto {

  //PuntoFijo() {
  //}

  void escribirnombre() {
    PVector Posp;
    Posp=a_pixel(Pos);
    textSize(letra);
    fill(colorLetra);
    text("F", Posp.x-6, Posp.y+syPunto);
    textSize(letrachica);
    text(Indice, Posp.x+2, Posp.y+syPunto+ysubindice);
  }
  void pintar() {
    PVector Posp;
    Posp=a_pixel(Pos);
    stroke(colorEslabon);
    fill(colorPunto);
    strokeWeight(ancholineaDeslizadera);
    ellipse(Posp.x, Posp.y, SizePunto, SizePunto);
  }
  void crearnombre() {
    this.nombre=("Punto Fijo F"+Indice);
  }
  /* void leer(String[] lista_txt, int i) {
   for (int j=i; j < lista_txt.length; j++) {
   if ((lista_txt[j]).equals("["+nombre+"]")== true) {
   String[] posicion=splitTokens(lista_txt[j+3], "= ");
   Pos=new PVector(float(posicion[1]), float( posicion[2]));
   break;
   }
   }
   }*/
  void leer(String[] lista_txt, int i) {
    buscarlinea(lista_txt, i, "["+nombre+"]" );
    buscarlinea(lista_txt, numlinea, "Posici�n" );
    String[] posicion=splitTokens(lista_txt[numlinea], "= ");
    Pos=new PVector(float(posicion[1]), float( posicion[2]));
  }
}
class ClaseRecta extends ClaseDireccion {

  int Indice;
  String nombre;
  //Recta() {
  //}

  void pintar() {
    lineadisc(theta, PInicial.Pos);
  }
  void crearnombre() {
    this.nombre=("Recta de Apoyo R"+Indice);
  }
  /* void leer(String[] lista_txt, int i) {
   for (int j=i; j < lista_txt.length; j++) {
   if ((lista_txt[j]).equals("["+nombre+"]")== true) {
   String[] ang=splitTokens(lista_txt[j+3], "=");
   theta=float(ang[1]);
   break;
   }
   }
   }*/
  void leer(String[] lista_txt, int i) {
    buscarlinea(lista_txt, i, "["+nombre+"]" );
    buscarlinea(lista_txt, numlinea, "�ngulo" );
    String[] ang=splitTokens(lista_txt[numlinea], "=");
    theta=float(ang[1]);
  }
}

class ClaseDiada4Barras extends ClaseDiada {
  ClasePunto A;
  ClasePunto OD3;
  ClaseBarra R2, R3;
  ClaseDiada4Barras(ClasePunto punto) {
    ListaEstructuras.incluirLista(this);
    A=ListaPuntos.crear();
    OD2=punto;
    OD3=ListaApoyos.crear();
    R2=ListaBarras.crear();
    R3=ListaBarras.crear();
    R3.PFinal=A;
    A.eslabonEnlace=R3;
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    
    
    R3.PInicial=OD3;
    R2.PInicial=punto;
    R2.PFinal=A;
    ListaEslabones.incluir(R2);
    ListaEslabones.incluir(R3);

    OD3.eslabonEnlace=R3;
  }
  void calcular() {
    if (!OD2.rota) {
      mecanismoRoto=Diada4BarrasPos(OD2.Pos, OD3.Pos, R2.L, R3.L, cruzado);
      R2.rota=mecanismoRoto;
      R3.rota=false;
      if (!mecanismoRoto) {
        R2.theta=Theta3;
        R3.theta=Theta4;
      }
      A.Pos=calculaPunto(R3.L, OD3.Pos, R3.theta);
    } else {
      R2.rota=true;
      R3.rota=false;
      mecanismoRoto=true;
    }
    R3.ListaPuntosAdicionales.calcular();
    R2.ListaPuntosAdicionales.calcular();
  }
}
class ClaseDiada4BarrasMovil extends ClaseDiada {
  ClasePunto A;
  ClaseBarra R2, R3;

  ClaseDiada4BarrasMovil(ClasePunto punto, ClasePunto punto2) {
    ListaEstructuras.incluirLista(this);
    OD2=punto;
    OD3=punto2;

    A=ListaPuntos.crear();

    R2=ListaBarras.crear();
    R3=ListaBarras.crear();

    A.eslabonEnlace=R2;
    
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;

    R3.PFinal=A;
    R3.PInicial=(ClasePunto)OD3;
    R2.PInicial=OD2;
    R2.PFinal=A;
    cruzado=false;
    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(R2);
  }

  void calcular() {
    if (!OD2.rota || !OD3.rota) {
      mecanismoRoto=Diada4BarrasPos(OD2.Pos, ((ClasePunto)OD3).Pos, R2.L, R3.L, cruzado);
      R3.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        R2.theta=Theta3;
        R3.theta=Theta4;
      }
      A.Pos=calculaPunto(R2.L, ((ClasePunto)OD2).Pos, R2.theta);
    } else {
      R3.rota=true;
      mecanismoRoto=true;
    }
    if (OD2 instanceof ClaseApoyo) {
      R2.rota=false;
      A.rota=false;
    } else {
      if (!OD2.rota && !OD3.rota) {
        R3.rota=mecanismoRoto;
        A.rota=mecanismoRoto;
        R2.rota=mecanismoRoto;
      } else {
        A.rota=true;
        R3.rota=true;
        R2.rota=true;
      }
    }
    R3.ListaPuntosAdicionales.calcular();
    R2.ListaPuntosAdicionales.calcular();
  }
  void leer(String[] lineas_txt, int i) {
    if (OD2 instanceof ClaseApoyo) {
      ((ClaseApoyo)OD2).leer(lineas_txt, i);
    }
    cruzada(lineas_txt, i);
    R2.leer(lineas_txt, i);
    R3.leer(lineas_txt, i);
  }
}

class ClaseDiadaBielaManivela extends ClaseDiada {
  ClaseBarra  R3;
  ClaseExcentricidad R4;
  ClasePunto  B;
  ClasePuntoFijo O4;
  ClaseRecta recta;
  ClaseDeslizadera Deslizadera1;
  ClaseDiadaBielaManivela(ClasePunto punto) {
    ListaEstructuras.incluirLista(this);
    OD2=punto;
    B=ListaPuntos.crear();
    O4=ListaPuntosFijos.crear();
    R3=ListaBarras.crear();
    R4=ListaExcentricidades.crear();
    Deslizadera1=ListaDeslizaderas.crear(true,false);
    recta=ListaRectas.crear();

    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(Deslizadera1);
    
    recta.PInicial=O4;
    B.eslabonEnlace=Deslizadera1;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    R4.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;
    
    R4.eslabonasociado=Deslizadera1;

   
    R3.PFinal=B;
    R3.PInicial=OD2;
    R4.PInicial=B;
    R4.PFinal=Deslizadera1.PInicial;   
  }
  void calcular() {
    if (!OD2.rota) {
      mecanismoRoto=DiadaBielaManivelaPos(OD2.Pos, O4.Pos, R3.L, R4.L, R4.theta + recta.theta, recta.theta, cruzado) ;
      R3.rota=mecanismoRoto; 
       //Deslizadera1.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        Deslizadera1.distancia=PosBRel;
        Deslizadera1.theta=recta.theta;
        R3.theta=Theta3;
      }
      R3.PInicial=OD2;
      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, O4.Pos, Deslizadera1.theta);
      B.Pos=calculaPunto(R4.L, Deslizadera1.PInicial.Pos, 180+R4.theta+Deslizadera1.theta);
      Deslizadera1.theta=recta.theta;
    } else {
      R3.rota=true;  
      Deslizadera1.enlaceEstructura.mecanismoRoto=true;
      R4.enlaceEstructura.mecanismoRoto=true;
     
    }
    R3.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
    //recta.pintar();
  }
}
class ClaseDiadaBielaManivelaMovil extends ClaseDiada {  
  ClaseBarra  R3;
  ClaseExcentricidad R4;
  ClasePunto  B;
  ClaseDeslizadera Deslizadera1;
  ClaseDiadaBielaManivelaMovil(ClasePunto punto, ClaseDireccion direccion1) {
    ListaEstructuras.incluirLista(this);
    OD2=punto;
    B=ListaPuntos.crear();
    R3=ListaBarras.crear();
    R4=ListaExcentricidades.crear();
    Deslizadera1=ListaDeslizaderas.crear(true, false);

    OD3=direccion1;

    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(Deslizadera1);

    ((ClasePuntoExtremo)Deslizadera1.PInicial).exasociada=R4;
    B.eslabonEnlace=R4;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    R4.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;

    R4.eslabonasociado=Deslizadera1;


    R3.PFinal=B;
    R3.PInicial=OD2;
    R4.PInicial=B;
    R4.PFinal=Deslizadera1.PInicial;
  }
  void calcular() {

    if (!OD2.rota && !OD3.rota) {
      ClaseDireccion tmpDir = (ClaseDireccion) OD3;
      mecanismoRoto=DiadaBielaManivelaPos(OD2.Pos, tmpDir.PInicial.Pos, R3.L, R4.L, R4.theta + tmpDir.theta, tmpDir.theta, cruzado) ;
      Deslizadera1.rota=mecanismoRoto;
      Deslizadera1.PInicial.rota=Deslizadera1.rota;
      if (!mecanismoRoto) {
        if (OD3 instanceof ClaseBarra) {
          mecanismoRoto=mecanismoRoto || (PosBRel < 0) || (PosBRel > ((ClaseBarra)OD3).L);
          Deslizadera1.rota=Deslizadera1.rota || (PosBRel < 0) || (PosBRel > ((ClaseBarra)OD3).L);
          Deslizadera1.PInicial.rota=Deslizadera1.rota;
          Deslizadera1.distancia=constrain(PosBRel, 0, ((ClaseBarra)OD3).L);
        } else {
          Deslizadera1.distancia=PosBRel;
        }
      } else {
        Deslizadera1.rota=false; 
        Deslizadera1.PInicial.rota=Deslizadera1.rota;//
      }
      if (!mecanismoRoto) {
        R3.theta=Theta3;
      }
      R4.rota=false;
      R3.rota=mecanismoRoto && !(OD2 instanceof ClaseApoyo);
      B.rota=false;
      Deslizadera1.rota=R4.rota;
      Deslizadera1.PInicial.rota=Deslizadera1.rota;
      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, ((ClaseDireccion)OD3).PInicial.Pos, ((ClaseDireccion)OD3).theta);
      if (OD2 instanceof ClaseApoyo) {
        B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
      } else {
        B.Pos=calculaPunto(R4.L, Deslizadera1.PInicial.Pos, 180+R4.theta+((ClaseDireccion)OD3).theta);
      }
      //R4.rota=true;
      //R3.rota=mecanismoRoto && !(OD2 instanceof Apoyo);
      //B.rota=R3.rota;
      //B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    } else if (!OD2.rota) {
      mecanismoRoto=true;
      R4.rota=true;
      R3.rota=!(OD2 instanceof ClaseApoyo);
      B.rota=R3.rota;
      Deslizadera1.rota=R4.rota;
      Deslizadera1.PInicial.rota=Deslizadera1.rota;
      B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    } else if (!OD3.rota) {
      mecanismoRoto=true;
      R3.rota=true;
      R4.rota=!(OD3 instanceof ClaseRecta);
      B.rota=R4.rota;
      Deslizadera1.rota=R4.rota;
      Deslizadera1.PInicial.rota=Deslizadera1.rota;
      B.Pos=calculaPunto(R4.L, Deslizadera1.PInicial.Pos, 180+R4.theta+((ClaseDireccion)OD3).theta);
    } else {
      mecanismoRoto=true;
      R3.rota=true;
      R4.rota=true;
      B.rota=true;
      Deslizadera1.rota=R4.rota; 
      Deslizadera1.PInicial.rota=Deslizadera1.rota;
      B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    }
    Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, ((ClaseDireccion)OD3).PInicial.Pos, ((ClaseDireccion)OD3).theta);
    Deslizadera1.theta=((ClaseDireccion)OD3).theta;
    R3.ListaPuntosAdicionales.calcular();
    R4.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
  }
  void leer(String[] lineas_txt, int i) {
    if (OD3 instanceof ClaseRecta) {
      ((ClaseRecta)OD3).leer(lineas_txt, i);
      ((ClasePuntoFijo)((ClaseRecta)OD3).PInicial).leer(lineas_txt, i);
    }
    if (OD2 instanceof ClaseApoyo) {
      ((ClaseApoyo)OD2).leer(lineas_txt, i);
    }

    cruzada(lineas_txt, i);
    R3.leer(lineas_txt, i);
    R4.leer(lineas_txt, i);
  }
}

class ClaseDiadaDeslizaderaInversion extends ClaseDiada {
  ClasePunto  B, D;
  ClaseApoyo O4;
  ClaseBarra  R3;
  ClaseExcentricidad EX2, EX1;
  ClaseDeslizadera Deslizadera1;
  ClaseDiadaDeslizaderaInversion(ClasePunto punto) {
    ListaEstructuras.incluirLista(this);
    OD2=punto;
    B=ListaPuntos.crear();
    D=ListaPuntos.crear();
    O4=ListaApoyos.crear();
    EX2=ListaExcentricidades.crear();
    R3=ListaBarras.crear();
    EX1=ListaExcentricidades.crear();
    Deslizadera1=ListaDeslizaderas.crear(true,true);
    
    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(Deslizadera1);
    
    B.rota=true;
    D.eslabonEnlace=R3;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    R3.enlaceEstructura=this;
    EX1.enlaceEstructura=this;
    EX2.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;
    
    EX1.eslabonasociado=R3;
    EX2.eslabonasociado=Deslizadera1;

    EX1.PInicial=OD2;
    EX1.PFinal=B;
    R3.PInicial=B;
    R3.PFinal=D;
    EX2.PInicial=O4;
    EX2.PFinal=Deslizadera1.PInicial;

    O4.eslabonEnlace=Deslizadera1;
    
  }
  void calcular() {

    if (!OD2.rota) {
      mecanismoRoto=DiadaDeslizderaInversion3Pos(OD2.Pos, O4.Pos, EX1.L, EX1.theta, R3.L, EX2.L, EX2.theta);
      R3.rota=mecanismoRoto;
      EX1.rota=mecanismoRoto;
      Deslizadera1.rota=mecanismoRoto;
      D.rota=mecanismoRoto;
      //Deslizadera1.rota=mecanismoRoto;
      

      if (!mecanismoRoto) {
        Deslizadera1.distancia=PosBRelA;
        R3.theta=Theta3;
        B.Pos=calculaPunto(EX1.L, OD2.Pos, R3.theta + EX1.theta);
        Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, B.Pos, R3.theta);
        D.Pos=calculaPunto(R3.L, B.Pos, R3.theta);
      } else if (!mecanismoRoto) {
        R3.theta=ThetaExcentricidad-EX2.theta;
      }
      Deslizadera1.theta=R3.theta;
    } else {
       
      Deslizadera1.enlaceEstructura.mecanismoRoto=true;
      EX1.rota=true;
      R3.rota=true;
      EX2.enlaceEstructura.mecanismoRoto=true;
      D.rota=true;
    }
    R3.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
  }
}
class ClaseDiadaDeslizaderaInversionMovil extends ClaseDiada {
  ClasePunto  B, D;
  ClaseBarra  R3;
  ClaseExcentricidad EX2, EX1;
  ClaseDeslizadera Deslizadera1;
  ClaseDiadaDeslizaderaInversionMovil(ClasePunto punto, ClasePunto punto2) {
    if (!(punto instanceof ClaseApoyo) && !(punto2 instanceof ClaseApoyo)) {
      Deslizadera1=ListaDeslizaderas.crear(true, false);
      B=ListaPuntosExtremos.crear();
    } else if (punto instanceof ClaseApoyo) {
      Deslizadera1=ListaDeslizaderas.crear(true, false);
      B=ListaPuntos.crear();
      B.eslabonEnlace=R3;
    } else {
      Deslizadera1=ListaDeslizaderas.crear(true, true);
      B=ListaPuntosExtremos.crear();
    }
    ListaEstructuras.incluirLista(this);
    OD2=punto;
    OD3=punto2;
    //B=ListaPuntos.crear();
    D=ListaPuntos.crear();
    EX2=ListaExcentricidades.crear();
    R3=ListaBarras.crear();
    EX1=ListaExcentricidades.crear();
    if (B instanceof ClasePuntoExtremo) {
      ((ClasePuntoExtremo)B).exasociada=EX1;
    }

    if (punto instanceof ClaseApoyo || (!(punto instanceof ClaseApoyo) && !(punto2 instanceof ClaseApoyo))) {
      ((ClasePuntoExtremo)Deslizadera1.PInicial).exasociada=EX2;
    } 
    if (OD2 instanceof ClaseApoyo) {
      ListaEslabones.incluir(Deslizadera1);
      ListaEslabones.incluir(R3);
    } else {

      ListaEslabones.incluir(R3);
      ListaEslabones.incluir(Deslizadera1);
    }
    if (OD2 instanceof ClaseApoyo) {
      B.rota=false;
      B.eslabonEnlace=R3;
      D.eslabonEnlace=R3;
    } else {
      B.rota=false;
      B.eslabonEnlace=EX1;
      B.enlaceEstructura=this;
      D.eslabonEnlace=R3;
    }


    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    Deslizadera1.PInicial.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    EX1.enlaceEstructura=this;
    EX2.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;

    EX1.eslabonasociado=R3;
    EX2.eslabonasociado=Deslizadera1;

    EX1.PInicial=OD2;
    EX1.PFinal=B;
    R3.PInicial=B;
    R3.PFinal=D;
    EX2.PInicial=(ClasePunto)OD3;
    EX2.PFinal=Deslizadera1.PInicial;
    EX1.crearnombre();
    EX2.crearnombre();
  }
  void calcular() {

    if (!OD2.rota || !OD3.rota) {
      mecanismoRoto=DiadaDeslizderaInversion3Pos(OD2.Pos, ((ClasePunto)OD3).Pos, EX1.L, EX1.theta, R3.L, EX2.L, EX2.theta);

      if (OD2 instanceof ClaseApoyo) {
        R3.rota=false;
        B.rota=false;
        EX1.rota=false;
        EX2.rota=mecanismoRoto;
        Deslizadera1.rota=mecanismoRoto;
        Deslizadera1.PInicial.rota= Deslizadera1.rota;
        D.rota=false;
        //Deslizadera1.rota=mecanismoRoto;
      } else if (OD3 instanceof ClaseApoyo) {
        R3.rota=mecanismoRoto;
        B.rota=mecanismoRoto;
        EX1.rota=mecanismoRoto;
        EX2.rota=false;
        Deslizadera1.rota=false;
        Deslizadera1.PInicial.rota= Deslizadera1.rota;
        D.rota=mecanismoRoto;
      } else if (!(OD2 instanceof ClaseApoyo && OD3 instanceof ClaseApoyo)) {//condiciones para la móvil
        R3.rota=mecanismoRoto;
        B.rota=mecanismoRoto;
        EX1.rota=mecanismoRoto;
        EX2.rota=mecanismoRoto;
        Deslizadera1.rota=mecanismoRoto;
        Deslizadera1.PInicial.rota= Deslizadera1.rota;
        D.rota=mecanismoRoto;
      }


      if (!mecanismoRoto) {
        Deslizadera1.distancia=PosBRelA;
        R3.theta=Theta3;
        B.Pos=calculaPunto(EX1.L, OD2.Pos, R3.theta + EX1.theta);
        Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, B.Pos, R3.theta);
        D.Pos=calculaPunto(R3.L, B.Pos, R3.theta);
      } else if (!mecanismoRoto) {
        R3.theta=ThetaExcentricidad-EX2.theta;
      }
      Deslizadera1.theta=R3.theta;
    } else {

      Deslizadera1.enlaceEstructura.mecanismoRoto=true;
      EX1.rota=true;
      R3.rota=true;
      EX2.rota=true;
      D.rota=true;
    }
    R3.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
  }
  void leer(String[] lineas_txt, int i) {
    if (OD2 instanceof ClaseApoyo) {
      ((ClaseApoyo)OD2).leer(lineas_txt, i);
    }
    if (OD3 instanceof ClaseApoyo) {
      ((ClaseApoyo)OD3).leer(lineas_txt, i);
    }
    cruzada(lineas_txt, i);
    R3.leer(lineas_txt, i);
    EX1.leer(lineas_txt, i);
    EX2.leer(lineas_txt, i);
  }
}
class ClaseDiadaDeslizaderaBase extends ClaseDiada {
  ClasePunto B, C, D; 
  ClaseBarra  R3, R4;
  ClaseDeslizadera Deslizadera1;//PFijo del Biela Manivela
  ClaseExcentricidad EX;

  ClaseDiadaDeslizaderaBase(ClasePunto punto) {
    ListaEstructuras.incluirLista(this);
    B=ListaPuntos.crear();
    C=ListaPuntos.crear();
    D=ListaPuntos.crear();
    R3=ListaBarras.crear();
    R4=ListaBarras.crear();
    Deslizadera1=ListaDeslizaderas.crear(true,true);
    EX=ListaExcentricidades.crear();

    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(R4);
    ListaEslabones.incluir(Deslizadera1);

    OD2=punto;
    B.eslabonEnlace=Deslizadera1;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    R3.enlaceEstructura=this;
    R4.enlaceEstructura=this;
    EX.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;

    B.eslabonEnlace=R4;
    C.eslabonEnlace=R4;
    D.eslabonEnlace=R4;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    R3.PInicial=OD2;
    R3.PFinal=B;
    EX.PInicial=B;
    EX.PFinal=C;
    R4.PFinal=C;
    R4.PInicial=D;

    //R4.theta=Deslizadera1.theta;
    C.rota=true;
    EX.eslabonasociado=R4;
  }
  void calcular() {
    mecanismoRoto=DiadaBielaManivelaPos( OD2.Pos, Deslizadera1.PInicial.Pos, R3.L, EX.L, EX.theta, Deslizadera1.theta, cruzado);
    R4.theta=Deslizadera1.theta;

    if (!mecanismoRoto) {
      if (Deslizadera1.distancia >= R4.L || Deslizadera1.distancia <= 0) {
        mecanismoRoto=true;
      }
      R3.theta=Theta3;
      Deslizadera1.distancia=PosBRel;
    }
    EX.rota=mecanismoRoto;
    R3.rota=mecanismoRoto;
    B.rota=mecanismoRoto;
    D.rota=mecanismoRoto;
    //Deslizadera1.rota=mecanismoRoto;
    R4.rota=mecanismoRoto;
    C.Pos=calculaPunto(Deslizadera1.distancia, Deslizadera1.PInicial.Pos, Deslizadera1.theta);
    B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    D.Pos=calculaPunto(R4.L, C.Pos, 180+R4.theta);
    R3.ListaPuntosAdicionales.calcular();
    R4.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
  }
 
}
class ClaseDiadaDeslizaderaBaseMovil extends ClaseDiada { 
  ClaseBarra  R3, R5;
  float angulo;
  ClaseExcentricidad R4;
  ClasePunto  B, D;
  ClasePuntoExtremo C;


  ClaseDiadaDeslizaderaBaseMovil(ClasePunto punto, ClaseDireccion direccion1) {
    ListaEstructuras.incluirLista(this);
    OD2=punto;
    B=ListaPuntos.crear();
    C=ListaPuntosExtremos.crear();
    D=ListaPuntos.crear();
    R3=ListaBarras.crear();
    R4=ListaExcentricidades.crear();
    R5=ListaBarras.crear();

    OD3=direccion1;

    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(R5);

    B.eslabonEnlace=R3;
    D.eslabonEnlace=R5;
    C.eslabonEnlace=R4;
    C.exasociada=R4;
    C.enlaceEstructura=this;
    R4.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    R5.enlaceEstructura=this;

    R4.eslabonasociado=R5;

    R3.PFinal=B;
    R3.PInicial=OD2;
    R4.PInicial=B;
    R5.PInicial=C;
    R4.PFinal=R5.PInicial;
    R5.PFinal=D;
    R4.crearnombre();
  }
  void calcular() {

    //println(OD2.Pos);
    //println(((Direccion)OD3).PInicial.Pos);
    if (OD3 instanceof ClaseDeslizaderaFija) {
      ((ClaseDeslizadera)OD3).theta=angulo;
    } else {
      //((Deslizadera)OD3).theta=angulo;
      ((ClaseDeslizadera)OD3).theta=((ClaseDeslizadera)OD3).PInicial.eslabonEnlace.theta + angulo;

      ((ClaseDeslizadera)OD3).rota=((ClaseDeslizadera)OD3).PInicial.rota;
    }
    if (!OD2.rota && !OD3.rota) {
      mecanismoRoto=DiadaBielaManivelaPos(OD2.Pos, ((ClaseDireccion)OD3).PInicial.Pos, R3.L, R4.L, R4.theta + ((ClaseDireccion)OD3).theta, ((ClaseDireccion)OD3).theta, cruzado) ;
      R5.rota=mecanismoRoto;
      R5.PInicial.rota=R5.rota;
      R5.PFinal.rota=R5.rota;
      if (!mecanismoRoto) {
        //        if (OD3 instanceof Barra) {
        mecanismoRoto=mecanismoRoto || (PosBRel > 0) || (abs(PosBRel) > R5.L);
        R5.rota=R5.rota || (PosBRel > 0) || (abs(PosBRel) > R5.L);
        //          R5.PInicial.rota=R5.rota;
        ((ClaseDeslizadera)OD3).distancia=constrain(PosBRel, - R5.L, 0);
        //        } else {

        //          R5.distancia=PosBRel;
        //        }
      }
      if (!mecanismoRoto) {
        R3.theta=Theta3;
      }
      R4.rota=mecanismoRoto;
      R3.rota=mecanismoRoto && !(OD2 instanceof ClaseApoyo);
      B.rota=R3.rota;
      B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    } else if (!OD2.rota) {
      mecanismoRoto=true;
      R4.rota=true;
      R3.rota=!(OD2 instanceof ClaseApoyo);
      B.rota=R3.rota;
      R5.rota=true;
      R5.PInicial.rota=true;
      R5.PFinal.rota=true;
      B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    } else if (!OD3.rota) {
      mecanismoRoto=true;
      R3.rota=true;
      R4.rota=true;
      B.rota=R4.rota;
      R5.rota=R4.rota;
      R5.PInicial.rota=R5.rota;
      R5.PFinal.rota=R5.rota;
      B.Pos=calculaPunto(R4.L, R5.PInicial.Pos, 180+R4.theta+R5.theta);
    } else {
      mecanismoRoto=true;
      R3.rota=true;
      R4.rota=true;
      B.rota=true;
      R5.rota=true; 
      R5.PInicial.rota=R5.rota;
      R5.PFinal.rota=R5.rota;
      B.Pos=calculaPunto(R3.L, OD2.Pos, R3.theta);
    }
    R5.PInicial.Pos=calculaPunto(((ClaseDeslizadera)OD3).distancia, ((ClaseDireccion)OD3).PInicial.Pos, ((ClaseDireccion)OD3).theta);
    if (OD3 instanceof ClaseDeslizaderaFija) {
      R5.PFinal.Pos=calculaPunto(R5.L, R5.PInicial.Pos, angulo);//+ R5.theta);
    } else {
      R5.PFinal.Pos=calculaPunto(R5.L, R5.PInicial.Pos, angulo+ ((ClaseDeslizadera)OD3).PInicial.eslabonEnlace.theta);
    }
    R5.theta=((ClaseDireccion)OD3).theta;
    R3.ListaPuntosAdicionales.calcular();
    R4.ListaPuntosAdicionales.calcular();
    R5.ListaPuntosAdicionales.calcular();
    R5.PFinal.rota=R5.rota;
    R5.PInicial.rota=R5.rota;
  }
  void leer(String[] lineas_txt, int i) {
    if (OD3 instanceof ClaseDeslizadera) {
      for (int j=i; j < lineas_txt.length; j++) {

        if (lineas_txt[j].startsWith("[Deslizadera")) {
          String ang=splitTokens(lineas_txt[j+16], "=")[1];
          angulo=float(ang); 
          break;
        }
      }
    }
    if (OD3 instanceof ClaseDeslizaderaFija) {
      ((ClaseDeslizaderaFija)OD3).leerfija(lineas_txt,i);
    }
    if (OD2 instanceof ClaseApoyo) {
      ((ClaseApoyo)OD2).leer(lineas_txt, i);
    }
    cruzada(lineas_txt, i);
    R3.leer(lineas_txt, i);
    R4.leer(lineas_txt, i);
    R5.leer(lineas_txt, i);
  }
}
ClaseDiada4BarrasMovil crearDiada4BarrasFija(ClasePunto punto) {
  ClaseApoyo apoyo=ListaApoyos.crear();
  ClaseDiada4BarrasMovil Diada=new ClaseDiada4BarrasMovil(apoyo, punto);
  apoyo.eslabonEnlace=Diada.R2;
  apoyo.crearnombre();
  return(Diada);
}
ClaseDiada4BarrasMovil crearDiada4BarrasMovil(ClasePunto punto, ClasePunto punto2) {
  ClaseDiada4BarrasMovil DiadaMovil=new ClaseDiada4BarrasMovil(punto, punto2);
  return(DiadaMovil);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
ClaseDiadaBielaManivelaMovil crearDiadaBielaManivelaFija(ClasePunto punto) {
  ClaseRecta recta=ListaRectas.crear();
  ClaseDiadaBielaManivelaMovil Diada=new ClaseDiadaBielaManivelaMovil(punto, recta);
  recta.enlaceEstructura=Diada;
  return(Diada);
}
ClaseDiadaBielaManivelaMovil crearDiadaBielaManivelaMovil(ClasePunto punto, ClaseBarra barra) {  
  ClaseDiadaBielaManivelaMovil Diada=new ClaseDiadaBielaManivelaMovil(punto, barra);
  return (Diada);
}
ClaseDiadaBielaManivelaMovil crearDiadaBielaManivelaFija2(ClaseBarra barra) { //Demasiada Recursion//Arreglada ahora el problema es que aunque rompa la barra continua la deslizadera.
  ClaseApoyo apoyo=ListaApoyos.crear();
  ClaseDiadaBielaManivelaMovil Diada=new ClaseDiadaBielaManivelaMovil(apoyo, barra);
  apoyo.eslabonEnlace=Diada.R3;
  apoyo.crearnombre();
  return(Diada);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ClaseDiadaDeslizaderaBaseMovil crearDiadaDeslizaderaBaseFija(ClasePunto punto) {//Está hecho con una clase aparte.
  ClaseDeslizaderaFija deslizadera=ListaDeslizaderasFijas.crear(true); 
  ClaseDiadaDeslizaderaBaseMovil Diada=new ClaseDiadaDeslizaderaBaseMovil(punto, deslizadera);
  ListaEslabones.incluir(deslizadera);
  deslizadera.enlaceEstructura=Diada;
  deslizadera.PInicial.enlaceEstructura=Diada;
  return(Diada);
}
ClaseDiadaDeslizaderaBaseMovil crearDiadaDeslizaderaBaseFija2(ClasePunto punto) {
  ClaseApoyo apoyo=ListaApoyos.crear();
  ClaseDeslizadera deslizadera=ListaDeslizaderas.crear(false, true);
  deslizadera.PInicial=punto;
  ClaseDiadaDeslizaderaBaseMovil Diada=new ClaseDiadaDeslizaderaBaseMovil(apoyo, deslizadera);
  ListaEslabones.incluir(deslizadera);
  apoyo.eslabonEnlace=Diada.R3;
  apoyo.crearnombre();
  apoyo.enlaceEstructura=Diada;
  deslizadera.enlaceEstructura=Diada;
  return(Diada);
}
ClaseDiadaDeslizaderaBaseMovil crearDiadaDeslizaderaBaseMovil(ClasePunto punto, ClasePunto punto2) {
  ClaseDeslizadera deslizadera=ListaDeslizaderas.crear(false, true);
  ClaseDiadaDeslizaderaBaseMovil Diada=new ClaseDiadaDeslizaderaBaseMovil(punto, deslizadera);
  ListaEslabones.incluir(deslizadera);
  deslizadera.PInicial=punto2;
  deslizadera.enlaceEstructura=Diada;
  return(Diada);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ClaseDiadaDeslizaderaInversionMovil crearDiadaDeslizaderaInversionMovil(ClasePunto punto, ClasePunto punto2) {
  ClaseDiadaDeslizaderaInversionMovil Diadamovil=new ClaseDiadaDeslizaderaInversionMovil(punto, punto2);
  return(Diadamovil);
}
ClaseDiadaDeslizaderaInversionMovil crearDiadaDeslizaderaInversionFija(ClasePunto punto) {
  ClaseApoyo apoyo=ListaApoyos.crear();
  ClaseDiadaDeslizaderaInversionMovil Diadamovil=new ClaseDiadaDeslizaderaInversionMovil(punto, apoyo);
  apoyo.eslabonEnlace=Diadamovil.Deslizadera1;
  apoyo.crearnombre();
  return(Diadamovil);
}
ClaseDiadaDeslizaderaInversionMovil crearDiadaDeslizaderaInversionFija2(ClasePunto punto) {
  ClaseApoyo apoyo=ListaApoyos.crear();
  ClaseDiadaDeslizaderaInversionMovil Diada=new ClaseDiadaDeslizaderaInversionMovil(apoyo, punto);
  Diada.OD2.eslabonEnlace=Diada.EX2;
  apoyo.eslabonEnlace=Diada.R3;
  apoyo.crearnombre();
  return(Diada);
}
float anchoEslabon=2;
float anchoEslabonCoger=3.50;
float ancholineaDeslizadera=0.5;
float ancholineatriangulo=0.5;
float SizePunto=7;
float DX=50, DY=30;//Dimensiones Deslizadera
float [] sepline={20, 30};//Separación línea discontinua

color colorEncimaEslabon=color(18, 183, 7);
color colorEslabonRoto=color(152, 152, 152);
color colorLetraRota=color(152, 152, 152);
color colorEslabon=color(0, 0, 0);
color colorDeslizadera=color(156,204,253);
color colorTriangulo=color(156,204,253);
color colorPunto=color(255, 255, 255);
color colorRecta=color(0, 0, 0);
float grosorRecta=0.7;
int ancho=1;

String Mensaje;
float letra=16;
float letrachica=10;
float xsubindice=14;
float ysubindice=4;
float xsubindiceex=14;
float syExcentricidad=-20;
color colorLetra=color(0, 0, 0);
float sx=-7, syPunto= -10, syApoyo= 30, sxApoyo=-9;
float ds=0.075;//buscar proporcionalidad a la barra.
float correccion=-5;
float dEx=15;
float sxDeslizadera=8;
float TOL=1E-10;

//float Modulo(PVector vector) {
//  float modulo=sqrt(vector.x*vector.x+vector.y*vector.y);
//  return(modulo);
//}
float nuevoatan(float y, float x) {
  float a=degrees(atan2(y, x));
  if (a < 0) {
    a=360+a;
  }
  return(radians(a));
}

float AnguloDireccion(float dX, float dY) {
  float angulo=degrees(atan2(dY, dX));
  if (angulo < 0.0) {
    angulo=360+angulo;
  }
  return(angulo);
}

float AnguloVector(PVector vector) {
  return(AnguloDireccion(vector.x, vector.y));
}
float NormalizaAng(float angulo) {
  while (angulo < 0.0) {
    angulo += 360;
  }
  while (angulo > 360) {
    angulo -= 360;
  }
  if (Similar(angulo, 0.0)) {
    angulo=0.0;
  }
  return(angulo);
}
boolean Similar(float a, float b) {
  if (abs(a-b) < TOL) {
    return(true);
  } else {
    return(false);
  }
}
boolean MenorOIgual(float a, float b) {
  if ((b - a >= 0.0) || (Similar(b-a+TOL, 0.0))) {
    return(true);
  } else {
    return(false);
  }
}
PVector vector(PVector A, PVector B) {
  PVector v=new PVector();
  v.x=B.x-A.x;
  v.y=B.y-A.y;
  return(v);
}
void EslabonBasePos(PVector PosO4, PVector PosOA) {
  resAngulo=AnguloVector(vector(PosOA, PosO4));
  resDistancia=dist(PosOA.x, PosOA.y, PosO4.x, PosO4.y);
}
void dashline(float x0, float y0, float x1, float y1, float[ ] spacing) 
{ 

  float distance = dist(x0, y0, x1, y1); 
  float [ ] xSpacing = new float[spacing.length]; 
  float [ ] ySpacing = new float[spacing.length]; 
  float drawn = 0.0;  // amount of distance drawn 

  if (distance > 0) 
  { 
    int i; 
    boolean drawLine = true; // alternate between dashes and gaps 

    /* 
     Figure out x and y distances for each of the spacing values 
     I decided to trade memory for time; I'd rather allocate 
     a few dozen bytes than have to do a calculation every time 
     I draw. 
     */
    for (i = 0; i < spacing.length; i++) 
    { 
      xSpacing[i] = lerp(0, (x1 - x0), spacing[i] / distance); 
      ySpacing[i] = lerp(0, (y1 - y0), spacing[i] / distance);
    } 

    i = 0; 
    while (drawn < distance) 
    { 
      if (drawLine) 
      { 
        line(x0, y0, x0 + xSpacing[i], y0 + ySpacing[i]);
      } 
      x0 += xSpacing[i]; 
      y0 += ySpacing[i]; 
      /* Add distance "drawn" by this line or gap */
      drawn = drawn + mag(xSpacing[i], ySpacing[i]); 
      i = (i + 1) % spacing.length;  // cycle through array 
      drawLine = !drawLine;  // switch between dash and gap
    }
  }
} 
void lineadisc(float angulo, PVector o4)
{ 
  PVector o4p;
  o4p=a_pixel(o4);
  float a, b, c, Kb, Ke, R, X0, Y0, X1, Y1;
  angulo=-angulo;
  //Primera parte calcula los puntos de la linea
  R=sqrt(width*width+height*height)/2.0;
  a=cos(radians(angulo))*cos(radians(angulo))+sin(radians(angulo))*sin(radians(angulo));
  b=2.0*((o4p.x-width/2.0)*cos(radians(angulo))+((o4p.y-height/2.0)*sin(radians(angulo))));
  c=((o4p.x*o4p.x+o4p.y*o4p.y)+((width/2.0)*(width/2.0)+(height/2.0)*(height/2.0))-2.0
    *(o4p.x*(width/2.0)+o4p.y*(height/2.0)))-R*R;

  Kb=(-b+sqrt(b*b-4.0*a*c))/(2.0*a);
  Ke=(-b-sqrt(b*b-4.0*a*c))/(2.0*a);

  X0=o4p.x+Kb*cos(radians(angulo));
  Y0=o4p.y+Kb*sin(radians(angulo));
  X1=o4p.x+Ke*cos(radians(angulo));
  Y1=o4p.y+Ke*sin(radians(angulo));
  stroke(colorRecta);
  strokeWeight(grosorRecta);
  dashline(X0, Y0, X1, Y1, sepline);
}
//void pintarrectangulos(PVector PInicial, float ancho, float alto, float theta) {
//  strokeWeight(ancholineaDeslizadera);
//  fill(colorDeslizadera);
//  rectMode(CENTER);
//  pushMatrix();
//  translate(PInicial.x, PInicial.y);
//  rotate(radians(-theta));
//  rect(0, 0, ancho, alto);
//  popMatrix();
//  stroke(0);
//}
PVector restaPVectores(PVector v1, PVector v2) {
  PVector resultado=new PVector();
  resultado.x=v1.x-v2.x;
  resultado.y=v1.y-v2.y;
  return(resultado);
}
//PVector sumaPVectores(PVector v1, PVector v2){
//PVector resultado=new PVector();
//resultado.x=v1.x+v2.x;
//resultado.y=v1.y+v2.y;
//return(resultado);

//}
//PVector giroX( float angulo , PVector punto){

//PVector Resultado=new PVector();
//Resultado.x=punto.x*cos(angulo) - punto.y*sin(angulo);
//Resultado.y=punto.x*sin(angulo) + punto.y*cos(angulo);
//return(Resultado);

//}
//float PFijoSimetrico(PVector O2, PVector PFijo, float thetarecta){
//  float cateto1=abs(PFijo.y+tan(radians(thetarecta))*(O2.x-PFijo.x)-O2.y);
//  float hipotenusa=dist(O2.x, O2.y,PFijo.x,PFijo.y);
//  float resultado=sqrt(abs(hipotenusa*hipotenusa-cateto1*cateto1));
//  return(resultado);
//}
//String[] borra_linea(String[] a,int i){//Borra un elemento del array
// String[] a1,a2,result;
// a1=(String[])subset(a,0,i);//Los parentesis (Rectangulos_clase[]) hacen que sea posible usar las funciones de arrays con la clase figuras.
// a2=(String[])subset(a,i+1,a.length-(i+1));
// result=(String[])concat(a1,a2);
// return(result);
//}
//void igualarPuntos(ClasePunto Punto1,ClasePunto punto2){

//    Punto1.Pos=punto2.Pos;
//    Punto1.eslabonEnlace=punto2.eslabonEnlace;
//    Punto1.Indice=punto2.Indice;
//    Punto1.nombre=punto2.nombre;


//}
boolean buscarlinea(String [] documento, int iniciobusqueda, String nombrebuscado) {
  boolean encontrado=false;
  String tmpLinea;
  for (int i=iniciobusqueda; i < documento.length; i++) {
    tmpLinea = documento[i];
    if (!EsStringVacia(tmpLinea)) {
      if (CompararStrings(splitTokens(tmpLinea, "=")[0],nombrebuscado)) {
        encontrado=true;
        numlinea=i;
        break;
      }
    }
  }

  return(encontrado);
}

boolean buscarlineaAsociado(String [] documento, int iniciobusqueda, String nombrebuscado) {
  boolean encontrado=false;
  for (int i=iniciobusqueda; i < documento.length; i++) {
    if (CompararStrings(splitTokens(documento[i], "=")[1],nombrebuscado)) {
      encontrado=true;
      numlinea=i;
      break;
    }
  }

  return(encontrado);
}

boolean buscarlineaDiada(String [] documento, int iniciobusqueda, String nombrebuscado) {
  boolean encontrado=false;
  for (int i=iniciobusqueda; i < documento.length; i++) {
    String [] Cadena=splitTokens(documento[i]);
    Cadena=shorten(Cadena);
    String nuevonombre=new String();
    nuevonombre= join(Cadena, " ");
    if (CompararStrings(nuevonombre,nombrebuscado)) {
      println(nuevonombre);
      encontrado=true;
      numlineaDiada=i;
      numlinea=i;
      break;
    }
  }

  return(encontrado);
}
class ListadeApoyos {
  ArrayList <ClaseApoyo> ListaApoyos=new ArrayList <ClaseApoyo>();
  ListadeApoyos() {
  }

  ClaseApoyo crear() {
    ClaseApoyo apoyo=new ClaseApoyo();
    ListaApoyos.add(apoyo);
    apoyo.Indice=ListaApoyos.size()+1;
    return(apoyo);
  }
  ClaseApoyo buscar(String  nombre1) {
    ClaseApoyo apoyoencontrado=new ClaseApoyo();
    for (int i=0; i< ListaApoyos.size(); i++) {
      ClaseApoyo apoyoelegido=ListaApoyos.get(i);
      if (CompararStrings(apoyoelegido.nombre,nombre1)) {
        apoyoencontrado=apoyoelegido;
      }
    }
    return(apoyoencontrado);
  }
  int NumeroApoyos() {
    int total=ListaApoyos.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaApoyos.size(); i++) {
      ListaApoyos.get(i).pintar();
      ListaApoyos.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaApoyos.size(); i++) {
      ListaApoyos.get(i).escribirnombre();
    }
  }
}
class ListadeApoyosDeslizantes { 
  ArrayList <ClaseApoyoDeslizante> ListaApoyosDeslizantes=new ArrayList <ClaseApoyoDeslizante>();
  //ListadeApoyosDeslizantes() {
  //}
  ClaseApoyoDeslizante crear() {
    ClaseApoyoDeslizante apoyodeslizante=new ClaseApoyoDeslizante();
    ListaApoyosDeslizantes.add(apoyodeslizante);
    apoyodeslizante.Indice= ListaApoyosDeslizantes.size()+1;
    apoyodeslizante.crearnombre();
    return(apoyodeslizante);
  }
  ClaseApoyoDeslizante buscar(String  nombre1) {
    ClaseApoyoDeslizante puntoElegido=new ClaseApoyoDeslizante();
    for (int i=0; i< ListaApoyosDeslizantes.size(); i++) {
      if (CompararStrings(ListaApoyosDeslizantes.get(i).nombre,nombre1)) {
        puntoElegido=ListaApoyosDeslizantes.get(i);
      }
    }
    return(puntoElegido);
  }
  int NumeroPuntos() {
    int total=ListaApoyosDeslizantes.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaApoyosDeslizantes.size(); i++) {
      ListaApoyosDeslizantes.get(i).pintar();
      ListaApoyosDeslizantes.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaApoyosDeslizantes.size(); i++) {
      ListaApoyosDeslizantes.get(i).escribirnombre();
    }
  }
}
class ListadeBarras {
  ArrayList <ClaseBarra> ListaBarras=new ArrayList <ClaseBarra>();
  ListadeBarras() {
  }

  ClaseBarra crear() {
    ClaseBarra barra=new ClaseBarra();
    ListaBarras.add(barra);
    //barra.Indice=ListaBarras.size()+1;
    return(barra);
  }
   ClaseBarra buscar(String  nombre1) {
    ClaseBarra barraElegida=new ClaseBarra();
    for (int i=0; i< ListaBarras.size(); i++) {
      if (CompararStrings(ListaBarras.get(i).nombre,nombre1)) {
        barraElegida=ListaBarras.get(i);
      }
    }
    return(barraElegida);
  }
  int NumeroBarras() {
    return(ListaBarras.size());
  }
  void pintar() {
    for (int i=0; i< ListaBarras.size(); i++) {  
      ListaBarras.get(i).pintarTriangulo();
      ListaBarras.get(i).pintar();
      ListaBarras.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaBarras.size(); i++) {
      ListaBarras.get(i).escribirnombre();
    }
  }
}
class ListadeDeslizaderas {
  ArrayList <ClaseDeslizadera> ListaDeslizaderas=new ArrayList <ClaseDeslizadera>();
  //ListadeDeslizaderas() {
  //}


  ClaseDeslizadera crear(boolean hayPunto, boolean apoyada) {
    ClaseDeslizadera deslizadera=new ClaseDeslizadera();
    if (hayPunto) {
      if (apoyada) {
        deslizadera.PInicial=ListaPuntos.crear();
         deslizadera.PInicial.eslabonEnlace=deslizadera;
      } else {
        deslizadera.PInicial=ListaPuntosExtremos.crear();
          deslizadera.PInicial.eslabonEnlace=deslizadera;
      }
    }
    ListaDeslizaderas.add(deslizadera);
    //deslizadera.Indice=ListaDeslizaderas.size()+1;
    return(deslizadera);
  }
  ClaseDeslizadera buscar(String  nombre1) {
    ClaseDeslizadera deslizaderaencontrada=new ClaseDeslizadera();
    for (int i=0; i< ListaDeslizaderas.size(); i++) {
      ClaseDeslizadera deslizaderaelegida=ListaDeslizaderas.get(i);
      if (CompararStrings(deslizaderaelegida.nombre,nombre1)) {
        deslizaderaencontrada=deslizaderaelegida;
      }
    }
    return(deslizaderaencontrada);
  }
  int NumeroPuntos() {
    int total=ListaDeslizaderas.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaDeslizaderas.size(); i++) {
      ListaDeslizaderas.get(i).pintar();
      ListaDeslizaderas.get(i).pintarlinea();
      ListaDeslizaderas.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaDeslizaderas.size(); i++) {
      ListaDeslizaderas.get(i).escribirnombre();
    }
  }
}
class ListadeDeslizaderasFijas {
  ArrayList <ClaseDeslizaderaFija> ListaDeslizaderasFijas=new ArrayList <ClaseDeslizaderaFija>();
  //ListadeDeslizaderasFijas() {
  //}


  ClaseDeslizaderaFija crear(boolean apoyodeslizante) {
    ClaseDeslizaderaFija deslizadera=new ClaseDeslizaderaFija();
    if(apoyodeslizante){
    deslizadera.PInicial=ListaApoyosDeslizantes.crear();
    deslizadera.PInicial.eslabonEnlace=deslizadera;
    }else{
     deslizadera.PInicial=ListaPuntos.crear();
    deslizadera.PInicial.eslabonEnlace=deslizadera;
    
    }
    ListaDeslizaderasFijas.add(deslizadera);
    //deslizadera.Indice=ListaDeslizaderas.size()+1;
    return(deslizadera);
  }
  ClaseDeslizaderaFija buscar(String  nombre1) {
    ClaseDeslizaderaFija deslizaderaencontrada=new ClaseDeslizaderaFija();
    for (int i=0; i< ListaDeslizaderasFijas.size(); i++) {
      ClaseDeslizaderaFija deslizaderaelegida=ListaDeslizaderasFijas.get(i);
      if (CompararStrings(deslizaderaelegida.nombre,nombre1)) {
        deslizaderaencontrada=deslizaderaelegida;
      }
    }
    return(deslizaderaencontrada);
  }
  int NumeroDeslizaderasFijas() {
    int total=ListaDeslizaderasFijas.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaDeslizaderasFijas.size(); i++) {
      ListaDeslizaderasFijas.get(i).pintar();
      ListaDeslizaderasFijas.get(i).pintarlinea();
      ListaDeslizaderasFijas.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaDeslizaderasFijas.size(); i++) {
      ListaDeslizaderasFijas.get(i).escribirnombre();
    }
  }
}
class ListadeEslabones {
  ArrayList <ClaseEslabon> ListaEslabones=new ArrayList <ClaseEslabon>();
  //ListadeEslabones() {
  //}

  void incluir(ClaseEslabon eslabon) {
    ListaEslabones.add(eslabon);
    eslabon.Indice=ListaEslabones.size()+1;
    eslabon.crearnombre();
  }
  ClaseEslabon buscar(String  nombre1) {
    ClaseEslabon eslabonElegido=new ClaseEslabon();
    for (int i=0; i< ListaEslabones.size(); i++) {
      if (CompararStrings(ListaEslabones.get(i).nombre, nombre1)) {
        eslabonElegido=ListaEslabones.get(i);
      }
    }
    return(eslabonElegido);
  }
  int NumeroEslabones() {
    int total=ListaEslabones.size();
    return(total);
  }
  void ratondentro() {
    for (int i=0; i< ListaEslabones.size(); i++) {
      if (eslabonMotor.es_este_eslabon(ListaEslabones.get(i))) {
        EncimaEslabon=raton_en_eslabon(ListaEslabones.get(i));
      }
    }
  }
}
class ListadeEstructuras {
  ArrayList <ClaseEstructura> privListaEstructuras = new ArrayList <ClaseEstructura>();

  //ListadeEstructuras() {
  //}

  void calcular() {
    for (int i=0; i< privListaEstructuras.size(); i++) {
      privListaEstructuras.get(i).calcular();
    }
  }

  void incluirLista(ClaseEstructura estr) {
    privListaEstructuras.add(estr);
  }
}
class ListadeExcentricidades {
  ArrayList <ClaseExcentricidad> ListaExcentricidades=new ArrayList <ClaseExcentricidad>();
  //ListadeExcentricidades() {
  //}


  ClaseExcentricidad crear() {
    ClaseExcentricidad excentricidad=new ClaseExcentricidad();
    ListaExcentricidades.add(excentricidad);
    excentricidad.Indice=ListaExcentricidades.size();
    return(excentricidad);
  }
  ClaseExcentricidad buscar(String  nombre1) {
    ClaseExcentricidad excentricidadencontrada=new ClaseExcentricidad();
    for (int i=0; i< ListaExcentricidades.size(); i++) {
      if (CompararStrings(ListaExcentricidades.get(i).nombre,nombre1)) {
        excentricidadencontrada=ListaExcentricidades.get(i);
      }
    }
    return(excentricidadencontrada);
  }
  
  int NumeroPuntos() {
    int total=ListaExcentricidades.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaExcentricidades.size(); i++) {  
      ListaExcentricidades.get(i).pintar();
      ListaExcentricidades.get(i).escribirnombre();
    }
  }
  void pintarNombre(){
  for (int i=0; i< ListaExcentricidades.size(); i++) {
      ListaExcentricidades.get(i).escribirnombre();
    }
  }
   void ratondentro() {
    for (int i=0; i< ListaExcentricidades.size(); i++) {
      if (eslabonMotor.es_este_eslabon(ListaExcentricidades.get(i))) {
        EncimaEslabon=raton_en_eslabon(ListaExcentricidades.get(i));
      }
    }
  }
}
class ListadePuntos {
  ArrayList <ClasePunto> ListaPuntos=new ArrayList <ClasePunto>();
  //ListadePuntos() {
  //}

  ClasePuntoAdicional crearAdicional(ClaseEslabon eslabon, float distancia, float angulo) {
    ClasePuntoAdicional punto=new ClasePuntoAdicional(eslabon, distancia, angulo);
    ListaPuntos.add(punto);
    eslabon.ListaPuntosAdicionales.ListaPuntosAdicionales.add(punto);
    punto.Indice= ListaPuntos.size()+1;
    punto.crearnombre();
    //punto.calcular();
    return(punto);
  }
  ClasePunto crear() {
    ClasePunto punto=new ClasePunto();
    ListaPuntos.add(punto);
    punto.Indice= ListaPuntos.size()+1;
    punto.crearnombre();
    return(punto);
  }
  ClasePunto buscar(String  nombre1) {
    ClasePunto puntoElegido;
    puntoElegido = null;
    for (int i=0; i< ListaPuntos.size(); i++) {
      if (CompararStrings(ListaPuntos.get(i).nombre,nombre1)) {
        puntoElegido=ListaPuntos.get(i);
      }
    }
    return(puntoElegido);
  }
  int NumeroPuntos() {
    int total=ListaPuntos.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaPuntos.size(); i++) {
      ListaPuntos.get(i).pintar();
      ListaPuntos.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaPuntos.size(); i++) {
      ListaPuntos.get(i).escribirnombre();
    }
  }
}
class ListadePuntosAdicionales {
  ArrayList <ClasePuntoAdicional> ListaPuntosAdicionales=new ArrayList <ClasePuntoAdicional>();
  //ListadePuntosAdicionales() {
  //}
  void calcular() {
    for (int i=0; i< ListaPuntosAdicionales.size(); i++) {
      ListaPuntosAdicionales.get(i).calcular();
    }
  }
}
class ListadePuntosFijos {
  ArrayList <ClasePuntoFijo> ListaPuntosFijos=new ArrayList <ClasePuntoFijo>();
  //ListadePuntosFijos() {
  //}


  ClasePuntoFijo crear() {
    ClasePuntoFijo puntofijo=new ClasePuntoFijo();
    ListaPuntosFijos.add(puntofijo);
    puntofijo.Indice= ListaPuntosFijos.size();
    puntofijo.crearnombre();
    return(puntofijo);
  }
  ClasePuntoFijo buscar(String  nombre1) {
    ClasePuntoFijo puntoencontrado=new ClasePuntoFijo();
    for (int i=0; i< ListaPuntosFijos.size(); i++) {
      ClasePuntoFijo puntoelegido=ListaPuntosFijos.get(i);
      if (CompararStrings(puntoelegido.nombre,nombre1)) {
        puntoencontrado=puntoelegido;
      }
    }
    return(puntoencontrado);
  }
  int NumeroPuntos() {
    int total=ListaPuntosFijos.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaPuntosFijos.size(); i++) {
      ListaPuntosFijos.get(i).pintar();
      ListaPuntosFijos.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaPuntosFijos.size(); i++) {
      ListaPuntosFijos.get(i).escribirnombre();
    }
  }
}
class ListadePuntosExtremos { 
  ArrayList <ClasePuntoExtremo> ListaPuntosExtremos=new ArrayList <ClasePuntoExtremo>();
  //ListadePuntosExtremos() {
  //}
  ClasePuntoExtremo crear() {
    ClasePuntoExtremo punto=new ClasePuntoExtremo();
    ListaPuntosExtremos.add(punto);
    punto.Indice= ListaPuntosExtremos.size()+1;
    return(punto);
  }
  ClasePuntoExtremo buscar(String  nombre1) {
    ClasePuntoExtremo puntoElegido=new ClasePuntoExtremo();
    for (int i=0; i< ListaPuntosExtremos.size(); i++) {
      if (CompararStrings(ListaPuntosExtremos.get(i).nombre,nombre1)) {
        puntoElegido=ListaPuntosExtremos.get(i);
      }
    }
    return(puntoElegido);
  }
  int NumeroPuntosExtremos() {
    int total=ListaPuntosExtremos.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaPuntosExtremos.size(); i++) {
      ListaPuntosExtremos.get(i).pintar();
      ListaPuntosExtremos.get(i).escribirnombre();
    }
  }
  void pintarNombre() {
    for (int i=0; i< ListaPuntosExtremos.size(); i++) {
      ListaPuntosExtremos.get(i).escribirnombre();
    }
  }
}
class ListadeRectas {
  ArrayList <ClaseRecta> ListaRectas=new ArrayList <ClaseRecta>();
  //ListadeRectas() {
  //}


  ClaseRecta crear() {
    ClaseRecta recta=new ClaseRecta();
    recta.PInicial=ListaPuntosFijos.crear();
    ListaRectas.add(recta);
    recta.Indice= ListaRectas.size();
    recta.crearnombre();
    return(recta);
  }

  int NumeroRectas() {
    int total=ListaRectas.size();
    return(total);
  }
  void pintar() {
    for (int i=0; i< ListaRectas.size(); i++) {
      ListaRectas.get(i).pintar();
      //ListaPuntosFijos.get(i).escribirnombre();
    }
  }
}
class ClaseMec4Barras extends ClaseMecanismo {
  ClaseApoyo  O2, O4;
  ClasePunto A, B;
  ClaseBarra  R2, R3, R4;
  ClaseMec4Barras() {//Constructor
    ListaEstructuras.incluirLista(this);

    A=ListaPuntos.crear();
    B=ListaPuntos.crear();
    R2=ListaBarras.crear();
    R3=ListaBarras.crear();
    R4=ListaBarras.crear();
    O2=ListaApoyos.crear();
    O4=ListaApoyos.crear();
    ListaEslabones.incluir(R2);
    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(R4);
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    R4.enlaceEstructura=this;
    cruzado=false;
    R2.motorizable=true;
    R3.motorizable=false;
    R4.motorizable=true;

    O2.eslabonEnlace=R2;
    O4.eslabonEnlace=R4;

    B.eslabonEnlace=R4;
    A.eslabonEnlace=R2;

    R2.PInicial=O2;
    R2.PFinal=A;
    R3.PInicial=A;
    R3.PFinal=B;
    R4.PInicial=O4;
    R4.PFinal=B;
    
    R2.rota=false;
    R4.rota=false;

    O2.crearnombre();
    O4.crearnombre();
    
    eslabonMotor.eslabonMotorEnlace=R2;
  }
  void calcular() {
    if (eslabonMotor.es_este_eslabon(R2)) {
      A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
      mecanismoRoto=Diada4BarrasPos( A.Pos, O4.Pos, R3.L, R4.L, !cruzado);
      R3.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        R3.theta=Theta3;
        R4.theta=Theta4;
      }
      B.Pos=calculaPunto(R4.L, O4.Pos, R4.theta);
    } else if (eslabonMotor.es_este_eslabon(R4)) {
      B.Pos=calculaPunto(R4.L, O4.Pos, R4.theta);
      mecanismoRoto=Diada4BarrasPos( B.Pos, O2.Pos, R3.L, R2.L, !cruzado);
      R3.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        R3.theta=Theta3+180;
        R2.theta=Theta4;
      }
      A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
    }
    R3.ListaPuntosAdicionales.calcular();
    R2.ListaPuntosAdicionales.calcular();
    R4.ListaPuntosAdicionales.calcular();
  }
  void leer(String[] lista_txt, int i) {
    eslabonMotor.leer(lista_txt, i);
    cruzada(lista_txt, i);
    O2.leer(lista_txt, i);
    O4.leer(lista_txt, i);
    R2.leer(lista_txt, i);
    R3.leer(lista_txt, i);
    R4.leer(lista_txt, i);
  }
}

class ClaseBielaManivela extends ClaseMecanismo {
  ClaseApoyo O2;
  ClasePunto  A, B;
  ClaseBarra  R2, R3;   
  ClaseRecta recta;
  ClaseExcentricidad EX;
  ClaseDeslizadera Deslizadera1;
  ClaseBielaManivela() {
    ListaEstructuras.incluirLista(this);
    A=ListaPuntos.crear();
    B=ListaPuntos.crear();
    EX=ListaExcentricidades.crear();
    O2=ListaApoyos.crear();
    R2=ListaBarras.crear();
    R3=ListaBarras.crear();
    Deslizadera1=ListaDeslizaderas.crear(true,false);
    recta=ListaRectas.crear();

    R2.motorizable=true;
    Deslizadera1.motorizable=true;
    R3.motorizable=false;

    ListaEslabones.incluir(R2);
    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(Deslizadera1);

    A.eslabonEnlace=R2;
    B.eslabonEnlace=EX;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    ((ClasePuntoExtremo)Deslizadera1.PInicial).exasociada=EX;
    recta.PInicial.eslabonEnlace=Deslizadera1;//Despendiendo de si queremos que el punto fijo
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    EX.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;
    Deslizadera1.direccionEnlace=recta;

    R2.PInicial=O2;
    R2.PFinal=A;
    R3.PInicial=A;
    R3.PFinal=B;
    EX.PInicial=B;
    EX.PFinal=Deslizadera1.PInicial;
    eslabonMotor.eslabonMotorEnlace=R2;
    R2.rota=false;
    EX.rota=false;
    
    

    O2.eslabonEnlace=R2;
    EX.eslabonasociado=Deslizadera1;
    EX.crearnombre();
    O2.crearnombre();
    ((ClasePuntoExtremo)Deslizadera1.PInicial).crearnombre();
  }
  void calcular() {
    eslabonMotor.moverse();
    Deslizadera1.limitesCarrera=calculaCarrera(O2.Pos, recta.PInicial.Pos, EX.theta, EX.L, recta.theta, R2.L, R3.L, restaPVectores(recta.PInicial.Pos, O2.Pos));
    if (eslabonMotor.es_este_eslabon(R2)) {
      A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
      mecanismoRoto=DiadaBielaManivelaPos( A.Pos, recta.PInicial.Pos, R3.L, EX.L, EX.theta+recta.theta, recta.theta, cruzado);
      R3.rota=mecanismoRoto;
      //Deslizadera1.rota=mecanismoRoto;

      if (!mecanismoRoto) {
        R3.theta=Theta3;
        Deslizadera1.distancia=PosBRel;
      }

      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, recta.PInicial.Pos, Deslizadera1.theta);
      B.Pos=calculaPunto(EX.L, Deslizadera1.PInicial.Pos, 180+EX.theta+Deslizadera1.theta); 
      Deslizadera1.theta=recta.theta;
      Deslizadera1.ListaPuntosAdicionales.calcular();
    } else if (eslabonMotor.es_este_eslabon(Deslizadera1)) {
      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, recta.PInicial.Pos, Deslizadera1.theta);
      B.Pos=calculaPunto(EX.L, Deslizadera1.PInicial.Pos, 180+EX.theta+Deslizadera1.theta); 
      mecanismoRoto=Diada4BarrasPos( B.Pos, O2.Pos, R3.L, R2.L, cruzado);
      R3.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        R3.theta=Theta3+180;
        R2.theta=Theta4;
      }
      A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
    }
    R3.ListaPuntosAdicionales.calcular();
    R2.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
  }
   void leer(String[] lista_txt, int i) {
      cruzada(lista_txt, i);
      eslabonMotor.leer(lista_txt, i);
      O2.leer(lista_txt,i);
      EX.leer(lista_txt,i);
      R2.leer(lista_txt,i);
      R3.leer(lista_txt,i);
      recta.leer(lista_txt,i);
      ((ClasePuntoFijo)recta.PInicial).leer(lista_txt,i);
  }
}
class ClaseDeslizaderaBase extends ClaseMecanismo {
  ClaseApoyo O2;
  ClasePunto A, B, D; 
  ClasePuntoExtremo C;
  ClaseBarra  R2, R3, R4;
  ClaseDeslizaderaFija Deslizadera;//PFijo del Biela Manivela
  ClaseExcentricidad EX;

  ClaseDeslizaderaBase() {
    ListaEstructuras.incluirLista(this);
    A=ListaPuntos.crear();
    B=ListaPuntos.crear();
    C=ListaPuntosExtremos.crear();
    D=ListaPuntos.crear();
    O2=ListaApoyos.crear();
    R2=ListaBarras.crear();
    R3=ListaBarras.crear();
    R4=ListaBarras.crear();
    Deslizadera=ListaDeslizaderasFijas.crear(true);
    EX=ListaExcentricidades.crear();

    
    ListaEslabones.incluir(R2);
    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(R4);
    ListaEslabones.incluir(Deslizadera);
    
    
    C.exasociada=EX;
    A.eslabonEnlace=R2;
    B.eslabonEnlace=Deslizadera;
    Deslizadera.PInicial.eslabonEnlace=Deslizadera;
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    R4.enlaceEstructura=this;
    EX.enlaceEstructura=this;
    Deslizadera.enlaceEstructura=this;
    
    R2.motorizable=true;

    A.eslabonEnlace=R2;
    B.eslabonEnlace=R4;
    C.eslabonEnlace=R4;
    D.eslabonEnlace=R4;
    Deslizadera.PInicial.eslabonEnlace=Deslizadera;
    R2.PInicial=O2;
    R2.PFinal=A;
    R3.PInicial=A;
    R3.PFinal=B;
    EX.PInicial=B;
    EX.PFinal=C;
    R4.PFinal=C;
    R4.PInicial=D;
 
    R4.theta=Deslizadera.theta;
    eslabonMotor.eslabonMotorEnlace=R2;
    R2.rota=false;
    C.rota=false;

    O2.eslabonEnlace=R2;
    EX.eslabonasociado=R4;
    O2.crearnombre();
    EX.crearnombre();
  }
  void calcular() {
    eslabonMotor.moverse();
    A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
    R2.ListaPuntosAdicionales.calcular();
    mecanismoRoto=DiadaBielaManivelaPos( A.Pos, Deslizadera.PInicial.Pos, R3.L, EX.L, EX.theta, Deslizadera.theta, cruzado);
    R4.theta=Deslizadera.theta;

    if (!mecanismoRoto) {
      if (Deslizadera.distancia >= R4.L || Deslizadera.distancia <= 0) {
        mecanismoRoto=true;
      }
      R3.theta=Theta3;
      Deslizadera.distancia=PosBRel;
    }
    EX.rota=mecanismoRoto;
    R3.rota=mecanismoRoto;
    B.rota=mecanismoRoto;
    D.rota=mecanismoRoto;
    //Deslizadera.rota=mecanismoRoto;
    R4.rota=mecanismoRoto;
    C.Pos=calculaPunto(Deslizadera.distancia, Deslizadera.PInicial.Pos, Deslizadera.theta);
    B.Pos=calculaPunto(R3.L, A.Pos, R3.theta);
    D.Pos=calculaPunto(R4.L, C.Pos, 180+R4.theta);
    R3.ListaPuntosAdicionales.calcular();
    R4.ListaPuntosAdicionales.calcular();
    Deslizadera.ListaPuntosAdicionales.calcular();
  }
  void leer(String[] lista_txt, int i) {
    cruzada(lista_txt, i);
    eslabonMotor.leer(lista_txt, i);
    O2.leer(lista_txt, i);
    R2.leer(lista_txt, i);
    R3.leer(lista_txt, i);
    EX.leer(lista_txt, i);
    R4.leer(lista_txt, i);
  }
}
class ClaseDeslizaderaInversion extends ClaseMecanismo {
  ClaseApoyo  O2, O4;
  ClasePunto A, D;
  ClasePuntoExtremo B;
  ClaseDeslizadera Deslizadera1;
  ClaseBarra  R2, R3;
  ClaseExcentricidad EX1, EX2;
  ClaseDeslizaderaInversion() {
    ListaEstructuras.incluirLista(this);
    A=ListaPuntos.crear();
    B=ListaPuntosExtremos.crear();
    D=ListaPuntos.crear();
    O2=ListaApoyos.crear();
    O4=ListaApoyos.crear();
    R2=ListaBarras.crear();
    R3=ListaBarras.crear();
    EX1=ListaExcentricidades.crear();
    EX2=ListaExcentricidades.crear();
    Deslizadera1=ListaDeslizaderas.crear(true, true);

    A.eslabonEnlace=R2;
    D.eslabonEnlace=R3;
    B.eslabonEnlace=EX1;
    B.exasociada=EX1;
    B.enlaceEstructura=this;
    //Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    EX1.enlaceEstructura=this;
    EX2.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;
    R2.motorizable=true;
    R3.motorizable=false;

    ListaEslabones.incluir(R2);
    ListaEslabones.incluir(R3);
    ListaEslabones.incluir(Deslizadera1);

    R2.PInicial=O2;
    R2.PFinal=A;
    EX1.PInicial=A;
    EX1.PFinal=B;
    R3.PInicial=B;
    R3.PFinal=D;
    EX2.PInicial=O4;
    EX2.PFinal=Deslizadera1.PInicial;
    R2.rota=false;
    B.rota=false;
    eslabonMotor.eslabonMotorEnlace=R2;
    EX1.eslabonasociado=R3;
    EX2.eslabonasociado=Deslizadera1;

    O2.eslabonEnlace=R2;
    O4.eslabonEnlace=Deslizadera1;
    O2.crearnombre();
    O4.crearnombre();
    EX1.crearnombre();
    EX2.crearnombre();
    B.crearnombre();
  }
  void calcular() {
    eslabonMotor.moverse();
    A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
    R2.ListaPuntosAdicionales.calcular();
    mecanismoRoto=DiadaDeslizderaInversion3Pos(A.Pos, O4.Pos, EX1.L, EX1.theta, R3.L, EX2.L, EX2.theta);
    B.rota=mecanismoRoto;
    D.rota=mecanismoRoto;
    R3.rota=mecanismoRoto;
    EX1.rota=mecanismoRoto;

    EX1.eslabonasociado.theta=R3.theta;
    EX2.eslabonasociado.theta=R3.theta;

    //Deslizadera1.rota=mecanismoRoto;
    if (!mecanismoRoto) {
      Deslizadera1.distancia=PosBRelA;
      R3.theta=Theta3;
    } else if (!mecanismoRoto) {
      R3.theta=ThetaExcentricidad-EX2.theta;
    }
    B.Pos=calculaPunto(EX1.L, A.Pos, R3.theta + EX1.theta);
    Deslizadera1.PInicial.Pos=calculaPunto(EX2.L, O4.Pos, R3.theta + EX2.theta);
    D.Pos=calculaPunto(R3.L, B.Pos, R3.theta);
    Deslizadera1.theta=R3.theta;
    R3.ListaPuntosAdicionales.calcular();
    Deslizadera1.ListaPuntosAdicionales.calcular();
  }
  void leer(String[] lista_txt, int i) {
    cruzada(lista_txt, i);
    eslabonMotor.leer(lista_txt, i);
    O2.leer(lista_txt, i);
    O4.leer(lista_txt, i);
    R2.leer(lista_txt, i);
    R3.leer(lista_txt, i);
    EX1.leer(lista_txt, i);
    EX2.leer(lista_txt, i);
  }
}
class ClaseDeslizaderaInversion2 extends ClaseMecanismo {
  ClasePunto A, B, C;
  ClaseApoyo  O2, O4;
  ClaseBarra  R2, R3;
  ClaseExcentricidad EX1, EX2;
  ClaseDeslizadera Deslizadera1;

  ClaseDeslizaderaInversion2() {

    ListaEstructuras.incluirLista(this);
    A=ListaPuntos.crear();
    Deslizadera1=ListaDeslizaderas.crear(true, false);
    B=ListaPuntos.crear();
    C=ListaPuntos.crear();

    O4=ListaApoyos.crear();
    O2=ListaApoyos.crear();
    R2=ListaBarras.crear();
    R3=ListaBarras.crear();

    EX1=ListaExcentricidades.crear();
    EX2=ListaExcentricidades.crear();

    R2.motorizable=true;
    R3.motorizable=true;


    ListaEslabones.incluir(R2);
    ListaEslabones.incluir(Deslizadera1);
    ListaEslabones.incluir(R3);

    ((ClasePuntoExtremo)Deslizadera1.PInicial).exasociada=EX1;    
    A.eslabonEnlace=R2;
    C.eslabonEnlace=R3;
    B.eslabonEnlace=R3;
    B.enlaceEstructura=this;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    Deslizadera1.PInicial.enlaceEstructura=this;
    R2.enlaceEstructura=this;
    R3.enlaceEstructura=this;
    R3.excentricidadasociada=EX2;
    EX1.enlaceEstructura=this;
    EX2.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;

    R2.PInicial=O2;
    R2.PFinal=A;
    EX1.PInicial=A;
    EX1.PFinal=Deslizadera1.PInicial;
    R3.PFinal=C;
    R3.PInicial=B;
    EX2.PInicial=O4;
    EX2.PFinal=B;
    R2.rota=false;
    B.rota=false;
    eslabonMotor.eslabonMotorEnlace=R2;
    EX1.eslabonasociado=Deslizadera1;
    EX2.eslabonasociado=R3;

    O2.eslabonEnlace=R2;
    O4.eslabonEnlace=R3;
    O2.crearnombre();
    O4.crearnombre();
    EX1.crearnombre();
    EX2.crearnombre();
  }
  void calcular() {
    eslabonMotor.moverse();
    if (eslabonMotor.es_este_eslabon(R2)) {
      A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
      R2.ListaPuntosAdicionales.calcular();
      mecanismoRoto=DiadaDeslizderaInversion3Pos(O4.Pos, A.Pos, EX2.L, EX2.theta, R3.L, EX1.L, EX1.theta);
      C.rota=false;
      B.rota=false;
      R3.rota=false;
      EX1.rota=mecanismoRoto;
      EX2.rota=false;
      EX1.eslabonasociado.theta=R3.theta;
      EX2.eslabonasociado.theta=R3.theta;
      Deslizadera1.rota=mecanismoRoto;
      Deslizadera1.PInicial.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        Deslizadera1.distancia=PosBRelA;
        R3.theta=Theta3;
      } else if (!mecanismoRoto) {
        R3.theta=ThetaExcentricidad-EX2.theta;
      }
      B.Pos=calculaPunto(EX2.L, O4.Pos, R3.theta + EX2.theta);
      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, B.Pos, R3.theta);
      //Deslizadera1.PInicial.Pos=calculaPunto(EX1.L, A.Pos, R3.theta + EX1.theta);
      C.Pos=calculaPunto(R3.L, B.Pos, R3.theta);
      Deslizadera1.theta=R3.theta;
      R3.ListaPuntosAdicionales.calcular();
      Deslizadera1.ListaPuntosAdicionales.calcular();
    } else if (eslabonMotor.es_este_eslabon(R3)) {
      B.Pos=calculaPunto(EX2.L, O4.Pos, EX2.theta + R3.theta);
      C.Pos=calculaPunto(R3.L, B.Pos, R3.theta);
      EX2.eslabonasociado=R3;
      mecanismoRoto=DiadaBielaManivelaPos(O2.Pos, R3.PInicial.Pos, R2.L, EX1.L, EX1.theta + R3.theta, R3.theta, cruzado);
      if (!mecanismoRoto && !(PosBRel >= R3.L || PosBRel <= 0)) {
        R2.theta=Theta3;
        Deslizadera1.distancia=PosBRel;
      }
      if (PosBRel >= R3.L || PosBRel <= 0) {
        mecanismoRoto=true;
      }
      Deslizadera1.rota=mecanismoRoto;
      Deslizadera1.PInicial.rota=mecanismoRoto;
      EX1.rota=mecanismoRoto;

      Deslizadera1.theta=R3.theta;
      A.Pos=calculaPunto(R2.L, O2.Pos, R2.theta);
      Deslizadera1.PInicial.Pos=calculaPunto(EX1.L, A.Pos, R3.theta+EX1.theta);
      R3.ListaPuntosAdicionales.calcular();
    }
  }
  void leer(String[] lista_txt, int i) {
    cruzada(lista_txt, i);
    eslabonMotor.leer(lista_txt, i);
    O2.leer(lista_txt, i);
    O4.leer(lista_txt, i);
    R2.leer(lista_txt, i);
    R3.leer(lista_txt, i);
    EX1.leer(lista_txt, i);
    EX2.leer(lista_txt, i);
  }
}
class ClaseDobleDeslizadera extends ClaseMecanismo {
  ClasePunto A, B;
  ClaseBarra R;  
  ClaseDeslizadera Deslizadera1, Deslizadera2;
  ClaseRecta Recta1, Recta2;
  ClaseExcentricidad EX1, EX2;


  ClaseDobleDeslizadera() {
    ListaEstructuras.incluirLista(this);
    A=ListaPuntos.crear();
    B=ListaPuntos.crear();
    R=ListaBarras.crear();
    Deslizadera1=ListaDeslizaderas.crear(true,false);
    Deslizadera2=ListaDeslizaderas.crear(true,false);
    EX1=ListaExcentricidades.crear();
    EX2=ListaExcentricidades.crear();
    //PFijo1=ListaPuntosFijos.crear();
    //PFijo2=ListaPuntosFijos.crear();
    Recta1=ListaRectas.crear();
    Recta2=ListaRectas.crear();

     ((ClasePuntoExtremo)Deslizadera1.PInicial).exasociada=EX1;
      ((ClasePuntoExtremo)Deslizadera2.PInicial).exasociada=EX2;
    R.PInicial=A;
    R.PFinal=B;
    EX1.PInicial=A;
    EX1.PFinal=Deslizadera1.PInicial;
    EX2.PInicial=B;
    EX2.PFinal=Deslizadera2.PInicial;

    ListaEslabones.incluir(Deslizadera1);
    ListaEslabones.incluir(R);
    ListaEslabones.incluir(Deslizadera2);

    R.enlaceEstructura=this;
    EX1.enlaceEstructura=this;
    EX2.enlaceEstructura=this;
    Deslizadera1.enlaceEstructura=this;
    Deslizadera2.enlaceEstructura=this;
    A.enlaceEstructura=this;
    B.enlaceEstructura=this;
    A.eslabonEnlace=EX1;
    B.eslabonEnlace=EX2;
    Deslizadera1.PInicial.eslabonEnlace=Deslizadera1;
    Deslizadera2.PInicial.eslabonEnlace=Deslizadera2;

    eslabonMotor.eslabonMotorEnlace=Deslizadera1;

    Deslizadera1.motorizable=true;
    Deslizadera2.motorizable=true;

    Deslizadera1.direccionEnlace=Recta1;
    Deslizadera2.direccionEnlace=Recta2;

    EX1.eslabonasociado=Deslizadera1;
    EX2.eslabonasociado=Deslizadera2;
    EX1.crearnombre();
    EX2.crearnombre();
  }

  void calcular() {
    calcularCarrera();
    //eslabonMotor.moverse();
    Deslizadera1.theta=Recta1.theta;
    Deslizadera2.theta=Recta2.theta;
    if (eslabonMotor.es_este_eslabon(Deslizadera1)) {

      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, Recta1.PInicial.Pos, Recta1.theta);
      A.Pos=calculaPunto(EX1.L, Deslizadera1.PInicial.Pos, 180+ EX1.theta + Recta1.theta);
      Deslizadera1.ListaPuntosAdicionales.calcular();
      mecanismoRoto=DiadaBielaManivelaPos( A.Pos, Recta2.PInicial.Pos, R.L, EX2.L, EX2.theta + Recta2.theta, Recta2.theta, cruzado);
      R.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        R.theta=Theta3;
        Deslizadera2.distancia=PosBRel;
      }

      Deslizadera2.PInicial.Pos=calculaPunto(Deslizadera2.distancia, Recta2.PInicial.Pos, Recta2.theta); 
      B.Pos=calculaPunto(EX2.L, Deslizadera2.PInicial.Pos, 180+Recta2.theta+EX2.theta);
      R.ListaPuntosAdicionales.calcular();
      Deslizadera2.ListaPuntosAdicionales.calcular();
    } else if (eslabonMotor.es_este_eslabon(Deslizadera2)) {
      //calcularCarrera();
      Deslizadera2.PInicial.Pos=calculaPunto(Deslizadera2.distancia, Recta2.PInicial.Pos, Recta2.theta);
      B.Pos=calculaPunto(EX2.L, Deslizadera2.PInicial.Pos, 180+ EX2.theta + Recta2.theta);
      Deslizadera2.ListaPuntosAdicionales.calcular();
      mecanismoRoto=DiadaBielaManivelaPos( B.Pos, Recta1.PInicial.Pos, R.L, EX1.L, EX1.theta + Recta1.theta, Recta1.theta, cruzado);
      R.rota=mecanismoRoto;
      if (!mecanismoRoto) {
        R.theta=Theta3 +180;
        Deslizadera1.distancia=PosBRel;
      }
      Deslizadera1.PInicial.Pos=calculaPunto(Deslizadera1.distancia, Recta1.PInicial.Pos, Recta1.theta); 
      A.Pos=calculaPunto(EX1.L, Deslizadera1.PInicial.Pos, 180+Recta1.theta+EX1.theta);
      R.ListaPuntosAdicionales.calcular();
      Deslizadera1.ListaPuntosAdicionales.calcular();
    }
  }
  void calcularCarrera() {
    if (eslabonMotor.es_este_eslabon(Deslizadera1)) {
      PVector R1=restaPVectores(Recta2.PInicial.Pos, Recta1.PInicial.Pos);
      float R61, R62;
       float R61B, R62B;
      R61=(1/cos(radians(Recta2.theta-Recta1.theta)))*(((-EX1.L*sin(radians(EX1.theta))+R.L*sin(radians(Recta2.theta-Recta1.theta + 90)) + EX2.L*sin(radians(Recta2.theta-Recta1.theta + EX2.theta))+ R1.x*sin(radians(Recta1.theta))-R1.y*cos(radians(Recta1.theta)))));
      R62=(1/cos(radians(Recta2.theta-Recta1.theta)))*(-EX1.L*sin(radians(EX1.theta))+R.L*sin(radians(Recta2.theta-Recta1.theta - 90)) + EX2.L*sin(radians(Recta2.theta-Recta1.theta + EX2.theta))+ R1.x*sin(radians(Recta1.theta))-R1.y*cos(radians(Recta1.theta)));
      Deslizadera1.limitesCarrera.x=(EX1.L*cos(radians(EX1.theta))-R.L*cos(radians(Recta2.theta-Recta1.theta + 90))+ R1.x*cos(radians(Recta1.theta))+ R1.y*sin(radians(Recta1.theta))+R61*cos(radians(Recta2.theta-Recta1.theta))-EX2.L*cos(radians(Recta2.theta-Recta1.theta + EX2.theta)));
      Deslizadera1.limitesCarrera.y=(EX1.L*cos(radians(EX1.theta))-R.L*cos(radians(Recta2.theta-Recta1.theta -90))+ R1.x*cos(radians(Recta1.theta))+ R1.y*sin(radians(Recta1.theta))+R62*cos(radians(Recta2.theta-Recta1.theta))-EX2.L*cos(radians(Recta2.theta-Recta1.theta + EX2.theta)));
      //println(Deslizadera1.limitesCarrera.x + " Deslizaderax");
      //println(Deslizadera1.limitesCarrera.y + " Deslizaderay");
    } else if (eslabonMotor.es_este_eslabon(Deslizadera2)) {
      PVector R1=restaPVectores(Recta1.PInicial.Pos, Recta2.PInicial.Pos);
     // R61B=(1/cos(radians(Recta2.theta-Recta1.theta)))*((-EX1.L*sin(radians(EX1.theta))+R.L*sin(radians(Recta2.theta-Recta1.theta + 90)) + EX2.theta*sin(radians(Recta2.theta-Recta1.theta + EX2.L))+ R1.x*sin(radians(Recta1.theta))-R1.y*cos(radians(Recta1.theta))));
      //R62B=(1/cos(radians(Recta2.theta-Recta1.theta)))*(-EX1.L*sin(radians(EX1.theta))+R.L*sin(radians(Recta2.theta-Recta1.theta - 90)) + EX2.theta*sin(radians(Recta2.theta-Recta1.theta + EX2.L))+ R1.x*sin(radians(Recta1.theta))-R1.y*cos(radians(Recta1.theta)));
      Deslizadera2.limitesCarrera.y=(1/cos(radians(Recta1.theta-Recta2.theta)))*(-EX2.L*sin(radians(EX2.theta))+R.L*sin(radians(Recta1.theta-Recta2.theta + 90)) + EX1.theta*sin(radians(Recta1.theta-Recta2.theta + EX1.L))+ R1.x*sin(radians(Recta2.theta))-R1.y*cos(radians(Recta2.theta)));
  
      Deslizadera2.limitesCarrera.x=EX2.L*cos(radians(EX2.theta))-R.L*cos(radians(Recta1.theta-Recta2.theta - 90))+ R1.x*cos(radians(Recta2.theta))+ R1.y*sin(radians(Recta2.theta))+0*Deslizadera2.limitesCarrera.y*cos(radians(Recta1.theta-Recta2.theta))-EX1.L*cos(radians(Recta1.theta-Recta2.theta + EX1.theta));
   
    }
  ;
   // println(Deslizadera2.limitesCarrera.y + " Deslizadera2y");
    //println(Deslizadera2.limitesCarrera.x + " Deslizadera2x");
  }
  void leer(String[] lista_txt, int i) {
    cruzada(lista_txt, i);
    eslabonMotor.leer(lista_txt, i);
    R.leer(lista_txt, i);
    EX1.leer(lista_txt, i);
    EX2.leer(lista_txt, i);
    Recta1.leer(lista_txt, i);
    Recta2.leer(lista_txt, i);
    ((ClasePuntoFijo)Recta1.PInicial).leer(lista_txt,i);
    ((ClasePuntoFijo) Recta2.PInicial).leer(lista_txt,i);
  }
}
float clickRatonX, clickRatonY;
float clickFocoX, clickFocoY, clickFocoZ;
float clickZoom;
boolean EncimaEslabon;
boolean EslabonCogido=false;

float gZoom=1;

PVector gposFoco = new PVector(0.0, 0.0);

boolean raton_en_eslabon(ClaseEslabon eslabon) {
  boolean esta=false;
  PVector mouser=new PVector();
  PVector ratonmm=raton_a_mm();
  if (eslabon instanceof ClaseBarra) {
    PVector PuntoMedio;
    PuntoMedio=calculaPunto((((ClaseBarra)eslabon).L/2.0), ((ClaseBarra)eslabon).PInicial.Pos, ((ClaseBarra)eslabon).theta);
    pushMatrix();
    translate(PuntoMedio.x, PuntoMedio.y);
    mouser.x=(ratonmm.x-PuntoMedio.x)*cos(radians(-eslabon.theta))-(ratonmm.y-PuntoMedio.y)*sin(radians(-eslabon.theta));
    mouser.y=-(ratonmm.y-PuntoMedio.y)*cos(radians(-eslabon.theta))-(ratonmm.x-PuntoMedio.x)*sin(radians(-eslabon.theta));
    if (mouser.x>-((((ClaseBarra)eslabon).L)/2.0) && mouser.x<((((ClaseBarra)eslabon).L)/2.0) && mouser.y>-((anchoEslabonCoger/2.0)/gZoom) && mouser.y<((anchoEslabonCoger/2.0)/gZoom)) {//para cuando el rectangulo se dibuja con rectMode(Center)
      esta=true;
    } else {
      esta=false;
    }
    popMatrix();
    return(esta);
  } else {
    rectMode(CENTER);
    pushMatrix();
    translate(((ClaseDeslizadera)eslabon).PInicial.Pos.x, ((ClaseDeslizadera)eslabon).PInicial.Pos.y);
    mouser.x=(ratonmm.x-((ClaseDeslizadera)eslabon).PInicial.Pos.x)*cos(radians(-eslabon.theta))-(ratonmm.y-((ClaseDeslizadera)eslabon).PInicial.Pos.y)*sin(radians(-eslabon.theta));
    mouser.y=-(ratonmm.y-((ClaseDeslizadera)eslabon).PInicial.Pos.y)*cos(radians(-eslabon.theta))-(ratonmm.x-((ClaseDeslizadera)eslabon).PInicial.Pos.x)*sin(radians(-eslabon.theta));
    if (mouser.x>-((DX/2.0)/gZoom) && mouser.x<((DX/2.0)/gZoom) && mouser.y>-((DY/2.0)/gZoom) && mouser.y<((DY/2.0)/gZoom)) {//para cuando el rectangulo se dibuja con rectMode(Center)
      esta=true;//variable lógica que sabe que se está dentro del botón.
    } else {
      esta=false;
    }
    popMatrix();
    return(esta);
  }
}
int Contadorclickraton=0, Guardotiempopar, Guardotiempoimpar, Velocidaddobleclick = 300;
int Contadordobleclick=0;
//Funcion Dobleclick;
boolean HayDobleclick() {
  boolean dobleclick=false;
  Contadorclickraton++;
  int interruptor=Contadorclickraton%2; // si contador es multiplo de dos
  int Milisegundos = millis();
  switch (interruptor) { // Guarda el tiempo si se han pulsado un número impar en guardotiempoimpar y si uno par en guardo tiempo par.
  case 0:
    Guardotiempopar = Milisegundos;
    break;
  case 1:
    Guardotiempoimpar = Milisegundos;
    break;
  }
  if (abs(Guardotiempopar - Guardotiempoimpar) < Velocidaddobleclick) { // checks if you clicked within the clickspeed
    dobleclick=true;
    Contadordobleclick++;
  }
  return(dobleclick);
}

void MoverEslabonMotor_dragged( ClaseEslabon eslabon) {//Realiza el giro en función del movimiento del ratón

  if (EslabonCogido) {//variable que sirve para saber si se ha cogido el eslabon (si se está encima y se pulsa el ratón se vuelve true, al soltar ratón false.
    PVector ratonmm=raton_a_mm();
    PVector ratonnuevo=new PVector();

    if (eslabon.enlaceEstructura instanceof ClaseDeslizaderaInversion2 && eslabonMotor.eslabonMotorEnlace==((ClaseDeslizaderaInversion2)eslabon.enlaceEstructura).R3 && eslabon.excentricidadasociada.L!=0) {

      PVector posRO=new PVector();
      PVector posROEslEx=new PVector();

      posRO = PVector.sub(ratonmm, eslabon.excentricidadasociada.PInicial.Pos);

      float r1;
      float discr, a, b, c;

      a = 1.0;
      b = - 2.0 * eslabon.excentricidadasociada.L * cos(radians(eslabon.excentricidadasociada.theta - 180));
      c = eslabon.excentricidadasociada.L * eslabon.excentricidadasociada.L - posRO.magSq();

      discr = b * b - 4 * a * c;

      if (discr >= 0) {
        r1 = (- b + sqrt(discr)) / (2.0 * a);
        //r = (- b - sqrt(discr)) / (2.0 * a);
        //println("r: " + r1);

        // Soluciones iguales pero de distinto signo, se toma la negativa
        //float r1,r2;

        //r2 = (- b - sqrt(discr)) / (2.0 * a);       
        //println("r1: " + r1);
        //println("r2: " + r2);

        posROEslEx.set(r1, 0);
        posROEslEx = posROEslEx.add(PVector.fromAngle(radians(eslabon.excentricidadasociada.theta)).mult(eslabon.excentricidadasociada.L));
        PVector recta=new PVector();
        recta=restaPVectores(posRO, posROEslEx);

        PVector pv = posRO.cross(recta);
        float distx= (pv.z >= 0.0 ? 1 : -1) * pv.mag() / recta.mag();

        float dist = posROEslEx.dist(posRO);
        //eslabon.theta = degrees(2.0* asin(dist / (2.0 * posRO.mag())));
        eslabon.theta=NormalizaAng(degrees(2*atan2(dist/2.0, distx)));
        println(eslabon.theta);
        //println("r1.theta "+ eslabon.theta);


        //PVector pPixel;

        //stroke(#FF0000);
        //fill(#FF0000);
        //strokeWeight(1);       

        //pPixel=a_pixel(posRO.add(eslabon.excentricidadasociada.PInicial.Pos));
        //ellipse(pPixel.x, pPixel.y, 5, 5);

        //pPixel=a_pixel(posROEslEx.add(eslabon.excentricidadasociada.PInicial.Pos));
        //ellipse(pPixel.x, pPixel.y, 3, 3);
      } else {
        // No se ejecuta NUNCA
      }   

      //    if (eslabon.enlaceEstructura instanceof DeslizaderaInversion2 && eslabonMotor.eslabonMotorEnlace==((DeslizaderaInversion2)eslabon.enlaceEstructura).R3 && eslabon.excentricidadasociada.L!=0) {
      //      ratonnuevo.x=(ratonmm.x-eslabon.excentricidadasociada.PInicial.Pos.x);
      //      ratonnuevo.y=(ratonmm.y-eslabon.excentricidadasociada.PInicial.Pos.y);
      //      float a=dist(ratonmm.x, ratonmm.y, eslabon.excentricidadasociada.PInicial.Pos.x, eslabon.excentricidadasociada.PInicial.Pos.y);
      //       float c=dist(ratonmm.x, ratonmm.y, eslabon.excentricidadasociada.PFinal.Pos.x,  eslabon.excentricidadasociada.PFinal.Pos.y);
      //      //float c=restaPVectores(ratonmm,eslabon.excentricidadasociada.PFinal.Pos).mag();
      //      //float a=ratonnuevo.mag();
      //      float A=degrees(acos(((eslabon.excentricidadasociada.L*eslabon.excentricidadasociada.L+c*c-a*a)/(2*c*eslabon.excentricidadasociada.L))));
      //      if(a!=0){
      //      eslabon.theta=degrees(acos((1/a)*(ratonnuevo.x+eslabon.excentricidadasociada.L*cos(radians(A)))));
      //      }else{
      //      eslabon.theta=degrees(acos(0*(ratonnuevo.x+eslabon.excentricidadasociada.L*cos(radians(A)))));
      //      }
      //      //eslabon.theta=degrees(asin((1/a)*(ratonnuevo.y+eslabon.excentricidadasociada.L*cos(radians(A)))));
      //      //float c=restaPVectores(ratonmm,eslabon.excentricidadasociada.PFinal.Pos).mag();
      //      //float a=restaPVectores(ratonmm,eslabon.excentricidadasociada.PInicial.Pos).mag();
      //      //println(a);
      //      //println(c+ " c");
      //      //float ax=restaPVectores(ratonmm,eslabon.excentricidadasociada.PInicial.Pos).x;
      //      //float A=degrees(acos((c*c+eslabon.excentricidadasociada.L*eslabon.excentricidadasociada.L-a*a)/(2*c*eslabon.excentricidadasociada.L)));
      //      //eslabon.theta=degrees(acos((1/a)*ratonnuevo.x+eslabon.excentricidadasociada.L*cos(radians(A))));*/
    } else if (eslabon instanceof ClaseBarra) {
      ratonnuevo.x=(ratonmm.x-eslabon.PInicial.Pos.x);
      ratonnuevo.y=(ratonmm.y-eslabon.PInicial.Pos.y);
      eslabon.theta=degrees(nuevoatan(ratonnuevo.y, ratonnuevo.x));
    } else if (eslabon instanceof ClaseDeslizadera) {
      ratonnuevo.x=(ratonmm.x-((ClaseDeslizadera)eslabon).direccionEnlace.PInicial.Pos.x);
      ratonnuevo.y=(ratonmm.y-((ClaseDeslizadera)eslabon).direccionEnlace.PInicial.Pos.y);
      float MouseAng=degrees(nuevoatan(ratonnuevo.y, ratonnuevo.x));
      ((ClaseDeslizadera)eslabon).distancia=ratonnuevo.mag()*cos(radians(MouseAng-eslabon.theta));
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*APLICACIONES*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mousePressed() {
  clickZoom = gZoom;

  clickRatonX = mouseX;
  clickRatonY = mouseY;

  clickFocoX = gposFoco.x;
  clickFocoY = gposFoco.y;
  clickFocoZ = gposFoco.z;
  for (int i=0; i< ListaEslabones.ListaEslabones.size(); i++) {
    if (ListaEslabones.ListaEslabones.get(i).motorizable) {
      if (raton_en_eslabon(ListaEslabones.ListaEslabones.get(i)) && HayDobleclick()) {

        eslabonMotor.eslabonMotorEnlace=ListaEslabones.ListaEslabones.get(i);
      }
    }
  }
  if (EncimaEslabon) {
    EslabonCogido=true;
  }
}

void mouseDragged() {
  if (mouseButton == LEFT && !EslabonCogido) {
    gposFoco.x = clickFocoX + (clickRatonX - mouseX) / gZoom;     
    gposFoco.y = clickFocoY - (clickRatonY - mouseY) / gZoom;     
    gposFoco.z = clickFocoZ + (clickRatonX - mouseX) / gZoom;
  }

  if (mouseButton == RIGHT) {
    float tmpZoom = clickZoom * pow(1.05, - (mouseY - clickRatonY) / 20.0);

    float w = 0.0;
    float h = 0.0;


    float tmpFocoRatonX = clickFocoX + (clickRatonX - w) / clickZoom;     
    float tmpFocoRatonY = clickFocoY - (clickRatonY - h) / clickZoom;     
    float tmpFocoRatonZ = clickFocoZ - (clickRatonX - w) / clickZoom;     

    gposFoco.x = clickFocoX + (1.0 - clickZoom / tmpZoom) * (tmpFocoRatonX - clickFocoX); 
    gposFoco.y = clickFocoY + (1.0 - clickZoom / tmpZoom) * (tmpFocoRatonY - clickFocoY);
    gposFoco.z = clickFocoZ + (1.0 - clickZoom / tmpZoom) * (tmpFocoRatonZ - clickFocoZ);

    gZoom = tmpZoom;
  }
  MoverEslabonMotor_dragged( eslabonMotor.eslabonMotorEnlace);
}

void mouseReleased() {
  EslabonCogido=false;
}

void mouseClicked() {
}

//mouseButton

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  float tmpZoom = gZoom * pow(1.05, - e / 1.0);

  float w = width*0.5;
  float h = height*0.5;

  float tmpDeltaFocoX = + (mouseX - w) / gZoom;     
  float tmpDeltaFocoY = - (mouseY - h) / gZoom;     
  float tmpDeltaFocoZ = + (mouseX - w) / gZoom;     

  gposFoco.x = gposFoco.x + (1.0 - gZoom / tmpZoom) * tmpDeltaFocoX; 
  gposFoco.y = gposFoco.y + (1.0 - gZoom / tmpZoom) * tmpDeltaFocoY;
  gposFoco.z = gposFoco.z + (1.0 - gZoom / tmpZoom) * tmpDeltaFocoZ;

  gZoom = tmpZoom;
}
void keyTyped() {  
  if (key=='p') {
    if(eslabonMotor.eslabonMotorEnlace instanceof ClaseBarra){
    pasoAng=0;
    }else{
    velocidad=0;
    }
  }
}

void keyPressed() {
  if (keyCode==UP) {
    if(eslabonMotor.eslabonMotorEnlace instanceof ClaseBarra){
    pasoAng++;
    }else{
    velocidad=velocidad + 0.5;
    }
  }
  if (keyCode==DOWN) {
   if(eslabonMotor.eslabonMotorEnlace instanceof ClaseBarra){
    pasoAng--;
    }else{
    velocidad=velocidad-0.5;
    }
  }
}
void unafuncionestupida(){
}

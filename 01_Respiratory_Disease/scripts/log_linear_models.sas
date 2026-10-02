/*------------------------------------------------------------*/
/*  Modello log-lineare su dati categoriali                   */
/*  Variabili: female, smoker, agecat, response, Frequency    */
/*------------------------------------------------------------*/

data temp01;
  input female smoker agecat response Frequency Percent;
  datalines;
0 1 1 0 34 6.18
0 1 1 1 21 3.82
0 1 2 0 16 2.91
0 1 2 1 10 1.82
0 1 3 0 15 2.73
0 1 3 1 9 1.64
0 1 4 0 7 1.27
0 1 4 1 3 0.55
0 2 1 0 26 4.73
0 2 1 1 19 3.45
0 2 2 0 27 4.91
0 2 2 1 17 3.09
0 2 3 0 10 1.82
0 2 3 1 5 0.91
0 2 4 0 1 0.18
0 2 4 1 1 0.18
0 3 1 0 3 0.55
0 3 1 1 2 0.36
0 3 2 0 6 1.09
0 3 2 1 6 1.09
0 3 3 0 6 1.09
0 3 3 1 6 1.09
0 3 4 0 5 0.91
0 3 4 1 4 0.73
1 1 1 0 28 5.09
1 1 1 1 18 3.27
1 1 2 0 22 4.00
1 1 2 1 20 3.64
1 1 3 0 25 4.55
1 1 3 1 17 3.09
1 1 4 0 8 1.45
1 1 4 1 8 1.45
1 2 1 0 26 4.73
1 2 1 1 20 3.64
1 2 2 0 25 4.55
1 2 2 1 12 2.18
1 2 3 0 15 2.73
1 2 3 1 7 1.27
1 2 4 0 2 0.36
1 2 4 1 1 0.18
1 3 1 0 7 1.27
1 3 1 1 6 1.09
1 3 2 0 5 0.91
1 3 2 1 1 0.18
1 3 3 0 1 0.18
1 3 3 1 1 0.18
1 3 4 0 9 1.64
1 3 4 1 7 1.27
;
run;

/*------------------------------------------------*/
/* Logistic regression (senza interazioni)        */
/*------------------------------------------------*/
proc logistic data=temp01 descending;
  class female smoker agecat / param=effect;
  model response = female smoker agecat;
  title "Model A: Logistic regression with three categorical predictors";
run;

/*------------------------------------------------*/
/* Logistic regression (fino a due vie)           */
/*------------------------------------------------*/
/*proc logistic data=temp01 descending;
  class female smoker agecat;
  model response = female smoker agecat
                    female*smoker
                    female*agecat
                    smoker*agecat;
  title "Model E1: Logistic regression with two-way interactions";
run;*/

/*------------------------------------------------*/
/* Modello nullo (solo costante)                  */
/*------------------------------------------------*/
proc genmod data=temp01;
  class female smoker agecat response;
  model Frequency = 
        / dist=poisson link=log type1 type3;
  title "Modello nullo (solo costante)";
run;

/*------------------------------------------------------*/
/* Modello saturo (tutte le interazioni)                */
/*    -> serve come riferimento finale per il confronto */
/*------------------------------------------------------*/
proc genmod data=temp01;
  class female smoker agecat response;
  model Frequency = female|smoker|agecat|response
        / dist=poisson link=log type1 type3;
  title "Modello log-lineare saturo (tutte le interazioni)";
run;

/*--------------------------------------------------------------*/
/* Modello di indipendenza completa                             */
/*    Tutte le variabili considerate, ma senza interazioni      */
/*    -> ipotesi: le variabili sono tutte indipendenti tra loro */
/*--------------------------------------------------------------*/
proc genmod data=temp01;
  class female smoker agecat response;
  model Frequency = female smoker agecat response
        / dist=poisson link=log type1 type3;
  title "Modello di indipendenza completa: nessuna interazione";
run;

/*------------------------------------------------------*/
/* Modello di indipendenza congiunta                    */
/*    Response indipendente da (Female, Smoker, Agecat) */
/*    -> test di indipendenza della variabile risposta  */
/*------------------------------------------------------*/
proc genmod data=temp01;
  class female smoker agecat response;
  model Frequency =
        female smoker agecat response
        female*smoker female*agecat smoker*agecat female*smoker*agecat
        / dist=poisson link=log type1 type3;
  title "Modello: tutte le interazioni tra female,smoker,agecat ; response come main effect";
run;

/*------------------------------------------------------*/
/* Modello con associazioni omogenee                    */
/*    -> response può interagire con le altre variabili,
       ma in modo uniforme (solo interazioni a due vie) */
/*------------------------------------------------------*/
proc genmod data=temp01;
  class female smoker agecat response;
  model Frequency = female smoker agecat response
                    response*female
                    response*smoker
                    response*agecat
        / dist=poisson link=log type1 type3;
  title "Associazioni omogenee: effetti di response uniformi tra sesso, età e fumo";
run;

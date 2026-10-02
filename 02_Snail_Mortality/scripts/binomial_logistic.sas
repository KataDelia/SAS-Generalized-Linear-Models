/*---------------------------------------------------------------*/
/* Analisi dei dati di sopravvivenza dei lumaconi                */
/* Fonte: Venables & Ripley, Modern Applied Statistics (1998)    */
/* Design: completamente randomizzato 4x3x4x2                    */
/* Variabili:                                                    */
/*   Species: specie di lumaca (A, B)                            */
/*   Espos: esposizione (settimane 1-4)                          */
/*   Umid: umidità relativa (%)                                  */
/*   Temp: temperatura (°C)                                      */
/*   Death: numero di morti                                      */
/*   Num: numero totale di lumache esposte                       */
/*---------------------------------------------------------------*/

data snail;
    input species $ espos umid temp death num;
    label species='Specie'
          espos='Settimane di esposizione'
          umid='Umidità relativa (%)'
          temp='Temperatura (°C)'
          death='Numero di morti'
          num='Numero totale di lumache';
    datalines;
A 1 60.0 10 0 20
A 1 60.0 15 0 20
A 1 60.0 20 0 20
A 1 65.8 10 0 20
A 1 65.8 15 0 20
A 1 65.8 20 0 20
A 1 70.5 10 0 20
A 1 70.5 15 0 20
A 1 70.5 20 0 20
A 1 75.8 10 0 20
A 1 75.8 15 0 20
A 1 75.8 20 0 20
A 2 60.0 10 0 20
A 2 60.0 15 1 20
A 2 60.0 20 1 20
A 2 65.8 10 0 20
A 2 65.8 15 1 20
A 2 65.8 20 0 20
A 2 70.5 10 0 20
A 2 70.5 15 0 20
A 2 70.5 20 0 20
A 2 75.8 10 0 20
A 2 75.8 15 0 20
A 2 75.8 20 0 20
A 3 60.0 10 1 20
A 3 60.0 15 4 20
A 3 60.0 20 5 20
A 3 65.8 10 0 20
A 3 65.8 15 2 20
A 3 65.8 20 4 20
A 3 70.5 10 0 20
A 3 70.5 15 2 20
A 3 70.5 20 3 20
A 3 75.8 10 0 20
A 3 75.8 15 1 20
A 3 75.8 20 2 20
A 4 60.0 10 7 20
A 4 60.0 15 7 20
A 4 60.0 20 7 20
A 4 65.8 10 4 20
A 4 65.8 15 4 20
A 4 65.8 20 7 20
A 4 70.5 10 3 20
A 4 70.5 15 3 20
A 4 70.5 20 5 20
A 4 75.8 10 2 20
A 4 75.8 15 3 20
A 4 75.8 20 3 20
B 1 60.0 10 0 20
B 1 60.0 15 0 20
B 1 60.0 20 0 20
B 1 65.8 10 0 20
B 1 65.8 15 0 20
B 1 65.8 20 0 20
B 1 70.5 10 0 20
B 1 70.5 15 0 20
B 1 70.5 20 0 20
B 1 75.8 10 0 20
B 1 75.8 15 0 20
B 1 75.8 20 0 20
B 2 60.0 10 0 20
B 2 60.0 15 3 20
B 2 60.0 20 2 20
B 2 65.8 10 0 20
B 2 65.8 15 2 20
B 2 65.8 20 1 20
B 2 70.5 10 0 20
B 2 70.5 15 0 20
B 2 70.5 20 1 20
B 2 75.8 10 1 20
B 2 75.8 15 0 20
B 2 75.8 20 1 20
B 3 60.0 10 7 20
B 3 60.0 15 11 20
B 3 60.0 20 11 20
B 3 65.8 10 4 20
B 3 65.8 15 5 20
B 3 65.8 20 9 20
B 3 70.5 10 2 20
B 3 70.5 15 4 20
B 3 70.5 20 6 20
B 3 75.8 10 2 20
B 3 75.8 15 3 20
B 3 75.8 20 5 20
B 4 60.0 10 12 20
B 4 60.0 15 14 20
B 4 60.0 20 16 20
B 4 65.8 10 10 20
B 4 65.8 15 12 20
B 4 65.8 20 12 20
B 4 70.5 10 5 20
B 4 70.5 15 7 20
B 4 70.5 20 9 20
B 4 75.8 10 4 20
B 4 75.8 15 5 20
B 4 75.8 20 7 20
;
run;

/*----------------------*/
/* Analisi descrittiva  */
/*----------------------*/

proc means data=snail mean std min max n;
    var death;
    title 'Statistiche descrittive di "death"';
run;

proc means data=snail mean std min max n;
    class species espos;
    var death;
    title 'Statistiche descrittive di "death" per specie ed esposizione';
run;

proc means data=snail mean std min max n;
    class species umid;
    var death;
    title 'Statistiche descrittive di "death" per specie e umidità';
run;

proc means data=snail mean std min max n;
    class species temp;
    var death;
    title 'Statistiche descrittive di "death" per specie e temperatura';
run;

/*-------------------*/
/* Modello binomiale */
/*-------------------*/

proc logistic data=snail;
    class  species(ref='A') / param=ref;
    model death/num = species espos temp umid
                      species*espos
                      species*temp
                      species*umid
                      espos*temp
                      espos*umid
                      temp*umid / scale=deviance;
    title 'Modello logit binomiale (effetti principali e interazioni di secondo ordine)';
run;

proc logistic data=snail;
    class species(ref='A') / param=ref;
    model death/num = species espos temp umid / scale=deviance;
    title 'Modello logit binomiale (effetti principali)';
run;

proc logistic data=snail descending;
   class species(ref='A') / param=ref;
   model death/num = species espos|temp|umid @4
                     / selection=stepwise
                       slentry=0.15
                       slstay=0.15
                       scale=deviance;
   title "Procedura di selezione Stepwise - Modello logit binomiale (dati Snail)";
run;

ods graphics on;

proc logistic data=snail descending
              plots(only)=(oddsratio(range=clip));
   class species(ref='A') / param=ref;
   model death/num = species espos temp umid
                     / scale=deviance
                       clodds=wald;

   /* Effetto di esposizione */
   effectplot slicefit(sliceby=species plotby=espos) / noobs clm at(temp=15 umid=70.5);

   /* Effetto della temperatura */
   effectplot slicefit(sliceby=species plotby=temp) / noobs clm at(espos=2 umid=70.5);

   /* Effetto dell'umidità */
   effectplot slicefit(sliceby=species plotby=umid) / noobs clm at(espos=2 temp=15);

   /* Output con valori predetti e residui */
   output out=pred_snail
          pred=pred_prob
          xbeta=xbeta
          predprobs=i
          resdev=resdev
          reschi=reschi;
run;

ods graphics off;

/*--------------------*/
/* Modello di Poisson */
/*--------------------*/

data snail_cat;
   set snail;

   if temp = 10 then temp_cat = "Bassa";
   else if temp = 15 then temp_cat = "Media";
   else temp_cat = "Alta";
   
   if umid = 60.0 then umid_cat = "Bassa";
   else if umid = 65.8 then umid_cat = "Media";
   else umid_cat = "Alta";

run;

proc genmod data=snail_cat;
  class species(ref='A') temp_cat(ref='Bassa') umid_cat(ref='Bassa') / param = ref;
  model death = species espos temp_cat umid_cat / dist=poisson link=log;
run;

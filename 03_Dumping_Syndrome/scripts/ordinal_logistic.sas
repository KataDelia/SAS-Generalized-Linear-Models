/* =======================================================
   1. Importazione dei dati
   ======================================================= */
title 'Dumping Syndrome Data';
data operate; 
  input Hospital Treatment $ Severity $ wt @@; 
  datalines; 
1 a none 23    1 a slight  7    1 a moderate 2 
1 b none 23    1 b slight 10    1 b moderate 5 
1 c none 20    1 c slight 13    1 c moderate 5 
1 d none 24    1 d slight 10    1 d moderate 6 
2 a none 18    2 a slight  6    2 a moderate 1 
2 b none 18    2 b slight  6    2 b moderate 2 
2 c none 13    2 c slight 13    2 c moderate 2 
2 d none  9    2 d slight 15    2 d moderate 2 
3 a none  8    3 a slight  6    3 a moderate 3 
3 b none 12    3 b slight  4    3 b moderate 4 
3 c none 11    3 c slight  6    3 c moderate 2 
3 d none  7    3 d slight  7    3 d moderate 4 
4 a none 12    4 a slight  9    4 a moderate 1 
4 b none 15    4 b slight  3    4 b moderate 2 
4 c none 14    4 c slight  8    4 c moderate 3 
4 d none 13    4 d slight  6    4 d moderate 4 
; 
run;


/* =======================================================
   2. Tabelle di contingenza esplorative
   ======================================================= */
proc freq data=operate;
   weight wt;
   tables Treatment*Severity 
          Hospital*Severity 
          Treatment*Hospital / chisq;
run;

/* Tabelle condizionate per ospedale */
proc sort data=operate;
   by Hospital;
run;

proc freq data=operate order=data;
   by Hospital;
   tables Severity*Treatment / chisq;
   weight wt;
run;


/* =======================================================
   3. Modello logistico cumulato (Ordinal Logistic Regression)
   ======================================================= */
ods graphics on;

proc logistic data=operate order=data plots=all;
   class Treatment (ref='a') Hospital (ref='1') / param=effect;
   model Severity = Treatment Hospital / link=cumlogit;
   freq wt;
   output out=logfit predprobs=individual;
   title 'Ordinal Logistic Regression - Parametrizzazione Effect';
run;

proc logistic data=operate order=data plots=all;
   class Treatment (ref='a') Hospital (ref='1') / param=reference;
   model Severity = Treatment Hospital / link=cumlogit;
   freq wt;
   output out=logfit predprobs=individual;
   title 'Ordinal Logistic Regression - Parametrizzazione Reference';
run;

/* =======================================================
   4. Modello logistico politomico (Generalized Logit)
   ======================================================= */
proc logistic data=operate;
    class Hospital (ref='1') Treatment (ref='a') / param=ref;
    model Severity (ref='none') = Hospital Treatment / link=glogit;
    freq wt;
    title 'Modello Logistico Politomico';
run;

/* =======================================================
   5. Modello logistico cumulato (Sub-setting Trattamento D)
   ======================================================= */
data operate_d;
   set operate;
   if Treatment = 'd';
run;

proc logistic data=operate_d order=data plots=all;
   class Hospital (ref='1') / param=effect;
   model Severity = Hospital / link=cumlogit;
   freq wt;
   output out=logfit predprobs=individual;
   title 'Ordinal Logistic Regression - Solo Trattamento D';
run;

ods graphics off;

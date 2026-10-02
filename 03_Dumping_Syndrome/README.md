# Progetto 3 — Modelli Logistici per la Sindrome da Dumping

## Panoramica dello studio

Questo progetto analizza i dati provenienti da uno studio clinico finalizzato a valutare la gravità della **sindrome da dumping**, una complicanza post-operatoria, in pazienti sottoposti a differenti trattamenti chirurgici.

L'obiettivo principale dell'analisi è valutare se la **frequenza e la gravità dei sintomi** siano associate alla tipologia di intervento chirurgico effettuato o alla struttura ospedaliera di riferimento.

---

## Struttura del dataset

Le osservazioni sono aggregate e la frequenza di ogni combinazione di caratteristiche è indicata dalla variabile `wt`, utilizzata come **peso delle osservazioni** nelle analisi.

Le principali variabili disponibili sono:

| Variabile | Descrizione |
|---|---|
| `Hospital` | Struttura ospedaliera in cui è stato effettuato l'intervento, identificata dai valori da 1 a 4 |
| `Treatment` | Tipologia di trattamento chirurgico, identificata dalle categorie `a`, `b`, `c` e `d` |
| `Severity` | Variabile di risposta ordinale che descrive la gravità della sindrome |
| `wt` | Frequenza associata a ciascuna combinazione di osservazioni |

La variabile `Severity` presenta tre livelli ordinati:

1. `none` — assenza di sintomi
2. `slight` — sintomi lievi
3. `moderate` — sintomi moderati

La natura ordinale della variabile risposta rappresenta un elemento centrale nella scelta del modello statistico.

---

## Metodologia analitica

L'analisi è stata condotta utilizzando le procedure SAS per l'analisi di dati categoriali.

### Tabelle di contingenza esplorative

Sono state create tabelle di contingenza bivariate e stratificate per ospedale mediante `PROC FREQ`.

Questa fase ha permesso di esaminare l'associazione grezza tra:

- trattamento;
- gravità dei sintomi;
- struttura ospedaliera.

Le analisi stratificate consentono inoltre di valutare la distribuzione della gravità della sindrome nei diversi ospedali.

### Modello logistico cumulato

Data la natura ordinale della variabile `Severity`, è stato stimato un **modello di regressione logistica cumulata (Ordinal Logistic Regression)**.

Il modello considera le probabilità cumulative dei diversi livelli di gravità ed è stato valutato utilizzando differenti parametrizzazioni:

- **Effect coding**
- **Reference coding**

Il trattamento `a` viene utilizzato come categoria di riferimento per l'interpretazione degli odds ratio.

### Modello logistico politomico

È stato inoltre sviluppato un **modello logistico generalizzato (Generalized Logit Model)**, trattando la variabile `Severity` come variabile nominale.

Questa analisi permette di valutare l'effetto dei predittori senza assumere una struttura ordinale tra le categorie della risposta.

### Analisi per sottogruppo

È stata infine condotta un'analisi specifica mediante **sub-setting dei dati**, considerando esclusivamente le osservazioni relative al trattamento `d`.

Questa analisi permette di valutare il comportamento del modello in uno specifico sottogruppo di trattamento.

---

## Risultati principali

### Assunzione degli odds proporzionali

Per il modello logistico cumulato è stato valutato l'assunto degli **odds proporzionali**.

Il test degli score restituisce:

$$
p\text{-value} = 0.1728
$$

Il risultato non evidenzia una violazione statisticamente significativa dell'assunto degli odds proporzionali. Il modello logistico ordinale risulta quindi coerente con la struttura dei dati analizzati.

---

### Effetto del trattamento

L'analisi evidenzia una differenza tra i trattamenti chirurgici.

In particolare, rispetto al trattamento di riferimento `a`, il trattamento `d` presenta un **odds ratio stimato pari a 0.547**.

L'intervallo di confidenza di Wald al 95% è:

$$
OR = 0.547 \quad [0.316,\ 0.945]
$$

L'odds ratio inferiore a 1 indica una riduzione delle odds associate ai livelli più elevati di gravità per il trattamento `d` rispetto al trattamento `a`, secondo la parametrizzazione del modello.

---

### Effetto dell'ospedale

La struttura ospedaliera non risulta associata in modo statisticamente significativo alla gravità della sindrome nel modello considerato.

Il test di Wald restituisce:

$$
p\text{-value} = 0.4424
$$

La distribuzione dell'assenza di sintomi mostra comunque alcune differenze descrittive tra le strutture ospedaliere.

La percentuale di pazienti nella categoria `none` varia da:

- **51.35%** nell'Ospedale 3
- **60.81%** nell'Ospedale 1

Queste differenze descrittive non risultano sufficienti, nel modello analizzato, a evidenziare un'associazione statisticamente significativa tra ospedale e gravità della sindrome.

---

## Sintesi

L'analisi ha utilizzato diversi approcci per studiare la relazione tra **trattamento chirurgico, struttura ospedaliera e gravità della sindrome da dumping**.

Il modello logistico cumulato risulta compatibile con l'assunzione degli odds proporzionali, con un test degli score pari a `p = 0.1728`.

Tra i fattori considerati, il **trattamento chirurgico** mostra un'associazione con la gravità dei sintomi. In particolare, il trattamento `d`, rispetto al trattamento `a`, presenta un odds ratio pari a **0.547**.

Al contrario, la **struttura ospedaliera** non mostra un'associazione statisticamente significativa con l'esito nel modello considerato (`p = 0.4424`).

L'utilizzo congiunto del modello cumulato, del modello generalized logit e dell'analisi per sottogruppo permette di ottenere una valutazione complementare della relazione tra caratteristiche del trattamento e gravità della sindrome.

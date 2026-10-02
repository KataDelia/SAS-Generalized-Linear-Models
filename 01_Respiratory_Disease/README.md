# Progetto 1 — Patologie Respiratorie e Fattori di Rischio

## Panoramica

L'obiettivo dell'analisi è verificare l'esistenza di associazioni significative tra alcune **variabili demografiche e comportamentali** e la presenza di **patologie respiratorie croniche**.

In particolare, vengono analizzati i seguenti fattori:

- **Sesso**
- **Età**
- **Abitudine al fumo**

Il dataset simula un campione di **550 individui**, aggregati all'interno di una **tabella di contingenza multidimensionale**.

L'analisi mira a valutare se le caratteristiche demografiche e comportamentali considerate siano associate alla presenza o all'assenza della patologia respiratoria.

---

## Metodologia

L'analisi implementa un confronto tra diversi **modelli lineari generalizzati per dati categoriali**, utilizzando le procedure SAS `PROC LOGISTIC` e `PROC GENMOD`.

### Regressione logistica

La regressione logistica (`PROC LOGISTIC`) viene utilizzata per stimare l'effetto dei predittori sulla probabilità di presenza della patologia respiratoria.

Il modello consente inoltre di ottenere i relativi **Odds Ratio**, utili per quantificare l'associazione tra ciascun predittore e l'esito clinico.

Il modello considera inizialmente i tre fattori:

- Sesso
- Fumo
- Età

come **effetti principali**, senza includere interazioni tra le variabili.

### Modelli log-lineari

I modelli log-lineari vengono stimati mediante `PROC GENMOD`, assumendo una distribuzione di **Poisson**.

Sono stati considerati e confrontati diversi tipi di modello:

#### Modello nullo

Modello contenente esclusivamente la costante, senza associazioni tra le variabili.

#### Modello saturo

Modello che include tutte le possibili interazioni tra le variabili presenti nella tabella di contingenza.

#### Modelli di indipendenza

Sono stati considerati modelli che assumono differenti strutture di indipendenza tra le variabili, tra cui:

- **Indipendenza completa**
- **Indipendenza congiunta**

#### Modello con associazioni omogenee

È stato inoltre considerato un modello caratterizzato da associazioni omogenee tra le variabili, permettendo di valutare la struttura delle associazioni presenti nella tabella di contingenza.

---

## Risultati principali

### Regressione logistica

Nel modello di regressione logistica contenente esclusivamente gli **effetti principali**, nessuno dei predittori considerati raggiunge il livello di significatività statistica fissato a:

$$
\alpha = 0.05
$$

I test del **Chi-quadrato di Wald** restituiscono i seguenti p-value:

| Variabile | p-value |
|---|---:|
| Sesso | 0.8466 |
| Fumo | 0.7102 |
| Età | 0.9615 |

Tutti i valori risultano superiori alla soglia di significatività di 0.05.

Di conseguenza, nel modello considerato, **nessuno dei tre predittori risulta statisticamente significativo singolarmente** nello spiegare la variabilità della risposta clinica.

---

## Interpretazione

I risultati della regressione logistica indicano che, considerando separatamente gli effetti principali di **sesso, abitudine al fumo ed età**, non emerge un'associazione statisticamente significativa con la presenza della patologia respiratoria nel campione analizzato.

In particolare:

- il **sesso** presenta un p-value pari a `0.8466`;
- l'**abitudine al fumo** presenta un p-value pari a `0.7102`;
- l'**età** presenta un p-value pari a `0.9615`.

Tutti i valori sono superiori a `0.05`, pertanto non si osservano evidenze statistiche sufficienti per associare individualmente questi predittori alla risposta clinica nel modello a soli effetti principali.

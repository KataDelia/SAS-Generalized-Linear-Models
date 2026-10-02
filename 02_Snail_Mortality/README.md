# Progetto 2: Analisi di sopravvivenza dei lumaconi

## Panoramica

Questo progetto contiene l'analisi dei dati derivanti da un esperimento randomizzato progettato per valutare la mortalità dei lumaconi in funzione della specie e di tre parametri ambientali:

- **Tempo di esposizione**
- **Umidità relativa**
- **Temperatura**

Il dataset è costituito da **96 gruppi di osservazioni**, corrispondenti a un disegno fattoriale completo:

$$
4 \times 3 \times 4 \times 2 = 96
$$

Le variabili considerate permettono di analizzare l'effetto delle condizioni ambientali sulla probabilità di mortalità, distinguendo inoltre tra le due specie considerate (**A** e **B**).

---

## Analisi statistica

Per modellare la probabilità di mortalità è stato utilizzato un **modello Logit Binomiale**.

La selezione delle variabili è stata effettuata tramite una procedura **stepwise**, utilizzando:

- `SLENTRY = 0.15` per l'ingresso delle variabili nel modello;
- `SLSTAY = 0.15` per la permanenza delle variabili nel modello.

### Modello finale

La procedura di selezione ha mantenuto nel modello finale esclusivamente i **quattro effetti principali**:

- Specie
- Tempo di esposizione
- Umidità
- Temperatura

Nessuna delle interazioni tra i predittori ha soddisfatto i criteri statistici necessari per essere inclusa nel modello finale.

Il modello può essere rappresentato, in forma generale, come:

$$
\text{logit}(p) =
\beta_0 +
\beta_1 \text{Specie} +
\beta_2 \text{Esposizione} +
\beta_3 \text{Umidità} +
\beta_4 \text{Temperatura}
$$

dove $p$ rappresenta la probabilità di mortalità.

---

## Risultati principali

### Effetto della specie

L'analisi evidenzia una differenza nella mortalità tra le due specie.

A parità delle condizioni ambientali, i lumaconi della **specie B** presentano un **odds ratio pari a 3.701** rispetto alla specie A.

L'intervallo di confidenza al 95% è:

$$
OR = 3.701 \quad [2.885,\ 4.749]
$$

Nel modello stimato, quindi, le odds di mortalità associate alla specie B risultano circa 3,7 volte quelle della specie A, a parità degli altri predittori inclusi nel modello.

### Effetto del tempo di esposizione

Il **tempo di esposizione** rappresenta il principale fattore di rischio individuato dal modello, con un **odds ratio stimato pari a 4.497**.

L'aumento del tempo di esposizione è associato a un incremento delle odds di mortalità.

---

## Visualizzazioni

Le visualizzazioni generate dall'analisi sono disponibili nella directory:

```text
output/
└── plots/
    ├── odds_ratio.png
    ├── effect_espos.png
    ├── effect_temp.png
    └── effect_umid.png

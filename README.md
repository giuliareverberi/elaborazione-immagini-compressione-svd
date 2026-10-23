# Elaborazione Immagini e Compressione tramite SVD

Questo progetto in MATLAB mostra le tecniche fondamentali di manipolazione digitale delle immagini e l'applicazione dell'algebra lineare numerica per la compressione delle immagini tramite Decomposizione ai Valori Singolari (SVD).

## Contenuto della Repository

* **`manipolazione_immagine.m`**: Script MATLAB contenente le funzioni di elaborazione dei canali RGB, manipolazione dei pixel e l'algoritmo di compressione SVD.

### Operazioni Implementate:
1. **Analisi Canali RGB e Conversioni:** Estrazione del canale rosso e conversione dell'immagine da colori RGB a scala di grigi tramite media ponderata dei canali.
2. **Manipolazione Diretta dei Pixel:** Modifica mirata dei valori dei tre canali di colore (RGB) per inserire elementi grafici su coordinate specifiche dell'immagine.
3. **Compressione per Sottocampionamento (Downsampling):** Riduzione della risoluzione spaziale tramite campionamento dei pixel a passo fisso.
4. **Compressione SVD (Singular Value Decomposition):**
   * Fattorizzazione delle matrici di colore RGB ($A = U \Sigma V^T$).
   * Approssimazione di rango $k$ per ridurre la dimensione dei dati memorizzati.
   * Valutazione dell'errore di troncamento basato sul valore singolare $\sigma_{k+1}$.

## Esecuzione
1. Inserire un'immagine di test denominata `foto.jpg` nella stessa cartella dello script.
2. Eseguire lo script `manipolazione_immagine.m` in MATLAB per visualizzare le figure con i confronti grafici e gli errori di approssimazione in console.

## Autore
* **Giulia Reverberi**

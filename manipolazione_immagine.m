%% CARICAMENTO IMMAGINE ORIGINALE
immagine = 'foto.jpg';
a = imread(immagine);

%% PARTE 1: VISUALIZZAZIONE CANALE ROSSO E CONVERSIONE IN SCALA DI GRIGI
% Estrazione del canale del Rosso
a1 = a(:,:,1);
figure(1);
image(a1);

%Conversione in formato double per calcoli di precisione
R = double(a(:,:,1)); % Strato del Rosso
G = double(a(:,:,2)); % Strato del Verde
B = double(a(:,:,3)); % Strato del Blu

% Calcolo della media dei tre canali RGB
grigio_double = (R + G + B) / 3;

% Riconversione in intero a 8 bit per la visualizzazione
immagine_bn = uint8(grigio_double);
figure(2);
colormap(gray); 
image(immagine_bn); % Visualizzazione dell'immagine in scala di grigi

%% PARTE 2: MODIFICA MANUALE DEI PIXEL (CREAZIONE DI UNA RIGA GIALLA)

a_pasticciata = a; %copia immagine per non alterare l'originale

% Impostazione del colore giallo su una striscia di pixel
a_pasticciata(500:510, :, 1) = 255; % Rosso al massimo
a_pasticciata(500:510, :, 2) = 255; %  Verde al massimo
a_pasticciata(500:510, :, 3) = 0;   % Blu al minimo

figure(3);
image(a_pasticciata); %Visualizzazione dell'immagine con la riga gialla

%% PARTE 3: COMPRESSIONE TRAMITE DOWNSAMPLING (SOTTOCAMPIONAMENTO)
% Riduzione della risoluzione prelevando un pixel ogni due
a_compressa = a(1:2:end, 1:2:end, :);

figure(4);
image(a_compressa); % Visualizzazione dell'immagine sottocampionata

%% PARTE 4: COMPRESSIONE TRAMITE DECOMPOSIZIONE AI VALORI SINGOLARI (SVD)
% Conversione dell'immagine in formato double
a_double = double(a);

% Separazione dei tre canali di colore
R = a_double(:,:,1);
G = a_double(:,:,2);
B = a_double(:,:,3);

% Impostazione del numero di valori singolari da mantenere
k = 10;

% Applicazione della compressione SVD su ciascun canale di colore
[Ur, Sr, Vr, err_r] = comprimi_svd(R, k);
[Ug, Sg, Vg, err_g] = comprimi_svd(G, k);
[Ub, Sb, Vb, err_b] = comprimi_svd(B, k);

% Ricostruzione dei singoli canali di colore con rango k
R_k = Ur * Sr * Vr';
G_k = Ug * Sg * Vg';
B_k = Ub * Sb * Vb';

% Metto insieme l'immagine compressa
Ak_double = zeros(size(a_double));
Ak_double(:,:,1) = R_k;
Ak_double(:,:,2) = G_k;
Ak_double(:,:,3) = B_k;

%Riconversione in uint8 per la stampa
Ak = uint8(Ak_double);

% Confronto  tra immagine originale e compressa
figure('Name', 'Confronto SVD');
subplot(1,2,1);
image(a);
title('Originale');

subplot(1,2,2);
image(Ak);
title(sprintf('Compressa (k=%d)', k));

% stampa degli errori di approssimazione (valore singolare sigma_{k+1})
fprintf('Errore (strato Rosso): %f\n', err_r);
fprintf('Errore (strato Verde): %f\n', err_g);
fprintf('Errore (strato Blu): %f\n', err_b);

%%FUNZIONE PER LA COMPRESSIONE SVD
function [Uk, Sk, Vk, errore] = comprimi_svd(A, k)
    % Calcolo della SVD completa della matrice A
    [U, S, V] = svd(A); 
    
    % Estrazione dei primi k fattori
    Uk = U(:, 1:k);     % Prime k colonne di U
    Sk = S(1:k, 1:k);   % Blocco k x k dei valori singolari
    Vk = V(:, 1:k);     % Prime k colonne di V  
    
    % L'errore corrisponde al più grande valore singolare scartato
    if k < min(size(A))
        errore = S(k+1, k+1);
    else
        errore = 0;
    end
end
# PredictAZUs
Plataforma per analitzar les dades dels assaigos del Arreplegats de la Zona Universitària.

Un primer estudi ràpid de les dades com a sèries temporals ens dona els següents resultats:
![Predicció de l'últim tram de la temporada 2018-2019](https://github.com/Huguet57/predictazus/blob/master/plots/PredTemporada20182019.png)
Com veiem, no és de gran ajuda la predicció estàndard perquè a l'haver-hi només un any de dades no pot detectar patrons repetits anualment. Per això, la segona predicció promet més; tenint dos anys de dades com a input.
![Predicció de la temporada 2019-2020](https://github.com/Huguet57/predictazus/blob/master/plots/PredTemporada20192020.png)

De l'estudi, també ens surt que la sèrie segueix un model ``SARIMA(2,1,1)(0,1,0)48``. Sigui ``Xt`` la variable aleatòria que recull el nombre de gent que va a assaig en un assaig ``t`` i ``Zt`` el soroll de l'assaig ``t``, diferència de la predicció esperada de gent a assaig aquell dia amb el valor real.

![Definició de Zt](https://latex.codecogs.com/gif.latex?%5Cdpi%7B150%7D%20Z_t%20%3D%20X_t%20-%20%5Cmathbb%7BE%7D%5BX_t%20%7C%20X_%7Bt-1%7D%2C%5Cldots%2CX_1%5D)

Els ``phi`` i ``theta`` són coeficients escalars reals i el nombre ``B`` és tal que:

![Definició de B](https://latex.codecogs.com/gif.latex?%5Cdpi%7B150%7D%20X_%7Bt-1%7D%20%3D%20B%20X_t)

Per tant, el model ve definit per:

![Sèrie temporal](https://latex.codecogs.com/gif.latex?%5Cdpi%7B150%7D%20%281%20-%20%5Cphi_1%20B%20-%20%5Cphi_2%20B%5E2%29%281%20-%20B%5E%7B48%7D%29%281%20-%20B%29X_t%20%3D%20%281%20&plus;%20%5Ctheta_1%20B%29%20Z_t)

Sent 48 el nombre d'assaigos per temporada, ens haurem de fixar en els **tres assaigos anteriors**, i en els **quatre assaigos anteriors** de l'assaig corresponent de l'any passat.

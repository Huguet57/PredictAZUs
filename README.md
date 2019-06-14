# PredictAZUs
Plataforma per analitzar les dades dels assaigos del Arreplegats de la Zona Universitària.

Un primer estudi ràpid de les dades com a sèries temporals ens dona els següents resultats:
![Predicció de l'últim tram de la temporada 2018-2019](https://github.com/Huguet57/predictazus/blob/master/plots/PredTemporada20182019.png)
Com veiem, no és de gran ajuda la predicció estàndard perquè a l'haver-hi només un any de dades no pot detectar patrons repetits anualment. Per això, la segona predicció promet més; tenint dos anys de dades com a input.
![Predicció de la temporada 2019-2020](https://github.com/Huguet57/predictazus/blob/master/plots/PredTemporada20192020.png)

De l'estudi, també ens surt que la sèrie és de la forma:
\[
(1 - \phi_1 B - \phi_2 B^2)(1 - B^48)(1 - B)X_t = (1 + \theta_1 B) Z_t
\]
Amb $$X_t$$ la variable aleatòria que recull el nombre de gent que va a assaig en un assaig $$t$$ i $$Z_t$$ el soroll de l'assaig $$t$$, diferència de la predicció esperada de gent a assaig aquell dia $$\mathbb{E}[X_t | X_{t-1},\ldots,X_1]$$ amb el valor real $$X_t$$. Els $$\phi_i$$, $$\theta_j$$ són coeficients escalars reals i el nombre $$B$$ és tal que: $$X_{t-1} = B X_t$$. Per tant,

$$
(1 - \phi_1 B - \phi_2 B^2)(1 - B^48)(1 - B)X_t = (1 + \theta_1 B) Z_t \\
X_t-X_{t-1}-\phi_1\,X_{t-1}+\phi_1\,X_{t-2}-\phi_2\,X_{t-2}+\phi_2\,X_{t-3}-X_{t-48}+X_{t-49}+\phi_1\,X_{t-49}-\phi_1\,X_{t-50}+\phi_2\,
 X_{t-50}-\phi_2\,X_{t-51} = Z_t + \theta_1 Z_{t-1} \\
X_t = X_{t-1}+\phi_1\,X_{t-1}-\phi_1\,X_{t-2}+\phi_2\,X_{t-2}-\phi_2\,X_{t-3}+X_{t-48}-X_{t-49}-\phi_1\,X_{t-49}+\phi_1\,X_{t-50}-\phi_2\,
 X_{t-50}+\phi_2\,X_{t-51} + Z_t + \theta_1 Z_{t-1}
$$

Sent 48 el nombre d'assaigos per temporada, ens haurem de fixar en els \textbf{tres assaigos anteriors}, i en els \textbf{quatre assaigos anteriors} de l'assaig corresponent de l'any passat.

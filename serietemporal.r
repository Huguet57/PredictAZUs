assist.assaig <- read.csv("./data/assistents_2017_2019.csv")
AA <- assist.assaig$assistents
TS <- ts(AA,
         start=c(2017, 28),
         frequency = 48)

serie=window(TS,
             start=c(2017,9))
print(round(serie,0))

plot(serie,
     type="o")

abline(v = 2018.56, col = 2)

##Descomposici?n en componentes b?sicas (tendencia+estacionalidad+proceso estacionario)
plot(decompose(lnserie))

##Transformaci?n logaritmica para homogeneizar la varianza
lnserie=log(serie)
plot(lnserie)

## Diferenciaci?n estacional (eliminaci?n de la componente estacional)
d48lnserie=diff(lnserie,48)
plot(d48lnserie)
abline(h=0)

## Diferenciaci?n regular (media no constante)
d1d48lnserie=diff(d48lnserie,1)
plot(d1d48lnserie)
abline(h=0)

## Nueva diferenciaci?n regular (posible no estacionariedad)
d1d1d48lnserie=diff(d1d48lnserie,1)
plot(d1d1d48lnserie)
abline(h=0)

##Comparaci?n de las varianzas
var(lnserie)
var(d48lnserie)
var(d1d48lnserie)
var(d1d1d48lnserie)

# ACF i PACF
par(mfrow=c(1,2))
acf(d1d48lnserie,ylim=c(-1,1),col=c(2,rep(1,11)),lwd=2,lag.max=200)
pacf(d1d48lnserie,ylim=c(-1,1),col=c(rep(1,11),2),lwd=2,lag.max=200)
par(mfrow=c(1,1))

# Models proposats
(mod=arima(d1d48lnserie,order=c(2,0,1),seasonal=list(order=c(0,0,0),period=48)))
# (mod=arima(lnserie,order=c(0,1,0),seasonal=list(order=c(0,1,0),period=48)))

# Validació
source("validation.r")
dades=d1d48lnserie
model=mod
validation(model,dades)

########### Estabilitat Model (SENSE CONSTANT!!!!) ###############
ultim=c(2019,0)
du=c(0,27)

serie1=window(serie,end=ultim+du)
lnserie1=log(serie1)
serie2=window(serie,end=ultim)
lnserie2=log(serie2)

(mod=arima(lnserie1,order=c(2,1,1),seasonal=list(order=c(0,1,0),period=48)))
(mod2=arima(lnserie2,order=c(2,1,1),seasonal=list(order=c(0,1,0),period=48)))

# Predicció
pred=predict(mod2,n.ahead=27)
pr<-ts(c(tail(lnserie2,1),pred$pred),start=ultim,freq=48)

se<-ts(c(0,pred$se),start=ultim,freq=48)

# Intervals de confiança
tl<-ts(exp(pr-1.96*se),start=ultim,freq=48)
tu<-ts(exp(pr+1.96*se),start=ultim,freq=48)
pr<-ts(exp(pr),start=ultim,freq=48)

ts.plot(serie,tl,tu,pr,
        lty=c(1,2,2,1),col=c(1,4,4,2),
        type="o",
        main = "Predicció de la temporada 2018-19 amb dades de la temporada 2017-18")

# Tractament de l'error de predicció
(previs=window(cbind(tl,pr,tu,serie,error=round(serie-pr,3)),start=ultim))

obs=window(serie,start=ultim)
(mod.EQM1=sqrt(sum(((obs-pr)/obs)^2)/48))
(mod.EAM1=sum(abs(obs-pr)/obs)/48)

##### Previsions a llarg termini amb el model complet ######
ultim <- c(2019,27)
pred=predict(mod,n.ahead=48)
pr<-ts(c(tail(lnserie,1),pred$pred),start=ultim,freq=48)
se<-ts(c(0,pred$se),start=ultim,freq=48)

#Intervals
tl1<-ts(exp(pr-1.96*se),start=ultim,freq=48)
tu1<-ts(exp(pr+1.96*se),start=ultim,freq=48)
pr1<-ts(exp(pr),start=ultim,freq=48)

ts.plot(serie,tl1,tu1,pr1,
        lty=c(1,2,2,1),col=c(1,4,4,2),
        main="Assistència a assaig temporada 2019-2020",type="o")
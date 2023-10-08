# Vérifier si l'estimateur de MCO est sans biais sous **R** : Simulation de Monte Carlo

 ![](https://i.imgur.com/ZLWZaa3.jpg)
 ***Auteur : Boubacar KANDE***

Je vérifie si l'estimateur des moindres carrés ordinaires est sans biais sur une  simulation d'un modèle linéaire simple en utilisant le logiciel **R**. Je formalise le modèle théorique comme suit: 

$$Y=alpha+beta\times X+epsilon$$
  
 **Code R** 
```
# définir la taille de l'échantillon et les paramétres du modèle
n=200 
alpha=1
beta=2
# initialisation des coéfficients estimés
b=0
a=0
# créer un boucle pour simuler le modèle 1000 fois
for (i in 1:1000){
    epsilon= rnorm(n,0,1)
    X=rnorm(n,6,1)
    Y=alpha+beta*X+epsilon
    plot(X,Y,col="blue",lwd=2)
    mod=lm(Y~1+X)
    abline(mod$coef,col="red")
    a[i]=mod$coef[1]
    b[i]=mod$coef[2]
}
hist(a,col="blue", freq = F, main = "Histogramme des 1000 coefficients a", ylab = "Densité")
summary(a)
hist(b,col="green",freq = F, main = "Histogramme des 1000 coefficients b", ylab = "Densité")
summary(b)

```
**Résultats**


![](https://i.imgur.com/HtSSba5.png)
- pour a 

![](https://i.imgur.com/Bnk4vTU.png)

 

| Min.     | 1st Qu.  | Median   |Mean  |3rd Qu.|Max.|
| -------- | -------- | -------- |------|-------|----|
| -0.5307  | 0.7096   |  0.9967  |**1.0003**|1.2890|2.4652|

Pour que l'estimateur alpha soit sans biais il faut que **E(a)=alpha**
 Nous avons la moyenne de **a=1.0003** estsensiblement égal à **alpha** fixé à **1** 
 
- pour b

![](https://i.imgur.com/Ix2TXxk.png)



| Min.     | 1st Qu.  | Median   |Mean  |3rd Qu.|Max.|
| -------- | -------- | -------- |------|-------|----|
| 1.760  | 1.953   |  2.000  |**2.000**|2.047|2.247| 

Pour que l'estimateur beta soit sans biais il faut que **E(b)=beta**
 Nous avons la moyenne de **b=2.000** est égal à **beta** fixé à **2** 
 
 -------------------------------

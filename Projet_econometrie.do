/* 

Projet d'économétrie Master Econométrie Appliquée 

Boubacar KANDE 
*/

clear
set obs 100 // On simule 100 individus (ou observations)
set seed 1234 // Pour que vous puissiez reproduire exactement mes résultats

* 1. Variable indépendante : Éducation (entre 10 et 20 ans d'études)
gen educ = floor(runiform(10, 20))

* 2. Variable indépendante : Expérience (entre 0 et 40 ans)
gen exper = floor(runiform(0, 40))

* 3. Le terme d'erreur (bruit blanc)
gen epsilon = rnormal(0, 5) // Moyenne 0, écart-type 5

* 4. Création de la variable dépendante (Salaire)
* Ici, on fixe arbitrairement : constante=15, coef_educ=2, coef_exper=0.5
gen salaire = 15 + 2*educ + 0.5*exper + epsilon

graph matrix salaire educ exper // Matrice de nuages de points
pwcorr salaire educ exper, sig   // Corrélations numériques

regress salaire educ exper

predict res, residuals
sktest res
ssc install jb
jb res
histogram res, normal
estat ovtest
vif
* Si vos données étaient temporelles (ex: tsset annee)
estat dwatson
rvfplot, yline(0) // Graphique des résidus vs valeurs prédites
hettest            // Test de Cook-Weisberg

* Modèle 1 : Régression simple
regress salaire educ
outreg2 using resultats.doc, replace word title("Comparaison des Modèles") ctitle("Modèle Simple")

* Modèle 2 : Régression multiple (ajout de l'expérience)
regress salaire educ exper
outreg2 using resultats.doc, append word ctitle("Modèle Multiple")

* Modèle 3 : Ajout d'un terme quadratique (ex: exper^2 pour tester la non-linéarité)
gen exper2 = exper^2
regress salaire educ exper exper2
outreg2 using resultats.doc, append word ctitle("Modèle Quadratique")

outreg2 using resultats.doc, append word ///
    label /// Utilise les étiquettes de variables au lieu des noms techniques
    dec(3) /// Fixe le nombre de décimales à 3
    adds(F-test, e(F), R-squared, e(r2)) /// Ajoute manuellement des stats spécifiques
    aster(coefficient) // Ajoute les étoiles de significativité (* p<0.05, ** p<0.01)
  <!-- badges: start -->
  [![Launch Rstudio Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/IgnasiLucas/Tasca/soca?urlpath=lab)
  <!-- badges: end -->

# Tasca de Bioinformàtica

## Continguts

Aquest repositori inclou materials didàctics per la realització d'exercicis pràctics
de bioinformàtica mitjançant la plataforma mybinder.org. Han estat confeccionats
seguint el tutorial [*From Zero to Binder in R!*](https://the-turing-way.netlify.app/communication/binder/zero-to-binder.html)
de l'Alan Turing Institute.

Aquí es proposa una tasca a realitzar individualment, fora de l'aula.

## Base de dades

L'execució de cerques BLAST des d'una instància de MyBinder té algune dificultats:

- No és possible utilitzar l'eina `update_blastdb.pl` de blast+ des de MyBinder,
  perquè, si no m'equivoque, depén d'una connexió ftp, que en MyBinder estan limitades.
- No és fàcil incloure una base de dades en un repositori de Github, on la mida dels
  arxius està limitada a 100M (mida màxima recomanada: 50M).
- No funciona l'opció `-remote` dels programes blast. Almenys jo no l'he poguda fer
  funcionar, i he assumit que està també limitada en MyBinder (ftp?).

La solució ha sigut incloure la base de dades en el repositori de Github, però reconstruïda
amb una mida màxima d'arxiu (opció `-max_file_sz` de `makeblastdb`). La base de dades inclou
informació taxonòmica per poder utilitzar les opcions `-taxids` i `-taxidlist`.

El procés de construcció de la base de dades està a l'script `crear_db.sh`.

## Instal·lació de blast

Com que el kernel que necessite en MyBinder és el d'R, la forma de definir l'entorn
és mitjançant l'script d'R `install.R`, que ha d'instal·lar els paquets especificats.
Per tal d'instal·lar paquets fora d'R he intentat incloure un document .yml amb un
entorn de conda que inclou blast, però no ha funcionat.

Entenc que en MyBinder, el notebook amb kernel d'R s'executa en un entorn de conda
concret ("notebook"?) i que no està previst modificar eixe entorn mitjançant un
document yaml. Per tal d'instal·lar blast+ des de la sessió oberta en MyBinder,
el que hem fet és utilitzar conda des de la terminal:

`conda install -c bioconda blast=2.10.1`

Això hauria de funcionar. Si no, es podria instal·lar la versió per defecte i
després intentar actualitzar. El cas és que no és possible crear un entorn nou,
perquè aleshores afectem el funcionament del notebook. El kernel d'R sembla
desaparéixer.


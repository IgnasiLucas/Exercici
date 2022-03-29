#!/bin/bash

# Este script descarrega la base de dades swissprot del ncbi (la més xicoteta) i la
# torna a regenerar amb una mida màxima d'arxiu de 50M. Així puc guardar la base de
# dades en github i es pot carregar en una instància de MyBinder.

if [ ! -e swissprot.00.phr ]; then
   if [ ! -e taxid_map.txt ]; then
      wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/idmapping_selected.tab.gz
      gunzip -c idmapping_selected.tab.gz | cut -f 1,13 > taxid_map.txt
      rm idmapping_selected.tab.gz

      # No he comprovat si l'arxiu següent és equivalent (9.9GB!):
      # wget https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.FULL.gz
      # gunzip -c prot.accession2taxid.FULL.gz > taxid_map.txt
   fi

   # No he aconseguit crear la base de dades amb límit de mida d'arxiu directament
   # a partir de la base de dades descarregada, sinó que sembla que haig de passar
   # pel format fasta.
   if [ ! -e swissprot.fas ]; then
      if [ ! -d tmp ]; then mkdir tmp; fi
      cd tmp
      if [ ! -e swissprot.pdb ]; then
         if [ ! -e swissprot.tar.gz ]; then
            update_blastdb.pl swissprot
         fi
         tar -xzvf swissprot.tar.gz
      fi
      cd ..
      blastdbcmd -db tmp/swissprot -entry all -out swissprot.fas
      if [ -d tmp ]; then rm -r tmp; fi
   fi
   makeblastdb -in swissprot.fas \
               -dbtype prot \
               -title swissprot \
               -parse_seqids \
               -taxid_map taxid_map.txt \
               -out swissprot \
               -max_file_sz 50M
   if [ ! -e taxdb.tar.gz ]; then
      wget https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz
   fi
   rm swissprot.fas
   rm taxid_map.txt
fi

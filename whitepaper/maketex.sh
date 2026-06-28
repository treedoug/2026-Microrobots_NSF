#!/bin/bash

name=`echo $1 | sed 's/\.tex//'`

if [ ! -f "refs.bib" ]; then
  echo "no bibliography"
  pdflatex $1
  pdflatex $1
else
  if [ -f "${name}.aux" ]; then
    pdflatex $1
    biber ${name}
    pdflatex $1
  else
    pdflatex $1 
    biber ${name}
    pdflatex $1
    pdflatex $1
  fi
fi


#echo ""
#echo "Searching PDF..."
#
## find page numbers
#mkdir -p pgcount
#cd pgcount
#pdftk ../${name}.pdf burst output tmp_%02d.pdf
#i=0
#for f in tmp*.pdf; do
#
#  i=$(($i+1))
#  pdftotext $f $f.txt
#
#  # first page of proj description 
#  PD=`grep -r "I. Introduction" $f.txt`
#  if [ -n "$PD" ]; then
#    PD_pg=$i
#  fi
#
#  # first page of refs
#  RC=`grep -r "References Cited" $f.txt`
#  if [ -n "$RC" ]; then
#    RC_pg=$i
#  fi
#
#done
#cd ..
#

#PD_pg=2
#RC_pg=17
#datetime=`date +'%Y-%m-%d-%H%M'`
#
#echo "  Projection Descrption Start: $PD_pg"
#echo "  References Cited Start: $RC_pg"
#echo "  Splitting PDF..."
#
#pdftk ${name}.pdf cat 1-$(($PD_pg-1)) output ${name}_Summary-${datetime}.pdf
#pdftk ${name}.pdf cat $PD_pg-$(($RC_pg-1)) output ${name}_Project_Description-${datetime}.pdf
#pdftk ${name}.pdf cat $RC_pg-end output ${name}_References-${datetime}.pdf
#

set term cairolatex #standalone header '\usepackage{siunitx}'
set pointintervalbox 0

set grid
set format y '%.0s\cdot10^{%T}'
set format x '%.0s\cdot10^{%T}'
set xlabel 'Wellenlänge $\lambda/\SI{}{m}$'
set ylabel 'Amplitude$/\SI{}{a.u}$'
set title 'P-Cygni Spektrum'
set output 'P_Cygni_spectra.tex'
plot '../data/processed/P-Cygni_spectra.dat' using 2:1 with linespoint lw 1  pt 0 title 'Datenpunkte' 

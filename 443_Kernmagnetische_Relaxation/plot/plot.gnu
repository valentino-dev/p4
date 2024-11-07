set term cairolatex

set output 'rabi_oszi.tex'
set grid
set ylabel 'Aplitude/$V$'
set xlabel 'Pulslänge \texttt{A_len}/$\SI{}{\micro s}'

plot '../data/rabi_oszillation.dat' using 1:($2*1e3):($3*1e3) with yerrorbars pt 0 title 'Probe',\
     '../data/rabi_oszillation.dat' using 1:($4):($5) with yerrorbars pt 0 title 'IN'

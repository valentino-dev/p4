set term cairolatex

set output 'rabi_oszi.tex'
set grid
set ylabel 'Amplitude/$\SI{}{\milli V}$'
set xlabel 'Pulslänge \texttt{A_len}/$\SI{}{\micro s}$'

m1=1400
f(x)=m1*abs(sin(b1*x+c1))
m2=200
b2=0.628
#c2=0
g(x)=m2*sin(b2*x+c2)

rabi_oszi_dat = '../data/rabi_oszillation.dat'
fit f(x) rabi_oszi_dat using 1:($2*1e3):($3*1e3) via m1, b1, c1
fit g(x) rabi_oszi_dat using 1:($4):($5) via m2, b2, c2

plot rabi_oszi_dat using 1:($2*1e3):($3*1e3) with yerrorbars pt 0 title 'Probe',\
    f(x) with lines title 'Probe fit',\
    rabi_oszi_dat using 1:($4):($5) with yerrorbars pt 0 title 'In-Phase',\
    g(x) with lines title 'In-Phase fit'

set datafile separator ","
set output 'opt_sig.tex'
opt_sig_dat='../data/print_001.csv'
set grid
set ylabel 'y'
set xlabel 'x'
plot opt_sig_dat using 1:2 with lines title 'Oszillogramm'

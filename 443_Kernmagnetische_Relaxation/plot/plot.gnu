set term cairolatex

set output 'rabi_oszi.tex'
set grid
set ylabel 'Amplitude/$\SI{}{\milli V}$'
set xlabel 'Pulslänge \texttt{A_len}/$\SI{}{\micro s}$'
set key bottom left

m1=1400
c1=0.1
b1=0.657
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
set key top right
set ylabel 'Auslenkung/\SI{}{V}'
set xlabel 'Zeit t/\SI{}{\micro s}'
plot opt_sig_dat using ($1*1e3):2 with lines title 'FID'

######
# T1 #
######

reset

set term cairolatex
set grid
set key box bottom right width 3
set datafile separator " "

s_zurück_dat = '../data/sättigungszurückgewinnung'
p_zurück_dat = '../data/polarisationszurückgewinnung'

set xlabel 'Zeit $\tau$/ms'
set ylabel 'Amplitude/mV'

MS(x) = MS0 * (1 - exp(-x/T1S)) # x = tau
MS0 = 1400
T1S = 10
fit MS(x) s_zurück_dat u 1:2:(50) via MS0,T1S

set output '../latex/s_zurück.tex'
plot s_zurück_dat u 1:2:(50) with yerrorbars ps .5 pt 13 title 'FID',\
        MS(x) title 'SZG Fit'

MP(x) = MP0 * (1 - 2 * exp(-x/T1P)) # x = tau
MP0 = 400
T1P = 10
fit MP(x) p_zurück_dat u 1:2:(50) every 1::8 via MP0,T1P

set yrange[0:1600]
set output '../latex/p_zurück.tex'
plot p_zurück_dat u 1:2:(50) with yerrorbars ps .5 pt 13 title 'FID',\
        MP(x) title 'PZG Fit'

#########
# T_2^* #
#########

reset 

set term cairolatex
set grid
set key box top right width 1 height 1
set datafile separator ","

T2eff_dat = '../data/print_001.csv'
T2hom_dat = '../data/hahn_spinecho_sequenz'
T2cp_dat = '../data/print_002.csv' # carr purcell
T2mg_dat = '../data/print_003.csv' # meiboom gill

set xlabel 'Zeit/ms'
set ylabel 'Amplitude/V'

MT2eff(x) = MT2eff0 * exp(-x/T2eff) # x = tau
MT2eff0 = 1000
T2eff = 1
fit MT2eff(x) T2eff_dat u ($1*1e3):2 every 1::320::1000 via MT2eff0,T2eff

set yrange[-.1:2]
set output '../latex/T2eff.tex'
plot T2eff_dat u ($1*1e3):2 pt 0 title 'FID',\
        MT2eff(x) title '$T_2^*$ Fit'

set datafile separator " "
set yrange[100:1100]
set xrange[0:55]
set key box top right width 2 height 1

set ylabel 'Amplitude/mV'

MT2hom(x) = MT2hom0 * exp(-x/T2hom) # x = tau
MT2hom0 = 500
T2hom = 10
fit MT2hom(x) T2hom_dat u 1:2:(20) via MT2hom0,T2hom

set output '../latex/T2hom.tex'
plot T2hom_dat u 1:2:(20) with yerrorbars pt 13 title 'FID Echo',\
        MT2hom(x) title '$T_2$ Fit'

###########
# CP & MG #
###########

reset

set term cairolatex
set grid
set key box top right width 2 height 1

set xlabel 'Zeit/ms'
set ylabel 'Amplitude/V'

set datafile separator ","
cp_dat = '../data/print_002.csv'
mg_dat = '../data/print_003.csv'
cp_max_dat = '../data/cp'
mg_max_dat = '../data/mg'
cp_Q_dat = '../data/print_004.csv'
mg_Q_dat = '../data/print_005.csv'

cp(x) = cp0 * exp(-x/T2cp)
cp0 = 10
T2cp = 20
fit cp(x) cp_max_dat u 1:2:(.2) via cp0,T2cp

set output '../latex/cp.tex'
plot cp_dat u ($1*1e3):2 every 1::3::1002 pt 0 title 'CP Sequenz',\
        cp_max_dat u 1:2:(.2):(.05) with xyerrorbars pt 13 ps .3 title 'CP Maxima',\
        cp_Q_dat u ($1*1e3):4 every 1::3::1002 pt 0 title 'Q--Signal',\
        cp(x) title 'CP Fit'

mg(x) = mg0 * exp(-x/T2mg)
mg0 = 10
T2mg = 20
fit mg(x) mg_max_dat u 1:2:(.2) via mg0,T2mg

set output '../latex/mg.tex'
plot mg_dat u ($1*1e3):2 every 1::3::1002 pt 0 title 'MG Sequenz',\
        mg_max_dat u 1:2:(.2):(.05) with xyerrorbars pt 13 ps .3 title 'MG Maxima',\
        mg_Q_dat u ($1*1e3):4 every 1::3::1002 pt 0 title 'Q--Signal',\
        mg(x) title 'MG Fit'

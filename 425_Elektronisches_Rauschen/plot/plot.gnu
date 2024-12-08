set term cairolatex standalone
set pointintervalbox 0

file = '../data/john_noise.dat'
set output 'test.tex'

set logscale xy 10
plot file using 1:($3/(600*$2)**2*10)

file = '../data/processed_eff_band.dat'
set output 'eff_band.tex'

set fit errorvariables
f1=1e2
f2=0
f(x)=(1+(x/f1)**4)**(-1/2)
g(x)=(x/f2)**2*(1+(x/f2)**4)**(-1/2)
#fit f(x) file using 1:2:3 yerrors via f1
#fit g(x) file using 1:2:3 yerrors via f2

unset logscale xy
set logscale x 10
plot file using 1:2:3 with yerrorbars,\
  f(x),\
  g(x)


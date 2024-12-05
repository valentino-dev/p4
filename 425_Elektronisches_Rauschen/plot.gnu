set term cairolatex standalone

file = 'data/john_noise.dat'
set output 'test.tex'

set logscale xy 10
plot file using 1:($3/(600*$2)**2*10)


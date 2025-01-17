set term cairolatex #standalone header '\usepackage{siunitx}'
set pointintervalbox 0

set format y '%.0s\cdot10^{%T}'
set format y2 '%.0s\cdot10^{%T}'
set format x '%.0s\cdot10^{%T}'
set xrange [0:20000]
set y2label 'Äquivalenzbreite$/\SI{}{m}$'
set ylabel '$\frac{n_2}{n}/\textrm{a.u.}$'
set xlabel 'Temperatur $T/\SI{}{K}$'
set title 'Relative H$\alpha$ Zustandszahl von Sternen'
set key top right
set samples 1000
set y2tics
set ytics
set grid
set output 'äquivalenzbreiten.tex'


pe=2e10
h=6.626e-34
m=1.672e-27
k=1.38e-23
chi=13.54*1.602e-19
lamthe(x)=h/sqrt(2*3.141*m*k*x)
Z(x)=2*exp(chi/(2*k*x))+8*exp(chi/(4*k*x))
n2(x)=8*pe*lamthe(x)**3*exp(chi/(4*k*x))/(4*k*x+pe*lamthe(x)**3*Z(x))
print n2(8000)
plot '../data/processed/äquivalenzbreiten.dat' using 1:2:3 w yerrorbars pt 26 title 'Datenpunkte' axis x1y2,\
  n2(x) axis x1y1 title 'Theorie'

set term cairolatex #standalone header '\usepackage{siunitx}'
set pointintervalbox 0

array stars_path[5]
stars_path[1]='109358-G0'
stars_path[2]='134083-F5'
stars_path[3]='21428-B3'
stars_path[4]='29488-A5'
stars_path[5]='60179-A1'

set grid
set xlabel 'Wellenlänge $\lambda/\SI{}{m}$'
set ylabel 'Amplitude$/\textrm{a.u.}$'
set format y '$%.0s\cdot10^{%T}$'
set format x '$%.0s\cdot10^{%T}$'
set xrange [656e-9-10e-9:656e-9+10e-9]
set samples 1000
set key bottom right
do for[i=1:5]{
  set output stars_path[i].'_gauss.tex'
  stats '../data/processed/'.stars_path[i].'_gauss_params.dat' using 1 every ::0::0 nooutput
  chi = STATS_min
  set title 'H$\alpha$(\SI{656}{nm})-Linie von '.stars_path[i].' mit $\chi^2/\textrm{ddof}=\SI{'.sprintf('%.2E', chi).'}{}$'

  stats '../data/processed/'.stars_path[i].'_gauss_params.dat' using 1 every ::1::1 nooutput
  a0 = STATS_min
  stats '../data/processed/'.stars_path[i].'_gauss_params.dat' using 1 every ::2::2 nooutput
  a1 = STATS_min
  stats '../data/processed/'.stars_path[i].'_gauss_params.dat' using 1 every ::3::3 nooutput
  a2 = STATS_min
  stats '../data/processed/'.stars_path[i].'_gauss_params.dat' using 1 every ::4::4 nooutput
  c = STATS_min

  f(x)=c-a0*exp(-(x-a1)**2/2/a2**2)
  
  plot '../data/processed/'.stars_path[i].'_spectra.dat' using 2:1 with linespoint lw 1 pt 0 title 'Datenpunkte',\
  f(x) title 'Anpassung $G_\text{f}(x)$'
}

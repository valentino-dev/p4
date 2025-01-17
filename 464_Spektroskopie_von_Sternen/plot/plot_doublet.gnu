set term cairolatex #standalone header '\usepackage{siunitx}'
set pointintervalbox 0

array stars_path[1]
stars_path[1] = 'Si3'

set grid
set xlabel 'Wellenlänge $\lambda/\SI{}{m}$'
set ylabel 'Amplitude$/\textrm{a.u.}$'
set format y '%.0s\cdot10^{%T}'
set format x '%.0s\cdot10^{%T}'
set samples 1000
set key top right
do for[i=1:1]{
  print stars_path[1]
  set output 'P-Cygni_'.stars_path[i].'_doublet.tex'
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::0::0 nooutput
  chi = STATS_min
  set title 'Doublet von '.stars_path[i].' mit $\chi^2/\textrm{ddof}=\SI{'.sprintf('%.2E', chi).'}{}$'


  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::2::2 nooutput
  a0 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::3::3 nooutput
  a1 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::4::4 nooutput
  a2 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::5::5 nooutput
  c = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::6::6 nooutput
  b0 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::7::7 nooutput
  b1 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_doublet_params.dat' using 1 every ::8::8 nooutput
  b2 = STATS_min

  f(x)=c+a0*exp(-(x-a1)**2/2/a2**2)+b0*exp(-(x-b1)**2/2/b2**2)
  plot '../data/processed/P-Cygni_'.stars_path[i].'_doublet.dat' using 1:2 with linespoint lw 1 pt 0 title 'Datenpunkte',\
    f(x) title 'Anpassung $G_\text{f}(x)$'
  
}

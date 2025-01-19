set term cairolatex #standalone header '\usepackage{siunitx}'
set pointintervalbox 0

array stars_path[5]
stars_path[1]='109358-G0'
stars_path[2]='134083-F5'
stars_path[3]='21428-B3'
stars_path[4]='29488-A5'
stars_path[5]='60179-A1'

set grid
set xlabel 'Pixelkoordinate$/\textrm{Pixel}$'
set ylabel 'Amplitude$/\textrm{a.u.}$'
set format y '$%.0s\cdot10^{%T}$'
set title 'Spektrum'
do for[i=1:5]{
  set output stars_path[i].'_data.tex'
  plot '../data/processed/'.stars_path[i].'.dat' using 0:1 title stars_path[i] with linespoint lw 1 pt 0,\
  '../data/processed/'.stars_path[i].'.dat' using 0:2 title 'Kalibrationslampe' with linespoint lw 1 pt 0 
}




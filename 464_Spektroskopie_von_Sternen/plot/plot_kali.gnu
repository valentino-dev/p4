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
set ylabel 'Wellenlänge $\lambda/\SI{}{m}$'
set format y '%.0s\cdot10^{%T}'
do for[i=1:5]{
  set output stars_path[i].'_kali.tex'
  stats '../data/processed/'.stars_path[i].'_kali_params.dat' using 1 every ::0::0 nooutput
  chi = STATS_min
  set title 'Kalibraiton des '.stars_path[i].' Spektrums mit $\chi^2/\textrm{ddof}=\SI{'.sprintf('%.2E', chi).'}{}$'
  stats '../data/processed/'.stars_path[i].'_kali_params.dat' using 1 every ::1::1 nooutput
  a = STATS_min
  stats '../data/processed/'.stars_path[i].'_kali_params.dat' using 1 every ::2::2 nooutput
  b = STATS_min

  f(x)=a*x+b
  
  plot '../data/processed/'.stars_path[i].'_kali.dat' using 1:2 pt 26 title 'Datenpunkte',\
  f(x) title 'Anpassung $\lambda_\text{f}(x)$'
}

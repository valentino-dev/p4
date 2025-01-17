set term cairolatex #standalone header '\usepackage{siunitx}'
set pointintervalbox 0


array stars_path[3]
stars_path[1]='N2'
stars_path[2]='He2'
stars_path[3]='H'

set grid
set xlabel 'Wellenlänge $\lambda/\SI{}{m}$'
set ylabel 'Amplitude$/\textrm{a.u.}$'
set format y '%.0s\cdot10^{%T}'
set format x '%.0s\cdot10^{%T}'
set samples 1000
set key top right
do for[i=1:3]{

  set output 'P-Cygni_'.stars_path[i].'_gauss.tex'
  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::0::0 nooutput
  chi = STATS_min
  set title 'Spektrallinie von '.stars_path[i].' mit $\chi^2/\textrm{ddof}=\SI{'.sprintf('%.2E', chi).'}{}$'

  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::1::1 nooutput
  v = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 2 every ::1::1 nooutput
  v_err = STATS_min

  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::2::2 nooutput
  blaue_kante = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 2 every ::2::2 nooutput
  blaue_kante_err = STATS_min

  if (i==1){
    a=110e3
    b=30e3
    set xtics 666e-9,1e-9,670e-9
  }
  if (i==2){
    a=48e3
    b=36e3
    set xtics 646e-9,1e-9,651e-9
  }
  if (i==3){
    a = 1e6
    b = 0
    set xtics 646e-9,3e-9,668e-9
  }
    set arrow from (blaue_kante-blaue_kante_err),(a) to (blaue_kante-blaue_kante_err),(b) nohead lc rgb 'blue' dt 3
    set arrow from (blaue_kante+blaue_kante_err),(a) to (blaue_kante+blaue_kante_err),(b) nohead lc rgb 'blue' dt 3
    set arrow from (blaue_kante),(a) to (blaue_kante),(b) nohead lc rgb 'blue'


  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::3::3 nooutput
  c = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::4::4 nooutput
  a0 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::5::5 nooutput
  a1 = STATS_min
  stats '../data/processed/P-Cygni_'.stars_path[i].'_params.dat' using 1 every ::6::6 nooutput
  a2 = STATS_min

  f(x)=c+a0*exp(-(x-a1)**2/2/a2**2)
  plot '../data/processed/P-Cygni_'.stars_path[i].'.dat' using 1:2 with linespoint lw 1 pt 0 title 'Datenpunkte',\
    f(x) title 'Anpassung $G_\text{f}(x)$'
  
}

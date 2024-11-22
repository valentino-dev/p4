set term cairolatex standalone header '\usepackage{siunitx}'

array data[6]
data[1] = '../data/ps_305nm.dat'
data[2] = '../data/ps_365nm.dat'
data[3] = '../data/ps_365nm_großeBlende.dat'
data[4] = '../data/ps_436nm.dat'
data[5] = '../data/ps_546nm.dat'
data[6] = '../data/ps_578nm.dat'

array filename[6]
filename[1] = '305nm.tex'
filename[2] = '365nm.tex'
filename[3] = '365nmGB.tex'
filename[4] = '436nm.tex'
filename[5] = '546nm.tex'
filename[6] = '578nm.tex'



i = 1
set output filename[i]
data_path = data[i]
I0=-13.6
I0err=1.0
threashhold=0.7
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -6
set border black
set xrange [-2.5:0.1]
#set yrange [-0.5:80]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
set title sprintf('$\lambda=\SI{305}{\nano m}$: $U_0=\SI{%.4f +- %.4f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', -b/m, sqrt((b_err/m)**2+(b/m**2*m_err)**2), FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(x)=\SI{%.3f +- %.3f}{}\cdot U_G + \SI{%.3f +- %.3f}{\milli V}$', m, m_err, b, b_err)




i = 2
set output filename[i]
data_path = data[i]
I0=-22.5
I0err=1.0
threashhold=1.4
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -6
set border black
set xrange [-2.5:0.1]
#set yrange [-0.5:80]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
set title sprintf('$\lambda=\SI{365}{\nano m}$: $U_0=\SI{%.3f +- %.3f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', -b/m, sqrt((b_err/m)**2+(b/m**2*m_err)**2), FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(U_G)=\SI{%.3f +- %.3f}{}\cdot U_G + \SI{%.3f +- %.3f}{\milli V}$', m, m_err, b, b_err)



i = 3
set output filename[i]
data_path = data[i]
I0=-146.0
I0err=4.0
threashhold=1.4
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -6
set border black
set xrange [-2.5:0.1]
#set yrange [-0.5:80]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
set title sprintf('$\lambda=\SI{365}{\nano m}$(GB): $U_0=\SI{%.2f +- %.2f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', -b/m, sqrt((b_err/m)**2+(b/m**2*m_err)**2), FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(U_G)=\SI{%.1f +- %.1f}{}\cdot U_G + \SI{%.1f +- %.1f}{\milli V}$', m, m_err, b, b_err)




i = 4
set output filename[i]
data_path = data[i]
I0=-13.1
I0err=1.0
threashhold=0.9
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -8
set border black
set xrange [-2.5:0.1]
set yrange [-0.5:10]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
set title sprintf('$\lambda=\SI{436}{\nano m}$: $U_0=\SI{%.3f +- %.3f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', -b/m, sqrt((b_err/m)**2+(b/m**2*m_err)**2), FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(U_G)=\SI{%.2f +- %.2f}{}\cdot U_G + \SI{%.3f +- %.3f}{\milli V}$', m, m_err, b, b_err)



i = 5
set output filename[i]
data_path = data[i]
I0=-18
I0err=1.0
threashhold=0.17
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -8
set border black
set xrange [-2.5:0.1]
set yrange [-0.5:10]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
set title sprintf('$\lambda=\SI{546}{\nano m}$: $U_0=\SI{%.4f +- %.4f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', -b/m, sqrt((b_err/m)**2+(b/m**2*m_err)**2), FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(U_G)=\SI{%.2f +- %.2f}{}\cdot U_G + \SI{%.3f +- %.3f}{\milli V}$', m, m_err, b, b_err)


i = 6
set output filename[i]
data_path = data[i]
I0=-6.0
I0err=1.0
threashhold=0.3
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -8
set border black
set xrange [-2.5:0.1]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
set title sprintf('$\lambda=\SI{578}{\nano m}$: $U_0=\SI{%.3f +- %.3f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', -b/m, sqrt((b_err/m)**2+(b/m**2*m_err)**2), FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(U_G)=\SI{%.2f +- %.2f}{}\cdot U_G + \SI{%.3f +- %.3f}{\milli V}$', m, m_err, b, b_err)







set output 'Austritsarbeit.tex'
set grid
set ylabel '$U_0/\SI{}{V}$'
set xlabel '$\nu / \SI{}{10^{14} Hz}$'
set key bottom right box opaque width -5 height 1
#set xrange [0:600]
unset xrange
unset yrange
f(x)=m*x+b
set fit errorvariables
fit f(x) '../data/ps_U0.dat' using (3e8/$1*1e-14):2:3 yerrors via m, b
set title sprintf('$W_A=\SI{%.2f +- %.2f}{eV}$, $\text{h}=\SI{%.4f +- %.4f }{eVs} \cdot 10^{-15} $ und $\chi^2/\text{ddof}=%.3f$', b, b_err, m*1e-1, m_err*1e-1, FIT_STDFIT**2)
plot '../data/ps_U0.dat' using (3e8/$1*1e-14):2:3 w yerrorbars title '$U_0$ Datenpunkte',\
  f(x)>0?f(x):1/0 title sprintf('$f(\nu)=\SI{%.3f +- %.3f}{V/\ 10^{14} Hz}\cdot \nu \SI{%.2f +- %.2f}{V}$', m, m_err, b, b_err)






set output 'Gitterkonstante.tex'
set grid
set xlabel '$\lambda/\SI{}{\nano m}$'
set ylabel '$[\sin{(\omega_G)}+\sin{(\omega_G+\omega_B-\SI{180}{\degree})}]/\SI{}{rad}$'
set key bottom right box opaque width +1

winkel_B = 130.0
winkel_B_err = 0.5

f(x)=x/g
set fit errorvariables
fit f(x) '../data/Balmer_Justage.dat' using 4:(sin($2/180*3.14)+sin((-180+winkel_B+$2)/180*3.14)):(sqrt(((cos($2/180*3.14)+cos((-180+$2+winkel_B)/180*3.14))*$3/180*3.14)**2+(cos((180-$2-winkel_B)/180*3.14)*winkel_B_err/180*3.14)**2)) yerrors via g
set title sprintf('$g=\SI{%.0f +- %.0f}{\angstrom}$ und $\chi^2/\text{ddof}=%.3f$', g*1e1, g_err*1e1, FIT_STDFIT**2)
plot '../data/Balmer_Justage.dat' using 4:(sin($2/180*3.14)+sin((-180+winkel_B+$2)/180*3.14)):(sqrt(((cos($2/180*3.14)+cos((-180+$2+winkel_B)/180*3.14))*$3/180*3.14)**2+(cos((180-$2-winkel_B)/180*3.14)*winkel_B_err/180*3.14)**2)) w yerrorbars title 'data' pt 0,\
  f(x) title sprintf('$f(\lambda)=\frac{\lambda}{\SI{%.0f +- %.0f}{\angstrom}}$', g*1e1, g_err*1e1)


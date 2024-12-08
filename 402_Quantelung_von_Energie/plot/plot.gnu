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

array U0[6]
array U0_err[6]


set pointintervalbox 0 # https://stackoverflow.com/questions/77344492/white-background-in-gnuplot-data-points ; removes white space around point which is drawn over the errorbar making it invisible for small errors


i = 1
set output filename[i]
data_path = data[i]
I0=-13.6
I0err=1.0
threashhold=0.7
set grid
set ylabel '$\sqrt{I-I_0}$/mV'
set xlabel '$U_G$/V'
set key top left box opaque width -6 height 1
set border black
set xrange [-2.5:0.1]
#set yrange [-0.5:80]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
U0[i]=-b/m
U0_err[i]=sqrt((b_err/m)**2+(b/m**2*m_err)**2)
set title sprintf('$\lambda=\SI{305}{\nano m}$: $U_0=\SI{%.4f +- %.4f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', U0[i], U0_err[i], FIT_STDFIT**2)
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
set key top left box opaque width -6 height 1
set border black
set xrange [-2.5:0.1]
#set yrange [-0.5:80]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
U0[i]=-b/m
U0_err[i]=sqrt((b_err/m)**2+(b/m**2*m_err)**2)
set title sprintf('$\lambda=\SI{365}{\nano m}$: $U_0=\SI{%.3f +- %.3f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', U0[i], U0_err[i], FIT_STDFIT**2)
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
set key top left box opaque width -6 height 1
set border black
set xrange [-2.5:0.1]
#set yrange [-0.5:80]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
U0[i]=-b/m
U0_err[i]=sqrt((b_err/m)**2+(b/m**2*m_err)**2)
set title sprintf('$\lambda=\SI{365}{\nano m}$(GB): $U_0=\SI{%.2f +- %.2f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', U0[i], U0_err[i], FIT_STDFIT**2)
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
set key top left box opaque width -8 height 1
set border black
set xrange [-2.5:0.1]
set yrange [-0.5:10]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
U0[i]=-b/m
U0_err[i]=1e-3*sqrt((b_err/m)**2+(b/m**2*m_err)**2)
set title sprintf('$\lambda=\SI{436}{\nano m}$: $U_0=\SI{%.3f +- %.3f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', U0[i], U0_err[i], FIT_STDFIT**2)
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
set key top left box opaque width -8 height 1
set border black
set xrange [-2.5:0.1]
set yrange [-0.5:10]
m=8
b=8
f(x)=m*x+b
set fit errorvariables
fit f(x) data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) xyerrors via m, b
U0[i]=-b/m
U0_err[i]=1e-3*sqrt((b_err/m)**2+(b/m**2*m_err)**2)
set title sprintf('$\lambda=\SI{546}{\nano m}$: $U_0=\SI{%.4f +- %.4f}{mV}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', U0[i], U0_err[i], FIT_STDFIT**2)
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
U0[i]=-b/m
U0_err[i]=1e-3*sqrt((b_err/m)**2+(b/m**2*m_err)**2)
set title sprintf('$\lambda=\SI{578}{\nano m}$: $U_0=\SI{%.3f +- %.3f}{V}$ und $\chi^2/\text{ddof}=\SI{%.3f}{}$', U0[i], U0_err[i], FIT_STDFIT**2)
plot data_path using ($1<threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'quadratische Datenpunkte' pt 0,\
  data_path using ($1>threashhold?$1*(-1):1/0):(sqrt($2-I0)):($4):(sqrt(($3)**2+I0err**2)/sqrt($2-I0)) w xyerrorbars title 'nicht quadratische Datenpunkte' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(U_G)=\SI{%.2f +- %.2f}{}\cdot U_G + \SI{%.3f +- %.3f}{\milli V}$', m, m_err, b, b_err)




#array wellenlängen[6]
#wellenlängen[1] = 305e-9
#wellenlängen[2] = 365e-9
#wellenlängen[3] = 436e-9
#wellenlängen[4] = 546e-9
#wellenlängen[5] = 578e-9

#set table '../data/ps_U0.dat'
#  plot sample [i=1:6] '+' using (wellenlänge[i]):(U0[i]):(U0_err[i]) w table
#unset table


set output 'Austrittsarbeit.tex'
set grid
set ylabel '$U_0/\SI{}{V}$'
set xlabel '$\nu / \SI{}{10^{14} Hz}$'
set key top left box opaque width -6 height 1
#set xrange [0:600]
unset xrange
unset yrange
f(x)=m1*x+b1
g(x)=m2*x+b2
set fit errorvariables
fit g(x) '../data/ps_U0.dat' using (3e8/$1*1e-14):2:3 yerrors via m2, b2
fit f(x) '../data/ps_U0.dat' using (3e8/($1>350e-9?$1:1/0)*1e-14):2:3 yerrors via m1, b1
set title sprintf('$W_{A,f}=\SI{%.2f +- %.2f}{eV}$, $\text{h}_f=\SI{%.2f +- %.2f }{eVs} \cdot 10^{-15} $ und $\chi^2_f/\text{ddof}=\SI{%.3f}{}$', b1, b1_err, m2*1e1, m2_err*1e1, FIT_STDFIT**2)
plot '../data/ps_U0.dat' using (3e8/($1>350e-9?$1:1/0)*1e-14):2:3 w yerrorbars title '' pt 0,\
  '../data/ps_U0.dat' using (3e8/($1<350e-9?$1:1/0)*1e-14):2:3 w yerrorbars title '' pt 0,\
  f(x)>0?f(x):1/0 title sprintf('$f(\nu)=\SI{%.3f +- %.3f}{V/\ 10^{14} Hz}\cdot \nu \SI{%.2f +- %.2f}{V}$', m1, m1_err, b1, b1_err),\
  g(x)>0?g(x):1/0 title sprintf('$g(\nu)=\SI{%.3f +- %.3f}{V/\ 10^{14} Hz}\cdot \nu \SI{%.2f +- %.2f}{V}$', m2, m2_err, b2, b2_err)




exit

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
set title sprintf('$g=\SI{%.0f +- %.0f}{\text{\r{A}}^{-1}}$ und $\chi^2/\text{ddof}=%.3f$', g*1e1, g_err*1e1, FIT_STDFIT**2)
plot '../data/Balmer_Justage.dat' using 4:(sin($2/180*3.14)+sin((-180+winkel_B+$2)/180*3.14)):(sqrt(((cos($2/180*3.14)+cos((-180+$2+winkel_B)/180*3.14))*$3/180*3.14)**2+(cos((180-$2-winkel_B)/180*3.14)*winkel_B_err/180*3.14)**2)) w yerrorbars title 'data' pt 0,\
  f(x) title sprintf('$f(\lambda)=\frac{\lambda}{\SI{%.0f +- %.0f}{\text{\r{A}}}}$', g*1e1, g_err*1e1)


set output "ccdrot.tex"
set xrange [-0.1:0.1]
set yrange [0:100]
set title 'Isotopieaufspaltung von Wasserstoff und Deuterium bei $\lambda=\SI{656}{\nano m}$'
set key top left box opaque width +2
set grid
set xlabel 'relativer Winkel $\Delta\omega_G/\SI{}{\degree}$'
set ylabel 'Intensität $I/\%$'
g=10
b1=90
b2=70
a1=1e-4
a2=1e-4
c1=-0.01
c2=0.025

f(x)=(b1*exp(-(x-c1)**2/a1)+b2*exp(-(x-c2)**2/a2))+g
data_path = '../data/ccd_rot.dat'
fit f(x) data_path via a1, a2, b1, b2, c1, c2, g
plot data_path using 1:2 w lines title 'Rote Aufspaltung',\
  f(x)


set output "ccdtuerkis.tex"
set xrange [-0.1:0.1]
set yrange [0:100]
set title 'Isotopieaufspaltung von Wasserstoff und Deuterium bei $\lambda=\SI{486}{\nano m}$'
set key bottom center box opaque width +1
set grid
set xlabel 'relativer Winkel $\Delta\omega_G/\SI{}{\degree}$'
set ylabel 'Intensität $I/\%$'
g=10
b1=90
b2=70
a1=1e-4
a2=1e-4
c1=-0.01
c2=0.025

f(x)=(b1*exp(-(x-c1)**2/a1)+b2*exp(-(x-c2)**2/a2))+g
data_path = '../data/ccd_tuerkis.dat'
fit f(x) data_path via a1, a2, b1, b2, c1, c2, g
plot data_path using 1:2 w lines title 'Turkisfarbene Aufspaltung',\
  f(x)

set output "ccdvioletschwach.tex"
set xrange [-0.1:0.1]
set yrange [0:100]
set title 'Isotopieaufspaltung von Wasserstoff und Deuterium bei $\lambda=\SI{434}{\nano m}$'
set key top left box opaque
set grid
set xlabel 'relativer Winkel $\Delta\omega_G/\SI{}{\degree}$'
set ylabel 'Intensität $I/\%$'
g=10
b1=90
b2=70
a1=1e-4
a2=1e-4
c1=-0.01
c2=0.025

f(x)=(b1*exp(-(x-c1)**2/a1)+b2*exp(-(x-c2)**2/a2))+g
data_path = '../data/ccd_violet_schwach.dat'
fit f(x) data_path via a1, a2, b1, b2, c1, c2, g
plot data_path using 1:2 w lines title 'Violetfarbene (schwache) Aufspaltung',\
  f(x)

set output "ccdvioletstark.tex"
set xrange [-0.1:0.1]
set yrange [0:100]
set title 'Isotopieaufspaltung von Wasserstoff und Deuterium bei $\lambda=\SI{410}{\nano m}$'
set key top left box opaque
set grid
set xlabel 'relativer Winkel $\Delta\omega_G/\SI{}{\degree}$'
set ylabel 'Intensität $I/\%$'
g=10
b1=90
b2=70
a1=1e-4
a2=1e-4
c1=-0.01
c2=0.025

f(x)=(b1*exp(-(x-c1)**2/a1)+b2*exp(-(x-c2)**2/a2))+g
data_path = '../data/ccd_violet_stark.dat'
fit f(x) data_path via a1, a2, b1, b2, c1, c2, g
plot data_path using 1:2 w lines title 'Violetfarbene (starke) Aufspaltung',\
  f(x)

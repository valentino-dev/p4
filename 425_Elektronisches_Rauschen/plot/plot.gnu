set term cairolatex standalone header '\usepackage{siunitx}'
set pointintervalbox 0


# Voreinschätzung für 5.4
file = '../data/john_noise.dat'
set output 'test.tex'

set logscale xy 10
plot file using 1:($3/(600*$2)**2*10)


# 5.2
file = '../data/processed_eff_band.dat'
set output 'eff_band.tex'
#plot x**2

set fit errorvariables

f1=1e4
f(x)=1/sqrt(1+(x/f1)**4)
fit f(x) file using ($1>1000?$1:1/0):2:3 yerrors via f1

f2=1e2
g(x)=(x/f2)**2/sqrt(1+(x/f2)**4)
fit g(x) file using ($1<1000?$1:1/0):2:3 yerrors via f2

unset logscale xy
set logscale x 10
set grid
set ylabel 'Verstärkung $\frac{U_{\text{RMS}}}{U_{0\text{, RMS}}}$'
set xlabel 'Frequenz $f/\SI{}{Hz}$'
plot file using ($1<1000?$1:1/0):2:3 with yerrorbars title 'Hochpass Dominiert' pt 0,\
  file using ($1>1000?$1:1/0):2:3 with yerrorbars title 'Tiefpass Dominiert' pt 0,\
  f(x) title 'Hochpass Modell $f_h=\SI{10}{\kilo Hz}$',\
  (g(x)<1?g(x):1/0) title 'Tiefpass Modell $f_l=\SI{100}{Hz}$'



# 5.3
file = '../data/john_noise.dat'
set output 'Widerstandsabhängigkeit.tex'

unset logscale xy
set logscale xy 10

set grid
set key bottom right opaque box width +2
set xlabel 'Widerstand $R/\SI{}{\Omega}$'
set ylabel 'Spannungsquadrat $V_{\text{meter}}\frac{\SI{10}{V}}{(600\cdot G_2)^2}/\SI{}{V^2}$'
m=0
b=0
f(x)=m*x+b
fit f(x) file using ($1<=1e5?$1:1/0):($3/600**2/$2**2*10):($4/600**2/$2**2*10) yerrors via m,b
#fit f(x) file using 1:($3/600**2/$2**2*10):($4/600**2/$2**2*10) yerrors via m,b

plot file using 1:($3/600**2/$2**2*10):($4/600**2/$2**2*10) w yerrorbars title 'Daten' pt 0,\
  (f(x)<4e-10?f(x):1/0) title 'Anpassung'

T=20.8+273.15
T_err=0.2
df=11107
#df=1e4-1e2
df_err=60
print 'kb'
print m/T/4/df # k_b
print sqrt((m_err/T/4/df)**2+(m/T**2/4/df*T_err)**2+(m/T/4/df**2*df_err)**2) # k_b_err


# 5.4
file = '../data/john_band.dat'
set output 'Bandbreitenabhängigkeit.tex'
set logscale xy 10
unset ylabel
unset xlabel
set xlabel '$\Delta f_{\text{eff}}=\frac{f_l^4\pi (f_l-f_h)}{2^{3/2}(f_l^4-f_h^4)}/\SI{}{Hz}$'
set ylabel 'Spannungsquadrat $V_{\text{meter}}\frac{\SI{10}{V}}{(600\cdot G_2)^2}/\SI{}{V^2}$'

df(a, b)=a**4*3.141*(a-b)/(sqrt(2**3)*(a**4-b**4))
f(x)=m*x+b
fit f(x) file using (df($1, $2)):($4/600**2/$3**2*10):($5/600**2/$3**2*10) yerrors via m, b

plot file using (df($1, $2)):($4/600**2/$3**2*10):($5/600**2/$3**2*10) w yerrorbars title '$V_\text{Rauschen}$',\
  f(x) title 'Anpassung'
R=1e3
print 'kb'
print m/4/T/R # k_b
print sqrt((m/(4*T**2*R)*T_err)**2+(m_err/(4*T*R))**2) # k_b_err


# 6.3
set grid
file = '../data/shot_noise_idc.dat'
set output 'idc.tex'
unset logscale
unset ylabel
unset xlabel
set xlabel '$i_{\text{dc}}=-\frac{V_{\text{monitor}}}{R_f}$'
set key bottom right opaque box width +2

R_f=10e3

f(x) = m*x+b
fit f(x) file using (-$1/R_f):($3*10/(100*$2*R_f)**2):($4*10/(100*$2*R_f)**2) yerrors via m, b
plot file using (-$1/R_f):($3*10/(100*$2*R_f)**2):($4*10/(100*$2*R_f)**2) w yerrorbars title 'Daten',\
  f(x) title 'Anpassung'

df= 111051
print 'e'
print m/2/df



# 6.4
file = '../data/shot_noise_frequency.dat'
set output 'shot_freq.tex'
set xlabel 'Frequenz $f/\SI{}{\kilo Hz}$'
set ylabel '$\frac{V_{\text{meter}}\SI{10}{V}}{(100G_2R_f)^2}/\SI{}{\nano V^2}$'
set logscale yx 10
#unset logscale
set key opaque box bottom right width +2
m=1.6e-24
f(x)=m*x+b
fit f(x) file using (3.141*$1/sqrt(2)**3):($3*10/(100*$2*R_f)**2):($4*10/(100*$2*R_f)**2) via m, b
plot file using (3.141*$1/sqrt(2)**3*1e-3):($3*10/(100*$2*R_f)**2*1e18):($4*10/(100*$2*R_f)**2*1e18) w yerrorbars title 'Daten',\
  f(x*1e3)*1e18 title 'Anpassung'

I=0.711/R_f
print 'e'
print m/2/I








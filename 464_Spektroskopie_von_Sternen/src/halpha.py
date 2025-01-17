import numpy as np
import matplotlib.pyplot as plt
import scipy as sp

stars_path = ['109358-G0', '134083-F5', '21428-B3', '29488-A5', '60179-A1']
data = np.array([np.genfromtxt(f'../data/provided/{stars_path[i]}/spectra.dat', delimiter='\t') for i in range(len(stars_path))])[:,:,1:]

fig, ax = plt.subplots(len(stars_path))

for i in range(len(stars_path)):
    ax[i].set_title(stars_path[i])
    ax[i].plot(data[i,:,0]/np.max(data[i,:,0]))
    ax[i].plot(data[i,:,1]/np.max(data[i,:,1]))
#plt.show()

for i in range(len(stars_path)):
    np.savetxt(f'../data/processed/{stars_path[i]}.dat', np.array([data[i,:,0]/np.max(data[i,:,0]), data[i,:,1]/np.max(data[i,:,1])]).T)

kali_wellen=np.array([6383, 6402.2, 6416.3, 6678.3, 6752.8])*1e-10
kali_data=np.zeros((5, 5))
kali_data[0]=np.array([246, 265, 280, 545, 621])
kali_data[1]=np.array([244, 264, 278, 544, 620])
kali_data[2]=np.array([300, 319, 334, 599, 675])
kali_data[3]=np.array([73, 98, 116, 454, 551])
kali_data[4]=np.array([243, 263, 277, 543, 619])

for i in range(len(stars_path)):
    np.savetxt(f'../data/processed/{stars_path[i]}_kali.dat', np.array([kali_data[i], kali_wellen]).T)

def lmd_fct(x, a, b):
    return a*x+b
lmd_fts = [sp.optimize.curve_fit(lmd_fct, kali_data[i], kali_wellen, p0=[1.25e-10, 6.0755e-7], sigma=2e-10) for i in range(len(stars_path))]

star_spectra = np.array([data[:,:,0], [lmd_fct(np.arange(data.shape[1]), *lmd_fts[i][0]) for i in range(len(stars_path))]])
star_spectra = np.transpose(star_spectra, (1, 2, 0))


for i in range(len(stars_path)):
    np.savetxt(f'../data/processed/{stars_path[i]}_spectra.dat', star_spectra[i])
    mat = np.zeros((lmd_fts[i][0].shape[0]+1, 2))
    r = kali_wellen - lmd_fct(kali_data[i], *lmd_fts[i][0])
    mat[0, 0] = np.sum((r/2e-10)**2) / (kali_data[i].shape[0] - len(lmd_fts[i][0]))
    mat[0, 1] = 0
    mat[1:,0] = lmd_fts[i][0]
    mat[1:,1] = np.diag(lmd_fts[i][1])**(1/2)
    np.savetxt(f'../data/processed/{stars_path[i]}_kali_params.dat', mat)


def gauss_fct(x, a0, a1, a2, c):
    return c-a0*np.exp(-(x-a1)**2/2/a2**2)

fit_mask = (star_spectra[:,:,1]>6500e-10)*(star_spectra[:,:,1]<6600e-10)

p0 = np.array([[0.7e5, 6.5648e-7, 800e-12,  1.387e5],[0.8e4, 6.5648e-7, 800e-12, 1.71e4],[1.125e4, 6.5648e-7, 800e-12, 2.25e4],[0.95e4, 6.5648e-7, 800e-12, 1.91e4],[0.5e3, 6.5648e-7, 800e-12, 1.004e3]])

sigma = 1e3
gauss_fts = [sp.optimize.curve_fit(gauss_fct, star_spectra[i,:,1][fit_mask[i]], star_spectra[i,:,0][fit_mask[i]], p0=p0[i], sigma=sigma) for i in range(len(stars_path))]


for i in range(len(stars_path)):
    x = star_spectra[i,:,1][fit_mask[i]]
    y = star_spectra[i,:,0][fit_mask[i]]
    mat = np.zeros((gauss_fts[i][0].shape[0]+1, 2))
    r = y - gauss_fct(x, *gauss_fts[i][0])
    mat[0, 0] = np.sum((r/sigma)**2) / (x.shape[0] - len(gauss_fts[i][0]))
    mat[0, 1] = 0
    mat[1:,0] = gauss_fts[i][0]
    mat[1:,1] = np.diag(gauss_fts[i][1])**(1/2)
    np.savetxt(f'../data/processed/{stars_path[i]}_gauss_params.dat', mat)


fig, ax = plt.subplots(len(stars_path))
for i in range(len(stars_path)):
    print(*gauss_fts[i][0])
    ax[i].set_title(stars_path[i])
    ax[i].plot(star_spectra[i,:,1], data[i,:,0])
    ax[i].plot(star_spectra[i,:,1][fit_mask[i]], gauss_fct(star_spectra[i,:,1][fit_mask[i]], *gauss_fts[i][0]))
#plt.show()

#FWHM=2*(2*np.log(2))**(1/2)*np.array([gauss_fts[i][0][-2] for i in range(len(stars_path))])
äquivalenzbreite = np.array([gauss_fts[i][0][-2]*gauss_fts[i][0][0]/gauss_fts[i][0][-1] for i in range(len(stars_path))])*(2*3.141)**(1/2)

äquivalenzbreite_err = np.array([(gauss_fts[i][1][-2, -2]**(1/2)*gauss_fts[i][0][0]/gauss_fts[i][0][-1])**2+(gauss_fts[i][0][-2]*gauss_fts[i][1][0, 0]**(1/2)/gauss_fts[i][0][-1])**2+(gauss_fts[i][0][-2]*gauss_fts[i][0][0]/gauss_fts[i][0][-1]**2*gauss_fts[i][1][-1, -1]**(1/2))**2 for i in range(len(stars_path))])**(1/2)*(2*3.141)**(1/2)

#äquivalenzbreite_err=0
print(äquivalenzbreite)

temperatur = np.array([5943, 6528, 18000, 8306, 9250])
pe=10e9
h=6.626e-34
m=1.672e-27
k=1.38e-23
#1.85, 7.95
#chi=(np.arange(0,10)/1)*1e-23*1e5
#chi=4*1e-23*1e5
#chi=24.48*1.602e-19
chi=54.17*1.602e-19
#chi=13.54*1.602e-19
T=1e4
print(chi/(2*k*T))
def n2_fct(T, chi):
    lamthe=h/(2*3.141*m*k*T)**(1/2)
    Z=2*np.exp(chi/(2*k*T))+8*np.exp(chi/(4*k*T))
    n2=8*pe*lamthe**3*np.exp(chi/(4*k*T))/(4*k*T+pe*lamthe**3*Z)
    return n2
#popt, pcot = sp.optimize.curve_fit(n2_fct, np.array([1e5, 7500, 17500]), np.array([2.5e-6, 0.5e-6, 0.2e-6]), p0=[chi])
#chi=popt[0]
print("chi", chi)
print("10k", n2_fct(1e4, chi))
#exit()

np.savetxt(f'../data/processed/äquivalenzbreiten.dat', np.array([temperatur, äquivalenzbreite, äquivalenzbreite_err]).T)

plt.clf()
plt.errorbar(temperatur, äquivalenzbreite, äquivalenzbreite_err, fmt='none')
x = np.linspace(0, 20e3, 1000)
chi=13.54*1.602e-19
plt.plot(x, n2_fct(x, chi)/36.98e6, label=f'{chi}')
chi=24.48*1.602e-19
plt.plot(x, n2_fct(x, chi)/36.98e6, label=f'{chi}')
chi=54.17*1.602e-19
plt.plot(x, n2_fct(x, chi)/36.98e6, label=f'{chi}')
print(n2_fct(8000, chi))
#print("max", np.max(n2_fct(x, chi)))
plt.legend()
plt.show()




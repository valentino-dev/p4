import numpy as np
import matplotlib.pyplot as plt
import scipy as sp


data = np.array(np.genfromtxt(f'../data/provided/pcygni/spectra.dat', delimiter='\t'))[:,1:]

print(data.shape)

plt.plot(data[:,0])
plt.plot(data[:,1])
#plt.show()



kali_wellen=np.array([6383, 6402.2, 6416.3, 6678.3, 6752.8])*1e-10
kali_data=np.array([98, 123, 141, 479, 576])


def lmd_fct(x, a, b):
    return a*x+b
lmd_fts = sp.optimize.curve_fit(lmd_fct, kali_data, kali_wellen, p0=[1, 1], sigma=2)

star_spectra = np.array([data[:,0], lmd_fct(np.arange(data.shape[0]), *lmd_fts[0])]).T
np.savetxt(f'../data/processed/P-Cygni_spectra.dat', star_spectra)

plt.clf()
plt.plot(star_spectra[:,1], star_spectra[:,0])
#plt.show()

sigma = 2e3

lines = ['H', 'N2', 'He2']
def gauss_fct(x, c, b0, b1, b2):
    return c+b0*np.exp(-(x-b1)**2/2/b2**2)
p0 = np.array([[4.75e4, -5.8e4+8.88e5, 6.56313e-7, 6.56313e-7-6.56498e-7],[4.75e4, 5.21e4, 6.67831e-7, 0.0013e-7], [4.32e4, 0.35e4, 6.482e-7, (6.48214e-7-6.4827e-7)*1.2]])
fit_bounds = np.array([[6.56229e-7, 6.65e-7], [6.67795e-7, 6.71170e-7], [6.48176e-7, 6.51e-7]])
export_bounds = np.array([[6.56313e-7-0.1e-7,6.56313e-7+0.1e-7], [6.67831e-7-0.02e-7, 6.67831e-7+0.02e-7], [6.48214e-7-0.02e-7, 6.48214e-7+0.02e-7]])
blaue_kante, blaue_kante_err = np.array([6.55795e-7, 6.67405e-7, 6.479340e-7]), np.array([0.0003e-7, 0.00044e-7, 0.00025e-7])

for i in range(len(lines)):
    fit_mask = (star_spectra[:,1]>fit_bounds[i, 0])*(star_spectra[:,1]<fit_bounds[i, 1])
    export_mask = (star_spectra[:,1]>export_bounds[i, 0])*(star_spectra[:,1]<export_bounds[i, 1])
    x = star_spectra[:,1][fit_mask]
    y = star_spectra[:,0][fit_mask]
    gauss_fts = sp.optimize.curve_fit(gauss_fct, x, y, p0=p0[i], sigma=sigma)
    #p0[i] = gauss_fts[0]
    mitte, mitte_err = gauss_fts[0][2], gauss_fts[1][2, 2]**(1/2)
    velocity = -3e8*(blaue_kante[i]**2-mitte**2)/(blaue_kante[i]**2+mitte**2)
    velocity_err = ((-3e8*(2*blaue_kante[i]*blaue_kante_err[i])/(blaue_kante[i]**2+mitte**2)+3e8*(blaue_kante[i]**2-mitte**2)/(blaue_kante[i]**2+mitte**2)**2*2*blaue_kante[i]*blaue_kante_err[i])**2+(3e8*(mitte*2*mitte_err)/(blaue_kante[i]**2+mitte**2)+3e8*(blaue_kante[i]**2-mitte**2)/(blaue_kante[i]**2+mitte**2)**2*2*mitte*mitte_err)**2)**(1/2)

    np.savetxt(f'../data/processed/P-Cygni_{lines[i]}.dat', np.array([star_spectra[:, 1][export_mask], star_spectra[:, 0][export_mask]]).T)
    mat = np.zeros((gauss_fts[0].shape[0]+3, 2))
    r = y - gauss_fct(x, *gauss_fts[0])
    mat[0, 0] = np.sum((r/sigma)**2) / (x.shape[0] - len(gauss_fts[0]))
    mat[0, 1] = 0
    mat[1, 0] = velocity
    mat[1, 1] = velocity_err
    mat[2, 0] = blaue_kante[i]
    mat[2, 1] = blaue_kante_err[i]
    mat[3:,0] = gauss_fts[0]
    mat[3:,1] = np.diag(gauss_fts[1])**(1/2)
    np.savetxt(f'../data/processed/P-Cygni_{lines[i]}_params.dat', mat)

    xlin = np.linspace(export_bounds[i, 0], export_bounds[i, 1], 1000)

    if lines[i]=='H':

        ll=gauss_fts[0][2]
        ll_err=np.diag(gauss_fts[1])[2]**(1/2)
        lh=6.564628e-7
        lh_err=0

        velocity = -3e8*(ll**2-lh**2)/(ll**2+lh**2)
        velocity_err = ((-3e8*(2*ll*ll_err)/(ll**2+lh**2)+3e8*(ll**2-lh**2)/(ll**2+lh**2)**2*2*ll*ll_err)**2+(3e8*(lh*2*lh_err)/(ll**2+lh**2)+3e8*(ll**2-lh**2)/(ll**2+lh**2)**2*2*lh*lh_err)**2)**(1/2)
        print("H doppler: ", velocity, velocity_err)

    '''

    plt.clf()
    plt.plot(xlin, gauss_fct(xlin, *p0[i]))
    plt.scatter(star_spectra[:, 1][export_mask], star_spectra[:, 0][export_mask])
    plt.show()
    '''


def gauss_fct2(x, a0, a1, a2, c, b0, b1, b2):
    return c+a0*np.exp(-(x-a1)**2/2/a2**2)+b0*np.exp(-(x-b1)**2/2/b2**2)

doublets = ['Si3']#, 'C2']
fit_bounds= np.array([[6.32e-7, 6.4e-7]])
p0 = [[5.74e4-4.73e4, 6.34525e-7, 6.34525e-7-6.34722e-7, 4.73e4, 5.38e4-4.73e4, 6.3699e-7, 6.37182e-7-6.3699e-7]]
for i in range(len(doublets)):
    fit_mask = (star_spectra[:,1]>fit_bounds[i, 0])*(star_spectra[:,1]<fit_bounds[i, 1])
    x = star_spectra[:,1][fit_mask]
    y = star_spectra[:,0][fit_mask]
    gauss_fts = sp.optimize.curve_fit(gauss_fct2, x, y, p0=p0[i], sigma=sigma)
    p0[i] = gauss_fts[0]
    plt.plot(x, y)
    plt.plot(x, gauss_fct2(x, *p0[i]))
    #plt.show()
    gauss_fts_err = np.diag(gauss_fts[1])**(1/2)
    lh, ll = gauss_fts[0][1], gauss_fts[0][5]
    lh_err, ll_err = gauss_fts_err[1], gauss_fts_err[5]
    velocity = -3e8*(ll**2-lh**2)/(ll**2+lh**2)
    velocity_err = ((-3e8*(2*ll*ll_err)/(ll**2+lh**2)+3e8*(ll**2-lh**2)/(ll**2+lh**2)**2*2*ll*ll_err)**2+(3e8*(lh*2*lh_err)/(ll**2+lh**2)+3e8*(ll**2-lh**2)/(ll**2+lh**2)**2*2*lh*lh_err)**2)**(1/2)

    np.savetxt(f'../data/processed/P-Cygni_{doublets[i]}_doublet.dat', np.array([star_spectra[:, 1][fit_mask], star_spectra[:, 0][fit_mask]]).T)
    mat = np.zeros((gauss_fts[0].shape[0]+2, 2))
    r = y - gauss_fct2(x, *gauss_fts[0])
    mat[0, 0] = np.sum((r/sigma)**2) / (x.shape[0] - len(gauss_fts[0]))
    mat[0, 1] = 0
    mat[1, 0] = velocity
    mat[1, 1] = velocity_err
    mat[2:,0] = gauss_fts[0]
    mat[2:,1] = gauss_fts_err 
    np.savetxt(f'../data/processed/P-Cygni_{doublets[i]}_doublet_params.dat', mat)

    print(velocity/2, velocity_err/2)



    

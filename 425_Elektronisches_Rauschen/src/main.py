import numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt



# Effektive Bandbreite
(f, U0_rms, U0_rms_err, U_rms, U_rms_err) = np.genfromtxt("../data/eff_band.dat", delimiter=" ").T
#data = np.genfromtxt("../data/eff_band.dat", delimiter=" ").T
#print(data)
eff_band_data = np.array([f, U_rms/U0_rms, ((U_rms_err/U0_rms)**2+(U_rms/U0_rms**2*U0_rms_err)**2)**(1/2)])
np.savetxt("../data/processed_eff_band.dat", eff_band_data.T, delimiter=" ")



'''
sigma = np.cov(y)/y.shape[1]
r = ydata - func(x, *popt[0])
chi_sq = r.T @ np.linalg.pinv(sigma) @ r
red_chi_sq[0] = chi_sq/(x.shape[0] - len(p0)) # reduced chisq
'''





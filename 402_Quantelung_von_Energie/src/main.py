import numpy as np

d, omega_G = np.genfromtxt('data/Balmer_Messung.dat', delimiter=' ')[:,1:].T
d = d*1e-3          # 1e-3 oder 1e-4??
d_err=0.05e-3
omega_G_err = 0.5

omega_B = 130
omega_B_err = 0.5
f = 25.5e-2
f_err = 0.5e-2

beta = (omega_G + omega_B - 180)/180*3.14
beta_err = (omega_G_err**2+omega_B_err**2)**(1/2)/180*3.14
delta_beta = d/f
delta_beta_err = ((d_err/f)**2+(d/f**2*f_err)**2)**(1/2)

g, g_err = 4527e-10, 47e-10

delta_lambda = g*np.cos(beta)*delta_beta
delta_lambda_err = ((g_err*np.cos(beta)*delta_beta)**2+(g*np.sin(beta)*beta_err*delta_beta)**2+(g*np.cos(beta)*delta_beta_err)**2)**(1/2)
wellenlänge = g*(np.sin(omega_G/180*3.14)+np.sin((omega_G+omega_B-180)/180*3.14))
wellenlänge_err = ((g_err*(np.sin(omega_G/180*3.14)+np.sin((omega_G+omega_B-180)/180*3.14)))**2+(g*(np.cos(omega_G/180*3.14)+np.cos((omega_G+omega_B-180)/180*3.14))*omega_G_err/180*3.14)**2+(g*(np.cos((omega_G+omega_B-180)/180*3.14))*omega_B_err/180*3.14)**2)**(1/2)
print("wellenlänge: ", wellenlänge, wellenlänge_err)
print("aufspaltung: ", delta_lambda, delta_lambda_err)


rel_alpha1 = np.array([-0.00793, -0.02217, -0.0140, -0.0123])/180*3.14
rel_alpha1_err = np.array([0.00018, 0.00037, 0.0015, 0.0013])/180*3.14

rel_alpha2 = np.array([0.02452, 0.01453, 0.0206, 0.0242])/180*3.14
rel_alpha2_err = np.array([0.00018, 0.00051, 0.0025, 0.0023])/180*3.14

abs_alpha1 = np.array([83.0, 62.5, 57.5, 57.0])/180*3.14
abs_alpha1_err = 0.5/180*3.14

abs_beta1 = abs_alpha1+omega_B/180*3.14-3.14
abs_beta1_err = (abs_alpha1_err**2+omega_B_err**2)**(1/2)

delta_alpha = rel_alpha2-rel_alpha1
delta_alpha_err = (rel_alpha2_err**2+rel_alpha1_err**2)**(1/2)

print(abs_alpha1)
print(abs_beta1)

ccd_lambda = g*(np.sin(abs_alpha1)+np.sin(abs_beta1))
ccd_lambda_err = ((g_err*(np.sin(abs_alpha1)+np.sin(abs_beta1)))**2+(g*np.cos(abs_alpha1)*abs_alpha1_err)**2+(g*np.cos(abs_beta1)*abs_beta1_err)**2)**(1/2)
print('ccd lambda: ', ccd_lambda, ccd_lambda_err)


ccd_delta_lambda = g*np.cos(abs_beta1)*delta_alpha
ccd_delta_lambda_err = ((g_err*np.cos(abs_beta1)*delta_alpha)**2+(g*np.sin(abs_beta1)*abs_beta1_err*delta_alpha)**2+(g*np.cos(abs_beta1)*delta_alpha_err)**2)**(1/2)
print('ccd delta lambda: ', ccd_delta_lambda, ccd_delta_lambda_err)



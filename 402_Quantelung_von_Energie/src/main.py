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
print("wellenlänge: ", "\n", wellenlänge,"\n", wellenlänge_err)
print("aufspaltung: ", "\n", delta_lambda,"\n", delta_lambda_err)


rel_alpha1 = np.array([-0.00793, -0.02217, -0.0140, -0.0123])/180*3.14
rel_alpha1_err = np.array([0.00018, 0.00037, 0.0015, 0.0013])/180*3.14

rel_alpha2 = np.array([0.02452, 0.01453, 0.0206, 0.0242])/180*3.14
rel_alpha2_err = np.array([0.00018, 0.00051, 0.0025, 0.0023])/180*3.14


abs_alpha1 = np.array([83.0, 62.5, 57.5, 57.0])/180*3.14 + rel_alpha1
abs_alpha1_err = ((0.5/180*3.14)**2+rel_alpha1_err**2)**(1/2)

abs_beta1 = abs_alpha1+omega_B/180*3.14-3.14
abs_beta1_err = (abs_alpha1_err**2+(omega_B_err/180*3.14)**2)**(1/2)

delta_alpha = rel_alpha2-rel_alpha1
delta_alpha_err = (rel_alpha2_err**2+rel_alpha1_err**2)**(1/2)

ccd_lambda = g*(np.sin(abs_alpha1)+np.sin(abs_beta1))
ccd_lambda_err = ((g_err*(np.sin(abs_alpha1)+np.sin(abs_beta1)))**2+(g*np.cos(abs_alpha1)*abs_alpha1_err)**2+(g*np.cos(abs_beta1)*abs_beta1_err)**2)**(1/2)
print('wasserstoff ccd lambda: ', "\n", ccd_lambda, "\n", ccd_lambda_err)


ccd_delta_lambda = g*np.cos(abs_beta1)*delta_alpha
ccd_delta_lambda_err = ((g_err*np.cos(abs_beta1)*delta_alpha)**2+(g*np.sin(abs_beta1)*abs_beta1_err*delta_alpha)**2+(g*np.cos(abs_beta1)*delta_alpha_err)**2)**(1/2)
print('ccd delta lambda: ', "\n", ccd_delta_lambda, "\n", ccd_delta_lambda_err)




abs_alpha2 = np.array([83.0, 62.5, 57.5, 57.0])/180*3.14 + rel_alpha2
abs_alpha2_err = ((0.5/180*3.14)**2+rel_alpha2_err**2)**(1/2)


abs_beta2 = abs_alpha2+omega_B/180*3.14-3.14
abs_beta2_err = (abs_alpha2_err**2+(omega_B_err/180*3.14)**2)**(1/2)

ccd_lambda = g*(np.sin(abs_alpha2)+np.sin(abs_beta2))
ccd_lambda_err = ((g_err*(np.sin(abs_alpha2)+np.sin(abs_beta2)))**2+(g*np.cos(abs_alpha2)*abs_alpha2_err)**2+(g*np.cos(abs_beta2)*abs_beta2_err)**2)**(1/2)
print('deuterium ccd lambda: ', "\n", ccd_lambda, "\n", ccd_lambda_err)


#print(abs_alpha1)
#print(abs_beta1)


c=3e8
m=np.array([3, 4, 5, 6, 7])
n=2
print("teeeeest: ", wellenlänge)
rydberg = (1/wellenlänge*(1/n**2-1/m**2)**-1)
rydberg_err = np.linalg.norm(1/wellenlänge**2*wellenlänge_err*(1/n**2-1/m**2)**-1)
rydberg_constant_H = rydberg.mean()
rydberg_constant_H_err = (rydberg.std()**2+rydberg_err**2)**(1/2)
#print(rydberg.mean(), (rydberg.std()**2+rydberg_err**2)**(1/2))
#print(np.log10(rydberg.mean()), np.log10((rydberg.std()**2+rydberg_err**2)**(1/2)))
me=9.1e-31
mp=1.67e-27
rydberg_constant_inf = rydberg_constant_H*(1+me/mp)
rydberg_constant_inf_err = rydberg_constant_H_err*(1+me/mp)
print(rydberg_constant_inf, rydberg_constant_inf_err)
eps_0 = 8.85e-12
e_charge = 1.6e-19
h = (1/rydberg_constant_inf*me*e_charge**4/8/eps_0**2/c)**(1/3)
h_err = rydberg_constant_inf**(-4/3)*(me*e_charge**4/8/eps_0**2/c)**(1/3)*rydberg_constant_inf_err
#print(h, h_err)


# Wasserstoff Halbwertsbreite: a:= mit b*exp(-x**2/a)+g
a = np.array([0.0001516, 0.0003768, 0.0003569, 0.0004403])/180*3.14
a_err = np.array([6.6e-6, 1.4e-5, 5e-5, 4.4e-5])/180*3.14
halbwertsbreite_grad = a/2*2*(2*np.log(2))**(1/2)
halbwertsbreite_grad_err = a_err/2*2*(2*np.log(2))**(1/2)
lower_lambda = g*(np.sin(abs_alpha1-halbwertsbreite_grad)+np.sin(abs_beta1-halbwertsbreite_grad))
lower_lambda_err = ((g_err*(np.sin(abs_alpha1-halbwertsbreite_grad)+np.sin(abs_beta1-halbwertsbreite_grad)))**2+(g*np.cos(abs_alpha1-halbwertsbreite_grad)*abs_alpha1_err)**2+(g*(np.cos(abs_beta1-halbwertsbreite_grad))*abs_beta1_err)**2+(g*(np.cos(abs_alpha1-halbwertsbreite_grad)+np.cos(abs_beta1-halbwertsbreite_grad))*halbwertsbreite_grad_err)**2)**(1/2)
heigher_lambda = g*(np.sin(abs_alpha1+halbwertsbreite_grad)+np.sin(abs_beta1+halbwertsbreite_grad))
heigher_lambda_err = ((g_err*(np.sin(abs_alpha1+halbwertsbreite_grad)+np.sin(abs_beta1+halbwertsbreite_grad)))**2+(g*np.cos(abs_alpha1+halbwertsbreite_grad)*abs_alpha1_err)**2+(g*np.cos(abs_beta1+halbwertsbreite_grad)*abs_beta1_err)**2+(g*(np.cos(abs_alpha1+halbwertsbreite_grad)+np.cos(abs_beta1+halbwertsbreite_grad))*halbwertsbreite_grad_err)**2)**(1/2)
fwhm = heigher_lambda - lower_lambda
fwhm_err = (heigher_lambda_err**2+lower_lambda_err**2)**(1/2)
print("wasserstoff halbwertsbreite: ", "\n", fwhm, "\n", fwhm_err)



# Deuterium Halbwertsbreite
a = np.array([6.645e-5, 0.0008668, 0.0005679, 0.0008303])/180*3.14
a_err = np.array([4.3e-6, 3.0e-5, 0.00012, 0.00011])/180*3.14
halbwertsbreite_grad = a/2*2*(2*np.log(2))**(1/2)
halbwertsbreite_gard_err = a_err/2*2*(2*np.log(2))**(1/2)
lower_lambda = g*(np.sin(abs_alpha2-halbwertsbreite_grad)+np.sin(abs_beta2-halbwertsbreite_grad))
lower_lambda_err = ((g_err*(np.sin(abs_alpha2-halbwertsbreite_grad)+np.sin(abs_beta2-halbwertsbreite_grad)))**2+(g*np.cos(abs_alpha2-halbwertsbreite_grad)*abs_alpha2_err)**2+(g*np.cos(abs_beta2-halbwertsbreite_grad)*abs_beta2_err)**2+(g*(np.cos(abs_alpha2-halbwertsbreite_grad) + np.cos(abs_beta2-halbwertsbreite_grad))*halbwertsbreite_grad_err)**2)**(1/2)
heigher_lambda = g*(np.sin(abs_alpha2+halbwertsbreite_grad)+np.sin(abs_beta2+halbwertsbreite_grad))
heigher_lambda_err = ((g_err*(np.sin(abs_alpha2+halbwertsbreite_grad)+np.sin(abs_beta2+halbwertsbreite_grad)))**2+(g*np.cos(abs_alpha2+halbwertsbreite_grad)*abs_alpha2_err)**2+(g*np.cos(abs_beta2+halbwertsbreite_grad)*abs_beta2_err)**2+(g*(np.cos(abs_alpha2+halbwertsbreite_grad)+np.cos(abs_beta2+halbwertsbreite_grad))*halbwertsbreite_grad_err)**2)**(1/2)
fwhm = heigher_lambda - lower_lambda
fwhm_err = (heigher_lambda_err**2+lower_lambda_err**2)**(1/2)
print("deuterium halbwertsbreite: ", "\n", fwhm, "\n", fwhm_err)


#Dopplerverbreiterung
lit_wellenlängen = np.array([656, 485, 434, 410])*1e-9
T = 1000
k_b=1.38e-23
dop_fwhm = lit_wellenlängen/c*(8*k_b*T*np.log(2)/mp)**(1/2)
print("dop fwhm: ", dop_fwhm)

dop_fwhm = lit_wellenlängen/c*(8*k_b*T*np.log(2)/mp/2)**(1/2)
print("dop fwhm: ", dop_fwhm)


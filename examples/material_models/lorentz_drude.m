clear
close all
%% different tests from applied optics vol 37 no 22 august 1998 rakic
% aside from oscillator strengths f, everything is in units of eV;
% which shouldn't matter since
eV = 241.79893*1e12*(2*pi);
rad_Hz = 1/(2*pi);
Hz_eV =  4.13566553853599E-15; %1Hz = x eV
rad_eV = rad_Hz*Hz_eV;
c0 = 3e8;

%% =================================== Ag ======================================
f0 = 0.845;
gamma_p = 0.048;
omega_p = 9.01;
%oscillator strengths;
oscillator_f = [0.065, 0.124, 0.011, 0.840, 5.646];
omega_l_arr = [0.816, 4.481, 8.815, 9.083, 20.29];
gamma_l_arr = [3.886, 0.452, 0.064, 0.916, 2.419];

%omega_scan
lambda_scan = logspace(-1,1, 1000)*1e-6;
omega_scan = 2*pi*c0./lambda_scan;

omega_scan_ev = omega_scan*rad_eV; %convert rad/s to eV

epsilon = lorentz_drude_rakic(lambda_scan, f0, oscillator_f, omega_p, gamma_p, omega_l_arr, gamma_l_arr);

figure(); 
loglog(omega_scan_ev, abs(real(epsilon)));
hold on;
loglog(omega_scan_ev, abs(imag(epsilon)));
legend('real', 'imag')
title('Ag Rakic')
xlim([0.7,5]);
lambda_scan_palik = linspace(0.3, 2, 1000);
xlabel('frequency (eV)')

% compare to Palik
for i = 1:length(lambda_scan_palik)
    epsilon_Palik(i) = Palik_Ag(lambda_scan_palik(i));

end

omega_scan_palik = 2*pi*c0./lambda_scan_palik*1e6;
eV_palik = omega_scan_palik*rad_eV;

figure(); loglog(eV_palik,abs(real(epsilon_Palik)));
hold on;
loglog(eV_palik,abs(imag(epsilon_Palik)))
ylim([0.01,1e3])
xlabel('frequency (eV)')

title('Ag Palik')

%% =================================== Al ======================================
%omega_scan
lambda_scan = logspace(-1,1.5, 1000)*1e-6;
omega_scan = 2*pi*c0./lambda_scan;

omega_scan_ev = omega_scan*rad_eV; %convert rad/s to eV


f0 = 0.523;
gamma_p = 0.047;
omega_p = 14.98;
%oscillator strengths;
oscillator_f = [0.227, 0.050, 0.166, 0.030];
omega_l_arr = [0.162, 1.544, 1.808, 3.473];
gamma_l_arr = [0.333, 0.312, 1.351, 3.382];
epsilon = lorentz_drude_rakic(lambda_scan, f0, oscillator_f, omega_p, gamma_p, omega_l_arr, gamma_l_arr);

figure(); 
loglog(omega_scan_ev, abs(real(epsilon)));
hold on;
loglog(omega_scan_ev, abs(imag(epsilon)));
legend('real', 'imag')
title('Rakic Aluminum')

lambda_scan_palik = linspace(0.3, 2, 1000);
xlabel('frequency (eV)')

omega_scan_palik = 2*pi*c0./lambda_scan_palik*1e6;
eV_palik = omega_scan_palik*rad_eV;


% compare to Palik
for i = 1:length(lambda_scan_palik)
    epsilon_Palik_Al(i) = Palik_Al(lambda_scan_palik(i));

end
figure(); loglog(eV_palik,abs(real(epsilon_Palik_Al)));
hold on;
loglog(eV_palik,abs(imag(epsilon_Palik_Al)))
ylim([0.01,1e3])
xlabel('frequency (eV)')

title('Palik Aluminum')

%% =================================== Au ======================================
%omega_scan
lambda_scan = logspace(-1,1.5, 1000)*1e-6;
omega_scan = 2*pi*c0./lambda_scan;

omega_scan_ev = omega_scan*rad_eV; %convert rad/s to eV


f0 = 0.760;
gamma_p = 0.053;
omega_p = 9.03;
%oscillator strengths;
oscillator_f = [0.024, 0.010, 0.071, 0.601,4.384];
omega_l_arr = [0.415,0.830,2.969,4.304,13.32];
gamma_l_arr = [0.241,0.345,0.870,2.494,2.214];
epsilon = lorentz_drude_rakic(lambda_scan, f0, oscillator_f, omega_p, gamma_p, omega_l_arr, gamma_l_arr);

figure(); 
loglog(omega_scan_ev, abs(real(epsilon)));
hold on;
loglog(omega_scan_ev, abs(imag(epsilon)));
legend('real', 'imag')
title('Rakic Au')

lambda_scan_palik = linspace(0.3, 2, 1000);
xlabel('frequency (eV)')

omega_scan_palik = 2*pi*c0./lambda_scan_palik*1e6;
eV_palik = omega_scan_palik*rad_eV;


% compare to Palik
for i = 1:length(lambda_scan_palik)
    epsilon_Palik_Al(i) = Palik_Au(lambda_scan_palik(i));

end
figure(); loglog(eV_palik,abs(real(epsilon_Palik_Al)));
hold on;
loglog(eV_palik,abs(imag(epsilon_Palik_Al)))
ylim([0.01,1e3])
xlabel('frequency (eV)')

title('Palik Au')



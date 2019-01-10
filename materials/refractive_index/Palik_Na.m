
function ep = Palik_Na(lambda)
          A=[
0.2	0.86416	0.052652
0.21	0.845553	0.054402
0.22	0.81175	0.054204
0.23	0.784136	0.053562
0.24	0.740628	0.059409
0.26	0.661223	0.056713
0.28	0.565928	0.065379
0.29	0.506726	0.069071
0.3	0.428659	0.075818
0.31	0.335469	0.092408
0.315	0.280721	0.108649
0.32	0.217039	0.138224
0.322	0.191296	0.156825
0.325	0.159417	0.188186
0.33	0.117674	0.250693
0.335	0.095749	0.313318
0.34	0.081061	0.376259
0.35	0.06558	0.465081
0.36	0.056393	0.549709
0.38	0.050753	0.68962
0.4	0.050949	0.804733
0.42	0.053595	0.914261
0.44	0.076149	1.017742
0.46	0.056511	1.105981
0.48	0.052215	1.196966
0.5	0.050411	1.289396
0.525	0.049508	1.393718
0.55	0.04467	1.600623
0.6	0.040213	1.703413

]; %
    %figure(); plot(A(:,1), imag((A(:,2)+(1i*A(:,3))).^2)); hold on;plot(A(:,1), real((A(:,2)+(1i*A(:,3))).^2));

        Palik_lam=A(:,1);
        Palik_kap=A(:,3);
        Palik_n=A(:,2);
        
        assert(lambda>=Palik_lam(1) && lambda<=Palik_lam(length(Palik_lam)), 'out of range')
            
        %first step: interpolate everything
        n = interp1(Palik_lam, Palik_n, lambda);
        k = interp1(Palik_lam, Palik_kap, lambda);

        
        ep = (n+1i*k)^2;
end
        


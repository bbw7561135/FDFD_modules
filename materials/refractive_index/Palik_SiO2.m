%lattice absorption

function ep = Palik_SiO2(lambda)
      A=[0.1012	1.41	0.824
0.1033	1.475	0.861
0.1051	1.554	0.874
0.1069	1.635	0.859
0.1088	1.716	0.81
0.1107	1.766	0.718
0.1127	1.739	0.569
0.1137	1.687	0.565
0.1148	1.587	0.618
0.1159	1.513	0.725
0.117	1.492	0.914
0.1181	1.567	1.11
0.1187	1.645	1.136
0.1192	1.772	1.132
0.1198	1.919	1.045
0.1204	2.33	0.323
0.121	2.152	0.81
0.1215	2.24	0.715
0.1228	2.332	0.46
0.124	2.33	0.323
0.1252	2.292	0.236
0.1265	2.243	0.168
0.1278	2.19	0.119
0.1291	2.14	0.077
0.1305	2.092	0.0561
0.1319	2.047	0.043
0.1333	2.006	0.039
0.1348	1.969	0.0271
0.1362	1.935	0.0228
0.1378	1.904	1.89E-02
0.1393	1.876	1.56E-02
0.1409	1.85	1.32E-02
0.1425	1.825	1.09E-02
0.1442	1.803	8.38E-03
0.1459	1.783	5.57E-03
0.1476	1.764	3.17E-03
0.1494	1.747	1.40E-03
0.1512	1.73	4.63E-04
0.1531	1.716	1.22E-04
0.155	1.702	3.20E-05
0.159	1.67	4.70E-06
0.1631	1.653	4.70E-06
0.1675	1.633	4.70E-06
0.1722	1.616	4.70E-06
0.1837	1.582	4.70E-06
0.2066	1.543	4.70E-06
0.214438	1.53371	4.70E-06
0.239938	1.51338	4.70E-06
0.302	1.48179	4.70E-06
0.404656	1.46961	4.70E-06
0.508582	1.46187	4.70E-06
0.643847	1.45671	4.70E-06
0.706519	1.45515	4.70E-06
0.852111	1.4528	4.70E-06
1.01398	1.45025	4.70E-06
1.01398	1.45025	4.70E-06
1.12866	1.44888	4.70E-06
1.3622	1.44621	4.70E-06
1.4695	1.44497	4.70E-06
1.6606	1.442267	4.70E-06
1.70913	1.44205	4.70E-06
1.81307	1.44069	4.70E-06
1.97	1.43451	4.70E-06
2.0561	1.432722	4.70E-06
2.1526	1.43567	4.70E-06
2.32452	1.43292	4.70E-06
2.4374	1.43095	4.70E-06
3.2439	1.4134	4.70E-06
3.2668	1.41253	4.70E-06
3.3026	1.41155	4.70E-06
3.422	1.40819	4.70E-06
3.507	1.40568	4.70E-06
3.5564	1.40418	4.70E-06
3.636	1.401627292	2.25E-05
3.704	1.401953438	3.39E-05
3.7067	1.39936	3.66E-05
3.774	1.39209	3.93E-05
3.846	1.395	4.96E-05
3.922	1.392	5.18E-05
4	1.389	5.79E-05
4.082	1.386	7.99E-05
4.167	1.383	1.07E-04
4.255	1.378809524	1.32E-04
4.348	1.374380952	2.13E-04
4.396	1.372095238	2.65E-04
4.444	1.369809524	2.84E-04
4.494	1.367428571	2.84E-04
4.545	1.365	2.56E-04
4.651	1.359641758	2.62E-04
4.762	1.354030769	4.85E-04
4.878	1.348167033	1.82E-03
5	1.342	3.98E-03
5.063	1.337920863	5.12E-03
5.128	1.33371223	5.18E-03
5.263	1.324971223	5.49E-03
5.333	1.320438849	5.69E-03
5.405	1.315776978	5.72E-03
5.556	1.306	5.63E-03
5.714	1.292429448	5.78E-03
5.882	1.278	5.94E-03
6.061	1.259029891	6.32E-03
6.154	1.249173913	6.46E-03
6.25	1.239	6.52E-03
6.452	1.212	6.57E-03
6.667	1.175	7.16E-03
6.757	1.158	7.61E-03
6.849	1.135	8.06E-03
6.897	1.121	8.51E-03
6.944	1.107	8.91E-03
7.042	1.084	9.74E-03
7.143	1.053	1.06E-02
7.407	0.9488	1.48E-02
7.692	0.7719	3.72E-02
7.752	0.7037	4.74E-02
7.813	0.6232	7.68E-02
7.874	0.5456	1.32E-01
7.937	0.4677	2.16E-01
8	0.4113	3.23E-01
8.065	0.3931	4.46E-01
8.13	0.402	5.53E-01
8.197	0.4329	6.35E-01
8.265	0.453	7.04E-01
8.333	0.46	7.71E-01
8.403	0.473	8.40E-01
8.45	0.4746	9.03E-01
8.547	0.4656	9.78E-01
8.621	0.4563	1.07E+00
8.696	0.4303	1.17E+00
8.772	0.3915	1.32E+00
8.85	0.3563	1.53E+00
8.929	0.3705	1.85E+00
9.009	0.5846	2.27E+00
9.091	1.043	2.55E+00
9.174	1.616	2.63E+00
9.302	2.25	2.26E+00
9.524	2.76	1.65E+00
9.75	2.839	9.62E-01
10      2.694	5.09E-01
10.26	2.448	2.31E-01
10.53	2.224	1.02E-01
10.81	2.038	4.60E-02
11.11	1.869	5.06E-02
11.36	1.784	7.75E-02
11.63	1.69	1.16E-01
11.76	1.652	1.52E-01
11.9	1.619	2.04E-01
12.05	1.615	2.67E-01
12.2	1.658	3.23E-01
12.35	1.701	3.41E-01
12.5	1.753	3.43E-01
12.66	1.789	3.14E-01
12.82	1.811	2.75E-01
12.99	1.81	2.27E-01
13.16	1.779	1.92E-01
13.33	1.756	1.77E-01
13.79	1.698	1.57E-01
14.29	1.643	1.57E-01
14.81	1.598	1.68E-01
15.38	1.555	1.82E-01
16	1.502	2.02E-01
16.67	1.45	2.35E-01
17.24	1.401	2.64E-01
17.86	1.337	2.98E-01
18.52	1.235	3.41E-01
18.97	1.161	3.77E-01
19.23	1.05	4.15E-01
19.61	0.8857	5.24E-01
20	0.6616	8.22E-01
20.41	0.5777	1.28E+00
20.83	0.7517	1.86E+00
21.05	1.002	2.22E+00
21.28	1.484	2.39E+00
21.74	2.308	2.29E+00
22.73	2.93	1.29E+00
23.81	2.912	7.38E-01
25	2.739	3.97E-01
26.67	2.537	1.99E-01
28.57	2.388	1.30E-01
30.77	2.284	9.20E-02
33.33	2.21	6.70E-02
36.36	2.147	5.60E-02
40	2.1	4.60E-02
45	2	2.50E-02
50	1.98	2.30E-02
55	1.98	2.00E-02
60	1.98	1.90E-02
65	1.98	1.90E-02
70	1.98	1.80E-02
75	1.97	1.75E-02
80	1.97	1.65E-02
85	1.97E+00	1.65E-02
90	1.97	1.60E-02
95	1.97	1.60E-02
100	1.967	1.59E-02
];

        Palik_lam=A(:,1);
        Palik_kap=A(:,3);
        Palik_ref=A(:,2);
        
        if lambda<Palik_lam(1) || lambda>Palik_lam(length(Palik_lam))
            y=0;
        else
            ind=find(Palik_lam>=lambda);
            wave_R=Palik_lam(ind(1));
            if ind(1)==1
                n=Palik_ref(1);
                k=Palik_kap(1);
            else
                wave_L=Palik_lam(ind(1)-1);
                n=(Palik_ref(ind(1))-Palik_ref(ind(1)-1))/(wave_R-wave_L)*(lambda-wave_L)+Palik_ref(ind(1)-1);
                k=(Palik_kap(ind(1))-Palik_kap(ind(1)-1))/(wave_R-wave_L)*(lambda-wave_L)+Palik_kap(ind(1)-1);
            end
        end
        
        ep = (n+i*k)^2;
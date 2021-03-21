nsFile = fopen('0to3nmAlN2DEGResults.final');
formatSpec = '%s nsQ=%f nsQ=%f nsQ=%f nsQ=%f nsQ=%f nsQ=%f nsQ=%f nsQ=%f nsQ=%f  nsQ=%f nsQ=%f %s';
nsC = textscan(nsFile,formatSpec,...            
                'Delimiter', 'n', ...
                'CollectOutput', true)
            
fclose(nsFile)
%celldisp(nsC)
ns=nsC{1,1}
algth=0550;
alnth=00.53;
figure
hold on
for i=17
    plot(algth,ns(i,));
end
legend('0nm AlN','0.5nm AlN', '1nm AlN','1.5nm AlN','2.0nm AlN','2.5nm AlN', '3nm AlN')
title({'Quantum Mechanical 2DEG density for AlN thicknesses of 0-3nm' })
xlabel('AlGaN thickness')
ylabel('2DEG density(cm^-^2)')

%% MOBILITIES
strf=''; %format string format of the log files
strf = '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s ';
strf=strcat(strf,' d %f %f %f %f %f %f %f %f %f %f %f %f')
Id=zeros(7,11);
for i=17
    for k=111
%I saved the drain current data in Silvaco to 11 log files named in the following fashion
        musFile = fopen(strcat('Id_alg(', num2str((k-1)0.005) ,')_aln(', num2str((i-1)0.0005) ,').log'));
        formatSpec = strf;
        Id_Cell(i,k) = textscan(musFile,formatSpec,...            
                'Delimiter', 'n', ...
                'CollectOutput', true);
        fclose(musFile);
        Id_array=Id_Cell(i,k);
        Id_d=Id_array{1,1};
        Id(i,k)=Id_d(6);
    end
end
Vds=0.01; q=(1.62e-19); W=100; L=5.5;
mu= Id.(qns(WL)Vds);
figure
hold on
for i=17
    semilogy(algth,mu(i,));
end
legend('0nm AlN','0.5nm AlN', '1nm AlN','1.5nm AlN','2.0nm AlN','2.5nm AlN', '3nm AlN')
title({'Quantum Mechanical Mobility for AlN thicknesses of 0-3nm' })
xlabel('AlGaN thickness')
ylabel('Mobility(cm^2(Vs))')
 
%% SHEET Conductivity
figure
sh_cond=ns.mu;
for i=17
    semilogy(algth,sh_cond(i,));
    hold on
end
legend('0nm AlN','0.5nm AlN', '1nm AlN','1.5nm AlN','2.0nm AlN','2.5nm AlN', '3nm AlN')
title({'Quantum Mechanical (Mobility)(ns) PRODUCT  for AlN thicknesses of 0-3nm', '(PROPORTIONAL TO SHEET CONDUCTIVITY)' })
xlabel('AlGaN thickness')
ylabel('(Mobility)(ns)(1(Vs))')



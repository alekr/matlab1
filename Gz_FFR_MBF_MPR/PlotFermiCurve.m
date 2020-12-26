function [ok] = PlotFermiCurve(i, j, k, NoInc, MBF, MBF_p, TIME_fermi, AIF_fermi, MYO_fermi, time, aif_tD, myo_base, myoSI)

hold off;

   f0=MBF_p(1)./(1+exp(MBF_p(2).*(TIME_fermi)-MBF_p(3)));
   new_myo_0=conv(AIF_fermi, f0);
   new_myo_0=new_myo_0(1: NoInc+1);

   plot(TIME_fermi, AIF_fermi, 'c', time-aif_tD, myoSI-myo_base, '.g');hold on;
   plot(TIME_fermi, new_myo_0, 'b');
   plot(TIME_fermi, MYO_fermi, '.r');
   
   tmp = sprintf('P%d AIF%d MYO%d', k, j, i);
   title(tmp); 
        
   txt = ['FLOW: ' num2str(MBF) ' mL/g/min'];
   xlabel(txt);
   
   hold off;
ok = 1;   
%         figure_out=strcat(path,name);
%         tmp = sprintf('_%d_', j);
%         figure_out=strcat(figure_out, tmp);
%         figure_out=strcat(figure_out,'-MBF1.jpeg');
%    
%         title(['Fermi Fit 1: ', temp_title]); 
%         
%         txt = ['FLOW: ' num2str(MBF1(j)) ' mL/g/min'];
%         xlabel(txt);
%         
%         export_fig temp.jpeg
%         movefile ('temp.jpg', figure_out);
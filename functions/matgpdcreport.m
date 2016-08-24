function matgpdcreport(dir_in,exportopt,nrun,nmode,nmaxmod,wave,nf,fmin,fmax)

%%% S. Pasquet - V16.4.14
% Read dinver report files

if nargin>6
    resamp=1;
else
    resamp=0;
end

for j=1:nrun
%     fprintf(['\nExtracting models for run ',num2str(j),'\n']);
    %     com1=['gpdcreport ',fullfile(dir_in,['run_0',num2str(j),'.report']),...
    %         ' -pm -best ',num2str(nmaxmod),' > ',fullfile(dir_in,'best')];
    %     unix(com1);
    %     com1=['tail -n ',num2str(nmaxmod),' ',fullfile(dir_in,'best'),' > '...
    %         ,fullfile(dir_in,['best',num2str(j)])];
    %     unix(com1);
    %     com1=['rm -f ',fullfile(dir_in,'best')];
    %     unix(com1);
    for k=1:nmode
%         fprintf(['Mode ',num2str(k-1),'\n']);
        if exportopt==0 || exportopt==2
            com1=['gpdcreport ',fullfile(dir_in,['run_0',num2str(j),'.report']),...
                ' -p',wave,' ',num2str(k-1),' -best ',num2str(nmaxmod),' > ',...
                fullfile(dir_in,['best',num2str(j),'.M',num2str(k-1),'.txt'])];
            unix(com1);
            if resamp==1
                com1=['mv ',fullfile(dir_in,['best',num2str(j),'.M',num2str(k-1),'.txt']),...
                    ' ',fullfile(dir_in,'best_old.txt')];
                unix(com1);
                com1=['gpcurve ',fullfile(dir_in,'best_old.txt'),' -resample ',...
                    num2str(nf),' -min ',num2str(fmin),' -max ',num2str(fmax),...
                    ' > ',fullfile(dir_in,['best',num2str(j),'.M',num2str(k-1),'.txt'])];
                unix(com1);
                com1=['rm -rf ',fullfile(dir_in,'best_old.txt')];
                unix(com1);
            end
        end
        if exportopt==1 || exportopt==2
            com1=['gpdcreport ',fullfile(dir_in,['run_0',num2str(j),'.report']),...
                ' -vs -best ',num2str(nmaxmod),' > ',...
                fullfile(dir_in,['vs',num2str(j),'.txt'])];
            unix(com1);
            com1=['gpdcreport ',fullfile(dir_in,['run_0',num2str(j),'.report']),...
                ' -vp -best ',num2str(nmaxmod),' > ',...
                fullfile(dir_in,['vp',num2str(j),'.txt'])];
            unix(com1);
            com1=['gpdcreport ',fullfile(dir_in,['run_0',num2str(j),'.report']),...
                ' -rho -best ',num2str(nmaxmod),' > ',...
                fullfile(dir_in,['rho',num2str(j),'.txt'])];
            unix(com1);
        end
    end
end
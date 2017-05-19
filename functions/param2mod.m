function [dpMIN,dpMAX]=param2mod(nameparam)

%%% S. Pasquet - V17.05.03
% Read .param dinver file
% [dpMIN,dpMAX]=param2mod(nameparam)

dir_param=fileparts(nameparam);
if strcmp(dir_param,'')==1
    dir_param=pwd;
end
nameparamnew=[nameparam(1:end-5),'tar'];
[~,~]=unix(['mv -f ',nameparam,' ',nameparamnew]);
if isunix==1
    [~,~]=unix(['tar -xf ',nameparamnew,' -C ',dir_param]);
else
    [~,~]=unix(['tar -xf ',nameparamnew,' --force-local']);
    [~,~]=unix(['mv contents.xml ',dir_param]);
end
[~,~]=unix(['mv -f ',nameparamnew,' ',nameparam]);

fid0=fopen(fullfile(dir_param,'contents.xml'),'r');
shortname=fgets(fid0); % Read line
n=0;
while isempty(strfind(shortname,'<shortName>Vs</shortName>'))==1
    shortname=fgets(fid0); % Read line
end
for i=1:4
    fgets(fid0); % Read line
end
ligne=fgets(fid0); % Read line
while isempty(strfind(ligne,'<ParamLayer name="Vs'))~=1
    n=n+1;
    ligne=fgets(fid0); % Read line
    while isempty(strfind(ligne,'<dhMin'))==1
        ligne=fgets(fid0); % Read line
    end
    dhMin(n) = str2double(ligne(strfind(ligne,'<dhMin>')+7:strfind(ligne,'</dhMin>')-1));
    ligne=fgets(fid0); % Read line
    dhMax(n) = str2double(ligne(strfind(ligne,'<dhMax>')+7:strfind(ligne,'</dhMax>')-1));
    fgets(fid0); % Read line
    ligne=fgets(fid0); % Read line
end

dpMIN = sum(dhMin(1:end-1));
dpMAX = sum(dhMax(1:end-1));

fclose(fid0);

delete(fullfile(dir_param,'contents.xml'));

end

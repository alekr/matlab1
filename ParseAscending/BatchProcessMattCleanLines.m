FileList = dir('*.txt');
N = size(FileList,1);

for k = 1:N

   % get the file name:
   filename = FileList(k).name;
   disp(filename);

   [path, name, extension] = fileparts(filename);
   
    fout=strcat(path,name);
    fout_name=strcat(fout,'.CleanBlanks');
    fout=fopen(fout_name, 'w');
   
filecontent = fileread(filename);
newcontent = regexprep(filecontent, {'\r', '\n\n+', '\n'}, {'', '\n', '\r\n'});
% fout = fopen('new_pressure.txt', 'w');
fwrite(fout, newcontent);
fclose(fout);

[path, name, extension] = fileparts(fout_name);
   
 ParseFilesqMASS_asc(fout_name);
   
fclose('all');
end
FileList = dir('*.txt');
N = size(FileList,1);

for k = 1:N

   % get the file name:
   filename = FileList(k).name;
   disp(filename);

   [path, name, extension] = fileparts(filename);
   
   
filecontent = fileread(filename);
newcontent = regexprep(filecontent, {'\r', '\n\n+', '\n'}, {'', '\n', '\r\n'});
fid = fopen('new_pressure.txt', 'w');
fwrite(fid, newcontent);
fclose(fid);
   
 ParseFilesqMASS_asc(filename);
   
fclose('all');
end
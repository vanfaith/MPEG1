function [runSymbols] = ivlc(vlcStream)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

getTheGlobals
elements=size(vlcStream);
elements=elements(2); %number of run symbols to be encoded


global d15a;
global d15b;
global d16a;
global d16b;
global d17a;
global d17b;
d15bNeg=d15b;
d15aNeg(:,2)=d15a(:,2)*(-1);
d15bNeg=strcat(d15b(1:end-1),'1') %den xriazomaste to EOB, the last element
d15aPos=d15a;
d15bPos=strcat(d15b(1:end-1),'0') %den xriazomaste to EOB, the last element



for i=1:(elements-1)

    
   I = find(strcmp(d15bPos,vlcStream(i)));  %vrisko index
   if not(isempty(I))%ean vrethike
   runSymbols(i,1)=d15aPos(I,1);
   runSymbols(i,2)=d15aPos(I,2);
   end    
   
   D = find(strcmp(d15bPos,vlcStream(i)));  %vrisko index
   if not(isempty(D))%ean vrethike
   runSymbols(i,1)=d15aPos(D,1);
   runSymbols(i,2)=d15aPos(D,2);
   end 
   
   
   if isempty(D)&&isempty(I) % if not found in previous ones, search in d17
       first_part=char(vlcStream(i));
       first_part=first_part(1:6);
       runSymbols(i,1)=bin2dec(first_part);
       
       
       second_part=char(vlcStream(i));
       second_part=second_part(7:end);
       second={second_part}
       
       S = find(strcmp(d17b,second))
       runSymbols(i,2)=d17a(S);
       
   end
   
       I(:) = [];    %emptying matrices due to isemptychecks
   D(:) = [];
   
  
       
   
end
runSymbols

end





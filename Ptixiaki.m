%algorithmos dimiourgias pinaka metapidisis 
%seiriakou sistimatos dio stathmon ergasias xoris endiameso buffer
%metaksi tous. O protos stathmos einai kekoresmenos. Meta ton deutero
%stathmo vrisketai apothikeutikos xoros opou apothikeuontai oi ontotites
%pou dimiourgountai apo tous stathmous ergasias kai apo opou ikanopoieitai
%i eksoteriki zitisi. O stathmos ergasias 2 einai mplokarismenos otan einai
%gematos o apothikeutikos xoros kai o stathmos ergasias 1 einai
%mplokarismenos otan o stahmos 2 einai eite apasxolimenos eite
%mplokarismenos.
%Buffer
B=3;
%voithitikes metavlites me vasi to buffer
B2=B+1;
B3=3*B2+2;
%rithmos afiksis
l=1;
%rithmos eksipiretisis station 1
m1=2;
%rithmos eksipiretisis station 2
m2=2;
%dimiourgia midenikou pinaka metapidisis
P=zeros(B3,B3);
%gemisma pinaka metapidisis me l stin diagonio pou emfanizontai ta
%perissotera l
for i=1:B3-1
    P(i+1,i)=l; 
end   
%diorthosi ton l pou apoklinoun apo tin diagonio pou emfanizontai ta
%perissotera l
for i=1:B3-1
    if (i/B2==1)
    P(i+1,i)=0;
    end 
    if (i/B2==2)
    P(i+1,i)=0;
    P(i+2,i+1)=0;
    P(i+1,i-B2)=l;
    end
    if (i==B3-1)
    P(i+1,i)=0;
    P(i+1,i-B2-1)=l;
    end 
end
%gemisma pinaka metapidisis me m1 stin proti diagonio pou emfanizontai 
%ta m1
for i=1:B2
        P(i,i+B2)=m1;
end
%gemisma pinaka metapidisis me m1 stin deuteri diagonio pou emfanizontai
%ta m1
for i=B2+1:2*B2+1
        P(i,i+B2+1)=m1;
end
%gemisma pinaka metapidisis me m2 stin proti diagonio pou emfanizontai ta
%m2
for i=1:B
    P(i+B2,i+1)=m2;
end
%gemisma pinaka metapidisis me m2 stin deuteri diagonio pou emfanizontai 
%ta m2
sum3=0;
for i=2*B2+2:2*B2+B+1
    P(i,B2+2+sum3)=m2;
    sum3=sum3+1;
end
%gemisma pinaka metapidisis me m2 pou apoklinoun apo tis diagonious pou
%emfanizontai ta perissotera m2
P(2*B2,2*B2+1)=m2;
P(B3-1,B3)=m2;
% gemisma tis diagoniou tou pinaka metapidisis 
P(1,1)=-m1;
for i=2:B2
    P(i,i)=-l-m1;
end
P(B2+1,B2+1)=-m1-m2;
for i=B2+2:B2+B+1
    P(i,i)=-l-m1-m2;
end
P(B2+B+2,B2+B+2)=-l-m1;
P(B2+B+3,B2+B+3)=-m2;
for i=B2+B+4:B2+2*B+3
    P(i,i)=-l-m2;
end
P(B3,B3)=-l;
%emfanisi tou pinaka P
P
% anastrofos tou P
Q=P';
for i=1:B3
    Q(B3,i)=1;
end
Q
M=zeros(B3,1);
M(B3,1)=1;
M
% Stationary Probabilities
X=Q\M;
X
% Metra apodosis
%pososto kalipsis tis zitisis i fill rate i service level
pososto_kalipsis_tis_zitisis=1-X(1,1)-X(B+2,1)-X(2*B+4);
pososto_kalipsis_tis_zitisis
% ë effective
l_effective=l*pososto_kalipsis_tis_zitisis;
l_effective
% utilization of S1
sum1=0;
for i=1:2*B+3
    sum1=sum1+X(i,1);
end
US1=sum1
%m1_effective
m1_effective=m1*US1
% utilization of S2
sum2=0;
for i=B2+1:B3
    sum2=sum2+X(i,1);
end
US2=sum2-X(2*B2+1,1)-X(B3,1)
%m2_effective
m2_effective=m2*US2
%pososto pou einai blocked to s2
s2_blocked=X(2*B2+1,1)+X(B3,1);
pososto_s2_blocked=100*s2_blocked
%throughput
throughput=m2_effective
% WIP
WIP=0;
for i=1:B2
    WIP=WIP+i*X(i,1);
end
j=2;
for i=B2+1:2*B2
    WIP=WIP+j*X(i,1);
    j=j+1;
end
WIP=WIP+(B+2)*X(2*B2+1,1);
k=2;
for i=2*B2+2:B3-1    
    WIP=WIP+k*X(i,1);
    k=k+1;
end
WIP=WIP+(B+2)*X(B3,1);
WIP
%meso_apothema
%to meso apothema dinetai apo to athroisma ton ginomenon ton timon
%ton apothematon ton katastaseon stis opoies iparxei apothema epi 
%tis antistoixes stasimes pithanotites ton katastaseon auton 
sum4=0;
for i=2:B2
    sum4=sum4+(i-1)*X(i,1);
end
for i=B2+2:2*B2
    sum4=sum4+(i-B2-1)*X(i,1);
end
sum4=sum4+(B2-1)*X(2*B2+1,1);
for i=2*B2+3:B3-1    
   sum4=sum4+(i-2*B2-2)*X(i,1);
end 
sum4=sum4+(B2-1)*X(B3,1);
meso_apothema=sum4;
meso_apothema
%Mean_Cycle_Time
Mean_Cycle_Time=WIP/l_effective;
Mean_Cycle_Time


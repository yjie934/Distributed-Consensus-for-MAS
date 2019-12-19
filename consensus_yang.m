clc;
clear;

% generate the random graph
% N=1000;
% param.distribute=1;
% param.nnparam.epsilon=sqrt(2)*N^(-1/2);
% param.nnparam.type='radius';
% G = gsp_sensor(N, param);


% x0=2*rand(N,1)-1;
% f=x0;

load('G_And_f');
f_oral=f;
A=double(full(G.A));
N=size(f,1);

for i_total=1:1000
    
[Distributed_A,Distributed_f,Distributed_Big_sets,Distributed_Small_sets]=Distributed_processing(A,f);
[Distributed_f_Constant]=Distributed_Frequency_Processing(Distributed_A,Distributed_f,Distributed_Big_sets);

Consensus_Matrix=zeros(N,N);

for i=1:N
    Consensus_Matrix(Distributed_Big_sets{i},i)=Distributed_f_Constant{i};
end

Consensus_Index=zeros(N,N); 

for i=1:N
    Consensus_Index(Distributed_Small_sets{i},i)=1;
end

Consensus_Matrix=Consensus_Matrix.*Consensus_Index;
Consensus_Sum=sum(Consensus_Matrix,2);

for i=1:N
Number_Big(i,1)=(size(Distributed_Big_sets{i},2));
Number_Small(i,1)=(size(Distributed_Small_sets{i},2));
end

for i=1:N
   Consensus_f(i,1)=Consensus_Sum(i,1)/size(Distributed_Small_sets{i},2);
end

% for i=1:N
%     
% end

record(:,i_total+1)=Consensus_f;

% if(max(record(:,i_total+1)-record(:,i_total))<10e-10)
%     break;
% end

   f=Consensus_f;
end
record(:,1)=f_oral;
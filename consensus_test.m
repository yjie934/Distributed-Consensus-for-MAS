% clear all
% clc
% close all

% for i_total=1:100
%     
% % generate the random graph
% N=100;
% param.distribute=1;
% param.nnparam.epsilon=sqrt(2)*N^(-1/2);
% param.nnparam.type='radius';
% G = gsp_sensor(N, param);
% %
% Adjacent_matrix=G.A;

% x0=2*rand(N,1)-1;

load('G_And_f');
x0=f;
Adjacent_matrix=G.A;
N=size(Adjacent_matrix,1);
diag_vec=sum(G.A.');
Laplacian=full(diag(diag_vec)-Adjacent_matrix);

[U,V]=eig(Laplacian);
lamda_set=diag(V);

iterative_seq=[];
xt0_fre=U'*x0;

iterative_seq=[iterative_seq,xt0_fre];

for t=1:N-1
    
    lamda_t=lamda_set(N+1-t);
 
    epsilon=1/lamda_t;

%     xt1_fre=(1-epsilon*lamda_set).*xt0_fre;
    xt1_fre=(1-lamda_set/lamda_t).*xt0_fre;
   
    xt0_fre=xt1_fre;
    
    iterative_seq=[iterative_seq,xt0_fre];
    
end

xT_Jiang=U*xt1_fre;

% condition_number_Laplacian=cond(Laplacian)

% if(norm(xT-mean(x0))>1)
%     break;
% end
% 
% end
% plot(x0)
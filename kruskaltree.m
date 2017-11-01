% 生成图G的 最小生成树的 边表
function MST = kruskaltree(G)
N = length(G); % 图G的顶点数
MST = []; % 记录MST的边表 [u v w]
k = 0;
vis = zeros(1, N); 
vis(1) = 1; 
while k < N-1
    maxw = -inf;
    u = 0; v = 0;
     
    % 找一条最小边
    for i = [1 : N]
        for j = [1 : N]
            if vis(i) == 1 && vis(j) == 0
                if G(i, j) > maxw
                    maxw = G(i, j);
                    u = i; v = j;
                end 
            end
        end % for j
    end % for i
 
    % 加入生成树
    vis(v)  = 1;
    k = k+1;
    MST(k, :) = [u v maxw];
    %uvw = [u v minw] % 打印本次选出的最小边
end
% ����ͼG�� ��С�������� �߱�
function MST = kruskaltree(G)
N = length(G); % ͼG�Ķ�����
MST = []; % ��¼MST�ı߱� [u v w]
k = 0;
vis = zeros(1, N); 
vis(1) = 1; 
while k < N-1
    maxw = -inf;
    u = 0; v = 0;
     
    % ��һ����С��
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
 
    % ����������
    vis(v)  = 1;
    k = k+1;
    MST(k, :) = [u v maxw];
    %uvw = [u v minw] % ��ӡ����ѡ������С��
end
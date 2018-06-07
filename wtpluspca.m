measure=DECIM*360;
%%
for i = 2:36
    eval(['v1runnoise0' num2str(i) '=v(:,i)']);
 end
 %%
for i=2:36
    eval(['cwthaartv' num2str(i) '=cwt(v1runnoise0' num2str(i) ',1:1:8,''db2'',''plot'')']);
end
%%
for i=2:36
    cwthaartv{i}=eval(['cwthaartv' num2str(i)]); 
end;
%%
% 1-v1 2-coeff 3-score 4-vpca%
cwtr1haartall=cwthaartv;
for i=2:36
[cwtr1haartall{2,i},cwtr1haartall{3,i}] = pca(cwtr1haartall{1,i}');
cwtr1haartall{4,i} = cwtr1haartall{1,i}' * cwtr1haartall{2,i}(:,2); %(:,n)pca第n个分量
end
cwtr1haartall{4,1} = zeros(measure,1);

for i=1:36
vr1haart(1:measure,i) = cwtr1haartall{4,i};
end

	sigmay = cov(vr1haart);
	Cx = inv([0 ones(1,n); ones(n,1) sigmay]);
	C = Cx(2:end,2:end);
%%
	Lp = zeros(n);
	V = 1;
    
	while length(V)<n

% 		find edge with minimum weight edge between inV and notinV
		nonV = setdiff(1:n,V);
        test = C(V,nonV);
        test1 = min(C(V,nonV), [], 2);
        test2 = min(test1);
		[dummyvar inV] = min( min( C(V,nonV), [], 2 ) );
		[dummyvar notinV] = min( min( C(V,nonV), [], 1 ) );
		Lp(V(inV),nonV(notinV)) = -1;
		Lp(nonV(notinV),V(inV)) = -1;
		Lp(V(inV),V(inV)) = Lp(V(inV),V(inV)) + 1; %对角线为1
		Lp(nonV(notinV),nonV(notinV)) = Lp(nonV(notinV),nonV(notinV)) + 1; %对角线为1
		V = [V nonV(notinV)];

	end
 %%
%     figure (6)
%     imagesc(C) 
%     colorbar
%     %caxis([-1.5*10000000,(1.5)*10000000])
%     hold on;
%     L_sp = L~=0;
%     spy(L_sp);
%     hold off;
%% 
   Lp_sp = Lp~=0;
   figure
   mid = L_sp - Lp_sp;
   spy(mid);
    
   
   

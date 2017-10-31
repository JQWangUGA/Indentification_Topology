A1=zeros(5766,24);

for i=1:1:24

    variableName=['ScopeData',num2str(i),'.signals.values']
    A1(:,i)=eval(variableName);


end

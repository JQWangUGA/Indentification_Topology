T=zeros(24);
T(MST(1,1),MST(1,2))=1;
T(MST(2,1),MST(2,2))=1;
T(MST(3,1),MST(3,2))=1;
T(MST(4,1),MST(4,2))=1;
T(MST(5,1),MST(5,2))=1;
T(MST(6,1),MST(6,2))=1;
T(MST(7,1),MST(7,2))=1;
T(MST(8,1),MST(8,2))=1;
T(MST(9,1),MST(9,2))=1;
T(MST(10,1),MST(10,2))=1;
T(MST(11,1),MST(11,2))=1;
T(MST(12,1),MST(12,2))=1;
T(MST(13,1),MST(13,2))=1;
T(MST(14,1),MST(14,2))=1;
T(MST(15,1),MST(15,2))=1;
T(MST(16,1),MST(16,2))=1;
T(MST(17,1),MST(17,2))=1;
T(MST(18,1),MST(18,2))=1;
T(MST(19,1),MST(19,2))=1;
T(MST(20,1),MST(20,2))=1;
T(MST(21,1),MST(21,2))=1;
T(MST(22,1),MST(22,2))=1;
T(MST(23,1),MST(23,2))=1;

T(MST(1,2),MST(1,1))=1;
T(MST(2,2),MST(2,1))=1;
T(MST(3,2),MST(3,1))=1;
T(MST(4,2),MST(4,1))=1;
T(MST(5,2),MST(5,1))=1;
T(MST(6,2),MST(6,1))=1;
T(MST(7,2),MST(7,1))=1;
T(MST(8,2),MST(8,1))=1;
T(MST(9,2),MST(9,1))=1;
T(MST(10,2),MST(10,1))=1;
T(MST(11,2),MST(11,1))=1;
T(MST(12,2),MST(12,1))=1;
T(MST(13,2),MST(13,1))=1;
T(MST(14,2),MST(14,1))=1;
T(MST(15,2),MST(15,1))=1;
T(MST(16,2),MST(16,1))=1;
T(MST(17,2),MST(17,1))=1;
T(MST(18,2),MST(18,1))=1;
T(MST(19,2),MST(19,1))=1;
T(MST(20,2),MST(20,1))=1;
T(MST(21,2),MST(21,1))=1;
T(MST(22,2),MST(22,1))=1;
T(MST(23,2),MST(23,1))=1;





[a,b]=find(T==1);
plot(a,b,'s','MarkerFaceColor','r');
set(gca,'XTick',[0:1:25]);
set(gca,'YTick',[0:1:25]);
xlabel('Node');
ylabel('Node');
grid on;

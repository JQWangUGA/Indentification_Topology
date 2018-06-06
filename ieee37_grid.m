% describes the IEEE 37 test feeder

% number of nodes

G.n = 36;

% node labels

G.labels = [	799; ...
		701; ...
		712; ...
		713; ...
		714; ...
		718; ...
		720; ...
		722; ...
		724; ...
		725; ...
		727; ...
		728; ...
		729; ...
		730; ...
		731; ...
		732; ...
		733; ...
		734; ...
		735; ...
		736; ...
		737; ...
		738; ...
		740; ...
		741; ...
		742; ...
		744; ...
		702; ...
		703; ...
		704; ...
		705; ...
		706; ...
		707; ...
		708; ...
		709; ...
		710; ...
		711];

% incidence matrix

A = horzcat( ...
  ee([-2 27], G.n), ...
  ee([-27 30], G.n), ...
  ee([-27 4], G.n), ...
  ee([-27 28], G.n), ...
  ee([-28 11], G.n), ...
  ee([-28 14], G.n), ...
  ee([-29 5], G.n), ...
  ee([-29 7], G.n), ...
  ee([-30 25], G.n), ...
  ee([-30 3], G.n), ...
  ee([-31 10], G.n), ...
  ee([-32 9], G.n), ...
  ee([-32 8], G.n), ...
  ee([-33 17], G.n), ...
  ee([-33 16], G.n), ...
  ee([-34 15], G.n), ...
  ee([-34 33], G.n), ...
  ee([-35 19], G.n), ...
  ee([-35 20], G.n), ...
  ee([-36 24], G.n), ...
  ee([-36 23], G.n), ...
  ee([-4 29], G.n), ...
  ee([-5 6], G.n), ...
  ee([-7 32], G.n), ...
  ee([-7 31], G.n), ...
  ee([-11 26], G.n), ...
  ee([-14 34], G.n), ...
  ee([-17 18], G.n), ...
  ee([-18 21], G.n), ...
  ee([-18 35], G.n), ...
  ee([-21 22], G.n), ...
  ee([-22 36], G.n), ...
  ee([-26 12], G.n), ...
  ee([-26 13], G.n), ...
  ee([-1 2], G.n));

G.A = A';
clear A;

% number of edges

G.m = size(G.A,1);

% vector of impedances

R = [	0.0863818182; ...
	0.1587272727; ...
	0.0882; ...
	0.118775; ...
	0.0952363636; ...
	0.147; ...
	0.0317454545; ...
	0.196; ...
	0.1269818182; ...
	0.0952363636; ...
	0.1111090909; ...
	0.3015818182; ...
	0.0476181818; ...
	0.0784; ...
	0.1269818182; ...
	0.147; ...
	0.0784; ...
	0.0793636364; ...
	0.5079272727; ...
	0.098; ...
	0.0793636364; ...
	0.1274; ...
	0.2063454545; ...
	0.3650727273; ...
	0.147; ...
	0.0686; ...
	0.049; ...
	0.1372; ...
	0.1568; ...
	0.2063454545; ...
	0.098; ...
	0.098; ...
	0.0793636364; ...
	0.1111090909; ...
	0.1025208333];

X = [	0.0540545455; ...   
	0.0587727273; ...
	0.0457704545; ...
	0.074325; ... 
	0.0352636364; ...
	0.0762840909; ...
	0.0117545455; ...
	0.1017121212; ...
	0.0470181818; ...
	0.0352636364; ...
	0.0411409091; ...
	0.1116681818; ...
	0.0176318182; ...
	0.0406848485; ...
	0.0470181818; ...
	0.0762840909; ...
	0.0406848485; ...
	0.0293863636; ...
	0.1880727273; ...
	0.0508560606; ...
	0.0293863636; ...
	0.0661128788; ...
	0.0764045455; ...
	0.1351772727; ...
	0.0762840909; ...
	0.0355992424; ...
	0.0254280303; ...
	0.0711984848; ...
	0.081369697; ...
	0.0764045455; ...
	0.0508560606; ...
	0.0508560606; ...
	0.0293863636; ...
	0.0411409091; ...
	0.0691297348];  

G.z = R + 1j*X;
%G.z = abs(G.z)*exp(j*0.35);

clear X R;

% vector of distances (ft.)

G.D = [960; ...
    400; ...
    360; ...
    1320; ...
    240; ...
    600; ...
    80; ...
    800; ...
    320; ...
    240; ...
    280; ...
    760; ...
    120; ...
    320; ...
    320; ...
    600; ...
    320; ...
    200; ...
    1280; ...
    400; ...
    200; ...
    520; ...
    520; ...
    920; ...
    600; ...
    280; ...
    200; ...
    560; ...
    640; ...
    520; ...
    400; ...
    400; ...
    200; ...
    280; ...
    1850];

% name of the PCC

G.PCClabel = 799;

% index of the PCC

G.PCC = find(G.labels == G.PCClabel);

% nominal voltage

G.UN = 4800;

% PCC voltage 

G.U0 = G.UN; %* exp(1j * 2*pi*rand);

% vector of static model exponents

G.eta = [	0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		2; ...
		0; ...
		0; ...
		2; ...
		0; ...
		0; ...
		0; ...
		0; ...
		2; ...
		2; ...
		0; ...
		0; ...
		0; ...
		0; ...
		2; ...
		0; ...
		0; ...
		0; ...
		0; ...
		2; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0; ...
		0];
    
G.eta=0*G.eta;

% weighted laplacian

G.L = G.A' * diag(1./G.z) * G.A;

% distances laplacian

G.Ld = G.A' * diag(1./G.D) * G.A;

% Green-like matrix

X = inv([G.L ee(G.PCC,G.n); ee(G.PCC,G.n)' 0]);
G.X = X(1:G.n,1:G.n);

clear X acomp ancomp;


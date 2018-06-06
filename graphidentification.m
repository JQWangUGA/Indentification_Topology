clear all
close all
clc

randn('seed', time);
rand('seed', time);

addpath('matpower4.1');
define_constants;

ieee37_grid;

[sss iii] = sort(G.labels);
L = G.L(iii,iii);
labels = G.labels(iii);
clear C G;

% SOLVER OPTIONS
mpopt=mpoption('OUT_ALL',0,'VERBOSE',0);

% GRID MODEL
mpc = loadcase('case_ieee37PQ');
n = size(mpc.bus(:, QD),1);

% LOAD PROFILE
load loadprofile
basePD = mpc.bus(:, PD);
baseQD = mpc.bus(:, QD);

RUNS = 1;

for DECIM = [2] % 2 4
for NOISE = [0]
%0 0.05 0.1 0.2 0.3 0.5 1 1.5 2.5 5

aver = 0;

for run=1:RUNS

	TSTOP = DECIM*360;

	v = zeros(TSTOP,n);

	for t=1:TSTOP

		tau = ceil(t/DECIM);
		% update power demands
		mpc.bus(:, PD) = basePD - real(DD(:,tau))/mpc.baseMVA/1e6 + 2e-1*randn(size(basePD));
		mpc.bus(:, QD) = baseQD - imag(DD(:,tau))/mpc.baseMVA/1e6 + 2e-1*randn(size(baseQD));

		results = runpf(mpc,mpopt);
		v(t,:) = results.bus(:,VM)' + NOISE/100/3*randn(1,n);
		v(t,:) = v(t,:) - v(t,end);

	end

	obs = [2 4 6 8 10 12 14 16 18 20];
	n = length(obs);

	v = v(:,obs);
	v = v - v(:,1) * ones(1,n);

	sigmay = cov(v);

	%figure(1)
	%imagesc(sigmay);

	Cx = inv([0 ones(1,n); ones(n,1) sigmay]);
	C = Cx(2:end,2:end);

	% Prim algorithm (minimum spanning tree)
	Lp = zeros(n);
	V = 1;

	while length(V)<n

		% find edge with minimum weight edge between inV and notinV
		nonV = setdiff(1:n,V);
		[dummyvar inV] = min( min( C(V,nonV), [], 2 ) );
		[dummyvar notinV] = min( min( C(V,nonV), [], 1 ) );
		Lp(V(inV),nonV(notinV)) = -1;
		Lp(nonV(notinV),V(inV)) = -1;
		Lp(V(inV),V(inV)) = Lp(V(inV),V(inV)) + 1;
		Lp(nonV(notinV),nonV(notinV)) = Lp(nonV(notinV),nonV(notinV)) + 1;
		V = [V nonV(notinV)];

	end


	% figure(2)
	% spy(Lp);
	Lp_sp = Lp~=0;

	% figure(3)
	L_sp = L~=0;
	% spy(L_sp);

	% figure(4)
	% spy(L_sp-Lp_sp)

	if any(L_sp-Lp_sp) 
		aver = aver + 1;
	end


end

fprintf(1, 'Noise %f, measures %f, average error %f \n', [NOISE TSTOP aver/RUNS]);
fflush(stdout);

end
end





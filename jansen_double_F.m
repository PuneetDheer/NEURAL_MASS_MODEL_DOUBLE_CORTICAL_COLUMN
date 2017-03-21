%CODED BY : PUNEET DHEER
%DATE : 07-03-2017
%DOUBLE CORTICAL COLUMN MODEL
%REFERENCES
%[1]Jansen BH, Zouridakis G, Brandt ME (1993)
%   A neurophysiologically-based mathematical model of flash visual evoked potentials. 
%   Biol Cybern 68: 275-283
%[2]Jansen  BH,  Rit  VG  (1995)  Electroencephalogram  and  visual evoked potential 
%   generation in a mathematical model of coupled cortical columns. Biol Cybern 73: 357-366

function ydot=jansen_double_F(t,y)
t

a = 100;  %rate constant for postsynaptic population response to excitatory input
b = 50;   %rate constant for postsynaptic population response to inhibitory input
A = 3.25; % max. amplitude of EXCITATORY(EPSP) mV
B = 22;   % max. amplitude of INHIBITORY(IPSP) mV
C = 135;  % (lumped connectivity constant) Average No. of SynapseS
C1 = C;         %pyramidal to excitatory interneurons EIN
C2 = 0.8 * C;   %excitatory interneurons(EIN) to pyramidal
C3 = 0.25 * C;  %pyramidal to inhibitory interneurons (IIN)
C4 = 0.25 * C;  %inhibitory interneurons(IIN) to pyramidal


AA = 3.25;
BB = 17.6;
CC = 108;
CC1 = CC;
CC2 = 0.8 * CC;
CC3 = 0.25 * CC;
CC4 = 0.25 * CC;

ad = a/3;

%Coupling Parameters
K12=600;%600,800 %0-8000 steps of 50-4000 unit
K21=1000; %0-1500 steps of 100-500 unit

MEAN = 120;%120;
SIGMA = 200;%200; %SD

p= MEAN+(rand*SIGMA); %uniformly distributed white noise
pp= MEAN+(rand*SIGMA);
% pp= MEAN+(randn*SIGMA);%Gaussian White Noise

ydot = zeros(16,1);

%Y(1),Y(2),Y(3) are the outputs of the three PSP blocks
%y(1)_psp block-> AVERAGE (EPSP) MEMBRANE POTENTIAL for the EIN and IIN
%y(2)_psp block-> AVERAGE (IPSP) MEMBRANE POTENTIAL for the PYRAMIDAL_NEU_P
%y(3)_psp block-> AVERAGE (EPSP) MEMBRANE POTENTIAL for the PYRAMIDAL_NEU_P
%OUTPUT = y(2)-y(3) SUMMED PSP at PYRAMIDAL_NEU_P (mV)

%COLUMN 1 VISUAL CORTEX ALPHA ACTIVITY
ydot(1) = y(4); %ydot0
ydot(2) = y(5); %ydot1
ydot(3) = y(6); %ydot2

ydot(4) = A*a*S(y(2)-y(3)) - 2*a*y(4) - a*a*y(1);%ydot3 excitatory synaptic input to the EIN and IIN

ydot(5) = A*a*((p+C2*S(C1*y(1)))+K21*y(14)) - 2*a*y(5) - a*a*y(2); %ydot4 excitatory synaptic input to the pyramidal population,

ydot(6) = B*b*(C4*S(C3*y(1))) - 2*b*y(6) - b*b*y(3); %ydot5 inhibitory synaptic input to the pyramidal population,

%COLUMN 2 PREFRONTAL CORTEX BETA ACTIVITY
ydot(7) = y(10);
ydot(8) = y(11);
ydot(9) = y(12);

ydot(10) = AA*a*S(y(8)-y(9)) - 2*a*y(10) - a*a*y(7);

ydot(11) = AA*a*((pp+CC2*S(CC1*y(7)))+K12*y(13)) - 2*a*y(11) - a*a*y(8);

ydot(12) = BB*b*(CC4*S(CC3*y(7))) - 2*b*y(12) - b*b*y(9);

%INTERCOLUMN BRANCHES
%Y(13) IS THE OUTPUT OF THE EPSP BLOCK THAT IS LINKING COLUMN1 TO COLUMN2
%Y(14) IS THE OUTPUT OF THE EPSP BLOCK THAT IS LINKING COLUMN2 TO COLUMN1
%
ydot(13) = y(15);
ydot(14) = y(16);

ydot(15) = AA*ad*S(y(2)-y(3)) - 2*ad*y(15) - a*a*y(13);

ydot(16) = AA*ad*S(y(8)-y(9)) - 2*ad*y(16) - a*a*y(14);


end

% Sigmoid function
function r = S(v)
%r = 2*e / (1.0 + exp(r * (V - v)));
%e=2.5,max firing rate of neural population
%r=0.56, steepness of sigmoid transformation
%V=6, PSP mV

r = 5.0 / (1.0 + exp(0.56 * (6.0 - v)));


end


%for wendling model
%p varies between 30 and 150 pulse per second
%then, mean=90 and std=30 gaussian white noise


% Note: Refer reference[2]
% 1) For small values of K21(<200), the output of column 1 was of the waxing and waning type, 
% irrespective of the value of K12.

% 2) As K21 was increased, the additional feedback progressively saturated column 1, 
% causing the output to wax and wane more sharply, displaying more high-frequency 
% components until it eventually resembled beta activity.

% 3) The output of column 2 resembled beta activity when the column
% operated  independently, i.e.,  for  small  K12 and  K21.

% 4) For K21 < 500, increasing K12 causes column 2 gradually to change its output from beta-like to 
% alpha-like activity. 

% 5) However,  for  K21  > 700,  column  2  produced  beta-like activity exclusively.





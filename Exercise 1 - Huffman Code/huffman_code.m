close all
clear
clc

%% Parameters
p = [1/2 1/8 1/8 1/16 1/16 1/16 1/16];
symbols = 1:length(p);
L_symbol = length(symbols);

%% 10,000 Sequence wite Px probability
FileSize = 10000;
sym = randsample(length(p),FileSize,true,p)';

% Symbol probability
Prob = zeros(1,L_symbol);
for i=1:L_symbol
    Prob(i) = length(find(sym == i))/FileSize;
end
figure()
histogram(sym-1)
grid on
grid minor


%% Simple binary representation
bin_dict = [{1}, {[0,0,0]};...
            {2},{[0,0,1]};...
            {3},{[0,1,0]};...
            {4},{[0,1,1]};...
            {5},{[1,0,0]};...
            {6},{[1,0,1]};...
            {7},{[1,1,0]}];
sim_code = bin_dict(sym,2)';
sim_code_vec = cell2mat(sim_code);
sim_p_1 = sum(sim_code_vec)/length(sim_code_vec);
sim_p_0 = 1 - sim_p_1;
sim_ExpLength = length(sim_code_vec)/FileSize;

%% Huffman code
dict = huffmandict(symbols,p);
huf_code = dict(sym,2)';
huf_code_vec = cell2mat(huf_code);
huf_p_1 = sum(huf_code_vec)/length(huf_code_vec);
huf_p_0 = 1 - huf_p_1;
huf_ExpLength = length(huf_code_vec)/FileSize;

%% Results
disp('Simulation Results:')
disp(['File Size = ',num2str(FileSize)])
for i=1:L_symbol
    disp(['Prob(x = ',num2str(i-1),') = ',num2str(Prob(i))])
end
disp('___________________')
disp('Simple Binary Code:')
disp(['Expected Length = ',num2str(sim_ExpLength)])
disp(['Prob(b = 0) = ',num2str(sim_p_0)])
disp(['Prob(b = 1) = ',num2str(sim_p_1)])
disp('___________________')
disp('Huffman Code:')
disp(['Expected Length = ',num2str(huf_ExpLength)])
disp(['Prob(b = 0) = ',num2str(huf_p_0)])
disp(['Prob(b = 1) = ',num2str(huf_p_1)])


%Read in hackathon data
train_S002_night1_hackathon_filt = load('train_S002_night1_hackathon_filt.mat');
train_S002_night1_hackathon_raw = load('train_S002_night1_hackathon_raw.mat');
EEG_filt = train_S002_night1_hackathon_filt.EEG;
EEG_raw = train_S002_night1_hackathon_raw.EEG;

filt_data_1_to_35Hz = EEG_filt.data(1,:);
filt_data_4_to_18Hz = EEG_filt.data(2,:);
times = EEG_filt.times;

raw_data = EEG_raw.data;

fs = EEG_raw.srate;
window_len_sec = 30; %seconds
window_len = 30*fs; %window length in samples

%Read in marker data
T = readtable('train_S002_labeled.csv');
Timestamp = T{:,1};
Epochs = T{:,2};
SS1 = T{:,3};
SS0 = T{:,4};
K1 = T{:,5};
K0 = T{:,6};
REM1 = T{:,7};
REM0 = T{:,8};
Son1 = T{:,9};
Son0 = T{:,10};
Soff1 = T{:,11};
Soff0 = T{:,12};
A1 = T{:,13};
A0 = T{:,14};
MS1 = T{:,15};
MS0 = T{:,16};

%Split datasets into epochs
raw_data_len = length(raw_data)-1;
raw_epochs_len = [window_len*ones(1,fix(raw_data_len/window_len)),1+rem(raw_data_len,window_len)];

raw_epochs = mat2cell(raw_data,1,raw_epochs_len);
filt_data_1_to_35Hz_epochs = mat2cell(filt_data_1_to_35Hz,1,raw_epochs_len);
filt_data_4_to_18Hz_epochs = mat2cell(filt_data_4_to_18Hz,1,raw_epochs_len);



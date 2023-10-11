function [Alignment_Times] = EMGMaxAlignmentTimes(xds, target_dir, target_center)

%% Catch possible sources of error

% If there is no EMG
if ~isfield(xds, 'EMG')
    disp('No EMG in this file');
    Alignment_Times = NaN;
    return
end

%% Times for rewarded trials

[rewarded_gocue_time] = GoCueAlignmentTimes(xds, target_dir, target_center);
[rewarded_end_time] = TrialEndAlignmentTimes(xds, target_dir, target_center);

%% Find the EMG index

[muscle_groups] = Hand_Muscle_Match(xds, target_dir);
[M] = EMG_Index(xds, muscle_groups);

%% Extracting EMG & time during successful trials

% EMG and time measured during each successful trial 
EMG = struct([]); % EMG during each successful trial 
timings = struct([]); % Time points during each succesful trial 
for ii = 1:length(rewarded_gocue_time)
    idx = find((xds.time_frame > rewarded_gocue_time(ii)) & ...
        (xds.time_frame < rewarded_end_time(ii)));
    for mm = 1:length(M)
        EMG{ii, 1}(:,mm) = xds.EMG(idx, M(mm));
    end
    timings{ii, 1} = xds.time_frame(idx);
end

%% Sum the EMG to find the summed max
summed_EMG = struct([]);
for ii = 1:length(EMG)
    for mm = 1:length(EMG{ii,1})
        summed_EMG{ii,1}(mm,1) = sum(EMG{ii,1}(mm,:));
    end
end

%% Defines onset time via the maximum EMG
EMG_max_idx = zeros(length(rewarded_gocue_time),1);

% Loops through EMG
for ii = 1:length(rewarded_gocue_time)
    EMG_max_idx(ii) = find(summed_EMG{ii,1} == max(summed_EMG{ii,1})); 
end
    
%% Convert the onset_time_idx array into actual timings in seconds

Alignment_Times = zeros(length(timings),1);
for ii = 1:length(timings)
    Alignment_Times(ii) = timings{ii, 1}(EMG_max_idx(ii));
end






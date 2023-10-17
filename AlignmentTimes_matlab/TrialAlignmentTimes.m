function [Alignment_Times] = TrialAlignmentTimes(xds, target_dir, target_center, event)

%% Indexes for rewarded trials

[rewarded_idxs] = Rewarded_Indexes(xds, target_dir, target_center);

%% Loops to extract only rewarded trials

temp_event = extractAfter(event, 'trial_');
trial_idx = contains(xds.trial_info_table_header, temp_event);
% Time's for succesful trials
Alignment_Times = zeros(height(rewarded_idxs),1);
for ii = 1:height(rewarded_idxs)
    Alignment_Times(ii) = cell2mat(xds.trial_info_table(rewarded_idxs(ii), trial_idx));
end

% Round to match the neural bin size
Alignment_Times = round(Alignment_Times, abs(floor(log10(xds.bin_width))));






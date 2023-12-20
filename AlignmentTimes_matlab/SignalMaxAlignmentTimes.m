function [Alignment_Times] = SignalMaxAlignmentTimes(xds, target_dir, target_center, event)

%% Extract the signal corresponding to the event
[Signal, Timing] = Extract_Signal(xds, target_dir, target_center, event);

%% Find the maximum of the signal

Signal_max_idx = zeros(length(Signal),1);
% Loop through each trial
for ii = 1:length(Signal)
    % Find the maximum
    max_Signal = max(Signal{ii,1});
    temp = find(Signal{ii,1} == max_Signal);
    Signal_max_idx(ii) = temp(1);
end

%% Convert the onset_time_idx array into actual timings in seconds

Alignment_Times = zeros(length(Timing),1);
for ii = 1:length(Timing)
    Alignment_Times(ii) = Timing{ii, 1}(Signal_max_idx(ii));
end






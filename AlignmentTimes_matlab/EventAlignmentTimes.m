function [Alignment_Times] = EventAlignmentTimes(xds, target_dir, target_center, event)

%% Extract the trials of the intended signal

% EMG_onset, window_EMG_onset, ...
% force_onset, window_force_onset, ...
% cursor_onset, window_cursor_onset, ...
if contains(event, 'onset')
    [Alignment_Times] = SignalOnsetAlignmentTimes(xds, target_dir, target_center, event);
end

% trial_goCue, window_trial_goCue, ...
% trial_end, window_trial_end, ...
% trial_start, window_trial_start, ...
if contains(event, 'trial')
    [Alignment_Times] = TrialAlignmentTimes(xds, target_dir, target_center, event);
end

% EMG_max, window_EMG_max, ...
% force_max, window_force_max, ...
% cursor_max, window_cursor_max, ...
if contains(event, 'max')
    [Alignment_Times] = SignalMaxAlignmentTimes(xds, target_dir, target_center, event);
end

%% Run the function according to the event

if contains(event, 'TgtHold')
    [Alignment_Times] = TgtHoldAlignmentTimes(xds, target_dir, target_center);
end

if contains(event, 'cursor_veloc')
    [Alignment_Times] = CursorVelocAlignmentTimes(xds, target_dir, target_center);
end

if contains(event, 'cursor_acc')
    [Alignment_Times] = CursorAccAlignmentTimes(xds, target_dir, target_center);
end

if contains(event, 'force_deriv')
    [Alignment_Times] = ForceDerivAlignmentTimes(xds, target_dir, target_center);
end


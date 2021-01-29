function [outtable] = createAdaptiveTable(Adaptive)
%% 
% Function to unravel Adaptive time series data, creating a table with all
% variables
%
% Input: a structure of time domain data that is read from AdaptiveLog.json
% (To transform *.json file into structure use deserializeJSON.m)
%%

numRecords = length(Adaptive); % If fix was required when opening JSON file, dimensions may be flipped

AdaptiveUpdate = [Adaptive.AdaptiveUpdate];
fieldNames = {'PacketGenTime','PacketRxUnixTime','CurrentProgramAmplitudesInMilliamps',...
    'IsInHoldOffOnStartup','StateEntryCount',...
    'StateTime','StimRateInHz'};
for iName = 1:length(fieldNames)
    data.(fieldNames{iName}) = [AdaptiveUpdate.(fieldNames{iName})]';
end

% Convert CurrentAdaptiveState
temp_currentAdaptiveState = [AdaptiveUpdate.CurrentAdaptiveState]';
CurrentAdaptiveState(temp_currentAdaptiveState == 0) = {'State 0'};
CurrentAdaptiveState(temp_currentAdaptiveState == 1) = {'State 1'};
CurrentAdaptiveState(temp_currentAdaptiveState == 2) = {'State 2'};
CurrentAdaptiveState(temp_currentAdaptiveState == 3) = {'State 3'};
CurrentAdaptiveState(temp_currentAdaptiveState == 4) = {'State 4'};
CurrentAdaptiveState(temp_currentAdaptiveState == 5) = {'State 5'};
CurrentAdaptiveState(temp_currentAdaptiveState == 6) = {'State 6'};
CurrentAdaptiveState(temp_currentAdaptiveState == 7) = {'State 7'};
CurrentAdaptiveState(temp_currentAdaptiveState == 8) = {'State 8'};
CurrentAdaptiveState(temp_currentAdaptiveState == 15) = {'No State'};
data.('CurrentAdaptiveState') = CurrentAdaptiveState';

% Convert detector status
temp_Ld0DetectionStatus = [AdaptiveUpdate.Ld0DetectionStatus]';
Ld0DetectionStatus(temp_Ld0DetectionStatus == 0) = {'None'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 1) = {'Low Immediate Detect'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 2) = {'High Immediate Detect'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 4) = {'Low Detect'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 8) = {'High Detect'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 16) = {'Output over Range'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 32) = {'Blanked'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 64) = {'Input over Range'};
Ld0DetectionStatus(temp_Ld0DetectionStatus == 128) = {'In Hold Off'};
data.('Ld0DetectionStatus') = Ld0DetectionStatus';

% Convert detector status
temp_Ld1DetectionStatus = [AdaptiveUpdate.Ld1DetectionStatus]';
Ld1DetectionStatus(temp_Ld1DetectionStatus == 0) = {'None'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 1) = {'Low Immediate Detect'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 2) = {'High Immediate Detect'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 4) = {'Low Detect'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 8) = {'High Detect'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 16) = {'Output over Range'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 32) = {'Blanked'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 64) = {'Input over Range'};
Ld1DetectionStatus(temp_Ld1DetectionStatus == 128) = {'In Hold Off'};
data.('Ld1DetectionStatus') = Ld1DetectionStatus';

% Convert PreviousAdaptiveState
temp_previousAdaptiveState = [AdaptiveUpdate.PreviousAdaptiveState]';
PreviousAdaptiveState(temp_previousAdaptiveState == 0) = {'State 0'};
PreviousAdaptiveState(temp_previousAdaptiveState == 1) = {'State 1'};
PreviousAdaptiveState(temp_previousAdaptiveState == 2) = {'State 2'};
PreviousAdaptiveState(temp_previousAdaptiveState == 3) = {'State 3'};
PreviousAdaptiveState(temp_previousAdaptiveState == 4) = {'State 4'};
PreviousAdaptiveState(temp_previousAdaptiveState == 5) = {'State 5'};
PreviousAdaptiveState(temp_previousAdaptiveState == 6) = {'State 6'};
PreviousAdaptiveState(temp_previousAdaptiveState == 7) = {'State 7'};
PreviousAdaptiveState(temp_previousAdaptiveState == 8) = {'State 8'};
PreviousAdaptiveState(temp_previousAdaptiveState == 15) = {'No State'};
data.('PreviousAdaptiveState') = PreviousAdaptiveState';

% Convert SensingStatus
temp_SensingStatus = [AdaptiveUpdate.SensingStatus]';
data.('SensingStatus') = cellstr(dec2bin(temp_SensingStatus,8));

% Convert StimFlags
temp_StimFlags = [AdaptiveUpdate.StimFlags]';
data.('StimFlags') = cellstr(dec2bin(temp_StimFlags,8));


Header = [AdaptiveUpdate.Header];
fieldNames = {'dataTypeSequence','systemTick'}; % Under AdaptiveUpdate.Header
for iName = 1:length(fieldNames)
    data.(fieldNames{iName}) = [Header.(fieldNames{iName})]';
end

Timestamp = [Header.timestamp];
data.timestamp = struct2array(Timestamp)';

Ld0Status = [AdaptiveUpdate.Ld0Status];
fieldNames = {'featureInputs','fixedDecimalPoint','highThreshold',...
    'lowThreshold','output'};
for iName = 1:length(fieldNames)
    data.(['Ld0_' fieldNames{iName}]) = [Ld0Status.(fieldNames{iName})]';
end

Ld1Status = [AdaptiveUpdate.Ld1Status];
fieldNames = {'featureInputs','fixedDecimalPoint','highThreshold',...
    'lowThreshold','output'};
for iName = 1:length(fieldNames)
    data.(['Ld1_' fieldNames{iName}]) = [Ld1Status.(fieldNames{iName})]';
end

outtable = struct2table(data);
end
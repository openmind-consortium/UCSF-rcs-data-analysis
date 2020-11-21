function [newEntry,powerChannels,fftConfig] = addNewEntry_PowerDomainSettings(actionType,recNum,currentSettings,TDsettings,powerChannels,fftConfig)
%%
% Extract powerDomain settings data in order to add a new row to the
% Power_SettingsTable; ensures that all table fields are filled for each
% entry (otherwise warning will print)
%
%%
HostUnixTime = currentSettings.RecordInfo.HostUnixTime;

newEntry.action = actionType;
newEntry.recNum = recNum;
newEntry.time = HostUnixTime;

if isfield(currentSettings,'SensingConfig') && isfield(currentSettings.SensingConfig,'powerChannels')
    powerChannels = currentSettings.SensingConfig.powerChannels;
end
newEntry.powerBands = powerChannels;

% Get sample rate for each TD channel; all TD channels have
% same Fs (or is listed as NaN)
for iChan = 1:4
    TDsampleRates(iChan) = str2double(TDsettings(iChan).sampleRate(1:end-2));
end
TDsampleRates = unique(TDsampleRates);
currentTDsampleRate = TDsampleRates(~isnan(TDsampleRates));
newEntry.TDsampleRates = currentTDsampleRate;

% Get fftConfig info if updated
if isfield(currentSettings,'SensingConfig') && isfield(currentSettings.SensingConfig,'fftConfig')
    fftConfig = currentSettings.SensingConfig.fftConfig;
end
newEntry.fftConfig = fftConfig;

end
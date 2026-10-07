%% Add nix to path
% Path for the folder 'nix-mx_Win64_1.4.1'
addpath('nix-mx_Win64_1.4.1\')

%% Open NIX file
% Path of the selected file
file_path = 'Data_Subject_01_Session_01.h5';
f = nix.File(file_path,nix.FileMode.ReadOnly);

%% Read metadata
% Display names of all sections
cellfun(@(x) disp(x.name),f.sections)

%% General information
sectionGeneral = f.openSection('General');
% Properties
cellfun(@(x) disp(x.name),sectionGeneral.properties)
% Institution
fprintf(['Institution: ',sectionGeneral.openProperty('Institution').values{1}.value,'\n'])
% Recording location
fprintf(['Recording location: ',sectionGeneral.openProperty('Recording location').values{1}.value,'\n'])
% Sections
cellfun(@(x) disp(x.name),sectionGeneral.sections)
% Publications
sectionPublications = sectionGeneral.openSection('Related publications');
cellfun(@(x) disp(x.name),sectionPublications.properties)
fprintf(['Publication name: ',sectionPublications.openProperty('Publication name').values{1}.value,'\n'])
fprintf(['Publication DOI: ',sectionPublications.openProperty('Publication DOI').values{1}.value,'\n'])
% Recording setup
sectionRecordingSetup = sectionGeneral.openSection('Recording setup');
cellfun(@(x) disp(x.name),sectionRecordingSetup.properties)
fprintf(['Recording setup iEEG: ',sectionRecordingSetup.openProperty('Recording setup iEEG').values{1}.value,'\n'])
fprintf(['Recording setup EEG: ',sectionRecordingSetup.openProperty('Recording setup EEG').values{1}.value,'\n'])

%% Task information
sectionTask = f.openSection('Task');
% Properties
cellfun(@(x) disp(x.name),sectionTask.properties)
% Task characteristics
fprintf(['Task name: ',sectionTask.openProperty('Task name').values{1}.value,'\n'])
fprintf(['Task description: ',sectionTask.openProperty('Task description').values{1}.value,'\n'])
fprintf(['Task URL: ',sectionTask.openProperty('Task URL').values{1}.value,'\n'])

%% Subject information
sectionSubject = f.openSection('Subject');
% Properties
cellfun(@(x) disp(x.name),sectionSubject.properties)
% Subject characteristics
fprintf(['Age: ',num2str(sectionSubject.openProperty('Age').values{1}.value),'\n'])
fprintf(['Sex: ',sectionSubject.openProperty('Sex').values{1}.value,'\n'])
fprintf(['Handedness: ',sectionSubject.openProperty('Handedness').values{1}.value,'\n'])
fprintf(['Pathology: ',sectionSubject.openProperty('Pathology').values{1}.value,'\n'])
fprintf(['Depth electrodes: ',sectionSubject.openProperty('Depth electrodes').values{1}.value,'\n'])
fprintf(['Electrodes in seizure onset zone (SOZ): ',sectionSubject.openProperty('Electrodes in seizure onset zone (SOZ)').values{1}.value,'\n'])

%% Session information
sectionSession = f.openSection('Session');
% Properties
cellfun(@(x) disp(x.name),sectionSession.properties)
% Session characteristics
fprintf(['Number of trials: ',num2str(sectionSession.openProperty('Number of trials').values{1}.value),'\n'])
fprintf(['Trial duration: ',num2str(sectionSession.openProperty('Trial duration').values{1}.value),' ',sectionSession.openProperty('Trial duration').unit,'\n'])
% Sections
cellfun(@(x) disp(x.name),sectionSession.sections)

%% Trial information
sectionTrialProperties = sectionSession.openSection('Trial properties');
% Sections
cellfun(@(x) disp(x.name),sectionTrialProperties.sections)
% Each section is for a single trial
% Select trial
nTrial = 1;
sectionSingleTrial = sectionTrialProperties.sections{nTrial};

%% Single trial
% Properties
cellfun(@(x) disp(x.name),sectionSingleTrial.properties)
for nProperty = 1:length(sectionSingleTrial.properties)
    switch sectionSingleTrial.properties{nProperty}.datatype
        case {'double','logical'}
            fprintf([sectionSingleTrial.properties{nProperty}.name,': ',num2str(sectionSingleTrial.properties{nProperty}.values{1}.value),'\n'])
        otherwise
            fprintf([sectionSingleTrial.properties{nProperty}.name,': ',sectionSingleTrial.properties{nProperty}.values{1}.value,'\n'])
    end
end

%% Blocks
cellfun(@(x) disp(x.name),f.blocks)
block = f.blocks{1};

%% Groups of data arrays, tags, multitags
groups = block.groups;
cellfun(@(x) disp(x.name),block.groups)

%% Select trial
nTrial = 1;

%% iEEG data
group_iEEG = block.openGroup('iEEG data');
% Data array
dataArray_iEEG = group_iEEG.dataArrays{nTrial};

% Electrode labels
striEEGLabels = dataArray_iEEG.dimensions{1}.labels;
% Time axis
tiEEG = (0:(double(dataArray_iEEG.dataExtent(2))-1))*dataArray_iEEG.dimensions{2}.samplingInterval+dataArray_iEEG.dimensions{2}.offset;
% Read data
data_iEEG = dataArray_iEEG.readAllData;

% Plot trial data
figure
plot(tiEEG,data_iEEG)
title(['iEEG data - Trial ',num2str(nTrial)])
xlabel(['Time (',dataArray_iEEG.dimensions{2}.unit,')'])
ylabel(['Voltage (',dataArray_iEEG.unit,')'])
legend(striEEGLabels)

%% Scalp EEG data
group_ScalpEEG = block.openGroup('Scalp EEG data');
% Data array
dataArray_ScalpEEG = group_ScalpEEG.dataArrays{nTrial};

% Electrode labels
strScalpEEGLabels = dataArray_ScalpEEG.dimensions{1}.labels;
% Time axis
tScalpEEG = (0:(double(dataArray_ScalpEEG.dataExtent(2))-1))*dataArray_ScalpEEG.dimensions{2}.samplingInterval+dataArray_ScalpEEG.dimensions{2}.offset;
% Read data
data_ScalpEEG = dataArray_ScalpEEG.readAllData;

% Plot trial data
figure
plot(tScalpEEG,data_ScalpEEG)
title(['Scalp data - Trial ',num2str(nTrial)])
xlabel(['Time (',dataArray_ScalpEEG.dimensions{2}.unit,')'])
ylabel(['Voltage (',dataArray_ScalpEEG.unit,')'])
legend(strScalpEEGLabels)

%% Trial events
group_TrialEvents_iEEG = block.openGroup('Trial events single tags iEEG');
group_TrialEvents_ScalpEEG = block.openGroup('Trial events single tags scalp EEG');

%% Trial events for a single trial
indTrialTags_iEEG = contains(cellfun(@(x) x.name,group_TrialEvents_iEEG.tags,'UniformOutput',0),['Trial_',num2str(nTrial,'%.2d')]);
indTrialTags_ScalpEEG = contains(cellfun(@(x) x.name,group_TrialEvents_ScalpEEG.tags,'UniformOutput',0),['Trial_',num2str(nTrial,'%.2d')]);

TrialEvents_iEEG = group_TrialEvents_iEEG.tags(indTrialTags_iEEG);
TrialEvents_ScalpEEG = group_TrialEvents_iEEG.tags(indTrialTags_ScalpEEG);

cellfun(@(x) disp(x.name),TrialEvents_iEEG)
cellfun(@(x) disp(x.name),TrialEvents_ScalpEEG)

%% Time of a single event
nEvent = 3; % Maintenance
fprintf(['Event name: ',TrialEvents_iEEG{nEvent}.name,'\n'])
fprintf([sprintf('Time w.r.t. fixation: %.1f %s',TrialEvents_iEEG{nEvent}.position(2),TrialEvents_iEEG{nEvent}.units{1}),'\n'])
fprintf([sprintf('Duration: %.1f %s',TrialEvents_iEEG{nEvent}.extent(2),TrialEvents_iEEG{nEvent}.units{1}),'\n'])
% The values are the same for TrialEvents_ScalpEEG

%% Units
group_SpikeTimes = block.openGroup('Spike times');

%% Select unit and trial
nUnit = 1;
nTrial = 5;
indUnitSpikeTimes = contains(cellfun(@(x) x.name,group_SpikeTimes.dataArrays,'UniformOutput',0),['Unit_',num2str(nUnit),'_'])&...
    contains(cellfun(@(x) x.name,group_SpikeTimes.dataArrays,'UniformOutput',0),['Trial_',num2str(nTrial,'%.2d')]);

dataArray_SpikeTimes = group_SpikeTimes.dataArrays{indUnitSpikeTimes};
% Read data
SpikeTimes = dataArray_SpikeTimes.readAllData;

figure
stem(dataArray_SpikeTimes.readAllData,ones(length(SpikeTimes),1))
title(['Spike times - Unit ',num2str(nUnit),' - Trial ',num2str(nTrial)])
xlabel(['Time (',dataArray_SpikeTimes.dimensions{1}.unit,')'])

%% Multitag for the unit
indMultiTagUnitSpikeTimes = contains(cellfun(@(x) x.name,block.multiTags,'UniformOutput',0),['Unit_',num2str(nUnit),'_'])&...
    contains(cellfun(@(x) x.name,block.multiTags,'UniformOutput',0),['Trial_',num2str(nTrial,'%.2d')]);

multiTag_SpikeTimes = block.multiTags{indMultiTagUnitSpikeTimes};

%% Waveform for the unit
dataArray_Waveform = multiTag_SpikeTimes.features{1}.openData;
% Time axis
tWaveform = (0:(double(dataArray_Waveform.dataExtent(2))-1))*dataArray_Waveform.dimensions{2}.samplingInterval+dataArray_Waveform.dimensions{2}.offset;
% Read data
waveform = dataArray_Waveform.readAllData;
% Plot
figure
plot(tWaveform,waveform(1,:),'b')
hold on
plot(tWaveform,waveform(1,:)+waveform(2,:),'b--')
plot(tWaveform,waveform(1,:)-waveform(2,:),'b--')
title(['Waveform - Unit',num2str(nUnit)])
xlabel(['Time (',dataArray_Waveform.dimensions{2}.unit,')'])
ylabel(['Voltage (',dataArray_Waveform.unit,')'])
legend({'Mean','Std'})

%% Source of the unit
sourceUnit = dataArray_SpikeTimes.sources{1};
% Electrode label
sourceUnit.sources{1}.name
% Anatomical location
sourceUnit.sources{2}.name

%% Use electrode map to get properties of the macroelectrode the unit is on
groupiEEGElecrodes = block.openGroup('iEEG electrode information');

nElectrode = find(strcmpi(cellfun(@(x) x.name,groupiEEGElecrodes.sources,'UniformOutput',0),sourceUnit.name));

% MNI coordinates of the electrode
groupiEEGElecrodes.multiTags{1}.retrieveFeatureData(nElectrode,'iEEG_Electrode_MNI_Coordinates')
% Was the anatomical location manually entered?
groupiEEGElecrodes.multiTags{1}.retrieveFeatureData(nElectrode,'iEEG_Electrode_Manual_Entry')

function varargout = gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargouxt}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for gui
handles.output = hObject;
% Instanciate network configuration variables
% Current Dataset variables
handles.currentNumRotations = 0;
handles.currentImageSize = 0;
handles.currentBoundaries = 0;
handles.currentHogFeatures = 0;
handles.currentTrainingSet = [];
handles.currentTargetTrainingSet = [];
% Network Training variables
handles.numNeuronsPerLayer = [10 10 10];
handles.activFunctionPerLayer = {'poslin' 'poslin' 'poslin'};
handles.trainedNetwork = [];
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- START *GENERATE DATASET* START ---
% --- Executes on button press in selectFolderDatasetBtn.
function selectFolderDatasetBtn_Callback(hObject, eventdata, handles)
dir = uigetdir('Imagens');
if ~isequal(dir,0)
    if ispc; slash = '\'; else; slash = '/'; end
    set(handles.imageDirectory, 'String', strcat(dir,slash));
end

% --- Executes on button press in numRotations.
function numRotations_Callback(hObject, eventdata, handles)
numRotations = str2num(get(hObject,'String'));
if isempty(numRotations)
    set(hObject,'string','0');
    warndlg('Input must be numerical');
elseif numRotations > 10
    warndlg('Bigger datasets will take longer to process');
end

% --- Executes during object creation, after setting all properties.
function numRotations_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[165.0 105.0 36.0 16.5]);
else
    set(hObject,'Position',[238.5 153.8077 36.0 16.5]);
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in imageSize.
function imageSize_Callback(hObject, eventdata, handles)
imageSize = str2num(get(hObject,'String'));
if isempty(imageSize)
    set(hObject,'string','0');
    warndlg('Input must be numerical');
elseif imageSize < 20
    warndlg('Image side size lower then 20 pixels is highly discouraged');
elseif imageSize > 50
    warndlg('Images with side size greater than 50 pixels will take longer to process');
end

% --- Executes during object creation, after setting all properties.
function imageSize_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[164.5 123.75 36.75 16.5]);
else
    set(hObject,'Position',[238.5 132.808 36.75 16.5]);
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in boundaries.
function boundaries_Callback(hObject, eventdata, handles)

% --- Executes on button press in hogFeatures.
function hogFeatures_Callback(hObject, eventdata, handles)

% --- Executes on button press in exportDataset.
function exportDataset_Callback(hObject, eventdata, handles)
if get(handles.exportDataset,'Value')
    set(handles.datasetName,'Enable','on');
else
    set(handles.datasetName,'Enable','off');
end

function datasetName_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function datasetName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in createDatasetBtn.
function createDatasetBtn_Callback(hObject, eventdata, handles)
if strcmp(get(handles.imageDirectory,'String'), ' ')
    errordlg('Valid directory must be chosen');
else
    if get(handles.exportDataset,'Value') && strcmp(get(handles.datasetName,'String'),' ')
        errordlg('Dataset name must be chosen');
    else
        wb = waitbar(.5,'Generating Dataset...');
        
        handles.currentNumRotations = str2num(get(handles.numRotations,'String'));
        handles.currentImageSize = str2num(get(handles.imageSize,'String'));
        handles.currentBoundaries = get(handles.boundaries,'Value');
        handles.currentHogFeatures = get(handles.hogFeatures,'Value');
        
        [handles.currentTrainingSet,handles.currentTargetTrainingSet] = datasetGenerator(get(handles.imageDirectory,'String'),handles.currentNumRotations,handles.currentImageSize,handles.currentBoundaries,handles.currentHogFeatures,get(handles.exportDataset,'Value'),get(handles.datasetName,'String'));
        handles.currentTrainingSet
        %[handles.currentTrainingSet,handles.currentTargetTrainingSet] = datasetGenerator(get(handles.imageDirectory,'String'),str2num(get(handles.numRotations,'String')),str2num(get(handles.imageSize,'String')),get(handles.boundaries,'Value'),get(handles.hogFeatures,'Value'),get(handles.exportDataset,'Value'),get(handles.datasetName,'String'));
        guidata(hObject,handles);
        delete(wb);
        helpdlg('Dataset finished!');
    end
end
% --- END *GENERATE DATASET* END ---

% --- START *IMPORT DATASET / NETWORK* START ---
% --- Executes when selected object is changed in selectImportBtnGroup.
function selectImportBtnGroup_SelectionChangedFcn(hObject, eventdata, handles)
if get(get(handles.selectImportBtnGroup,'SelectedObject'),'String') == 'Dataset'
    set(handles.selectImportBtn, 'String', 'Select Dataset');
else
    set(handles.selectImportBtn, 'String', 'Select Network');
end

% --- Executes on button press in selectImportBtn.
function selectImportBtn_Callback(hObject, eventdata, handles)
if get(get(handles.selectImportBtnGroup,'SelectedObject'),'String') == 'Dataset'
    file = uigetfile('Datasets','*.mat');
else
    file = uigetfile('Networks','*.mat');
end

if ~isequal(file,0)
    set(handles.datasetDirectory, 'String', file);
end

% --- Executes on button press in importDatasetBtn.
function importDatasetBtn_Callback(hObject, eventdata, handles)
if strcmp(get(handles.datasetDirectory,'String'), ' ')
    errordlg('Valid dataset must be chosen');
else
    if ispc; datasetDirectory = 'Datasets\'; else; datasetDirectory = 'Datasets/'; end;
    wb = waitbar(.5,'Importing Dataset...');
    
    fullDatasetName = strcat(datasetDirectory,get(handles.datasetDirectory, 'String'));
    load(fullDatasetName,'numRotations','imageSize','boundaries','hogFeatures','trainingSet','targetTrainingSet')

    handles.currentNumRotations = numRotations;
    handles.currentImageSize = imageSize;
    handles.currentBoundaries = boundaries;
    handles.currentHogFeatures = hogFeatures;
    handles.currentNumRotations = numRotations;
    handles.currentTrainingSet = trainingSet;
    handles.currentTargetTrainingSet = targetTrainingSet;

    guidata(hObject, handles);
    
    delete(wb);
    helpdlg('Dataset Imported!');
end
% --- END *IMPORT DATASET / NETWORK* END ---

% --- START *NETWORK TRAINING* START ---
% --- Executes on selection change in trainingAlgorithm.
function trainingAlgorithm_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function trainingAlgorithm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in trainingFunction.
function trainingFunction_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function trainingFunction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in numHiddenLayersDropdown.
function numHiddenLayersDropdown_Callback(hObject, eventdata, handles)
if get(handles.numHiddenLayersDropdown,'Value') == 2
    set(handles.hiddenLayer1,'Value',1);
    set(handles.hiddenLayer2,'Enable','on');
    set(handles.hiddenLayer3,'Enable','off');
elseif get(handles.numHiddenLayersDropdown,'Value') == 3
    set(handles.hiddenLayer2,'Enable','on');
    set(handles.hiddenLayer3,'Enable','on');
else
    set(handles.hiddenLayer1,'Value',1);
    set(handles.hiddenLayer2,'Enable','off');
    set(handles.hiddenLayer3,'Enable','off');
end

% --- Executes during object creation, after setting all properties.
function numHiddenLayersDropdown_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[32.2 16.462 8.6 1.923]);
else
    set(hObject,'Position',[32.2 10.938 8.6 1.923]);
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function confHiddenLayerText_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[4.8 14.769 36.5 1.077]);
else
    set(hObject,'Position',[4.8 9.8 30.8 1.077]);
end

% --- Executes when selected object is changed in confHiddenLayerSelection.
function confHiddenLayerSelection_SelectionChangedFcn(hObject, eventdata, handles)
selectedRadioButton = str2num(get(get(handles.confHiddenLayerSelection,'SelectedObject'),'String'));
set(handles.numNeurons,'String',num2str(handles.numNeuronsPerLayer(selectedRadioButton)));
set(handles.activationFunction,'Value',find(contains(get(handles.activationFunction,'String'),handles.activFunctionPerLayer{selectedRadioButton})));

% --- Executes during object creation, after setting all properties.
function hiddenLayer1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[5.7 0.312 5.857 1.062]);
else
    set(hObject,'Position',[2.714 0.312 5.857 1.062]);
end

% --- Executes during object creation, after setting all properties.
function hiddenLayer2_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[13.3 0.312 5.857 1.062]);
else
    set(hObject,'Position',[11.857 0.312 5.857 1.062]);
end

% --- Executes during object creation, after setting all properties.
function hiddenLayer3_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[21.2 0.312 5.857 1.062]);
else
    set(hObject,'Position',[21.286 0.312 5.857 1.062]);
end

% --- Executes during object creation, after setting all properties.
function numNeuronsText_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[2.2 1.538 19.6 1.077]);
else
    set(hObject,'Position',[2.2 1.3 16.6 1.077]);
end

% --- Executes on numNeurons field edit.
function numNeurons_Callback(hObject, eventdata, handles)
selectedRadioButton = str2num(get(get(handles.confHiddenLayerSelection,'SelectedObject'),'String'));
% set(handles.numNeurons,'String',handles.numNeuronsPerLayer(selectedRadioButton));
handles.numNeuronsPerLayer(selectedRadioButton) =  str2num(get(handles.numNeurons,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function numNeurons_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[82.5 12 27.75 16.5]);
else
    set(hObject,'Position',[98.25 15.75 27.75 16.5]);
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in activationFunction.
function activationFunction_Callback(hObject, eventdata, handles)
activationFunctions = get(handles.activationFunction,'String');
handles.activFunctionPerLayer{str2num(get(get(handles.confHiddenLayerSelection,'SelectedObject'),'String'))} = activationFunctions{get(handles.activationFunction,'Value')};
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function activationFunction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function trainingRepetitionsText_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[3.2 7.625 54 1.062]);
else
    set(hObject,'Position',[4.714 4.0 47.429 1.062]);
end

function trainingRepetitions_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function trainingRepetitions_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[214.5 72 27.75 16.5]);
else
    set(hObject,'Position',[273 46.5 36.75 16.5]);
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function networkPrecision_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in trainNetworkBtn.
function trainNetworkBtn_Callback(hObject, eventdata, handles)
tempHiddenLayersNeutrons = [];
for tempHidenLayerNum=1:get(handles.numHiddenLayersDropdown,'Value')
   tempHiddenLayersNeutrons = [tempHiddenLayersNeutrons handles.numNeuronsPerLayer(tempHidenLayerNum)];
end

networkTrainingAlgorithm = get(handles.trainingAlgorithm,'Value');
switch networkTrainingAlgorithm
    case 1
        emptyNetwork = feedforwardnet(tempHiddenLayersNeutrons);
    case 2
        emptyNetwork = fitnet(tempHiddenLayersNeutrons);
    case 3
        emptyNetwork = patternnet(tempHiddenLayersNeutrons);
    case 4
        emptyNetwork = cascadeforwardnet(tempHiddenLayersNeutrons);
end

trainingFunctionsTemp = get(handles.trainingFunction,'String');
emptyNetwork.trainFcn = trainingFunctionsTemp{get(handles.trainingFunction,'Value')};

emptyNetwork.divideParam.trainRatio = str2num(get(handles.datasetTrainingDividend,'String'));
emptyNetwork.divideParam.valRatio = str2num(get(handles.datasetValidationDividend,'String'));
emptyNetwork.divideParam.testRatio = str2num(get(handles.datasetTestingDividend,'String'));

for i=1:get(handles.numHiddenLayersDropdown,'Value')
    emptyNetwork.layers{i}.transferFcn = handles.activFunctionPerLayer{i};
end

% view(emptyNetwork)

if emptyNetwork.divideParam.trainRatio + emptyNetwork.divideParam.valRatio + emptyNetwork.divideParam.testRatio ~= 100
    errordlg('Sum of Dataset dividends must be 100!');
elseif isempty(handles.currentTrainingSet) || isempty(handles.currentTargetTrainingSet)
    errordlg('Valid Training and Target datasets must be loaded!');
else
    handles.trainedNetwork = train(emptyNetwork,handles.currentTrainingSet,handles.currentTargetTrainingSet,'useParallel','no');
    guidata(hObject, handles);
    set(handles.networkPrecision,'String',num2str(100-perform(handles.trainedNetwork,handles.currentTargetTrainingSet,handles.trainedNetwork(handles.currentTrainingSet))));
    helpdlg('Network training ended succesfully!');
end

% --- Executes during object creation, after setting all properties.
function trainNetworkBtn_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'Position',[50 0.625 16.8 1.688]);
else
    set(hObject,'Position',[53.286 0.625 13.857 1.688]);
end
% --- END *NETWORK TRAINING* END ---

% --- START *TEST SAMPLES* START ---
% --- Executes on button press in selectFolderTestSamplesBtn.
function selectFolderTestSamplesBtn_Callback(hObject, eventdata, handles)
dir = uigetdir('Imagens');
if ~isequal(dir,0)
    if ispc; slash = '\'; else; slash = '/'; end
    set(handles.testSamplesDirectory, 'String', strcat(dir,slash));
end

% --- Executes on button press in importTestSamplesBtn.
function importTestSamplesBtn_Callback(hObject, eventdata, handles)
if strcmp(get(handles.testSamplesDirectory,'String'), ' ')
    errordlg('Valid directory must be chosen');
elseif isempty(handles.trainedNetwork)
    errordlg('Network has to be trained in order to perform tests...');
else
    wb = waitbar(.5,'Processing Test Samples...');
    
    [testingSet,targetTrainingSet] = datasetGenerator(get(handles.testSamplesDirectory,'String'),0,handles.currentImageSize,handles.currentBoundaries,handles.currentHogFeatures,0,'');
    
    set(handles.precisionTestResult,'String',num2str(100-perform(handles.trainedNetwork,targetTrainingSet,handles.trainedNetwork(testingSet))));
    
    delete(wb);
    helpdlg('Testing complete!');
end
% --- END *TEST SAMPLES* END ---

% --- START *TEST DRAWINGS* START ---
% --- Executes on mouse press over axes background.
function axesUserDraw_ButtonDownFcn(hObject, eventdata, handles)
userDraw(handles);

function userDraw(handles)
A=handles.axesUserDraw;
set(A,'buttondownfcn',@start_pencil)

function start_pencil(src,eventdata)
coords=get(src,'currentpoint'); %since this is the axes callback, src=gca
x=coords(1,1,1);
y=coords(1,2,1);

r=line(x, y, 'color', 'black', 'LineWidth', 4, 'hittest', 'off'); %turning     hittset off allows you to draw new lines that start on top of an existing line.
set(gcf,'windowbuttonmotionfcn',{@continue_pencil,r})
set(gcf,'windowbuttonupfcn',@done_pencil)

function continue_pencil(src,eventdata,r)
%Note: src is now the figure handle, not the axes, so we need to use gca.
coords=get(gca,'currentpoint'); %this updates every time i move the mouse
x=coords(1,1,1);
y=coords(1,2,1);
%get the line's existing coordinates and append the new ones.
lastx=get(r,'xdata');
lasty=get(r,'ydata');
newx=[lastx x];
newy=[lasty y];
set(r,'xdata',newx,'ydata',newy);

function done_pencil(src,evendata)
%all this function does is turn the motion function off
set(gcf,'windowbuttonmotionfcn','')
set(gcf,'windowbuttonupfcn','')

% --- Executes on button press in clearDraw.
function clearDraw_Callback(hObject, eventdata, handles)
cla(handles.axesUserDraw);
set(handles.drawingTestResult,'String',' ');

% --- Executes on button press in testDraw.
function testDraw_Callback(hObject, eventdata, handles)
if isempty(get(handles.axesUserDraw,'Children'))
    errordlg('Valid image must be drown');
elseif isempty(handles.trainedNetwork)
    errordlg('Network has to be trained in order to test drawings...');
else
    drawing = frame2im(getframe(handles.axesUserDraw));
    processedImage =  imageProcesser(drawing(:, :, 2),handles.currentImageSize,0,handles.currentBoundaries);
    
    if handles.currentHogFeatures == 1
        processedImage = extractHOGFeatures(processedImage);
    end
    sim(handles.trainedNetwork,processedImage(:))

    set(handles.drawingTestResult,'String','Image is inconclusive...');
end
% --- END *TEST DRAWINGS* END ---

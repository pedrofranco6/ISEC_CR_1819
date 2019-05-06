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
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for gui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on button press in selectFolderBtn.
function selectFolderBtn_Callback(hObject, eventdata, handles)
if ispc; lastSlash = '\'; else; lastSlash = '/'; end
set(handles.imageDirectory, 'String', strcat(uigetdir(),lastSlash));

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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in hogFeatures.
function hogFeatures_Callback(hObject, eventdata, handles)

% --- Executes on button press in boundaries.
function boundaries_Callback(hObject, eventdata, handles)

% --- Executes on button press in createDatasetBtn.
function createDatasetBtn_Callback(hObject, eventdata, handles)
if strcmp(get(handles.imageDirectory,'String'), ' ')
    errordlg('Valid directory must be chosen');
else
    if strcmp(get(handles.datasetName,'String'),' ')
        errordlg('Dataset name must be chosen');
    else
        wb = waitbar(.5,'Generating Dataset...');
        [handles.trainingSet,handles.targetTrainingSet] = datasetGenerator(get(handles.imageDirectory,'String'),str2num(get(handles.numRotations,'String')),str2num(get(handles.imageSize,'String')),get(handles.hogFeatures,'Value'),get(handles.boundaries,'Value'),get(handles.exportDataset,'Value'),get(handles.datasetName,'String'));
        guidata(hObject,handles);
        delete(wb);
        helpdlg('Dataset finished!');
    end
end

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

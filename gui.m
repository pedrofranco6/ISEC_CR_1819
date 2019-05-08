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
    if get(handles.exportDataset,'Value') && strcmp(get(handles.datasetName,'String'),' ')
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

% --- Executes on button press in selectDatasetBtn.
function selectDatasetBtn_Callback(hObject, eventdata, handles)
set(handles.datasetDirectory, 'String', uigetfile('*.mat'));

function edit8_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in importDataset.
function importDataset_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)

function edit9_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)

function edit10_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
userDraw(handles);

function userDraw(handles)
A=handles.axesUserDraw; % axesUserDraw is tag of my axes
set(A,'buttondownfcn',@start_pencil)

function start_pencil(src,eventdata)
coords=get(src,'currentpoint'); %since this is the axes callback, src=gca
x=coords(1,1,1);
y=coords(1,2,1);

r=line(x, y, 'color', 'black', 'LineWidth', 2, 'hittest', 'off'); %turning     hittset off allows you to draw new lines that start on top of an existing line.
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
%all this funciton does is turn the motion function off
set(gcf,'windowbuttonmotionfcn','')
set(gcf,'windowbuttonupfcn','')

% --- Executes on mouse press over axes background.
function axesUserDraw_ButtonDownFcn(hObject, eventdata, handles)
userDraw(handles);

% --- Executes on button press in clearDraw.
function clearDraw_Callback(hObject, eventdata, handles)
cla(handles.axesUserDraw);
set(handles.drawingTestResult,'String',' ');

% --- Executes on button press in testDraw.
function testDraw_Callback(hObject, eventdata, handles)
if isempty(get(handles.axesUserDraw,'Children'))
    errordlg('Valid image must be drown');
else
    drawing = frame2im(getframe(handles.axesUserDraw));
    set(handles.drawingTestResult,'String','Image is inconclusive...');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
if get(handles.popupmenu2,'Value') == 2
    set(handles.hiddenLayer1,'Value',1);
    set(handles.hiddenLayer2,'Enable','on');
    set(handles.hiddenLayer3,'Enable','off');
elseif get(handles.popupmenu2,'Value') == 3
    set(handles.hiddenLayer2,'Enable','on');
    set(handles.hiddenLayer3,'Enable','on');
else
    set(handles.hiddenLayer1,'Value',1);
    set(handles.hiddenLayer2,'Enable','off');
    set(handles.hiddenLayer3,'Enable','off');
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in hiddenLayer1.
function hiddenLayer1_Callback(hObject, eventdata, handles)

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)

function numNeurons_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function numNeurons_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
strings = get(handles.popupmenu4,'String');
teste = strings{get(handles.popupmenu4,'Value')}
% get(handles.popupmenu4,'Value')

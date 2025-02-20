function varargout = model_search(varargin)
% MODEL_SEARCH MATLAB code for model_search.fig
%      MODEL_SEARCH, by itself, creates a new MODEL_SEARCH or raises the existing
%      singleton*.
%
%      H = MODEL_SEARCH returns the handle to a new MODEL_SEARCH or the handle to
%      the existing singleton*.
%
%      MODEL_SEARCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODEL_SEARCH.M with the given input arguments.
%
%      MODEL_SEARCH('Property','Value',...) creates a new MODEL_SEARCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before model_search_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to model_search_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help model_search

% Last Modified by GUIDE v2.5 12-Oct-2015 20:10:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @model_search_OpeningFcn, ...
                   'gui_OutputFcn',  @model_search_OutputFcn, ...
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
% End initialization code - DO NOT EDIT





% --- Executes just before model_search is made visible.
function model_search_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to model_search (see VARARGIN)

% Choose default command line output for model_search
handles.output = hObject;

% Defaults
handles.query       = '';
handles.modeldb     = 'models';
handles.descriptor  = -1;

% Match-Name Handles
handles.MatchNameHandles = ...
{ ...
    handles.match0_name, ...
    handles.match1_name, ...
    handles.match2_name, ...
    handles.match3_name, ...
    handles.match4_name  ...
};

% Match-Axis Handles
handles.MatchAxisHandles = ...
{ ...
    handles.match0, ...
    handles.match1, ...
    handles.match2, ...
    handles.match3, ...
    handles.match4  ...
};

% Clear Match Collumn
clear_matches(handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes model_search wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = model_search_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function model_name_entry_Callback(hObject, eventdata, handles)
% hObject    handle to model_name_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of model_name_entry as text
%        str2double(get(hObject,'String')) returns contents of model_name_entry as a double
    handles.query   = get(hObject,'String');
    guidata(hObject, handles);

    

    
    

% --- Executes during object creation, after setting all properties.
function model_name_entry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to model_name_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in descriptor_menu.
function descriptor_menu_Callback(hObject, eventdata, handles)
% hObject    handle to descriptor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns descriptor_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from descriptor_menu
    handles.descriptor = get(handles.descriptor_menu,'Value')-1;
    disp(handles.descriptor)
    guidata(hObject, handles);

    
% --- Executes during object creation, after setting all properties.
function descriptor_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to descriptor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in search_button.
function search_button_Callback(hObject, eventdata, handles)
% hObject    handle to search_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    if  handles.descriptor > 0
        if ~isempty(handles.query)
            [M,R,Q] =                                ...
            search_engine(                           ...
                handles.query                       ,...
                handles.modeldb                     ,...
                handles.descriptor                   ...
             );

             % Show Query Model
             axes(handles.model_view)
                cla
                hold on
                show(R{1,2}  ,'FaceColor','g')
                show(Q.mmesh ,'FaceColor','b')
                hold off

             % Show Query Hist
             axes(handles.hist_view)
                cla
                 if     handles.descriptor==1
                        N = 1:numel(R{1,2}.ED);
                        plot(   N,R{4,2}.ED ,'y',...
                                N,R{4,2}.ED ,'c',...
                                N,R{3,2}.ED ,'r',...
                                N,R{2,2}.ED ,'m',...
                                N,R{1,2}.ED ,'g',...
                                N,Q.mmesh.ED,'b' ...
                                )
                 elseif handles.descriptor==2
                        N = 1:numel(R{1,2}.GD);
                        plot(   N,R{4,2}.GD ,'y',...
                                N,R{4,2}.GD ,'c',...
                                N,R{3,2}.GD ,'r',...
                                N,R{2,2}.GD ,'m',...
                                N,R{1,2}.GD ,'g',...
                                N,Q.mmesh.GD,'b' ...
                                )
                 elseif handles.descriptor==3
                        N = 1:numel(R{1,2}.CD);
                        plot(   N,R{4,2}.CD ,'y',...
                                N,R{4,2}.CD ,'c',...
                                N,R{3,2}.CD ,'r',...
                                N,R{2,2}.CD ,'m',...
                                N,R{1,2}.CD ,'g',...
                                N,Q.mmesh.CD,'b' ...
                                )
                 end

             % Show top-5 Matches
             for idx = 1:5
                    axes(handles.MatchAxisHandles{idx});
                    cla
                    show(R{idx,2},'FaceColor','g')

                    set(handles.MatchNameHandles{idx},'String',...
                        sprintf('%s - (%f)',M{idx,2},R{idx,1}));
             end
        else
            warndlg('Query not selected!');
        end
    else
        warndlg('Descriptor not selected!');
    end
    
    
    
    

    

function clear_matches(handles)
    for idx = 1:5
        axes(handles.MatchAxisHandles{idx});  %#ok<LAXES>
        cla; 
        set(handles.MatchNameHandles{idx},'String',sprintf('Close Match-%d',idx));
    end

        


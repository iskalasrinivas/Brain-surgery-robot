function varargout = RobotGUI(varargin)
% ROBOTGUI MATLAB code for RobotGUI.fig
%      ROBOTGUI, by itself, creates a new ROBOTGUI or raises the existing
%      singleton*.
%
%      H = ROBOTGUI returns the handle to a new ROBOTGUI or the handle to
%      the existing singleton*.
%
%      ROBOTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOTGUI.M with the given input arguments.
%
%      ROBOTGUI('Property','Value',...) creates a new ROBOTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RobotGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RobotGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RobotGUI

% Last Modified by GUIDE v2.5 02-Dec-2018 15:36:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RobotGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RobotGUI_OutputFcn, ...
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
end

% --- Executes just before RobotGUI is made visible.
function RobotGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RobotGUI (see VARARGIN)

% Choose default command line output for RobotGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RobotGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = RobotGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end
% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Robot's home position
x=10.8;
y=28;
z=22;
Motor_move(x,y,z)

end

% --- Executes on button press in Target1.
function Target1_Callback(hObject, eventdata, handles)
% hObject    handle to Target1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function used to take in target 1 co ordinates from workspace
Hot1 = evalin('base','Hot1');
x= Hot1(1,1);
y= Hot1(2,1);
z= Hot1(3,1);

Motor_move(x,y,z);
end

% --- Executes on button press in Target2_return.
function Target2_return_Callback(hObject, eventdata, handles)
% hObject    handle to Target2_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function used to take in target 2 co ordinates from workspace
Hot2 = evalin('base','Hot2');
x= Hot2(1,1);
y= Hot2(2,1);
z= Hot2(3,1);
% Used for returning back to home position
Motor_move(0,0,-z);
pause(5)
Motor_move(-x,-y,0);
end

% --- Executes on button press in Robot_home.
function Robot_home_Callback(hObject, eventdata, handles)
% hObject    handle to Robot_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Return to robot initial position
x=-10.8;
y=-28;
z=-22;
Motor_move(x,y,z)

end

% --- Executes on button press in Target1return.
function Target1return_Callback(hObject, eventdata, handles)
% hObject    handle to Target1return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function used to take in target 1 co ordinates from workspace
Hot1 = evalin('base','Hot1');
x= Hot1(1,1);
y= Hot1(2,1);
z= Hot1(3,1);

% Used for returning back to home position
Motor_move(0,0,-z);
pause(5)
Motor_move(-x,-y,0);
end

% --- Executes on button press in Target2.
function Target2_Callback(hObject, eventdata, handles)
% hObject    handle to Target2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function used to take in target 2 co ordinates from workspace
Hot2 = evalin('base','Hot2');
x= Hot2(1,1);
y= Hot2(2,1);
z= Hot2(3,1);

Motor_move(x,y,z);
end

% --- Executes on button press in Target3.
function Target3_Callback(hObject, eventdata, handles)
% hObject    handle to Target3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function used to take in target 3 co ordinates from workspace
Hot3 = evalin('base','Hot3');
x= Hot3(1,1);
y= Hot3(2,1);
z= Hot3(3,1);

Motor_move(x,y,z);
end

% --- Executes on button press in Target3_return.
function Target3_return_Callback(hObject, eventdata, handles)
% hObject    handle to Target3_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function used to take in target 3 co ordinates from workspace
Hot3 = evalin('base','Hot3');
x= Hot3(1,1);
y= Hot3(2,1);
z= Hot3(3,1);
% Used for returning back to home position
Motor_move(0,0,-z);
pause(5)
Motor_move(-x,-y,0);
end

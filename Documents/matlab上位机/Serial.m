function varargout = Serial(varargin)
% SERIAL MATLAB code for Serial.fig
%      SERIAL, by itself, creates a new SERIAL or raises the existing
%      singleton*.
%
%      H = SERIAL returns the handle to a new SERIAL or the handle to
%      the existing singleton*.
%
%      SERIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERIAL.M with the given input arguments.
%
%      SERIAL('Property','Value',...) creates a new SERIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Serial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Serial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Serial

% Last Modified by GUIDE v2.5 08-Jan-2016 18:34:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Serial_OpeningFcn, ...
    'gui_OutputFcn',  @Serial_OutputFcn, ...
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


% --- Executes just before Serial is made visible.
function Serial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Serial (see VARARGIN)

% Choose default command line output for Serial
handles.output = hObject;


warning off all;
NewIcon = javax.swing.ImageIcon('qinaidi.jpg');%选取要跟换的左上角图片
figFrame = get(hObject,'JavaFrame');             %取得Figure的JavaFrame。
figFrame.setFigureIcon(NewIcon);                 %修改图标

%%初始化参数
hasData = false;
isShow = false;
isStopDisp = false;
isHexDisp = false;
isHexSend = false;
isFirst = true;
numRec = 0;
numSend = 0;
strRec = '';
%%将上述参数作为应用数据，存入窗口对象内
setappdata(hObject,'hasData',hasData);
setappdata(hObject,'isFirst',isFirst);
setappdata(hObject,'strRec',strRec);
setappdata(hObject,'numRec',numRec);
setappdata(hObject,'numSend',numSend);
setappdata(hObject,'isShow',isShow);
setappdata(hObject,'isStopDisp',isStopDisp);
setappdata(hObject,'isHexDisp',isHexDisp);
setappdata(hObject,'isHexSend',isHexSend);
global p
p=1;
global isanalysis
isanalysis=0;
global mid_old
mid_old=115;
global midline
global leftline
global rightline

set(handles.lamb,'BackgroundColor','r');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Serial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Serial_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in com.
function com_Callback(hObject, eventdata, handles)
% hObject    handle to com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns com contents as cell array
%        contents{get(hObject,'Value')} returns selected item from com


% --- Executes during object creation, after setting all properties.
function com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rate.
function rate_Callback(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rate


% --- Executes during object creation, after setting all properties.
function rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in jiaoyan.
function jiaoyan_Callback(hObject, eventdata, handles)
% hObject    handle to jiaoyan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns jiaoyan contents as cell array
%        contents{get(hObject,'Value')} returns selected item from jiaoyan


% --- Executes during object creation, after setting all properties.
function jiaoyan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jiaoyan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in data_bits.
function data_bits_Callback(hObject, eventdata, handles)
% hObject    handle to data_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data_bits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data_bits


% --- Executes during object creation, after setting all properties.
function data_bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stop_bits.
function stop_bits_Callback(hObject, eventdata, handles)
% hObject    handle to stop_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stop_bits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stop_bits


% --- Executes during object creation, after setting all properties.
function stop_bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stop_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_serial.
function start_serial_Callback(hObject, eventdata, handles)   %%打开串口按键回调程序
% hObject    handle to start_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start_serial
%%打开串口按键按下
if get(hObject,'Value')
    
    %%删除串口，保证串口正常打开
    scoms=instrfind;
    delete(scoms);
    %%COM口的选择
    com_n=sprintf('com%d',get(handles.com,'value'));
    %%波特率的选择
    rates=[300 600 1200 2400 4800 9600 19200 38400 43000 56000 57600 115200];
    baud_rate=rates(get(handles.rate,'value'));
    %%校验位的选择
    switch get(handles.jiaoyan,'value')
        case 1
            jiaoyan='none';
        case 2
            jiaoyan='odd';
        case 3
            jiaoyan='even';
    end
    %%数据位及其停止位的选择
    data_bits=5+get(handles.data_bits,'value');
    stop_bits=get(handles. stop_bits,'value');
    %%设置COM口参数
    scom=serial(com_n);
    set(scom,'BaudRate',baud_rate,'Parity',jiaoyan,'DataBits',data_bits,'StopBits',stop_bits,'BytesAvailableFcnCount',10,...
        'BytesAvailableFcnMode','byte','InputBufferSize',1024,'BytesAvailableFcn',{@bytes,handles},'TimerPeriod',0.05,'timerfcn',{@dataDisp,handles});
    %%将串口对象的句柄作为用户数据，存入窗口对象
    set(handles.figure1,'UserData',scom);
    %%尝试打开串口
    try
        fopen(scom);
    catch
        msgbox('串口不可用','Warnning!','error');
        set(hObject,'value',0);
        return;
    end
    set(handles.period_send,'Enable','on');
    set(handles.manual_send,'Enable','on');
    set(handles.com,'Enable','off');
    set(handles.rate,'Enable','off');
    set(handles.jiaoyan,'Enable','off');
    set(handles.data_bits,'Enable','off');
    set(handles.stop_bits,'Enable','off');
    set(handles.lamb,'BackgroundColor','g');
    set(hObject,'String','关闭串口');
    %%关闭串口时，删除定时器及其串口信息
else
    %%停止并删除定时器
    t=timerfind;
    if ~isempty(t)
        stop(t);
        delete(t);
    end
    %%停止并删除串口，保证下一次串口正常打开
    scoms=instrfind;
    stopasync(scoms);
    fclose(scoms);
    delete(scoms);
    set(handles.com,'Enable','on');
    set(handles.rate,'Enable','on');
    set(handles.jiaoyan,'Enable','on');
    set(handles.data_bits,'Enable','on');
    set(handles.stop_bits,'Enable','on');
    set(handles.period_send,'Enable','off')
    set(handles.manual_send,'Enable','off')
    set(handles.lamb,'BackgroundColor','r');
    set(hObject,'String','打开串口');
end


%%定时执行函数，定时时间50ms
function dataDisp(hObject, eventdata, handles)

hasData = getappdata(handles.figure1,'hasData');
strRec = getappdata(handles.figure1,'strRec');
numRec = getappdata(handles.figure1,'numRec');
%%如果没有数据，则采集数据
if ~hasData
    bytes(hObject, eventdata, handles);
end
%%采集到数据后显示
if hasData
    setappdata(handles.figure1,'isShow',true);
    %%如果显示的字符串长度超过20000，则清空显示区（尚不知其作用）
    if length(strRec)>20000
        strRec='';
        setappdata(handles.figure1,'strRec',strRec);
    end
    set(handles.xianshi,'String',strRec); %%在显示区显示收到的数据
    set(handles.rec,'String',numRec);
    
    setappdata(handles.figure1,'hasData',false);
    setappdata(handles.figure1,'isShow',false);
end



function bytes(hObject, eventdata, handles)

%%参数读取
strRec = getappdata(handles.figure1,'strRec');
numRec = getappdata(handles.figure1,'numRec');
isStopDisp = getappdata(handles.figure1,'isStopDisp');
isHexDisp = getappdata(handles.figure1,'isHexDisp');
isShow = getappdata(handles.figure1,'isShow');

global p;
global imgbuf;
global img;
global camera_W;
global camera_H;

% for i=1:100
%     imgbuf(i)=i;
% end

%%如果忙于显示中，则不采集数据
if isShow
    return;
end

if ~isStopDisp
%%获取串口可获取的数据个数
n=get(hObject,'BytesAvailable');
%%如果有数据
if n
    setappdata(handles.figure1,'hasData',true);
    a=fread(hObject,n,'uchar');  %%读取串口数据
    %%选择是否停止接收（识别帧头正确）
    for i=1:n
        if a(i)~=255                                          %%帧头判断程序（此处可以改帧头标示）
            if getappdata(handles.figure1,'isFirst')~=true   %%判断是否是第一次进入赋值，第一次不定义数组，等确定P后开始定义
                imgbuf(p)=a(i);
            end
            p=p+1;
        else
            set(handles.xianshi,'String',p);
            if getappdata(handles.figure1,'isFirst')        %%如果是第一次进入并且P已经矫正正确，则开始允许赋值
                if p==camera_H*camera_W+1
                    setappdata(handles.figure1,'isFirst',false);
                end
            end
            
            if getappdata(handles.figure1,'isFirst')==false  %%将一维数组编程二维数组，方便出图及其后续分析
                for h=1:camera_H
                    for w=1:camera_W
                        img(h,w)=imgbuf((h-1)*camera_W+w);
                    end
                end
            end
            imgbuf = zeros(p-1);
            p=1;
        end
    end
    
    if ~isStopDisp
        %%选择数据格式（16进制或者10进制）
        if ~isHexDisp  %%普通显示格式
            c=char(a');
        else           %%16进制显示处理
            strHex=dec2hex(a')';
            strHex=[strHex;blanks(size(a,1))];
            c = strHex(:)';
        end
        numRec=numRec+size(a,1);
        %% 更新要显示的字符串（字符串的累加）
        strRec=[strRec c];
        %%图像显示程序
        if getappdata(handles.figure1,'isFirst')==false
            
            set(figure(1),'name','上海海事大学摄像头专用上位机','Numbertitle','off');
            colormap(gray);
            imagesc(img);
            title('图像实时更新系统');
            axis off;
        end
    end
    %%更新数据
    setappdata(handles.figure1,'numRec',numRec);
    setappdata(handles.figure1,'strRec',strRec);
    
end
end




% --- Executes on button press in lamb.
function lamb_Callback(hObject, eventdata, handles)
% hObject    handle to lamb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xianshi_Callback(hObject, eventdata, handles)
% hObject    handle to xianshi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xianshi as text
%        str2double(get(hObject,'String')) returns contents of xianshi as a double


% --- Executes during object creation, after setting all properties.
function xianshi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xianshi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sends_Callback(hObject, eventdata, handles)
% hObject    handle to sends (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sends as text
%        str2double(get(hObject,'String')) returns contents of sends as a double


% --- Executes during object creation, after setting all properties.
function sends_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sends (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clear_count.
function clear_count_Callback(hObject, eventdata, handles)
% hObject    handle to clear_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set([handles.rec handles.trans],'String','0');
setappdata(handles.figure1,'numRec',0);
setappdata(handles.figure1,'numSend',0);

% --- Executes on button press in period_send.
function period_send_Callback(hObject, eventdata, handles)
% hObject    handle to period_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of period_send


% --- Executes on button press in hex_send.
function hex_send_Callback(hObject, eventdata, handles)
% hObject    handle to hex_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hex_send


% --- Executes on button press in clear_send.
function clear_send_Callback(hObject, eventdata, handles)
% hObject    handle to clear_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sends,'String','');

% --- Executes on button press in manual_send.
function manual_send_Callback(hObject, eventdata, handles)
% hObject    handle to manual_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
scom=get(handles.figure1,'UserData');
numSend=getappdata(handles.figure1,'numSend');
val=get(handles.sends,'String');

numSend=numSend+length(val);

set(handles.trans,'String',num2str(numSend));

setappdata(handles.figure1,'numSend',numSend);

if ~isempty(val)
    n=1000;
    while n
        str=get(scom,'TransferStatus');
        if ~(strcmp(str,'write') || strcmp(str,'read&write'))
            fwrite(scom,val,'uint8','async');
            break;
        end
        n=n-1;
    end
end


function period1_Callback(hObject, eventdata, handles)
% hObject    handle to period1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of period1 as text
%        str2double(get(hObject,'String')) returns contents of period1 as a double


% --- Executes during object creation, after setting all properties.
function period1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to period1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stop_disp.
function stop_disp_Callback(hObject, eventdata, handles)
% hObject    handle to stop_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stop_disp
if get(hObject,'Value')
    isStopDisp = true;
else
    isStopDisp = false;
end
setappdata(handles.figure1,'isStopDisp',isStopDisp);

% --- Executes on button press in qingkong.
function qingkong_Callback(hObject, eventdata, handles)
% hObject    handle to qingkong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

strRec='';
setappdata(handles.figure1,'strRec',strRec);
set(handles.xianshi,'String',strRec);       %%在显示区显示收到的数据

% --- Executes on button press in hex_disp.
function hex_disp_Callback(hObject, eventdata, handles)
% hObject    handle to hex_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hex_disp
if get(hObject,'Value')
    isHexDisp = true;
else
    isHexDisp = false;
end
setappdata(handles.figure1,'isHexDisp',isHexDisp);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
if get(hObject,'Value')
    set(handles.xianshi,'Enable','on');
else
    set(handles.xianshi,'Enable','inactive');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=timerfind;
if ~isempty(t)
    stop(t);
    delete(t);
end

scoms=instrfind;
try
    stopsync(scoms);
    fclose(scoms);
    delete(scoms);
end

% Hint: delete(hObject) closes the figure
delete(hObject);



function Camera_W_Callback(hObject, eventdata, handles)
% hObject    handle to Camera_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Camera_W as text
%        str2double(get(hObject,'String')) returns contents of Camera_W as a double


% --- Executes during object creation, after setting all properties.
function Camera_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Camera_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Camera_H_Callback(hObject, eventdata, handles)
% hObject    handle to Camera_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Camera_H as text
%        str2double(get(hObject,'String')) returns contents of Camera_H as a double


% --- Executes during object creation, after setting all properties.
function Camera_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Camera_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ShowImage.
function ShowImage_Callback(hObject, eventdata, handles)
% hObject    handle to ShowImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera_W
global camera_H
global img
% Hint: get(hObject,'Value') returns toggle state of ShowImage
if get(hObject,'Value')
    set(handles.Camera_W,'Enable','off');
    set(handles.Camera_H,'Enable','off');
    camera_W=str2num(get(handles.Camera_W,'String'));
    camera_H=str2num(get(handles.Camera_H,'String'));
    img = zeros(camera_H,camera_W);
else
    set(handles.Camera_W,'Enable','on');
    set(handles.Camera_H,'Enable','on');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to Camera_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Camera_W as text
%        str2double(get(hObject,'String')) returns contents of Camera_W as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Camera_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to Camera_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Camera_H as text
%        str2double(get(hObject,'String')) returns contents of Camera_H as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Camera_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ShowImage.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to ShowImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowImage


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
[FileName,PathName] = uiputfile('*.txt','文件另存为','dat1.txt');
dlmwrite(FileName,img,'delimiter','\t','newline','pc');
warndlg('储存成功！','通知');

% --- Executes on button press in read.
function read_Callback(hObject, eventdata, handles)
% hObject    handle to read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global isanalysis
global camera_W
global camera_H
global midline
[FileName,PathName] = uigetfile('*.txt');
img=load(FileName);
set(figure(1),'name','上海海事大学摄像头专用上位机','Numbertitle','off');
colormap(gray);
imagesc(img);
title('图像实时更新系统');
axis off;

global isanalysis
global midline
global leftline
global rightline
global img
global camera_H
global camera_W
global mid_old

Interval=5;
Jump_threshold=80;
Last_line=camera_H;
Tracking_NUM=35;
Tracking_NUM2=15;   %%专门用于从边缘开始找线
Tracking_displacement=13;
for z=1:camera_H          %%手动设置图像采集行数
    leftline(z)=0;
    midline(z)=0;
    rightline(z)=0;
end

    
    sao_you=1;
    sao_zuo=1;
    rightline_flag=0;
    leftline_flag=0;
    break_left=39;
    break_right=39;
    first_lost_left=1;
    first_lost_right=1;
    find_line_left=0;
    find_line_right=0;
    mid_left=0;
    mid_right=0;
    
    %%中线程序提取
    
    
    
    %%如果上次一中线偏左或者偏右太厉害的话，就默认只往一个方向扫线
    if mid_old<=2+Interval
        sao_zuo=0;
        mid_old=2+Interval;
    end
    if mid_old>=camera_W-Interval-1
        sao_you=0;
        mid_old=camera_W-Interval-1
    end
    %%？？？？？？？？基准行所要取得行数问题？？？？？？？？
    %%扫基准行左线
    if sao_zuo
        for i=round(mid_old):-1:1+Interval                              %从上一次最低行中线开始找线，涉及到上一行中线取整问题
            if img(Last_line,i)-img(Last_line,i-Interval)>Jump_threshold
                leftline(Last_line)=i-Interval;
                leftline_flag=1;
                break;
            else
                leftline_flag=0;
            end
        end
    end
    
    %%扫基准行右线
    if sao_you
        for i=round(mid_old):1:camera_W-Interval
            if img(Last_line,i)-img(Last_line,i+Interval)>Jump_threshold
                rightline(Last_line)=i+Interval;
                rightline_flag=1;
                break;
            else
                rightline_flag=0;
            end
        end
    end
    
    
    %%根据左线或者右线和直道上赛道宽度拟合出另一条已经丢失的线（最底行！！！！）
    if leftline_flag==1 && rightline_flag==0
        rightline(Last_line)=leftline(Last_line)+185;
        if rightline(Last_line)<camera_W
            rightline(Last_line)=camera_W;
        end
    end
    
    if leftline_flag==0 && rightline_flag==1
        leftline(Last_line)=rightline(Last_line)-185;
        if leftline(Last_line)>0
            leftline(Last_line)=0;
        end
    end
    %%利用左线和右线计算中线位置（特指最底行）
    midline(Last_line)=(leftline(Last_line)+rightline(Last_line))/2;
    %%赋值最低行中线位置，作为下一次的扫线起点
    mid_old=midline(Last_line);
    
    %%！！！！！！！！！！！基准行采集结束！！！！！！！！！！！！！！
    
    
    %%！！！！！！！！！！！基本跟踪算法！！！！！！！！！！！！！！！
    %%左线跟踪
    if leftline_flag
        for i=camera_H-1:-1:1
            find_line_left=0;
            for j=Tracking_NUM:-1:0
                if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
                    if img(i,leftline(i+1)+j+Interval-Tracking_displacement)-img(i,leftline(i+1)+j-Tracking_displacement)>Jump_threshold
                        leftline(i)=leftline(i+1)+j-Tracking_displacement;
                        find_line_left=1;
                        break_left=0;
                        break;
                    end
                end
            end
            if find_line_left==0                    %%记录左线丢线开始行
                break_left=i;
                break;
            end
        end
    end
    
    %%右线跟踪
    if rightline_flag
        for i=camera_H-1:-1:1
            find_line_right=0;
            for j=Tracking_NUM:-1:0
                if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
                    if img(i,rightline(i+1)+j-Interval-Tracking_displacement)-img(i,rightline(i+1)+j-Tracking_displacement)>Jump_threshold
                        rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
                        find_line_right=1;
                        break_right=0;
                        break;
                    end
                end
            end
            if find_line_right==0                   %%记录右线丢线开始行
                break_right=i;
                break;
            end
        end
    end
    %%！！！！！！！！！！！基本跟踪算法完毕！！！！！！！！！！！！！！
    
    %%！！！！！！！！！！！十字判断！！！！！！！！！！！！！！
    shizi_flag=0;
    %%！！！！直入十字！！！！
    shizi_flag_zhi=0;
    %%十字两边同时丢线，完全采用前端黑线的补线方式
    if rightline_flag==0 && leftline_flag==0 
        white=0;
        start_check=camera_H;              %%若两边同时丢线，则判断前两行是否全为白点
        for i=1:1:camera_W
            if img(start_check-2,i)>140        %%确保扫到的都只有白点（白点个数大于225点）
                white=white+1;
                if white>camera_W-5
                    shizi_flag_zhi=2;
                end
            end
        end
    %% 两边黑线扫到极少的情况，完全采用前端黑线的补线方式
    elseif (break_left>=38 || break_right>=38) && abs(break_right-break_left)<3   %%有一边黑线少于3行，且两边黑线之差小于一定值
        
        if break_left<=break_right
            start_check=break_left;
        else
            start_check=break_right;
        end
        white=0;
        for i=1:1:camera_W
            if img(start_check-2,i)>140
                white=white+1;
                if white>camera_W-5
                    shizi_flag_zhi=2;
                end
            end
        end
    %%有搜索到至少两行的黑线，并且黑线行数小于10行，进行两点连线补线方式（若黑线行数大于10行，则采取直接补线的方式）
    elseif ((break_left>=30 && break_left<=38)|| (break_right>=30 && break_right<=38)) && abs(break_right-break_left)<3 && rightline_flag==1 && leftline_flag==1 
        if break_left<=break_right
            start_check=break_left;
        else
            start_check=break_right;
        end
        white=0;
        for i=1:1:camera_W
            if img(start_check-2,i)>120
                white=white+1;
                if white>camera_W-5
                    shizi_flag_zhi=1;
                end
            end
        end
    end
    
    %%直入十字判断完成，flag=1为采用两点连线补线方式，flag=2为采用前端黑线补线方式（这两种补线方式会有一定的偏差，可考虑直接补中线解决问题）
    %%！！！！直入十字判断完成！！！！
    
    
    %%！！！！斜入十字判断！！！！
    %%开始处理斜入十字的情况
    xierushizi_flag=0;
    tiaobian=0;
    shizi_flag_xie=0;
    if shizi_flag_zhi==0                %%如果不是直入十字，那么就开始判断是否为斜入十字
        if rightline_flag==1
            if  break_right<30
                for i=camera_H-5:-1:6             %%防止出现数组溢出的现象（更多的考虑跳变点在第35行之前的情况）
                    if rightline(i)-rightline(i+1)<0 && rightline(i-1)-rightline(i)>0
                        tiaobian=i;
                        slope1=(rightline(i)-rightline(i+5))/5;
                        slope2=(rightline(i-5)-rightline(i))/5;
                        break;
                    end
                end
            else                                   %%如果有右线标志，但是其黑线小于5行，那么判断它前面两行是否为全白
                start_check=break_right;
                white=0;
                for i=1:1:camera_W
                    if img(start_check-2,i)>120
                        white=white+1;
                        if white>camera_W-5
                            shizi_flag_xie=1;
                        end
                    end
                end
            end
            
        elseif leftline_flag==1          %%与斜入右线相对称
            if break_left<30
            for i=camera_H-5:-1:6                 %%防止出现数组溢出的现象（更多的考虑跳变点在第35行之前的情况）
                if leftline(i)-leftline(i+1)>0 && leftline(i-1)-leftline(i)<0
                    tiaobian=i;
                    slope1=(leftline(i)-leftline(i+5))/5;
                    slope2=(leftline(i-5)-leftline(i))/5;
                    break;
                end
            end
            else
                start_check=break_left;
                white=0;
                for i=1:1:camera_W
                    if img(start_check-2,i)>120
                        white=white+1;
                        if white>camera_W-5
                            shizi_flag_xie=2;
                        end
                    end
                end
            end
        end
    end
    
    if tiaobian~=0 && abs(slope1-slope2)>10 && slope1*slope2<0  %%利用跳变点附近的斜率之差来确定是否为斜入十字              
       xierushizi_flag=1;
    end
    
    if xierushizi_flag==1 || shizi_flag_xie==2 || shizi_flag_xie==1 || shizi_flag_zhi==1 || shizi_flag_zhi==2  %%十字标志的总结
        shizi_flag=1;
    end
    %%！！！！斜入十字识别完毕！！！！
    %%！！！！！！！！！！！！！十字识别完毕，后续步骤为针对十字的补线程序！！！！！！！！！！！！！！！！！！！！！！
    
    
    
    %%！！！直入十字标志位，有全白现象，找出十字重新开始的行数！！！
    if shizi_flag_zhi==1 || shizi_flag_zhi==2                      
        shizi_star=0;                                              
        for i=start_check-2:-1:1
            for j=round(camera_W/2):-1:1+Interval                   %从上一次最低行中线开始找线，涉及到上一行中线取整问题
                if img(i,j)-img(i,j-Interval)>Jump_threshold
                    leftline(start_check-2)=j-Interval;
                    shizi_star=i;                                
                    break;
                end
            end
            if shizi_star~=0
                break;
            end
        end
        
        find=0;
        for i=shizi_star:-1:1
            for j=round(camera_W/2):1:camera_W-Interval                   %从上一次最低行中线开始找线，涉及到上一行中线取整问题
                if img(i,j)-img(i,j+Interval)>Jump_threshold
                    leftline(shizi_star)=j+Interval;
                    shizi_star=i;
                    find=1;
                    break;
                end
            end
            if find~=0
                break;
            end
        end
        %%在十字前半截扫到线后，进行向前两行左右扫线
        for j=round(camera_W/2):-1:1+Interval
            if img(shizi_star-2,j)-img(shizi_star-2,j-Interval)>Jump_threshold     %%向上置位两行，防止横着的黑线干扰
                leftline(shizi_star-2)=j-Interval;
                break;
            end
        end
        
        for j=round(camera_W/2):1:camera_W-Interval
            if img(shizi_star-2,j)-img(shizi_star-2,j+Interval)>Jump_threshold
                rightline(shizi_star-2)=j+Interval;
                break;
            end
        end
    %%！！斜入十字，存在全白行的情况，并且底层黑线不可靠，只往一边扫线！！
    elseif shizi_flag_xie==1           %%右线存在斜入十字的情况，只追逐右线，搜素中线偏向左边
        shizi_star=0;
        for i=start_check-2:-1:1
            for j=1:1:camera_W-Interval     %从上一次最低行中线开始找线，涉及到上一行中线取整问题
                if img(i,j)-img(i,j+Interval)>Jump_threshold
                    rightline(i)=j+Interval;
                    shizi_star=i;                                
                    break;
                end
            end
            if shizi_star~=0
                break;
            end
        end
    elseif shizi_flag_xie==2           %%左线存在斜入十字的情况，只追逐左线，搜素中线偏向右边
        shizi_star=0;
        for i=start_check-2:-1:1
            for j=camera_W:-1:1+Interval        %从上一次最低行中线开始找线，涉及到上一行中线取整问题
                if img(i,j)-img(i,j-Interval)>Jump_threshold
                    leftline(i)=j-Interval;
                    shizi_star=i;
                    break;
                end
            end
            if shizi_star~=0
                break;
            end
        end
    end
    %%！！！！找到十字重新开始的行数，并且找到此时的左线和右线！！！！
    
    break_left_shizi=0;
    break_right_shizi=0;
    %%！！！！！！！！！！！！对重新开始的十字黑线进行跟踪！！！！！！！！！！！！！
    if shizi_flag_zhi==1 || shizi_flag_zhi==2
        %%十字前端跟踪黑线
        for i=shizi_star-2-1:-1:1
            find_line_left=0;
            for j=Tracking_NUM:-1:0
                if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
                    if img(i,round(leftline(i+1))+j+Interval-Tracking_displacement)-img(i,round(leftline(i+1))+j-Tracking_displacement)>Jump_threshold
                        leftline(i)=leftline(i+1)+j-Tracking_displacement;
                        find_line_left=1;
                        break_left_shizi=0;
                        break;
                    end
                end
            end
            if find_line_left==0                    %%记录左线丢线开始行
                break_left_shizi=i;
                break;
            end
        end
        
        for i=shizi_star-2-1:-1:1
            find_line_right=0;
            for j=Tracking_NUM:-1:0
                if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
                    if img(i,round(rightline(i+1))+j-Interval-Tracking_displacement)-img(i,round(rightline(i+1))+j-Tracking_displacement)>Jump_threshold
                        rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
                        find_line_right=1;
                        break_right_shizi=0;
                        break;
                    end
                end
            end
            if find_line_right==0                   %%记录右线丢线开始行
                break_right_shizi=i;
                break;
            end
        end
    
    elseif shizi_flag_xie==1
        for i=shizi_star-1:-1:1
            find_line_right=0;
            for j=Tracking_NUM:-1:0
                if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
                    if img(i,round(rightline(i+1))+j-Interval-Tracking_displacement)-img(i,round(rightline(i+1))+j-Tracking_displacement)>Jump_threshold
                        rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
                        find_line_right=1;
                        break_right_shizi=0;
                        break;
                    end
                end
            end
            if find_line_right==0                   %%记录右线丢线开始行
                break_right_shizi=i;
                break;
            end
        end
        
    elseif shizi_flag_xie==2
        for i=shizi_star-1:-1:1
            find_line_left=0;
            for j=Tracking_NUM:-1:0
                if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
                    if img(i,round(leftline(i+1))+j+Interval-Tracking_displacement)-img(i,round(leftline(i+1))+j-Tracking_displacement)>Jump_threshold
                        leftline(i)=leftline(i+1)+j-Tracking_displacement;
                        find_line_left=1;
                        break_left_shizi=0;
                        break;
                    end
                end
            end
            if find_line_left==0                    %%记录左线丢线开始行
                break_left_shizi=i;
                break;
            end
        end
    end
        
    
    
    
    %%！！！！直入十字补线程序！！！！
    if shizi_flag_zhi==1             %%反向补线（采用两点连线补线方式），即针对找到底下黑线较多的情况
        slope=(leftline(break_left+2)-leftline(shizi_star-2))/(break_left-shizi_star+4);
        for i=break_left+1:-1:shizi_star-1
            leftline(i)=leftline(break_left+2)-slope*(break_left+2-i);
        end
        
        slope=(rightline(break_right+2)-rightline(shizi_star-2))/(break_right-shizi_star+4);
        for i=break_right+1:-1:shizi_star-1
            rightline(i)=rightline(break_right+2)-slope*(break_right+2-i);
        end
    elseif shizi_flag_zhi==2          %%往后跟踪黑线程序，完全依靠前几行向后延伸补线     
        slope=(leftline(shizi_star-2)-leftline(shizi_star-7))/5;
        for i=shizi_star-2:1:camera_H
            leftline(i)=leftline(shizi_star-2)-slope*(shizi_star-2-i-1);
        end
        
        slope=(rightline(shizi_star-2)-rightline(shizi_star-7))/5;
        for i=shizi_star-2:1:camera_H
            rightline(i)=rightline(shizi_star-2)-slope*(shizi_star-2-i-1);
        end
    %%！！！！斜入十字补线程序！！！！
    elseif xierushizi_flag==1            %%如果是斜入十字,并且底行参考点较多，则从跳变处开始补线（直接往前补线,全部补完，不考虑与前面线的融合性）
        if rightline_flag==1
            for i=tiaobian-1:-1:1
                rightline(i)=rightline(tiaobian)+slope1*(tiaobian-i);
            end
        elseif leftline_flag==1
            for i=tiaobian-1:-1:1
                leftline(i)=leftline(tiaobian)+slope1*(tiaobian-i);
            end
        end
    elseif shizi_flag_xie==1
        slope=(rightline(shizi_star-2)-rightline(shizi_star-7))/5;
        for i=shizi_star-2:1:camera_H
            rightline(i)=rightline(shizi_star-2)-slope*(shizi_star-2-i-1);
        end
    elseif shizi_flag_xie==2
        slope=(leftline(shizi_star-2)-leftline(shizi_star-7))/5;
        for i=shizi_star-2:1:camera_H
            leftline(i)=leftline(shizi_star-2)-slope*(shizi_star-2-i-1);
        end
    end
    
    
    %%！！！！十字往前补黑线程序！！！！（不用考虑有跳变点的情况，因为跳变情况下已自己将线补完）
    if break_left_shizi~=0
        slope=(leftline(break_left_shizi+1)-leftline(break_left_shizi+6))/5;
         for i=break_left_shizi:-1:1
             leftline(i)=leftline(break_left_shizi+1)+slope*(break_left_shizi-i);
         end 
    end
    if break_right_shizi~=0
        slope=(rightline(break_right_shizi+1)-rightline(break_right_shizi+6))/5;
         for i=break_right_shizi:-1:1
             rightline(i)=slope*(break_right_shizi-i+1)+rightline(break_right_shizi+1);
         end 
    end
    
    
    %%非十字情况下的补线，有基准点，且黑线超过10个点，即开始补线，利用前五点斜率向上补线
    if shizi_flag==0
        if break_left~=0 || break_right~=0
            if break_left<=30                        %%确保至少有10个点
                slope=(leftline(break_left+1)-leftline(break_left+6))/5;
                
                for i=break_left:-1:1
                    leftline(i)=slope*(break_left-i+1)+leftline(break_left+1);
                end
            end
        end
        
        if break_right<=30                           %%确保至少有10个点
            slope=(rightline(break_right+1)-rightline(break_right+6))/5;
            
            for i=break_right:-1:1
                rightline(i)=slope*(break_right-i+1)+rightline(break_right+1);
            end
        end
    end

        
    if shizi_flag==0     %%只有在不是十字判断的条件下，执行从中间找线程序
        
        %% 当只有左线没有扫到时，直接从左边缘找黑线
        if leftline_flag==0 && rightline_flag==1
            for i=camera_H-1:-1:1                   %%最多采集20行，再上去就要排除其他远处赛道的影响？？
                find_mid_left=0;
                if rightline(i)<5                   %%如果右线过多偏于左边，那么直接跳出，代表左线不可能被找到
                    break;
                end
                for j=Tracking_NUM2:-1:Interval+1
                    if img(i,j)-img(i,j-Interval)>Jump_threshold
                        leftline(i)=j-Interval;
                        find_mid_left=1;
                        break;
                    end
                end
                if find_mid_left
                    mid_left=i;
                    break;
                end
            end
        end
        
        %% 当只有右线没有扫到时，直接从右边缘找黑线
        if leftline_flag==1 && rightline_flag==0
            for i=camera_H-1:-1:1                    %%最多采集20行，再上去就要排除其他远处赛道的影响？？
                find_mid_right=0;
                if leftline(i)>camera_W-5             %%如果左线过多偏于右边，那么直接跳出，代表右线不可能被找到
                    break;
                end
                for j=camera_W-Tracking_NUM2:1:camera_W-Interval
                    if img(i,j)-img(i,j+Interval)>Jump_threshold
                        rightline(i)=j+Interval;
                        find_mid_right=1;
                        break;
                    end
                end
                if find_mid_right
                    mid_right=i;
                    break;
                end
            end
        end
        
        
        %%跟踪算法，从边界找到的点开始跟踪，确保不应为起始行丢线而整体丢线（左线）
        if leftline_flag==0 && mid_left~=0
            for i=mid_left-1:-1:1
                find_line_left=0;
                for j=Tracking_NUM:-1:0
                    if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
                        if img(i,leftline(i+1)+j+Interval-Tracking_displacement)-img(i,leftline(i+1)+j-Tracking_displacement)>Jump_threshold
                            leftline(i)=leftline(i+1)+j-Tracking_displacement;
                            find_line_left=1;
                            break_left=0;
                            break;
                        end
                    end
                end
                if find_line_left==0                    %%记录左线丢线开始行
                    break_left=i;
                    break;
                end
            end
        end
        
        %%跟踪算法，从边界找到的点开始跟踪，确保不应为起始行丢线而整体丢线（右线）
        if rightline_flag==0 && mid_right~=0
            for i=mid_right-1:-1:1
                find_line_right=0;
                for j=Tracking_NUM:-1:0
                    if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
                        if img(i,rightline(i+1)+j-Interval-Tracking_displacement)-img(i,rightline(i+1)+j-Tracking_displacement)>Jump_threshold
                            rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
                            find_line_right=1;
                            break_right=0;
                            break;
                        end
                    end
                end
                if find_line_right==0                   %%记录右线丢线开始行
                    break_right=i;
                    break;
                end
            end
        end
        
        
        %%将刚刚在中间找到线的最后一个点与原来还有一边线的最后一点作比较，进行对另一边的重新补线
        if leftline_flag==0 && mid_left~=0
            if break_left~=0                                                %%自己这条线的补线
                slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%三点补线法算左线最后一点的斜率
                for i=break_left:-1:1
                    leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
                end
            end
            if break_left<break_right                                       %%另外一条线的辅助补线
                slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%三点补线法算左线最后一点的斜率
                for i=break_right:-1:1
                    rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
                end
            end
        end
        
        if rightline_flag==0 && mid_right~=0
            if break_right~=0                                                %%自己这条线的补线
                slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%三点补线法算左线最后一点的斜率
                for i=break_right:-1:1
                    rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
                end
            end
            if break_left>break_right
                slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%三点补线法算左线最后一点的斜率
                for i=break_left:-1:1
                    leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
                end
            end
        end
        
        
        %%左边基本行未找到线的补线
        if leftline_flag==0 && mid_left~=0
            
            slope=(leftline(mid_left-3)-leftline(mid_left))/3;
            for i=mid_left:1:40
                leftline(i)=slope*(mid_left-i)+leftline(mid_left);
            end
            %%右边基本行未找到线的补线
        elseif rightline_flag==0 && mid_right~=0
            slope=(rightline(mid_right-3)-rightline(mid_right))/3;
            for i=mid_right:1:40
                rightline(i)=slope*(mid_right-i)+rightline(mid_right);
            end
        end
        
    end
    
    
    %%左线或者右线有一条完全丢线或者可参考点非常少的情况
    if shizi_flag_zhi==0                                       %%在非直入十字的情况下进行判定
        if (break_left>=30 && abs(break_right-break_left)>4 && shizi_flag_xie==0) || (leftline_flag==0 && mid_left==0)    %%非斜入十字且参考点较少或者丢线且无法在前面找到黑线  
            slope=(rightline(break_left)-rightline(break_left-5))/5;
            for i=break_left:-1:1
                leftline(i)=leftline(break_left+1)-slope*(break_left+1-i);
            end
        end
        
        if (break_right>=30 && abs(break_right-break_left)>4 && shizi_flag_xie==0) || (rightline_flag==0 && mid_right==0)
            slope=(leftline(break_right)-leftline(break_right-5))/5;
            for i=break_right:-1:1
                rightline(i)=rightline(break_right+1)-slope*(break_right+1-i);
            end
        end
    end
    
    %%中线计算
    midline=(rightline+leftline)/2;
    

    %%显示采集到的图像
    set(figure(1),'name','上海海事大学摄像头专用上位机','Numbertitle','off');
    colormap(gray);
    imagesc(img);
    title('图像实时更新系统');
    hold on
    for z=1:camera_H
        %%坐标轴控制程序，让图像外的黑线也能显示在图像上
        xmin1=min(leftline);
        xmin2=min(rightline);
        if xmin1>xmin2
            xmin=xmin2;
        else
            xmin=xmin1;
        end
        if xmin>0
            xmin=1;
        end
        if xmin<-180
            xmin=-180;
        end
        xmax1=max(rightline);
        xmax2=max(leftline);
        if xmax2>xmax1
            xmax=xmax2;
        else
            xmax=xmax1;
        end
        if xmax<camera_W+1
            xmax=camera_W;
        end
        if xmax>camera_W+180
            xmax=camera_W+180;
        end
        axis([xmin,xmax,1,camera_H]);
        
        %%显示左线右线及其中线
        plot(leftline(z),z,'g*');
        plot(rightline(z),z,'b*');
        plot(midline(z),z,'r*');
    end


    

% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton5
global isanalysis
global midline
global leftline
global rightline
global img
global camera_H
global camera_W
global mid_old

Interval=5;
Jump_threshold=80;
Last_line=camera_H;
Tracking_NUM=35;
Tracking_NUM2=15;   %%专门用于从边缘开始找线
Tracking_displacement=13;
for z=1:camera_H          %%手动设置图像采集行数
    leftline(z)=0;
    midline(z)=0;
    rightline(z)=0;
end

    
    sao_you=1;
    sao_zuo=1;
    rightline_flag=0;
    leftline_flag=0;
    break_left=39;
    break_right=39;
    first_lost_left=1;
    first_lost_right=1;
    find_line_left=0;
    find_line_right=0;
    mid_left=0;
    mid_right=0;
    
    %%中线程序提取
    
    
    
    %%如果上次一中线偏左或者偏右太厉害的话，就默认只往一个方向扫线
    if mid_old<=2+Interval
        sao_zuo=0;
        mid_old=2+Interval;
    end
    if mid_old>=camera_W-Interval-1
        sao_you=0;
        mid_old=camera_W-Interval-1
    end
    %%？？？？？？？？基准行所要取得行数问题？？？？？？？？
    %%扫基准行左线
    if sao_zuo
        for i=round(mid_old):-1:1+Interval                              %从上一次最低行中线开始找线，涉及到上一行中线取整问题
            if img(Last_line,i)-img(Last_line,i-Interval)>Jump_threshold
                leftline(Last_line)=i-Interval;
                leftline_flag=1;
                break;
            else
                leftline_flag=0;
            end
        end
    end
    
    %%扫基准行右线
    if sao_you
        for i=round(mid_old):1:camera_W-Interval
            if img(Last_line,i)-img(Last_line,i+Interval)>Jump_threshold
                rightline(Last_line)=i+Interval;
                rightline_flag=1;
                break;
            else
                rightline_flag=0;
            end
        end
    end
    
    
    %%根据左线或者右线和直道上赛道宽度拟合出另一条已经丢失的线（最底行！！！！）
    if leftline_flag==1 && rightline_flag==0
        rightline(Last_line)=leftline(Last_line)+185;
        if rightline(Last_line)<camera_W
            rightline(Last_line)=camera_W;
        end
    end
    
    if leftline_flag==0 && rightline_flag==1
        leftline(Last_line)=rightline(Last_line)-185;
        if leftline(Last_line)>0
            leftline(Last_line)=0;
        end
    end
    %%利用左线和右线计算中线位置（特指最底行）
    midline(Last_line)=(leftline(Last_line)+rightline(Last_line))/2;
    %%赋值最低行中线位置，作为下一次的扫线起点
    mid_old=midline(Last_line);
    
    %%！！！！！！！！！！！基准行采集结束！！！！！！！！！！！！！！
    
    
    %%！！！！！！！！！！！基本跟踪算法！！！！！！！！！！！！！！！
    %%左线跟踪
    if leftline_flag
        for i=camera_H-1:-1:1
            find_line_left=0;
            for j=Tracking_NUM:-1:0
                if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
                    if img(i,leftline(i+1)+j+Interval-Tracking_displacement)-img(i,leftline(i+1)+j-Tracking_displacement)>Jump_threshold
                        leftline(i)=leftline(i+1)+j-Tracking_displacement;
                        find_line_left=1;
                        break_left=0;
                        break;
                    end
                end
            end
            if find_line_left==0                    %%记录左线丢线开始行
                break_left=i;
                break;
            end
        end
    end
    
    %%右线跟踪
    if rightline_flag
        for i=camera_H-1:-1:1
            find_line_right=0;
            for j=Tracking_NUM:-1:0
                if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
                    if img(i,rightline(i+1)+j-Interval-Tracking_displacement)-img(i,rightline(i+1)+j-Tracking_displacement)>Jump_threshold
                        rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
                        find_line_right=1;
                        break_right=0;
                        break;
                    end
                end
            end
            if find_line_right==0                   %%记录右线丢线开始行
                break_right=i;
                break;
            end
        end
    end
    %%！！！！！！！！！！！基本跟踪算法完毕！！！！！！！！！！！！！！
    
%     %！！！！！！！！！！！十字判断！！！！！！！！！！！！！！
%     shizi_flag=0;
%     %！！！！直入十字！！！！
%     shizi_flag_zhi=0;
%     %十字两边同时丢线，完全采用前端黑线的补线方式
%     if rightline_flag==0 && leftline_flag==0 
%         white=0;
%         start_check=camera_H;              %%若两边同时丢线，则判断前两行是否全为白点
%         for i=1:1:camera_W
%             if img(start_check-2,i)>140        %%确保扫到的都只有白点（白点个数大于225点）
%                 white=white+1;
%                 if white>camera_W-5
%                     shizi_flag_zhi=2;
%                 end
%             end
%         end
%     % 两边黑线扫到极少的情况，完全采用前端黑线的补线方式
%     elseif (break_left>=38 || break_right>=38) && abs(break_right-break_left)<3   %%有一边黑线少于3行，且两边黑线之差小于一定值
%         
%         if break_left<=break_right
%             start_check=break_left;
%         else
%             start_check=break_right;
%         end
%         white=0;
%         for i=1:1:camera_W
%             if img(start_check-2,i)>140
%                 white=white+1;
%                 if white>camera_W-5
%                     shizi_flag_zhi=2;
%                 end
%             end
%         end
%     %有搜索到至少两行的黑线，并且黑线行数小于10行，进行两点连线补线方式（若黑线行数大于10行，则采取直接补线的方式）
%     elseif ((break_left>=30 && break_left<=38)|| (break_right>=30 && break_right<=38)) && abs(break_right-break_left)<3 && rightline_flag==1 && leftline_flag==1 
%         if break_left<=break_right
%             start_check=break_left;
%         else
%             start_check=break_right;
%         end
%         white=0;
%         for i=1:1:camera_W
%             if img(start_check-2,i)>120
%                 white=white+1;
%                 if white>camera_W-5
%                     shizi_flag_zhi=1;
%                 end
%             end
%         end
%     end
%     
%     %直入十字判断完成，flag=1为采用两点连线补线方式，flag=2为采用前端黑线补线方式（这两种补线方式会有一定的偏差，可考虑直接补中线解决问题）
%     %！！！！直入十字判断完成！！！！
%     
%     
%     %！！！！斜入十字判断！！！！
%     %开始处理斜入十字的情况
%     xierushizi_flag=0;
%     tiaobian=0;
%     shizi_flag_xie=0;
%     if shizi_flag_zhi==0                %%如果不是直入十字，那么就开始判断是否为斜入十字
%         if rightline_flag==1
%             if  break_right<30
%                 for i=camera_H-5:-1:6             %%防止出现数组溢出的现象（更多的考虑跳变点在第35行之前的情况）
%                     if rightline(i)-rightline(i+1)<0 && rightline(i-1)-rightline(i)>0
%                         tiaobian=i;
%                         slope1=(rightline(i)-rightline(i+5))/5;
%                         slope2=(rightline(i-5)-rightline(i))/5;
%                         break;
%                     end
%                 end
%             else                                   %%如果有右线标志，但是其黑线小于5行，那么判断它前面两行是否为全白
%                 start_check=break_right;
%                 white=0;
%                 for i=1:1:camera_W
%                     if img(start_check-2,i)>120
%                         white=white+1;
%                         if white>camera_W-5
%                             shizi_flag_xie=1;
%                         end
%                     end
%                 end
%             end
%             
%         elseif leftline_flag==1          %%与斜入右线相对称
%             if break_left<30
%             for i=camera_H-5:-1:6                 %%防止出现数组溢出的现象（更多的考虑跳变点在第35行之前的情况）
%                 if leftline(i)-leftline(i+1)>0 && leftline(i-1)-leftline(i)<0
%                     tiaobian=i;
%                     slope1=(leftline(i)-leftline(i+5))/5;
%                     slope2=(leftline(i-5)-leftline(i))/5;
%                     break;
%                 end
%             end
%             else
%                 start_check=break_left;
%                 white=0;
%                 for i=1:1:camera_W
%                     if img(start_check-2,i)>120
%                         white=white+1;
%                         if white>camera_W-5
%                             shizi_flag_xie=2;
%                         end
%                     end
%                 end
%             end
%         end
%     end
%     
%     if tiaobian~=0 && abs(slope1-slope2)>10 && slope1*slope2<0  %%利用跳变点附近的斜率之差来确定是否为斜入十字              
%        xierushizi_flag=1;
%     end
%     
%     if xierushizi_flag==1 || shizi_flag_xie==2 || shizi_flag_xie==1 || shizi_flag_zhi==1 || shizi_flag_zhi==2  %%十字标志的总结
%         shizi_flag=1;
%     end
%     %！！！！斜入十字识别完毕！！！！
%     %！！！！！！！！！！！！！十字识别完毕，后续步骤为针对十字的补线程序！！！！！！！！！！！！！！！！！！！！！！
%     
%     
%     
%     %！！！直入十字标志位，有全白现象，找出十字重新开始的行数！！！
%     if shizi_flag_zhi==1 || shizi_flag_zhi==2                      
%         shizi_star=0;                                              
%         for i=start_check-2:-1:1
%             for j=round(camera_W/2):-1:1+Interval                   %从上一次最低行中线开始找线，涉及到上一行中线取整问题
%                 if img(i,j)-img(i,j-Interval)>Jump_threshold
%                     leftline(start_check-2)=j-Interval;
%                     shizi_star=i;                                
%                     break;
%                 end
%             end
%             if shizi_star~=0
%                 break;
%             end
%         end
%         
%         find=0;
%         for i=shizi_star:-1:1
%             for j=round(camera_W/2):1:camera_W-Interval                   %从上一次最低行中线开始找线，涉及到上一行中线取整问题
%                 if img(i,j)-img(i,j+Interval)>Jump_threshold
%                     leftline(shizi_star)=j+Interval;
%                     shizi_star=i;
%                     find=1;
%                     break;
%                 end
%             end
%             if find~=0
%                 break;
%             end
%         end
%         %在十字前半截扫到线后，进行向前两行左右扫线
%         for j=round(camera_W/2):-1:1+Interval
%             if img(shizi_star-2,j)-img(shizi_star-2,j-Interval)>Jump_threshold     %%向上置位两行，防止横着的黑线干扰
%                 leftline(shizi_star-2)=j-Interval;
%                 break;
%             end
%         end
%         
%         for j=round(camera_W/2):1:camera_W-Interval
%             if img(shizi_star-2,j)-img(shizi_star-2,j+Interval)>Jump_threshold
%                 rightline(shizi_star-2)=j+Interval;
%                 break;
%             end
%         end
%     %！！斜入十字，存在全白行的情况，并且底层黑线不可靠，只往一边扫线！！
%     elseif shizi_flag_xie==1           %%右线存在斜入十字的情况，只追逐右线，搜素中线偏向左边
%         shizi_star=0;
%         for i=start_check-2:-1:1
%             for j=1:1:camera_W-Interval     %从上一次最低行中线开始找线，涉及到上一行中线取整问题
%                 if img(i,j)-img(i,j+Interval)>Jump_threshold
%                     rightline(i)=j+Interval;
%                     shizi_star=i;                                
%                     break;
%                 end
%             end
%             if shizi_star~=0
%                 break;
%             end
%         end
%     elseif shizi_flag_xie==2           %%左线存在斜入十字的情况，只追逐左线，搜素中线偏向右边
%         shizi_star=0;
%         for i=start_check-2:-1:1
%             for j=camera_W:-1:1+Interval        %从上一次最低行中线开始找线，涉及到上一行中线取整问题
%                 if img(i,j)-img(i,j-Interval)>Jump_threshold
%                     leftline(i)=j-Interval;
%                     shizi_star=i;
%                     break;
%                 end
%             end
%             if shizi_star~=0
%                 break;
%             end
%         end
%     end
%     %！！！！找到十字重新开始的行数，并且找到此时的左线和右线！！！！
%     
%     break_left_shizi=0;
%     break_right_shizi=0;
%     %！！！！！！！！！！！！对重新开始的十字黑线进行跟踪！！！！！！！！！！！！！
%     if shizi_flag_zhi==1 || shizi_flag_zhi==2
%         %十字前端跟踪黑线
%         for i=shizi_star-2-1:-1:1
%             find_line_left=0;
%             for j=Tracking_NUM:-1:0
%                 if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
%                     if img(i,round(leftline(i+1))+j+Interval-Tracking_displacement)-img(i,round(leftline(i+1))+j-Tracking_displacement)>Jump_threshold
%                         leftline(i)=leftline(i+1)+j-Tracking_displacement;
%                         find_line_left=1;
%                         break_left_shizi=0;
%                         break;
%                     end
%                 end
%             end
%             if find_line_left==0                    %%记录左线丢线开始行
%                 break_left_shizi=i;
%                 break;
%             end
%         end
%         
%         for i=shizi_star-2-1:-1:1
%             find_line_right=0;
%             for j=Tracking_NUM:-1:0
%                 if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
%                     if img(i,round(rightline(i+1))+j-Interval-Tracking_displacement)-img(i,round(rightline(i+1))+j-Tracking_displacement)>Jump_threshold
%                         rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
%                         find_line_right=1;
%                         break_right_shizi=0;
%                         break;
%                     end
%                 end
%             end
%             if find_line_right==0                   %%记录右线丢线开始行
%                 break_right_shizi=i;
%                 break;
%             end
%         end
%     
%     elseif shizi_flag_xie==1
%         for i=shizi_star-1:-1:1
%             find_line_right=0;
%             for j=Tracking_NUM:-1:0
%                 if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
%                     if img(i,round(rightline(i+1))+j-Interval-Tracking_displacement)-img(i,round(rightline(i+1))+j-Tracking_displacement)>Jump_threshold
%                         rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
%                         find_line_right=1;
%                         break_right_shizi=0;
%                         break;
%                     end
%                 end
%             end
%             if find_line_right==0                   %%记录右线丢线开始行
%                 break_right_shizi=i;
%                 break;
%             end
%         end
%         
%     elseif shizi_flag_xie==2
%         for i=shizi_star-1:-1:1
%             find_line_left=0;
%             for j=Tracking_NUM:-1:0
%                 if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
%                     if img(i,round(leftline(i+1))+j+Interval-Tracking_displacement)-img(i,round(leftline(i+1))+j-Tracking_displacement)>Jump_threshold
%                         leftline(i)=leftline(i+1)+j-Tracking_displacement;
%                         find_line_left=1;
%                         break_left_shizi=0;
%                         break;
%                     end
%                 end
%             end
%             if find_line_left==0                    %%记录左线丢线开始行
%                 break_left_shizi=i;
%                 break;
%             end
%         end
%     end
%         
%     
%     
%     
%     %！！！！直入十字补线程序！！！！
%     if shizi_flag_zhi==1             %%反向补线（采用两点连线补线方式），即针对找到底下黑线较多的情况
%         slope=(leftline(break_left+2)-leftline(shizi_star-2))/(break_left-shizi_star+4);
%         for i=break_left+1:-1:shizi_star-1
%             leftline(i)=leftline(break_left+2)-slope*(break_left+2-i);
%         end
%         
%         slope=(rightline(break_right+2)-rightline(shizi_star-2))/(break_right-shizi_star+4);
%         for i=break_right+1:-1:shizi_star-1
%             rightline(i)=rightline(break_right+2)-slope*(break_right+2-i);
%         end
%     elseif shizi_flag_zhi==2          %%往后跟踪黑线程序，完全依靠前几行向后延伸补线     
%         slope=(leftline(shizi_star-2)-leftline(shizi_star-7))/5;
%         for i=shizi_star-2:1:camera_H
%             leftline(i)=leftline(shizi_star-2)-slope*(shizi_star-2-i-1);
%         end
%         
%         slope=(rightline(shizi_star-2)-rightline(shizi_star-7))/5;
%         for i=shizi_star-2:1:camera_H
%             rightline(i)=rightline(shizi_star-2)-slope*(shizi_star-2-i-1);
%         end
%     %！！！！斜入十字补线程序！！！！
%     elseif xierushizi_flag==1            %%如果是斜入十字,并且底行参考点较多，则从跳变处开始补线（直接往前补线,全部补完，不考虑与前面线的融合性）
%         if rightline_flag==1
%             for i=tiaobian-1:-1:1
%                 rightline(i)=rightline(tiaobian)+slope1*(tiaobian-i);
%             end
%         elseif leftline_flag==1
%             for i=tiaobian-1:-1:1
%                 leftline(i)=leftline(tiaobian)+slope1*(tiaobian-i);
%             end
%         end
%     elseif shizi_flag_xie==1
%         slope=(rightline(shizi_star-2)-rightline(shizi_star-7))/5;
%         for i=shizi_star-2:1:camera_H
%             rightline(i)=rightline(shizi_star-2)-slope*(shizi_star-2-i-1);
%         end
%     elseif shizi_flag_xie==2
%         slope=(leftline(shizi_star-2)-leftline(shizi_star-7))/5;
%         for i=shizi_star-2:1:camera_H
%             leftline(i)=leftline(shizi_star-2)-slope*(shizi_star-2-i-1);
%         end
%     end
%     
%     
%     %！！！！十字往前补黑线程序！！！！（不用考虑有跳变点的情况，因为跳变情况下已自己将线补完）
%     if break_left_shizi~=0
%         slope=(leftline(break_left_shizi+1)-leftline(break_left_shizi+6))/5;
%          for i=break_left_shizi:-1:1
%              leftline(i)=leftline(break_left_shizi+1)+slope*(break_left_shizi-i);
%          end 
%     end
%     if break_right_shizi~=0
%         slope=(rightline(break_right_shizi+1)-rightline(break_right_shizi+6))/5;
%          for i=break_right_shizi:-1:1
%              rightline(i)=slope*(break_right_shizi-i+1)+rightline(break_right_shizi+1);
%          end 
%     end
%     
%     
%     %非十字情况下的补线，有基准点，且黑线超过10个点，即开始补线，利用前五点斜率向上补线
%     if shizi_flag==0
%         if break_left~=0 || break_right~=0
%             if break_left<=30                        %%确保至少有10个点
%                 slope=(leftline(break_left+1)-leftline(break_left+6))/5;
%                 
%                 for i=break_left:-1:1
%                     leftline(i)=slope*(break_left-i+1)+leftline(break_left+1);
%                 end
%             end
%         end
%         
%         if break_right<=30                           %%确保至少有10个点
%             slope=(rightline(break_right+1)-rightline(break_right+6))/5;
%             
%             for i=break_right:-1:1
%                 rightline(i)=slope*(break_right-i+1)+rightline(break_right+1);
%             end
%         end
%     end
% 
%         
%     if shizi_flag==0     %%只有在不是十字判断的条件下，执行从中间找线程序
%         
%         % 当只有左线没有扫到时，直接从左边缘找黑线
%         if leftline_flag==0 && rightline_flag==1
%             for i=camera_H-1:-1:1                   %%最多采集20行，再上去就要排除其他远处赛道的影响？？
%                 find_mid_left=0;
%                 if rightline(i)<5                   %%如果右线过多偏于左边，那么直接跳出，代表左线不可能被找到
%                     break;
%                 end
%                 for j=Tracking_NUM2:-1:Interval+1
%                     if img(i,j)-img(i,j-Interval)>Jump_threshold
%                         leftline(i)=j-Interval;
%                         find_mid_left=1;
%                         break;
%                     end
%                 end
%                 if find_mid_left
%                     mid_left=i;
%                     break;
%                 end
%             end
%         end
%         
%         % 当只有右线没有扫到时，直接从右边缘找黑线
%         if leftline_flag==1 && rightline_flag==0
%             for i=camera_H-1:-1:1                    %%最多采集20行，再上去就要排除其他远处赛道的影响？？
%                 find_mid_right=0;
%                 if leftline(i)>camera_W-5             %%如果左线过多偏于右边，那么直接跳出，代表右线不可能被找到
%                     break;
%                 end
%                 for j=camera_W-Tracking_NUM2:1:camera_W-Interval
%                     if img(i,j)-img(i,j+Interval)>Jump_threshold
%                         rightline(i)=j+Interval;
%                         find_mid_right=1;
%                         break;
%                     end
%                 end
%                 if find_mid_right
%                     mid_right=i;
%                     break;
%                 end
%             end
%         end
%         
%         
%         %跟踪算法，从边界找到的点开始跟踪，确保不应为起始行丢线而整体丢线（左线）
%         if leftline_flag==0 && mid_left~=0
%             for i=mid_left-1:-1:1
%                 find_line_left=0;
%                 for j=Tracking_NUM:-1:0
%                     if leftline(i+1)+j-Tracking_displacement>0 && leftline(i+1)+j+Interval-Tracking_displacement<=camera_W
%                         if img(i,leftline(i+1)+j+Interval-Tracking_displacement)-img(i,leftline(i+1)+j-Tracking_displacement)>Jump_threshold
%                             leftline(i)=leftline(i+1)+j-Tracking_displacement;
%                             find_line_left=1;
%                             break_left=0;
%                             break;
%                         end
%                     end
%                 end
%                 if find_line_left==0                    %%记录左线丢线开始行
%                     break_left=i;
%                     break;
%                 end
%             end
%         end
%         
%         %跟踪算法，从边界找到的点开始跟踪，确保不应为起始行丢线而整体丢线（右线）
%         if rightline_flag==0 && mid_right~=0
%             for i=mid_right-1:-1:1
%                 find_line_right=0;
%                 for j=Tracking_NUM:-1:0
%                     if rightline(i+1)+j-Interval-Tracking_displacement>0 && rightline(i+1)+j-Tracking_displacement<=camera_W
%                         if img(i,rightline(i+1)+j-Interval-Tracking_displacement)-img(i,rightline(i+1)+j-Tracking_displacement)>Jump_threshold
%                             rightline(i)=rightline(i+1)+j-Tracking_displacement-Interval;
%                             find_line_right=1;
%                             break_right=0;
%                             break;
%                         end
%                     end
%                 end
%                 if find_line_right==0                   %%记录右线丢线开始行
%                     break_right=i;
%                     break;
%                 end
%             end
%         end
%         
%         
%         %将刚刚在中间找到线的最后一个点与原来还有一边线的最后一点作比较，进行对另一边的重新补线
%         if leftline_flag==0 && mid_left~=0
%             if break_left~=0                                                %%自己这条线的补线
%                 slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%三点补线法算左线最后一点的斜率
%                 for i=break_left:-1:1
%                     leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
%                 end
%             end
%             if break_left<break_right                                       %%另外一条线的辅助补线
%                 slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%三点补线法算左线最后一点的斜率
%                 for i=break_right:-1:1
%                     rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
%                 end
%             end
%         end
%         
%         if rightline_flag==0 && mid_right~=0
%             if break_right~=0                                                %%自己这条线的补线
%                 slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%三点补线法算左线最后一点的斜率
%                 for i=break_right:-1:1
%                     rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
%                 end
%             end
%             if break_left>break_right
%                 slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%三点补线法算左线最后一点的斜率
%                 for i=break_left:-1:1
%                     leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
%                 end
%             end
%         end
%         
%         
%         %左边基本行未找到线的补线
%         if leftline_flag==0 && mid_left~=0
%             
%             slope=(leftline(mid_left-3)-leftline(mid_left))/3;
%             for i=mid_left:1:40
%                 leftline(i)=slope*(mid_left-i)+leftline(mid_left);
%             end
%             %右边基本行未找到线的补线
%         elseif rightline_flag==0 && mid_right~=0
%             slope=(rightline(mid_right-3)-rightline(mid_right))/3;
%             for i=mid_right:1:40
%                 rightline(i)=slope*(mid_right-i)+rightline(mid_right);
%             end
%         end
%         
%     end
%     
%     
%     %左线或者右线有一条完全丢线或者可参考点非常少的情况
%     if shizi_flag_zhi==0                                       %%在非直入十字的情况下进行判定
%         if (break_left>=30 && abs(break_right-break_left)>4 && shizi_flag_xie==0) || (leftline_flag==0 && mid_left==0)    %%非斜入十字且参考点较少或者丢线且无法在前面找到黑线  
%             slope=(rightline(break_left)-rightline(break_left-5))/5;
%             for i=break_left:-1:1
%                 leftline(i)=leftline(break_left+1)-slope*(break_left+1-i);
%             end
%         end
%         
%         if (break_right>=30 && abs(break_right-break_left)>4 && shizi_flag_xie==0) || (rightline_flag==0 && mid_right==0)
%             slope=(leftline(break_right)-leftline(break_right-5))/5;
%             for i=break_right:-1:1
%                 rightline(i)=rightline(break_right+1)-slope*(break_right+1-i);
%             end
%         end
%     end
    
    %%中线计算
    midline=(rightline+leftline)/2;
    

    %%显示采集到的图像
    set(figure(1),'name','上海海事大学摄像头专用上位机','Numbertitle','off');
    colormap(gray);
    imagesc(img);
    title('图像实时更新系统');
    hold on
    for z=1:camera_H
        %%坐标轴控制程序，让图像外的黑线也能显示在图像上
        xmin1=min(leftline);
        xmin2=min(rightline);
        if xmin1>xmin2
            xmin=xmin2;
        else
            xmin=xmin1;
        end
        if xmin>0
            xmin=1;
        end
        if xmin<-180
            xmin=-180;
        end
        xmax1=max(rightline);
        xmax2=max(leftline);
        if xmax2>xmax1
            xmax=xmax2;
        else
            xmax=xmax1;
        end
        if xmax<camera_W+1
            xmax=camera_W;
        end
        if xmax>camera_W+180
            xmax=camera_W+180;
        end
        axis([xmin,xmax,1,camera_H]);
        
        %%显示左线右线及其中线
        plot(leftline(z),z,'g*');
        plot(rightline(z),z,'b*');
        plot(midline(z),z,'r*');
    end
    
    
    

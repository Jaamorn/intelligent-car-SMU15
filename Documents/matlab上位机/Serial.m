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
NewIcon = javax.swing.ImageIcon('qinaidi.jpg');%ѡȡҪ���������Ͻ�ͼƬ
figFrame = get(hObject,'JavaFrame');             %ȡ��Figure��JavaFrame��
figFrame.setFigureIcon(NewIcon);                 %�޸�ͼ��

%%��ʼ������
hasData = false;
isShow = false;
isStopDisp = false;
isHexDisp = false;
isHexSend = false;
isFirst = true;
numRec = 0;
numSend = 0;
strRec = '';
%%������������ΪӦ�����ݣ����봰�ڶ�����
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
function start_serial_Callback(hObject, eventdata, handles)   %%�򿪴��ڰ����ص�����
% hObject    handle to start_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start_serial
%%�򿪴��ڰ�������
if get(hObject,'Value')
    
    %%ɾ�����ڣ���֤����������
    scoms=instrfind;
    delete(scoms);
    %%COM�ڵ�ѡ��
    com_n=sprintf('com%d',get(handles.com,'value'));
    %%�����ʵ�ѡ��
    rates=[300 600 1200 2400 4800 9600 19200 38400 43000 56000 57600 115200];
    baud_rate=rates(get(handles.rate,'value'));
    %%У��λ��ѡ��
    switch get(handles.jiaoyan,'value')
        case 1
            jiaoyan='none';
        case 2
            jiaoyan='odd';
        case 3
            jiaoyan='even';
    end
    %%����λ����ֹͣλ��ѡ��
    data_bits=5+get(handles.data_bits,'value');
    stop_bits=get(handles. stop_bits,'value');
    %%����COM�ڲ���
    scom=serial(com_n);
    set(scom,'BaudRate',baud_rate,'Parity',jiaoyan,'DataBits',data_bits,'StopBits',stop_bits,'BytesAvailableFcnCount',10,...
        'BytesAvailableFcnMode','byte','InputBufferSize',1024,'BytesAvailableFcn',{@bytes,handles},'TimerPeriod',0.05,'timerfcn',{@dataDisp,handles});
    %%�����ڶ���ľ����Ϊ�û����ݣ����봰�ڶ���
    set(handles.figure1,'UserData',scom);
    %%���Դ򿪴���
    try
        fopen(scom);
    catch
        msgbox('���ڲ�����','Warnning!','error');
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
    set(hObject,'String','�رմ���');
    %%�رմ���ʱ��ɾ����ʱ�����䴮����Ϣ
else
    %%ֹͣ��ɾ����ʱ��
    t=timerfind;
    if ~isempty(t)
        stop(t);
        delete(t);
    end
    %%ֹͣ��ɾ�����ڣ���֤��һ�δ���������
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
    set(hObject,'String','�򿪴���');
end


%%��ʱִ�к�������ʱʱ��50ms
function dataDisp(hObject, eventdata, handles)

hasData = getappdata(handles.figure1,'hasData');
strRec = getappdata(handles.figure1,'strRec');
numRec = getappdata(handles.figure1,'numRec');
%%���û�����ݣ���ɼ�����
if ~hasData
    bytes(hObject, eventdata, handles);
end
%%�ɼ������ݺ���ʾ
if hasData
    setappdata(handles.figure1,'isShow',true);
    %%�����ʾ���ַ������ȳ���20000���������ʾ�����в�֪�����ã�
    if length(strRec)>20000
        strRec='';
        setappdata(handles.figure1,'strRec',strRec);
    end
    set(handles.xianshi,'String',strRec); %%����ʾ����ʾ�յ�������
    set(handles.rec,'String',numRec);
    
    setappdata(handles.figure1,'hasData',false);
    setappdata(handles.figure1,'isShow',false);
end



function bytes(hObject, eventdata, handles)

%%������ȡ
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

%%���æ����ʾ�У��򲻲ɼ�����
if isShow
    return;
end

if ~isStopDisp
%%��ȡ���ڿɻ�ȡ�����ݸ���
n=get(hObject,'BytesAvailable');
%%���������
if n
    setappdata(handles.figure1,'hasData',true);
    a=fread(hObject,n,'uchar');  %%��ȡ��������
    %%ѡ���Ƿ�ֹͣ���գ�ʶ��֡ͷ��ȷ��
    for i=1:n
        if a(i)~=255                                          %%֡ͷ�жϳ��򣨴˴����Ը�֡ͷ��ʾ��
            if getappdata(handles.figure1,'isFirst')~=true   %%�ж��Ƿ��ǵ�һ�ν��븳ֵ����һ�β��������飬��ȷ��P��ʼ����
                imgbuf(p)=a(i);
            end
            p=p+1;
        else
            set(handles.xianshi,'String',p);
            if getappdata(handles.figure1,'isFirst')        %%����ǵ�һ�ν��벢��P�Ѿ�������ȷ����ʼ����ֵ
                if p==camera_H*camera_W+1
                    setappdata(handles.figure1,'isFirst',false);
                end
            end
            
            if getappdata(handles.figure1,'isFirst')==false  %%��һά�����̶�ά���飬�����ͼ�����������
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
        %%ѡ�����ݸ�ʽ��16���ƻ���10���ƣ�
        if ~isHexDisp  %%��ͨ��ʾ��ʽ
            c=char(a');
        else           %%16������ʾ����
            strHex=dec2hex(a')';
            strHex=[strHex;blanks(size(a,1))];
            c = strHex(:)';
        end
        numRec=numRec+size(a,1);
        %% ����Ҫ��ʾ���ַ������ַ������ۼӣ�
        strRec=[strRec c];
        %%ͼ����ʾ����
        if getappdata(handles.figure1,'isFirst')==false
            
            set(figure(1),'name','�Ϻ����´�ѧ����ͷר����λ��','Numbertitle','off');
            colormap(gray);
            imagesc(img);
            title('ͼ��ʵʱ����ϵͳ');
            axis off;
        end
    end
    %%��������
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
set(handles.xianshi,'String',strRec);       %%����ʾ����ʾ�յ�������

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
[FileName,PathName] = uiputfile('*.txt','�ļ����Ϊ','dat1.txt');
dlmwrite(FileName,img,'delimiter','\t','newline','pc');
warndlg('����ɹ���','֪ͨ');

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
set(figure(1),'name','�Ϻ����´�ѧ����ͷר����λ��','Numbertitle','off');
colormap(gray);
imagesc(img);
title('ͼ��ʵʱ����ϵͳ');
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
Tracking_NUM2=15;   %%ר�����ڴӱ�Ե��ʼ����
Tracking_displacement=13;
for z=1:camera_H          %%�ֶ�����ͼ��ɼ�����
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
    
    %%���߳�����ȡ
    
    
    
    %%����ϴ�һ����ƫ�����ƫ��̫�����Ļ�����Ĭ��ֻ��һ������ɨ��
    if mid_old<=2+Interval
        sao_zuo=0;
        mid_old=2+Interval;
    end
    if mid_old>=camera_W-Interval-1
        sao_you=0;
        mid_old=camera_W-Interval-1
    end
    %%������������������׼����Ҫȡ���������⣿��������������
    %%ɨ��׼������
    if sao_zuo
        for i=round(mid_old):-1:1+Interval                              %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
            if img(Last_line,i)-img(Last_line,i-Interval)>Jump_threshold
                leftline(Last_line)=i-Interval;
                leftline_flag=1;
                break;
            else
                leftline_flag=0;
            end
        end
    end
    
    %%ɨ��׼������
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
    
    
    %%�������߻������ߺ�ֱ�������������ϳ���һ���Ѿ���ʧ���ߣ�����У���������
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
    %%�������ߺ����߼�������λ�ã���ָ����У�
    midline(Last_line)=(leftline(Last_line)+rightline(Last_line))/2;
    %%��ֵ���������λ�ã���Ϊ��һ�ε�ɨ�����
    mid_old=midline(Last_line);
    
    %%������������������������׼�вɼ���������������������������������
    
    
    %%�������������������������������㷨������������������������������
    %%���߸���
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
            if find_line_left==0                    %%��¼���߶��߿�ʼ��
                break_left=i;
                break;
            end
        end
    end
    
    %%���߸���
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
            if find_line_right==0                   %%��¼���߶��߿�ʼ��
                break_right=i;
                break;
            end
        end
    end
    %%�������������������������������㷨��ϣ���������������������������
    
    %%����������������������ʮ���жϣ���������������������������
    shizi_flag=0;
    %%��������ֱ��ʮ�֣�������
    shizi_flag_zhi=0;
    %%ʮ������ͬʱ���ߣ���ȫ����ǰ�˺��ߵĲ��߷�ʽ
    if rightline_flag==0 && leftline_flag==0 
        white=0;
        start_check=camera_H;              %%������ͬʱ���ߣ����ж�ǰ�����Ƿ�ȫΪ�׵�
        for i=1:1:camera_W
            if img(start_check-2,i)>140        %%ȷ��ɨ���Ķ�ֻ�а׵㣨�׵��������225�㣩
                white=white+1;
                if white>camera_W-5
                    shizi_flag_zhi=2;
                end
            end
        end
    %% ���ߺ���ɨ�����ٵ��������ȫ����ǰ�˺��ߵĲ��߷�ʽ
    elseif (break_left>=38 || break_right>=38) && abs(break_right-break_left)<3   %%��һ�ߺ�������3�У������ߺ���֮��С��һ��ֵ
        
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
    %%���������������еĺ��ߣ����Һ�������С��10�У������������߲��߷�ʽ����������������10�У����ȡֱ�Ӳ��ߵķ�ʽ��
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
    
    %%ֱ��ʮ���ж���ɣ�flag=1Ϊ�����������߲��߷�ʽ��flag=2Ϊ����ǰ�˺��߲��߷�ʽ�������ֲ��߷�ʽ����һ����ƫ��ɿ���ֱ�Ӳ����߽�����⣩
    %%��������ֱ��ʮ���ж���ɣ�������
    
    
    %%��������б��ʮ���жϣ�������
    %%��ʼ����б��ʮ�ֵ����
    xierushizi_flag=0;
    tiaobian=0;
    shizi_flag_xie=0;
    if shizi_flag_zhi==0                %%�������ֱ��ʮ�֣���ô�Ϳ�ʼ�ж��Ƿ�Ϊб��ʮ��
        if rightline_flag==1
            if  break_right<30
                for i=camera_H-5:-1:6             %%��ֹ����������������󣨸���Ŀ���������ڵ�35��֮ǰ�������
                    if rightline(i)-rightline(i+1)<0 && rightline(i-1)-rightline(i)>0
                        tiaobian=i;
                        slope1=(rightline(i)-rightline(i+5))/5;
                        slope2=(rightline(i-5)-rightline(i))/5;
                        break;
                    end
                end
            else                                   %%��������߱�־�����������С��5�У���ô�ж���ǰ�������Ƿ�Ϊȫ��
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
            
        elseif leftline_flag==1          %%��б��������Գ�
            if break_left<30
            for i=camera_H-5:-1:6                 %%��ֹ����������������󣨸���Ŀ���������ڵ�35��֮ǰ�������
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
    
    if tiaobian~=0 && abs(slope1-slope2)>10 && slope1*slope2<0  %%��������㸽����б��֮����ȷ���Ƿ�Ϊб��ʮ��              
       xierushizi_flag=1;
    end
    
    if xierushizi_flag==1 || shizi_flag_xie==2 || shizi_flag_xie==1 || shizi_flag_zhi==1 || shizi_flag_zhi==2  %%ʮ�ֱ�־���ܽ�
        shizi_flag=1;
    end
    %%��������б��ʮ��ʶ����ϣ�������
    %%��������������������������ʮ��ʶ����ϣ���������Ϊ���ʮ�ֵĲ��߳��򣡣�����������������������������������������
    
    
    
    %%������ֱ��ʮ�ֱ�־λ����ȫ�������ҳ�ʮ�����¿�ʼ������������
    if shizi_flag_zhi==1 || shizi_flag_zhi==2                      
        shizi_star=0;                                              
        for i=start_check-2:-1:1
            for j=round(camera_W/2):-1:1+Interval                   %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
            for j=round(camera_W/2):1:camera_W-Interval                   %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
        %%��ʮ��ǰ���ɨ���ߺ󣬽�����ǰ��������ɨ��
        for j=round(camera_W/2):-1:1+Interval
            if img(shizi_star-2,j)-img(shizi_star-2,j-Interval)>Jump_threshold     %%������λ���У���ֹ���ŵĺ��߸���
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
    %%����б��ʮ�֣�����ȫ���е���������ҵײ���߲��ɿ���ֻ��һ��ɨ�ߣ���
    elseif shizi_flag_xie==1           %%���ߴ���б��ʮ�ֵ������ֻ׷�����ߣ���������ƫ�����
        shizi_star=0;
        for i=start_check-2:-1:1
            for j=1:1:camera_W-Interval     %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
    elseif shizi_flag_xie==2           %%���ߴ���б��ʮ�ֵ������ֻ׷�����ߣ���������ƫ���ұ�
        shizi_star=0;
        for i=start_check-2:-1:1
            for j=camera_W:-1:1+Interval        %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
    %%���������ҵ�ʮ�����¿�ʼ�������������ҵ���ʱ�����ߺ����ߣ�������
    
    break_left_shizi=0;
    break_right_shizi=0;
    %%�����������������������������¿�ʼ��ʮ�ֺ��߽��и��٣�������������������������
    if shizi_flag_zhi==1 || shizi_flag_zhi==2
        %%ʮ��ǰ�˸��ٺ���
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
            if find_line_left==0                    %%��¼���߶��߿�ʼ��
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
            if find_line_right==0                   %%��¼���߶��߿�ʼ��
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
            if find_line_right==0                   %%��¼���߶��߿�ʼ��
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
            if find_line_left==0                    %%��¼���߶��߿�ʼ��
                break_left_shizi=i;
                break;
            end
        end
    end
        
    
    
    
    %%��������ֱ��ʮ�ֲ��߳��򣡣�����
    if shizi_flag_zhi==1             %%�����ߣ������������߲��߷�ʽ����������ҵ����º��߽϶�����
        slope=(leftline(break_left+2)-leftline(shizi_star-2))/(break_left-shizi_star+4);
        for i=break_left+1:-1:shizi_star-1
            leftline(i)=leftline(break_left+2)-slope*(break_left+2-i);
        end
        
        slope=(rightline(break_right+2)-rightline(shizi_star-2))/(break_right-shizi_star+4);
        for i=break_right+1:-1:shizi_star-1
            rightline(i)=rightline(break_right+2)-slope*(break_right+2-i);
        end
    elseif shizi_flag_zhi==2          %%������ٺ��߳�����ȫ����ǰ����������첹��     
        slope=(leftline(shizi_star-2)-leftline(shizi_star-7))/5;
        for i=shizi_star-2:1:camera_H
            leftline(i)=leftline(shizi_star-2)-slope*(shizi_star-2-i-1);
        end
        
        slope=(rightline(shizi_star-2)-rightline(shizi_star-7))/5;
        for i=shizi_star-2:1:camera_H
            rightline(i)=rightline(shizi_star-2)-slope*(shizi_star-2-i-1);
        end
    %%��������б��ʮ�ֲ��߳��򣡣�����
    elseif xierushizi_flag==1            %%�����б��ʮ��,���ҵ��вο���϶࣬������䴦��ʼ���ߣ�ֱ����ǰ����,ȫ�����꣬��������ǰ���ߵ��ں��ԣ�
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
    
    
    %%��������ʮ����ǰ�����߳��򣡣����������ÿ������������������Ϊ������������Լ����߲��꣩
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
    
    
    %%��ʮ������µĲ��ߣ��л�׼�㣬�Һ��߳���10���㣬����ʼ���ߣ�����ǰ���б�����ϲ���
    if shizi_flag==0
        if break_left~=0 || break_right~=0
            if break_left<=30                        %%ȷ��������10����
                slope=(leftline(break_left+1)-leftline(break_left+6))/5;
                
                for i=break_left:-1:1
                    leftline(i)=slope*(break_left-i+1)+leftline(break_left+1);
                end
            end
        end
        
        if break_right<=30                           %%ȷ��������10����
            slope=(rightline(break_right+1)-rightline(break_right+6))/5;
            
            for i=break_right:-1:1
                rightline(i)=slope*(break_right-i+1)+rightline(break_right+1);
            end
        end
    end

        
    if shizi_flag==0     %%ֻ���ڲ���ʮ���жϵ������£�ִ�д��м����߳���
        
        %% ��ֻ������û��ɨ��ʱ��ֱ�Ӵ����Ե�Һ���
        if leftline_flag==0 && rightline_flag==1
            for i=camera_H-1:-1:1                   %%���ɼ�20�У�����ȥ��Ҫ�ų�����Զ��������Ӱ�죿��
                find_mid_left=0;
                if rightline(i)<5                   %%������߹���ƫ����ߣ���ôֱ���������������߲����ܱ��ҵ�
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
        
        %% ��ֻ������û��ɨ��ʱ��ֱ�Ӵ��ұ�Ե�Һ���
        if leftline_flag==1 && rightline_flag==0
            for i=camera_H-1:-1:1                    %%���ɼ�20�У�����ȥ��Ҫ�ų�����Զ��������Ӱ�죿��
                find_mid_right=0;
                if leftline(i)>camera_W-5             %%������߹���ƫ���ұߣ���ôֱ���������������߲����ܱ��ҵ�
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
        
        
        %%�����㷨���ӱ߽��ҵ��ĵ㿪ʼ���٣�ȷ����ӦΪ��ʼ�ж��߶����嶪�ߣ����ߣ�
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
                if find_line_left==0                    %%��¼���߶��߿�ʼ��
                    break_left=i;
                    break;
                end
            end
        end
        
        %%�����㷨���ӱ߽��ҵ��ĵ㿪ʼ���٣�ȷ����ӦΪ��ʼ�ж��߶����嶪�ߣ����ߣ�
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
                if find_line_right==0                   %%��¼���߶��߿�ʼ��
                    break_right=i;
                    break;
                end
            end
        end
        
        
        %%���ո����м��ҵ��ߵ����һ������ԭ������һ���ߵ����һ�����Ƚϣ����ж���һ�ߵ����²���
        if leftline_flag==0 && mid_left~=0
            if break_left~=0                                                %%�Լ������ߵĲ���
                slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%���㲹�߷����������һ���б��
                for i=break_left:-1:1
                    leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
                end
            end
            if break_left<break_right                                       %%����һ���ߵĸ�������
                slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%���㲹�߷����������һ���б��
                for i=break_right:-1:1
                    rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
                end
            end
        end
        
        if rightline_flag==0 && mid_right~=0
            if break_right~=0                                                %%�Լ������ߵĲ���
                slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%���㲹�߷����������һ���б��
                for i=break_right:-1:1
                    rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
                end
            end
            if break_left>break_right
                slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%���㲹�߷����������һ���б��
                for i=break_left:-1:1
                    leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
                end
            end
        end
        
        
        %%��߻�����δ�ҵ��ߵĲ���
        if leftline_flag==0 && mid_left~=0
            
            slope=(leftline(mid_left-3)-leftline(mid_left))/3;
            for i=mid_left:1:40
                leftline(i)=slope*(mid_left-i)+leftline(mid_left);
            end
            %%�ұ߻�����δ�ҵ��ߵĲ���
        elseif rightline_flag==0 && mid_right~=0
            slope=(rightline(mid_right-3)-rightline(mid_right))/3;
            for i=mid_right:1:40
                rightline(i)=slope*(mid_right-i)+rightline(mid_right);
            end
        end
        
    end
    
    
    %%���߻���������һ����ȫ���߻��߿ɲο���ǳ��ٵ����
    if shizi_flag_zhi==0                                       %%�ڷ�ֱ��ʮ�ֵ�����½����ж�
        if (break_left>=30 && abs(break_right-break_left)>4 && shizi_flag_xie==0) || (leftline_flag==0 && mid_left==0)    %%��б��ʮ���Ҳο�����ٻ��߶������޷���ǰ���ҵ�����  
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
    
    %%���߼���
    midline=(rightline+leftline)/2;
    

    %%��ʾ�ɼ�����ͼ��
    set(figure(1),'name','�Ϻ����´�ѧ����ͷר����λ��','Numbertitle','off');
    colormap(gray);
    imagesc(img);
    title('ͼ��ʵʱ����ϵͳ');
    hold on
    for z=1:camera_H
        %%��������Ƴ�����ͼ����ĺ���Ҳ����ʾ��ͼ����
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
        
        %%��ʾ�������߼�������
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
Tracking_NUM2=15;   %%ר�����ڴӱ�Ե��ʼ����
Tracking_displacement=13;
for z=1:camera_H          %%�ֶ�����ͼ��ɼ�����
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
    
    %%���߳�����ȡ
    
    
    
    %%����ϴ�һ����ƫ�����ƫ��̫�����Ļ�����Ĭ��ֻ��һ������ɨ��
    if mid_old<=2+Interval
        sao_zuo=0;
        mid_old=2+Interval;
    end
    if mid_old>=camera_W-Interval-1
        sao_you=0;
        mid_old=camera_W-Interval-1
    end
    %%������������������׼����Ҫȡ���������⣿��������������
    %%ɨ��׼������
    if sao_zuo
        for i=round(mid_old):-1:1+Interval                              %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
            if img(Last_line,i)-img(Last_line,i-Interval)>Jump_threshold
                leftline(Last_line)=i-Interval;
                leftline_flag=1;
                break;
            else
                leftline_flag=0;
            end
        end
    end
    
    %%ɨ��׼������
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
    
    
    %%�������߻������ߺ�ֱ�������������ϳ���һ���Ѿ���ʧ���ߣ�����У���������
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
    %%�������ߺ����߼�������λ�ã���ָ����У�
    midline(Last_line)=(leftline(Last_line)+rightline(Last_line))/2;
    %%��ֵ���������λ�ã���Ϊ��һ�ε�ɨ�����
    mid_old=midline(Last_line);
    
    %%������������������������׼�вɼ���������������������������������
    
    
    %%�������������������������������㷨������������������������������
    %%���߸���
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
            if find_line_left==0                    %%��¼���߶��߿�ʼ��
                break_left=i;
                break;
            end
        end
    end
    
    %%���߸���
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
            if find_line_right==0                   %%��¼���߶��߿�ʼ��
                break_right=i;
                break;
            end
        end
    end
    %%�������������������������������㷨��ϣ���������������������������
    
%     %����������������������ʮ���жϣ���������������������������
%     shizi_flag=0;
%     %��������ֱ��ʮ�֣�������
%     shizi_flag_zhi=0;
%     %ʮ������ͬʱ���ߣ���ȫ����ǰ�˺��ߵĲ��߷�ʽ
%     if rightline_flag==0 && leftline_flag==0 
%         white=0;
%         start_check=camera_H;              %%������ͬʱ���ߣ����ж�ǰ�����Ƿ�ȫΪ�׵�
%         for i=1:1:camera_W
%             if img(start_check-2,i)>140        %%ȷ��ɨ���Ķ�ֻ�а׵㣨�׵��������225�㣩
%                 white=white+1;
%                 if white>camera_W-5
%                     shizi_flag_zhi=2;
%                 end
%             end
%         end
%     % ���ߺ���ɨ�����ٵ��������ȫ����ǰ�˺��ߵĲ��߷�ʽ
%     elseif (break_left>=38 || break_right>=38) && abs(break_right-break_left)<3   %%��һ�ߺ�������3�У������ߺ���֮��С��һ��ֵ
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
%     %���������������еĺ��ߣ����Һ�������С��10�У������������߲��߷�ʽ����������������10�У����ȡֱ�Ӳ��ߵķ�ʽ��
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
%     %ֱ��ʮ���ж���ɣ�flag=1Ϊ�����������߲��߷�ʽ��flag=2Ϊ����ǰ�˺��߲��߷�ʽ�������ֲ��߷�ʽ����һ����ƫ��ɿ���ֱ�Ӳ����߽�����⣩
%     %��������ֱ��ʮ���ж���ɣ�������
%     
%     
%     %��������б��ʮ���жϣ�������
%     %��ʼ����б��ʮ�ֵ����
%     xierushizi_flag=0;
%     tiaobian=0;
%     shizi_flag_xie=0;
%     if shizi_flag_zhi==0                %%�������ֱ��ʮ�֣���ô�Ϳ�ʼ�ж��Ƿ�Ϊб��ʮ��
%         if rightline_flag==1
%             if  break_right<30
%                 for i=camera_H-5:-1:6             %%��ֹ����������������󣨸���Ŀ���������ڵ�35��֮ǰ�������
%                     if rightline(i)-rightline(i+1)<0 && rightline(i-1)-rightline(i)>0
%                         tiaobian=i;
%                         slope1=(rightline(i)-rightline(i+5))/5;
%                         slope2=(rightline(i-5)-rightline(i))/5;
%                         break;
%                     end
%                 end
%             else                                   %%��������߱�־�����������С��5�У���ô�ж���ǰ�������Ƿ�Ϊȫ��
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
%         elseif leftline_flag==1          %%��б��������Գ�
%             if break_left<30
%             for i=camera_H-5:-1:6                 %%��ֹ����������������󣨸���Ŀ���������ڵ�35��֮ǰ�������
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
%     if tiaobian~=0 && abs(slope1-slope2)>10 && slope1*slope2<0  %%��������㸽����б��֮����ȷ���Ƿ�Ϊб��ʮ��              
%        xierushizi_flag=1;
%     end
%     
%     if xierushizi_flag==1 || shizi_flag_xie==2 || shizi_flag_xie==1 || shizi_flag_zhi==1 || shizi_flag_zhi==2  %%ʮ�ֱ�־���ܽ�
%         shizi_flag=1;
%     end
%     %��������б��ʮ��ʶ����ϣ�������
%     %��������������������������ʮ��ʶ����ϣ���������Ϊ���ʮ�ֵĲ��߳��򣡣�����������������������������������������
%     
%     
%     
%     %������ֱ��ʮ�ֱ�־λ����ȫ�������ҳ�ʮ�����¿�ʼ������������
%     if shizi_flag_zhi==1 || shizi_flag_zhi==2                      
%         shizi_star=0;                                              
%         for i=start_check-2:-1:1
%             for j=round(camera_W/2):-1:1+Interval                   %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
%             for j=round(camera_W/2):1:camera_W-Interval                   %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
%         %��ʮ��ǰ���ɨ���ߺ󣬽�����ǰ��������ɨ��
%         for j=round(camera_W/2):-1:1+Interval
%             if img(shizi_star-2,j)-img(shizi_star-2,j-Interval)>Jump_threshold     %%������λ���У���ֹ���ŵĺ��߸���
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
%     %����б��ʮ�֣�����ȫ���е���������ҵײ���߲��ɿ���ֻ��һ��ɨ�ߣ���
%     elseif shizi_flag_xie==1           %%���ߴ���б��ʮ�ֵ������ֻ׷�����ߣ���������ƫ�����
%         shizi_star=0;
%         for i=start_check-2:-1:1
%             for j=1:1:camera_W-Interval     %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
%     elseif shizi_flag_xie==2           %%���ߴ���б��ʮ�ֵ������ֻ׷�����ߣ���������ƫ���ұ�
%         shizi_star=0;
%         for i=start_check-2:-1:1
%             for j=camera_W:-1:1+Interval        %����һ����������߿�ʼ���ߣ��漰����һ������ȡ������
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
%     %���������ҵ�ʮ�����¿�ʼ�������������ҵ���ʱ�����ߺ����ߣ�������
%     
%     break_left_shizi=0;
%     break_right_shizi=0;
%     %�����������������������������¿�ʼ��ʮ�ֺ��߽��и��٣�������������������������
%     if shizi_flag_zhi==1 || shizi_flag_zhi==2
%         %ʮ��ǰ�˸��ٺ���
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
%             if find_line_left==0                    %%��¼���߶��߿�ʼ��
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
%             if find_line_right==0                   %%��¼���߶��߿�ʼ��
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
%             if find_line_right==0                   %%��¼���߶��߿�ʼ��
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
%             if find_line_left==0                    %%��¼���߶��߿�ʼ��
%                 break_left_shizi=i;
%                 break;
%             end
%         end
%     end
%         
%     
%     
%     
%     %��������ֱ��ʮ�ֲ��߳��򣡣�����
%     if shizi_flag_zhi==1             %%�����ߣ������������߲��߷�ʽ����������ҵ����º��߽϶�����
%         slope=(leftline(break_left+2)-leftline(shizi_star-2))/(break_left-shizi_star+4);
%         for i=break_left+1:-1:shizi_star-1
%             leftline(i)=leftline(break_left+2)-slope*(break_left+2-i);
%         end
%         
%         slope=(rightline(break_right+2)-rightline(shizi_star-2))/(break_right-shizi_star+4);
%         for i=break_right+1:-1:shizi_star-1
%             rightline(i)=rightline(break_right+2)-slope*(break_right+2-i);
%         end
%     elseif shizi_flag_zhi==2          %%������ٺ��߳�����ȫ����ǰ����������첹��     
%         slope=(leftline(shizi_star-2)-leftline(shizi_star-7))/5;
%         for i=shizi_star-2:1:camera_H
%             leftline(i)=leftline(shizi_star-2)-slope*(shizi_star-2-i-1);
%         end
%         
%         slope=(rightline(shizi_star-2)-rightline(shizi_star-7))/5;
%         for i=shizi_star-2:1:camera_H
%             rightline(i)=rightline(shizi_star-2)-slope*(shizi_star-2-i-1);
%         end
%     %��������б��ʮ�ֲ��߳��򣡣�����
%     elseif xierushizi_flag==1            %%�����б��ʮ��,���ҵ��вο���϶࣬������䴦��ʼ���ߣ�ֱ����ǰ����,ȫ�����꣬��������ǰ���ߵ��ں��ԣ�
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
%     %��������ʮ����ǰ�����߳��򣡣����������ÿ������������������Ϊ������������Լ����߲��꣩
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
%     %��ʮ������µĲ��ߣ��л�׼�㣬�Һ��߳���10���㣬����ʼ���ߣ�����ǰ���б�����ϲ���
%     if shizi_flag==0
%         if break_left~=0 || break_right~=0
%             if break_left<=30                        %%ȷ��������10����
%                 slope=(leftline(break_left+1)-leftline(break_left+6))/5;
%                 
%                 for i=break_left:-1:1
%                     leftline(i)=slope*(break_left-i+1)+leftline(break_left+1);
%                 end
%             end
%         end
%         
%         if break_right<=30                           %%ȷ��������10����
%             slope=(rightline(break_right+1)-rightline(break_right+6))/5;
%             
%             for i=break_right:-1:1
%                 rightline(i)=slope*(break_right-i+1)+rightline(break_right+1);
%             end
%         end
%     end
% 
%         
%     if shizi_flag==0     %%ֻ���ڲ���ʮ���жϵ������£�ִ�д��м����߳���
%         
%         % ��ֻ������û��ɨ��ʱ��ֱ�Ӵ����Ե�Һ���
%         if leftline_flag==0 && rightline_flag==1
%             for i=camera_H-1:-1:1                   %%���ɼ�20�У�����ȥ��Ҫ�ų�����Զ��������Ӱ�죿��
%                 find_mid_left=0;
%                 if rightline(i)<5                   %%������߹���ƫ����ߣ���ôֱ���������������߲����ܱ��ҵ�
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
%         % ��ֻ������û��ɨ��ʱ��ֱ�Ӵ��ұ�Ե�Һ���
%         if leftline_flag==1 && rightline_flag==0
%             for i=camera_H-1:-1:1                    %%���ɼ�20�У�����ȥ��Ҫ�ų�����Զ��������Ӱ�죿��
%                 find_mid_right=0;
%                 if leftline(i)>camera_W-5             %%������߹���ƫ���ұߣ���ôֱ���������������߲����ܱ��ҵ�
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
%         %�����㷨���ӱ߽��ҵ��ĵ㿪ʼ���٣�ȷ����ӦΪ��ʼ�ж��߶����嶪�ߣ����ߣ�
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
%                 if find_line_left==0                    %%��¼���߶��߿�ʼ��
%                     break_left=i;
%                     break;
%                 end
%             end
%         end
%         
%         %�����㷨���ӱ߽��ҵ��ĵ㿪ʼ���٣�ȷ����ӦΪ��ʼ�ж��߶����嶪�ߣ����ߣ�
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
%                 if find_line_right==0                   %%��¼���߶��߿�ʼ��
%                     break_right=i;
%                     break;
%                 end
%             end
%         end
%         
%         
%         %���ո����м��ҵ��ߵ����һ������ԭ������һ���ߵ����һ�����Ƚϣ����ж���һ�ߵ����²���
%         if leftline_flag==0 && mid_left~=0
%             if break_left~=0                                                %%�Լ������ߵĲ���
%                 slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%���㲹�߷����������һ���б��
%                 for i=break_left:-1:1
%                     leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
%                 end
%             end
%             if break_left<break_right                                       %%����һ���ߵĸ�������
%                 slope=(leftline(break_left+1)-leftline(break_left+4))/3;    %%���㲹�߷����������һ���б��
%                 for i=break_right:-1:1
%                     rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
%                 end
%             end
%         end
%         
%         if rightline_flag==0 && mid_right~=0
%             if break_right~=0                                                %%�Լ������ߵĲ���
%                 slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%���㲹�߷����������һ���б��
%                 for i=break_right:-1:1
%                     rightline(i)=rightline(break_right+1)+slope*(break_right-i+1);
%                 end
%             end
%             if break_left>break_right
%                 slope=(rightline(break_right+1)-rightline(break_right+4))/3;    %%���㲹�߷����������һ���б��
%                 for i=break_left:-1:1
%                     leftline(i)=leftline(break_left+1)+slope*(break_left-i+1);
%                 end
%             end
%         end
%         
%         
%         %��߻�����δ�ҵ��ߵĲ���
%         if leftline_flag==0 && mid_left~=0
%             
%             slope=(leftline(mid_left-3)-leftline(mid_left))/3;
%             for i=mid_left:1:40
%                 leftline(i)=slope*(mid_left-i)+leftline(mid_left);
%             end
%             %�ұ߻�����δ�ҵ��ߵĲ���
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
%     %���߻���������һ����ȫ���߻��߿ɲο���ǳ��ٵ����
%     if shizi_flag_zhi==0                                       %%�ڷ�ֱ��ʮ�ֵ�����½����ж�
%         if (break_left>=30 && abs(break_right-break_left)>4 && shizi_flag_xie==0) || (leftline_flag==0 && mid_left==0)    %%��б��ʮ���Ҳο�����ٻ��߶������޷���ǰ���ҵ�����  
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
    
    %%���߼���
    midline=(rightline+leftline)/2;
    

    %%��ʾ�ɼ�����ͼ��
    set(figure(1),'name','�Ϻ����´�ѧ����ͷר����λ��','Numbertitle','off');
    colormap(gray);
    imagesc(img);
    title('ͼ��ʵʱ����ϵͳ');
    hold on
    for z=1:camera_H
        %%��������Ƴ�����ͼ����ĺ���Ҳ����ʾ��ͼ����
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
        
        %%��ʾ�������߼�������
        plot(leftline(z),z,'g*');
        plot(rightline(z),z,'b*');
        plot(midline(z),z,'r*');
    end
    
    
    

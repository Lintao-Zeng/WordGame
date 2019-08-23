unit Unit_wuziqi;

interface

uses
  Windows, Messages, SysUtils,Classes;
const
  wuziqi_char_count_cn= 255;
  wuziqi_msg_c= $0400 + $6613;
type
  Twuziqi = class(TThread)
  private
   filename: string;
   hh: thandle;
   MyInput, ChildOutput,ChildInput, MyOutput: THandle;
si: STARTUPINFO;
lsa: SECURITY_ATTRIBUTES;
pi: PROCESS_INFORMATION;
cchReadBuffer: DWORD;
fname: array[0..max_path] of Char;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(aFileName: String; h:thandle); //�����������ai����

  end;

  var wuziqi_CriticalSection: TRTLCriticalSection; //�ؼ������
     wuziqi_flag: integer;
       {0 ��Ч״̬
        1 ��ȡ����д����
        2���ݻ�ȡ��ϣ��ɶ�ȡ��
        3 ��ȡ��
        4 ��ȡ���
        5 ��������д����
        6 ���ݿ��Է�����
        7 ���ݷ�����
        8���ݷ������
        }
      wuziqi_receive,wuziqi_send: array[0..wuziqi_char_count_cn] of char;
implementation

{ wuziqi }
constructor Twuziqi.Create(aFileName: String; h:thandle);  //tmp�ؼ���ָ���Ƿ�������ʱ�ؼ���ָ�����ļ�
begin
  FreeOnTerminate := True;
  inherited Create(True);

   FileName:= aFileName;
   hh:= h;
   if not FileExists(filename) then
     begin
      //������Ϣ����ʾ���治����
      postmessage(hh,wuziqi_msg_c,0,999);
      exit;
     end;

     //��������

lsa.nLength := sizeof(SECURITY_ATTRIBUTES);
lsa.lpSecurityDescriptor := nil;
lsa.bInheritHandle := True;
      //  ��������ܵ����ӱ����������������̣�
  if CreatePipe(MyInput, ChildOutput, @lsa, 0) = false then
    begin
     //������Ϣ�������ܵ�ʧ��
      postmessage(hh,wuziqi_msg_c,1,999);
      exit;
    end;


    //��������ܵ����ӱ����������������̣�
  if CreatePipe(ChildInput, MyOutput , @lsa, wuziqi_char_count_cn) = false then
    begin
     //������Ϣ�������ܵ�ʧ��
      postmessage(hh,wuziqi_msg_c,1,999);
      exit;
    end;

fillchar(si, sizeof(STARTUPINFO), 0);
si.cb := sizeof(STARTUPINFO);
si.dwFlags := (STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW);
si.wShowWindow := SW_HIDE;
si.hStdOutput := ChildOutput;
si.hStdInput:= ChildInput;
fillchar(fname, sizeof(fname), #0);


//fname := 'cmd.exe cmd/c ';
lstrcat(fname, pchar(filename));

    if CreateProcess( nil, fname, nil, nil, true, NORMAL_PRIORITY_CLASS, nil, nil, si, pi) = False  then
     begin
      //���ش�����Ϣ����������ʧ��
      postmessage(hh,wuziqi_msg_c,2,999);
      exit;
     end;
     
 writefile(MyOutput,'START 15'+#13#10,10,cchreadbuffer,nil);

     InitializeCriticalSection(wuziqi_CriticalSection); //��ʼ���ؼ�����α���

  Resume;
end;

procedure Twuziqi.Execute;
begin
  { Place thread code here }


while not Terminated do
begin
 cchReadBuffer:= 0;
  if not PeekNamedPipe(MyInput, @wuziqi_receive, wuziqi_char_count_cn, @cchReadBuffer, nil, nil) then
    break;

     if cchReadBuffer <> 0 then
     begin
      //EnterCriticalSection(wuziqi_CriticalSection);
       //wuziqi_flag:= 1;// ���ݻ�ȡ��
      //��ȡ����
       fillchar(wuziqi_receive, sizeof(wuziqi_receive), #0);
        if ReadFile(MyInput, wuziqi_receive, wuziqi_char_count_cn, cchReadBuffer, nil) = false then
           break;
       // wuziqi_flag:= 2;// ���ݻ�ȡ��ϣ��ɹ���ȡ
      //LeaveCriticalSection(wuziqi_CriticalSection);
       //������Ϣ������׼������
        sendmessage(hh,wuziqi_msg_c,3,999);

     end else begin
              //���ܵ�д����
              if wuziqi_flag= 6 then
               begin
              EnterCriticalSection(wuziqi_CriticalSection);
               wuziqi_flag:= 7; //���ݷ�����
               writefile(MyOutput,wuziqi_send,byte(wuziqi_send[wuziqi_char_count_cn]),cchreadbuffer,nil);
               wuziqi_flag:= 8; //���ݷ������
              LeaveCriticalSection(wuziqi_CriticalSection);
               end;
             end;

  // if(WaitForSingleObject(pi.hProcess , 0) = WAIT_OBJECT_0) then break;

  Sleep(50);
end;

//���������˳���Ϣ
  writefile(MyOutput,'end'+#13#10,5,cchreadbuffer,nil);

 DeleteCriticalSection(wuziqi_CriticalSection);
CloseHandle(MyOutput);
CloseHandle(Myinput);
CloseHandle(ChildInput);
CloseHandle(Childoutput);
CloseHandle(pi.hThread);
CloseHandle(pi.hProcess);


end;


end.
 
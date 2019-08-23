{*******************************************************************************

                          AAFont - ƽ����Ч����ؼ���
                          ---------------------------
                           (C)Copyright 2001-2004
                            CnPack ������ �ܾ���

            ��һ�ؼ����������������������������������������GNU ��
        ����ͨ�ù������֤Э�����޸ĺ����·�����һ���򣬻��������֤��
        �ڶ��棬���ߣ���������ѡ�����κθ��µİ汾��

            ������һ�ؼ�����Ŀ����ϣ�������ã���û���κε���������û��
        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� GNU �Ͽ���ͨ�ù�
        �����֤��

            ��Ӧ���Ѿ��Ϳؼ���һ���յ�һ�� GNU �Ͽ���ͨ�ù������֤��
        �����������û�У�д�Ÿ���
            Free Software Foundation, Inc., 59 Temple Place - Suite
        330, Boston, MA 02111-1307, USA.

            ��Ԫ���ߣ�CnPack ������ �ܾ���
            ���ص�ַ��http://www.yygw.net
            �����ʼ���yygw@yygw.net

*******************************************************************************}

unit AATimer;
{* |<PRE>
================================================================================
* ������ƣ�ƽ����Ч����ؼ���
* ��Ԫ���ƣ��߾��ȶ�ʱ�����TAATimer��Ԫ
* ��Ԫ���ߣ�CnPack ������ �ܾ���
* ��    ע��- Delphi�Դ���TTimerʹ�ò���ϵͳ����Ϣ��ʽ�ṩ�Ķ�ʱ������Win9X��
*             ��ʱ���Ƚ�Ϊ55ms��NT��Լ10ms��
*           - TAATimer���õ������߳̽��ж�ʱ���ƣ����ȱ�TTimerҪ�ߣ���Ӧ��Ҳռ
*             �ý϶��CPU��Դ����ʹ�÷�ʽ��TTimer��ɼ��ݣ����ṩ�˸���Ĺ��ܡ�
*           - TAATimerList��ʱ���б����ͬʱ���������ʱ����
*           - ���ж�ʱ��ʹ��ͬһ���̶߳�ʱ���ʺϴ���ʹ�õĳ��ϡ�
*           - ����Win32����ռʽ���������ϵͳ�������߳���������CPUʱ��Ƭ�����
*             �������߳�ռ�ô���CPUʱ�䣬��ʹ������߾��ȣ�Ҳ��һ���ܱ�֤��ȷ
*             �Ķ�ʱ�����
* ����ƽ̨��PWin98SE + Delphi 5.0
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6
* �� �� �����õ�Ԫ�е��ַ��������ϱ��ػ�����ʽ
* ���¼�¼��2002.11.05 V2.0
*               ��дȫ�����룬���Ӷ�ʱ���б����ж�ʱ��ʹ��ͬһ�̶߳�ʱ
*           2002.04.18 V1.0
*               ������Ԫ
================================================================================
|</PRE>}

interface

{$I AAFont.inc}

uses
  Windows, SysUtils, Classes, Forms;

type

//==============================================================================
// �߾��ȶ�ʱ������
//==============================================================================

{ TAATimerObject }

  TAATimerObject = class(TObject)
  private
    FActualFPS: Double;
    FEnabled: Boolean;
    FExecCount: Cardinal;
    FInterval: Cardinal;
    FLastTickCount: Cardinal;
    FOnTimer: TNotifyEvent;
    FRepeatCount: Cardinal;
    FSyncEvent: Boolean;
    function GetFPS: Double;
    procedure SetEnabled(Value: Boolean);
    procedure SetFPS(Value: Double);
    procedure SetInterval(Value: Cardinal);
    procedure SetRepeatCount(Value: Cardinal);
  protected
    procedure Timer; dynamic;
  public
    constructor Create;
    destructor Destroy; override;
    property ActualFPS: Double read FActualFPS;
    property ExecCount: Cardinal read FExecCount;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FPS: Double read GetFPS write SetFPS stored False;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    property RepeatCount: Cardinal read FRepeatCount write SetRepeatCount
      default 0;
    property SyncEvent: Boolean read FSyncEvent write FSyncEvent default True;
  end;

//==============================================================================
// �߾��ȶ�ʱ�����
//==============================================================================

{ TAATimer }

  TAATimer = class(TComponent)
  {* �̶߳�ʱ�������ʹ�÷������� TTimer��}
  private
    FTimerObject: TAATimerObject;
    function GetActualFPS: Double;
    function GetEnabled: Boolean;
    function GetExecCount: Cardinal;
    function GetFPS: Double;
    function GetInterval: Cardinal;
    function GetOnTimer: TNotifyEvent;
    function GetRepeatCount: Cardinal;
    function GetSyncEvent: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetFPS(Value: Double);
    procedure SetInterval(Value: Cardinal);
    procedure SetOnTimer(Value: TNotifyEvent);
    procedure SetRepeatCount(Value: Cardinal);
    procedure SetSyncEvent(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    property ActualFPS: Double read GetActualFPS;
    {* ʵ�ʵĶ�ʱ�����ʣ���ÿ��}
    property ExecCount: Cardinal read GetExecCount;
    {* �Ѿ�ִ�й��Ĵ���}
  published
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    {* ��ʱ���Ƿ�����}
    property FPS: Double read GetFPS write SetFPS stored False;
    {* ��ʱ���ٶȣ���ÿ��}
    property Interval: Cardinal read GetInterval write SetInterval default 1000;
    {* ��ʱ���������}
    property OnTimer: TNotifyEvent read GetOnTimer write SetOnTimer;
    {* ��ʱ�¼�}
    property RepeatCount: Cardinal read GetRepeatCount write SetRepeatCount
      default 0;
    {* ��ʱ�¼�����������ʱ�¼�����ָ���������Զ��رա����Ϊ 0 ��ʾ������}
    property SyncEvent: Boolean read GetSyncEvent write SetSyncEvent default
      True;
    {* �Ƿ�ʹ��ͬ����ʽ�����߳��в�����ʱ�¼������Ϊ false ���ڶ�ʱ�߳��в����¼�}
  end;

//==============================================================================
// �߾��ȶ�ʱ���б�������
//==============================================================================

{ TAATimerItem }

  TAATimerItem = class(TCollectionItem)
  {* �̶߳�ʱ���б����ʹ�÷������� TTimer��}
  private
    FOnTimer: TNotifyEvent;
    FTimerObject: TAATimerObject;
    function GetActualFPS: Double;
    function GetEnabled: Boolean;
    function GetExecCount: Cardinal;
    function GetFPS: Double;
    function GetInterval: Cardinal;
    function GetRepeatCount: Cardinal;
    function GetSyncEvent: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetFPS(Value: Double);
    procedure SetInterval(Value: Cardinal);
    procedure SetRepeatCount(Value: Cardinal);
    procedure SetSyncEvent(Value: Boolean);
  protected
    procedure Timer(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    procedure Assign(Source: TPersistent); override;
    {* ��ֵ����}
    property ActualFPS: Double read GetActualFPS;
    {* ʵ�ʵĶ�ʱ�����ʣ���ÿ��}
    property ExecCount: Cardinal read GetExecCount;
    {* �Ѿ�ִ�й��Ĵ���}
  published
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    {* ��ʱ���Ƿ�����}
    property FPS: Double read GetFPS write SetFPS stored False;
    {* ��ʱ���ٶȣ���ÿ��}
    property Interval: Cardinal read GetInterval write SetInterval default 1000;
    {* ��ʱ���������}
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    {* ��ʱ�¼�}
    property RepeatCount: Cardinal read GetRepeatCount write SetRepeatCount
      default 0;
    {* ��ʱ�¼�����������ʱ�¼�����ָ���������Զ��رա����Ϊ 0 ��ʾ������}
    property SyncEvent: Boolean read GetSyncEvent write SetSyncEvent default
      True;
    {* �Ƿ�ʹ��ͬ����ʽ�����߳��в�����ʱ�¼������Ϊ false ���ڶ�ʱ�߳��в����¼�}
  end;

//==============================================================================
// �߾��ȶ�ʱ���б�����
//==============================================================================

{ TAATimerCollection }

  TAATimerList = class;

  TAATimerCollection = class(TOwnedCollection)
  {* �̶߳�ʱ���б���}
  private
    FTimerList: TAATimerList;
    function GetItems(Index: Integer): TAATimerItem;
    procedure SetItems(Index: Integer; Value: TAATimerItem);
  protected
    property TimerList: TAATimerList read FTimerList;
  public
    constructor Create(AOwner: TPersistent);
    {* �๹����}
    property Items[Index: Integer]: TAATimerItem read GetItems write SetItems; default;
    {* ��ʱ����������}
  end;

//==============================================================================
// �߾��ȶ�ʱ���б����
//==============================================================================

{ TAATimerList }

  TAATimerEvent = procedure(Sender: TObject; Index: Integer; var Handled:
    Boolean) of object;
  {* �̶߳�ʱ���б��¼���Index Ϊ�����¼��Ķ�ʱ��������ţ�Handle �����Ƿ��Ѵ���
     ������¼��н� Handle ��Ϊ true�����������ö�ʱ�������¼�}
    
  TAATimerList = class(TComponent)
  {* �̶߳�ʱ���б���������Զ�������ʱ����}
  private
    FItems: TAATimerCollection;
    FOnTimer: TAATimerEvent;
    procedure SetItems(Value: TAATimerCollection);
  protected
    function Timer(Index: Integer): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
  published
    property Items: TAATimerCollection read FItems write SetItems;
    {* ��ʱ���б�}
    property OnTimer: TAATimerEvent read FOnTimer write FOnTimer;
    {* ��ʱ���¼�}
  end;

implementation

type

//==============================================================================
// �߾��ȶ�ʱ���̣߳�˽���ࣩ
//==============================================================================

{ TAATimerThread }

  TAATimerMgr = class;

  TAATimerThread = class(TThread)
  private
    FTimerMgr: TAATimerMgr;
  protected
    FInterval: Cardinal;
    FStop: THandle;
    procedure Execute; override;
    property TimerMgr: TAATimerMgr read FTimerMgr;
  public
    constructor Create(CreateSuspended: Boolean; ATimerMgr: TAATimerMgr);
  end;

//==============================================================================
// �߾��ȶ�ʱ����������˽���ࣩ
//==============================================================================

{ TAATimerMgr }

  TAATimerMgr = class(TObject)
  private
    FTimerList: TThreadList;                
    FTimerThread: TAATimerThread;
  protected
    procedure ClearTimer;
    procedure DoTimer(Sycn: Boolean);
    procedure SyncTimer; virtual;
    procedure Timer; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function AddTimer: TAATimerObject;
    procedure DeleteTimer(TimerObject: TAATimerObject); overload;
  end;

//==============================================================================
// �߾��ȶ�ʱ���̣߳�˽���ࣩ
//==============================================================================

{ TAATimerThread }

constructor TAATimerThread.Create(CreateSuspended: Boolean; ATimerMgr:
  TAATimerMgr);
begin
  inherited Create(CreateSuspended);
  Assert(Assigned(ATimerMgr));
  FTimerMgr := ATimerMgr;
  FStop := CreateEvent(nil, False, False, nil); // �����˳����¼�
end;

procedure TAATimerThread.Execute;
begin
  repeat                                // �ȴ��˳��¼���λ�� FInterval �����ʱ�˳�
    if WaitForSingleObject(FStop, FInterval) = WAIT_TIMEOUT then
    begin
      TimerMgr.Timer;                   // ��ͬ����ʽ������ʱ�¼�
      Synchronize(TimerMgr.SyncTimer);  // ͬ����ʽ������ʱ�¼�
    end;
  until Terminated;
  CloseHandle(FStop);                   // �ͷ��¼����
end;

//==============================================================================
// �߾��ȶ�ʱ����������˽���ࣩ
//==============================================================================

{ TAATimerMgr }

constructor TAATimerMgr.Create;
begin
  inherited Create;
  FTimerList := TThreadList.Create;
  FTimerThread := TAATimerThread.Create(True, Self);
  FTimerThread.FreeOnTerminate := False;
  FTimerThread.Priority := tpNormal;
  FTimerThread.FInterval := 1;
  FTimerThread.Resume;
end;

destructor TAATimerMgr.Destroy;
begin
  FTimerThread.Terminate;
  SetEvent(FTimerThread.FStop);
  if FTimerThread.Suspended then FTimerThread.Resume;
  FTimerThread.WaitFor;
  ClearTimer;
  FreeAndNil(FTimerThread);
  FreeAndNil(FTimerList);
  inherited Destroy;
end;

function TAATimerMgr.AddTimer: TAATimerObject;
begin
  Result := TAATimerObject.Create;
  with FTimerList.LockList do
  try
    Add(Result);
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.ClearTimer;
var
  i: Integer;
begin
  with FTimerList.LockList do
  try
    for i := Count - 1 downto 0 do
    begin
      TAATimerObject(Items[i]).Free;
      Delete(i);
    end;
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.DeleteTimer(TimerObject: TAATimerObject);
var
  i: Integer;
begin
  with FTimerList.LockList do
  try
    for i := 0 to Count - 1 do
      if Items[i] = TimerObject then
      begin
        TimerObject.Free;
        Delete(i);
        Exit;
      end;
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.DoTimer(Sycn: Boolean);
var
  i: Integer;
  CurrTick: Cardinal;
begin
  with FTimerList.LockList do
  try
    CurrTick := GetTickCount;
    for i := 0 to Count - 1 do
      with TAATimerObject(Items[i]) do
        if Enabled and (Interval <> 0) and (SyncEvent = Sycn) and
          (CurrTick - FLastTickCount >= Interval) and Assigned(FOnTimer) then
        begin
          if CurrTick <> FLastTickCount then
            FActualFPS := 1000 / (CurrTick - FLastTickCount)
          else
            FActualFPS := 0;
          FLastTickCount := CurrTick;
          Timer;
        end;
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.SyncTimer;
begin
  try
    DoTimer(True);
  except
    Application.HandleException(Self);
  end
end;

procedure TAATimerMgr.Timer;
begin
  try
    DoTimer(False);
  except
    Application.HandleException(Self);
  end
end;

var
  TimerMgr: TAATimerMgr;

function GetTimerMgr: TAATimerMgr;
begin
  if TimerMgr = nil then
    TimerMgr := TAATimerMgr.Create;
  Result := TimerMgr;
end;

//==============================================================================
// �߾��ȶ�ʱ������
//==============================================================================

{ TAATimerObject }

constructor TAATimerObject.Create;
begin
  inherited Create;
  FEnabled := True;
  FExecCount := 0;
  FInterval := 1000;
  FLastTickCount := GetTickCount;
  FRepeatCount := 0;
  FSyncEvent := True;
end;

destructor TAATimerObject.Destroy;
begin
end;

function TAATimerObject.GetFPS: Double;
begin
  if Interval = 0 then
    Result := 0
  else
    Result := 1000 / Interval;
end;

procedure TAATimerObject.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FExecCount := 0;
    if FEnabled then
    begin
      FLastTickCount := GetTickCount;
    end;
  end;
end;

procedure TAATimerObject.SetFPS(Value: Double);
begin
  if Value < 0 then
    Exit
  else if Value < 1 / High(Word) then
    Value := 1 / High(Word)
  else if Value > 1000 then
    Value := 1000;
  FInterval := Round(1000 / Value);
end;

procedure TAATimerObject.SetInterval(Value: Cardinal);
begin
  if FInterval <> Value then
  begin
    FInterval := Value;
    FLastTickCount := GetTickCount;
  end;
end;

procedure TAATimerObject.SetRepeatCount(Value: Cardinal);
begin
  if FRepeatCount <> Value then
  begin
    FRepeatCount := Value;
  end;
end;

procedure TAATimerObject.Timer;
begin
  Inc(FExecCount);
  if Assigned(FOnTimer) then FOnTimer(Self);
  if (RepeatCount <> 0) and (FExecCount >= RepeatCount) then
  begin
    Enabled := False;
  end;
end;

//==============================================================================
// �߾��ȶ�ʱ�����
//==============================================================================

{ TAATimer }

constructor TAATimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTimerObject := GetTimerMgr.AddTimer;
end;

destructor TAATimer.Destroy;
begin
  GetTimerMgr.DeleteTimer(FTimerObject);
  inherited Destroy;
end;

function TAATimer.GetActualFPS: Double;
begin
  Result := FTimerObject.ActualFPS;
end;

function TAATimer.GetEnabled: Boolean;
begin
  Result := FTimerObject.Enabled;
end;

function TAATimer.GetExecCount: Cardinal;
begin
  Result := FTimerObject.ExecCount;
end;

function TAATimer.GetFPS: Double;
begin
  Result := FTimerObject.FPS;
end;

function TAATimer.GetInterval: Cardinal;
begin
  Result := FTimerObject.Interval;
end;

function TAATimer.GetOnTimer: TNotifyEvent;
begin
  Result := FTimerObject.OnTimer;
end;

function TAATimer.GetRepeatCount: Cardinal;
begin
  Result := FTimerObject.RepeatCount;
end;

function TAATimer.GetSyncEvent: Boolean;
begin
  Result := FTimerObject.SyncEvent;
end;

procedure TAATimer.SetEnabled(Value: Boolean);
begin
  FTimerObject.Enabled := Value;
end;

procedure TAATimer.SetFPS(Value: Double);
begin
  FTimerObject.FPS := Value;
end;

procedure TAATimer.SetInterval(Value: Cardinal);
begin
  FTimerObject.Interval := Value;
end;

procedure TAATimer.SetOnTimer(Value: TNotifyEvent);
begin
  FTimerObject.OnTimer := Value;
end;

procedure TAATimer.SetRepeatCount(Value: Cardinal);
begin
  FTimerObject.RepeatCount := Value;
end;

procedure TAATimer.SetSyncEvent(Value: Boolean);
begin
  FTimerObject.SyncEvent := Value;
end;

//==============================================================================
// �߾��ȶ�ʱ���б�������
//==============================================================================

{ TAATimerItem }

constructor TAATimerItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTimerObject := GetTimerMgr.AddTimer;
  FTimerObject.OnTimer := Timer;
end;

destructor TAATimerItem.Destroy;
begin
  GetTimerMgr.DeleteTimer(FTimerObject);
  inherited Destroy;
end;

procedure TAATimerItem.Assign(Source: TPersistent);
begin
  if Source is TAATimerItem then
  begin
    Enabled := TAATimerItem(Source).Enabled;
    Interval := TAATimerItem(Source).Interval;
    RepeatCount := TAATimerItem(Source).RepeatCount;
    SyncEvent := TAATimerItem(Source).SyncEvent;
  end
  else
    inherited;
end;

function TAATimerItem.GetActualFPS: Double;
begin
  Result := FTimerObject.ActualFPS;
end;

function TAATimerItem.GetEnabled: Boolean;
begin
  Result := FTimerObject.Enabled;
end;

function TAATimerItem.GetExecCount: Cardinal;
begin
  Result := FTimerObject.ExecCount;
end;

function TAATimerItem.GetFPS: Double;
begin
  Result := FTimerObject.FPS;
end;

function TAATimerItem.GetInterval: Cardinal;
begin
  Result := FTimerObject.Interval;
end;

function TAATimerItem.GetRepeatCount: Cardinal;
begin
  Result := FTimerObject.RepeatCount;
end;

function TAATimerItem.GetSyncEvent: Boolean;
begin
  Result := FTimerObject.SyncEvent;
end;

procedure TAATimerItem.SetEnabled(Value: Boolean);
begin
  FTimerObject.Enabled := Value;
end;

procedure TAATimerItem.SetFPS(Value: Double);
begin
  FTimerObject.FPS := Value;
end;

procedure TAATimerItem.SetInterval(Value: Cardinal);
begin
  FTimerObject.Interval := Value;
end;

procedure TAATimerItem.SetRepeatCount(Value: Cardinal);
begin
  FTimerObject.RepeatCount := Value;
end;

procedure TAATimerItem.SetSyncEvent(Value: Boolean);
begin
  FTimerObject.SyncEvent := Value;
end;

procedure TAATimerItem.Timer(Sender: TObject);
begin
  if not TAATimerList(TAATimerCollection(Collection).GetOwner).Timer(Index) then
    if Assigned(FOnTimer) then
      FOnTimer(Self);
end;

//==============================================================================
// �߾��ȶ�ʱ���б�����
//==============================================================================

{ TAATimerCollection }

constructor TAATimerCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TAATimerItem);
  Assert(AOwner is TAATimerList);
end;

function TAATimerCollection.GetItems(Index: Integer): TAATimerItem;
begin
  Result := TAATimerItem(inherited Items[Index]);
end;

procedure TAATimerCollection.SetItems(Index: Integer; Value: TAATimerItem);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
// �߾��ȶ�ʱ���б����
//==============================================================================

{ TAATimerList }

constructor TAATimerList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TAATimerCollection.Create(Self);
end;

destructor TAATimerList.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TAATimerList.SetItems(Value: TAATimerCollection);
begin
  FItems.Assign(Value);
end;

function TAATimerList.Timer(Index: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnTimer) then
    FOnTimer(Self, Index, Result);
end;

initialization

finalization
  if TimerMgr <> nil then
    TimerMgr.Free;

end.


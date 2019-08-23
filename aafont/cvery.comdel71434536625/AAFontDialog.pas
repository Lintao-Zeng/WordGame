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

unit AAFontDialog;
{* |<PRE>
================================================================================
* ������ƣ�ƽ����Ч����ؼ���
* ��Ԫ���ƣ�ƽ����Ч����Ի���ؼ� TAAFontDialog ��Ԫ
* ��Ԫ���ߣ�CnPack ������ �ܾ���
* ������ַ��http://www.yygw.net
* Eamil   ��yygw@yygw.net
* ����ƽ̨��PWin2000Pro + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 + C++Build 5/6
* ������ע��
* �����£�2003.03.22
================================================================================
|</PRE>}

interface

{$I AAFont.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AAFont, AACtrls, ExtCtrls, StdCtrls, ExtDlgs,
  {$IFDEF DELPHI} Spin {$ELSE} AASpin {$ENDIF};

type

{ TAAFontDlg }

  TAAFontDlg = class(TForm)
    Panel1: TPanel;
    gbShadow: TGroupBox;
    cbShadow: TCheckBox;
    Label1: TLabel;
    seShadowBlur: TSpinEdit;
    Label2: TLabel;
    seShadowAlpha: TSpinEdit;
    Label3: TLabel;
    seOffsetX: TSpinEdit;
    Label4: TLabel;
    seOffsetY: TSpinEdit;
    spShadow: TShape;
    Label5: TLabel;
    gbGradual: TGroupBox;
    spStartColor: TShape;
    Label10: TLabel;
    cbGradual: TCheckBox;
    spEndColor: TShape;
    Label6: TLabel;
    rbLeftToRight: TRadioButton;
    rbRightToLeft: TRadioButton;
    rbTopToBottom: TRadioButton;
    rbCenterToLR: TRadioButton;
    gbTexture: TGroupBox;
    cbTexture: TCheckBox;
    rbTile: TRadioButton;
    rbStretched: TRadioButton;
    rbCenter: TRadioButton;
    rbNormal: TRadioButton;
    btnOpenPic: TButton;
    gbOther: TGroupBox;
    cbOutline: TCheckBox;
    Label7: TLabel;
    seBlur: TSpinEdit;
    Label8: TLabel;
    seAlpha: TSpinEdit;
    Label9: TLabel;
    seNoise: TSpinEdit;
    btnFont: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    OpenPictureDialog: TOpenPictureDialog;
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    btnClearPic: TButton;
    Label11: TLabel;
    seSpray: TSpinEdit;
    rbBottomToTop: TRadioButton;
    rbCenterToTB: TRadioButton;
    Label12: TLabel;
    seAngle: TSpinEdit;
    cbHorzMirror: TCheckBox;
    cbVertMirror: TCheckBox;
    procedure btnFontClick(Sender: TObject);
    procedure cbShadowClick(Sender: TObject);
    procedure seShadowBlurClick(Sender: TObject);
    procedure spShadowMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOpenPicClick(Sender: TObject);
    procedure btnClearPicClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FUpdating: Boolean;
    AALabel: TAALabel;
    procedure SetEffect(const Value: TAAEffect);
    function GetTestFont: TFont;
    procedure SetTestFont(const Value: TFont);
    function GetEffect: TAAEffect;
    procedure SetEffectToControls;
    procedure GetEffectFromControls;
    procedure UpdateEffect;
  public
    { Public declarations }
    property Effect: TAAEffect read GetEffect write SetEffect;
    property TestFont: TFont read GetTestFont write SetTestFont;
  end;

{ TAAFontDialog }

  TAAFontDialog = class(TComponent)
  {* ƽ����Ч����Ի��������ʹ�÷���ͬ��ͨ�Ի���}
  private
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FEffect: TAAEffect;
    FFont: TFont;
    FAllowChangeFont: Boolean;
    procedure SetEffect(const Value: TAAEffect);
    procedure SetTestFont(const Value: TFont);
  protected
    procedure DoShow; virtual;
    procedure DoClose; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    procedure Assign(Source: TPersistent); override;
    {* ����ֵ����}
    function Execute: Boolean;
    {* �򿪶Ի��򣬷���ִ�н��}
  published
    property Effect: TAAEffect read FEffect write SetEffect;
    {* ƽ����Ч��������}
    property Font: TFont read FFont write SetTestFont;
    {* ��������}
    property AllowChangeFont: Boolean read FAllowChangeFont
      write FAllowChangeFont default False;
    {* �Ƿ�����������壬���ΪTrue���������û�����Font���ԡ����ΪFalse����
       ��ʾ�����塱��ť��}
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    {* �Ի���ر��¼�}
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    {* �Ի�����ʾ�¼�}
  end;

procedure Register;

implementation

{$R *.DFM}

procedure Register;
begin
  RegisterComponents('AAFont', [TAAFontDialog]);
end;

{ TAAFontDlg }

procedure TAAFontDlg.FormCreate(Sender: TObject);
begin
  FUpdating := False;
  Panel1.DoubleBuffered := True;
  AALabel := TAALabel.Create(Self);
  with AALabel do
  begin
    Parent := Panel1;
    AutoSize := False;
    Align := alClient;
    Font.Charset := GB2312_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -19;
    Font.Name := '����_GB2312';
    Font.Style := [];
    Effect.Layout := tlCenter;
    Effect.Alignment := taCenter;
    Effect.BackColor := clWhite;
    Caption := 'ƽ����Ч���� AAFont';
  end;
end;

function TAAFontDlg.GetEffect: TAAEffect;
begin
  Result := AALabel.Effect.FontEffect;
end;

function TAAFontDlg.GetTestFont: TFont;
begin
  Result := AALabel.Font;
end;

procedure TAAFontDlg.SetEffect(const Value: TAAEffect);
begin
  AALabel.Effect.FontEffect := Value;
  SetEffectToControls;
end;

procedure TAAFontDlg.SetTestFont(const Value: TFont);
begin
  AALabel.Font := Value;
end;

procedure TAAFontDlg.GetEffectFromControls;
begin
  with AALabel.Effect.FontEffect do
  begin
    Shadow.Enabled := cbShadow.Checked;
    Shadow.Blur := seShadowBlur.Value;
    Shadow.Color := spShadow.Brush.Color;
    Shadow.Alpha := seShadowAlpha.Value;
    Shadow.OffsetX := seOffsetX.Value;
    Shadow.OffsetY := seOffsetY.Value;
    Gradual.Enabled := cbGradual.Checked;
    Gradual.StartColor := spStartColor.Brush.Color;
    Gradual.EndColor := spEndColor.Brush.Color;
    if rbLeftToRight.Checked then
      Gradual.Style := gsLeftToRight
    else if rbRightToLeft.Checked then
      Gradual.Style := gsRightToLeft
    else if rbTopToBottom.Checked then
      Gradual.Style := gsTopToBottom
    else if rbBottomToTop.Checked then
      Gradual.Style := gsBottomToTop
    else if rbCenterToLR.Checked then
      Gradual.Style := gsCenterToLR
    else
      Gradual.Style := gsCenterToTB;
    Texture.Enabled := cbTexture.Checked;
    if rbTile.Checked then
      Texture.Mode := tmTiled
    else if rbStretched.Checked then
      Texture.Mode := tmStretched
    else if rbCenter.Checked then
      Texture.Mode := tmCenter
    else
      Texture.Mode := tmNormal;
    Blur := seBlur.Value;
    Alpha := seAlpha.Value;
    Angle := seAngle.Value;
    Noise := seNoise.Value;
    Spray := seSpray.Value;
    Outline := cbOutline.Checked;
    HorzMirror := cbHorzMirror.Checked;
    VertMirror := cbVertMirror.Checked;
  end;
end;

procedure TAAFontDlg.SetEffectToControls;
begin
  FUpdating := True;
  try
    with AALabel.Effect.FontEffect do
    begin
      cbShadow.Checked := Shadow.Enabled;
      seShadowBlur.Value := Shadow.Blur;
      spShadow.Brush.Color := Shadow.Color;
      seShadowAlpha.Value := Shadow.Alpha;
      seOffsetX.Value := Shadow.OffsetX;
      seOffsetY.Value := Shadow.OffsetY;
      cbGradual.Checked := Gradual.Enabled;
      spStartColor.Brush.Color := Gradual.StartColor;
      spEndColor.Brush.Color := Gradual.EndColor;
      rbLeftToRight.Checked := Gradual.Style = gsLeftToRight;
      rbRightToLeft.Checked := Gradual.Style = gsRightToLeft;
      rbTopToBottom.Checked := Gradual.Style = gsTopToBottom;
      rbBottomToTop.Checked := Gradual.Style = gsBottomToTop;
      rbCenterToLR.Checked := Gradual.Style = gsCenterToLR;
      rbCenterToTB.Checked := Gradual.Style = gsCenterToTB;
      cbTexture.Checked := Texture.Enabled;
      rbTile.Checked := Texture.Mode = tmTiled;
      rbStretched.Checked := Texture.Mode = tmStretched;
      rbCenter.Checked := Texture.Mode = tmCenter;
      rbNormal.Checked := Texture.Mode = tmNormal;
      seBlur.Value := Blur;
      seAlpha.Value := Alpha;
      seAngle.Value := Angle;
      seNoise.Value := Noise;
      seSpray.Value := Spray;
      cbOutline.Checked := Outline;
      cbHorzMirror.Checked := HorzMirror;
      cbVertMirror.Checked := VertMirror;
      cbShadowClick(cbShadow);
      cbShadowClick(cbGradual);
      cbShadowClick(cbTexture);
    end;
  finally
    FUpdating := False;
  end;
end;

procedure TAAFontDlg.btnFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(TestFont);
  if FontDialog.Execute then
    TestFont := FontDialog.Font;
end;

procedure TAAFontDlg.cbShadowClick(Sender: TObject);
var
  GroupBox: TGroupBox;
  i: Integer;
begin
  if (Sender is TCheckBox) and (TCheckBox(Sender).Parent is TGroupBox) then
  begin
    GroupBox := TGroupBox(TCheckBox(Sender).Parent);
    for i := 0 to GroupBox.ControlCount - 1 do
      if GroupBox.Controls[i] <> Sender then
        GroupBox.Controls[i].Enabled := TCheckBox(Sender).Checked;
  end;
  UpdateEffect;
end;

procedure TAAFontDlg.UpdateEffect;
begin
  if FUpdating then Exit;
  FUpdating := True;
  AALabel.BeginUpdate;
  try
    GetEffectFromControls;
  finally
    AALabel.EndUpdate;
    AALabel.Changed;
    FUpdating := False;
  end;
end;

procedure TAAFontDlg.seShadowBlurClick(Sender: TObject);
begin
  UpdateEffect;
end;

procedure TAAFontDlg.spShadowMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender is TShape) and (Button = mbLeft) then
  begin
    ColorDialog.Color := TShape(Sender).Brush.Color;
    if ColorDialog.Execute then
    begin
      TShape(Sender).Brush.Color := ColorDialog.Color;
      UpdateEffect;
    end;
  end;
end;

procedure TAAFontDlg.btnOpenPicClick(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
  begin
    AALabel.Effect.FontEffect.Texture.Picture.LoadFromFile(OpenPictureDialog.FileName);
    UpdateEffect;
  end;
end;

procedure TAAFontDlg.btnClearPicClick(Sender: TObject);
begin
  AALabel.Effect.FontEffect.Texture.Picture := nil;
  UpdateEffect;
end;

{ TAAFontDialog }

procedure TAAFontDialog.Assign(Source: TPersistent);
begin
  if Source is TAAFontDialog then
  begin
    FFont.Assign(TAAFontDialog(Source).FFont);
    FEffect.Assign(TAAFontDialog(Source).FEffect);
  end
  else
    inherited;
end;

constructor TAAFontDialog.Create(AOwner: TComponent);
begin
  inherited;
  FAllowChangeFont := False;
  FFont := TFont.Create;
  FEffect := TAAEffect.Create(nil);
end;

destructor TAAFontDialog.Destroy;
begin
  FEffect.Free;
  FFont.Free;
  inherited;
end;

procedure TAAFontDialog.DoClose;
begin
  if Assigned(FOnClose) then
    FOnClose(Self);
end;

procedure TAAFontDialog.DoShow;
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

function TAAFontDialog.Execute: Boolean;
begin
  with TAAFontDlg.Create(Self) do
  try
    Effect := Self.FEffect;
    btnFont.Visible := AllowChangeFont;
    if AllowChangeFont then
      TestFont := Self.FFont;
    Self.DoShow;
    Result := ShowModal = mrOk;
    if Result then
    begin
      Self.FEffect.Assign(Effect);
      if AllowChangeFont then
        Self.FFont.Assign(TestFont);
    end;
    Self.DoClose;
  finally
    Free;
  end;
end;

procedure TAAFontDialog.SetEffect(const Value: TAAEffect);
begin
  FEffect.Assign(Value);
end;

procedure TAAFontDialog.SetTestFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

end.




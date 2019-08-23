//-------------------------------------------------------------------------
//�� �� ����ƽ����Ч����ؼ���
//��Ԫ���ƣ���ʾ���������嵥Ԫ  ��������������
//��Ԫ���ߣ�CnPack ������ �ܾ���
//������ַ��http://www.yygw.net
//Eamil   ��yygw@yygw.net
//�������ͣ���ѵ�Ԫ������������������������������������
//������ע���õ�Ԫ��ʾ�˿ؼ�����һЩ����
//�����£�2002.06.26
//-------------------------------------------------------------------------
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AAFont, AACtrls, ComCtrls, MPlayer, StdCtrls, Buttons, ExtCtrls,
  AAFontDialog;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    bbtnRandomUpdate: TBitBtn;
    AAScrollText: TAAScrollText;
    AALabel1: TAALabel;
    AALabel2: TAALabel;
    AALabel3: TAALabel;
    AALabel4: TAALabel;
    AALabel5: TAALabel;
    AALabel6: TAALabel;
    AALabel8: TAALabel;
    AALabel9: TAALabel;
    AALabel7: TAALabel;
    tbSpeed: TTrackBar;
    AALinkLabel1: TAALinkLabel;
    AALinkLabel2: TAALinkLabel;
    AAFontDialog: TAAFontDialog;
    AALabel10: TAALabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    AALinkLabel3: TAALinkLabel;
    AALinkLabel4: TAALinkLabel;
    AALinkLabel5: TAALinkLabel;
    AAText1: TAAText;
    AALinkLabel6: TAALinkLabel;
    AALinkLabel7: TAALinkLabel;
    AAFadeText1: TAAFadeText;
    Edit: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    AALabel11: TAALabel;
    AALabel12: TAALabel;
    AALabel13: TAALabel;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AAScrollTextLabels8GetText(Sender: TUserLabel;
      var Text: String);
    procedure bbtnRandomUpdateClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure tbSpeedChange(Sender: TObject);
    procedure AALabel1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MidName: string;
    MediaPlayer: TMediaPlayer;
    Ver: Integer;
    procedure OnNotify(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

const
  csResName = 'YYGW';
  csResNum = 3;
  csDesMidFile = 'yygw.mid';
  csTitleYygw = 'TitleYygw';
  csTextYygw = 'TextYygw';
  csTextVer = 'TextVer';
  csText2 = 'Text2';

{$R *.DFM}
{$R Mid.RES}

// ������ʾǰ
procedure TForm1.FormShow(Sender: TObject);
var
  TempPath: array[0..MAX_PATH] of Char;
begin
  MediaPlayer := TMediaPlayer.Create(Self); // ����ý�岥�������ڲ���MIDI
  MediaPlayer.Parent := Self;
  MediaPlayer.Visible := False;
  MediaPlayer.OnNotify := OnNotify;
  GetTempPath(MAX_PATH, TempPath);
  MidName := TempPath + csDesMidFile;
  AAScrollText.Active := True;
end;

// �����ͷ�
procedure TForm1.FormDestroy(Sender: TObject);
begin
  MediaPlayer.Close;
  DeleteFile(MidName);
end;

// ˫����ǩ��������Ч��
procedure TForm1.AALabel1DblClick(Sender: TObject);
begin
  if Sender is TAALabel then
  begin
    AAFontDialog.Effect := TAALabel(Sender).Effect.FontEffect;
    AAFontDialog.Font := TAALabel(Sender).Font; // ����ֱ���ø�ֵ����ֵ
    if AAFontDialog.Execute then
    begin
      TAALabel(Sender).Effect.FontEffect := AAFontDialog.Effect;
      TAALabel(Sender).Font := AAFontDialog.Font;
    end;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  AALinkLabel1.Click; // ʹ��TAALinkLabel.Click�����൱���û�����ؼ�
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  AALinkLabel2.Click;
end;

// ������֪ͨ
procedure TForm1.OnNotify(Sender: TObject);
begin
  if MediaPlayer.Mode = mpStopped then
    MediaPlayer.Play; // ѭ������
  MediaPlayer.Notify := True;
end;

// �л�ҳ����Ʊ���MIDI
procedure TForm1.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheet4 then
    bbtnRandomUpdateClick(nil)
  else
    MediaPlayer.Close;
end;

// ���ڹ����ٶ�
procedure TForm1.tbSpeedChange(Sender: TObject);
begin                      // ���Ϊ0��ֹͣ�������ʼ�1
  AAScrollText.ScrollDelay := 10 * tbSpeed.Position + 1;
end;

// ȡ��ǩ���ݣ���ʾ�û���ǩ��ʹ�ã�
procedure TForm1.AAScrollTextLabels8GetText(Sender: TUserLabel;
  var Text: String);
const
  Vers: array[0..2] of string = ('�����', '�����', '�����');
begin
  Text := Vers[Ver];  // ����ʱ�ɸ��Ĺ����ı����ݣ��������ڿؼ�Resetʱ��ȡ
end;

// ����������ʵġ����¹��衷������MIDIԭ����������
procedure TForm1.bbtnRandomUpdateClick(Sender: TObject);
const
  csFontMax = 9;
  csFonts: array[0..csFontMax - 1] of string = ('��', '��', 'κ', '��', '��', 'Բ',
    '��', '��', '��');
var
  i, j: Integer;
  Fonts: TStrings;
  FontName: string;
  ResStream: TResourceStream;
  ResName: string;
  function RandomColor: TColor;   //���ɫ
  begin
    Result := HSLToRGB(Random, 0.75 + Random * 0.25, 0.3 + Random * 0.25);
  end;
begin
  MediaPlayer.Close;
  try
    Ver := Random(csResNum);
    ResName := csResName + IntToStr(Ver);
    ResStream := TResourceStream.Create(hInstance, PChar(ResName), RT_RCDATA);
    try
      ResStream.SaveToFile(MidName);
      MediaPlayer.FileName := MidName;
      MediaPlayer.Open;
      MediaPlayer.Play;
      MediaPlayer.Notify := True;
    finally
      ResStream.Free;
    end;
  except
    ;
  end;
  Fonts := TStringList.Create;
  try
    AAScrollText.BeginUpdate;  // ��ʼ���£���ֹ�Զ��ػ�
    try
      for i := 0 to Screen.Fonts.Count - 1 do  // �������������������б�
      begin
        FontName := Screen.Fonts[i];
        if Pos('@', FontName) <= 0 then  // ���ǵ�������
        begin
          for j := 0 to csFontMax - 1 do
            if Pos(csFonts[j], FontName) > 0 then
            begin
              Fonts.Add(FontName);
              Break;
            end;
        end;
      end;
      with AAScrollText.Fonts do   // �����������
      begin
        if Fonts.Count > 0 then
        begin    // ʹ��IndexOf��ȡ�������ǩ��
          Items[IndexOf(csTitleYygw)].Font.Name := Fonts[Random(Fonts.Count)];
          Items[IndexOf(csTextYygw)].Font.Name := Fonts[Random(Fonts.Count)];
          Items[IndexOf(csTextVer)].Font.Name := Fonts[Random(Fonts.Count)];
          Items[IndexOf(csText2)].Font.Name := Fonts[Random(Fonts.Count)];
        end;    // ���������ɫ��Ч��
        Items[IndexOf(csTitleYygw)].Effect.Gradual.StartColor := RandomColor;
        Items[IndexOf(csTitleYygw)].Effect.Gradual.EndColor := RandomColor;
        Items[IndexOf(csTextYygw)].Effect.Gradual.StartColor := RandomColor;
        Items[IndexOf(csTextYygw)].Effect.Gradual.EndColor := RandomColor;
        Items[IndexOf(csTitleYygw)].Effect.Outline := Odd(Random(100));
        Items[IndexOf(csTextVer)].Font.Color := RandomColor;
        Items[IndexOf(csText2)].Font.Color := RandomColor;
        Items[IndexOf(csTitleYygw)].Effect.Gradual.Style :=
          TGradualStyle(Random(Ord(High(TGradualStyle)) + 1));
        Items[IndexOf(csTextYygw)].Effect.Gradual.Style :=
          TGradualStyle(Random(Ord(High(TGradualStyle)) + 1));
      end;
    finally
      AAScrollText.EndUpdate;  // ��������
      AAScrollText.Reset;  // ���»����ı�
    end;
  finally
    Fonts.Free;
  end;
end;

// ������ָ����
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  AAFadeText1.FadeToStr(Edit.Text);
end;

end.

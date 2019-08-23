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

unit AACtrls;
{* |<PRE>
================================================================================
* ������ƣ�ƽ����Ч����ؼ���
* ��Ԫ���ƣ�ƽ����Ч����ؼ���Ԫ
* ��Ԫ���ߣ�CnPack ������ �ܾ���
* ������ַ��http://www.yygw.net
* Eamil   ��yygw@yygw.net
* ����ƽ̨��PWin2000Pro + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 + C++Build 5/6
* ������ע���õ�Ԫʵ�������¼����ؼ���
*           ƽ����Ч�����ǩ TAALabel
*           ƽ����Ч�����ӱ�ǩ TAALinkLabel
*           ƽ����Ч�ı��ؼ� TAAText
*           ƽ�������ı��ؼ� TAAScrollText
*           ƽ����Ч�����ı��ؼ� TAAFadeText
* �����£�2004.07.12
================================================================================
|</PRE>}

interface

{$I AAFont.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AAFont, AATimer, ExtCtrls, StdCtrls, ShellAPI;

const
  //�汾��
  verAAFont = 'V2.60';

type

{ TAAFontEffect }

  TAAFontEffect = class(TCustomParam)
  {* ƽ����Ч�����ǩ�ؼ�������}
  published
    property Transparent;
    {* �ؼ��Ƿ�͸��}
    property Layout;
    {* �ı���ֱ������뷽ʽ}
    property Alignment;
    {* �ı�ˮƽ���뷽ʽ}
    property Quality;
    {* ƽ��������ʾ����}
    property FontEffect;
    {* ƽ����Ч��������}
    property BackColor;
    {* �ؼ�������ɫ}
    property BackGround;
    {* �ؼ�����ͼ��}
    property BackGroundMode;
    {* �ؼ�����ͼ����ʾģʽ}
  end;

{ TAALabel }

  TAALabel = class(TAAGraphicControl)
  {* ƽ����Ч�����ǩ�ؼ���������ʾ�����ı����ڿؼ���Effect�����ж�����������
     ��Ч��ʾ��ص����á�
   |<BR> ע���ÿؼ���֧�ֶ����ı��������Ҫ��ʾ�����ı�����TAAText�����档
   |<BR> ������ڣ���ͨ��˫���ؼ�����������������Ч����}
  private
    { Private declarations }
    FEffect: TAAFontEffect;
    MemBmp: TBitmap;
    procedure SetEffect(const Value: TAAFontEffect);
  protected
    { Protected declarations }
    procedure PaintCanvas; override;
    procedure Reset; override;
    procedure TransparentPaint;
    procedure DrawMem;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
  published
    { Published declarations }
    property AutoSize;
    {* �Ƿ��Զ����ÿؼ��ߴ�}
    property Border;
    {* �ؼ��߽籣�����}
    property Caption;
    {* �ؼ�����}
    property Font;
    {* ����}
    property Width default 46;
    {* �ؼ����}
    property Height default 12;
    {* �ؼ��߶�}
    property Effect: TAAFontEffect read FEffect write SetEffect;
    {* ƽ����Ч��������}
  end;

{ THotLink }

  THotLink = class(TCustomParam)
  {* ƽ����Ч���峬���ӱ�ǩ�ؼ������Ӳ�����}
  private
    FFade: Boolean;
    FUnderLine: Boolean;
    FFadeDelay: Cardinal;
    FURL: string;
    FFontEffect: TAAEffect;
    FColor: TColor;
    FBackColor: TColor;
    procedure SetFontEffect(const Value: TAAEffect);
  public
    constructor Create; reintroduce;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    procedure Assign(Source: TPersistent); override;
    {* ����ֵ����}
  published
    property Fade: Boolean read FFade write FFade default True;
    {* �Ƿ������뵭����ʾ}
    property FadeDelay: Cardinal read FFadeDelay write FFadeDelay
      default 600;
    {* ���뵭����ʾ��ʱ}
    property Color: TColor read FColor write FColor default clBlue;
    {* ����ʱ�ĸ���ʱ��������ɫ}
    property BackColor: TColor read FBackColor write FBackColor default clBtnface;
    {* ����ʱ�ı�����ɫ}
    property FontEffect: TAAEffect read FFontEffect write SetFontEffect;
    {* ����ʱ��������Ч����}
    property URL: string read FURL write FURL;
    {* ���������ݻ��ļ��������磺
     |<PRE>
       http://www.yygw.net      - ��ҳ
       mailto:yygw@yygw.net      - �ʼ���ַ
       mailto:yygw@yygw.net?subject=��� - ���ʼ�������ʼ���ַ����
       c:\tools\anyexe.exe      - ��ִ���ļ�
       d:\aafont\readme.txt     - �ı��ļ��������ļ�
       ������Ч�ĳ����ӵ�ַ���ļ������൱�ڡ���ʼ���˵��еġ����С�����
     |</PRE>}
    property UnderLine: Boolean read FUnderLine write FUnderLine
      default False;
    {* ����ʱ�Ƿ���ʾ�»���}
    property Transparent;
    {* ����ʱ��͸������}
    property BackGround;
    {* ����ʱ�ı���ͼ��}
    property BackGroundMode;
    {* ����ʱ�ı���ͼ����ʾģʽ}
  end;

{ TAALinkLabel }

  TFadeStyle = (fsNone, fsIn, fsOut);

  TAALinkLabel = class(TAALabel)
  {* ƽ����Ч�����ӱ�ǩ�ؼ���������ʾ�����ӣ�֧���л�ʱ�ĵ��뵭��Ч��}
  private
    { Private declarations }
    HotBmp: TBitmap;
    BlendBmp: TBitmap;
    FadeTimer: TTimer;
    FFadeStyle: TFadeStyle;
    FProgress: TProgress;
    FHotLink: THotLink;
    FMouseIn: Boolean;
    NewProg: Double;

    procedure OnFadeTimer(Sender: TObject);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetProgress(const Value: TProgress);
    procedure SetFadeStyle(const Value: TFadeStyle);
    procedure SetHotLink(const Value: THotLink);
  protected
    { Protected declarations }
    property Progress: TProgress read FProgress write SetProgress;
    property FadeStyle: TFadeStyle read FFadeStyle write SetFadeStyle;
    procedure DrawHot;
    procedure PaintCanvas; override;
    procedure SetEnabled(Value: Boolean); override;
    procedure LoadedEx; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    procedure Click; override;
    {* ģ���û�����ÿؼ�������HotLink��URL����}
  published
    { Published declarations }
    property HotLink: THotLink read FHotLink write SetHotLink;
    {* ����������}
  end;

{ TTextParam }

  TTextParam = class(TCustomTextParam)
  {* ƽ����Ч�ı��ؼ�������}
  protected
    function IsLinesStored: Boolean; override;
  public
    constructor Create(AOwner: TAAGraphicControl; ChangedProc:
      TNotifyEvent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
  published
    property WordWrap;
    {* �Ƿ������Զ�����}
    property RowPitch;
    {* �ı��м�࣬��λΪ����߶ȵİٷֱ�}
    property Lines;
    {* �ı��������ԣ�����ʹ�������ǩ���û���ǩ������ÿһ���ı��Ķ��뷽ʽ��������Ч��
       ʹ�ñ�ǩʱ��һ�Լ�����'<'��'>'����ǩ�������������Ʊ�ǩ�����÷�Χ��LabelEffect
       ����������ı��ؼ���Fonts��Labels���ԡ�}
    property Transparent;
    {* �Ƿ�����ؼ�͸��}
    property Alignment;
    {* Ĭ�ϵ��ı����뷽ʽ������ı����ж����ǩ�����ɶ����ǩ������
     |<BR> ���LabelEffect��Lines��Labels����}
    property Quality;
    {* ƽ������ʾ����}
    property FontEffect;
    {* Ĭ�ϵ�������Ч����������ı����������ǩ�����������ǩ������
     |<BR> ���LabelEffect��Lines��Fonts��Font����}
    property LabelEffect;
    {* ���塢�����ǩ���÷�Χ}
    property BackColor;
    {* �ؼ�������ɫ}
    property BackGround;
    {* �ؼ�����ͼ��}
    property BackGroundMode;
    {* �ؼ�������ʾģʽ}
  end;

{ TAAText }

  TAAText = class(TAACustomText)
  {* ƽ����Ч�ı��ؼ���������ʾ�����ı���ͨ��ʹ�ñ�ǩ������ÿ���ı�ʹ�ò�ͬ��
     ���뷽ʽ��������Ч��}
  private
    { Private declarations }
    FText: TTextParam;
    procedure SetText(const Value: TTextParam);
  protected
    { Protected declarations }
    TextBmp: TBitmap;
    procedure PaintCanvas; override;
    procedure LoadedEx; override;
    function UseDefaultLabels: Boolean; override;
    procedure CalcSize;
    procedure DrawCanvas(ACanvas: TCanvas);
    procedure CreateText;
    procedure TransparentPaint;
    procedure Reset; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
  published
    { Published declarations }
    property AutoSize;
    {* �Ƿ��Զ����ÿؼ��ߴ�}
    property Border;
    {* �ؼ��߽籣�����}
    property Font;
    {* �ؼ�����}
    property Width default 46;
    {* �ؼ����}
    property Height default 12;
    {* �ؼ��߶�}
    property Text: TTextParam read FText write SetText;
    {* �ؼ��ı����ݼ���ʾ����}
  end;

  TAAScrollText = class;

{ TScrollTextParam }

  TScrollTextParam = class(TCustomTextParam)
  {* ƽ�������ı��ؼ�������}
  private
    FFade: Boolean;
    FFadeHeight: Integer;
    FTailSpace: Integer;
    FHeadSpace: Integer;

    procedure SetFade(const Value: Boolean);
    procedure SetFadeHeight(const Value: Integer);
    procedure SetTailSpace(const Value: Integer);
    procedure SetHeadSpace(const Value: Integer);
  protected
    function IsLinesStored: Boolean; override;
  public
    constructor Create(AOwner: TAAGraphicControl; ChangedProc:
    {* �๹����}
      TNotifyEvent); override;
    destructor Destroy; override;
    {* ��������}
  published
    property Fade: Boolean read FFade write SetFade default True;
    {* �Ƿ�����ؼ����±߽絭�뵭��}
    property FadeHeight: Integer read FFadeHeight write SetFadeHeight default 10;
    {* ���뵭���߽�ĸ߶�}
    property HeadSpace: Integer read FHeadSpace write SetHeadSpace default 0;
    {* ��������ͷ���հ׸߶ȣ���λΪ�ؼ��߶ȵİٷֱ�}
    property TailSpace: Integer read FTailSpace write SetTailSpace default 60;
    {* ��������β���հ׸߶ȣ���λΪ�ؼ��߶ȵİٷֱ�}
    property Alignment default taCenter;
    {* Ĭ�ϵ��ı����뷽ʽ������ı����ж����ǩ�����ɶ����ǩ������
     |<BR> ���LabelEffect��Lines��Labels����}
    property RowPitch;
    {* �ı��м�࣬��λΪ����߶ȵİٷֱ�}
    property WordWrap;
    {* �Ƿ������Զ�����}
    property Lines;
    {* �ı��������ԣ�����ʹ�������ǩ���û���ǩ������ÿһ���ı��Ķ��뷽ʽ��������Ч��
       ʹ�ñ�ǩʱ��һ�Լ�����'<'��'>'����ǩ�������������Ʊ�ǩ�����÷�Χ��LabelEffect
       ����������ı��ؼ���Fonts��Labels���ԡ�}
    property Quality;
    {* ƽ������ʾ����}
    property FontEffect;
    {* Ĭ�ϵ�������Ч����������ı����������ǩ�����������ǩ������
     |<BR> ���LabelEffect��Lines��Fonts��Font����}
    property LabelEffect;
    {* ���塢�����ǩ���÷�Χ}
    property Font;
    {* Ĭ�ϵ��������������ı����������ǩ�����������ǩ������
     |<BR> ���LabelEffect��Lines��Fonts����}
    property BackColor default clWhite;
    {* �ؼ�������ɫ}
    property BackGround;
    {* �ؼ�����ͼ��}
    property BackGroundMode default bmTiled;
    {* �ؼ�������ʾģʽ}
  end;

{ TAAScrollText }

  TAAScrollText = class(TAACustomText)
  {* ƽ�������ı��ؼ������ڶ����ı��Ķ�̬������ʾ}
  private
    { Private declarations }
    FScrollDelay: Word;
    FScrollStep: Integer;
    FRepeatDelay: Word;
    FRepeatCount: TBorderWidth;
    FRepeatedCount: Integer;
    FText: TScrollTextParam;
    FCurrPos: Integer;
    TextBmp: TBitmap;
    CurrBmp: TBitmap;
    DelayTimer: TTimer;
    ScrollTimer: TAATimer;
    FActive: Boolean;

    procedure CreateText;
    procedure OnDelayTimer(Sender: TObject);
    procedure OnScrollTimer(Sender: TObject);
    procedure SetActive(const Value: Boolean);
    procedure SetScrollDelay(const Value: Word);
    procedure SetScrollStep(const Value: Integer);
    procedure SetRepeatDelay(const Value: Word);
    procedure SetRepeatCount(const Value: TBorderWidth);
    procedure SetText(const Value: TScrollTextParam);
    procedure SetCurrPos(const Value: Integer);
    function GetBmpHeight: Integer;
  protected
    { Protected declarations }
    procedure CreateDefFonts; override;
    procedure PaintCanvas; override;
    function UseDefaultLabels: Boolean; override;
    procedure LoadedEx; override;
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    procedure Reset; override;
    {* ���´����������ݣ�����AutoUpdateΪ��ʱ���������ڶ�̬�޸Ŀؼ��������ʼ���ؼ�������}
    procedure ReStart;
    {* ���¿�ʼ��������������������ı���ͷ��ʼ����}
    property RepeatedCount: Integer read FRepeatedCount;
    {* ��ѭ������������������ֻ������}
    property CurrPos: Integer read FCurrPos write SetCurrPos;
    {* ��ǰ��ʾ������������ͼ���е�λ�ã��û����������ֶ����ƿؼ�����}
    property BmpHeight: Integer read GetBmpHeight;
    {* ����ͼ��ĸ߶�}
  published
    { Published declarations }
    property AutoUpdate;
    {* �Ƿ�����ؼ��������ʱ�Զ����´����������ݡ�����кܶ������Ҫ������ʱ���ã�
       �ɽ���������ΪFalse�����趨����������Reset������}
    property Active: Boolean read FActive write SetActive default True;
    {* �Ƿ������ı�����}
    property Height default 280;
    {* �ؼ��߶�}
    property Width default 240;
    {* �ؼ����}
    property ScrollDelay: Word read FScrollDelay write SetScrollDelay default 60;
    {* ����ʱ����ʱ����λΪ����}
    property ScrollStep: Integer read FScrollStep write SetScrollStep default 1;
    {* һ�ι�����������������趨Ϊ���������¹���}
    property RepeatCount: TBorderWidth read FRepeatCount write SetRepeatCount default 0;
    {* ����ѭ��������ָ��������ѭ���������Զ�ֹͣ������������OnComplete�¼���
     |<BR> ��ֵ��Ϊ0������ѭ����}
    property RepeatDelay: Word read FRepeatDelay write SetRepeatDelay default 2000;
    {* ���һ�ι���ѭ�������ʱ���������Ҫ��ʱ������Ϊ0}
    property Text: TScrollTextParam read FText write SetText;
    {* �����ı����ݺͲ�������}
    property OnComplete;
    {* ָ�������Ĺ���ѭ�������¼�����RepeatCount}
    property OnTextReady;
    {* ���������ѳ�ʼ���¼�}
    property OnPainted;
    {* �ؼ��ػ��¼�}
  end;

{ TFadeTextParam }

  TFadeTextParam = class(TCustomTextParam)
  {* ƽ����Ч�����ı��ؼ�������}
  private
    FFadeDelay: Cardinal;
    procedure SetFadeDelay(const Value: Cardinal);
    procedure SetLineDelay(const Value: Cardinal);
    function GetLineDelay: Cardinal;
  protected
    function IsLinesStored: Boolean; override;
  public
    constructor Create(AOwner: TAAGraphicControl; ChangedProc:
      TNotifyEvent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    procedure Assign(Source: TPersistent); override;
    {* ����ֵ����}
  published
    property FadeDelay: Cardinal read FFadeDelay write SetFadeDelay default 600;
    {* �ı����뵭���л���ʱ}
    property LineDelay: Cardinal read GetLineDelay write SetLineDelay default 3000;
    {* ÿ���ı���ʾ��ʱ}
    property Lines;
    {* �ı��������ԣ�����ʹ�������ǩ���û���ǩ������ÿһ���ı��Ķ��뷽ʽ��������Ч��
       ʹ�ñ�ǩʱ��һ�Լ�����'<'��'>'����ǩ�������������Ʊ�ǩ�����÷�Χ��LabelEffect
       ����������ı��ؼ���Fonts��Labels���ԡ�}
    property Transparent;
    {* �Ƿ�����ؼ�͸��}
    property Alignment default taCenter;
    {* Ĭ�ϵ��ı����뷽ʽ������ı����ж����ǩ�����ɶ����ǩ������
     |<BR> ���LabelEffect��Lines��Labels����}
    property Layout default tlCenter;
    {* �ı���ֱ������뷽ʽ}
    property Quality;
    {* ƽ������ʾ����}
    property FontEffect;
    {* Ĭ�ϵ�������Ч����������ı����������ǩ�����������ǩ������
     |<BR> ���LabelEffect��Lines��Fonts��Font����}
    property LabelEffect;
    {* ���塢�����ǩ���÷�Χ}
    property BackColor default clWhite;
    {* �ؼ�������ɫ}
    property BackGround;
    {* �ؼ�����ͼ��}
    property BackGroundMode;
    {* �ؼ�������ʾģʽ}
  end;

{ TAAFadeText }

  TAAFadeText = class(TAACustomText)
  {* ƽ����Ч�����ı��ؼ������ڶ����ı��ĵ��뵭���л���ʾ}
  private
    { Private declarations }
    FActive: Boolean;
    FLineIndex: Integer;
    FText: TFadeTextParam;
    FFadeProgress: TProgress;
    InBmp, OutBmp, TextBmp: TBitmap;
    FadeTimer: TTimer;
    DelayTimer: TTimer;
    LastText: string;
    CurrText: string;
    CurrAlign: TAlignment;
    FRepeatedCount: Integer;
    FRepeatCount: TBorderWidth;
    NewProg: Double;

    procedure SetActive(const Value: Boolean);
    procedure SetLineIndex(const Value: Integer);
    procedure SetText(const Value: TFadeTextParam);
    procedure OnFadeTimer(Sender: TObject);
    procedure OnDelayTimer(Sender: TObject);
    procedure SetFadeProgress(const Value: TProgress);
    procedure DrawFadeBmp(AText: string; Bmp: TBitmap);
    procedure SetRepeatCount(const Value: TBorderWidth);
  protected
    { Protected declarations }
    procedure CreateDefFonts; override;
    procedure PaintCanvas; override;
    function UseDefaultLabels: Boolean; override;
    procedure LoadedEx; override;
    procedure Reset; override;
    property FadeProgress: TProgress read FFadeProgress write SetFadeProgress;
  public
    constructor Create(AOwner: TComponent); override;
    {* �๹����}
    destructor Destroy; override;
    {* ��������}
    property LineIndex: Integer read FLineIndex write SetLineIndex;
    {* ��ǰ��ʾ���������ţ��û����ֶ�����}
    property RepeatedCount: Integer read FRepeatedCount;
    {* ��ѭ������������������ֻ������}
    procedure FadeTo(Line: Integer);
    {* ���뵭���л���ָ����}
    procedure FadeToNext;
    {* ���뵭���л�����һ��}
    procedure FadeToStr(AText: string);
    {* ���뵭���л���ָ���ı�}
  published
    { Published declarations }
    property Active: Boolean read FActive write SetActive default True;
    {* �Ƿ������ı����뵭���л�}
    property Height default 34;
    {* �ؼ��߶�}
    property Width default 240;
    {* �ؼ����}
    property Font;
    {* �ؼ�����}
    property RepeatCount: TBorderWidth read FRepeatCount write SetRepeatCount default 0;
    {* ����ѭ��������ָ��������ѭ���������Զ�ֹͣ������������OnComplete�¼���
     |<BR> ��ֵ��Ϊ0������ѭ����}
    property Text: TFadeTextParam read FText write SetText;
    {* �ؼ��ı����ݺͲ�������}
    property OnComplete;
    {* ָ�������Ĺ���ѭ�������¼�����RepeatCount}
    property OnPainted;
    {* �ؼ��ػ��¼�}
  end;

procedure Register;

implementation

{$R-}

procedure Register;
begin
  RegisterComponents('AAFont', [TAAFadeText]);
  RegisterComponents('AAFont', [TAALabel]);
  RegisterComponents('AAFont', [TAALinkLabel]);
  RegisterComponents('AAFont', [TAAText]);
  RegisterComponents('AAFont', [TAAScrollText]);
  
  RegisterComponents('AAFont', [TAATimer]);
  RegisterComponents('AAFont', [TAATimerList]);
end;

const
  csAACopyRight =
    '<Title2>��Ȩ����'#13#10 +
    '<Text1>���ؼ�Ϊ��ѿؼ�'#13#10 +
    '����������ڹ�����ҵ�����'#13#10 +
    '����˵���μ�Readme.txt�ļ�'#13#10 +
    '�緢�ִ�������������ϵ'#13#10#13#10 +

  '<Title2>�ؼ�����'#13#10 +
    '<Text1>���ߣ��ܾ���'#13#10 +
    'Email��yygw@yygw.net'#13#10 +
    'Http://www.cnvcl.org'#13#10 +
    'Http://www.yygw.net'#13#10 +
    'CnPack ������'#13#10;

  csAACopyRightStart =
    #13#10'<Title2>�û�����'#13#10 +
    '<Text1><Owner>'#13#10 +
    '<Organization>'#13#10#13#10 +

  '<Title2>�ؼ�����'#13#10;

  csAACopyRightEnd =
    '����ʹ�ò�ͬ��������'#13#10 +
    '�Ͷ��뷽ʽ'#13#10 +
    '֧����Ӱ������ɫ���������Ч'#13#10 +
    '�ṩ���ϵͳ������'#13#10 +
    '�����Զ������'#13#10 +
    '�����������ƽ����ʾ'#13#10#13#10 +

  '<Title2>ʹ��˵��'#13#10 +
    '<Text1>�ؼ������ԡ��������¼�'#13#10 +
    '���Readme.txt�ļ�'#13#10#13#10 +

  '<Title2>�ر��л'#13#10 +
    '<Text1>�����������ṩ'#13#10 +
    'ƽ��������ʾ�㷨'#13#10 +
    'liwensong@hotmail.com'#13#10 +
    'http://member.netease.com/~lws'#13#10 +
    'Passion�ְ��������ؼ�ͼ��'#13#10 +
    'shanzhashu@163.com'#13#10#13#10 +

  '<Title2>��ע'#13#10 +
    '<Text1>�ÿؼ�Ϊ��ѿؼ�'#13#10 +
    '�����������ؼ���������'#13#10 +
    '������߷�һ��ؿ����ʼ�'#13#10 +
    '��ʾ֧��'#13#10#13#10#13#10 +

  '<Title3>CnPack ������'#13#10 +
    '2004.07'#13#10;

  csAATextCopyRight =
    '<Title1><Center>ƽ����Ч�ı��ؼ� ' + verAAFont + #13#10#13#10 +
    csAACopyRight;

  csAAFadeTextCopyRight =
    '<Title1><Center>ƽ����Ч�����ı��ؼ� ' + verAAFont + #13#10#13#10 +
    csAACopyRight + csAACopyRightStart +
    '<Text1>������ʾ���뵭���ı�'#13#10 +
    csAACopyRightEnd;

  csAAScrollTextCopyRight =
    '<Title1>ƽ�������ı��ؼ� ' + verAAFont + #13#10#13#10 +
    csAACopyRight + csAACopyRightStart +
    '<Text1>������ʾ�����ı���Ϣ'#13#10 +
    csAACopyRightEnd;

{ TAALabel }

//--------------------------------------------------------//
//ƽ����Ч�����ǩ                                        //
//--------------------------------------------------------//

//��ʼ��
constructor TAALabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MemBmp := TBitmap.Create;
  MemBmp.PixelFormat := pf24bit;
  FEffect := TAAFontEffect.Create(Self, OnEffectChanged);
  ControlStyle := ControlStyle + [csReplicatable, csSetCaption];
  Width := 46;
  Height := 12;
end;

//�ͷ�
destructor TAALabel.Destroy;
begin
  FEffect.Free;
  MemBmp.Free;
  inherited;
end;

//�ػ�
procedure TAALabel.Reset;
begin
  if not Effect.Transparent then
    DrawMem;
  inherited;
end;

//���ƻ�����
procedure TAALabel.DrawMem;
var
  OffPoint: TPoint;
  th, tw: Integer;
begin
  AAFont.Canvas := MemBmp.Canvas;
  MemBmp.Canvas.Font.Assign(Font); //����
  th := AAFont.TextHeight(Caption); //�ı��߶�
  tw := AAFont.TextWidth(Caption); //�ı����
  //�Զ��趨��С
  if AutoSize and (Align in [alNone, alLeft, alRight]) then
    ClientWidth := tw + 2 * Border;
  if AutoSize and (Align in [alNone, alTop, alBottom]) then
    ClientHeight := th + 2 * Border;
  case Effect.Alignment of    //ˮƽ���뷽ʽ
    taLeftJustify: OffPoint.x := Border;
    taCenter: OffPoint.x := (ClientWidth - tw) div 2;
    taRightJustify: OffPoint.x := ClientWidth - Border - tw;
  end;
  case Effect.Layout of       //��ֱ���뷽ʽ
    tlTop: OffPoint.y := Border;
    tlCenter: OffPoint.y := (ClientHeight - th) div 2;
    tlBottom: OffPoint.y := ClientHeight - Border - th;
  end;
  MemBmp.Height := ClientHeight;
  MemBmp.Width := ClientWidth;
  MemBmp.Canvas.Brush.Color := Color;
  MemBmp.Canvas.Brush.Style := bsSolid;
  if Effect.Transparent then  //͸��
  begin
    CopyParentImage(MemBmp.Canvas); //���Ƹ��ؼ�����
  end else if not Effect.IsBackEmpty then
  begin                       //���Ʊ���ͼ
    DrawBackGround(MemBmp.Canvas, Rect(0, 0, MemBmp.Width, MemBmp.Height),
      Effect.BackGround.Graphic, Effect.BackGroundMode);
  end else
  begin                       //��䱳��ɫ
    MemBmp.Canvas.FillRect(ClientRect);
  end;
  MemBmp.Canvas.Brush.Style := bsClear;
  AAFont.TextOut(OffPoint.x, OffPoint.y, Caption); //ƽ���������
end;

// ͸������
procedure TAALabel.TransparentPaint;
var
  OffPoint: TPoint;
  th, tw: Integer;
begin
  AAFont.Canvas := Canvas;
  Canvas.Font.Assign(Font); //����
  th := AAFont.TextHeight(Caption); //�ı��߶�
  tw := AAFont.TextWidth(Caption); //�ı����
  //�Զ��趨��С
  if AutoSize and (Align in [alNone, alLeft, alRight]) then
    ClientWidth := tw + 2 * Border;
  if AutoSize and (Align in [alNone, alTop, alBottom]) then
    ClientHeight := th + 2 * Border;
  case Effect.Alignment of    //ˮƽ���뷽ʽ
    taLeftJustify: OffPoint.x := Border;
    taCenter: OffPoint.x := (ClientWidth - tw) div 2;
    taRightJustify: OffPoint.x := ClientWidth - Border - tw;
  end;
  case Effect.Layout of       //��ֱ���뷽ʽ
    tlTop: OffPoint.y := Border;
    tlCenter: OffPoint.y := (ClientHeight - th) div 2;
    tlBottom: OffPoint.y := ClientHeight - Border - th;
  end;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Style := bsClear;
  AAFont.TextOut(OffPoint.x, OffPoint.y, Caption); //ƽ���������
end;

//�ؼ��ػ�
procedure TAALabel.PaintCanvas;
begin
  if Effect.Transparent then
    TransparentPaint
  else
    Bitblt(Canvas.Handle, 0, 0, Width, Height, MemBmp.Canvas.Handle, 0, 0,
      SRCCOPY);
end;

//����������Ч
procedure TAALabel.SetEffect(const Value: TAAFontEffect);
begin
  FEffect.Assign(Value);
end;

{ THotLink }

//--------------------------------------------------------//
//�����Ӳ�����                                            //
//--------------------------------------------------------//

//���Ӳ���
procedure THotLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is THotLink then
  begin
    FFade := THotLink(Source).Fade;
    FUnderLine := THotLink(Source).UnderLine;
    FFadeDelay := THotLink(Source).FadeDelay;
    FURL := THotLink(Source).URL;
    FColor := THotLink(Source).Color;
    FBackColor := THotLink(Source).BackColor;
    FFontEffect.Assign(THotLink(Source).FontEffect);
  end;
end;

//��ʼ��
constructor THotLink.Create;
begin
  inherited Create(nil, nil);
  FFade := True;
  FUnderLine := False;
  FFadeDelay := 600;
  FURL := '';
  FColor := clBlue;
  FBackColor := clBtnface;
  FFontEffect := TAAEffect.Create(nil);
end;

//�ͷ�
destructor THotLink.Destroy;
begin
  FFontEffect.Free;
  inherited;
end;

procedure THotLink.SetFontEffect(const Value: TAAEffect);
begin
  FFontEffect.Assign(Value);
  Changed;
end;

{ TAALinkLabel }

//--------------------------------------------------------//
//ƽ����Ч�����ӱ�ǩ                                      //
//--------------------------------------------------------//

//��ʼ��
constructor TAALinkLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHotLink := THotLink.Create;
  HotBmp := TBitmap.Create;
  HotBmp.PixelFormat := pf24bit;
  BlendBmp := TBitmap.Create;
  BlendBmp.PixelFormat := pf24bit;
  FadeTimer := TTimer.Create(Self);
  FadeTimer.Interval := 55;
  FadeTimer.OnTimer := OnFadeTimer;
  FadeTimer.Enabled := False;
  FProgress := 0;
  FFadeStyle := fsNone;
  NewProg := 0;
end;

//�ͷ�
destructor TAALinkLabel.Destroy;
begin
  HotBmp.Free;
  BlendBmp.Free;
  FadeTimer.Free;
  HotLink.Free;
  inherited;
end;

//���ƻ���
procedure TAALinkLabel.PaintCanvas;
begin
  if FMouseIn or (FadeStyle <> fsNone) then
    Bitblt(Canvas.Handle, 0, 0, Width, Height, BlendBmp.Canvas.Handle, 0, 0,
      SRCCOPY)
  else
    inherited;
end;

//���뵭��
procedure TAALinkLabel.OnFadeTimer(Sender: TObject);
begin
  if Abs(NewProg - Progress) > 1 then
    NewProg := Progress;
  case FadeStyle of
    fsIn: begin               //����
        NewProg := NewProg + csMaxProgress * FadeTimer.Interval div HotLink.FadeDelay;
        if NewProg > csMaxProgress then
        begin
          NewProg := csMaxProgress;
          FadeStyle := fsNone;
        end;
        Progress := Round(NewProg);
      end;
    fsOut: begin              //����
        NewProg := NewProg - csMaxProgress * FadeTimer.Interval div HotLink.FadeDelay;
        if NewProg < 0 then
        begin
          NewProg := 0;
          FadeStyle := fsNone;
        end;
        Progress := Round(NewProg);
      end;
    fsNone: begin             //��
        FadeTimer.Enabled := False;
      end;
  end;
end;

//�����ȵ㻭��
procedure TAALinkLabel.DrawHot;
var
  OffPoint: TPoint;
  th, tw: Integer;
  AAEffect: TAAEffect;
begin
  BeginUpdate;
  try
    AAEffect := TAAEffect.Create(nil);
    AAEffect.Assign(AAFont.Effect);

    AAFont.Canvas := HotBmp.Canvas;
    AAFont.Effect.Assign(HotLink.FontEffect);
    HotBmp.Canvas.Font.Assign(Font); //����
    HotBmp.Canvas.Font.Color := HotLink.Color;
    if HotLink.UnderLine then
      HotBmp.Canvas.Font.Style := HotBmp.Canvas.Font.Style + [fsUnderline];
    th := AAFont.TextHeight(Caption); //�ı��߶�
    tw := AAFont.TextWidth(Caption); //�ı����
    if AutoSize and (Align = alNone) then //�Զ��趨��С
    begin
      OffPoint := Point(Border, Border);
    end else begin
      case Effect.Alignment of //ˮƽ���뷽ʽ
        taLeftJustify: OffPoint.x := Border;
        taCenter: OffPoint.x := (ClientWidth - tw) div 2;
        taRightJustify: OffPoint.x := ClientWidth - Border - tw;
      end;
      case Effect.Layout of   //��ֱ���뷽ʽ
        tlTop: OffPoint.y := Border;
        tlCenter: OffPoint.y := (ClientHeight - th) div 2;
        tlBottom: OffPoint.y := ClientHeight - Border - th;
      end;
    end;
    HotBmp.Height := ClientHeight;
    HotBmp.Width := ClientWidth;
    HotBmp.Canvas.Brush.Color := HotLink.BackColor;
    HotBmp.Canvas.Brush.Style := bsSolid;
    if HotLink.Transparent then
    begin
      CopyParentImage(HotBmp.Canvas);
    end else if not HotLink.IsBackEmpty then
    begin
      DrawBackGround(HotBmp.Canvas, Rect(0, 0, HotBmp.Width, HotBmp.Height),
        HotLink.BackGround.Graphic, HotLink.BackGroundMode);
    end else
    begin
      HotBmp.Canvas.FillRect(ClientRect);
    end;
    HotBmp.Canvas.Brush.Style := bsClear;
    AAFont.TextOut(OffPoint.x, OffPoint.y, Caption); //ƽ���������

    AAFont.Effect.Assign(AAEffect);
    AAEffect.Free;
  finally
    EndUpdate;
  end;
end;

//������뿪ʼ����
procedure TAALinkLabel.CMMouseEnter(var Message: TMessage);
begin
  if Enabled then
  begin
    FMouseIn := True;
    DrawMem;
    DrawHot;
    if HotLink.Fade then
    begin
      FadeStyle := fsIn;
    end else
      Progress := csMaxProgress;
  end;
  inherited;
end;

//���Ƴ���ʼ����
procedure TAALinkLabel.CMMouseLeave(var Message: TMessage);
begin
  if Enabled then
  begin
    if HotLink.Fade then
    begin
      FadeStyle := fsOut;
    end else
      Progress := 0;
    FMouseIn := False;
  end;
  inherited;
end;

//����ؼ�
procedure TAALinkLabel.Click;
var
  Wnd: THandle;
begin
  if HotLink.URL <> EmptyStr then
  begin
    if Parent is TForm then
      Wnd := Parent.Handle
    else
      Wnd := 0;               //NULL;
    ShellExecute(Wnd, nil, PChar(HotLink.URL), nil, nil, SW_SHOWNORMAL);
  end;
  inherited;
end;

//������װ��
procedure TAALinkLabel.LoadedEx;
begin
  inherited;
  Reset;
end;

//���õ��뵭������
procedure TAALinkLabel.SetProgress(const Value: TProgress);
begin
  if FProgress <> Value then
  begin
    FProgress := Value;
    Blend(BlendBmp, MemBmp, HotBmp, Progress);
    Paint;
  end;
end;

//��������
procedure TAALinkLabel.SetEnabled(Value: Boolean);
begin
  inherited;
  if not Value then
  begin
    FadeStyle := fsNone;
    Progress := 0;
  end;
end;

//���õ��뵭��
procedure TAALinkLabel.SetFadeStyle(const Value: TFadeStyle);
begin
  if FFadeStyle <> Value then
  begin
    FFadeStyle := Value;
    FadeTimer.Enabled := FFadeStyle <> fsNone;
  end;
end;

//�������Ӳ���
procedure TAALinkLabel.SetHotLink(const Value: THotLink);
begin
  FHotLink.Assign(Value);
end;

{ TAAText }

//--------------------------------------------------------//
//ƽ����Ч�����ӱ�ǩ                                      //
//--------------------------------------------------------//

//�����ߴ�
procedure TAAText.CalcSize;
var
  i, j: Integer;
  DispLines: TStrings;
  WrapLines: TStrings;
  CurrText: string;
  CurrAlign: TAlignment;
  TextWidth: Integer;
  TextHeight: Integer;
  AWidth, AHeight: Integer;
  xFree, yFree: Boolean;
  MaxCol: Integer;
begin
  BeginUpdate;
  DispLines := nil;
  WrapLines := nil;
  try
    DispLines := TStringList.Create; //��ʱ�ı�
    WrapLines := TStringList.Create;
    with FText do
    begin
      xFree := not WordWrap and AutoSize and (Align in [alNone, alLeft, alRight]);
      yFree := AutoSize and (Align in [alNone, alTop, alBottom]);
      if xFree then AWidth := 0
      else AWidth := ClientWidth;
      if yFree then AHeight := 0
      else AHeight := ClientHeight;
      if xFree or yFree then
      begin
        DispLines.Clear;
        DispLines.AddStrings(Lines);
        AAFont.Canvas := Canvas;
        AAFont.Effect.Assign(FText.FontEffect);
        Canvas.Font.Assign(Font);
        for i := 0 to DispLines.Count - 1 do
        begin
          CurrText := DispLines[i]; //��ǰ�����ַ���
          if LabelEffect = leOnlyALine then
          begin
            Canvas.Font.Assign(Font);
            AAFont.Effect.Assign(FText.FontEffect);
          end;
          Fonts.Check(CurrText, Canvas.Font, AAFont.Effect); //��������ǩ
          Labels.Check(CurrText, CurrAlign); //����û���ǩ
          TextWidth := AAFont.TextWidth(CurrText);
          if WordWrap and (TextWidth > AWidth) then //�Զ�����
          begin
            MaxCol := AWidth * Length(CurrText) div TextWidth;
            while AAFont.TextWidth(Copy(CurrText, 1, MaxCol)) > AWidth do
              Dec(MaxCol);
            WrapText(CurrText, WrapLines, MaxCol);
          end else if CurrText <> '' then
            WrapLines.Text := CurrText
          else
            WrapLines.Text := ' ';
          if xFree and (TextWidth > AWidth) then //ȷ�����
          begin
            AWidth := TextWidth;
          end;
          if yFree then       //ȷ���߶�
          begin
            for j := 0 to WrapLines.Count - 1 do
            begin
              CurrText := WrapLines[j];
              TextHeight := AAFont.TextHeight(CurrText + ' ');
              Inc(AHeight, TextHeight);
              if (i < DispLines.Count - 1) or (j < WrapLines.Count - 1) then
                Inc(AHeight, Round(TextHeight * RowPitch / 100));
            end;
          end;
        end;
        if xFree then ClientWidth := AWidth + 2 * Border;
        if yFree then ClientHeight := AHeight + 2 * Border;
      end;
    end;
  finally
    DispLines.Free;
    WrapLines.Free;
    EndUpdate;
  end;
end;

//����
constructor TAAText.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];
  FText := TTextParam.Create(Self, OnLabelChanged);
  TextBmp := TBitmap.Create;
  TextBmp.PixelFormat := pf24bit;
  Width := 46;
  Height := 12;
end;

//������ʾ�ı�
procedure TAAText.CreateText;
begin
  CalcSize;
  TextBmp.Canvas.Brush.Color := Color;
  TextBmp.Canvas.Brush.Style := bsSolid;
  TextBmp.Width := ClientWidth;
  TextBmp.Height := ClientHeight;
  if FText.Transparent then     //͸��
  begin
    CopyParentImage(TextBmp.Canvas); //���Ƹ��ؼ�����
  end else if not FText.IsBackEmpty then
  begin                   //���Ʊ���ͼ
    DrawBackGround(TextBmp.Canvas, Rect(0, 0, TextBmp.Width, TextBmp.Height),
      FText.BackGround.Graphic, FText.BackGroundMode);
  end else
  begin                   //��䱳��ɫ
    TextBmp.Canvas.FillRect(ClientRect);
  end;
  TextBmp.Canvas.Brush.Style := bsClear;
  DrawCanvas(TextBmp.Canvas);
end;

//�ͷ�
destructor TAAText.Destroy;
begin
  TextBmp.Free;
  FText.Free;
  inherited;
end;

//����
procedure TAAText.DrawCanvas(ACanvas: TCanvas);
var
  i, j: Integer;
  DispLines: TStrings;
  WrapLines: TStrings;
  CurrText: string;
  CurrAlign: TAlignment;
  x, y: Integer;
  TextWidth: Integer;
  TextHeight: Integer;
  MaxCol: Integer;
begin
  BeginUpdate;
  DispLines := nil;
  WrapLines := nil;
  try
    DispLines := TStringList.Create; //��ʱ�ı�
    WrapLines := TStringList.Create;
    with FText do
    begin
      DispLines.AddStrings(Lines);
      ACanvas.Brush.Color := Color;
      ACanvas.Brush.Style := bsClear;
      ACanvas.Font.Assign(Font);
      AAFont.Canvas := ACanvas;
      AAFont.Effect.Assign(FText.FontEffect);
      CurrAlign := Alignment; //Ĭ�϶��뷽ʽ
      y := Border;
      for i := 0 to DispLines.Count - 1 do
      begin
        if y > ClientHeight - Border then
          Break;
        CurrText := DispLines[i]; //��ǰ�����ַ���
        if LabelEffect = leOnlyALine then
        begin
          ACanvas.Font.Assign(Font);
          AAFont.Effect.Assign(FText.FontEffect);
          CurrAlign := Alignment;
        end;
        Fonts.Check(CurrText, ACanvas.Font, AAFont.Effect); //��������ǩ
        Labels.Check(CurrText, CurrAlign); //����û���ǩ
        TextWidth := AAFont.TextWidth(CurrText);
        if WordWrap and (TextWidth > ClientWidth - 2 * Border) then //�Զ�����
        begin
          MaxCol := (ClientWidth - 2 * Border) * Length(CurrText) div TextWidth;
          while AAFont.TextWidth(Copy(CurrText, 1, MaxCol)) > ClientWidth - 2
            * Border do
            Dec(MaxCol);
          WrapText(CurrText, WrapLines, MaxCol);
        end else if CurrText <> '' then
          WrapLines.Text := CurrText
        else
          WrapLines.Text := ' ';
        for j := 0 to WrapLines.Count - 1 do
        begin
          CurrText := WrapLines[j];
          TextHeight := AAFont.TextHeight(CurrText + ' ');
          TextWidth := AAFont.TextWidth(CurrText);
          case CurrAlign of   //���뷽ʽ
            taLeftJustify: x := Border;
            taCenter: x := (ClientWidth - TextWidth) div 2;
            taRightJustify: x := ClientWidth - Border - TextWidth;
          else x := 0;
          end;
          AAFont.TextOut(x, y, CurrText);
          y := y + Round(TextHeight * (1 + RowPitch / 100));
        end;
      end;
      AAFont.Effect.Assign(FText.FontEffect);
    end;
  finally
    DispLines.Free;
    WrapLines.Free;
    EndUpdate;
  end;
end;

//�ؼ�������װ��
procedure TAAText.LoadedEx;
begin
  inherited;
  Reset;
end;

//���ƻ���
procedure TAAText.PaintCanvas;
begin
  if Text.Transparent then
    TransparentPaint    //͸��
  else
    Bitblt(Canvas.Handle, 0, 0, Width, Height, TextBmp.Canvas.Handle, 0, 0,
      SRCCOPY);
end;

//��λ
procedure TAAText.Reset;
begin
  if not Text.Transparent then
    CreateText;
  inherited;
end;

//�����ı�
procedure TAAText.SetText(const Value: TTextParam);
begin
  Text.Assign(Value);
end;

//͸������
procedure TAAText.TransparentPaint;
begin
  CalcSize;
  DrawCanvas(Canvas);
end;

//Ĭ���ı�����Ĭ�ϱ�ǩ
function TAAText.UseDefaultLabels: Boolean;
begin
  Result := not FText.IsLinesStored;
end;

{ TTextParam }

//--------------------------------------------------------//
//ƽ���ı�������                                          //
//--------------------------------------------------------//

//����
constructor TTextParam.Create(AOwner: TAAGraphicControl;
  ChangedProc: TNotifyEvent);
begin
  inherited;
  Lines.Text := csAATextCopyRight;
end;

//�ͷ�
destructor TTextParam.Destroy;
begin
  inherited;
end;

//�ı��洢
function TTextParam.IsLinesStored: Boolean;
begin
  Result := Lines.Text <> csAATextCopyRight;
end;

{ TAAScrollText }

//--------------------------------------------------------//
//ƽ�������ı��ؼ�                                        //
//--------------------------------------------------------//

//�ؼ���ʼ��
constructor TAAScrollText.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque]; //�ɿؼ��������пͻ���
  FText := TScrollTextParam.Create(Self, OnLabelChanged);
  TextBmp := TBitmap.Create;
  TextBmp.PixelFormat := pf24bit;
  CurrBmp := TBitmap.Create;
  CurrBmp.PixelFormat := pf24bit;
  ScrollTimer := TAATimer.Create(Self);
  ScrollTimer.Enabled := False;
  ScrollTimer.OnTimer := OnScrollTimer;
  DelayTimer := TTimer.Create(Self);
  DelayTimer.Enabled := False;
  DelayTimer.OnTimer := OnDelayTimer;
  FCurrPos := 0;
  FRepeatCount := 0;
  FActive := True;
  RepeatDelay := 2000;
  ScrollStep := 1;
  ScrollDelay := 60;
  Color := clWhite;
  SetBounds(0, 0, 240, 280);
end;

//�ͷ�
destructor TAAScrollText.Destroy;
begin
  Active := False;
  ScrollTimer.Free;
  DelayTimer.Free;
  TextBmp.Free;
  CurrBmp.Free;
  FText.Free;
  inherited;
end;

//��ʾ�ı���λ
procedure TAAScrollText.Reset;
var
  tActive: Boolean;
begin
  tActive := Active;
  FRepeatedCount := -1;
  Active := False;
  CreateText;
  FCurrPos := 0;
  Paint;
  Active := tActive;
end;

//���ƿؼ�
procedure TAAScrollText.PaintCanvas;
var
  i: Integer;
  BkRed, BkGreen, BkBlue: Byte;
  tBkColor: TColor;

  //͸�����
  procedure DrawFade(y: Integer; Transparency: Integer);
  const
    MaxPixelCount = 32768;
  type
    PRGBTripleArray = ^TRGBTripleArray;
    TRGBTripleArray = array[0..MaxPixelCount] of TRGBTriple;
  var
    Row: PRGBTripleArray;
    x: Integer;
  begin
    Row := CurrBmp.ScanLine[y];
    for x := 0 to CurrBmp.Width - 1 do
    begin
      if Row[x].rgbtRed <> BkRed then
        Row[x].rgbtRed := Transparency * (Row[X].rgbtRed - BkRed) shr 8 + BkRed;
      if Row[x].rgbtGreen <> BkGreen then
        Row[x].rgbtGreen := Transparency * (Row[X].rgbtGreen - BkGreen) shr 8 + BkGreen;
      if Row[x].rgbtBlue <> BkBlue then
        Row[x].rgbtBlue := Transparency * (Row[X].rgbtBlue - BkBlue) shr 8 + BkBlue;
    end;
  end;
begin
  CurrBmp.Height := Height;
  CurrBmp.Width := Width;
  if FCurrPos + Height <= TextBmp.Height then //������ʾ
    BitBlt(CurrBmp.Canvas.Handle, 0, 0, Width, Height, TextBmp.Canvas.Handle, 0,
      FCurrPos, SRCCopy)
  else
  begin                       //��β���
    BitBlt(CurrBmp.Canvas.Handle, 0, 0, Width, TextBmp.Height - FCurrPos,
      TextBmp.Canvas.Handle, 0, FCurrPos, SRCCopy);
    BitBlt(CurrBmp.Canvas.Handle, 0, TextBmp.Height - FCurrPos, Width, Height -
      (TextBmp.Height - FCurrPos), TextBmp.Canvas.Handle, 0, 0, SRCCopy);
  end;
  if FText.Fade then          //���뵭��
  begin
    tBkColor := ColorToRGB(Color);
    BkRed := GetRValue(tBkColor);
    BkGreen := GetGValue(tBkColor);
    BkBlue := GetBValue(tBkColor);
    for i := 0 to FText.FadeHeight - 1 do
    begin
      DrawFade(i, 255 * i div (FText.FadeHeight - 1));
      DrawFade(Height - 1 - i, 255 * i div (FText.FadeHeight - 1));
    end;
  end;                        //���Ƶ��ؼ�����
  if not (csDestroying in ComponentState) then
    BitBlt(Canvas.Handle, 0, 0, Width, Height, CurrBmp.Canvas.Handle, 0, 0, SRCCopy);
  if Assigned(OnPainted) then
    OnPainted(Self);
end;

//ִ�й���
procedure TAAScrollText.OnScrollTimer(Sender: TObject);
begin
  if CurrPos = 0 then         //���ι������
  begin
    FRepeatedCount := FRepeatedCount + 1;
    if (RepeatCount > 0) and (RepeatedCount >= RepeatCount) then
    begin                     //�������
      Active := False;
      FRepeatedCount := -1;
      if Assigned(OnComplete) then
        OnComplete(Self);
      Exit;
    end else if DelayTimer.Interval > 0 then
    begin                     //ѭ����ʱ
      ScrollTimer.Enabled := False;
      DelayTimer.Enabled := True;
      Exit;
    end;
  end;
  
  if (FScrollStep > 0) and (CurrPos + FScrollStep >= TextBmp.Height) then
    CurrPos := 0
  else if (FScrollStep < 0) and (CurrPos + FScrollStep < 0) then
    CurrPos := 0
  else
    CurrPos := CurrPos + FScrollStep; //��ǰλ������
end;

//�����ı�λͼ
procedure TAAScrollText.CreateText;
var
  i, j: Integer;
  DispLines: TStrings;
  CurrText: string;
  WrapLines: TStrings;
  CurrHeight: Integer;
  CurrAlign: TAlignment;
  x, y: Integer;
  TextWidth: Integer;
  TextHeight: Integer;
  MaxCol: Integer;
begin
  BeginUpdate;
  DispLines := nil;
  WrapLines := nil;
  try
    DispLines := TStringList.Create; //��ʱ�ı�
    WrapLines := TStringList.Create;
    with FText do
    begin
      TextBmp.Height := 0;
      TextBmp.Width := Width;
      TextBmp.Canvas.Brush.Color := Color;
      TextBmp.Canvas.Brush.Style := bsSolid;
      DispLines.Clear;
      DispLines.AddStrings(Lines);
      AAFont.Canvas := TextBmp.Canvas;
      AAFont.Effect.Assign(FText.FontEffect);
      if Fade then            //���뵭���հ�
        CurrHeight := FadeHeight
      else
        CurrHeight := 0;
      CurrHeight := CurrHeight + Height * HeadSpace div 100; //ͷ���հ�
      TextBmp.Canvas.Font.Assign(Font);
      for i := 0 to DispLines.Count - 1 do
      begin
        CurrText := DispLines[i]; //��ǰ�����ַ���
        if LabelEffect = leOnlyALine then
        begin
          TextBmp.Canvas.Font.Assign(Font);
          AAFont.Effect.Assign(FText.FontEffect);
        end;
        Fonts.Check(CurrText, TextBmp.Canvas.Font, AAFont.Effect); //��������ǩ
        Labels.Check(CurrText, CurrAlign); //����û���ǩ
        TextHeight := AAFont.TextHeight(CurrText + ' ');
        TextWidth := AAFont.TextWidth(CurrText);
        if WordWrap and (TextWidth > Width) then //�Զ�����
        begin
          MaxCol := Width * Length(CurrText) div TextWidth;
          while AAFont.TextWidth(Copy(CurrText, 1, MaxCol)) > Width do
            Dec(MaxCol);
          WrapText(CurrText, WrapLines, MaxCol);
        end else if CurrText <> '' then
          WrapLines.Text := CurrText
        else
          WrapLines.Text := ' ';
        CurrHeight := CurrHeight + Round(TextHeight * (1 + RowPitch / 100)) *
          WrapLines.Count;
      end;
      TextBmp.Canvas.Brush.Color := Color;
      TextBmp.Canvas.Brush.Style := bsSolid;
      CurrHeight := CurrHeight + Height * TailSpace div 100; //β���հ�
      if CurrHeight < ClientHeight then
        CurrHeight := ClientHeight;
      TextBmp.Height := CurrHeight;
      if Assigned(FText.BackGround.Graphic) and not
        FText.BackGround.Graphic.Empty then
        DrawBackGround(TextBmp.Canvas, Rect(0, 0, TextBmp.Width,
          TextBmp.Height), FText.BackGround.Graphic, FText.BackGroundMode);

      DispLines.Clear;
      DispLines.AddStrings(Lines);
      TextBmp.Canvas.Brush.Style := bsClear;
      AAFont.Effect.Assign(FText.FontEffect);
      if Fade then            //���뵭���հ�
        CurrHeight := FadeHeight
      else
        CurrHeight := 0;
      CurrHeight := CurrHeight + Height * HeadSpace div 100; //ͷ���հ�
      TextBmp.Canvas.Font.Assign(Font);
      CurrAlign := Alignment; //Ĭ�϶��뷽ʽ
      for i := 0 to DispLines.Count - 1 do
      begin
        CurrText := DispLines[i]; //��ǰ�����ַ���
        if LabelEffect = leOnlyALine then
        begin
          TextBmp.Canvas.Font.Assign(Font);
          AAFont.Effect.Assign(FText.FontEffect);
          CurrAlign := Alignment;
        end;
        Fonts.Check(CurrText, TextBmp.Canvas.Font, AAFont.Effect); //��������ǩ
        Labels.Check(CurrText, CurrAlign); //����û���ǩ
        TextWidth := AAFont.TextWidth(CurrText);
        if WordWrap and (TextWidth > Width) then //�Զ�����
        begin
          MaxCol := Width * Length(CurrText) div TextWidth;
          while AAFont.TextWidth(Copy(CurrText, 1, MaxCol)) > Width do
            Dec(MaxCol);
          WrapText(CurrText, WrapLines, MaxCol);
        end else if CurrText <> '' then
          WrapLines.Text := CurrText
        else
          WrapLines.Text := ' ';
        for j := 0 to WrapLines.Count - 1 do
        begin
          CurrText := WrapLines[j];
          TextHeight := AAFont.TextHeight(CurrText + ' ');
          TextWidth := AAFont.TextWidth(CurrText);
          case CurrAlign of     //���뷽ʽ
            taLeftJustify: x := 0;
            taCenter: x := (TextBmp.Width - TextWidth) div 2;
            taRightJustify: x := TextBmp.Width - TextWidth;
          else x := 0;
          end;
          y := CurrHeight;      //�м��
          AAFont.TextOut(x, y, CurrText);
          CurrHeight := CurrHeight + Round(TextHeight * (1 + RowPitch / 100));
        end;
      end;
      if Assigned(OnTextReady) then //����OnTextReady�¼�
        OnTextReady(Self);
    end;
  finally
    WrapLines.Free;
    DispLines.Free;
    EndUpdate;
  end;
end;

//���û
procedure TAAScrollText.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    ScrollTimer.Enabled := FActive;
    if not FActive then
      DelayTimer.Enabled := False;
  end;
end;

//����ѭ����ʱ
procedure TAAScrollText.SetRepeatDelay(const Value: Word);
begin
  if FRepeatDelay <> Value then
  begin
    FRepeatDelay := Value;
    if FRepeatDelay <= 0 then
      FRepeatDelay := 0;
    DelayTimer.Interval := Value;
  end;
end;

//���ù�����ʱ
procedure TAAScrollText.SetScrollDelay(const Value: Word);
begin
  if FScrollDelay <> Value then
  begin
    FScrollDelay := Value;
    if FScrollDelay <= 0 then
      FScrollDelay := 0;
    ScrollTimer.Interval := FScrollDelay;
  end;
end;

//����ÿ�ι�������
procedure TAAScrollText.SetScrollStep(const Value: Integer);
begin
  if FScrollStep <> Value then
  begin
    FScrollStep := Value;
  end;
end;

//����ѭ������
procedure TAAScrollText.SetRepeatCount(const Value: TBorderWidth);
begin
  if FRepeatCount <> Value then
  begin
    FRepeatCount := Value;
    if FRepeatCount <= 0 then
      FRepeatCount := 0;
    Changed;
  end;
end;

//�����ı�����
procedure TAAScrollText.SetText(const Value: TScrollTextParam);
begin
  FText.Assign(Value);
end;

//��ͷ��ʼ����
procedure TAAScrollText.ReStart;
begin
  FRepeatedCount := -1;
  CurrPos := 0;
end;

//���õ�ǰλ��
procedure TAAScrollText.SetCurrPos(const Value: Integer);
begin
  if FCurrPos <> Value then
  begin
    FCurrPos := Value mod TextBmp.Height;
    if FCurrPos < 0 then
      Inc(FCurrPos, TextBmp.Height);
    Paint;
  end;
end;

//��С�仯��Ϣ
function TAAScrollText.CanResize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  if NewWidth < 20 then NewWidth := 20;
  if NewHeight < 20 then NewHeight := 20;
  Result := inherited CanResize(NewWidth, NewHeight);
end;

//ѭ����ʱ
procedure TAAScrollText.OnDelayTimer(Sender: TObject);
begin
  DelayTimer.Enabled := False;
  CurrPos := CurrPos + FScrollStep;
  if Active then
    ScrollTimer.Enabled := True;
end;

//����Ĭ�����弯
procedure TAAScrollText.CreateDefFonts;
var
  FLabel: TFontLabel;
begin
  inherited;
  FLabel := Fonts.AddItem('Title4', '����', 22, clBlack, [fsBold], True, 2, 2);
  if Assigned(FLabel) then
  begin
    FLabel.Effect.Gradual.Enabled := True;
    FLabel.Effect.Gradual.Style := gsLeftToRight;
    FLabel.Effect.Gradual.StartColor := $00FF2200;
    FLabel.Effect.Gradual.EndColor := $002210FF;
    FLabel.Effect.Outline := True;
    FLabel.Effect.Blur := 50;
  end;
  FLabel := Fonts.AddItem('Text3', '����', 11, clBlue, [], True, 1, 1);
  if Assigned(FLabel) then
  begin
    FLabel.Effect.Gradual.Enabled := True;
    FLabel.Effect.Gradual.Style := gsTopToBottom;
    FLabel.Effect.Gradual.StartColor := $00CC3311;
    FLabel.Effect.Gradual.EndColor := $00FF22AA;
  end;
end;

//Ĭ���ı�����Ĭ�ϱ�ǩ
function TAAScrollText.UseDefaultLabels: Boolean;
begin
  Result := not FText.IsLinesStored;
end;

//�ؼ�������װ��
procedure TAAScrollText.LoadedEx;
begin
  inherited;
  Reset;
end;

{ TScrollTextParam }

//--------------------------------------------------------//
//ƽ�������ı�����                                        //
//--------------------------------------------------------//

//��ʼ��
constructor TScrollTextParam.Create(AOwner: TAAGraphicControl;
  ChangedProc: TNotifyEvent);
begin
  inherited;
  TStringList(Lines).Text := csAAScrollTextCopyRight;
  FFade := True;
  FFadeHeight := 10;
  FHeadSpace := 0;
  FTailSpace := 60;
  Alignment := taCenter;
  BackGroundMode := bmTiled;
end;

//�ͷ�
destructor TScrollTextParam.Destroy;
begin
  inherited;
end;

//���õ��뵭��
procedure TScrollTextParam.SetFade(const Value: Boolean);
begin
  if FFade <> Value then
  begin
    FFade := Value;
    Changed;
  end;
end;

//���õ��뵭���߶�
procedure TScrollTextParam.SetFadeHeight(const Value: Integer);
begin
  if FFadeHeight <> Value then
  begin
    FFadeHeight := Value;
    Changed;
  end;
end;

//����ͷ���հ�
procedure TScrollTextParam.SetHeadSpace(const Value: Integer);
begin
  if FHeadSpace <> Value then
  begin
    FHeadSpace := Value;
    if FHeadSpace < 0 then
      FHeadSpace := 0;
    if FHeadSpace > 150 then
      FHeadSpace := 150;
    Changed;
  end;
end;

//����β���հ�
procedure TScrollTextParam.SetTailSpace(const Value: Integer);
begin
  if FTailSpace <> Value then
  begin
    FTailSpace := Value;
    if FTailSpace < 0 then
      FTailSpace := 0;
    if FTailSpace > 150 then
      FTailSpace := 150;
    Changed;
  end;
end;

//�ı������Ƿ�洢
function TScrollTextParam.IsLinesStored: Boolean;
begin
  Result := Lines.Text <> csAAScrollTextCopyRight;
end;

{ TAAFadeText }

//--------------------------------------------------------//
//ƽ����Ч�����ı��ؼ�                                    //
//--------------------------------------------------------//

//����
constructor TAAFadeText.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];
  TextBmp := TBitmap.Create;
  TextBmp.PixelFormat := pf24bit;
  InBmp := TBitmap.Create;
  InBmp.PixelFormat := pf24bit;
  OutBmp := TBitmap.Create;
  OutBmp.PixelFormat := pf24bit;
  FadeTimer := TTimer.Create(Self);
  FadeTimer.Interval := 25;
  FadeTimer.Enabled := False;
  FadeTimer.OnTimer := OnFadeTimer;
  DelayTimer := TTimer.Create(Self);
  DelayTimer.Enabled := False;
  DelayTimer.OnTimer := OnDelayTimer;
  FText := TFadeTextParam.Create(Self, OnLabelChanged);
  FLineIndex := -1;
  FFadeProgress := 0;
  FRepeatCount := 0;
  FRepeatedCount := 0;
  FActive := True;
  Color := clWhite;
  LastText := '';
  CurrText := '';
  NewProg := 0;
  SetBounds(0, 0, 240, 34);
end;

//����Ĭ�������ǩ
procedure TAAFadeText.CreateDefFonts;
var
  FLabel: TFontLabel;
begin
  inherited;
  FLabel := Fonts.AddItem('Title4', '����', 22, clBlack, [], True, 2, 2);
  if Assigned(FLabel) then
  begin
    FLabel.Effect.Gradual.Enabled := True;
    FLabel.Effect.Gradual.Style := gsLeftToRight;
    FLabel.Effect.Gradual.StartColor := $00FF2200;
    FLabel.Effect.Gradual.EndColor := $002210FF;
    FLabel.Effect.Outline := True;
    FLabel.Effect.Blur := 50;
  end;
  FLabel := Fonts.AddItem('Text3', '����', 11, clBlue, [], True, 1, 1);
  if Assigned(FLabel) then
  begin
    FLabel.Effect.Gradual.Enabled := True;
    FLabel.Effect.Gradual.Style := gsTopToBottom;
    FLabel.Effect.Gradual.StartColor := $00CC8811;
    FLabel.Effect.Gradual.EndColor := $00FF22AA;
  end;
end;

//�ͷ�
destructor TAAFadeText.Destroy;
begin
  FText.Free;
  DelayTimer.Free;
  FadeTimer.Free;
  OutBmp.Free;
  InBmp.Free;
  TextBmp.Free;
  inherited;
end;

//���ƽ���ͼ
procedure TAAFadeText.DrawFadeBmp(AText: string; Bmp: TBitmap);
var
  OffPoint: TPoint;
  th, tw: Integer;
begin
  AAFont.Canvas := Bmp.Canvas;
  if Text.LabelEffect = leOnlyALine then
  begin
    Bmp.Canvas.Font.Assign(Font);
    AAFont.Effect.Assign(Text.FontEffect);
    CurrAlign := Text.Alignment;
  end;
  Fonts.Check(AText, Bmp.Canvas.Font, AAFont.Effect); //��������ǩ
  Labels.Check(AText, CurrAlign); //����û���ǩ
  th := AAFont.TextHeight(AText); //�ı��߶�
  tw := AAFont.TextWidth(AText); //�ı����
  case CurrAlign of           //ˮƽ���뷽ʽ
    taLeftJustify: OffPoint.x := 0;
    taRightJustify: OffPoint.x := ClientWidth - tw;
    taCenter: OffPoint.x := (ClientWidth - tw) div 2;
  end;
  case Text.Layout of         //��ֱ���뷽ʽ
    tlTop: OffPoint.y := 0;
    tlCenter: OffPoint.y := (ClientHeight - th) div 2;
    tlBottom: OffPoint.y := ClientHeight - th;
  end;
  Bmp.Height := ClientHeight;
  Bmp.Width := ClientWidth;
  Bmp.Canvas.Brush.Color := Color;
  Bmp.Canvas.Brush.Style := bsSolid;
  if Text.Transparent then    //͸��
  begin
    CopyParentImage(Bmp.Canvas); //���Ƹ��ؼ�����
  end else if not Text.IsBackEmpty then
  begin                       //���Ʊ���ͼ
    DrawBackGround(Bmp.Canvas, Rect(0, 0, Bmp.Width, Bmp.Height),
      Text.BackGround.Graphic, Text.BackGroundMode);
  end else
  begin                       //��䱳��ɫ
    Bmp.Canvas.FillRect(ClientRect);
  end;
  Bmp.Canvas.Brush.Style := bsClear;
  AAFont.TextOut(OffPoint.x, OffPoint.y, AText); //ƽ���������
end;

//������ָ����
procedure TAAFadeText.FadeTo(Line: Integer);
begin
  if Text.Lines.Count <= 0 then
    Exit;
  if Line < 0 then
    Line := 0;
  if Line > Text.Lines.Count - 1 then
  begin
    Line := 0;
    Inc(FRepeatedCount);
    if (FRepeatCount > 0) and (FRepeatedCount >= FRepeatCount) then
    begin
      Active := False;
      FRepeatedCount := 0;
      FLineIndex := -1;
      FadeToStr('');
      if Assigned(OnComplete) then
        OnComplete(Self);
      Exit;
    end;
  end;
  FadeToStr(Text.Lines[Line]);
  FLineIndex := Line;
end;

//��������һ��
procedure TAAFadeText.FadeToNext;
begin
  FadeTo(LineIndex + 1);
end;

//������ָ���ı�
procedure TAAFadeText.FadeToStr(AText: string);
begin
  OutBmp.Assign(TextBmp);
  DrawFadeBmp(AText, InBmp);
  LastText := CurrText;
  CurrText := AText;
  FFadeProgress := 0;
  FadeTimer.Enabled := False;
  FadeTimer.Enabled := True;
  if DelayTimer.Enabled then
  begin
    DelayTimer.Enabled := False;
    DelayTimer.Enabled := True;
  end;
end;

//������װ��
procedure TAAFadeText.LoadedEx;
begin
  inherited;
  CurrAlign := Text.Alignment;
  Reset;
  FRepeatedCount := 0;
  DelayTimer.Enabled := FActive;
  if FActive then
    OnDelayTimer(Self);
end;

//�����л��ı���ʱ�¼�
procedure TAAFadeText.OnDelayTimer(Sender: TObject);
begin
  FadeToNext;
end;


//�������̶�ʱ�¼�
procedure TAAFadeText.OnFadeTimer(Sender: TObject);
begin
  if Abs(NewProg - FadeProgress) > 1 then
    NewProg := FadeProgress;
  NewProg := NewProg + csMaxProgress * FadeTimer.Interval div Text.FadeDelay;
  if NewProg > csMaxProgress then
  begin
    NewProg := csMaxProgress;
    FadeTimer.Enabled := False;
  end;
  FadeProgress := Round(NewProg);
end;

//���ƿؼ�����
procedure TAAFadeText.PaintCanvas;
begin
  inherited;
  if Text.Transparent then
  begin                       //͸���������ػ�
    if FadeProgress = 0 then
      DrawFadeBmp(CurrText, TextBmp)
    else begin
      DrawFadeBmp(LastText, OutBmp);
      DrawFadeBmp(CurrText, InBmp);
    end;
  end;
  if FadeProgress <> 0 then   //������
    Blend(TextBmp, OutBmp, InBmp, FFadeProgress);
  Bitblt(Canvas.Handle, 0, 0, Width, Height, TextBmp.Canvas.Handle, 0, 0,
    SRCCOPY);
  if Assigned(OnPainted) then
    OnPainted(Self);
end;

//������ʾ
procedure TAAFadeText.Reset;
begin
  if FadeProgress = 0 then
    DrawFadeBmp(CurrText, TextBmp)
  else begin
    DrawFadeBmp(LastText, OutBmp);
    DrawFadeBmp(CurrText, InBmp);
    Blend(TextBmp, OutBmp, InBmp, FFadeProgress);
  end;
  inherited;
end;

//���û�Ծ
procedure TAAFadeText.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    DelayTimer.Enabled := FActive;
    if FActive then
    begin
      FRepeatedCount := 0;
      OnDelayTimer(Self);
    end;
  end;
end;

//���ý�������
procedure TAAFadeText.SetFadeProgress(const Value: TProgress);
begin
  if FFadeProgress <> Value then
  begin
    FFadeProgress := Value;
    Paint;
  end;
end;

//���õ�ǰ��
procedure TAAFadeText.SetLineIndex(const Value: Integer);
begin
  if FLineIndex <> Value then
  begin
    FadeTo(FLineIndex);
  end;
end;

//������ѭ������
procedure TAAFadeText.SetRepeatCount(const Value: TBorderWidth);
begin
  if FRepeatCount <> Value then
  begin
    FRepeatCount := Value;
    if FRepeatedCount >= FRepeatCount then
  end;
end;

//�����ı�
procedure TAAFadeText.SetText(const Value: TFadeTextParam);
begin
  FText.Assign(Value);
end;

//��Ĭ���ı�ʱ����Ĭ�ϱ�ǩ
function TAAFadeText.UseDefaultLabels: Boolean;
begin
  Result := not FText.IsLinesStored;
end;

{ TFadeTextParam }

//--------------------------------------------------------//
//ƽ����Ч�����ı�����                                    //
//--------------------------------------------------------//

//��ֵ
procedure TFadeTextParam.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TFadeTextParam then
  begin
    FFadeDelay := TFadeTextParam(Source).FadeDelay;
    LineDelay := TFadeTextParam(Source).LineDelay;
  end;
end;

//����
constructor TFadeTextParam.Create(AOwner: TAAGraphicControl;
  ChangedProc: TNotifyEvent);
begin
  inherited;
  TStringList(Lines).Text := csAAFadeTextCopyRight;
  FadeDelay := 600;
  LineDelay := 3000;
  Alignment := taCenter;
  Layout := tlCenter;
end;

//�ͷ�
destructor TFadeTextParam.Destroy;
begin
  inherited;
end;

//ȡ����ʱ
function TFadeTextParam.GetLineDelay: Cardinal;
begin
  Result := TAAFadeText(Owner).DelayTimer.Interval;
end;

// ȡͼ��߶�
function TAAScrollText.GetBmpHeight: Integer;
begin
  Result := TextBmp.Height;
end;

//�洢�ı�
function TFadeTextParam.IsLinesStored: Boolean;
begin
  Result := Lines.Text <> csAAFadeTextCopyRight;
end;

//���ý�����ʱ
procedure TFadeTextParam.SetFadeDelay(const Value: Cardinal);
begin
  if FFadeDelay <> Value then
  begin
    FFadeDelay := Value;
    if FFadeDelay > LineDelay - 200 then
      FFadeDelay := LineDelay - 200;
    if FFadeDelay < 50 then
      FFadeDelay := 50;
  end;
end;

//��������ʱ
procedure TFadeTextParam.SetLineDelay(const Value: Cardinal);
var
  T: Cardinal;
begin
  T := Value;
  if T < FFadeDelay + 200 then
    T := FFadeDelay + 200;
  TAAFadeText(Owner).DelayTimer.Interval := T;
end;

end.




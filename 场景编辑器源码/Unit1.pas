unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VCLUnZip, VCLZip, StdCtrls, ComCtrls,md5, ActnList,richedit,
  Menus, SynEdit, SynMemo, SynEditor, SynEditSource, SynEditActions,
  ImgList, ExtCtrls, SynCompletionProposal, SynSpellCheck, SynAutoCorrect,
  SynEditHighlighter, SynHighlighterJScript, SynEditPrint,SynEditMiscClasses,
  AppEvnts,gifimage, StdActns;
 const
   post_msg_id= WM_USER + 35670;
   edit_caption='��������Ϸ�����༭��2.1';
type
   Tlift_page_type=(l_new,l_gpic,l_shuxing,l_guaiwu,l_wupin,L_html,l_duihua,l_jianmo,l_renwu,L_crt_html);
  PNode_map_data= ^TNode_map_data;
  TNode_map_data=packed record
    name: string[32];
    id: integer;
    is_set: boolean;
    is_short_id: boolean; //id�Ƿ���Ե�ַ
    row: integer;
    col: array[0..1] of word;  //0��ʾ��㣬1��ʾ������
    qianjin: array[0..63] of integer;
    houtui: array[0..9] of integer;
    prve: PNode_map_data;
    next: PNode_map_data;
    end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    VCLZip1: TVCLZip;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    StatusBar1: TStatusBar;
    Button8: TButton;
    il1: TImageList;
    SynEditor1: TSynEditor;
    SynManager1: TSynManager;
    SynEditSource1: TSynEditSource;
    actlst1: TActionList;
    aSynNormalSelect1: TaSynNormalSelect;
    aSynColumnSelect1: TaSynColumnSelect;
    aSynLineSelect1: TaSynLineSelect;
    aSynUndo1: TaSynUndo;
    aSynRedo1: TaSynRedo;
    aSynAppendCut1: TaSynAppendCut;
    aSynAppendCopy1: TaSynAppendCopy;
    aSynDeleteNextchar1: TaSynDeleteNextchar;
    aSynDeleteLastChar1: TaSynDeleteLastChar;
    aSynDeleteWordToEnd1: TaSynDeleteWordToEnd;
    aSynDeleteWordToStart1: TaSynDeleteWordToStart;
    aSynDeleteWord1: TaSynDeleteWord;
    aSynDeleteLineToEnd1: TaSynDeleteLineToEnd;
    aSynDeleteLineToStart1: TaSynDeleteLineToStart;
    aSynDeleteLine1: TaSynDeleteLine;
    aSynClearAll1: TaSynClearAll;
    aSynSelectAll1: TaSynSelectAll;
    aSynSelectLine1: TaSynSelectLine;
    aSynSelectNextLine1: TaSynSelectNextLine;
    aSynSelectLastLine1: TaSynSelectLastLine;
    aSynSelectWrod1: TaSynSelectWrod;
    aSynSelectNextWord1: TaSynSelectNextWord;
    aSynSelectLastWord1: TaSynSelectLastWord;
    aSynGotoBookmark1: TaSynGotoBookmark;
    aSynSetBookmark1: TaSynSetBookmark;
    aSynClearBookmark1: TaSynClearBookmark;
    aSynGotoLastChange1: TaSynGotoLastChange;
    aSynMatchBracket1: TaSynMatchBracket;
    aSynCommentBlock1: TaSynCommentBlock;
    aSynFind1: TaSynFind;
    aSynFindNext1: TaSynFindNext;
    aSynFindLast1: TaSynFindLast;
    aSynFindNextWord1: TaSynFindNextWord;
    aSynFindLastWord1: TaSynFindLastWord;
    aSynReplace1: TaSynReplace;
    aSynReplaceNext1: TaSynReplaceNext;
    aSynReplaceLast1: TaSynReplaceLast;
    aSynUpperCase1: TaSynUpperCase;
    aSynLowerCase1: TaSynLowerCase;
    aSynToggleCase1: TaSynToggleCase;
    aSynTitleCase1: TaSynTitleCase;
    aSynBlockIndent1: TaSynBlockIndent;
    aSynBlockUnindent1: TaSynBlockUnindent;
    aSynInsertLine1: TaSynInsertLine;
    aSynLineBreak1: TaSynLineBreak;
    aSynFileFormatDos1: TaSynFileFormatDos;
    aSynFileFormatMac1: TaSynFileFormatMac;
    aSynFileFormatUnix1: TaSynFileFormatUnix;
    aSynPrint1: TaSynPrint;
    aSynQuickPrint1: TaSynQuickPrint;
    aSynGotoBookmark2: TaSynGotoBookmark;
    aSynSetBookmark2: TaSynSetBookmark;
    aSynGotoBookmark3: TaSynGotoBookmark;
    aSynSetBookmark3: TaSynSetBookmark;
    aSynGotoBookmark4: TaSynGotoBookmark;
    aSynGotoBookmark5: TaSynGotoBookmark;
    aSynSetBookmark5: TaSynSetBookmark;
    aSynGotoBookmark6: TaSynGotoBookmark;
    aSynSetBookmark6: TaSynSetBookmark;
    aSynGotoBookmark7: TaSynGotoBookmark;
    aSynSetBookmark7: TaSynSetBookmark;
    aSynGotoBookmark8: TaSynGotoBookmark;
    aSynSetBookmark8: TaSynSetBookmark;
    aSynGotoBookmark9: TaSynGotoBookmark;
    aSynSetBookmark9: TaSynSetBookmark;
    aSynGotoBookmark10: TaSynGotoBookmark;
    aSynSetBookmark10: TaSynSetBookmark;
    aSynSetBookmark4: TaSynSetBookmark;
    aSynInsertFile1: TaSynInsertFile;
    aSynPageSetup1: TaSynPageSetup;
    aSynPreview1: TaSynPreview;
    aSynClose1: TaSynClose;
    aSynJump1: TaSynJump;
    aSynOptionsSetting1: TaSynOptionsSetting;
    aSynToggleHighlighter1: TaSynToggleHighlighter;
    aSynSpellCheck1: TaSynSpellCheck;
    aSynSpellCheckOptions1: TaSynSpellCheckOptions;
    SynEditPrint1: TSynEditPrint;
    mm1: TMainMenu;
    N1: TMenuItem;
    N4: TMenuItem;
    N49: TMenuItem;
    N6: TMenuItem;
    aSynPaste11: TMenuItem;
    N7: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    x1: TMenuItem;
    U1: TMenuItem;
    R1: TMenuItem;
    N8: TMenuItem;
    X2: TMenuItem;
    N32: TMenuItem;
    C1: TMenuItem;
    N33: TMenuItem;
    P1: TMenuItem;
    N9: TMenuItem;
    D1: TMenuItem;
    t1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N17: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    aSynClearAll11: TMenuItem;
    N13: TMenuItem;
    A3: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N34: TMenuItem;
    N56: TMenuItem;
    N55: TMenuItem;
    F1: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    aSynReplaceNext11: TMenuItem;
    aSynReplaceLast11: TMenuItem;
    N41: TMenuItem;
    N44: TMenuItem;
    N02: TMenuItem;
    N111: TMenuItem;
    N211: TMenuItem;
    N311: TMenuItem;
    N46: TMenuItem;
    N52: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N82: TMenuItem;
    N92: TMenuItem;
    N43: TMenuItem;
    N01: TMenuItem;
    N110: TMenuItem;
    N210: TMenuItem;
    N310: TMenuItem;
    N45: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    N42: TMenuItem;
    N50: TMenuItem;
    G1: TMenuItem;
    N03: TMenuItem;
    N53: TMenuItem;
    O2: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    H1: TMenuItem;
    N54: TMenuItem;
    E1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    Button9: TButton;
    Button10: TButton;
    aSynSaveSel1: TaSynSaveSel;
    SynCompletionProposal1: TSynCompletionProposal;
    N3: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    Button11: TButton;
    Button12: TButton;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    N78: TMenuItem;
    N79: TMenuItem;
    N80: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    N85: TMenuItem;
    N86: TMenuItem;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    ColorDialog1: TColorDialog;
    N90: TMenuItem;
    N93: TMenuItem;
    N94: TMenuItem;
    N95: TMenuItem;
    N96: TMenuItem;
    Button13: TButton;
    N97: TMenuItem;
    html2: TMenuItem;
    N98: TMenuItem;
    GIF1: TMenuItem;
    OpenDialog2: TOpenDialog;
    SaveDialog2: TSaveDialog;
    N99: TMenuItem;
    OpenDialog3: TOpenDialog;
    N100: TMenuItem;
    N101: TMenuItem;
    N102: TMenuItem;
    SaveDialog_zip: TSaveDialog;
    N103: TMenuItem;
    N104: TMenuItem;
    jpg1: TMenuItem;
    N105: TMenuItem;
    N106: TMenuItem;
    N107: TMenuItem;
    Edit1: TEdit;
    Button14: TButton;
    ID1: TMenuItem;
    N108: TMenuItem;
    N109: TMenuItem;
    N112: TMenuItem;
    Button15: TButton;
    Button16: TButton;
    N113: TMenuItem;
    N114: TMenuItem;
    N115: TMenuItem;
    N116: TMenuItem;
    N117: TMenuItem;
    N118: TMenuItem;
    N119: TMenuItem;
    N120: TMenuItem;
    N121: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    N122: TMenuItem;
    N123: TMenuItem;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Edit_gpic: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Edit_kuan: TEdit;
    Edit_gao: TEdit;
    Edit_touming: TEdit;
    Label17: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Button17: TButton;
    Label18: TLabel;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button39: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    Button43: TButton;
    Button37: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button38: TButton;
    Button44: TButton;
    Button45: TButton;
    N124: TMenuItem;
    Button46: TButton;
    Button47: TButton;
    N125: TMenuItem;
    N126: TMenuItem;
    N127: TMenuItem;
    N128: TMenuItem;
    ID2: TMenuItem;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    Button48: TButton;
    N129: TMenuItem;
    ifthen1: TMenuItem;
    Button49: TButton;
    Button50: TButton;
    N130: TMenuItem;
    Button51: TButton;
    TrackBar1: TTrackBar;
    Edit2: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Edit3: TEdit;
    CheckBox7: TCheckBox;
    Button52: TButton;
    Button53: TButton;
    Label21: TLabel;
    Edit4: TEdit;
    Button54: TButton;
    Label22: TLabel;
    Edit5: TEdit;
    Label23: TLabel;
    Edit6: TEdit;
    Label24: TLabel;
    Edit7: TEdit;
    Label25: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label26: TLabel;
    Edit11: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure SynEditor1GutterClick(Sender: TObject; Button: TMouseButton;
      X, Y, Line: Integer; Mark: TSynEditMark; Region: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SynEditor1Change(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N60Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure N76Click(Sender: TObject);
    procedure N77Click(Sender: TObject);
    procedure N79Click(Sender: TObject);
    procedure N80Click(Sender: TObject);
    procedure N83Click(Sender: TObject);
    procedure N84Click(Sender: TObject);
    procedure N85Click(Sender: TObject);
    procedure N86Click(Sender: TObject);
    procedure N90Click(Sender: TObject);
    procedure N87Click(Sender: TObject);
    procedure N94Click(Sender: TObject);
    procedure N95Click(Sender: TObject);
    procedure N96Click(Sender: TObject);
    procedure html2Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure N98Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure GIF1Click(Sender: TObject);
    procedure N49Click(Sender: TObject);
    procedure N72Click(Sender: TObject);
    procedure N99Click(Sender: TObject);
    procedure N74Click(Sender: TObject);
    procedure N101Click(Sender: TObject);
    procedure N102Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure VCLZip1TotalPercentDone(Sender: TObject; Percent: Integer);
    procedure N65Click(Sender: TObject);
    procedure N68Click(Sender: TObject);
    procedure N66Click(Sender: TObject);
    procedure N103Click(Sender: TObject);
    procedure SynEditor1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SynEditor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SynEditor1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N104Click(Sender: TObject);
    procedure jpg1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SynEditor1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N105Click(Sender: TObject);
    procedure N106Click(Sender: TObject);
    procedure N107Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ID1Click(Sender: TObject);
    procedure N108Click(Sender: TObject);
    procedure N109Click(Sender: TObject);
    procedure N112Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure N113Click(Sender: TObject);
    procedure N114Click(Sender: TObject);
    procedure N116Click(Sender: TObject);
    procedure N119Click(Sender: TObject);
    procedure N120Click(Sender: TObject);
    procedure N118Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure N123Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button43Click(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure N124Click(Sender: TObject);
    procedure Button47Click(Sender: TObject);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit_gpicExit(Sender: TObject);
    procedure Edit_gpicChange(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Edit_gpicEnter(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure ID2Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure N129Click(Sender: TObject);
    procedure ifthen1Click(Sender: TObject);
    procedure N130Click(Sender: TObject);
    procedure Button51Click(Sender: TObject);
    procedure Button54Click(Sender: TObject);
    procedure Edit10Enter(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure Edit11Enter(Sender: TObject);
    procedure Edit11Exit(Sender: TObject);
  private
    { Private declarations }
    rich_i,open_file_index: integer;
    help_list: Tstringlist;
    open_file_list: Tstringlist;
    open_bk: boolean; //�Ƿ���open��ǰ�����˲���
    jiami_flag: integer;
    open_file_type: Tlift_page_type;
    procedure save_file;
    function Input_password(const ACaption, APrompt: string;
              Value: string): string;
    procedure open_file_upp(const n: string; stt: Tstringlist=nil);
    procedure open_file_usp(const n: string; stt: Tstringlist=nil);
    procedure RC_post_message(var msg: TMessage); message post_msg_id;
    procedure open_file_all(const n: string);
    procedure open_file_shell(const n: string);
    function get_scene_id: string; //�õ�һ��δ�õ�id
    function spell_scene(need_h: boolean): boolean; //�����ļ����﷨����
    function is_number(const s: string): boolean; //�ַ����Ƿ����ֵ�
    procedure create_npc_chat(s: string); //����ѡ���������ĶԻ����
    procedure create_next_char(flag: integer); //������һ���ĶԻ�
    function  code_in_html: boolean; //��鵱ǰ���Ƿ�λ�ڿ�дhtml������������
    procedure show_code; //չ���۵��Ĵ���
    function up_and_clean_space(const s: string): string; //Сд��ĸ���д����ȥ�����ں�ǰ��Ŀո�
    procedure show_lift_page_type(t:Tlift_page_type); //��ʾ���ҳ����
    procedure show_l_shuxing;
    procedure show_l_guaiwu;
    procedure show_l_wupin;
    procedure show_l_jianmo;
    procedure show_l_renwu;
    procedure insert_text_fromfile(const s: string);
    procedure show_l_gpic_base;
    procedure show_l_shuxing_base;
    function compo_gpic: string; //�ϳ�gpic
    procedure open_new_file(n: string; p:Tlift_page_type); //���½������ļ�
    procedure save_upp_base(const n: string; str1: Tstringlist);
  public
    { Public declarations }
    map_name: Tstringlist;
    map_name_changed: boolean; //��ͼ�����ļ��Ƿ��޸�
    procedure write_ss(s: string);
    function read_ss_up: string;
    function read_ss_down: string;

        function read_ss_up_2: string;
    function read_ss_down_2: string;

    procedure load_password_set;
    function get_open_ps: string;
    function get_save_ps: string; //��ȡ��ȡ��������
    procedure game_add_password(st1: Tstringlist); //���ݹ����������
    function  game_check_password(st1: Tstringlist): boolean; //�������
    procedure open_file_scene(const n: string; stt: Tstringlist=nil);
    procedure save_ugm(const n: string);
  end;

var
  Form1: TForm1;
  data_path: string;
  file_save_path: string;
  file_is_change: boolean;
  file_open_type: integer;
  open_s_G,save_s_G: string;
  open_type_G,save_type_G: integer;
  opened_file_name: string; //�򿪵��ļ��������ڱ���ʱ�ظ�
  edit_hint_string: string;
  show_space: boolean;
implementation
   uses unit2,unit_password,Unit_p_edit,FastStrings,shellapi,
   Unit_scene_option,Registry,Unit_gpic,unit_sijian,Unit_debug,unit_tihuan;
{$R *.dfm}
function GetShellFolders(strDir:string):string;
const
  regPath = '\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders';
var
  Reg : TRegistry;
  strFolders : string;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(regPath,false) then
    begin
      strFolders := Reg.ReadString(strDir);
    end;
  finally
    Reg.Free;
  end;
    result := strFolders;
end;
function char_not_in_az(a: char): boolean;
  begin
    result:= not (a in['a'..'z','A'..'Z','0'..'9','_']);
  end;
function TForm1.Input_password(const ACaption, APrompt: string;
  Value: string): string;
  function GetAveCharSize(Canvas: TCanvas): TPoint;
 var
   I: Integer;
   Buffer: array[0..51] of Char;
 begin
   for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
   for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
   GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
   Result.X := Result.X div 52;
 end;

var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := '';
  Form := TForm.Create(nil);
  //Windows.SetParent(Form.Handle ,Handle);
  form.ParentWindow:= handle;
  form.FormStyle:= fsStayOnTop;
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      ParentWindow:= handle;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        passwordchar:= '*';
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'ȷ��';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'ȡ��';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        result := Edit.Text;
      end;
    finally
      Form.Free;
    end;
end;

function game_dencrypt(const src: string): string;
var
//idx :integer;
KeyLen :Integer;
KeyPos :Integer;
offset :Integer;
dest :string;
SrcPos :Integer;
SrcAsc :Integer;
TmpSrcAsc :Integer;
//Range :Integer;
 key: string;
begin

  if src= '' then
   begin
   result:= '';
   exit;
   end;

key:= 'fat dog';
KeyLen:=Length(Key);
KeyPos:=0;
//SrcPos:=0;
//SrcAsc:=0;
//Range:=256;
offset:=StrToInt('$'+ copy(src,1,2));
SrcPos:=3;
repeat
SrcAsc:=StrToInt('$'+ copy(src,SrcPos,2));
if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
if TmpSrcAsc <= offset then
TmpSrcAsc := 255 + TmpSrcAsc - offset
else
TmpSrcAsc := TmpSrcAsc - offset;
dest := dest + chr(TmpSrcAsc);
offset:=srcAsc;
SrcPos:=SrcPos + 2;
until SrcPos >= Length(Src);
Result:=Dest;


end;

procedure TForm1.FormShow(Sender: TObject);
begin
self.WindowState:= wsMaximized;

  if not show_space then
   begin
    SynEditor1.lines.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\t.txt');
     syneditor1.InitCodeFolding;
    syneditor1.Repaint;
   end;
 combobox1.Items.AddStrings(form_gpic.ComboBox1.Items); //������ʾЧ��
end;

procedure TForm1.Button2Click(Sender: TObject);

begin
screen.Cursor:= crhourglass;

 syneditor1.InitCodeFolding;  //չ���۵��Ĵ���
 if not (GetKeyState(VK_SHIFT) < 0) then
 begin
 if not spell_scene(false) then
  begin
   screen.Cursor:= crdefault;
    exit;
  end;
 end;
screen.Cursor:= crdefault;
statusbar1.Panels[0].Text:= '';

   if trim(SynEditor1.Lines.Values['id'])= '' then
    begin
     raise Exception.Create('ID����Ϊ�ա�');
    end;

      savedialog1.FileName:= '';

     if (file_open_type= 1) and (file_save_path<> '') then
     savedialog1.InitialDir:= file_save_path
     else
      savedialog1.InitialDir:= data_path+ 'scene';

    savedialog1.FileName:= SynEditor1.Lines.Values['id'];

   savedialog1.FilterIndex:= 1;

if savedialog1.Execute then
 begin
    save_ugm(savedialog1.FileName);
    caption:= edit_caption+ ' --'+ savedialog1.FileName;
    application.Title:= ExtractFileName(savedialog1.FileName)+ ' - ��Ϸ�༭��';
    case jiami_flag of
    1: caption:= caption+ ' ���ܵ��ĵ���ע�⣬����ȫ�Ŀ�����';
    2: caption:= caption+ ' ���ܵ��ĵ�';
     end;

 end;
end;

procedure TForm1.Button1Click(Sender: TObject);   //��
var b: boolean;
begin
opendialog1.filename:='';
b:= (GetKeyState(VK_SHIFT) < 0);
 if (file_open_type= 1) and (file_save_path<> '') then
     opendialog1.InitialDir:= file_save_path
     else
      opendialog1.InitialDir:= data_path+ 'scene';
   opendialog1.FilterIndex:= 1;
if opendialog1.Execute then
 begin
   if file_is_change or b or (GetKeyState(VK_SHIFT) < 0) then
    open_file_shell(opendialog1.FileName )
   else
    open_file_scene(opendialog1.FileName);

 end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var str1: Tstringlist;
    i: integer;

begin
    syneditor1.InitCodeFolding;  //չ���۵��Ĵ���
savedialog1.filename:='';

   if (file_open_type= 2) and (file_save_path<> '') then
     savedialog1.InitialDir:= file_save_path
     else
      savedialog1.InitialDir:= data_path+ 'dat';

    savedialog1.filename:= opened_file_name;
   savedialog1.FilterIndex:= 2;
if savedialog1.Execute then
 begin
   caption:= edit_caption+ ' --'+ savedialog1.FileName;
   application.Title:= ExtractFileName(savedialog1.FileName)+ ' - ��Ϸ�༭��';
  if FileExists(savedialog1.FileName) then
     deletefile(savedialog1.FileName);

  str1:= Tstringlist.Create;
   for i:= 0 to SynEditor1.lines.Count-1 do
    str1.Append(SynEditor1.lines.Strings[i]);

     save_upp_base(savedialog1.FileName, str1);

  str1.Free;
  Button2.Font.Style:= [];
  button3.Font.Style:= [];
  button6.Font.Style:= [];
  file_is_change:= false;
  statusbar1.Panels[0].Text:= '';
  
  if pos('Player',savedialog1.FileName)> 1 then
    if messagebox(handle,'���޸Ļ򴴽��������ļ������������������ļ����иĶ�����ô��Ҫ�޸Ķ����ļ���Ҫ�򿪶����ļ���',
                       'ѯ��',mb_yesno)= mryes then
    begin
     open_file_shell(data_path + 'persona\ext.upp');
    end;

 end; //end save

end;


procedure TForm1.Button4Click(Sender: TObject);
 var b: boolean;
begin
 b:= (GetKeyState(VK_SHIFT) < 0);
opendialog1.filename:='';
   if sender= label8 then
    begin
     opendialog1.InitialDir:= data_path+ 'persona';
    end else begin
   if (file_open_type= 2) and (file_save_path<> '') then
     opendialog1.InitialDir:= file_save_path
     else
      opendialog1.InitialDir:= data_path+ 'dat';
             end;
   opendialog1.FilterIndex:= 2;
if opendialog1.Execute then
 begin
    if file_is_change or b or (GetKeyState(VK_SHIFT) < 0) then
    open_file_shell(opendialog1.FileName )
   else
    open_file_upp(opendialog1.FileName);
 end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var b: boolean;
begin
b:= (GetKeyState(VK_SHIFT) < 0); //�ж��Ƿ���shift��
opendialog1.filename:='';
  if (file_open_type= 3) and (file_save_path<> '') then
     opendialog1.InitialDir:= file_save_path
     else
      opendialog1.InitialDir:= data_path;
   opendialog1.FilterIndex:= 3;
if opendialog1.Execute then
 begin
   if file_is_change or b or (GetKeyState(VK_SHIFT) < 0) then
    open_file_shell(opendialog1.FileName )
   else
   open_file_usp(opendialog1.FileName);
 end;


end;

procedure TForm1.Button6Click(Sender: TObject);
var str1: Tstringlist;
    i: integer;
    stream1: TMemoryStream;
begin
 syneditor1.InitCodeFolding;  //չ���۵��Ĵ���
savedialog1.filename:='';

   if (file_open_type= 3) and (file_save_path<> '') then
     savedialog1.InitialDir:= file_save_path
     else
      savedialog1.InitialDir:= data_path;

     savedialog1.filename:= opened_file_name;
   savedialog1.FilterIndex:= 3;
if savedialog1.Execute then
 begin
   caption:= edit_caption+ ' --'+ savedialog1.FileName;
   application.Title:= ExtractFileName(savedialog1.FileName)+ ' - ��Ϸ�༭��';
  if FileExists(savedialog1.FileName) then
     deletefile(savedialog1.FileName);

  str1:= Tstringlist.Create;
   for i:= 0 to SynEditor1.lines.Count-1 do
    str1.Append(SynEditor1.lines.Strings[i]);

    game_add_password(str1); //���ĵ���������
    
    str1.Append('Code=fuchengrong@hotmail.com'); //��Ӷ�����֤�ַ�

     str1.Append('Code='+ StrMD5(str1.text) );
      str1.Delete(str1.Count-2);
    stream1:= TMemoryStream.Create;
     str1.SaveToStream(stream1);
     stream1.Position:= 0;
    vclzip1.Password:= 'AGP2@3%N';
     vclzip1.ZipName:= savedialog1.FileName;
    vclzip1.ZipFromStream(stream1,savedialog1.FileName);

   // vclzip1.Zip;
   stream1.Free;
 // str1.SaveToFile(savedialog1.FileName);
  str1.Free;
  Button2.Font.Style:= [];
  button3.Font.Style:= [];
  button6.Font.Style:= [];
  file_is_change:= false;
  statusbar1.Panels[0].Text:= '';
  
   if messagebox(handle,'�����Ʒ�ı���иı䣬��ô��Ҫ�޸���Ӧ�ĵ����ļ��ͷ��������ļ�(Լ10���)���Ƿ������޸ģ�','ѯ��',
                mb_yesno)= mryes then
    begin
     for i:= 1 to 99 do
       if FileExists(data_path+ 'layer'+ inttostr(i)+'.upp') then
         open_file_shell(data_path + 'layer'+ inttostr(i)+'.upp');

     open_file_shell(data_path+ 'dat\const.upp');
    end;
 end; //end save

 

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
   rich_i:= SynEditor1.CaretY -1;
   if open_file_type= l_wupin then
      form2.show_type_i:= 3
      else
        form2.show_type_i:= 2;
   //form2.show_type_i:= file_open_type;
   form2.show_ss(SynEditor1.lines.Strings[rich_i]);

  form2.ShowModal;
end;

procedure TForm1.write_ss(s: string);
var ss: string;
begin
  ss:= SynEditor1.lines.Strings[SynEditor1.CaretY-1];
  ss:= copy(ss,1,pos('=',ss));
  ss:= ss+ s;
   SynEditor1.lines.Strings[SynEditor1.CaretY-1]:= ss;

   file_is_change:= true;
end;

procedure TForm1.Button8Click(Sender: TObject);
var ss: string;
    i,j: integer;
begin
 ss:= inputbox('���','�����ʾ�ţ����λ�ôӹ�������С�','');
 if ss<>'' then
  begin
try
  j:= strtoint(ss)
except
  showmessage('������������');
  exit;
end;
    for i:= SynEditor1.CaretY-1 to SynEditor1.lines.Count-1 do
     begin
      ss:= SynEditor1.lines.Strings[i];
      if ss= '' then
       continue;

      if (ss[1]= ';') or (ss[1]= '[') then
       Continue;
      if pos('=',ss)> 0 then
       delete(ss,1,pos('=',ss));

       ss:= inttostr(j)+ '=' + ss;
       SynEditor1.lines.Strings[i]:= ss;
       inc(j);
     end;
   form1.SynEditor1Change(sender); 
  end;
end;

function TForm1.read_ss_down: string;
begin
 if rich_I = SynEditor1.lines.Count then
    exit;

 inc(rich_i);
 form2.show_ss2(SynEditor1.lines.Strings[rich_i]);
end;

function TForm1.read_ss_up: string;
begin
 if rich_I = 0 then
  exit;

 dec(rich_i);
 form2.show_ss2(SynEditor1.lines.Strings[rich_i]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Manager.AddEditor(SynEditor1);
 if DirectoryExists(ExtractFilePath(application.ExeName)+'��Ϸ�ű�') then
   data_path:=  ExtractFilePath(application.ExeName)+'��Ϸ�ű�\'
    else if DirectoryExists(ExtractFilePath(application.ExeName)+'output') then
   data_path:=  ExtractFilePath(application.ExeName)+'output\'
    else
     data_path:=  ExtractFilePath(application.ExeName);

 load_password_set;

 if ParamCount > 0 then
   postmessage(handle, post_msg_id,29,0); //�򿪲���������ļ�

 SynCompletionProposal1.InsertList.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\insert.txt');
 SynCompletionProposal1.itemList.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\show.txt');

 caption:= edit_caption;

 help_list:= Tstringlist.Create;
 help_list.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\helptip.txt');
 open_file_list:= Tstringlist.Create;
 application.HintPause:= 2400;
 application.hinthidepause:= 8000;

 SetWindowLong(edit_kuan.Handle, GWL_STYLE, GetWindowLong(edit_kuan.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(edit_gao.Handle, GWL_STYLE, GetWindowLong(edit_gao.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(edit_touming.Handle, GWL_STYLE, GetWindowLong(edit_touming.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(edit4.Handle, GWL_STYLE, GetWindowLong(edit4.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(edit5.Handle, GWL_STYLE, GetWindowLong(edit5.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(edit7.Handle, GWL_STYLE, GetWindowLong(edit7.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(edit8.Handle, GWL_STYLE, GetWindowLong(edit8.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(edit9.Handle, GWL_STYLE, GetWindowLong(edit9.Handle, GWL_STYLE) or ES_NUMBER);

 map_name:= Tstringlist.Create;
end;

procedure TForm1.N56Click(Sender: TObject);
begin
 syneditor1.InitCodeFolding;
  syneditor1.Repaint;
end;

procedure TForm1.SynEditor1GutterClick(Sender: TObject;
  Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark;
  Region: Boolean);
begin
if Region then
 If Mark = nil Then
  SynEditor1.SetBookMark(SynEditor1.GetFirstFreeBookMark, SynEditor1.CaretX, Line)
 else
  SynEditor1.ClearBookMark(Mark.BookmarkNumber);


end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if button11.Enabled= false then
    begin
      case messagebox(handle,'��ǰ���Խ����У��Ƿ���ֹ��','����',mb_yesno or MB_ICONQUESTION) of
       mryes: form_debug.Close;
      // mrno:
       mrno: begin
                 canclose:= false;
                 exit;
                 end;
       end;
    end;

   if file_is_change then
    begin
      case messagebox(handle,'��ǰ�ļ��޸ĺ�û�б��棬�Ƿ񱣴棿','�����ļ�',mb_yesnocancel or MB_ICONQUESTION) of
       mryes: save_file;
      // mrno:
       mrcancel: canclose:= false;
       end;
    end;
end;

procedure TForm1.save_file;
begin
  case file_open_type of
  1: button2.Click;
  2: button3.Click;
  3: button6.Click;
  4: N72click(self);
   else
     button2.Click;
  end;
end;

procedure TForm1.SynEditor1Change(Sender: TObject);
begin
  file_is_change:= true;
  case file_open_type of
   1: button2.Font.Style:= [fsBold];
   2: button3.Font.Style:= [fsBold];
   3: button6.Font.Style:= [fsBold];
   end;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  self.Close;
end;

procedure TForm1.load_password_set;
var str1: Tstringlist;
begin
    {
       open_s_G,save_s_G: string;
  open_type_G,save_type_G: integer;
    }
     if not FileExists(ExtractFilePath(application.ExeName)+'highlighters\set.dat') then
      begin
       open_type_G:= 2;
       save_type_G:= 3;
       exit;
      end;

    str1:= Tstringlist.Create;
     str1.loadfromfile(ExtractFilePath(application.ExeName)+'highlighters\set.dat');
    if str1.Values['encrypt']<>'' then
       save_type_G := strtoint(str1.Values['encrypt']);


       save_s_G:= str1.Values['savepas']; //����ʱ�õ�����

       if str1.Values['dencrypt']<> '' then
          open_type_G:= strtoint(str1.Values['dencrypt']);

        open_s_G:= str1.Values['openpas']; //���ļ�ʱ�õ�����

        show_space:= (str1.Values['showspace']= '1');
   str1.Free;

end;

function TForm1.get_open_ps: string;
begin
  result:= game_dencrypt(open_s_G);
end;

function TForm1.get_save_ps: string;
begin
  result:= game_dencrypt(save_s_G);
end;

procedure TForm1.N60Click(Sender: TObject);
begin
  form_password.ShowModal;
end;

procedure TForm1.game_add_password(st1: Tstringlist);
var ss: string;
begin
ss:= '';
  case save_type_G of
  1: begin
      if save_s_G= '' then
       begin
        ss:= Input_password('���������룺 ','�������룺  ','');
        if ss= '' then
         exit;
       end else ss:= get_save_ps;
     end;
  2: begin
      if messagebox(handle,'�Ƿ�����ĵ���','ѯ��',mb_yesno)= mryes then
         begin
          ss:= Input_password('���������룺 ','�������룺  ','');
          if ss= '' then
           exit;

         end else exit;
     end;
  3: exit;
  end;

   if ss= '' then
     jiami_flag:= 1
     else
        jiami_flag:= 2;
        
  ss:= StrMD5(ss); //����任Ϊmd5��
   ss:= ';;game_password='+ ss;
  st1.Append(ss);
end;

function TForm1.game_check_password(st1: Tstringlist): boolean;
var ss: string;
    ss2: string;
    i,j: integer;
begin
result:= false;
   j:= st1.Count-5;  //�Ӻ���ǰ��5�У����û�о���û����������
   if j< 0 then
     j:= 0;

    for i:= st1.Count-1 downto j do
      if pos(';;game_password',st1.Strings[i])= 1 then
       begin
        ss:= st1.Strings[i]; //ȡ���ĵ��ڵ�����
        delete(ss,1,16);
        st1.Delete(i);  //ɾ��������
        break;
       end;

  if ss= '' then
   begin
   result:= true;
   exit;
   end;

      case open_type_G of
      1: begin
          ss2:= get_open_ps;
          if ss2= '' then
            begin
              ss2:= Input_password('���������룺 ','���ĵ������ܣ��������룺  ','');
            end;
         end;
      2: ss2:= Input_password('���������룺 ','���ĵ������ܣ��������룺  ','');
      end;
   if ss = StrMD5(ss2) then
    begin
    result:= true;
    if ss2= '' then
     caption:= caption + ' ���ܵ��ĵ���ע�⣬����ȫ�Ŀ�����'
     else
        caption:= caption + ' ���ܵ��ĵ�';
    end else
         st1.Clear;
end;

procedure TForm1.open_file_scene(const n: string; stt: Tstringlist=nil);
var str1: Tstringlist;
    i: integer;
    stream1: TMemoryStream;
    ss: string;
begin
 if stt= nil then
 begin
 file_save_path:= ExtractFiledir(n);
 opened_file_name:= ExtractFileName(n);
 caption:= edit_caption+ ' --'+ n;
 application.Title:= ExtractFileName(n)+ ' - ��Ϸ�༭��';
 
 ss:= ExtractFileDir(n);  //����¼��ļ����������¼��ļ�
 ss:= ExtractFileDir(ss);
  ss:= ExtractFileName(ss);
  if form_shijian.open_name<> ss then
   begin
    form_shijian.open_name:= ss;
    ss:= ExtractFilePath(application.ExeName) +'highlighters\' + ss + '.txt';
     if FileExists(ss) then
        form_shijian.open_file(ss);
   end;
str1:= Tstringlist.Create;
 end else str1:= stt;

    vclzip1.Password:= 'APP2433N';
     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
      vclzip1.UnZipToStream(stream1,ExtractFileName(n));
      // vclzip1.UnZip;
       str1.Clear;
       stream1.Position:= 0;
       str1.LoadFromStream(stream1);

       if stt<>nil then
          exit; //���ⲿ���ô˹���ʱ����������������

       if stream1.Size= 0 then
        begin
         showmessage('������Ч');
          stream1.Free;
          str1.Free;
         exit;
        end;

       ss:= trim(str1.Strings[0]) + '.ugm'; //��ȡ��һ���ַ���
       delete(ss,1,3);
        if CompareText(ss,ExtractFileName(n))<> 0 then
           begin
             showmessage('��Ϸ����ID��ƥ�䡣');
           end else begin
                     edit1.Text:= str1.Values['ID'];
                     ss:= str1.Strings[str1.count-1];
                     str1.Delete(str1.count-1);
                     str1.Append('Code=ufo2003a@gmail.com');

                     delete(ss,1,5);
                      if CompareStr( ss,StrMD5(str1.text))<> 0 then
                       begin
                         showmessage('��Ϸ�����ļ���Ч��');
                       end else begin
                                  str1.Delete(str1.count-1);
                                  SynEditor1.lines.Clear;

                                   if game_check_password(str1) then
                                    begin
                                      for i:= 0 to str1.count-1 do
                                        SynEditor1.lines.Append(str1.Strings[i]);

                                      file_open_type:= 1; //���ļ�����
                                      if not open_bk then  //����Ǻ���ǰ���ģ��������б�
                                         begin
                                         open_file_list.Insert(open_file_index,n); //����򿪵��ļ���
                                         inc(open_file_index);
                                         if open_file_index<> 1 then
                                            button15.Enabled:= true;
                                         end;

                                      open_bk:= false;
                                      
                                      Button2.Font.Style:= [];
                                      button3.Font.Style:= [];
                                      button6.Font.Style:= [];
                                    end else SynEditor1.lines.Append('�������');
                                end;
                    end;


   stream1.Free;
  str1.Free;
  statusbar1.Panels[0].Text:= '';
   syneditor1.InitCodeFolding;
   syneditor1.Repaint;
   syneditor1.SetFocus;

   open_file_type:= l_html;
   show_lift_page_type(open_file_type);
end;

procedure TForm1.open_file_upp(const n: string; stt: Tstringlist=nil);
var str1: Tstringlist;
    i: integer;
    stream1: TMemoryStream;
begin

    if stt=nil then
         begin
    file_save_path:= ExtractFiledir(n);     //����򿪵��ļ�·��
    opened_file_name:= ExtractFileName(n); //����򿪵��ļ���
    caption:= edit_caption+ ' --'+ n;
    application.Title:= ExtractFileName(n)+ ' - ��Ϸ�༭��';
    
    str1:= Tstringlist.Create;
    SynEditor1.lines.Clear;
    show_lift_page_type(open_file_type);
         end else str1:= stt;

    vclzip1.Password:= 'AGP2@3%N';
     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
      vclzip1.UnZipToStream(stream1,ExtractFileName(n));
      // vclzip1.UnZip;
       str1.Clear;
       stream1.Position:= 0;
       str1.LoadFromStream(stream1);
        stream1.Free;

         if stt<> nil then
           begin
           game_check_password(str1);
           exit;
           end;



       if game_check_password(str1) then
        begin
         file_open_type:= 2;
         Button2.Font.Style:= [];
         button3.Font.Style:= [];
         button6.Font.Style:= [];

           for i:= 0 to str1.count-1 do
               SynEditor1.lines.Append(str1.Strings[i]);

        end else SynEditor1.lines.Append('�������');


   
  str1.Free;
  statusbar1.Panels[0].Text:= '';
  syneditor1.InitCodeFolding;
  syneditor1.Repaint;
  syneditor1.SetFocus;
  if pos('guai.',n)> 0 then
     open_file_type:= l_guaiwu
     else if pos('\Player',n)> 0 then
     open_file_type:= l_renwu
     else
     open_file_type:= l_new;


end;

procedure TForm1.open_file_usp(const n: string; stt: Tstringlist=nil);
var str1: Tstringlist;
    i: integer;
    stream1: TMemoryStream;
    ss: string;
begin
      if stt=nil then
      begin
       file_save_path:= ExtractFiledir(n);
        opened_file_name:= ExtractFileName(n);
       caption:= edit_caption+ ' --'+ n;
       application.Title:= ExtractFileName(n)+ ' - ��Ϸ�༭��';
      str1:= Tstringlist.Create;
      end else str1:= stt;
    vclzip1.Password:= 'AGP2@3%N';
     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
      vclzip1.UnZipToStream(stream1,ExtractFileName(n));
      // vclzip1.UnZip;
       str1.Clear;
       stream1.Position:= 0;
       str1.LoadFromStream(stream1);
       if stt<> nil then
          exit;

                     ss:= str1.Strings[str1.count-1];
                     str1.Delete(str1.count-1);
                     str1.Append('Code=fuchengrong@hotmail.com');

                     delete(ss,1,5);
                      if CompareStr( ss,StrMD5(str1.text))<> 0 then
                       begin
                         showmessage('��Ϸ��Ʒ�ļ�ǩ����Ч��');
                       end else begin
                                  str1.Delete(str1.count-1);
                                   if stt=nil then
                                      SynEditor1.lines.Clear;

                                   if game_check_password(str1) then
                                     begin
                                      file_open_type:= 3;
                                      Button6.Font.Style:= [];
                                      button3.Font.Style:= [];
                                      button2.Font.Style:= [];
                                      if stt=nil then
                                       begin
                                        for i:= 0 to str1.count-1 do
                                        SynEditor1.lines.Append(str1.Strings[i]);
                                       end else stt.AddStrings(str1);
                                     end else SynEditor1.lines.Append('�������');
                                end;



   stream1.Free;
  str1.Free;
  statusbar1.Panels[0].Text:= '';
  syneditor1.InitCodeFolding;
  syneditor1.Repaint;
  syneditor1.SetFocus;

  open_file_type:= l_wupin; //������Ʒ�ļ�
  show_lift_page_type(open_file_type);

end;

procedure TForm1.RC_post_message(var msg: TMessage);
var i: integer;
begin
 if msg.WParam= 29 then
  begin
    //�򿪲���������ļ�
   for i:= 1 to ParamCount do
    begin
     if FileExists(ParamStr(i)) then
       begin
         if i= 1 then
           open_file_all(ParamStr(i))
           else
             open_file_shell(ParamStr(i));
       end;
    end;
  end;

 if msg.WParam= 39 then
   begin
   statusbar1.Panels[0].Text:= inttostr(syneditor1.CaretY)+ ': '+inttostr(syneditor1.CaretX);
     show_lift_page_type(open_file_type); //��ʾ��ߵ�����
   end;
end;

procedure TForm1.open_file_all(const n: string);
begin
 if uppercase(ExtractFileExt(n))='.UGM' then
    open_file_scene(n)
    else if uppercase(ExtractFileExt(n))='.UPP' then
      open_file_upp(n)
       else if uppercase(ExtractFileExt(n))='.USP' then
          open_file_usp(n)
           else if uppercase(ExtractFileExt(n))='.TXT' then
                   begin
                     SynEditor1.lines.Clear;
                     SynEditor1.lines.LoadFromFile(n);
                     file_open_type:= 4;
                      if (ExtractFileName(n)= 'new_scene.txt') or (ExtractFileName(n)= 'new_mg.txt') then
                        begin
                         SynEditor1.lines.Values['id']:= get_scene_id;
                         syneditor1.InitCodeFolding;
                         syneditor1.Repaint;
                         file_open_type:= 1;
                         open_file_type:= l_html;
                        end else  begin
                                   caption:= edit_caption+ ' --'+ n;
                                   application.Title:= ExtractFileName(n)+ ' - ��Ϸ�༭��';
                                   end;
                     if (syneditor1.Lines.Count>0) and (pos('��ͼ=',syneditor1.Lines.Strings[0])>0) then
                        open_file_type:= l_jianmo;
                   end;

  file_is_change:= false;
end;

procedure TForm1.open_file_shell(const n: string);
begin
 WinExec(pchar(application.exename +' "'+ n+'"'),SW_SHOWNORMAL);
end;

procedure TForm1.Button9Click(Sender: TObject);
var i: integer;
begin
  if file_open_type<> 2 then
   begin
    if messagebox(handle,'��ǰ���ܲ��Ǻ��ʵ������ļ����Ƿ�༭��','ѯ��',mb_yesno)= mrno then
       exit;
   end;

  for i:= 1 to SynEditor1.lines.Count- 1 do
    form_p_edit.StringGrid1.Cells[1,i]:= SynEditor1.lines.Strings[i];

   if form_p_edit.ShowModal= mrok then
     form1.SynEditor1Change(sender);
end;

function TForm1.read_ss_down_2: string;
begin
   if rich_I = SynEditor1.lines.Count then
    exit;

   read_ss_down;
    SynEditor1.CaretY := rich_I+ 1;
end;

function TForm1.read_ss_up_2: string;
begin
   if rich_I = 0 then
    exit;

   read_ss_up;
    SynEditor1.CaretY := rich_I+ 1;
end;

procedure TForm1.Button10Click(Sender: TObject);  //�½������ļ�
begin
  if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
    begin
     { case messagebox(handle,'��ǰ�ļ��޸ĺ�û�б��棬�Ƿ񱣴棿','�����ļ�',mb_yesnocancel or MB_ICONQUESTION) of
      mryes: save_file;
      mrcancel: exit;
      end;  }
      open_file_shell(ExtractFilePath(application.ExeName)+'highlighters\new_scene.txt');
      exit;
    end;

  SynEditor1.Lines.Clear;
  SynEditor1.lines.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\new_scene.txt');
  SynEditor1.lines.Values['id']:= get_scene_id;

   syneditor1.InitCodeFolding;
  syneditor1.Repaint;

  file_is_change:= false;
  opened_file_name:= '';
  caption:= edit_caption;
  application.Title:= edit_caption;

  open_file_type:= l_shuxing; //�½��˳����ļ�
end;

function TForm1.get_scene_id: string;
var i:array[0..2] of integer;
    label pp;
begin
screen.Cursor:= crhourglass;
result:= '10001';

   i[0]:= 20000;
   i[1]:= 16000;
   i[2]:= 10000;
   pp:
   if FileExists(data_path+'scene\'+ inttostr(i[1])+ '.ugm') then
    begin
     i[2]:= i[1];
     i[1]:= (i[0]- i[1]) div 2 + i[1];
     i[0]:= i[0] * 2;
      goto pp;
    end else begin  //������
              if i[1]-i[2]> 1 then
               begin
              i[0]:= i[1];
              i[1]:=i[1]- (i[1]- i[2]) div 2;
               goto pp;
               end;
             end;

       result:= inttostr(i[1]);
       screen.Cursor:= crdefault;

end;

procedure TForm1.N27Click(Sender: TObject);
begin
 SynEditor1.lines.Values['id']:= get_scene_id;
  SynEditor1Change(sender); //�ļ�����
end;

function TForm1.spell_scene(need_h: boolean): boolean;
     procedure spell_prc(ppp: integer);
      var ss: string;
        ppp2: integer;
      begin
        ss:= '>';
        for ppp2:= 2 to ppp do
           ss:= ss+ '>';
        StatusBar1.Panels[0].Text:= '�﷨�����ȣ�'+ ss;
        application.ProcessMessages;
      end;
     function get_h_color(cl: integer): Tcolor;
      begin
        case cl mod 20 of
        0: result:= $FFF0F5;
        1: result:= $FFC0CB;
        2: result:= $D8BFD8;
        3: result:= $E6E6FA;
        4: result:= $FFFACD;
        5: result:= $7B68EE;
        6: result:= $DDA0DD;
        7: result:= $87CEEB;
        8: result:= $00BFFF;
        9: result:= $AFEEEE;
        10: result:=$98FB98;
        11: result:= $ADFF2F;
        12: result:= $BDB76B;
        13: result:= $EEE8AA;
        14: result:= $F0E68C;
        15: result:= $D3D3D3;
        16: result:= $C0C0C0;
        17: result:= $FFE4B5;
        18: result:= $FFEFD5;
        19: result:= $FFDAB9;
        else
         result:= $FFF0F5;
       end;
      end;
var i,j,pd2,pd3,pd_d,j2: integer;
    area,p_start,p_end: integer;
    b,b2,b_script,b_s_skip: boolean;
    ss_text: string;
begin
result:= false;
b:= false;
b2:= false; //�Ƿ���ע�Ͷ���
 p_end:= 0; //java�ű�����
 p_start:= 0;
 b_script:= false;
 b_s_skip:= false;


  //�����ļ����﷨����
  {
  1�����id�����Ե���
  2������������䣬�����Ϸ���
  3���������������������Ϸ�
  4��������ķֺŲ���
  }
  pd2:= 0; //�������
  pd3:= 0;  //���������
  pd_d:= 0; //���������

  if not is_number(SynEditor1.lines.Values['id']) then
     begin
       messagebox(handle,'ID����Ϊ�գ��ұ���������','����',mb_ok or MB_ICONWARNING);
       exit;
     end;

  if SynEditor1.lines.Values['����']<> '' then
    begin
     if not is_number(SynEditor1.lines.Values['����']) then
       begin
         messagebox(handle,'���Ա���������','����',mb_ok or MB_ICONWARNING);
         exit;
       end;
    end;

     spell_prc(1);  //��ʾ����

    syneditor1.InitCodeFolding;  //չ���۵��Ĵ���
    ss_text:= SynEditor1.lines.Text;

    if FastPosNoCase(ss_text,'<script',length(ss_text),
                             7,1) > 0 then  b_script:= true;

            {���Ҵ��������}
     spell_prc(10);  //��ʾ����

    for i:= 2 to length(ss_text) do
      begin
        if b2 then //����ע����
         begin
          if ss_text[i]= #13 then
             b2:= false;
             Continue;
         end;

       if ss_text[i]= '{' then
          inc(pd_d)
           else if ss_text[i]= '}' then
                 dec(pd_d)
                 else if (ss_text[i-1]= ';')and (ss_text[i]= ';') then
                         b2:= true;

      end; //end for
       spell_prc(20);  //��ʾ����
     if pd_d<> 0 then
      begin
        messagebox(handle,'{}���Ҵ����Ų���ԣ�һ����{�������Ӧ��һ����}�������ڴ����ű�ǿ��Կ��У����δ�ܶ�λ������У�����ϸ��顣','����',mb_ok or MB_ICONWARNING);
        exit;
      end;
          {����if end ���}
          area:= 0;
          if b_script then //���ҽű�λ��
          begin
          p_start:= FastPosNoCase(ss_text,'<script',length(ss_text),
                             7,1);

          if p_start> 0 then
           begin
            p_end:= FastPosNoCase(ss_text,'</script',length(ss_text),
                             8,p_start);
            if p_end= 0 then
             begin
              messagebox(handle,'��ǰ�е�<scriptû���ҵ�ƥ��ġ�</script��java����vb�ű�û��������������ע�⣬��</script��֮�䲻���пո�','����',mb_ok or MB_ICONWARNING);
                SynEditor1.SelStart:= p_start;
                exit;
             end;
           end;
          end;
      spell_prc(30);  //��ʾ����
      for i:= 2 to length(ss_text)-3 do
      begin
        if (i < p_end) and (i > p_start)  then
           Continue; //���Խű�

        if (p_end > 0) and (i > p_end) then
         begin
           //�ڽű����棬�ٴβ��ҿ��Ƿ����µĽű�
           spell_prc(35);  //��ʾ����
           p_start:= FastPosNoCase(ss_text,'<script',length(ss_text),
                             7,p_end);
          p_end:= 0;
          if p_start> 0 then
          p_end:= FastPosNoCase(ss_text,'</script',length(ss_text),
                             8,p_start);
         end;

        if b2 then //����ע����
         begin
          if ss_text[i]= #13 then
             b2:= false;
             Continue;
         end;

       if char_not_in_az(ss_text[i-1]) and(UpCase(ss_text[i])= 'I') and
         (UpCase(ss_text[i+1])= 'F') and char_not_in_az(ss_text[i+2])then
          begin
          inc(pd_d);
          //����if ��
          if need_h then
            begin
             SynEditor1.SelStart:= i;
             SynEditor1.SetLineColor(SynEditor1.CaretY-1,clwindowtext,get_h_color(pd_d));
            end;
          if pd_d=1 then
             area:= i;
          end else if need_h and char_not_in_az(ss_text[i-1]) and(UpCase(ss_text[i])= 'E') and
                 (UpCase(ss_text[i+1])= 'L') and (UpCase(ss_text[i+2])= 'S')
                 and (UpCase(ss_text[i+3])= 'E') and char_not_in_az(ss_text[i+4]) then
                   begin
                     // ����else ��
                     if need_h then
                      begin
                       SynEditor1.SelStart:= i;
                       SynEditor1.SetLineColor(SynEditor1.CaretY-1,clwindowtext,get_h_color(pd_d));
                      end;
                   end else
                 if char_not_in_az(ss_text[i-1]) and(UpCase(ss_text[i])= 'E') and
                 (UpCase(ss_text[i+1])= 'N') and (UpCase(ss_text[i+2])= 'D')
                 and char_not_in_az(ss_text[i+3]) then
                 begin
                  //����
                  if need_h then
                      begin
                       SynEditor1.SelStart:= i;
                       SynEditor1.SetLineColor(SynEditor1.CaretY-1,clwindowtext,get_h_color(pd_d));
                      end;
                 dec(pd_d);
                 if pd_d< 0 then
                    area:= i;
                 end else if (ss_text[i-1]= ';')and (ss_text[i]= ';') then
                         b2:= true;

       if pd_d< 0 then
        begin
         SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ���������ڴ������end �ؼ���û�ж�Ӧ��if������if ��end ����һһ��Ӧ��','����',mb_ok or MB_ICONWARNING);
         exit;
        end;
      end; //end for

     if pd_d > 0 then
      begin
        SynEditor1.SelStart:= area;
        messagebox(handle,'��ǰ���������ڵĴ������if �ؼ��ֺ� end�ؼ��ֲ���ԣ�һ��if�����Ӧ��һ��end����','����',mb_ok or MB_ICONWARNING);
        exit;
      end;

      spell_prc(40);  //��ʾ����

      {����if then ���}
      area:= 0;
        if b_script then //���ҽű�λ��
          begin
          p_start:= FastPosNoCase(ss_text,'<script',length(ss_text),
                             7,1);
                             
          p_end:= 0;
          if p_start> 0 then
          p_end:= FastPosNoCase(ss_text,'</script',length(ss_text),
                             8,p_start);
          end;

      for i:= 2 to length(ss_text)-4 do
      begin
        if (i < p_end) and (i > p_start)  then
           Continue; //���Խű�

        if (p_end > 0) and (i > p_end) then
         begin
           //�ڽű����棬�ٴβ��ҿ��Ƿ����µĽű�
           spell_prc(45);  //��ʾ����
           p_start:= FastPosNoCase(ss_text,'<script',length(ss_text),
                             7,p_end);
           p_end:= 0;
          if p_start> 0 then
          p_end:= FastPosNoCase(ss_text,'</script',length(ss_text),
                             8,p_start);
         end;

        if b2 then //����ע����
         begin
          if ss_text[i]= #13 then
             b2:= false;
             Continue;
         end;

       if char_not_in_az(ss_text[i-1]) and(UpCase(ss_text[i])= 'I') and
         (UpCase(ss_text[i+1])= 'F') and char_not_in_az(ss_text[i+2])then
          begin
          inc(pd_d);
           if pd_d= 1 then
              area:= i; //����ǰ���if�������ֵΪ2������1��ʱ��û��then��Ӧ
          end else if char_not_in_az(ss_text[i-1]) and(UpCase(ss_text[i])= 'T') and
                 (UpCase(ss_text[i+1])= 'H') and (UpCase(ss_text[i+2])= 'E')
                 and (UpCase(ss_text[i+3])= 'N')and char_not_in_az(ss_text[i+4]) then
                 dec(pd_d)
                 else if (ss_text[i-1]= ';')and (ss_text[i]= ';') then
                         b2:= true;

       if (pd_d= 2) or (pd_d< 0) then
        begin
           SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ�����е�if �ؼ��ֺ� then�ؼ��ֲ���ԣ�һ��if�����Ӧ��һ��then����','����',mb_ok or MB_ICONWARNING);
         exit;
        end;
      end; //end for

      if (pd_d= 1) or (pd_d< 0) then
        begin
          SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ�����е�if �ؼ��ֺ� then�ؼ��ֲ���ԣ�һ��if�����Ӧ��һ��then����','����',mb_ok or MB_ICONWARNING);
         exit;
        end;
        spell_prc(50);  //��ʾ����
        {����<: :>���}
      area:= 0;
      for i:= 2 to length(ss_text)-1 do
      begin
        if b2 then //����ע����
         begin
          if ss_text[i]= #13 then
             b2:= false;
             Continue;
         end;

       if (UpCase(ss_text[i])= '<') and
         (UpCase(ss_text[i+1])= ':') then
          begin
          inc(pd_d);
           if pd_d= 1 then
              area:= i; //����ǰ���if�������ֵΪ2������1��ʱ��û��then��Ӧ
          end else if (UpCase(ss_text[i])= ':') and
                 (UpCase(ss_text[i+1])= '>')    then
                 begin
                 dec(pd_d);
                   if pd_d< 0 then
                       area:= i;
                 end else if (ss_text[i-1]= ';')and (ss_text[i]= ';') then
                         b2:= true;

       if (pd_d= 2) then
        begin
           SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ�����е�<:���û�ж�Ӧ�Ľ�����ǡ�:>����','����',mb_ok or MB_ICONWARNING);
         exit;
        end else
       if (pd_d< 0) then
        begin
           SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ�����е�:>���û���ҵ���Ӧ�Ŀ�ʼ��ǡ�<:����','����',mb_ok or MB_ICONWARNING);
         exit;
        end;
      end; //end for
       
      if (pd_d= 1) then
        begin
           SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ�����е�<:���û�ж�Ӧ�Ľ�����ǡ�:>����','����',mb_ok or MB_ICONWARNING);
         exit;
        end else
       if (pd_d< 0) then
        begin
           SynEditor1.SelStart:= area;
         messagebox(handle,'��ǰ�����е�:>���û���ҵ���Ӧ�Ŀ�ʼ��ǡ�<:����','����',mb_ok or MB_ICONWARNING);
         exit;
        end;
       spell_prc(60);  //��ʾ����
    area:= 0;
  for i:= 0 to SynEditor1.lines.Count- 1 do
   begin
     if SynEditor1.lines.Strings[i]='' then
        Continue;
     if pos(';;',SynEditor1.lines.Strings[i])> 0 then
        Continue;
     if b_script then
      begin
       if b_s_skip= false then
        begin
        if FastPosNoCase(SynEditor1.lines.Strings[i],'<script',length(SynEditor1.lines.Strings[i]),
                             7,1)> 0 then
                             b_s_skip:= true;
        end else begin
                  if FastPosNoCase(SynEditor1.lines.Strings[i],'</script',length(SynEditor1.lines.Strings[i]),
                             8,1)> 0 then
                              b_s_skip:= false;
                   Continue; //����           
                 end;
      end;
     if area> 0 then
      begin
       if trim(SynEditor1.lines.Strings[i])='}' then
        begin
         area:= 0; //�����Ҵ�����ʱ��Ϊ�㣬��ʾ�˳�����
         Continue;
        end;
         //������ķֺŲ���
          for j:= 1 to length(SynEditor1.lines.Strings[i]) do
             begin
               if SynEditor1.lines.Strings[i][j]= ')' then
                  b:= true
                  else if SynEditor1.lines.Strings[i][j]= 'g' then
                          begin
                           if b then
                            begin
                              SynEditor1.CaretY:= i+ 1;
                              SynEditor1.CaretX:= j+ 1;
                               messagebox(handle,'��������еĺ����뺯��֮������÷ֺŸ�����','����',mb_ok or MB_ICONWARNING);
                               exit;
                            end;
                          end else if SynEditor1.lines.Strings[i][j]<> ' ' then
                                      b:= false;
             end; //end for j
                                 {�����������}
             j2:= 0;
          for j:= 1 to length(SynEditor1.lines.Strings[i]) do
           begin
             if SynEditor1.lines.Strings[i][j]= '(' then
                begin
                inc(pd2);
                if pd2= 1 then
                   j2:= j;
                end else if SynEditor1.lines.Strings[i][j]= ')' then
                         begin
                           dec(pd2);
                          if pd2< 0 then
                           begin
                             SynEditor1.CaretY:= i+ 1;
                             SynEditor1.CaretX:= j+ 1;
                             messagebox(handle,'��������еĺ����������ֵ����Ų���ԡ�ȱ�������š�','����',mb_ok or MB_ICONWARNING);
                             exit;
                           end;
                         end;
           end; //enf for j

                if pd2> 0 then
                  begin
                   SynEditor1.CaretY:= i+ 1;
                   SynEditor1.CaretX:= j2 + 1;
                   messagebox(handle,'��������еĺ����������ֵ����Ų���ԡ�ȱ��������','����',mb_ok or MB_ICONWARNING);
                     exit;
                  end;

          case area of
           2: begin


              end; //end 2
           3: begin
                //�ѵ��ں�ǰ��Сд��ĸת��д���ո����
                SynEditor1.lines.Strings[i]:= up_and_clean_space(SynEditor1.lines.Strings[i]);
                //�����ںź����Ƿ�����
                  j:= fastcharpos(SynEditor1.lines.Strings[i],'=',1);
                  if j> 0 then
                   begin
                     if not(SynEditor1.lines.Strings[i][j+1] in['0'..'9']) and
                          (SynEditor1.lines.Strings[i][j+1]<>'[')  then
                      begin
                      SynEditor1.CaretY:= i+ 1;
                      SynEditor1.CaretX:= j+ 1;
                      messagebox(handle,'��������еĵ��ںź���������ֻ��ߡ�[����','����',mb_ok or MB_ICONWARNING);
                     exit;
                       end;
                   end;

                 //���������
               j:= fastcharpos(SynEditor1.lines.Strings[i],'[',1); //����������
         while j> 0 do
          begin
            inc(pd3);
            j:= fastcharpos(SynEditor1.lines.Strings[i],'[',j+1);
          end;
         j:= fastcharpos(SynEditor1.lines.Strings[i],']',1); //����������
         while j> 0 do
          begin
           if not(SynEditor1.lines.Strings[i][j+1] in['0'..'9']) then
              begin
               SynEditor1.CaretY:= i+ 1;
               SynEditor1.CaretX:= j+ 1;
               messagebox(handle,'��������еķ��š�]��������������֣��Ի������кţ���','����',mb_ok or MB_ICONWARNING);
               exit;
              end;
            dec(pd3);
             if pd3 < 0 then
              begin
               SynEditor1.CaretY:= i+ 1;
               SynEditor1.CaretX:= j+ 1;
               messagebox(handle,'������������ڰ������������š�[ ]������ԡ�ȱ��������"["','����',mb_ok or MB_ICONWARNING);
               exit;
              end;
            j:= fastcharpos(SynEditor1.lines.Strings[i],']',j+1);
          end;
                   if pd3 > 0 then
                        begin
                         SynEditor1.CaretY:= i+ 1;
                         SynEditor1.CaretX:= fastcharpos(SynEditor1.lines.Strings[i],'[',1)+ 1;
                          messagebox(handle,'������������ڰ������������š�[ ]������ԡ�ȱ��������"]"','����',mb_ok or MB_ICONWARNING);
                        exit;
                        end;
              end; //end 3
           end;
      end else begin
                
                    if pos('����=',SynEditor1.lines.Strings[i])> 0 then
                     begin
                      if length(trim(SynEditor1.lines.Strings[i]))> 5 then
                        begin
                         SynEditor1.CaretY:= i+ 1;
                         messagebox(handle,'������=���ؼ�������ռһ�У�ǰ�����������ַ�','����',mb_ok or MB_ICONWARNING);
                         exit;
                        end;
                      if trim(SynEditor1.lines.Strings[i+1])<>'{' then
                                begin
                                 SynEditor1.CaretY:= i+ 2;
                                 messagebox(handle,'������=���ؼ���ǵ���һ�б����ǡ�{���Ҳ����������ַ� ','����',mb_ok or MB_ICONWARNING);
                                 exit;
                                end;
                               area:= 1; //����1��ʾ�����˶�����
                     end;
               if pos('����=',SynEditor1.lines.Strings[i])> 0 then
                     begin
                      if length(trim(SynEditor1.lines.Strings[i]))> 5 then
                        begin
                         SynEditor1.CaretY:= i+ 1;
                         messagebox(handle,'������=���ؼ�������ռһ�У�ǰ�����������ַ�','����',mb_ok or MB_ICONWARNING);
                         exit;
                        end;
                       if trim(SynEditor1.lines.Strings[i+1])<>'{' then
                                begin
                                 SynEditor1.CaretY:= i+ 2;
                                 messagebox(handle,'������=���ؼ���ǵ���һ�б����ǡ�{���Ҳ����������ַ� ','����',mb_ok or MB_ICONWARNING);
                                 exit;
                                end;
                               area:= 2; //����2��ʾ������������
                     end;
                     if pos('�Ի���Դ=',SynEditor1.lines.Strings[i])> 0 then
                     begin
                      if length(trim(SynEditor1.lines.Strings[i]))> 9 then
                        begin
                         SynEditor1.CaretY:= i+ 1;
                         messagebox(handle,'���Ի���Դ=���ؼ�������ռһ�У�ǰ�����������ַ�','����',mb_ok or MB_ICONWARNING);
                         exit;
                        end;
                       if trim(SynEditor1.lines.Strings[i+1])<>'{' then
                                begin
                                 SynEditor1.CaretY:= i+ 2;
                                 messagebox(handle,'���Ի���Դ=���ؼ���ǵ���һ�б����ǡ�{���Ҳ����������ַ� ','����',mb_ok or MB_ICONWARNING);
                                 exit;
                                end;
                               area:= 3; //����3��ʾ�����˶Ի���
                     end;
             end; //end if area
   end; //end for
    spell_prc(70);  //��ʾ����
    result:= true;


end;

function TForm1.is_number(const s: string): boolean;
var i: integer;
begin

if s= '' then
 begin
  result:= false;
  exit;
 end;

  for i:= 1 to length(s) do
     if not (s[i] in['0'..'9']) then
       begin
         result:= false;
         exit;
       end;

 result:= true;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  screen.Cursor:= crhourglass;
     if spell_scene(false) then
      messagebox(handle,'���ͨ������ע�⣬�Ժ����Ĳ���û�м�飩��','�﷨���',mb_ok or MB_ICONINFORMATION);
  screen.Cursor:= crdefault;
  statusbar1.Panels[0].Text:= '';
end;

procedure TForm1.N70Click(Sender: TObject);
begin
ShellAbout(form1.Handle,pchar('��Ϸ�����༭��'),pchar('���ߣ�������'),Application.icon.handle);
end;

procedure TForm1.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.panels[0].text :=Application.hint;

end;

procedure TForm1.create_npc_chat(s: string);
var ss,ss3: string;
    i,c,m1,m2: integer;
    str1: Tstringlist;
begin
      {
       ����ѡ������ĶԻ���ܡ�
       1����Ҫѡ��һ�����
       2���������ڳ����ļ�����������
      }
  c:= 0; //�Ի��ε��к�
  m1:= 0; //�����ο�ʼ
  m2:= 0; //�����ν�����

   if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'������϶�������ѡ��һ��������','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end else if syneditor1.SelLength> 16 then
               begin
                if messagebox(handle,'ѡ�е����ֹ������Ƿ������','��ʾ',mb_yesno or MB_ICONWARNING)= mrno then
                   exit;
               end;


    with syneditor1.Lines do
     begin
   for i:= 0 to Count- 1 do
    begin
     // ɨ���Ƿ�����������
      if fastpos(strings[i],'����=',length(strings[i]),5,1)>0 then
        m1:= i
         else if fastpos(strings[i],'�Ի���Դ=',length(strings[i]),9,1)>0 then
                begin
                  m2:= i;
                  c:= i;
                  break;
                end;
    end;
     end;

    if (syneditor1.CaretY <= m1) or (syneditor1.CaretY >= m2) then
      begin
       messagebox(handle,'ֻ���ڡ�������������ִ�д�������Ի�������','��ʾ',mb_ok or MB_ICONWARNING);
       exit;
      end;

  ss:= syneditor1.SelText;
 // ss2:= syneditor1.LineText; //�õ���ǰ������

  //  delete(ss2,syneditor1.CaretX-length(ss),length(ss));
   if s= '' then
   //���������Ի�
   ss3:= '<a href="game_npc_talk(''' + ss + ''')">'+ ss + '</a>'
   else begin
          //��������
          if (edit5.Text= '') or (edit5.Text='0') then
           ss3:= '<a href="game_npc_talk(''' + ss + ''')">'+ ss + '</a>'
           else begin
                 ss3:= '<a href="if game_grade(''����'','+
                       edit5.Text + ') or game_check_role_values(''����'',19,'+
                       inttostr(strtoint(edit5.Text)* 500)+') then game_chat(''��������'+edit5.Text +'�����ڣ����ĵȼ����߻��߾���ֵ���࣬���񱻾ܾ���'') else  game_npc_talk(''' +
                       ss + ''') end">'+ ss + '</a>';
                end;
        end;
    syneditor1.SelText:= ss3;

   file_is_change:= true;
   
    show_code;  //չ���۵��Ĵ��� ���˺������ᱣ��ԭʼ�к�
   //д��Ի���
    if c > 0 then
     begin
      for i:= syneditor1.Lines.Count -1 downto c do
          if pos('}',syneditor1.Lines.Strings[i])> 0 then
           begin
             c:= i;
             break;
           end;

     // syneditor1.Lines.Insert(c,ss+ '=1,');
     // syneditor1.Lines.Insert(c+1,'I=1,');
        if s='' then
        begin
        ss:= ss+ '=1,';
        syneditor1.Lines.Strings[c]:= ss ;
        syneditor1.Lines.Append('I=1,');
        
        end else begin
                   s:=StringReplace(s,'$����$',ss,[rfReplaceAll]);
                   str1:= Tstringlist.Create;
                   str1.Text:=s;
                   syneditor1.Lines.Strings[c]:= '' ;
                   syneditor1.Lines.AddStrings(str1);

                   str1.Free;
                 end;
       syneditor1.Lines.Append('}');
       syneditor1.CaretY:= c + 1;
      SendMessage(syneditor1.Handle, WM_VSCROLL, SB_BOTTOM, 0);
        syneditor1.CaretX:= length(ss)+1;
        syneditor1.InitCodeFolding;  //չ���۵��Ĵ��룬�����ػ��۵���
     end; //if c
end;

procedure TForm1.N76Click(Sender: TObject);
begin
 create_npc_chat(''); //�Զ�����npc����ĶԻ����
end;

procedure TForm1.create_next_char(flag: integer);    //������һ���ĶԻ�
     function Is_end_char(s: string): boolean;
      begin
        s:= trim(s);
        if (s= '') or
           (Comparetext(s,'end')= 0) or
           (Comparetext(s,'else')= 0) or
           (s='{') or
           (s='}') or
           (FastPosNoCase(s,'if',length(s),2,1)= 1) then
           Is_end_char:= true
           else
            Is_end_char:= false;
      end;
     function is_not_i_n(const s,n: string): boolean; //���ҵ���һ������ʱΪtrue
      var i2: integer;
      begin
       is_not_i_n:= true;
        i2:= fastcharpos(s,'=',1);
        if i2> 0 then
          begin
           if flag >1 then
            begin
             if (pos(n,s)=0) or (pos(n,s)> i2) then
              exit;   //flagΪ2ʱ���ҵ����Ǳ��˵ĶԻ��ͽ���
            end;
          if (FastCharPosNoCase(s,'i',1)< i2) and (FastCharPosNoCase(s,'i',1)> 0) then
              is_not_i_n:= false
              else if (pos(n,s)< i2) and (pos(n,s)> 0) then
                   is_not_i_n:= false;
          end; //end i2> 0
      end;
     function find_first(const s,n: string; var b2: boolean): boolean;
      var i2: integer;
      begin //���ϲ��ҶԻ��Ŀ�ͷ��
        find_first:= false;
        i2:= fastcharpos(s,'=',1);
         if i2> 0 then
          if (FastCharPosNoCase(s,'i',1)< i2) and (FastCharPosNoCase(s,'i',1)> 0) then
            begin
              if b2 then
                find_first:= true;
            end else if (pos(n,s)< i2) and (pos(n,s)> 0) then
                        b2:= true;
      end;
     function get_head_string(const s: string; bb: boolean=false): string; //��ȡ�ı��Ŀ�ʼ���ݣ�������id
      var i2,i3: integer;
      begin
        i2:= fastcharpos(s,']',1); //���Ȳ�����������
         if i2= 0 then
            i2:= fastcharpos(s,'=',1); //���û���������ţ���ô���ҵ��ں�

         if i2= 0 then
            i3:= fastcharpos(s,',',1)
            else
              i3:= fastcharpos(s,',',i2);
              
          if i3> i2 then
           i3:= strtoint(copy(s,i2+ 1,i3-i2-1));

           if bb then //bbΪtrue����ʾ���һλ��ͬ����
            result:= copy(s,1,fastcharpos(s,'=',1))+ inttostr(i3)+ ','
           else
           result:= copy(s,1,fastcharpos(s,'=',1))+ inttostr(i3+ 1)+ ',';
      end;
var ss2,ss_npc,ss_next,ss_next2: string;
    i,c,last1,first1,y: integer;
    b,b_i: boolean;
begin
    c:= 0; //�Ի��εĲ����к�
    // show_code; //չ���۵��Ĵ���

    with syneditor1.Lines do
     begin
      for i:= syneditor1.CaretY-1 downto 0 do
        begin
        // ɨ���Ƿ��ڶԻ�����
          if fastpos(strings[i],'�Ի���Դ=',length(strings[i]),9,1)>0 then
                begin
                  c:= i;
                  break;
                end;
        end;
     end;


    if (syneditor1.CaretY <= c) or (c= 0) then
      begin
       if flag= 2 then
        begin
         syneditor1.CaretX:= length(syneditor1.LineText)+ 1;
         syneditor1.SelText:= #13;
         syneditor1.LineText:= syneditor1.Lines.Strings[syneditor1.CaretY-2];
        end else begin
                   messagebox(handle,'ֻ���ڡ��Ի���Դ�������ڴ�����һ���Ի���','��ʾ',mb_ok or MB_ICONWARNING);
                  
                 end;
        exit;
      end;

      {
       ���������������л��� if��else��end �Ҵ����ŵ�Ϊֹ�������к�
       ���Ŵ�����кſ�ʼ���������������Ի�id������߹ؼ���ʱ��ֹ
       Ȼ����������к������ڵ�̸��id��������������̸��id��1

      }

   last1:= 0;
   first1:= 0;

   
   ss_npc:= '';
     //��ȡ���ں�ǰ�ĶԷ���������
    for i:= syneditor1.CaretY-1 downto c do
     begin
      if trim(syneditor1.LineS.Strings[i])= '' then
         Continue; //��������

      ss2:= trim(copy(syneditor1.Lines.Strings[i],1,fastcharpos(syneditor1.Lines.Strings[i],'=',1))); //���ں�ǰ������
      if ss2<> '' then
       begin
        if flag> 1 then
         begin
          if fastcharpos(ss2,',',1)> 0 then
              ss_npc:= copy(ss2,1,fastcharpos(ss2,',',1)-1)
              else
                 ss_npc:= copy(ss2,1,length(ss2)-1); //ɾ�����ĵ��ں�
          break;  //������flagģʽ�£�ֻ���ȡ��������
         end;
        if (ss2[1]<> 'i') and (ss2[1]<>'I') then
          begin
           if fastcharpos(ss2,',',1)> 0 then
              ss_npc:= copy(ss2,1,fastcharpos(ss2,',',1)-1)
              else
                 ss_npc:= copy(ss2,1,length(ss2)-1); //ɾ�����ĵ��ں�
           break;
          end;
       end; //end if
     end; //end for

     if ss_npc= '' then
      begin
        messagebox(handle,'���������һ����Ч�ĶԻ����ϣ������ܴ�����һ���Ի���','��ʾ',mb_ok or MB_ICONWARNING);
         exit;
      end;

   for i:= syneditor1.CaretY-1 to syneditor1.LineS.Count- 1 do  //���ҶԻ�������
    begin
     if Is_end_char(syneditor1.LineS.Strings[i]) or
        is_not_i_n(syneditor1.LineS.Strings[i],ss_npc) then
         begin
         last1:= i;
         break;
         end;

    end; //end for

    if last1= 0 then
     begin
      messagebox(handle,'���������һ����Ч�ĶԻ����ϣ������ܴ�����һ���Ի���','��ʾ',mb_ok or MB_ICONWARNING);
       exit;
     end;

     {
     ���ҶԻ��Ŀ�ʼ
     ���Կ��У��ú�ӽ����п�ʼ���ң�����ҵ��µĽ����л���
     �������ҷ��Ի�������Ի����ֵ��ҷ��Ի�����ôҲ��ʾһ�ζԻ���һ�ν���
     }
   b:= false;
   for i:= last1-1 downto c do  //���ҶԻ���ʼ��
    begin
      if trim(syneditor1.LineS.Strings[i])= '' then
        Continue;

      if Is_end_char(syneditor1.LineS.Strings[i]) or
         find_first(syneditor1.LineS.Strings[i],ss_npc,b) then
         begin
         first1:= i;
         break;
         end;
    end; //end for

    if first1= 0 then
      begin
       messagebox(handle,'���������һ����Ч�ĶԻ����ϣ������ܴ�����һ���Ի���','��ʾ',mb_ok or MB_ICONWARNING);
       exit;
      end;

  

     if flag= 1 then  //������һ��Ի�
      begin
       //д��Ի���
      if last1 > first1 then
       begin
        b_i:= false; //û�з���i��ͷ�ĶԻ�ʱ����ֵΪfalse
       for i:= last1-1 downto first1+1 do
        begin
         if trim(syneditor1.Lines.Strings[i])= '' then
            Continue;
         if pos(';;',syneditor1.Lines.Strings[i])> 0 then
            Continue;

            if UpCase(syneditor1.Lines.Strings[i][1])= 'I' then
             begin
              b_i:= true;
              syneditor1.Lines.Insert(last1,get_head_string(syneditor1.Lines.Strings[i]));
             end else begin
                       if b_i then
                        begin
                         //����ѭ�����ѶԻ�̸����iϵ�е�����
                         for y:= last1-1 downto i+1 do
                            begin
                             syneditor1.Lines.Insert(last1,
                                FastReplace(get_head_string(syneditor1.Lines.Strings[y]),'i',ss_npc,false));
                            end;

                         break;
                        end else begin
                                  //����һ��ͷ���ǶԷ�̸������ô���贴��һ���ҷ���̸��
                                   syneditor1.Lines.Insert(last1,
                                   FastReplace(get_head_string(syneditor1.Lines.Strings[i],true),ss_npc,'I',true));
                                 end;
                      end;
         
         file_is_change:= true;
        end; //end for

       end; //if
      end; //end if flag=1

    if flag= 2 then //����ͬ�����һ��Ի�
     begin
       for i:= last1-1 downto first1+1 do
        begin
         if trim(syneditor1.Lines.Strings[i])= '' then
            Continue;

         ss_next:= get_head_string(syneditor1.Lines.Strings[i],true);  //ȡ���ļ�ͷ�����һλ���ֲ�������
                  //�ж��Ƿ��ļ�ͷ��Ҫ�޸�
          if fastcharpos(ss_next,',',1) > fastcharpos(ss_next,'=',1) then //������ں�ǰ��û����ĸ����
            begin
             //�����ĸ
             ss_next2:= syneditor1.Lines.Strings[i];
             insert(',A',ss_next2,fastcharpos(ss_next,'=',1));
             syneditor1.Lines.Strings[i]:= ss_next2; //���´����
             ss_next:= get_head_string(ss_next2,true);
            end;
            //������������ĸ��ͷ���
           ss_next[fastcharpos(ss_next,'=',1)-1]:= char(ord(ss_next[fastcharpos(ss_next,'=',1)-1])+1);
         syneditor1.Lines.Insert(last1,ss_next);
         file_is_change:= true;
          break;
        end; //end for
     end; //end flag=2

     if flag=3 then  //���ұ������ĸ��֧
      begin
       if get_head_string(syneditor1.LineText,true)<> '0,' then
             last1:= syneditor1.CaretY; //�����ǰ����Ч����ôֱ���޸Ĵ���
        for i:= last1-1 downto first1+1 do
        begin
         if trim(syneditor1.Lines.Strings[i])= '' then
            Continue;

         ss_next:= get_head_string(syneditor1.Lines.Strings[i],true);  //ȡ���ļ�ͷ�����һλ���ֲ�������
                  //�ж��Ƿ��ļ�ͷ��Ҫ�޸�

             //�����ĸ
             ss_next2:= syneditor1.Lines.Strings[i];
             insert(',A',ss_next2,fastcharpos(ss_next,'=',1));
             syneditor1.Lines.Strings[i]:= ss_next2; //���´����
             ss_next:= get_head_string(ss_next2,true);
              dec(last1);
            //������������ĸ��ͷ���
           {ss_next[fastcharpos(ss_next,'=',1)-1]:= char(ord(ss_next[fastcharpos(ss_next,'=',1)-1])+1);
         syneditor1.Lines.Insert(last1,ss_next); }
         file_is_change:= true;
          break;
        end; //end for
      end; //end flag=3

     y:= syneditor1.GetRealLineNumber(last1);
         syneditor1.InitCodeFolding;  //չ���۵��Ĵ��룬�����ػ��۵���
      SendMessage(syneditor1.Handle, WM_VSCROLL, SB_BOTTOM, 0); //��������
         syneditor1.CaretY:= y + 1;
        syneditor1.CaretX:= length(syneditor1.LineText)+1; //��λ��굽�ı�ĩβ
      
end;

procedure TForm1.N77Click(Sender: TObject);
begin
 create_next_char(1); //������һ�����
end;

function TForm1.code_in_html: boolean;
var i: integer;
begin
   //��鵱ǰ���Ƿ�λ�ڿ�дhtml������������

 result:= false;

// show_code;  //չ���۵��Ĵ���

    with syneditor1.Lines do
     begin
      for i:= 0 to syneditor1.CaretY-1 do
        begin
        // ɨ���Ƿ��ڶԻ�����
          if fastpos(strings[i],'����=',length(strings[i]),5,1)>0 then
                begin
                  result:= true;
                  exit;
                end;
        end;
     end;

end;

procedure TForm1.N79Click(Sender: TObject);
begin
 if code_in_html then
    begin
     syneditor1.selText:= '<p>'+ #13;
     //syneditor1.LineText:= syneditor1.LineText+ ;
    end;
end;

procedure TForm1.N80Click(Sender: TObject);
begin
  if code_in_html then
    begin
     syneditor1.selText:= '<a href="game_page(10001)">����</a>';
    end;
end;

procedure TForm1.N83Click(Sender: TObject);
var ss,ss3: string;
begin
    //�ı���ɫ
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ�ı���ɫ�����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

    if colordialog1.Execute then
     begin

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����

      ss3:= '<FONT color=#'+ Format('%s%s%s',[IntToHex(GetRValue(colordialog1.Color),2),
                                                IntToHex(GetGValue(colordialog1.Color),2),
                                                IntToHex(GetBValue(colordialog1.Color),2)]) +
      '>' + ss + '</FONT>';

     syneditor1.SelText:= ss3;
     // syneditor1.SelStart:=
      syneditor1.CaretX:= syneditor1.CaretX- 7;
     SynEditor1Change(sender); //�ļ�����
    end;
end;

procedure TForm1.N84Click(Sender: TObject);
var ss,ss3: string;
begin
    //����
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ�ı���ʽ�����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����

      ss3:= '<b>' + ss + '</b>';
     // ss3:= '<strong>' + ss + '</strong>';

     syneditor1.SelText:= ss3;
     // syneditor1.SelStart:=
      syneditor1.CaretX:= syneditor1.CaretX- 9;
     SynEditor1Change(sender); //�ļ�����


end;

procedure TForm1.show_code;  //չ���۵��Ĵ��룬ͬʱ������ʵ�к�
var y: integer;
begin
    y:= syneditor1.GetRealLineNumber(syneditor1.CaretY-1);
     syneditor1.InitCodeFolding;
     syneditor1.CaretY:= y+1;
end;

procedure TForm1.N85Click(Sender: TObject);
var ss,ss3: string;
begin
    //б��
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ�ı���ʽ�����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����

      ss3:= '<em>' + ss + '</em>';

     syneditor1.SelText:= ss3;
      syneditor1.CaretX:= syneditor1.CaretX- 5;
     SynEditor1Change(sender); //�ļ�����

end;

procedure TForm1.N86Click(Sender: TObject);
var ss,ss3: string;
begin
    //�»���
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ�ı���ʽ�����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����

      ss3:= '<u>' + ss + '</u>';

      syneditor1.SelText:= ss3;
      syneditor1.CaretX:= syneditor1.CaretX- 4;
     SynEditor1Change(sender); //�ļ�����

end;

procedure TForm1.N90Click(Sender: TObject);
var ss,ss3: string;
begin
    //ɾ����
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ�ı���ʽ�����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����
      ss3:= '<s>' + ss + '</s>';

      syneditor1.SelText:= ss3;
      syneditor1.CaretX:= syneditor1.CaretX- 4;
     SynEditor1Change(sender); //�ļ�����

end;

procedure TForm1.N87Click(Sender: TObject);
var ss,ss3: string;
begin
    //������
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ���������ӵ����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����
      ss3:= '<a href="" title="">' + ss + '</a>';
      syneditor1.SelText:= ss3;
     // syneditor1.SelStart:=
      syneditor1.CaretX:= syneditor1.CaretX- length(ss) - 15;
     SynEditor1Change(sender); //�ļ�����


end;

function TForm1.up_and_clean_space(const s: string): string;
 var i,k: integer;
     b_dy,b_zuo: boolean;
begin
     //Сд��ĸ���д����ȥ�����ں�ǰ��Ŀո�

     result:= s;
     if FastPosNoCase(s,'string ',length(s),7,1)= 1 then
        exit; //����ʼ�Ǻ������˳�

     k:= fastcharpos(s,'=',1);
      if ((pos('if',s)>0) and (pos('if',s)< k)) or(k = 0) then
       exit;

     b_dy:= false;
     b_zuo:= false;
     i:= 0;
   while i< length(result) do
    begin
      inc(i);
      if result[i]= '=' then
        begin
          b_dy:= true;
          Continue;
        end else if result[i]= '[' then
              begin
               b_zuo:= true;
               Continue;
              end else if result[i]= ']' then
                        begin
                          b_zuo:= false;
                          Continue;
                        end;

     if b_dy and not b_zuo then
      begin
       //���ںŵĺ��棬����û�з����ţ���ʱ���ֶ��ż��ɽ���
       if result[i]=',' then
        exit
        else if result[i]= ' ' then
               delete(result,i,1);

      end else if not b_dy then
                  if result[i] in['a'..'z'] then
                     result[i]:= UpCase(result[i])
                     else if result[i]= ' ' then
                       delete(result,i,1);

    end; //end for

end;

procedure TForm1.N94Click(Sender: TObject); //������һ��Ի�
begin
 //����ͬһ���������һ���ѡ�Ի������� I=1, ִ�д˲�����Ϊ I,a= i,b=

 {
 �����ǰ���ǽ����У���ô���ϲ��ң��ҵ���һ����Ч��������ӻ���
 �����ǰ������Ч�У���ô���²��ң��ҵ���β��������
 }
  //��������ڶԻ���Դ�ڣ���ôֱ�Ӹ���һ�仰

  create_next_char(2); //������һ��
end;

procedure TForm1.N95Click(Sender: TObject);
begin
  create_next_char(3); //�����֧��ĸ
end;

procedure TForm1.N96Click(Sender: TObject);
begin
  if code_in_html then
    begin
     syneditor1.selText:= '<br>'+ #13;
     //syneditor1.LineText:= syneditor1.LineText+ ;
    end;
 
end;

procedure TForm1.html2Click(Sender: TObject);
begin
 shellexecute(handle,'open','IEXPLORE.EXE',
  pchar(ExtractFilePath(application.ExeName)+'highlighters\index.htm'),nil,sw_shownormal);
end;



procedure TForm1.Button13Click(Sender: TObject); //���ó�������
           function HexToTColor(sColor : string) : TColor; //ʮ����torgb
           begin
            try
              Result :=
               RGB(
                 StrToInt('$'+Copy(sColor, 1, 2)),
                 StrToInt('$'+Copy(sColor, 3, 2)),
                 StrToInt('$'+Copy(sColor, 5, 2))
               );
            except
              result:= 0;
            end;
           end;
var op,i,x,y,z: integer;
    ss,ss2: string;
begin
    i:= -1;
     for x:= 0 to syneditor1.Lines.Count-1 do
         if pos('����=',syneditor1.Lines.Strings[x])> 0 then
           begin
           i:= x;
           break;
           end;
     if i = -1 then
       begin
         messagebox(handle,'��λ"����"��ʧ�ܣ���ȷ�ϵ�ǰ�򿪵���һ����Ч�ĳ����ļ���','��ʾ',
                  mb_ok or MB_ICONWARNING);
         exit;
       end;
     //д����������++++++++++++++++++++++++++++++
      if syneditor1.Lines.Values['����']= '' then
         op:= 1
         else
           op:= strtoint(syneditor1.Lines.Values['����']);


         form_scene_option.CheckBox_mi.Checked:= (op and 2= 2);


         form_scene_option.CheckBox_temp.Checked:=(op and 4=4);

         form_scene_option.CheckBox_notstop.Checked:=(op and 8= 8);
         form_scene_option.CheckBox_home.Checked:=(op and 64= 64);
         form_scene_option.CheckBox_tuichu.Checked:=(op and 128= 128);
         form_scene_option.CheckBox_not_down_img.Checked:=(op and 256= 256);
      if op and 16= 16 then
         begin
         form_scene_option.CheckBox_before.Checked:= true;
          form_scene_option.Edit1.Text:=  syneditor1.Lines.Values['����ǰ'];
         end else begin
                   form_scene_option.CheckBox_before.Checked:= false;
                   form_scene_option.Edit1.Text:= '';
                  end;
      if op and 32= 32 then
         begin
         form_scene_option.CheckBox_after.Checked:= true;
         form_scene_option.Edit2.Text:= syneditor1.Lines.Values['�����'];
         end else begin
                   form_scene_option.CheckBox_after.Checked:= false;
                   form_scene_option.Edit2.Text:= '';
                  end;
      if op and 128= 128 then
         begin
         form_scene_option.CheckBox_tuichu.Checked:= true;
         form_scene_option.Edit5.Text:= syneditor1.Lines.Values['�˳���'];
         end else begin
                   form_scene_option.CheckBox_tuichu.Checked:= false;
                   form_scene_option.Edit5.Text:= '';
                  end;

       syneditor1.InitCodeFolding;
           for i:= 0 to syneditor1.Lines.Count -1 do
            begin
               y:= FastPosNoCase(syneditor1.Lines.Strings[i],'<body',
                                 length(syneditor1.Lines.Strings[i]),5,1);
             if y > 0 then
                begin
                 ss:= syneditor1.Lines.Strings[i];

                  z:= FastPosNoCase(ss,' link=',length(ss),6,1);
                  form_scene_option.CheckBox_link.Checked:= z> 0;
                  if z> 0 then
                   begin

                     form_scene_option.Label2.Color:=HexToTColor(copy(ss,z+8,6));
                   end;
                  z:= FastPosNoCase(ss,'alink=',length(ss),6,1);
                  form_scene_option.CheckBox_alink.Checked:= z> 0;
                  if z> 0 then
                   begin

                     form_scene_option.Label3.Color:=HexToTColor(copy(ss,z+8,6));
                   end;
                  z:= FastPosNoCase(ss,'vlink=',length(ss),6,1);
                   form_scene_option.CheckBox_vlink.Checked:= z> 0;
                  if z> 0 then
                   begin
                     
                     form_scene_option.Label4.Color:=HexToTColor(copy(ss,z+8,6));
                   end;
                  z:= FastPosNoCase(ss,'bgcolor=',length(ss),8,1);
                   form_scene_option.CheckBox_color.Checked:= z> 0;
                  if z> 0 then
                   begin

                     form_scene_option.Label1.Color:=HexToTColor(copy(ss,z+10,6));
                   end;
                  z:= FastPosNoCase(ss,'text=',length(ss),8,1);
                   form_scene_option.CheckBox_text.Checked:= z> 0;
                  if z> 0 then
                   begin

                     form_scene_option.Label5.Color:=HexToTColor(copy(ss,z+7,6));
                   end;
                   z:= FastPosNoCase(ss,'style=',length(ss),6,1);  //�����̶�
                  form_scene_option.CheckBox_b_pic.Checked:= z> 0;
                  form_scene_option.RadioButton_PP.Enabled:= z> 0;
                  form_scene_option.RadioButton_LS.Enabled:= z> 0;
                  form_scene_option.RadioButton_GD.Enabled:= z> 0;
                  if z> 0 then
                   begin  //�̶�ģʽ
                         form_scene_option.RadioButton_GD.Checked:= true;
                     z:= fastpos(ss,'$app',length(ss),4,z+6);
                     if z=0 then //���������$,����gpic��־
                      z:= fastpos(ss,'gpic:',length(ss),5,1);

                     form_scene_option.Edit3.Text:= copy(ss,z,
                               fastcharpos(ss,'.',z)-z+ 4);
                               //����ֻ���ж��Ƿ��е㣬�������ļ����ж���㣬���ܵ����ļ���ȡ�ò�ȫ
                   end else begin
                         form_scene_option.Edit3.Text:= '';
                             end;

                   if z = 0 then
                   begin
                     z:= FastPosNoCase(ss,'background=',length(ss),11,1);
                     form_scene_option.CheckBox_b_pic.Checked:= z> 0;
                     form_scene_option.RadioButton_PP.Enabled:= z> 0;
                     form_scene_option.RadioButton_LS.Enabled:= z> 0;
                     form_scene_option.RadioButton_GD.Enabled:= z> 0;
                     if z> 0 then
                      begin
                       form_scene_option.RadioButton_PP.Checked:= true;
                       form_scene_option.Edit3.Text:= copy(ss,z+12,
                               fastcharpos(ss,'"',z+13)-z -12);
                      end else begin
                          form_scene_option.Edit3.Text:= '';
                               end;
                   end; //end if z ����ƽ��

                   if z = 0 then   //��������
                    begin
                     ss:= syneditor1.Lines.Strings[i+1];
                     z:= FastPosNoCase(ss,'ufoDiv',length(ss),6,1);
                       if z= 0 then //���Ϊ�㣬����̽����һ��
                          begin
                           ss:= syneditor1.Lines.Strings[i+2];
                           z:= FastPosNoCase(ss,'ufoDiv',length(ss),6,1);
                          end;
                      form_scene_option.CheckBox_b_pic.Checked:= z> 0;
                      form_scene_option.RadioButton_PP.Enabled:= z> 0;
                      form_scene_option.RadioButton_LS.Enabled:= z> 0;
                      form_scene_option.RadioButton_GD.Enabled:= z> 0;
                       if z> 0 then
                         begin
                          form_scene_option.RadioButton_ls.Checked:= true;
                           z:= fastpos(ss,'$app',length(ss),4,z+6);
                           if z=0 then //���������$,����gpic��־
                              z:= fastpos(ss,'gpic:',length(ss),5,1);
                           form_scene_option.Edit3.Text:= copy(ss,z,
                               fastcharpos(ss,'.',z)-z+ 4);
                          end;
                    end; //end if z

                   ss:= syneditor1.Lines.Strings[i+1];
                   z:= FastPosNoCase(ss,'<bgsound',length(ss),8,1);
                   form_scene_option.CheckBox_b_sound.Checked:= z> 0;
                  if z> 0 then
                   begin

                     form_scene_option.Edit4.Text:= copy(ss,z+14,
                               fastcharpos(ss,'"',z+15)-z -14);
                   end;
                 break;
                end; //end if y
            end; //end for i

     //����д�����++++++++++++++++++++++++++++++++++

  if form_scene_option.ShowModal= mrok then
    begin
        for x:= 0 to syneditor1.Lines.Count-1 do
         if pos('����=',syneditor1.Lines.Strings[x])> 0 then
           begin
           i:= x;
           break;
           end;

      op:= 0; //�������
      if form_scene_option.CheckBox_mi.Checked then
         op:= 2;
      if form_scene_option.CheckBox_temp.Checked then
         op:= op or 4;
      if form_scene_option.CheckBox_notstop.Checked then
         op:= op or 8;
      if form_scene_option.CheckBox_home.Checked then
         op:= op or 64; //�سǵ�
      if form_scene_option.CheckBox_before.Checked then
         begin
         op:= op or 16;
         y:= 0;
          for x:= 0 to syneditor1.Lines.Count-1 do
            if pos('����ǰ=',syneditor1.Lines.Strings[x])> 0 then
             begin
              y:= x;
              end;
          if y > 0 then
             syneditor1.Lines.Strings[y]:= '����ǰ=' + form_scene_option.Edit1.Text
             else
              syneditor1.Lines.Insert(i+1,'����ǰ=' + form_scene_option.Edit1.Text);
         end;
      if form_scene_option.CheckBox_after.Checked then
         begin
         op:= op or 32;
          y:= 0;
          for x:= 0 to syneditor1.Lines.Count-1 do
            if pos('�����=',syneditor1.Lines.Strings[x])> 0 then
             begin
              y:= x;
             end;
           if y >0 then
             syneditor1.Lines.Strings[y]:= '�����=' + form_scene_option.Edit2.Text
             else
              syneditor1.Lines.Insert(i+1,'�����=' + form_scene_option.Edit2.Text);
         end;
       if form_scene_option.CheckBox_tuichu.Checked then
         begin
         op:= op or 128;
          y:= 0;
          for x:= 0 to syneditor1.Lines.Count-1 do
            if pos('�˳���=',syneditor1.Lines.Strings[x])> 0 then
             begin
              y:= x;
             end;
           if y >0 then
             syneditor1.Lines.Strings[y]:= '�˳���=' + form_scene_option.Edit5.Text
             else
              syneditor1.Lines.Insert(i+1,'�˳���=' + form_scene_option.Edit5.Text);
         end;

        if form_scene_option.CheckBox_not_down_img.Checked then
         op:= op or 256;

       if op > 0 then
         syneditor1.Lines.Values['����']:= inttostr(op)
         else
           syneditor1.Lines.Values['����']:='1';

     //����ͼ�ͱ�������
           syneditor1.InitCodeFolding;
           for i:= 0 to syneditor1.Lines.Count -1 do
            begin
               y:= FastPosNoCase(syneditor1.Lines.Strings[i],'<body',
                                 length(syneditor1.Lines.Strings[i]),5,1);
             if y > 0 then
                begin
                 ss:= syneditor1.Lines.Strings[i];
                 x:= fastcharpos(ss ,'>',y);
                 if x= 0 then
                    x:= length(ss);

                  delete(ss,y+5,x-y-5); //ɾ�����ܴ��ڵ�body�ڵı�������
                  ss2:= '';
                   if form_scene_option.CheckBox_b_pic.Checked then
                     begin
                      if form_scene_option.RadioButton_PP.Checked then
                        if pos('://',form_scene_option.Edit3.Text)> 0 then
                           ss2:= ' background="'+ form_scene_option.Edit3.Text +'"'
                           else
                            ss2:= ' background="$apppath$img\'+ ExtractFileName(form_scene_option.Edit3.Text) +'"';

                      if form_scene_option.RadioButton_GD.Checked then
                        if pos('://',form_scene_option.Edit3.Text)> 0 then
                           ss2:= ' style="background:url('+ form_scene_option.Edit3.Text +') fixed no-repeat center center;"'
                           else
                            ss2:= ' style="background:url($apppath$img\'+ ExtractFileName(form_scene_option.Edit3.Text) +') fixed no-repeat center center;"';
                     end;
                   if form_scene_option.CheckBox_color.Checked then
                     ss2:= ss2 + ' bgcolor="#' +Format('%s%s%s',[IntToHex(GetRValue(form_scene_option.Label1.Color),2),
                                                IntToHex(GetGValue(form_scene_option.Label1.Color),2),
                                                IntToHex(GetBValue(form_scene_option.Label1.Color),2)]) +'"';
                   if form_scene_option.CheckBox_text.Checked then
                     ss2:= ss2 + ' text="#' +Format('%s%s%s',[IntToHex(GetRValue(form_scene_option.Label5.Color),2),
                                                IntToHex(GetGValue(form_scene_option.Label5.Color),2),
                                                IntToHex(GetBValue(form_scene_option.Label5.Color),2)]) +'"';
                   if form_scene_option.CheckBox_link.Checked then
                     ss2:= ss2 + ' link="#' +Format('%s%s%s',[IntToHex(GetRValue(form_scene_option.Label2.Color),2),
                                                IntToHex(GetGValue(form_scene_option.Label2.Color),2),
                                                IntToHex(GetBValue(form_scene_option.Label2.Color),2)]) +'"';
                   if form_scene_option.CheckBox_alink.Checked then
                     ss2:= ss2 + ' alink="#' +Format('%s%s%s',[IntToHex(GetRValue(form_scene_option.Label3.Color),2),
                                                IntToHex(GetGValue(form_scene_option.Label3.Color),2),
                                                IntToHex(GetBValue(form_scene_option.Label3.Color),2)]) +'"';
                   if form_scene_option.CheckBox_vlink.Checked then
                     ss2:= ss2 + ' vlink="#' +Format('%s%s%s',[IntToHex(GetRValue(form_scene_option.Label4.Color),2),
                                                IntToHex(GetGValue(form_scene_option.Label4.Color),2),
                                                IntToHex(GetBValue(form_scene_option.Label4.Color),2)]) +'"';
                   
                    insert(ss2,ss,y+ 5);
                   syneditor1.Lines.Strings[i]:= ss;

                    if form_scene_option.CheckBox_b_sound.Checked then //����
                      begin
                        ss2:='<bgsound src="$apppath$music\'+ ExtractFileName(form_scene_option.Edit4.Text) +'" loop="-1">';

                       if FastPosNoCase(syneditor1.Lines.Strings[i+1],'<bgsound',
                                       length(syneditor1.Lines.Strings[i+1]),8,1)> 0 then
                          syneditor1.Lines.Strings[i+1]:= ss2
                          else
                           syneditor1.Lines.Insert(i+1,ss2);

                      end;
                   if form_scene_option.CheckBox_b_pic.Checked then
                    begin  //����
                     if form_scene_option.RadioButton_LS.Checked then
                      begin
                        if pos('://',form_scene_option.Edit3.Text)> 0 then
                           ss2:= '<DIV ID="ufoDiv" STYLE="z-index:-1;position:absolute;left:0px;top:0px; height:100%; width:102%;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='''+ form_scene_option.Edit3.Text +''', sizingMethod=''scale'');" ></DIV>'
                           else
                             ss2:='<DIV ID="ufoDiv" STYLE="z-index:-1;position:absolute;left:0px;top:0px; height:100%; width:102%;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=''$apppath$img\'+ ExtractFileName(form_scene_option.Edit3.Text) +''', sizingMethod=''scale'');" ></DIV>';
                       if FastPosNoCase(syneditor1.Lines.Strings[i+1],'ufoDiv',
                                       length(syneditor1.Lines.Strings[i+1]),6,1)> 0 then
                          syneditor1.Lines.Strings[i+1]:= ss2
                          else if FastPosNoCase(syneditor1.Lines.Strings[i+2],'ufoDiv',
                                       length(syneditor1.Lines.Strings[i+2]),6,1)> 0 then
                          syneditor1.Lines.Strings[i+2]:= ss2
                            else
                             syneditor1.Lines.Insert(i+1,ss2);
                      end;
                    end;
                  syneditor1.InitCodeFolding; //�ػ��۵���
                   form1.SynEditor1Change(sender);
                 exit;
                end;
             
            end;

    end;

end;

procedure TForm1.N98Click(Sender: TObject);
var ss,ss3: string;
begin
  //����ת�ĳ�����
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ���������ӵ����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����
      ss3:= '<a href="game_page(1)" title="">' + ss + '</a>';

     syneditor1.SelText:= ss3;
     // syneditor1.SelStart:=
      syneditor1.CaretX:= syneditor1.CaretX- length(ss) - 16;
     SynEditor1Change(sender); //�ļ�����
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
 //����
 if file_is_change then
  begin
   if messagebox(handle,'�ļ��޸ĺ�û�б��棬��Щ�ı佫������������Ϸ�У��Ƿ����������Ϸ��','ѯ��',
                 mb_yesno or MB_ICONQUESTION)= mrno then exit;
  end;
  
 //WinExec(pchar(data_path +'game.exe'),SW_SHOWNORMAL);
 shellexecute(handle,'open',pchar(data_path +'game.exe'),
  pchar('debug-'+ inttostr(form_debug.Handle)),nil,sw_shownormal);
  button11.Enabled:= false;
   form_debug.Show;
end;

procedure TForm1.GIF1Click(Sender: TObject);
begin
  //�ڵ�ǰ��괦����img
    opendialog2.FileName:= '';
    opendialog2.InitialDir:= data_path +'gif';
    opendialog2.FilterIndex:= 1;
    if opendialog2.Execute then
     begin
      if not FileExists(data_path+'gif\'+ ExtractFileName(opendialog2.FileName)) then
           copyfile(pchar(opendialog2.FileName),pchar(data_path+'gif\'+
                    ExtractFileName(opendialog2.FileName)),true);

      syneditor1.selText:= '<img src="$apppath$gif\'+ ExtractFileName(opendialog2.FileName) +'">';
     end;
end;

procedure TForm1.N49Click(Sender: TObject);
begin
  if file_is_change then
    begin
      case messagebox(handle,'��ǰ�ļ��޸ĺ�û�б��棬�Ƿ񱣴棿','�����ļ�',mb_yesnocancel or MB_ICONQUESTION) of
       mryes: save_file;
      // mrno:
       mrcancel: begin
                  syneditor1.ClearAll;
                  syneditor1.InitCodeFolding; //�ػ��۵���
                 end;
       end;
    end else begin
              syneditor1.ClearAll;
              syneditor1.InitCodeFolding; //�ػ��۵���
             end;
end;

procedure TForm1.N72Click(Sender: TObject);
begin
 if savedialog2.Execute then
    begin
     caption:= edit_caption+ ' --'+ savedialog2.FileName;
     application.Title:= ExtractFileName(savedialog2.FileName)+ ' - ��Ϸ�༭��';
     syneditor1.Lines.SaveToFile(savedialog2.FileName);
     file_is_change:= false;
    end;
end;

procedure TForm1.N99Click(Sender: TObject);
begin
 //����Ϊģ���ļ�
 if messagebox(handle,'�Ƿ񸲸ǵ�ǰ�ġ��½�������ʱ�õ�ģ�壿','ȷ��',mb_yesno or MB_ICONQUESTION)= mryes then
   begin
    syneditor1.InitCodeFolding;
    syneditor1.Lines.SaveToFile(ExtractFilePath(application.ExeName)+'highlighters\new_scene.txt');
    
   end;
end;

procedure TForm1.N74Click(Sender: TObject);
begin


      if opendialog3.Execute then
        begin
         if file_is_change then
            open_file_shell(opendialog3.FileName)
            else begin
         syneditor1.ClearAll;
         caption:= edit_caption+ ' --'+ opendialog3.FileName;
         application.Title:= ExtractFileName(opendialog3.FileName)+ ' - ��Ϸ�༭��';
         syneditor1.Lines.LoadFromFile(opendialog3.FileName);
         syneditor1.InitCodeFolding; //�ػ��۵���
         file_open_type:= 4;
          if (syneditor1.Lines.Count>0) and (pos('��ͼ=',syneditor1.Lines.Strings[0])>0) then
             open_file_type:= l_jianmo;
                 end;
        end;

end;

procedure TForm1.N101Click(Sender: TObject);
var ss,ss3: string;
begin
  //��html�ڲ�������ƶ��¼�
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ���������ӵ����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����

      ss3:= '<a onMouseOver=location.href="">' + ss + '</a>';

      syneditor1.SelText:= ss3;
      syneditor1.CaretX:= syneditor1.CaretX- length(ss) - 6;
     SynEditor1Change(sender); //�ļ�����

end;

procedure TForm1.N102Click(Sender: TObject);
var ss,ss3: string;
begin
  //��html�ڲ���������¼�
    if syneditor1.SelLength= 0 then
    begin
      messagebox(handle,'�������ѡ��Ҫ���������ӵ����֡�','��ʾ',mb_ok or MB_ICONWARNING);
      exit;
    end;

      ss:= syneditor1.SelText;    //�õ�ѡ�е�����

      ss3:= '<a onclick="">' + ss + '</a>';

      syneditor1.SelText:= ss3;
      syneditor1.CaretX:= syneditor1.CaretX- length(ss) - 6;
     SynEditor1Change(sender); //�ļ�����

end;

procedure TForm1.Button12Click(Sender: TObject);
begin
   SaveDialog_zip.InitialDir:= GetShellFolders('Personal');
  if SaveDialog_zip.Execute then
   begin
    vclzip1.ZipName:= SaveDialog_zip.FileName;
    If FileExists(SaveDialog_zip.FileName) Then DeleteFile(SaveDialog_zip.FileName);
    vclzip1.RootDir:= data_path;
    vclzip1.FilesList.Clear;
    vclzip1.FilesList.Add(data_path+ '*.*');
    vclzip1.Recurse := True;
    vclzip1.RelativePaths := True;
    screen.Cursor:= crhourglass;
    vclzip1.Zip;
    screen.Cursor:= crdefault;
     if messagebox(handle,'�����ɡ��Ƿ������ļ��У�','ѯ��',mb_yesno or MB_ICONQUESTION)= mryes then
       WinExec(PChar('explorer /select,'+ SaveDialog_zip.FileName),SW_ShowNormal);
   end;
end;

procedure TForm1.VCLZip1TotalPercentDone(Sender: TObject;
  Percent: Integer);
  procedure spell_prc(ppp: integer);
      var ss: string;
        ppp2: integer;
      begin
        ss:= '>';
        for ppp2:= 2 to ppp do
           ss:= ss+ '>';
        StatusBar1.Panels[0].Text:= '���ݴ�����ȣ�'+ ss;
        application.ProcessMessages;
      end;
begin
 if vclzip1.Tag<> Percent then
  begin
  vclzip1.Tag:= Percent;
  spell_prc(round(Percent / 100 * 70));
  end;
end;

procedure TForm1.N65Click(Sender: TObject);
begin
shellexecute(handle,'open',pchar(extractfilepath(application.ExeName)+'help.chm'),nil,nil,sw_shownormal);
end;

procedure TForm1.N68Click(Sender: TObject);
begin
 messagebox(handle,pchar('�������䣺ufo2003a@gmail.com'+ #13#10 +'ufo2003@126.com'),'��Ϣ',mb_ok or MB_ICONINFORMATION);
end;

procedure TForm1.N66Click(Sender: TObject);
begin
 shellexecute(handle,'open','http://hi.baidu.com/3030',nil,nil,sw_shownormal);

end;

procedure TForm1.N103Click(Sender: TObject);
begin
  if form_gpic.ShowModal= mrok then
     syneditor1.selText:= form_gpic.text_result;
end;

procedure TForm1.SynEditor1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ss: string;
      i: integer;
  label pp;
begin
    postmessage(handle,post_msg_id,39,0);//�ı���λ�õ���ʾ����
   // if ssAlt in shift then //��ѡ��ģʽ
   // n30.Action
   //   else
     // n29.Action; //����ѡ��ģʽ
   if ssCtrl in shift then
    begin
     //���������ǳ�����ţ���ô������ת���ó����ļ�
     ss:= SynEditor1.WordAtMouse;
     if length(ss)= 5 then
      begin
        pp:
       if (file_open_type= 1) and (file_save_path<> '') then
         begin
         ss:= file_save_path+ '\'+ ss +'.ugm';

         end else  begin

          ss:= data_path+ 'scene\' + ss+ '.ugm';
                   end;
       if FileExists(ss) then
        begin
         if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
           open_file_shell(ss )
            else
            open_file_scene(ss);
        end;
      end else if (length(ss)= 1) or (length(ss)= 2) then
                 begin
                   if TryStrToInt(ss,i) then
                    begin
                      if SynEditor1.lines.Values['id']<> '' then
                        begin
                         ss:= inttostr(strtoint(SynEditor1.lines.Values['id'])+ i);
                          goto pp;
                        end;
                    end;
                 end else if (length(ss)= 4) and (ss[1] in ['1'..'9']) then
                            begin
                            form_shijian.index_line(ss);
                            form_shijian.ShowModal;
                            end;
    end
end;

procedure TForm1.SynEditor1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   postmessage(handle,post_msg_id,39,0); //�ı���λ�õ���ʾ����
end;

procedure TForm1.SynEditor1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var pt: TPoint;
begin
 postmessage(handle,post_msg_id,39,0); //�ı���λ�õ���ʾ����
  if button= mbRight then
   begin
    if SynEditor1.SelLength=0 then
       SynEditor1.Perform(WM_LBUTTONDOWN, MK_LBUTTON, MakeLong(X, Y));

   GetCursorPos(pt);
   TrackPopupMenu(mm1.Items[1].Handle, TPM_LEFTBUTTON or TPM_LEFTALIGN,
     pt.X, pt.Y, 0, Handle, nil);
   end;
end;

procedure TForm1.N104Click(Sender: TObject);
begin
  //�ڵ�ǰ��괦�������ͼƬ


      syneditor1.selText:= '<CENTER><img src=""></CENTER>';
     syneditor1.CaretX:= syneditor1.CaretX- 11;
end;

procedure TForm1.jpg1Click(Sender: TObject);
begin
  //�ڵ�ǰ��괦���� jpg
    opendialog2.FileName:= '';
    opendialog2.InitialDir:= data_path +'img';
    opendialog2.FilterIndex:= 2;
    if opendialog2.Execute then
     begin
      if not FileExists(data_path+'img\'+ ExtractFileName(opendialog2.FileName)) then
           copyfile(pchar(opendialog2.FileName),pchar(data_path+'img\'+
                    ExtractFileName(opendialog2.FileName)),true);

      syneditor1.selText:= '<img src="$apppath$img\'+ ExtractFileName(opendialog2.FileName) +'">';
     end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
help_list.Free;
open_file_list.Free;

  if map_name_changed then
     map_name.SaveToFile(extractfilepath(application.ExeName)+'highlighters\map_name.txt');

map_name.Free;

end;

procedure TForm1.SynEditor1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if ssLeft in shift then
   begin
    if (syneditor1.SelLength>0) and (open_file_type in[l_html,l_duihua]) then
     begin
      open_file_type:= l_crt_html;
      pagecontrol1.ActivePageIndex:= ord(open_file_type);
     end;
    exit;
   end;

  if (syneditor1.WordAtMouse_length <> length(edit_hint_string)) or
     (syneditor1.WordAtMouse <> edit_hint_string) then //�Ż����ȱȽ��ַ�������
   begin
     edit_hint_string:= syneditor1.WordAtMouse;
    if (length(edit_hint_string) > 7) and (length(edit_hint_string) < 30) then
     begin
  if (edit_hint_string[1]= 'g') and (edit_hint_string[2]= 'a')and (edit_hint_string[3]= 'm') and (edit_hint_string[4]= 'e') then
   begin
    syneditor1.Hint:= help_list.Values[edit_hint_string];
    syneditor1.ShowHint:= true;
   end else begin
             syneditor1.Hint:= '';
             syneditor1.ShowHint:= false;
            end;
     end else begin
               if (length(edit_hint_string)= 4) and (edit_hint_string[1] in ['1'..'9']) then
               begin
                if form_shijian.Memo1.Lines.Count= 0 then
                syneditor1.Hint:= '�¼�û�м���'
                else
                syneditor1.Hint:='�¼�'+edit_hint_string +'��'+ form_shijian.Memo1.Lines.Values[edit_hint_string];
                syneditor1.ShowHint:= true;
               end else begin
                         syneditor1.Hint:= '';
                         syneditor1.ShowHint:= false;
                        end;
              end;
   end;
end;

procedure TForm1.N105Click(Sender: TObject);
var ss: string;
    i: integer;
label pp;
begin
    ss:= inputbox('�����볡�����','������Ż��߳���ƫ�ƺ�   ','');
    if ss= '' then
     exit;

   if length(ss)= 5 then
      begin
        pp:
       if (file_open_type= 1) and (file_save_path<> '') then
         begin
         ss:= file_save_path+ '\'+ ss +'.ugm';

         end else  begin

          ss:= data_path+ 'scene\' + ss+ '.ugm';
                   end;
       if FileExists(ss) then
        begin
         if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
           open_file_shell(ss )
            else
            open_file_scene(ss);
        end;
      end else if (length(ss)< 4) then
                 begin
                   if TryStrToInt(ss,i) then
                    begin
                      if SynEditor1.lines.Values['id']<> '' then
                        begin
                         ss:= inttostr(strtoint(SynEditor1.lines.Values['id'])+ i);
                          goto pp;
                        end;
                    end;
                 end;
end;

procedure TForm1.N106Click(Sender: TObject);
var ss: string;
    i: integer;
label pp;
begin
    ss:='-1';


   if length(ss)= 5 then
      begin
        pp:
       if (file_open_type= 1) and (file_save_path<> '') then
         begin
         ss:= file_save_path+ '\'+ ss +'.ugm';

         end else  begin

          ss:= data_path+ 'scene\' + ss+ '.ugm';
                   end;
       if FileExists(ss) then
        begin
         if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
           open_file_shell(ss )
            else
            open_file_scene(ss);
        end;
      end else if (length(ss)< 4) then
                 begin
                   if TryStrToInt(ss,i) then
                    begin
                      if length(SynEditor1.lines.Values['id'])= 5 then
                        begin
                         ss:= inttostr(strtoint(SynEditor1.lines.Values['id'])+ i);
                          goto pp;
                        end;
                    end;
                 end;

end;

procedure TForm1.N107Click(Sender: TObject);
var ss: string;
    i: integer;
label pp;
begin
    ss:= '1';


   if length(ss)= 5 then
      begin
        pp:
       if (file_open_type= 1) and (file_save_path<> '') then
         begin
         ss:= file_save_path+ '\'+ ss +'.ugm';

         end else  begin

          ss:= data_path+ 'scene\' + ss+ '.ugm';
                   end;
       if FileExists(ss) then
        begin
         if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
           open_file_shell(ss )
            else
            open_file_scene(ss);
        end;
      end else if (length(ss)< 4) then
                 begin
                   if TryStrToInt(ss,i) then
                    begin
                      if length(SynEditor1.lines.Values['id'])= 5 then
                        begin
                         ss:= inttostr(strtoint(SynEditor1.lines.Values['id'])+ i);
                          goto pp;
                        end;
                    end;
                 end;

end;

procedure TForm1.Button14Click(Sender: TObject);
var ss: string;
    i: integer;
label pp;
begin
    ss:= edit1.Text;
    if ss= '' then
     exit;
    if not TryStrToInt(ss,i) then
       begin //�������֣���ô����map_name
       screen.Cursor:= crhourglass;
         if map_name.Count= 0 then
            begin
              if FileExists(extractfilepath(application.ExeName)+'highlighters\map_name.txt') then
                map_name.LoadFromFile(extractfilepath(application.ExeName)+'highlighters\map_name.txt');
            end;
         ss:= map_name.Values[ss];
         if ss= '' then
          begin
            //ģ������
            ss:= edit1.Text;
            for i:= 0 to map_name.Count-1 do
               if AnsiPos(ss,map_name.Strings[i])> 0 then
                  begin
                    ss:= map_name.Strings[i];
                    delete(ss,1,AnsiPos('=',ss));
                    break;
                  end;
           if ss= edit1.Text then
              ss:= '';
          end;
         screen.Cursor:= crdefault;
         if ss= '' then
            begin
            messagebox(handle,pchar(edit1.Text+' �ļ�û���ҵ�'),'nil',mb_ok);
            exit;
            end else edit1.Text:= ss;
       end;

   if length(ss)= 5 then
      begin
        pp:
       if (file_open_type= 1) and (file_save_path<> '') then
         begin
         ss:= file_save_path+ '\'+ ss +'.ugm';

         end else  begin

          ss:= data_path+ 'scene\' + ss+ '.ugm';
                   end;
       if FileExists(ss) then
        begin
         if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
           open_file_shell(ss )
            else
            open_file_scene(ss);
        end;
      end else if (length(ss)< 4) then
                 begin
                   if TryStrToInt(ss,i) then
                    begin
                      if length(SynEditor1.lines.Values['id'])= 5 then
                        begin
                         ss:= inttostr(strtoint(SynEditor1.lines.Values['id'])+ i);
                          goto pp;
                        end;
                    end;
                 end;

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if key= #13 then
   begin
    key:= #0;
    button14click(self);
   end;
end;

procedure TForm1.ID1Click(Sender: TObject);
begin
  syneditor1.selText:= get_scene_id;
  SynEditor1Change(sender); //�ļ�����
end;

procedure TForm1.N108Click(Sender: TObject);
begin
  form_shijian.ShowModal;
end;

procedure TForm1.N109Click(Sender: TObject);
begin

    if open_file_index<= 1 then
       exit;

       dec(open_file_index); //λ��ǰ��
       open_bk:= true;
       button16.Enabled:= true;
       if file_is_change then
           open_file_shell(open_file_list.Strings[open_file_index-1])
            else
            open_file_scene(open_file_list.Strings[open_file_index-1]);

     if open_file_index<= 1 then
        button15.Enabled:= false;
   //ǰһ�򿪵ĳ���
end;

procedure TForm1.N112Click(Sender: TObject);
begin
 //��һ�򿪵ĳ���
     if open_file_index= open_file_list.Count then
       exit;

       open_bk:= true;
       button15.Enabled:= true;
       if file_is_change then
           open_file_shell(open_file_list.Strings[open_file_index])
            else
            open_file_scene(open_file_list.Strings[open_file_index]);

     inc(open_file_index); //λ�ú���
     if open_file_index= open_file_list.Count then
      button16.Enabled:= false;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  N109Click(button15); //��ǰһ��ҳ��
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  N112Click(button16); //����һ��ҳ��
end;

procedure TForm1.N113Click(Sender: TObject);
var i,j,k: integer;
    ss: string;
begin
 syneditor1.InitCodeFolding;

  for i:= 0 to syneditor1.Lines.Count- 1 do
   begin
    ss:= syneditor1.Lines.Strings[i];
    j:= pos('=',ss);
    if j<2 then
     begin
     syneditor1.CaretY:= i+1;
     messagebox(handle,'��ǰ��ȱ�ٵ��ںŻ��ߵ��ں�ǰû������','error',mb_ok);
     exit;
     end else begin
               for k:= 1 to j do
                begin
                  if ByteType(ss,k)<> mbSingleByte then
                   begin
                    syneditor1.CaretX:= k;
                     syneditor1.CaretY:= i+1;
                      messagebox(handle,'��ǰ�е�����ǰ�������ַ����߱�㣬��ȥ����','error',mb_ok);
                      exit;
                   end;
                end;
              end;
   end;
  messagebox(handle,'�ʿ���ͨ��','ok',mb_ok);
end;

procedure TForm1.N114Click(Sender: TObject);
var i,j,k,L: integer;
    ss: string;
begin
 if messagebox(handle,'�ù��ܽ��ڴʿ����Զ����ӵ��ںţ��Ƿ������','ok',mb_yesno)= mryes then
  begin
    for i:= 0 to syneditor1.Lines.Count- 1 do
   begin
    ss:= syneditor1.Lines.Strings[i];
    j:= pos('=',ss);
    if j<2 then
     begin
     syneditor1.CaretY:= i+1;
     L:= 1;
      for k:= 1 to length(ss) do
       begin
         if ss[k]= ' ' then
           L:= k;
         if (ss[k]= '.') or (ByteType(ss,k)<> mbSingleByte) then
          begin
           if L<>1 then
            begin
             syneditor1.CaretX:= L;
            end else begin
                       syneditor1.CaretX:= k;
                     end;
            syneditor1.SelText:= '=';
            break;
          end;
       end;
     end;
   end;
  messagebox(handle,'���ӵ��ں������','ok',mb_ok);
  end;
end;

procedure TForm1.save_ugm(const n: string);
var str1: Tstringlist;
    i: integer;
    stream1: TMemoryStream;
begin
    if FileExists(n) then
     deletefile(n);

   if ExtractFileName(n)<> SynEditor1.Lines.Values['id']+ '.ugm' then
      raise Exception.Create('ID�뱣����ļ�����һ�£���ᵼ�´��ļ����ܱ��򿪡�');

  str1:= Tstringlist.Create;
   for i:= 0 to SynEditor1.lines.Count-1 do
    str1.Append(SynEditor1.lines.Strings[i]);

    game_add_password(str1); //���ĵ���������

    str1.Append('Code=ufo2003a@gmail.com'); //��Ӷ�����֤�ַ�

     str1.Append('Code='+ StrMD5(str1.text) );
      str1.Delete(str1.Count-2);
    stream1:= TMemoryStream.Create;
     str1.SaveToStream(stream1);
     stream1.Position:= 0;
    vclzip1.Password:= 'APP2433N';
     vclzip1.ZipName:= n;
    vclzip1.ZipFromStream(stream1,n);

   // vclzip1.Zip;
   stream1.Free;
  str1.Free;
  Button2.Font.Style:= [];
  button3.Font.Style:= [];
  button6.Font.Style:= [];
  statusbar1.Panels[0].Text:= '';
  file_is_change:= false;

         if map_name.Count= 0 then
            begin
              if FileExists(extractfilepath(application.ExeName)+'highlighters\map_name.txt') then
                map_name.LoadFromFile(extractfilepath(application.ExeName)+'highlighters\map_name.txt');
            end;
         if map_name.Values[SynEditor1.Lines.Values['����']]='' then
          begin
         map_name.Append(SynEditor1.Lines.Values['����'] +'='+
                         SynEditor1.Lines.Values['id']);
         map_name_changed:= true;
          end;
end;

procedure TForm1.N116Click(Sender: TObject);
begin
  form_tihuan.ShowModal;
end;

procedure TForm1.N119Click(Sender: TObject);
var i: integer;
begin
   if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
    begin
     { case messagebox(handle,'��ǰ�ļ��޸ĺ�û�б��棬�Ƿ񱣴棿','�����ļ�',mb_yesnocancel or MB_ICONQUESTION) of
      mryes: save_file;
      mrcancel: exit;
      end; }
      open_file_shell(ExtractFilePath(application.ExeName)+'highlighters\moshi.txt');
      exit;
    end;

  SynEditor1.Lines.Clear;
  SynEditor1.lines.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\moshi.txt');

   syneditor1.InitCodeFolding;
  

  file_is_change:= false;
  opened_file_name:= '';
  caption:= edit_caption;
  application.Title:=edit_caption;

   SynEditor1.Lines.Insert(14,get_scene_id+'[-1]>1');
   SynEditor1.Lines.Insert(17,get_scene_id+'=���ǲ�');
   SynEditor1.Lines.Insert(18,'1=����');
    for i:= 2 to 99 do
        SynEditor1.Lines.Insert(17+i,inttostr(i)+'=');
   syneditor1.Repaint;

   
   syneditor1.CaretY:= 15;
   syneditor1.CaretX:= 12;
   open_file_type:= l_jianmo;
   pagecontrol1.ActivePageIndex:= ord(open_file_type);
end;

procedure TForm1.N120Click(Sender: TObject);
begin
   file_is_change:= false;
end;

procedure TForm1.N118Click(Sender: TObject);
var base_map,tmp_map: PNode_map_data;
    str1: Tstringlist;
    i,j,flag,col_pos,f,g_s,g_b,total: integer;
    xiang_you: boolean;
    ss,ss_map,q_word,f_word,q_link,f_link,save,wupin: string;
    function get_new_node_map: PNode_map_data;
     begin
       if base_map= nil then
        begin
         new(base_map);
         fillchar(base_map^,sizeof(TNode_map_data),0);
         result:= base_map;
        end else begin
                  result:= base_map;
                  if result.id= 0 then
                     exit;
                     
                   while true do
                   if result.next=nil then
                     begin
                       if result.id= 0 then
                          exit;
                       new(result.next);
                       fillchar(result.next^,sizeof(TNode_map_data),0);
                       result.next.prve:= result;
                       result:= result.next;
                       exit;
                     end else begin
                                result:= result.next;
                              end;
                 end;
     end; //func
     procedure set_node;
     var tp: PNode_map_data;
         k: integer;
     begin
        //���>��־���У��򽫵�ǰ�ڵ�ķ��ص�ַ����Ϊ�ϲ㣬���ϲ��ǰ����ַ����Ϊ���㣬
             if (tmp_map.id< 1000) and (tmp_map.id<>0) then
                begin
                tmp_map.is_short_id:= true;
                tmp_map.id:= tmp_map.id+ base_map.id;
                end;

       if not xiang_you then
            exit;
       if (tmp_map.prve= nil) or tmp_map.is_set or(tmp_map.id=0) then
          exit;

          tp:= tmp_map.prve;
          while true do   //���һ���ϼ��ڵ�
          if ((tmp_map.row= tp.row) or (tp.col[0]< tmp_map.col[0]))
             and (tp.col[1]>= tmp_map.col[0]-1) then
            begin
             for k:= 0 to 9 do
               if tmp_map.houtui[k]= 0 then
                 begin
                   tmp_map.houtui[k]:= tp.id;  //���ñ��ڵ�ķ���id
                   break;
                 end;
             for k:= 0 to 63 do
               if tp.qianjin[k]= 0 then
                 begin
                   tp.qianjin[k]:= tmp_map.id; //�����ϼ���ǰ��id
                   break;
                 end;
             tmp_map.is_set:= true;

             exit;
            end else begin
                       if tp.prve= nil then
                          exit
                          else tp:= tp.prve;
                     end;

     end; //procedre
     function get_xuhao_qianjin(L: integer): string;
      var tp: PNode_map_data;
      begin
       tp:= base_map; //����Ŀ��id��������Ʋ�ͬ����ô������ȡ
       while tp<> nil do
        begin
         if (tp.id= tmp_map.qianjin[L]) or (tp.id= tmp_map.qianjin[L]+ tmp_map.id) then
           begin
             if (tp.name<> tmp_map.name) and (tp.name<>'') then
                begin
                result:= tp.name;
                exit;
                end;
           end;
         tp:= tp.next;
        end; //while
       if L> 0 then
        result:= 'ǰ��'+inttostr(L+1)
        else
         result:= 'ǰ��';
      end; //func
      function get_xuhao_houtui(L: integer): string;
      var tp: PNode_map_data;
      begin
       tp:= base_map; //����Ŀ��id��������Ʋ�ͬ����ô������ȡ
       while tp<> nil do
        begin
         if (tp.id= tmp_map.houtui[L]) or (tp.id= tmp_map.houtui[L]+ tmp_map.id) then
           begin
             if (tp.name<> tmp_map.name) and (tp.name<>'') then
                begin
                result:= tp.name;
                exit;
                end;
           end;
         tp:= tp.next;
        end; //while
       if L> 0 then
        result:= '����'+inttostr(L+1)
        else
         result:= '����';
      end; //func
begin
    //����ģʽ�ļ����ɵ�ͼ ���ȴ�����ͼ�������ݣ�Ȼ�������Щ�������ɵ�ͼ
    if (SynEditor1.Lines.Count=0) or  (pos('��ͼ=',SynEditor1.Lines.Strings[0])<>1) then
     begin
      messagebox(handle,'��ǰ���ݲ��ǵ�ͼģʽ�ļ������ܴ�����ͼ','����',mb_ok);
      exit;
     end;

//f:= 1; //������־
//xiang_you:= false; //���ұ�־

          if (file_open_type= 1) and (file_save_path<> '') then
          savedialog1.InitialDir:= file_save_path
          else
          savedialog1.InitialDir:= data_path+ 'scene';

          savedialog1.FileName:= '��������';
          savedialog1.FilterIndex:= 1;
          if savedialog1.Execute then
             save:= ExtractFilePath(savedialog1.FileName)
             else exit;

total:= 0; //ͳ���ܴ����ļ�����
col_pos:= 0;
   str1:= Tstringlist.Create;
     str1.AddStrings(SynEditor1.Lines);

     SynEditor1.Lines.Clear;
     if FileExists(ExtractFilePath(application.ExeName)+'highlighters\'+ str1.Values['��ͼ']+ '.txt') then
        SynEditor1.Lines.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\'+ str1.Values['��ͼ']+ '.txt')
        else begin
              if messagebox(handle,'��ͼ�ļ�û�ҵ����Ƿ������˴���','����',mb_yesno)= mryes then
                 str1.Values['��ͼ']:='��ͨ';
                str1.Free;
               exit;
             end;
     //��ʼ��һЩ����������ǰ��ʱ��Ҫ�ı����������ͺ���ʱ��Ҫ��
     if TryStrToInt(str1.Values['ǰ��ʱ������'],g_s) then
        begin
        if g_s>0 then
           q_word:='game_pop_a('+inttostr(g_s) +');';
        end else
         q_word:= '';
     if TryStrToInt(str1.Values['����ʱ������'],g_s) then
        begin
        if g_s >0 then
        f_word:='game_pop_a('+inttostr(g_s) +');';
        end else
             f_word:= '';
     if not TryStrToInt(str1.Values['��������'],g_s) then
        g_s:= 1;
     if not TryStrToInt(str1.Values['������'],g_b) then
        g_b:= 2;

    //��ʼ�����㷨
    screen.Cursor:= crhourglass;
    for i:= 0 to str1.Count - 1 do
      begin
        ss:= str1.Strings[i];
        if (ss= '') or (ByteType(ss,1)=mbLeadByte)
        or (ss[1]=';') or (pos('=',ss)> 0) then
           Continue; //�������ںŵ�Ҳ����

        tmp_map:=  get_new_node_map; //���һ�����ӵ�
        flag:= 0;
        f:= 1; //������־�ָ�
        xiang_you:= false; //���ұ�־
        for j:= 1 to length(ss) do
         begin
           case ss[j] of
            '(': begin
                  flag:= 1;
                  f:= 1; //������־�ָ�
                  col_pos:= 0;
                  if tmp_map.col[0]=0 then
                     tmp_map.col[0]:= j;  //�趨��ʼ��λ��
                 end;
            ')': begin
                  flag:= 0;
                  f:= 1; //������־�ָ�
                 end;
            '[': begin
                  flag:= 2;
                  f:= 1; //������־�ָ�
                  col_pos:= 0;
                  if tmp_map.col[0]=0 then
                     tmp_map.col[0]:= j;  //�趨��ʼ��λ��
                 end;
            ']': begin
                  flag:= 0;
                  f:= 1; //������־�ָ�
                 end;
            ' ': begin
                  if flag= 3 then
                     tmp_map.name:= tmp_map.name +ss[j];
                  if (flag=1) or (flag=2) then
                      inc(col_pos);
                 end;
            ';': break;
            '-': f:= -1;
            ',': begin
                  f:= 1; //������־�ָ�
                   if (flag=1) or (flag=2) then
                      inc(col_pos);
                 end;
            '>': begin
                   f:= 1; //������־�ָ�
                   //if tmp_map.col[1]=0 then
                      tmp_map.col[1]:= j;
                   //���>��־���У��򽫵�ǰ�ڵ�ķ��ص�ַ����Ϊ�ϲ㣬���ϲ��ǰ����ַ����Ϊ���㣬
                     set_node;
                   //���½��ڵ�
                   tmp_map:=  get_new_node_map; //���һ�����ӵ�
                   xiang_you:= true;
                 end;
            '''': begin
                   f:= 1; //������־�ָ�
                  if tmp_map.col[0]=0 then
                     tmp_map.col[0]:= j;  //�趨��ʼ��λ��
                  if flag=3 then
                     flag:= 0
                     else
                      flag:= 3;
                 end;
            '0'..'9': begin
                      if tmp_map.col[0]=0 then
                         tmp_map.col[0]:= j;  //�趨��ʼ��λ��
                       tmp_map.row:= i;
                       case flag of
                       0: tmp_map.id:= tmp_map.id * 10 + strtoint(ss[j]) * f;
                       1: begin
                           if col_pos < 24 then //ǰ���������24��
                           tmp_map.qianjin[col_pos]:=tmp_map.qianjin[col_pos] * 10 + strtoint(ss[j]) * f;
                           end;

                       2: begin
                           if col_pos < 10 then
                           tmp_map.houtui[col_pos]:=tmp_map.houtui[col_pos] * 10 + strtoint(ss[j]) * f;
                           end;
                       end;
                 end;
            else
              begin
               if flag= 3 then
                  tmp_map.name:= tmp_map.name +ss[j];
              end;
            end; // end case
            if j= length(ss) then
             begin
              tmp_map.col[1]:= j;  //�趨������λ��
              set_node;
             end;
         end;//end for j
      end; //end for i
    //�滻����
    ss_map:= SynEditor1.Lines.Text; //����
        //******************************************
    tmp_map:= base_map;
    while (tmp_map<>nil) and (tmp_map.id>0) do
     begin
      ss:= ss_map;
      if tmp_map.name= '' then
         tmp_map.name:= str1.Values['����'];
        //����
        wupin:= str1.Values[inttostr(tmp_map.id)];
        if wupin= '' then
           wupin:= str1.Values[inttostr(tmp_map.id- base_map.id)];
        if wupin= '' then
           wupin:= str1.Values['Ĭ����Ʒ'];
        if wupin='' then
           wupin:= 'һ������ҩ';
        ss:=StringReplace(ss,'$����$',inttostr(g_s),[rfReplaceAll]);
        ss:=StringReplace(ss,'$���$',inttostr(g_b),[rfReplaceAll]);
        ss:=StringReplace(ss,'$����$',tmp_map.name,[rfReplaceAll]);
        ss:=StringReplace(ss,'$��Ʒ$',wupin,[rfReplaceAll]);
          for i:= 0 to 9 do //��������Ϊ�������
           begin
               if (tmp_map.houtui[i]>1000) and (abs(tmp_map.houtui[i]-tmp_map.id)<100)then
                  begin
                   tmp_map.houtui[i]:= tmp_map.houtui[i]- tmp_map.id;
                  end else if tmp_map.is_short_id and (tmp_map.houtui[i]>0) and (tmp_map.houtui[i]<1000) then
                               begin
                                tmp_map.houtui[i]:= tmp_map.houtui[i] + base_map.id; //��id���������Ҳ�Ƕ̵ģ��Ȼָ�
                                tmp_map.houtui[i]:= tmp_map.houtui[i]- tmp_map.id;
                               end;

           end; //for
             for i:= 0 to 63 do //��������Ϊ�������
             begin
               if (tmp_map.qianjin[i]>1000) and (abs(tmp_map.qianjin[i]-tmp_map.id)<100)then
                   begin
                   tmp_map.qianjin[i]:= tmp_map.qianjin[i]- tmp_map.id;
                   end else if tmp_map.is_short_id and (tmp_map.qianjin[i]>0) and (tmp_map.qianjin[i]<1000) then
                               begin
                                tmp_map.qianjin[i]:= tmp_map.qianjin[i] + base_map.id; //��id���������Ҳ�Ƕ̵ģ��Ȼָ�
                                tmp_map.qianjin[i]:= tmp_map.qianjin[i]- tmp_map.id;
                               end;


             end; // end for
           q_link:= ''; //ǰ��ҳ����
           f_link:= '';
           for i:= 0 to 63 do
             if tmp_map.qianjin[i]<> 0 then
                q_link:= q_link+ '<a href="'+q_word+'game_page('+
                inttostr(tmp_map.qianjin[i])+')">'+get_xuhao_qianjin(i)+'</a><br>'+#13#10;
           for i:= 0 to 9 do
             if tmp_map.houtui[i]<> 0 then
                f_link:= f_link+ '<a href="'+f_word+'game_page('+
                inttostr(tmp_map.houtui[i])+')">'+get_xuhao_houtui(i)+'</a><br>'+#13#10;

        ss:=StringReplace(ss,'$��һҳ$',q_link,[rfReplaceAll]);
        ss:=StringReplace(ss,'$����$',f_link,[rfReplaceAll]);
           ss:=StringReplace(ss,'$�Զ���һ$',str1.Values['�Զ���һ'],[rfReplaceAll]);
           ss:=StringReplace(ss,'$�Զ����$',str1.Values['�Զ����'],[rfReplaceAll]);
           ss:=StringReplace(ss,'$�Զ�����$',str1.Values['�Զ�����'],[rfReplaceAll]);
           
      SynEditor1.Lines.Clear;
      SynEditor1.Lines.Text:= ss;
      SynEditor1.Lines.Values['id']:= inttostr(tmp_map.id);
      SynEditor1.Lines.Values['����']:= tmp_map.name;
       if str1.Values['����']<> '' then
          SynEditor1.Lines.Values['����']:= str1.Values['����'];
       if str1.Values['����']<> '' then
          SynEditor1.Lines.Values['����']:= str1.Values['����'];
       //����
       if not FileExists(save+ inttostr(tmp_map.id) +'.ugm') then
         begin
          save_ugm(save+ inttostr(tmp_map.id) +'.ugm');
          inc(total);
         end;
      tmp_map:= tmp_map.next;
     end; //while

      //**********************************************
   //�ͷŽڵ�
   tmp_map:= base_map;
   while tmp_map<>nil do
    begin
     base_map:= tmp_map.next;
     Dispose(tmp_map);
     tmp_map:= base_map;
    end;

   SynEditor1.Lines.Clear;
   SynEditor1.Lines.AddStrings(str1); //�ָ�
  str1.Free;
  screen.Cursor:= crdefault;
  messagebox(handle,pchar('������ɡ��ܼ� '+inttostr(total)+' �������Ѿ����档'),'���',mb_ok);
end;

procedure TForm1.Label1MouseEnter(Sender: TObject);
begin
  tlabel(sender).Font.Color:= clhotlight;
end;

procedure TForm1.Label1MouseLeave(Sender: TObject);
begin
  tlabel(sender).Font.Color:= clwindowtext;
end;

procedure TForm1.N123Click(Sender: TObject);
begin
if pagecontrol1.Visible then
  begin
   pagecontrol1.Visible:= false;
   syneditor1.Left:= 0;
   syneditor1.Width:= syneditor1.Width + pagecontrol1.Width + 2;
   N123.Caption:= '��ʾ�����';
  end else begin
             syneditor1.Width:= syneditor1.Width - pagecontrol1.Width - 2;
             syneditor1.Left:= pagecontrol1.Width + 2;
             pagecontrol1.Visible:= true;
             N123.Caption:= '�رղ����';
            end;
end;

procedure TForm1.show_lift_page_type(t: Tlift_page_type);
begin
      if not pagecontrol1.Visible then
         exit;

       pagecontrol1.ActivePageIndex:= ord(t);
      case t of
      l_new:   begin

               end;
      l_gpic:  begin
                 show_l_shuxing;
               end;
      l_shuxing:begin
                show_l_shuxing;
               end;
      l_guaiwu:begin
                 show_l_guaiwu;
               end;
      l_wupin: begin
                show_l_wupin;
               end;
      L_html:  begin
                show_l_shuxing;
               end;
      l_duihua:begin
                 show_l_shuxing;
               end;
      l_jianmo:begin
                show_l_jianmo;
               end;
      l_renwu:begin
                show_l_renwu;
               end;
      l_crt_html:show_l_shuxing;
      end;
end;


procedure TForm1.show_l_guaiwu;
begin
  //
end;


procedure TForm1.show_l_jianmo;
begin
   //
end;

procedure TForm1.show_l_renwu;
begin
   //
end;

procedure TForm1.show_l_wupin;
begin
   //
end;

procedure TForm1.show_l_shuxing; //����ѡ��ص�
var i: integer;
begin
if open_file_type in[l_gpic,l_shuxing,l_html,l_duihua,l_crt_html] then
    begin
       //������������

       button25.Enabled:= syneditor1.SelLength >0;
       button26.Enabled:= button25.Enabled;//������ѡ��ʱ�����Խ�����Щ����
       button54.Enabled:= button25.Enabled;
    if syneditor1.SelLength =0 then
               begin
                 //�����ж��Ƿ���gpic�ϣ�����ж�λ��
                 i:= pos('gpic:/',syneditor1.LineText);
                 if (i>0) and (i<= syneditor1.CaretX) then
                   open_file_type:= l_gpic
                   else begin
                         open_file_type:= l_shuxing;
                         for i:= 0 to syneditor1.Lines.Count-1 do
                          begin
                            if pos('����=',syneditor1.Lines[i])=1 then
                              begin
                               if syneditor1.CaretY> i then
                                  open_file_type:= L_html;
                              end else if pos('�Ի���Դ=',syneditor1.Lines[i])=1 then
                                         begin
                                           if syneditor1.CaretY> i then
                                              begin
                                              open_file_type:= L_duihua;
                                              break;
                                              end;
                                         end;
                          end; //for
                        end;
               end;
    end;
  pagecontrol1.ActivePageIndex:= ord(open_file_type);
  case open_file_type of
   l_gpic:    show_l_gpic_base;
   l_shuxing: show_l_shuxing_base;
   end;

end;


procedure TForm1.Button37Click(Sender: TObject); //��ʾ������ʾ
begin
  messagebox(handle,'������ĸ g Ȼ���Ե�һ��ͻ���֣����߰��� Ctrl + J ��ϼ���ע����Щ���Ϻ��治�ܳ�����ʾ��','��ʾ',mb_ok);

end;

procedure TForm1.Button28Click(Sender: TObject);
begin
   insert_text_fromfile('�̶���Ʒ');
end;

procedure TForm1.insert_text_fromfile(const s: string);
var str1: Tstringlist;
    ss: string;
begin
    str1:= Tstringlist.Create;
        if FileExists(extractfilepath(application.ExeName)+'highlighters\�༭.txt') then
           str1.LoadFromFile(extractfilepath(application.ExeName)+'highlighters\�༭.txt');


      ss:= str1.Values[s];
      if ss= '' then
       begin
         messagebox(handle,'�༭.txt �ļ������ڻ�������Ϊ�ա�','����',mb_ok);
         shellexecute(handle,'open',pchar(extractfilepath(application.ExeName)+'highlighters\�༭.txt'),nil,nil,sw_shownormal);
       end else begin
                  ss:=StringReplace(ss,'$br$',#13#10,[rfReplaceAll]);
                 syneditor1.SelText:= ss;
                end;
    str1.Free;
end;

procedure TForm1.Button29Click(Sender: TObject);
begin
   insert_text_fromfile('�����Ʒ');
end;

procedure TForm1.Button30Click(Sender: TObject);
begin
   insert_text_fromfile('�Թ��Ķ�');
end;

procedure TForm1.Button32Click(Sender: TObject);
begin
  insert_text_fromfile('����ͼƬ');
end;

procedure TForm1.Button34Click(Sender: TObject);
var i: integer;
begin
  insert_text_fromfile('�Թ��Ѷ�');
  if not TryStrToInt(syneditor1.Lines.Values['����'],i) then
    i:= 0;

    i:= i or 4;
    syneditor1.Lines.Values['����']:= inttostr(i);
end;

procedure TForm1.Button35Click(Sender: TObject);
begin
  insert_text_fromfile('�Զ���һ');
end;

procedure TForm1.Button36Click(Sender: TObject);
begin
  insert_text_fromfile('�Զ����');
end;

procedure TForm1.Button38Click(Sender: TObject);
begin
 insert_text_fromfile('�Զ�����');
end;

procedure TForm1.Button43Click(Sender: TObject);
var i: integer;
begin
  for i:= 0 to syneditor1.Lines.Count-1 do
     syneditor1.SetLineColorToDefault(i);

end;

procedure TForm1.Button42Click(Sender: TObject);
begin
     //�����ɫ
  spell_scene(true);
   StatusBar1.Panels[0].Text:='';
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
shellexecute(handle,'open',pchar(extractfilepath(application.ExeName)+'highlighters\��ģ.txt'),nil,nil,sw_shownormal);

end;

procedure TForm1.Label18Click(Sender: TObject);
begin
    open_new_file('new_mg.txt',l_html);

end;

procedure TForm1.Button24Click(Sender: TObject);
begin
   if syneditor1.SelLength>0 then
    N76Click(sender)
    else messagebox(handle,'����ѡ��Ҫ�����Ի������֡�','ѡ������',mb_ok);

end;

procedure TForm1.Button23Click(Sender: TObject);
begin
   if syneditor1.SelLength>0 then
    N98Click(sender)
    else begin
     syneditor1.SelText:='<a href="game_page(1)" title="">������</a>';
      syneditor1.CaretX:= syneditor1.CaretX- 22;
     SynEditor1Change(sender); //�ļ�����
         end;
end;

procedure TForm1.N124Click(Sender: TObject); //����ģ���ļ�
var b: boolean;
begin
     opendialog3.filename:='';
      b:= (GetKeyState(VK_SHIFT) < 0);

      opendialog3.InitialDir:= ExtractFilePath(application.ExeName)+'highlighters\��ģ';
   opendialog3.FilterIndex:= 1;
     if opendialog3.Execute then
        begin
         if file_is_change or b then
            open_file_shell(opendialog3.FileName)
            else begin
         syneditor1.ClearAll;
         caption:= edit_caption+ ' --'+ opendialog3.FileName;
         application.Title:= ExtractFileName(opendialog3.FileName)+ ' - ��Ϸ�༭��';
         syneditor1.Lines.LoadFromFile(opendialog3.FileName);
         syneditor1.InitCodeFolding; //�ػ��۵���
         file_open_type:= 4;
          if (syneditor1.Lines.Count>0) and (pos('��ͼ=',syneditor1.Lines.Strings[0])>0) then
             open_file_type:= l_jianmo;
                 end;
        end;
end;

procedure TForm1.Button47Click(Sender: TObject);
begin
     savedialog2.filename:='';
      savedialog2.InitialDir:= ExtractFilePath(application.ExeName)+'highlighters\��ģ';
      savedialog2.filename:= syneditor1.Lines.Values['����'];
     N72Click(sender);
end;

procedure TForm1.show_l_gpic_base;
var ss: string;
    i,j: integer;
begin
   Edit_gpic.Tag:= 0;
     //����ǰ��־��Ϊ��
      ss:= syneditor1.LineText;
      j:= pos('gpic:/',ss);
      if j= 0 then
       exit;

       delete(ss,1,j+6);
       for i:= 1 to length(ss) do
        if ss[i]='"' then
          begin
           ss:= copy(ss,1,i-1);
           break;
          end else if ss[i]='.' then
                    begin
                     ss:= copy(ss,1,i+3);
                     break;
                    end;
           
      if ss<> '' then
       begin
         i:= pos(',',ss);
         if (i> 0) and (ss[1] in['0'..'9']) then
          begin
           edit_kuan.Text:= copy(ss,1,i-1);
            delete(ss,1,i);
            i:= pos(',',ss);
            edit_gao.Text:= copy(ss,1,i-1);
             delete(ss,1,i+1); //ɾ������
             i:= pos(')',ss);
             if i>0 then
               form_gpic.StringToFont(copy(ss,1,i-1),label16.Font);

              delete(ss,1,i+1); //ɾ�����źͶ���
              i:= pos(',',ss);
              label15.Color:= StringToColor(copy(ss,1,i-1));
              delete(ss,1,i);
              i:= pos(',',ss);
              edit_gpic.Text:= copy(ss,1,i-1); //����
              delete(ss,1,i);
              i:= pos(',',ss);
              if TryStrToInt(copy(ss,5,2),j) then
                 combobox1.ItemIndex:= j; //ʶ��Ч��
              delete(ss,1,i);
              i:= pos(',',ss);
              if (ss<>'') and (ss[1]='1') then
                 checkbox1.Checked:= true
                 else
                   checkbox1.Checked:= false;
              delete(ss,1,i);
              i:= pos('/',ss);
              edit_touming.Text:= copy(ss,1,i-1); //͸��
          end else begin
                     edit_kuan.Text:= '';
                     edit_gao.Text:= '';
                     edit_gpic.Text:= ss;
                   end;
         Edit_gpic.Tag:= 100;
       end;
end;

procedure TForm1.show_l_shuxing_base;
var i: integer;
begin
     if not TryStrToInt(syneditor1.Lines.Values['����'],i) then
        i:= 0;

        checkbox2.Checked:= i and 4=4;
        checkbox3.Checked:= i and 2=2;
        checkbox4.Checked:= i and 8=8;
        checkbox5.Checked:= i and 64=64;
        checkbox6.Checked:= i and 256=256;
end;

procedure TForm1.CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
begin
     if not TryStrToInt(syneditor1.Lines.Values['����'],i) then
        i:=1;

   if checkbox2.Checked then
     i:= i or 4
     else
       i:= i and not 4;

       if checkbox3.Checked then
          i:= i or 2
          else
           i:= i and not 2;

       if checkbox4.Checked then
         i:= i or 8
         else i:= i and not 8;

       if checkbox5.Checked then
          i:= i or 64
          else i:= i and not 64;

        if checkbox6.Checked then
          i:= i or 256
          else i:= i and not 256;

      syneditor1.Lines.Values['����']:= inttostr(i);

end;

function TForm1.compo_gpic: string;
begin
     if (edit_kuan.Text= '') or (edit_gao.Text= '') then
      begin
        if edit_gpic.Text= '' then
           result:= ''
           else result:= 'gpic://'+ edit_gpic.Text;
      end else begin
                 result:='gpic://'+ edit_kuan.Text+ ','+ edit_gao.Text;
                 result:=result +',('+ form_gpic.FontToString(label16.Font)+')'; //����
                 result:=result +','+ ColorToString(label15.Color); //����ɫ
                 result:=result +','+ edit_gpic.Text; //����
                 if combobox1.ItemIndex < 10  then
                    result:= result + ',' +  'AT100'+ inttostr(combobox1.ItemIndex)
                  else
                     result:= result + ',' +  'AT10'+ inttostr(combobox1.ItemIndex); //��ʾЧ��

                 if checkbox1.Checked then
                    result:= result + ',1' //����
                    else
                     result:= result + ',0';

                 if edit_touming.Text= '' then
                 result:= result + ',0'
                  else
                   result:= result + ',' + edit_touming.Text; //͸����

                result:= result + '/2007.bmp';
               end;
end;

procedure TForm1.Edit_gpicExit(Sender: TObject);
begin

    edit_gpic.Tag:= label11.Tag;
    
   if edit_gpic.Text='' then
   begin
   if messagebox(handle,'����Ϊ�գ��Ƿ�ɾ���˶���','��Ч����',mb_yesno)= mryes then
      begin
        edit_kuan.Text:= '';
        edit_gao.Text:= '';
      end;
   end else begin
              if (pos(',',edit_gpic.Text)>0) or (pos('.',edit_gpic.Text)>0) then
                begin
                   messagebox(handle,'���ݲ��ܰ�����Ӣ�Ķ��Ż���Բ�����','��Ч����',mb_ok);
                   edit_gpic.SetFocus;
                end;
            end;

end;

procedure TForm1.Edit_gpicChange(Sender: TObject);
var ss: string;
    i,j,k: integer;
begin
   if Edit_gpic.Tag= 0 then
      exit
      else if edit_gpic.Tag= 60 then
             begin
               edit_kuan.Text:= inttostr(label16.Canvas.TextWidth(Edit_gpic.Text));
               edit_gao.Text:= inttostr(label16.Canvas.TextHeight('��'));
             end;

    ss:= syneditor1.LineText;
    j:= pos('gpic:/',ss);
    if j> 0 then
     begin
      k:= 0;
       for i:= j to length(ss) do
           if ss[i]= '"' then
             begin
              k:= i-1;
              break;
             end  else if ss[i]='.' then
                       begin
                       k:= i+ 3;
                       break;
                       end;
                       
       if (k> 0) and (k >j) then
        begin
         delete(ss,j,k-j+1);
         insert(compo_gpic, ss,j);
         syneditor1.LineText:= ss;
        end;
     end; //if


end;

procedure TForm1.Label15Click(Sender: TObject);
begin
      //ѡ�񱳾�ɫ
        colordialog1.Color:= Label15.Color;
     if colordialog1.Execute then
        begin
          Label15.Color:= colordialog1.Color;
          Edit_gpicChange(sender);
        end;
     
end;

procedure TForm1.Label16Click(Sender: TObject);
begin
    //ѡ����
         form_gpic.FontDialog1.Font:= Label16.Font;
         
      if form_gpic.FontDialog1.Execute then
       begin
         Label16.Font:= form_gpic.FontDialog1.Font;
         edit_kuan.Text:= inttostr(label16.Canvas.TextWidth(Edit_gpic.Text));
         edit_gao.Text:= inttostr(label16.Canvas.TextHeight('��'));
         Edit_gpicChange(sender);
       end;
     
end;

procedure TForm1.Edit_gpicEnter(Sender: TObject);
begin
    label11.Tag:=edit_gpic.Tag;
    edit_gpic.Tag:= 60;
end;

procedure TForm1.open_new_file(n: string; p: Tlift_page_type);
begin
   if file_is_change or (GetKeyState(VK_SHIFT) < 0) then
    begin
      case messagebox(handle,'��ǰ�ļ��޸ĺ�û�б��棬�Ƿ񱣴棿','�����ļ�',mb_yesnocancel or MB_ICONQUESTION) of
      mryes: save_file;
      mrcancel: exit;
      end;
     // open_file_shell(ExtractFilePath(application.ExeName)+'highlighters\new_mg.txt');
     // exit;
    end;

  SynEditor1.Lines.Clear;
  SynEditor1.lines.LoadFromFile(ExtractFilePath(application.ExeName)+'highlighters\'+n);
  //SynEditor1.lines.Values['id']:= get_scene_id;

   syneditor1.InitCodeFolding;
  syneditor1.Repaint;

  file_is_change:= false;
  opened_file_name:= '';
  caption:= edit_caption +'--'+ n;
  application.Title:= ExtractFileName(n)+ ' - ��Ϸ�༭��';

  open_file_type:= p; //�½��˳����ļ�
  pagecontrol1.ActivePageIndex:= ord(open_file_type);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
   open_new_file('new_upp.txt',l_new);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
    open_new_file('new_��Ʒ.txt',l_wupin);
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
       open_new_file('new_����.txt',l_renwu);
       file_open_type:= 2;
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
        open_new_file('new_����.txt',l_guaiwu);
end;

procedure TForm1.ID2Click(Sender: TObject);
var ss: string;
    i: integer;
    str1: Tstringlist;
begin
  //ʶ����������Ʒ��Ϣ
    ss:= syneditor1.WordAtCursor;
    if length(ss)> 3 then
       exit;

    if not TryStrToInt(ss,i) then
       exit;

    if i= 0 then
      exit;

  screen.Cursor:= crhourglass;
    str1:= Tstringlist.Create;
      open_file_upp(data_path+ 'dat\guai.upp',str1);
      ss:= '��ţ�'+ ss+ #13#10 +
           '�������ԣ�'+ str1.Values[inttostr(i)]+ #13#10;

      str1.Clear;
      open_file_usp(data_path+ 'goods.usp',str1);
      ss:=  ss+
           '��Ʒ��'+ str1.Values[inttostr(i)];
    str1.Free;
  screen.Cursor:= crdefault;
  messagebox(handle,pchar(ss),'����',mb_ok);
end;

procedure TForm1.Label10Click(Sender: TObject);
begin
    //�򿪹���
    open_file_upp(data_path+ 'dat\guai.upp');

end;

procedure TForm1.Label8Click(Sender: TObject);
begin
    //�����
    Button4Click(label8);
end;

procedure TForm1.N129Click(Sender: TObject);
begin
    insert_text_fromfile('allifthen');
end;

procedure TForm1.ifthen1Click(Sender: TObject);
begin
   insert_text_fromfile('ifthen');
end;

procedure TForm1.N130Click(Sender: TObject);
var i,j: integer;
     b: boolean;
begin
 b:= false;
    for i:= 1 to 99 do
     if syneditor1.Lines.Values['D'+inttostr(5000+ i)]= '' then
       begin
        syneditor1.SelText:= 'D'+inttostr(5000+ i)+';';
         for j:= 0 to syneditor1.Lines.Count -1 do
           begin
             if pos('����=',syneditor1.Lines[j])= 1 then
                b:= true
                else if b and (pos('}',syneditor1.Lines[j])>0) then
                       begin
                         syneditor1.Lines.Insert(j,'D'+inttostr(5000+ i)+ '=');
                         syneditor1.CaretX:= 7;
                         syneditor1.CaretY:= j+1;
                         syneditor1.SetFocus;
                         exit;
                       end;
           end; // for j
        exit;
       end;
end;

procedure TForm1.Button51Click(Sender: TObject);
 var i,j,k,L,i_max,i_pos,i_max_pos,row: integer;
     ss,ss2: string;
     r: array of integer;
     label pp;
      function get_a_rnd: integer;
       var i8: integer;
       begin
         while true do
          begin
          result:= random(i_max) + 1;
           for i8:= 0 to high(r) do
             begin
              if i8= high(r) then exit;
               if (r[i8]= result) then
                  break
                  else begin
                        if r[i8]= 0 then
                         begin
                        r[i8]:= result;
                        exit;
                         end;
                       end;
             end;
          end; // while
       end; //func
       function get_link: string;
        begin
        result:= '';
          while random(trackbar1.Position * trackbar1.Position+2)< trackbar1.Position+1 do
           begin
           result:= result +','+ inttostr(random(i_max)+1);
           end;
          if result<> '' then
            begin
               delete(result,1,1); //ɾ����һ������
               result:= '('+result +')';
            end;
        end;

begin
    if TryStrToInt(edit2.Text,i_max) then
        dec(i_max)
       else
         i_max:= 24;   //��ഴ���ĳ����� +1
         
    if i_max<= 0 then
       exit;

       setlength(r,i_max);

    //i_pos:= 0; //��ǰλ��
   // i_max_pos:= 0; //���λ��

     Randomize; //��ʼ�������

    row:= SynEditor1.CaretY-1;
    for j:= 1 to strtoint(edit3.text) do
    begin
      SynEditor1.Lines.Insert(row,';;'+inttostr(j)+' ������ɵ�ģ�ͣ��粻���룬��ɾ���ؽ�');
      inc(row);
    ss:= get_scene_id+'[-1]>1';
    fillchar(r[0],Sizeof(integer)*i_max,0);
    r[0]:= 1;
     i_max_pos:= 11;
    i:= 1;

     while i < i_max do
      begin
        if checkbox7.Checked then
           k:= get_a_rnd
           else
            k:= i+1;
        ss:= ss+ '>'+ inttostr(k)+ get_link;
         i_pos:= length(ss);
         if i_max_pos< i_pos then
            i_max_pos:=i_pos;

          SynEditor1.Lines.strings[row]:=ss;
         if random(5)= 0 then
            begin
              //����
              ss:= format('%'+ inttostr(random(i_max_pos))+'s',[' ']);

              inc(row);
              SynEditor1.Lines.Insert(row,'');
            end;
       inc(i);
      end; //while
      inc(row);
      SynEditor1.Lines.Insert(row,'');
      inc(row);
      SynEditor1.Lines.Insert(row,'');
    end; //for

    //����
    for i:= SynEditor1.CaretY to SynEditor1.Lines.Count-1 do
     begin
        ss:= SynEditor1.Lines.Strings[i];
        j:= pos('>',ss);
        if (j=1) or ((j>1) and (ss[j-1]=' ') and (ss[1]<>';')) then
         begin
           for k:= i-1 downto SynEditor1.CaretY do
            begin
             ss2:= SynEditor1.Lines.Strings[k];
             if (length(ss2)< j) or (ss2[j]=' ') then
                Continue;

             for L:= j to length(ss2) do
                if (ss2[L]= '>') or (L= length(ss2)) then
                 begin
                   if L-j >0 then
                    begin
                      ss:=format('%'+ inttostr(L-j)+'s',[' '])+  ss;
                       SynEditor1.Lines.Strings[i]:= ss;
                    end;

                    goto pp;
                 end;
            end; //end for k
            pp:
         end;
     end;
end;
function trans1(const d:string):string;
var
 i:integer; 
begin
result:= '';
 if d= '' then
    exit;
result:= '';
 for i:=1 to length(d) do
 begin 
   case d[i] of
     '0':result:=result+'��';
     '1':result:=result+'һ';
     '2':result:=result+'��';
     '3':result:=result+'��';
     '4':result:=result+'��';
     '5':result:=result+'��';
     '6':result:=result+'��';
     '7':result:=result+'��';
     '8':result:=result+'��';
     '9':result:=result+'��';
   end;
     case length(d)-i of
       1:result:=result+'ʮ';
       2:result:=result+'��';
       3:result:=result+'ǧ';
       4:result:=result+'��';
       5:result:=result+'ʮ';
       6:result:=result+'��';
     end; 
   end 

end;

procedure TForm1.Button54Click(Sender: TObject);
var str1: Tstringlist;
     ss,ss2: string;
      procedure create_new_id;
       var i2: integer;
       begin
         i2:= 9000;
         while str1.Values[inttostr(i2)]<> '' do
             inc(i2);

         edit4.Text:= inttostr(i2);
       end;
begin
   
   if edit4.Text= '' then
     begin
       messagebox(handle,'��Ų���Ϊ��','����',mb_ok);
       edit4.SetFocus;
       exit;
     end;
    if (edit6.Text= '') or (edit6.Text= '��Ʒ��') then
     begin
       messagebox(handle,'������Ҫ����Ʒ������Ϊ��','����',mb_ok);
       edit6.SetFocus;
       exit;
     end;
    if (edit11.Text= '') or (edit11.Text= '�ص�') then
     begin
       messagebox(handle,'�����ύ�ص㲻��Ϊ�գ������д ���ִ壬С����','����',mb_ok);
       edit11.SetFocus;
       exit;
     end;

   //��������Ƿ����
   str1:= Tstringlist.Create;
     str1.LoadFromFile(extractfilepath(application.ExeName)+'highlighters\�༭.txt');
     ss:= str1.Values['task'];
       if ss='' then
     begin
       messagebox(handle,'�༭.txt�ļ���task�β����ڡ�','����',mb_ok);
       str1.Free;
       exit;
     end;
      str1.Clear;
    //������
    open_file_upp(data_path+ 'dat\task.upp',str1);
     if str1.Values[edit4.Text]<> '' then
      begin
       case messagebox(handle,'��ǰ��ŵ������Ѿ����ڣ�ѡ���ǡ�����Ϊ�������ţ�ѡ�񡰷��滻�Ѵ������ݣ�ѡ��ȡ����ֹͣ������','����',mb_yesnocancel) of
        mryes   :begin
                  create_new_id;
                 end;
        mrno    :begin

                 end;
        mrcancel: begin
                   str1.Free;
                   exit;
                  end;
        end;
      end;
     //9017=���ִ壬�ﶹ�����ɷ��ۣ�����100��ң�100���飬�������˲Ρ�2��
   ss2:= edit11.Text+'���ɼ�'+ trans1(edit7.text)+'��'+edit6.Text;
       if (edit5.Text<>'') and (edit5.Text<>'0') then
          ss2:= ss2+ '(��'+trans1(edit5.Text)+'������)';
   ss2:= ss2 +'������'+ edit8.Text +'��ң�' + edit9.Text +'���顣';
   if (edit10.Text<>'') and (edit10.Text<>'��Ʒ��') then
      ss2:= ss2 + '��'+ edit10.Text +'��1��';

    str1.Values[edit4.Text]:= ss2;
    DeleteFile(data_path+ 'dat\task.upp');
    save_upp_base(data_path+ 'dat\task.upp',str1);
   str1.Free;


     ss:=StringReplace(ss,'$br$',#13#10,[rfReplaceAll]);
     ss:=StringReplace(ss,'$id$',edit4.Text,[rfReplaceAll]);
     ss:=StringReplace(ss,'$��Ʒ$',edit6.Text,[rfReplaceAll]);
     ss:=StringReplace(ss,'$����$',edit7.Text,[rfReplaceAll]);
     ss:=StringReplace(ss,'$����$',edit8.Text +'��ң�' + edit9.Text +'����',[rfReplaceAll]);

    create_npc_chat(ss);
end;

procedure TForm1.Edit10Enter(Sender: TObject);
begin
  if tedit(sender).Text='��Ʒ��' then
     tedit(sender).Text:= '';
end;

procedure TForm1.Edit10Exit(Sender: TObject);
begin
  if tedit(sender).Text='' then
     tedit(sender).Text:= '��Ʒ��';
end;

procedure TForm1.save_upp_base(const n: string; str1: Tstringlist);
var stream1: TMemoryStream;
begin
   game_add_password(str1); //���ĵ���������

    stream1:= TMemoryStream.Create;
     str1.SaveToStream(stream1);
     stream1.Position:= 0;
    vclzip1.Password:= 'AGP2@3%N';
     vclzip1.ZipName:= n;
    vclzip1.ZipFromStream(stream1,n);

   // vclzip1.Zip;
   stream1.Free;
end;

procedure TForm1.Edit11Enter(Sender: TObject);
begin
    if edit11.Text='�ص�' then
       edit11.Text:= '';
end;

procedure TForm1.Edit11Exit(Sender: TObject);
begin
    if edit11.Text='' then
       edit11.Text:= '�ص�';
end;

end.


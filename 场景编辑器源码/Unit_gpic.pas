unit Unit_gpic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,jpeg, ExtDlgs;

type
  TForm_gpic = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label9: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    CheckBox2: TCheckBox;
    Button3: TButton;
    ComboBox2: TComboBox;
    Button4: TButton;
    Label10: TLabel;
    Button5: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    procedure show_text_info;
    procedure show_mob(n: string);
  public
   text_result: string;
   procedure StringToFont(sFont : string; Font : TFont );
   function FontToString(Font : TFont ) : string;
   
    { Public declarations }
  end;

var
  Form_gpic: TForm_gpic;

implementation
    uses Unit_paiban,unit1;
{$R *.dfm}

const 
 csfsBold      = '|Bold';     
 csfsItalic    = '|Italic';   
 csfsUnderline = '|Underline'; 
 csfsStrikeout = '|Strikeout';
procedure TForm_gpic.StringToFont(sFont : string; Font : TFont );
var
  p : integer;
  sStyle : string;
begin
  with Font do
  begin
    // get font name
    p := Pos( ',', sFont );
    Name := Copy( sFont, 1, p-1 );
    Delete( sFont, 1, p );

    // get font charset
    p := Pos( ',', sFont );
    Charset :=StrToInt( Copy( sFont, 1, p-1 ) );
    Delete( sFont, 1, p );

    // get font size
    p := Pos( ',', sFont );
    Size :=StrToInt( Copy( sFont, 1, p-1 ) );
    Delete( sFont, 1, p );

    // get font style
    p := Pos( ',', sFont );
    sStyle := '|' + Copy( sFont, 2, p-3 );
    Delete( sFont, 1, p );

    // get font color
    Color :=StringToColor(Copy( sFont, 2,Length( sFont ) - 2 ) );

    // convert str font style to font style
    Style := [];

    if( Pos( csfsBold,sStyle ) > 0 )then
      Style := Style + [ fsBold ];

    if( Pos( csfsItalic,sStyle ) > 0 )then
      Style := Style + [ fsItalic ];

    if( Pos( csfsUnderline,sStyle ) > 0 )then
      Style := Style + [ fsUnderline ];

    if( Pos( csfsStrikeout,sStyle ) > 0 )then
      Style := Style + [ fsStrikeout ];
  end;
end;

function TForm_gpic.FontToString(Font : TFont ) : string;
var
  sStyle : string;
begin
  with Font do
  begin
    // convert font style to string
    sStyle := '';

    if( fsBold in Style )then
       sStyle := sStyle + csfsBold;

    if( fsItalic in Style )then
       sStyle := sStyle + csfsItalic;

    if( fsUnderline in Style )then
       sStyle := sStyle + csfsUnderline;

    if( fsStrikeout in Style )then
       sStyle := sStyle + csfsStrikeout;

    if( ( Length( sStyle ) > 0 ) and ( '|' = sStyle[ 1 ] ) )then //ȥ����һ�� ��|��
    begin
       sStyle := Copy( sStyle, 2,Length( sStyle ) - 1 );
    end;

    Result := Format('%s,%d,%d,{%s},{%s}',
         [ Name, //���������
           CharSet, //�ַ���
           Size, //����Ĵ�С
           sStyle, //���������
           ColorToString( Color ) ]   //�������ɫ
          );
  end;
end;

procedure TForm_gpic.Label2Click(Sender: TObject);
begin
  fontdialog1.Font:= label2.Font;
  if fontdialog1.Execute then
    begin
     label2.Font:= fontdialog1.Font;
     Edit1Change(sender);
     if pos('{',edit1.Text)> 0 then
      begin
        if messagebox(handle,'���޸��������С��ԭ�ȵĶ�λ��Ϣ����׼ȷ���Ƿ������Ű涨λ��',
           'ѯ��',mb_yesno or MB_ICONQUESTION)= mryes then
             button3click(sender);
      end;
    end;
end;

procedure TForm_gpic.Label3Click(Sender: TObject);
begin
 if colordialog1.Execute then
    label3.Color:= colordialog1.Color;
end;

procedure TForm_gpic.Button1Click(Sender: TObject);
begin
  if edit1.Text= '' then
    begin
      messagebox(handle,'�������ݲ���Ϊ�ա�','��ʾ',mb_ok);
      edit1.SetFocus;

      exit;
    end;
   if pos(',',edit1.Text)> 0 then
    begin
      if messagebox(handle,'�����ڲ��ܺ���Ӣ�Ķ��ţ��Ƿ��滻Ϊ���Ķ��ţ�','��ʾ',mb_yesno)= mryes then
       begin
        edit1.Text:= StringReplace(edit1.Text,',','��',[rfReplaceAll]);
       end else begin
                edit1.SetFocus;
                exit;
                end;
    end;

  if checkbox1.Checked then
  text_result:= 'gpic://'
  else
    text_result:= '<img src="gpic://';
 //���ߣ����壬����ɫ�����ݣ�Ч����͸����
  if edit2.Text= '' then
     text_result:= text_result + '0'
     else
      text_result:= text_result + edit2.Text; //��

   if edit3.Text= '' then
     text_result:= text_result + ',0'
     else
      text_result:= text_result + ',' + edit3.Text; //��

     text_result:= text_result + ',(' + FontToString(label2.Font)+')'; //����
     text_result:= text_result + ',' + ColorToString(label3.Color); //����ɫ
     text_result:= text_result + ',' + edit1.Text; //����
     
      if combobox1.ItemIndex < 10  then
        text_result:= text_result + ',' +  'AT100'+ inttostr(combobox1.ItemIndex)
      else
         text_result:= text_result + ',' +  'AT10'+ inttostr(combobox1.ItemIndex); //��ʾЧ��

     if checkbox2.Checked then
        text_result:= text_result + ',1' //����
        else
         text_result:= text_result + ',0';

     if edit4.Text= '' then
     text_result:= text_result + ',0'
      else
       text_result:= text_result + ',' + edit4.Text; //͸����

    text_result:= text_result + '/2007.bmp';

    if not checkbox1.Checked then
       text_result:= text_result + '">';

 self.ModalResult:= mrok;
end;

procedure TForm_gpic.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm_gpic.FormCreate(Sender: TObject);
begin
 label3.Color:= clwindow;
 show_text_info;
 SetWindowLong(Edit2.Handle, GWL_STYLE, GetWindowLong(Edit2.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit3.Handle, GWL_STYLE, GetWindowLong(Edit3.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit4.Handle, GWL_STYLE, GetWindowLong(Edit4.Handle, GWL_STYLE) or ES_NUMBER);

end;

procedure TForm_gpic.show_text_info;
begin
  edit1.Hint:= format('��ǰ������%D���أ��߶�%D���ء������ܳ���%D',[
        label2.Canvas.TextWidth('��'),
        label2.Canvas.TextHeight('��'),
        label2.Canvas.TextWidth(edit1.Text)]);
end;

procedure TForm_gpic.Button3Click(Sender: TObject);
begin
  if not Assigned(Form_paiban) then
     Form_paiban:= TForm_paiban.Create(application);

   Form_paiban.char_w:= label2.Canvas.TextWidth('��');
    Form_paiban.char_H:= label2.Canvas.TextHeight('��');
    text_result:= edit1.Text;
   Form_paiban.ShowModal;
   edit1.Text:= text_result;
end;

procedure TForm_gpic.FormShow(Sender: TObject);
var vSearchRec: TSearchRec;
  vPathName: string;
  K: Integer;
  str1: Tstringlist;
begin   //�г�ģ���ļ�

    combobox2.Items.Clear;
   combobox2.Items.Add('ģ��');

   if FileExists(extractfilepath(application.ExeName)+'highlighters\mobset.dat') then
   begin
   vPathName := extractfilepath(application.ExeName)+'highlighters\*.mob';
  K := FindFirst(vPathName, faAnyFile, vSearchRec);
  while K = 0 do
  begin
    if Pos(vSearchRec.Name, '..') = 0 then
    begin
      combobox2.Items.Add(vSearchRec.Name);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);
    str1:= Tstringlist.Create; //�����ϴα����ģ���ļ����
     str1.LoadFromFile(extractfilepath(application.ExeName)+'highlighters\mobset.dat');
     if str1.Values['index']= '' then
        combobox2.ItemIndex:= combobox2.Items.Count-1
        else
         combobox2.ItemIndex:= strtoint(str1.Values['index']);
    str1.Free;
   end else
         combobox2.ItemIndex:= 0;

   if combobox2.ItemIndex > 0 then  //0������Ϊ˵������
    begin
      show_mob(combobox2.Items.Strings[combobox2.ItemIndex]);
    end;
end;

procedure TForm_gpic.Button4Click(Sender: TObject);
var ss: string;
    str1: tstringlist;
begin
   //����ģ��
  ss:= inputbox('������ģ������   ','ģ������  ','');
  if ss<> '' then
   begin
     str1:= Tstringlist.Create;

      str1.Values['edit2']:= edit2.Text; //��
      str1.Values['edit3']:= edit3.Text; //  ��
      str1.Values['edit4']:= edit4.Text; //   ͸����
      str1.Values['combobox1']:= inttostr(combobox1.ItemIndex); //  ��ʾЧ��
      str1.Values['label3']:= colortostring(label3.Color);      //����ɫ
       str1.Values['label2']:= fonttostring(label2.Font);       //����
       str1.Values['checkbox2']:= booltostr(checkbox2.Checked); //�Ƿ񸡵�Ч��
       str1.Values['checkbox1']:= booltostr(checkbox1.Checked); //�����gpic��ַ

        str1.savetofile(extractfilepath(application.ExeName)+'highlighters\'+ ss
                        + '.mob');

       combobox2.Items.Append(ss + '.mob');
       combobox2.ItemIndex:= combobox2.Items.Count-1;

      str1.Clear;
       str1.Append('index='+ inttostr(combobox2.ItemIndex));
       str1.savetofile(extractfilepath(application.ExeName)+'highlighters\mobset.dat');
      str1.free;
   end;
end;

procedure TForm_gpic.show_mob(n: string);
var str1: tstringlist;
begin
    //��ʾģ��
       str1:= Tstringlist.Create; //�����ϴα����ģ���ļ����
      str1.LoadFromFile(extractfilepath(application.ExeName)+'highlighters\'+ n
                        );
      edit2.Text:= str1.Values['edit2']; //��
      edit3.Text:= str1.Values['edit3']; //  ��
      edit4.Text:= str1.Values['edit4']; //   ͸����
      combobox1.ItemIndex:= strtoint(str1.Values['combobox1']); //  ��ʾЧ��
      label3.Color:= stringtocolor(str1.Values['label3']); //����ɫ
       stringtofont(str1.Values['label2'],label2.Font); //����
       checkbox2.Checked:= strtobool(str1.Values['checkbox2']); //�Ƿ񸡵�Ч��
        checkbox1.Checked:= strtobool(str1.Values['checkbox1']); //�����gpic��ַ

      str1.free;
end;

procedure TForm_gpic.ComboBox2Select(Sender: TObject);
begin
     if combobox2.ItemIndex> 0 then
      begin
        show_mob(combobox2.Items.Strings[combobox2.ItemIndex]);
      end;
end;

procedure TForm_gpic.Edit1Change(Sender: TObject);
begin
  show_text_info;
  if pos('{',edit1.Text)= 0 then
    begin
     edit2.Text:= inttostr(label2.Canvas.TextWidth(edit1.Text));
     edit3.Text:= inttostr(label2.Canvas.TextHeight('��'));
    end else begin
              edit2.Text:= '0';
              edit3.Text:= '0';
             end;
end;

procedure TForm_gpic.Button5Click(Sender: TObject);
begin
openpicturedialog1.InitialDir:= data_path+'img';
 if OpenPictureDialog1.Execute then
  begin
   if not FileExists(data_path+'img\'+ ExtractFileName(OpenPictureDialog1.FileName)) then
           copyfile(pchar(OpenPictureDialog1.FileName),pchar(data_path+'img\'+ ExtractFileName(OpenPictureDialog1.FileName)),true);

    edit1.Text:= ExtractFileName(OpenPictureDialog1.FileName) + edit1.Text;
  end;
end;

end.

unit Unit_password;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_password = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    RadioButton5: TRadioButton;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Edit4: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_password: TForm_password;

implementation
   uses unit1,md5;
{$R *.dfm}

function game_encrypt(const Src: string): string;
var

KeyLen :Integer;
KeyPos :Integer;
offset :Integer;
dest :string;
SrcPos :Integer;
SrcAsc :Integer;

Range :Integer;
key: string;
begin
    //�����ַ���
    if Src= '' then
     begin
       result:= '';
       exit;
     end;
key:= 'fat dog';
KeyLen:=Length(Key);
KeyPos:=0;
//SrcPos:=0;
//SrcAsc:=0;
Range:=256;

Randomize;
offset:=Random(Range);
dest:=format('%1.2x',[offset]);
for SrcPos := 1 to Length(Src) do
begin
SrcAsc:=(Ord(Src[SrcPos]) + offset) MOD 255;
if KeyPos < KeyLen then KeyPos:= KeyPos + 1 else KeyPos:=1;
SrcAsc:= SrcAsc xor Ord(Key[KeyPos]);
dest:=dest + format('%1.2x',[SrcAsc]);
offset:=SrcAsc;
end;
Result:=Dest;

end;

procedure TForm_password.Button2Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_password.Button1Click(Sender: TObject);
var str1: Tstringlist;
begin
  //һ���Լ��
  if radiobutton1.Checked then
   begin
    if edit1.Text= '' then
     begin
      messagebox(handle,'ѡ���Զ�����ʱ����������Ĭ�����롣','����', mb_ok);
      edit1.SetFocus;
      exit;
     end else begin
                if edit1.Text <> edit2.Text then
                 begin
                  messagebox(handle,'������������벻һ�¡�','����', mb_ok);
                  edit1.SetFocus;
                  exit;
                 end;
              end;
   end;

      if radiobutton3.Checked then
       if edit3.Text= '' then
         begin
          messagebox(handle,'ѡ���Զ����ܣ���ô��������һ��Ĭ�����롣','����', mb_ok);
          edit3.SetFocus;
          exit;
         end;

//��������
   str1:= Tstringlist.Create;
    if radiobutton1.Checked then
        str1.Values['encrypt']:= '1'
        else if radiobutton2.Checked then
          str1.Values['encrypt']:= '2'
           else if radiobutton5.Checked then
                str1.Values['encrypt']:= '3'; //������


        str1.Values['savepas']:= game_encrypt(edit1.Text); //����ʱ�õ�����

       if radiobutton3.Checked then
        str1.Values['dencrypt']:= '1'
        else if radiobutton4.Checked then
          str1.Values['dencrypt']:= '2';

        str1.Values['openpas']:= game_encrypt(edit3.Text); //���ļ�ʱ�õ�����

       if checkbox1.Checked then
          str1.Values['showspace']:= '1'
           else
             str1.Values['showspace']:= '0';

      str1.SaveToFile(ExtractFilePath(application.ExeName)+'highlighters\set.dat');
   str1.Free;
//��������
    Form1.load_password_set;
  self.Close;
end;

procedure TForm_password.FormShow(Sender: TObject);
begin
  case save_type_G of
  1: radiobutton1.Checked:= true;
  2: radiobutton2.Checked:= true;
  3: radiobutton5.Checked:= true;
  end;
  case open_type_G of
  1: radiobutton3.Checked:= true;
  2: radiobutton4.Checked:= true;
  end;
  edit1.Text:= form1.get_save_ps;
  edit2.Text:= edit1.Text;

  edit3.Text:= form1.get_open_ps;

  checkbox1.Checked:= show_space; //�Ƿ�����ʱ��ʾ�հ�ҳ
end;

procedure TForm_password.Button3Click(Sender: TObject);
begin
  if edit1.Text= '' then
   begin
    showmessage('������������������������');
    exit;
   end;

   edit4.Text:= StrMD5(edit1.Text);
end;

end.

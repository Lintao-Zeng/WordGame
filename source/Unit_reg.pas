unit Unit_reg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,System.Hash;

type
  TForm_reg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label14: TLabel;
    Edit12: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function id_bucunzai: boolean; //�ж�id�Ƿ����
  public
    { Public declarations }
  end;

var
  Form_reg: TForm_reg;

implementation
     uses unit_net,unit_glb,unit_data;
{$R *.dfm}

procedure TForm_reg.Button3Click(Sender: TObject);
begin
 if trim(edit1.Text) = '' then
    begin
      messagebox(handle,'�û�Id����Ϊ�ա�','����',mb_ok);
     edit1.SetFocus;
     exit;
    end;

button3.Enabled:= false;

   id_bucunzai;

 button3.Enabled:= true;
end;

procedure TForm_reg.Edit1Change(Sender: TObject);
begin
  label1.Caption:= '*�û�ID��';
end;

function TForm_reg.id_bucunzai: boolean;
var t: cardinal;
    ss: string;
    i: integer;
begin
result:= false;
   if Data_net.g_start_udpserver2(Game_server_addr_g) then
   begin
    Game_wait_ok1_g:= false;
    game_wait_integer_g:= 0;
     t:= GetTickCount;
     //���Ͳ�ѯ���ݣ�Ȼ��ȴ���ѯ���
      ss:= '    '+ edit1.Text;
      i:= byte_to_integer(g_player_isreg_c,false);
      move(i,Pointer(ss)^,4);
      screen.Cursor:= crhourglass;
      sleep(100);
      g_send_msg_str(ss); //�����������
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(100);
      end;
       screen.Cursor:= crdefault;

       if Game_wait_ok1_g then
        begin
         if game_wait_integer_g= 1 then
          begin
           label1.Font.Color:= clgreen;
           label1.Caption:= 'ID����';
           result:= true;
          end else if game_wait_integer_g= 2 then
                    begin
                    label1.Font.Color:= clred;
                    label1.Caption:= 'ID�ѱ�ע��';
                   end else if game_wait_integer_g= 3 then
                       begin
                         label1.Font.Color:= clred;
                         label1.Caption:= '��������ֹע��';
                       end;
        end else begin
                   messagebox(handle,'ͨѶ��ʱ����ѯʧ�ܡ�','����',mb_ok);
                 end;
   end else begin
              messagebox(handle,'���ӷ���������','����',mb_ok);
            end;
end;

procedure TForm_reg.Button2Click(Sender: TObject);
begin
 close;
end;

procedure TForm_reg.Button1Click(Sender: TObject);
var ss: string;
    i: integer;
    t: cardinal;
begin
   if trim(edit1.Text)= '' then
    begin
     messagebox(handle,'�û�Id����Ϊ�ա�','����',mb_ok);
     edit1.SetFocus;
     exit;
    end;

    if edit3.Text= '' then
    begin
     messagebox(handle,'���벻��Ϊ�ա�','����',mb_ok);
     edit3.SetFocus;
     exit;
    end;
    if edit3.Text<> edit4.Text then
    begin
     messagebox(handle,'������������벻һ�¡�','����',mb_ok);
     edit4.SetFocus;
     exit;
    end;
    if (edit5.Text<> '') and (edit6.Text= '') then
    begin
     messagebox(handle,'����д���������⣬������𰸲���Ϊ�ա�','����',mb_ok);
     edit6.SetFocus;
     exit;
    end;

    if edit8.Text= '' then
       edit8.Text:= '0'; //����Ϊ��

    if id_bucunzai then
     begin
      ss:= '    '+ edit1.Text+'|' + edit2.Text;
      i:= byte_to_integer(g_player_reg_c,false);
      move(i,Pointer(ss)^,4); //д��ͷ��Ϣ
      ss:= ss + '|' + THashMD5.GetHashString(edit3.text) +'|' + combobox1.Text;
      ss:= ss + '|' + edit5.Text +'|' + edit6.Text + '|' +edit7.Text;
      ss:= ss + '|' + edit8.Text +'|' + edit9.Text + '|' +edit10.Text;
      ss:= ss + '|' + edit11.Text +'|' + edit12.Text + '|' +edit13.Text;
      ss:= ss + '|' + edit14.Text +'|' + edit15.Text + '|' +edit16.Text;

      if (edit5.Text= '') and (edit6.Text= '') and (edit7.Text= '') and (edit9.Text= '') and
         (edit10.Text= '') and (edit11.Text= '') and (edit12.Text= '') and (edit13.Text= '') and
         (edit14.Text= '') and (edit15.Text= '') and (edit16.Text= '') then
         ss:= ss + '|��'
         else
          ss:= ss + '|��'; //�У���ʾ��дѡ����Ϣ

          button1.Enabled:= false;
          screen.Cursor:= crhourglass;
         sleep(100);
          Game_wait_ok1_g:= false;
           game_wait_integer_g:= 0;
           
         g_send_msg_str(ss); //�����������ע����Ϣ
         t:= GetTickCount;
         while (Game_wait_ok1_g= false) and (GetTickCount -t < 15000) do
          begin
           application.ProcessMessages;
           sleep(100);
          end;  //�ȴ��ظ��ź�
          screen.Cursor:= crdefault;

       if Game_wait_ok1_g then
        begin
         //ע����Ϣ��data1=1��ע��ɹ���2ע��ʧ����ͬ�����ڣ�3ע��ʧ�ܣ�����ԭ��
         case game_wait_integer_g of
         1: begin
             messagebox(handle,'ע��ɹ���','�ɹ�',mb_ok);
             self.ModalResult:= mrok;
            end;
         2: messagebox(handle,'��ͬ���û����ڣ�ע��ʧ�ܡ�','����',mb_ok);
         3: messagebox(handle,'��������ֹע�ᣬע��ʧ�ܡ�','����',mb_ok);
         4: messagebox(handle,'ע��ʧ�ܣ�����ԭ������ϵ���������ܡ�','����',mb_ok);
         end;
        end else begin
                   messagebox(handle,'ͨѶ��ʱ��ע��ʧ�ܡ�','����',mb_ok);
                 end;
       button1.Enabled:= true;
     end else messagebox(handle,'ע��ʧ�ܡ�','����',mb_ok);
end;

procedure TForm_reg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key= #13 then
      key:= #0
      else begin
            if key in['|','''','"'] then
              begin
                messagebox(handle,'��Ϣ�ڲ��ܺ��� | " '' ��Щ���š�','����',mb_ok);
                key:= #0;
              end;
           end;
end;

procedure TForm_reg.FormCreate(Sender: TObject);
begin
   SetWindowLong(Edit8.Handle, GWL_STYLE, GetWindowLong(Edit8.Handle, GWL_STYLE) or ES_NUMBER);
end;

end.

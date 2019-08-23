unit unit_save;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_save = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    function check_password(const s: string): boolean;
  public
   addr: string;
   cunpan: string; //�����̵�ַ
    procedure CreateParams(var Para:TCreateParams);override;
    function get_app_data_path: string;
    { Public declarations }
  end;

var
  Form_save: TForm_save;

implementation
    uses unit1,unit_data,SHFolder,shellapi,md5;
{$R *.dfm}

procedure TForm_save.FormShow(Sender: TObject);
var vSearchRec: TSearchRec;
  vPathName,ss: string;
  j,K: Integer;
  px: array of integer;
begin
   listbox1.Items.Clear;
    setlength(px,1024); //����һ���ڴ�

   vPathName := game_doc_path_G+'save\*.*';   //�������ĵ�·��
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      listbox1.Items.Add(vSearchRec.Name);
       px[listbox1.Count-1]:= vSearchRec.Time;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

   vPathName := game_app_path_G+'save\*.*';   //����������Ŀ¼
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      listbox1.Items.Add(vSearchRec.Name);
       px[listbox1.Count-1]:= vSearchRec.Time;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  vPathName := get_app_data_path + '\��������Ϸ��������\*.*';  //�ٴ�����app·��
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      listbox1.Items.Add(vSearchRec.Name);
      px[listbox1.Count-1]:= vSearchRec.Time;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  screen.Cursor:= crhourglass;
   listbox1.Items.BeginUpdate;
    for j:= 1 to listbox1.Count-1 do
     begin
       for k:= j to listbox1.Count-1 do
         begin
           if px[k] > px[j-1] then
             begin
                ss:= listbox1.Items.Strings[k];
                listbox1.Items.Strings[k]:= listbox1.Items.Strings[j-1];
                listbox1.Items.Strings[j-1]:= ss;
                px[k]:= px[k] xor px[j-1];   //����ֵ
                px[j-1]:= px[k] xor px[j-1];
                px[k]:= px[k] xor px[j-1];
             end;
         end;
     end;

   for k:= 0 to 49 do
  listbox1.Items.Append('');

  listbox1.Items.endUpdate;
 screen.Cursor:= crdefault;

end;

procedure TForm_save.Button3Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_save.Button1Click(Sender: TObject);
    function get_date_str: string;
     var s: string;
     begin
       s:= datetimetostr(now);
       s:= StringReplace(s,' ','',[rfReplaceAll]);
       s:=StringReplace(s,'-','',[rfReplaceAll]);
       s:=StringReplace(s,':','',[rfReplaceAll]);
       s:=StringReplace(s,'/','',[rfReplaceAll]);
       s:=StringReplace(s,'\','',[rfReplaceAll]);
       result:= s;
     end;
var ss,ss2,gsfNmae: string;
    str1: Tstringlist;
begin
     if game_debug_handle_g<> 0 then
     begin
      messagebox(handle,'����ʱ���ܴ��̡�','��ʾ',mb_ok);
     exit;
     end;
   if (Game_scene_type_G and 2 = 2) and (Sender= button1) then  //���Թ�
    begin
      messagebox(handle,'�Թ��ڲ��ܴ��̣���Ҫ�˳��Թ�����ʹ����Ϸ���ߴ洢�����̡�','��ʾ',mb_ok);
     exit;
     end;

    if game_role_list.Count=0 then
  begin
   if (sender<> form1) and (sender<>button7) then
    begin
       messagebox(handle,'��Ϸû�п�ʼ�����ȿ�ʼ��Ϸ����������ȡ�','��Ϸû��ʼ',mb_ok);
     exit;
    end;
  end;
    if game_at_net_g then
     begin
      messagebox(handle,'������Ϸ���ô���','��ʾ',mb_ok);
     exit;
     end;

   //����
     if checkbox1.Checked then
     begin
      if edit1.Text= '' then
       begin
        messagebox(handle,'��ѡ���˼��ܴ浵������û���������롣�������½ǵ���������������롣','��������',mb_ok);
        screen.Cursor:= crdefault;
        exit;
       end;
      if edit1.Text<> edit2.Text then
       begin
        messagebox(handle,'��ǰ��������������벻ͬ��������ٴ��ظ������������ͬ��','����ͬ������',mb_ok);
        screen.Cursor:= crdefault;
        exit;
       end;
     end;
     
     addr:= form1.groupbox5.Caption;
   if sender<> form1 then
   begin
   if listbox1.ItemIndex = -1 then
    ss:= ''
     else
      ss:= listbox1.Items.Strings[listbox1.ItemIndex];
   end else
           ss:= '';

   if (ss<> '') and (sender<>button7) then
    begin
     if messagebox(handle,pchar('�Ƿ񸲸ǵ�����'+ ss+' ��'),'ѯ��',mb_yesno or MB_ICONQUESTION)= mryes then
      begin
       if not check_password(ExtractFilePath(application.ExeName) + 'save\'+ ss+'\role.dat') then
        exit;

       ss2:= addr + get_date_str; //����µ�����
         if checkbox1.Checked then
             begin
              if pos('!',ss2)= 0 then
                 ss2:= ss2+'!'+ form1.game_get_newname_at_id(1); //����һ�����ܱ��
             end;
       //����
       renamefile(game_doc_path_g + 'save\'+ ss,
                   game_doc_path_g + 'save\'+ ss2);
       ss:= ss2;
      end;
    end else ss:= addr + get_date_str;


     if sender=button7 then
     begin
       if opendialog1.Execute then
        begin
        gsfNmae:= opendialog1.FileName;  //����浵ʱ
         ss:= ExtractFileName(gsfNmae);
         ss:= copy(ss,1,pos('.',ss)-1);
         ss2:= ss; //����һ�����Ʊ���
        end
         else exit;
     end;

screen.Cursor:= crhourglass;

        ss:= game_doc_path_g + 'save\'+ ss;

    if checkbox1.Checked then
     begin
     if pos('!',ss)= 0 then
       ss:= ss+'!'+form1.game_get_newname_at_id(1); //����һ�����ܱ��
     end;

    if not DirectoryExists(ss) then
          CreateDir(ss); //�����浵�ļ�


    if not DirectoryExists(ss) then
     begin
      //������ɹ�������appĿ¼�´���һ��
      if sender=button7 then
       ss:= get_app_data_path + '\��������Ϸ��������\'+ ss2
       else
         ss:= get_app_data_path + '\��������Ϸ��������\'+ addr + get_date_str;

       if not ForceDirectories(ss) then
        showmessage('�����ļ���ʧ�ܣ�'+ ss+ SysErrorMessage(getlasterror));
     end;

    if not DirectoryExists(ss) then
     begin
       messagebox(handle,'��������Ŀ¼ʧ�ܡ�������� win7 �£��������Թ���Ա���������Ϸ�����߶���Ϸ��װĿ¼�ڵ�save�ļ��е�������Ȩ�ޣ����߲�����Ϸ��װ��ϵͳ�̣����԰�װ��D�̣�E�̵ȡ�','ʧ��',mb_ok or MB_ICONERROR);
     end else begin  //******************************************
               cunpan:= ExtractFilePath(ss +'\');
               if sender=button7 then
                begin
                 data2.in_save(gsfNmae,ss);
                  //ˢ��
                  FormShow(Sender);
                 screen.Cursor:= crdefault;
                 exit; //����浥��������˳�
                end else
                     form1.game_save_doc(cunpan);
               if checkbox1.Checked then
                   begin
                     str1:= Tstringlist.Create;
                      str1.Append(StrMD5(edit1.text));
                     str1.SaveToFile(ss+'\role.dat');
                     str1.Free;
                     edit1.Text:= '';
                     edit2.Text:= '';
                   end;
                Game_not_save:= false;
                if sender<> form1 then
                 Button1.Enabled:= false;
              end;  //*********************************************
 if sender<> form1 then
  Button1.Enabled:= true;

screen.Cursor:= crdefault;

  if sender<> form1 then
  self.Close;

end;

procedure TForm_save.Button2Click(Sender: TObject); //��ȡ
var ss,ss2: string;
begin
   if game_at_net_g then
     begin
      messagebox(handle,'������Ϸ���ܶ���','��ʾ',mb_ok);
     exit;
     end;

   if sender<> form1 then
    begin
   if Game_not_save then
  begin
    case messagebox(handle,'��Ϸû�д��̣���ǰ���Ȼᶪʧ���Ƿ��ȡ��ǰ�Ľ��ȣ�','��ʾ',mb_yesnocancel or MB_ICONQUESTION) of
    //mryes: game_save(0);
    mrno: exit;
    mrcancel: exit;
    end;
  end;

   if listbox1.ItemIndex = -1 then
    ss:= ''
     else
      ss:= listbox1.Items.Strings[listbox1.ItemIndex];

   if ss= '' then
     begin
      messagebox(handle,'��ѡ��һ����Ч�Ĵ��̽��ȡ�','ѡ�����',mb_ok);
      exit;
     end;


    ss2:= game_doc_path_g+ 'save\'+ ss;
    if not check_password(ss2+ '\role.dat') then
    begin
     exit;
    end;
     end else ss2:=  cunpan; //�Զ�����


     if not DirectoryExists(ss2) then
       ss2:= ExtractFilePath(application.ExeName)+ 'save\'+ ss;

       //�ٴμ���ļ����Ƿ����
     if not DirectoryExists(ss2) then
       ss2:= get_app_data_path + '\��������Ϸ��������\'+ ss;


     if not DirectoryExists(ss2) then
     begin
       messagebox(handle,'��ȡ���ȳ������ܴ��̽��ȱ�����ɾ����','����',mb_ok);
       exit;
     end;
Button2.Enabled:= false;
screen.Cursor:= crhourglass;
     if sender=button8 then
      begin
       //��ȡ�Ե����浵
       savedialog1.FileName:= ss+'.gsf';
       if savedialog1.Execute then
          data2.out_save(ss2,savedialog1.FileName);
      end else
          form1.game_load_doc(ExtractFilePath(ss2 +'\'));  //��ȡ�浵
Button2.Enabled:= true;
screen.Cursor:= crdefault;

   self.Close;
   
end;

procedure TForm_save.ListBox1DblClick(Sender: TObject);
begin
if listbox1.ItemIndex= -1 then
 exit;

 if button1.Enabled= false then
    button2click(sender)
    else begin
          if listbox1.Items.Strings[listbox1.ItemIndex]= '' then
            begin
             if Game_scene_type_G and 2 = 2 then
             messagebox(handle,'�Թ��ڲ��ܴ��̡����������Ե����ʹ�ô洢���������̡�','���ܴ���',mb_ok)
             else begin
             if messagebox(handle,'�Ƿ���̣�','ѯ��',mb_yesno or MB_ICONQUESTION)= mryes then
                button1click(sender);
                  end;
            end else begin
                      if messagebox(handle,'Ҫ��ȡ������','ѯ��',mb_yesno or MB_ICONQUESTION)= mryes then
                         button2click(sender);
                     end;
         end;
end;

procedure TForm_save.Button4Click(Sender: TObject);
begin
  if game_debug_handle_g<> 0 then
     begin
      messagebox(handle,'����ʱ���ܴ��̡�','��ʾ',mb_ok);
     exit;
     end;
  if game_role_list.Count=0 then
  begin
   messagebox(handle,'��Ϸû�п�ʼ�����ȿ�ʼ��Ϸ����������ȡ�','��Ϸû��ʼ',mb_ok);
   exit;
  end;
  
    if game_at_net_g then
     begin
      messagebox(handle,'������Ϸ���ô���','��ʾ',mb_ok);
     exit;
     end;

  if form1.game_check_goods_nmb('�洢��',1)= 1 then
    begin
     button1click(sender);
     form1.game_goods_change_n('�洢��',-1); //��ȥ�洢��
    end else messagebox(handle,'�洢���������㣬�ÿ���������Ϸ������ӻ����򵽡�','��������',mb_ok or MB_ICONWARNING);
end;

procedure TForm_save.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
ListBox1.Canvas.FillRect(Rect);

     ListBox1.Canvas.Font.Style:= [fsbold];
    ListBox1.Canvas.Font.Size:= 16;

      if ListBox1.Items[Index] = '' then
        begin
        ListBox1.Canvas.Font.Color:= clgreen;
        ListBox1.Canvas.TextOut(Rect.Left+2, Rect.Top, '��');
        end else begin
                     if pos('!',ListBox1.Items[Index])> 0 then
                      begin
                        ListBox1.Canvas.Font.Color:= clred;
                        ListBox1.Canvas.TextOut(Rect.Left+2, Rect.Top, '��');
                      end else begin
                                 ListBox1.Canvas.Font.Color:= clblue;
                                 ListBox1.Canvas.TextOut(Rect.Left+2, Rect.Top, '��');
                               end;
                       end;

    ListBox1.Canvas.Font.Size:= 12;
    ListBox1.Canvas.Font.Style:= [];
    ListBox1.Canvas.Font.Color:= clwindowtext;
  ListBox1.Canvas.TextOut(Rect.Left+26, Rect.Top+ 3, ListBox1.Items[Index]);
end;

procedure TForm_save.ListBox1MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
 Height:= 26;
end;

function TForm_save.get_app_data_path: string;
var InternetCacheFolder: Array[0..MAX_PATH] of Char;
begin
   SHGetFolderPath(0,CSIDL_APPDATA,0,0,InternetCacheFolder);
   Result:= InternetCacheFolder;
end;

procedure TForm_save.Button5Click(Sender: TObject);
var SHOP:TSHFILEOPSTRUCT;
   ss: string;
begin
 if listbox1.ItemIndex= -1 then
   begin
     messagebox(handle,'��ѡ��һ���浵','ɾ��',mb_ok);
     exit;
   end;

 if listbox1.Items[listbox1.Itemindex]= '' then
   begin
     messagebox(handle,'��ѡ��һ���浵','ɾ��',mb_ok);
     exit;
   end;
   ss:= ExtractFilePath(application.ExeName) + 'save\'+ listbox1.Items.Strings[listbox1.ItemIndex];
   if not check_password(ss+'\role.dat') then
    begin
     messagebox(handle,'ɾ��ʧ��','ɾ��',mb_ok);
     exit;
    end;
  if messagebox(handle,'ȷ��ɾ����ǰ�浵��','ɾ��',mb_yesno)= mryes then
   begin

     FillChar(SHOP,Sizeof(SHOP),0);
 SHOP.Wnd:=0;
 SHOP.pFrom :=pchar(ss+#0#0);
 SHOP.wFunc :=FO_DELETE  ;
 //SHOP.fFlags:=FOF_NOCONFIRMATION; //����㲻��Ҫ��ʾ�Ļ��ͼ�����䡣
 SHFileOperation(SHOP);
  FormShow(self);
   end;
end;

procedure TForm_save.CheckBox1Click(Sender: TObject);
begin
  edit1.Enabled:= checkbox1.Checked;
  edit2.Enabled:= checkbox1.Checked;
end;

function TForm_save.check_password(const s: string): boolean;
var str1: Tstringlist;
begin
   if FileExists(s) then
    begin
     str1:= Tstringlist.Create;
      str1.LoadFromFile(s);
      if str1.Count= 0 then
       result:= true
       else
        begin
         if edit1.Text= '' then
          begin
           checkbox1.Checked:= true;
           result:= false;
           messagebox(handle,'�õ��������ܣ����������롣','��������',mb_ok);
          end else begin
                    if CompareStr( str1.Strings[0],StrMD5(edit1.text))<> 0 then
                     begin
                       result:= false;
                       messagebox(handle,'�������','�������',mb_ok);
                     end  else
                         result:= true;
                   end;
        end;
     str1.Free;
    end else result:= true;
end;

procedure TForm_save.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;

procedure TForm_save.Button6Click(Sender: TObject);
begin
  if messagebox(handle,'�Ƿ����Ϸ�Ĵ浵�ļ��У�','�ļ���',mb_yesno)=mryes then
    begin
      if DirectoryExists(get_app_data_path + '\��������Ϸ��������') then
         begin
          ShellExecute(0,
             'open',pchar(get_app_data_path + '\��������Ϸ��������'),nil,nil,sw_shownormal);

         end else  ShellExecute(0,
             'open',pchar(ExtractFilePath(application.ExeName) + 'save'),nil,nil,sw_shownormal);
    end;
end;

procedure TForm_save.Button7Click(Sender: TObject);
begin
  Button1Click(Sender); //����浥
end;

procedure TForm_save.Button8Click(Sender: TObject);
begin
  Button2Click(button8);   //�����浥
  
end;

end.

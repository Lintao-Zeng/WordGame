unit Unit_task;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm_task = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    TabSheet3: TTabSheet;
    ListBox3: TListBox;
    Button2: TButton;
    Button3: TButton;

    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    procedure TabSheet3aShow(Sender: TObject);
    procedure TabSheet2aShow(Sender: TObject);
    procedure TabSheet1aShow(Sender: TObject);
  public
    { Public declarations }
    task_type: integer;
    procedure CreateParams(var Para:TCreateParams);override;
  end;

var
  Form_task: TForm_task;

implementation
    uses unit_data,unit1;
{$R *.dfm}

procedure TForm_task.TabSheet3aShow(Sender: TObject);   //��ʾ��Ϣ
begin
   listbox3.Items.Clear;
   if Assigned(game_message_txt) then
      listbox3.Items.Assign(game_message_txt);

end;

procedure TForm_task.TabSheet2aShow(Sender: TObject);
begin
   listbox1.Items.Clear;
    Data2.game_show_task_complete(listbox1.Items);

end;

procedure TForm_task.TabSheet1aShow(Sender: TObject);
begin
  listbox2.Items.Clear;
    Data2.game_show_task_uncomplete(listbox2.Items);
end;

procedure TForm_task.Button3Click(Sender: TObject);
begin
  if messagebox(handle,'�Ƿ������Щ����ɵ������б��ò�������ȥ���Ѿ���õľ���ֵ����Ʒ��','ȷ��',
     mb_yesno or MB_ICONQUESTION) = mryes then
     begin
      listbox1.Items.Clear;
      Game_task_comp1.Clear;
     end;
end;

procedure TForm_task.Button2Click(Sender: TObject);
begin
  if messagebox(handle,'�Ƿ������Щ��ʾ��Ϣ��','ȷ��',
     mb_yesno or MB_ICONQUESTION) = mryes then
     begin
      listbox3.Items.Clear;
      game_message_txt.Clear;
     end;
end;

procedure TForm_task.Button1Click(Sender: TObject);
var str1: tstringlist;
    i,j: integer;
begin
   //ɾ��δ��ɵ�����

   if listbox2.ItemIndex= -1 then
    begin
     messagebox(handle,'��ѡ��һ������','ȷ��',
     mb_ok)
    end else begin
              str1:= Tstringlist.Create;
              data2.Load_file_upp(game_app_path_g+'dat\task.upp',str1); //���������ļ�
              Assert(str1.count >0,'��Ч�����������ļ�');
              for i:= 0 to str1.Count- 1 do
                  if pos(listbox2.Items.Strings[listbox2.ItemIndex],str1.Strings[i])> 0 then
                   begin
                     j:= strtoint(copy(str1.Strings[i],1,pos('=',str1.Strings[i])-1)); //ȡ������id
                     //ɾ��id
                     form1.game_del_res_event(j);
                     listbox2.Items.Delete(i); //ɾ����ʾ������
                       //ɾ�������¼�ļ��ڵ�����
                     Game_task_uncomp1.Delete(Game_task_uncomp1.IndexOf(inttostr(j)));
                     break;
                   end;
              str1.Free;
             end;

end;

procedure TForm_task.FormShow(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
  0: TabSheet1aShow(self);
  1: TabSheet2aShow(self);
  2: TabSheet3aShow(self);
  end;
end;

procedure TForm_task.PageControl1Change(Sender: TObject);
begin
     FormShow(sender);
end;

procedure TForm_task.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;

end.

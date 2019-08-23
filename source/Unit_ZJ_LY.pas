unit Unit_ZJ_LY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids;

type
  TForm_ZJ_LY = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    ListBox2: TListBox;
    StringGrid2: TStringGrid;
    Button2: TButton;
    GroupBox3: TGroupBox;
    ListBox3: TListBox;
    StringGrid3: TStringGrid;
    Button3: TButton;
    GroupBox4: TGroupBox;
    ListBox4: TListBox;
    StringGrid4: TStringGrid;
    Button4: TButton;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure TabSheet1Show(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button4Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    dangqian_dengji: integer;
    grid_cur: Tstringgrid;
    box_cur: Tlistbox;
    str1_u: Tstringlist;
    total_ok: boolean;
  public
    { Public declarations }
   function can_next(id: integer;write: boolean): integer;
   procedure CreateParams(var Para:TCreateParams);override;
  end;

var
  Form_ZJ_LY: TForm_ZJ_LY;

implementation
     uses unit1,Unit_player,unit_data,unit_goods,faststrings;
{$R *.dfm}

function TForm_ZJ_LY.can_next(id: integer;write: boolean): integer;
var i,j: integer;
begin
result:= 0;
  //�Ƿ������������ҩ��
   for i:= 0 to Game_role_list.Count- 1 do
    begin
      for j:= 0 to 23 do
       begin
        if get_L_16(Tplayer(Game_role_list.Items[i]).pl_ji_array[j]) = id then
         begin
          if write then
          begin
          //д��ʹ�ô���
          if get_HL_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j]) = 5 then
            begin
             //�����ȼ�
              if get_H_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j])< 10 then
                 Tplayer(Game_role_list.Items[i]).pl_ji_array[j]:=
                  set_H_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j],
                           get_H_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j])+ 1);

              Tplayer(Game_role_list.Items[i]).pl_ji_array[j]:=
               set_HL_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j],0);
            end else begin//������һ
                      Tplayer(Game_role_list.Items[i]).pl_ji_array[j]:=
                      set_HL_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j],1 +
                      get_HL_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j]));
                     end;
          end else
            result:= get_H_8(Tplayer(Game_role_list.Items[i]).pl_ji_array[j]);
          exit;
         end;
       end;
    end;
end;

procedure TForm_ZJ_LY.TabSheet1Show(Sender: TObject);
var
    i: integer;
    b: boolean;
begin

   grid_cur:= stringgrid1;
   box_cur:= listbox1;
b:= false;
listbox1.Items.Clear;
 grid_cur.Cols[0].Clear;
 grid_cur.Cols[1].Clear;

  grid_cur.Cells[0,0]:= '����ԭ��';
  grid_cur.Cells[1,0]:= '��������';

   str1_u.Clear;
     Data2.Load_file_upp(game_app_path_G+ 'dat\sword.upp',str1_u);
     dangqian_dengji:= can_next(strtoint(str1_u.Values['id']),false);
     if dangqian_dengji > 0 then
       begin
        listbox1.Items.Append('-��ǰ�������ȼ�Ϊ��' + inttostr(dangqian_dengji) +'��');

           listbox1.Items.Append('-��ǰ�ɹ���Ϊ��' + inttostr(dangqian_dengji * 5 +50) +'%');
           listbox1.Items.Append('-ÿʹ��5��');
           listbox1.Items.Append('-�ȼ����һ��');
           listbox1.Items.Append('-�ɹ�������5%');

        listbox1.Items.Append('-��������������£�');
        for i:= 0 to str1_u.Count- 1 do  //�����б�
        if b then
         begin
          listbox1.Items.Append(copy(str1_u.Strings[i],1,pos('=',str1_u.Strings[i])-1));
         end else begin
                   if pos('id=',str1_u.Strings[i])> 0 then
                     b:= true;
                  end;
       end else begin
                  listbox1.Items.Add('-��û��ѧ��������');
                  listbox1.Items.Add('-���������ؼ�һ��');
                  listbox1.Items.Add('-�������Թ�����');
                  listbox1.Items.Add('-һЩ���������ϵõ���');
                end;

end;

procedure TForm_ZJ_LY.FormCreate(Sender: TObject);
const PBM_SETBARCOLOR         = WM_USER+9;
begin
str1_u:= Tstringlist.Create;
 SendMessage(ProgressBar1.Handle,PBM_SETBARCOLOR,0,clpurple);
end;

procedure TForm_ZJ_LY.FormDestroy(Sender: TObject);
begin
str1_u.Free;
end;

procedure TForm_ZJ_LY.ListBox1Click(Sender: TObject);
var ss,ss2: string;
    st1: Tstringlist;
    i,j,k: integer;
begin
  total_ok:= false;
  k:= 0;
  grid_cur.Cols[0].Clear;
           grid_cur.Cols[1].Clear;
           grid_cur.Cells[0,0]:= '����ԭ��';
           grid_cur.Cells[1,0]:= '��������';
  if Tlistbox(sender).Itemindex <> -1 then
    begin
     ss:= Tlistbox(sender).Items[Tlistbox(sender).Itemindex];
     if ss<> '' then
      begin
        if ss[1]<> '-' then
         begin
          ss2:= Data2.get_game_goods_type_a(form_goods.get_goods_id(ss));
          if Sender= listbox1 then
          label1.Caption:= ss2;
          if Sender= listbox2 then
          label2.Caption:= ss2;
          if Sender= listbox3 then
          label3.Caption:= ss2;
          if Sender= listbox4 then
           begin
           ss2:= StringReplace(ss2,'+','-',[rfReplaceAll]);
           label4.Caption:= ss2;
           end;
          ss:= str1_u.Values[ss];
          st1:= Tstringlist.Create;
           st1.Delimiter:= ',';
           st1.DelimitedText:= ss;
           for i:= 0 to st1.Count-1 do
              begin
               grid_cur.Cells[0,i+1]:= st1.Strings[i];
               if grid_cur.Cells[0,i+1] <> ''then
                 begin
                  j:= form_goods.get_goods_id(grid_cur.Cells[0,i+1]);
                  k:= k+ j;
                    grid_cur.Cells[1,i+1]:= inttostr(read_goods_number(j));

                 end;
              end; //end for i
          if k > 0 then
           begin
            //�жϲ����Ƿ��㹻��ɾ���ظ�����
            for i:= 0 to st1.Count-1 do
              begin
               if grid_cur.Cells[1,i+1] = '0' then
                  begin
                   k:= -1;
                   break;
                  end;
               dec(k); //��ȥ����
                for j:= i+ 1 to st1.Count -1 do
                   if grid_cur.Cells[0,i+1] = grid_cur.Cells[0,j+1] then
                      k:= k- strtoint(grid_cur.Cells[1,i+1]); //��ȥ�ظ�����
              end; //end for i
            if k >= 0 then
               total_ok:= true; //ԭ���㹻
           end;
          st1.free;
         end;
      end;
    end;

end;

procedure TForm_ZJ_LY.TabSheet3Show(Sender: TObject);
var
    i: integer;
    b: boolean;
begin

   grid_cur:= stringgrid2;
   box_cur:= listbox2;
b:= false;
listbox2.Items.Clear;
 grid_cur.Cols[0].Clear;
 grid_cur.Cols[1].Clear;

  grid_cur.Cells[0,0]:= '����ԭ��';
  grid_cur.Cells[1,0]:= '��������';

   str1_u.Clear;
     Data2.Load_file_upp(game_app_path_G+ 'dat\yao.upp',str1_u);
     dangqian_dengji:= can_next(strtoint(str1_u.Values['id']),false);
     if dangqian_dengji > 0 then
       begin
        listbox2.Items.Append('-��ǰ��ҩ���ȼ�Ϊ��' + inttostr(dangqian_dengji) +'��');

           listbox2.Items.Append('-��ǰ�ɹ���Ϊ��' + inttostr(dangqian_dengji * 5 +50) +'%');
           listbox2.Items.Append('-ÿʹ��5��');
           listbox2.Items.Append('-�ȼ����һ��');
           listbox2.Items.Append('-�ɹ�������5%');

        listbox2.Items.Append('-�����Ƶ�ҩ�����£�');
        for i:= 0 to str1_u.Count- 1 do  //�����б�
        if b then
         begin
          listbox2.Items.Append(copy(str1_u.Strings[i],1,pos('=',str1_u.Strings[i])-1));
         end else begin
                   if pos('id=',str1_u.Strings[i])> 0 then
                     b:= true;
                  end;
       end else begin
                  listbox2.Items.Add('-��û��ѧ����ҩ��');
                  listbox2.Items.Add('-��ҩ�����ؼ�һ��');
                  listbox2.Items.Add('-�������Թ�����');
                  listbox2.Items.Add('-һЩ���������ϵõ���');
                end;

end;

procedure TForm_ZJ_LY.TabSheet2Show(Sender: TObject);
var
    i: integer;
    b: boolean;
begin

   grid_cur:= stringgrid3;
   box_cur:= listbox3;
b:= false;
listbox3.Items.Clear;
 grid_cur.Cols[0].Clear;
 grid_cur.Cols[1].Clear;

  grid_cur.Cells[0,0]:= '����ԭ��';
  grid_cur.Cells[1,0]:= '��������';

   str1_u.Clear;
     Data2.Load_file_upp(game_app_path_G+ 'dat\zhuangbei.upp',str1_u);
     dangqian_dengji:= can_next(strtoint(str1_u.Values['id']),false);
     if dangqian_dengji > 0 then
       begin
        listbox3.Items.Append('-��ǰװ������ȼ�Ϊ��' + inttostr(dangqian_dengji) +'��');

           listbox3.Items.Append('-��ǰ�ɹ���Ϊ��' + inttostr(dangqian_dengji * 5 +50) +'%');
           listbox3.Items.Append('-ÿʹ��5��');
           listbox3.Items.Append('-�ȼ����һ��');
           listbox3.Items.Append('-�ɹ�������5%');

        listbox3.Items.Append('-����װ�����£�');
        for i:= 0 to str1_u.Count- 1 do  //�����б�
        if b then
         begin
          listbox3.Items.Append(copy(str1_u.Strings[i],1,pos('=',str1_u.Strings[i])-1));
         end else begin
                   if pos('id=',str1_u.Strings[i])> 0 then
                     b:= true;
                  end;
       end else begin
                  listbox3.Items.Add('-��û��ѧ��װ��������');
                  listbox3.Items.Add('-���������ؼ�һ��');
                  listbox3.Items.Add('-�������Թ�����');
                  listbox3.Items.Add('-һЩ���������ϵõ���');
                end;

end;

procedure TForm_ZJ_LY.TabSheet4Show(Sender: TObject);
var
    i: integer;
    b: boolean;
begin

   grid_cur:= stringgrid4;
   box_cur:= listbox4;
b:= false;
listbox4.Items.Clear;
 grid_cur.Cols[0].Clear;
 grid_cur.Cols[1].Clear;

  grid_cur.Cells[0,0]:= '����ԭ��';
  grid_cur.Cells[1,0]:= '��������';

   str1_u.Clear;
     Data2.Load_file_upp(game_app_path_G+ 'dat\anqi.upp',str1_u);
     dangqian_dengji:= can_next(strtoint(str1_u.Values['id']),false);
     if dangqian_dengji > 0 then
       begin
        listbox4.Items.Append('-��ǰ��������ȼ�Ϊ��' + inttostr(dangqian_dengji) +'��');

           listbox4.Items.Append('-��ǰ�ɹ���Ϊ��' + inttostr(dangqian_dengji * 5 +50) +'%');
           listbox4.Items.Append('-ÿʹ��5��');
           listbox4.Items.Append('-�ȼ����һ��');
           listbox4.Items.Append('-�ɹ�������5%');

        listbox4.Items.Append('-���ư������£�');
        for i:= 0 to str1_u.Count- 1 do  //�����б�
        if b then
         begin
          listbox4.Items.Append(copy(str1_u.Strings[i],1,pos('=',str1_u.Strings[i])-1));
         end else begin
                   if pos('id=',str1_u.Strings[i])> 0 then
                     b:= true;
                  end;
       end else begin
                  listbox4.Items.Add('-��û��ѧ�ᰵ��������');
                  listbox4.Items.Add('-���������ؼ�һ��');
                  listbox4.Items.Add('-�������Թ�����');
                  listbox4.Items.Add('-һЩ���������ϵõ���');
                end;

end;

procedure TForm_ZJ_LY.ListBox1MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  height:= 19;
end;

procedure TForm_ZJ_LY.ListBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
Tlistbox(control).Canvas.FillRect(Rect);
 if fastcharpos(Tlistbox(control).Items[index],'-',1)= 1 then
    begin
     Tlistbox(control).Canvas.Font.Style:= [];
     Tlistbox(control).Canvas.TextOut(Rect.Left+2, Rect.Top+ 3, Tlistbox(control).Items[Index]);
    end else begin
              Tlistbox(control).Canvas.Font.Style:= [fsbold];
              Tlistbox(control).Canvas.TextOut(Rect.Left+20, Rect.Top+ 3, Tlistbox(control).Items[Index]);
             end;
  data2.ImageList_sml.Draw(Tlistbox(control).Canvas,rect.left+2,rect.top+3,
                        Game_goods_Index_G[form_goods.get_goods_id(Tlistbox(control).Items[Index])]);
end;

procedure TForm_ZJ_LY.Button4Click(Sender: TObject);
var id,i: integer;
begin
  //����
 if grid_cur.Cells[0,1] = '' then
  begin
   messagebox(handle,'��ѡ��һ����Ҫ�ϳɵ���Ʒ����','��ʾ',mb_ok or MB_ICONWARNING);
   exit;
  end;
 if not total_ok then
  begin
   messagebox(handle,'ԭ���ϲ��㣬�޷�������','��ʾ',mb_ok or MB_ICONWARNING);
   exit;
  end;

  if form1.game_pop(2)<> 1 then
   begin
    messagebox(handle,'����ϳɹ����жϡ�','��ʾ',mb_ok or MB_ICONWARNING);
    exit;
   end;
 //ȡ��Ҫ�ϳɵĲ�Ʒ���ͣ���ȥԭ�ϣ�ȡ�ü��ܵȼ����ϳ�
  id:= form_goods.get_goods_id(box_cur.Items[box_cur.ItemIndex]);

   for i:= 0 to str1_u.Count -1 do
       write_goods_number(form_goods.get_goods_id(grid_cur.Cells[0,i+1]),-1);

         //���ӺϳɵĶ���

    can_next(strtoint(str1_u.Values['id']),true); //����ʹ�ô���
     screen.Cursor:= crhourglass;
     ProgressBar1.Visible:= true;
     ProgressBar1.Update;
    for i:= 1 to 100 do
     begin
        sleep(30);
        ProgressBar1.Position:= i;
        application.ProcessMessages;
     end;
      ProgressBar1.Visible:= false;
      screen.Cursor:= crdefault;
   if (dangqian_dengji >= 10) or
       (Game_base_random(100) < (dangqian_dengji * 5 +50)) then
     begin
      write_goods_number(id,1);
      messagebox(handle,'����ϳɳɹ���','��ʾ',mb_ok or MB_ICONINFORMATION);
     end else  messagebox(handle,'����ϳ�ʧ�ܡ�','��ʾ',mb_ok or MB_ICONWARNING);

    ListBox1Click(box_cur); //ˢ��

    dangqian_dengji:= can_next(strtoint(str1_u.Values['id']),false); //ȡ�õȼ�
    box_cur.Items[0]:= ('-��ǰ���ܵȼ�Ϊ��' + inttostr(dangqian_dengji) +'��');
    box_cur.Items[1]:= ('-��ǰ�ɹ���Ϊ��' + inttostr(dangqian_dengji * 5 +50) +'%');

end;

procedure TForm_ZJ_LY.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if State = [gdSelected] then
 begin
   TStringGrid(Sender).Canvas.Brush.Color := clWhite;
 end;

   TStringGrid(Sender).Canvas.FillRect(Rect);
    TStringGrid(Sender).Canvas.Font.Color:= clwindowtext;
   TStringGrid(Sender).Canvas.TextRect(Rect, Rect.Left + 20, Rect.Top + 2,
                       TStringGrid(Sender).Cells[ACol, ARow]);

   if acol= 0 then
   data2.ImageList_sml.Draw(TStringGrid(Sender).Canvas,rect.left+2,rect.top+3,
                        Game_goods_Index_G[form_goods.get_goods_id(TStringGrid(Sender).Cells[ACol, ARow])]);
end;

procedure TForm_ZJ_LY.FormShow(Sender: TObject);
begin
 if grid_cur= nil then
   exit;

    if grid_cur= stringgrid1 then
      TabSheet1Show(sender);
    if grid_cur= stringgrid2 then
      TabSheet2Show(sender);
    if grid_cur= stringgrid3 then
      TabSheet3Show(sender);
    if grid_cur= stringgrid4 then
      TabSheet4Show(sender);

end;

procedure TForm_ZJ_LY.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;

end.

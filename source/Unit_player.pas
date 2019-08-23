unit Unit_player;

interface
 uses classes,sysutils;

type
  //��������
 {
0����Ǯ         0 �ż�¼
1������ֵ
2���ٶ�
3��������
4���Ƿ��ϳ�--ͬʱ�ϳ���ֻ��5��������ռ��һ�����ϳ�����1
5������
6������
7������
8������ֵ
9������ֵ
10������ֵ
11���Ը�

12���Ա�
13��̰��
14�����Ƕ���İ���ֵ
15�������ǵİ���ֵ
16�����������ζ�
17�����Ƕ������ζ�
18��������¼
19������ֵ
20������ֵ
21.�����
22��̸��ǰ���ı��
23��̸���α꣬Ϊ�˿��ٲ��ҶԻ���
24  �´�����
25  �̶����� 50
26 �̶����� 0
27 �̶�����ֵ 100
28��ǰ�ȼ�
29��ʱ���أ�˫�˱�����ʱ�ã�����������
30,�رյ����ӳ���ʾ�Ĵ���
31,��ʱ����ϵ��
32,ͼ�����
33��ͷ��
}
   Tgame_one_value=(g_money,g_luck,g_speed,g_attack,g_hide,g_tili,g_lingli,g_intellect,
                   g_life,g_morality,g_weiwang,g_character,g_sex,g_cupidity,g_love,g_loveme,
                   g_believeMe,g_believe,g_fuzu,g_experience{����},g_defend,g_face,g_talk22,
                   g_talkid23,g_upgrade,g_gdtl25,g_gdll26,g_gdsmz27,g_grade,
                   g_tmp_hide,g_30_yanchi,g_linshifang,g_icon_index,g_touxian);
 pplayer= ^Tplayer;
 Tplayer = class(TPersistent)
  private
   Fname: string;
   Fvalues: array[0..63] of integer;
   Fpl_accouter1: array[0..9] of integer; //װ����ʮ����0�ż�¼��ʱδ��
   Fpl_ji_array: array[0..23] of integer;   //�����б�
   Fpl_fa_array: array[0..63] of integer; //�����б�
    FtalkChar1: char;
    FtalkChar4: char;
    FtalkChar5: char;
    FtalkChar2: char;
    FtalkChar3: char;
    Foldname: string;
    procedure setFname(const Value: string);
    function get_values(Index: Integer): integer; //����
    procedure set_values(Index: Integer; const Value: integer);
    procedure setFtalkChar(const Value: char);
    procedure setFtalkChar2(const Value: char);
    procedure setFtalkChar3(const Value: char);
    procedure setFtalkChar4(const Value: char);
    procedure setFtalkChar5(const Value: char);
    procedure setFoldname(const Value: string);
    function get_pl_accouter1(Index: Integer): integer;
    function get_pl_fa_array(Index: Integer): integer;
    function get_pl_ji_array(Index: Integer): integer;
    procedure set_pl_accouter1(Index: Integer; const Value: integer);
    procedure set_pl_fa_array(Index: Integer; const Value: integer);
    procedure set_pl_ji_array(Index: Integer; const Value: integer);
  protected

  public
   constructor Create(const FileName: string); overload;
   property plname: string read Fname write setFname;
   property plvalues[Index: Integer]: integer read get_values write set_values; //��ȡ��Ϸ����
   property pl_accouter1[Index: Integer]: integer read get_pl_accouter1 write set_pl_accouter1; //װ����ʮ����0�ż�¼��ʱδ��  array[0..9] of
   property pl_ji_array[Index: Integer]: integer read get_pl_ji_array write set_pl_ji_array;   //�����б�  array[0..23] of
   property pl_fa_array[Index: Integer]: integer read get_pl_fa_array write set_pl_fa_array; //�����б� array[0..63] of
   property PlTalkChar1: char read FtalkChar1 write setFtalkChar;
   property PlTalkChar2: char read FtalkChar2 write setFtalkChar2;
   property PlTalkChar3: char read FtalkChar3 write setFtalkChar3;
   property PlTalkChar4: char read FtalkChar4 write setFtalkChar4;
   property PlTalkChar5: char read FtalkChar5 write setFtalkChar5;
   procedure get_pl_ji_p(st1: Tstringlist); //��ȡ�����б�
   procedure get_pl_fa_p(st1: Tstringlist); //��ȡ�����б�
   procedure saveupp(const filename: string); //���������ļ�
   property pl_old_name: string read Foldname write setFoldname;  //ԭʼ����
   procedure add_fa(id: integer);   //��ӷ���
   procedure add_ji(id: integer); //��Ӽ���
   procedure change_g_morality(i: integer); //�Ӽ�����ֵ
   function get_name_and_touxian: string;
  end;

implementation
   uses unit_data,unit_net;
{ Tplayer }

procedure Tplayer.add_fa(id: integer); //��ӷ���
var i: integer;
begin
  for i:= 0 to 63 do
   if pl_fa_array[i]= 0 then
    begin
      pl_fa_array[i]:= set_H_8(id,1);
      exit;
    end else begin
              if get_L_16(pl_fa_array[i])= id then
                exit; //����Ѿ�ѧ���ˣ��˳�
             end;

end;

procedure Tplayer.add_ji(id: integer); //��Ӽ���
var i: integer;
begin
  for i:= 0 to 23 do
   if pl_ji_array[i]= 0 then
    begin
      pl_ji_array[i]:= set_H_8(id,1);
      exit;
    end else begin
              if get_L_16(pl_ji_array[i])= id then
                exit; //����Ѿ�ѧ���ˣ��˳�
             end;

end;

procedure Tplayer.change_g_morality(i: integer);
begin
    Fvalues[ord(g_morality)]:= Fvalues[ord(g_morality)] + i;
end;

constructor Tplayer.Create(const FileName: string);
var str1: Tstringlist;
    i: integer;
    ss: string;
begin
 inherited Create;

 if FileName= 'net' then
  begin
   pl_old_name:= '����';
  end else begin
  str1:= Tstringlist.Create;
  Data2.Load_file_upp(filename,str1);
   if str1.Count> 0 then
    begin
     if str1.Strings[0] <> ExtractFileName(filename) then
       begin
         exit;
       end else str1.Delete(0);
    end else exit;

    for i:= 0 to str1.Count-1 do
     begin
      case i of
       0: ss:= str1.Strings[0];      //����
       1..64: plvalues[i-1]:= strtoint(str1.Strings[i]);  //����
       65..74: pl_accouter1[i-65]:= strtoint(str1.Strings[i]);    //װ��
       75..98: pl_ji_array[i-75]:= strtoint(str1.Strings[i]);       //����
       99..162: pl_fa_array[i-99]:= strtoint(str1.Strings[i]);       //����
        //����޸�������Ľ���ֵ 162����ô�ڱ������������¼���Ҳ����Ӧ�޸�
       end;
     end;
  str1.Free;

  //����������Ƿ��а����ϵ��û���
    i:= pos('<!!!',ss);
   if i> 0 then
    begin
     plname:= copy(ss,1,i-1);
     pl_old_name:= copy(ss,i+ 4, length(ss)-i-3); //ȡ��ԭʼ�û����������������ƥ��
    end
   else begin
         plname:= ss;
          pl_old_name:= ss; //����ԭʼ�û���
        end;
          end; //end net
end;
          
function Tplayer.get_name_and_touxian: string; //ȡ�����ƺ�ͷ��ĺϳ�
begin
  if plvalues[ord(g_touxian)] > 0 then
   result:= plname+ '('+ game_get_touxian(plvalues[ord(g_touxian)] -1) +')'
   else
    result:= plname;
end;
           {��ȡ�����б�}
function Tplayer.get_pl_accouter1(Index: Integer): integer;
begin
    if (index < 0) or (index > 9) then
   result:= 0
   else
     result:= fpl_accouter1[index];
end;

function Tplayer.get_pl_fa_array(Index: Integer): integer;
begin
      if (index < 0) or (index > 63) then
   result:= 0
   else
     result:= fpl_fa_array[index];
end;

procedure Tplayer.get_pl_fa_p(st1: Tstringlist);
var i,j,k: integer;
   // game_fa_begin_c,game_fa_end_c: integer;
   // str1: Tstringlist;
begin
{ str1:= Tstringlist.Create;
  Data2.Load_file_upp(data2.game_app_path+ 'dat\const.upp',str1);
  game_fa_begin_c:= strtoint(str1.Values['game_fa_begin_c']);
  game_fa_end_c:=  strtoint(str1.Values['game_fa_end_c']);  }
  for i:= 0 to 63 do
   if pl_fa_array[i] > 0 then
    begin
      j:= get_L_16(pl_fa_array[i]);  //�õ��������
       k:= get_H_8(pl_fa_array[i]); //�õ������ȼ�
      st1.Append(Data2.get_game_fa(j)+' �ȼ�'+ inttostr(k));
    end;
  //str1.Free;
end;
            
function Tplayer.get_pl_ji_array(Index: Integer): integer;
begin
  if (index < 0) or (index > 23) then
   result:= 0
   else
     result:= fpl_ji_array[index];
end;
          {��ȡ�����б�}
procedure Tplayer.get_pl_ji_p(st1: Tstringlist);
var i,j,k: integer;
     //game_ji_begin_c,game_ji_end_c: integer;
     //str1: Tstringlist;
begin
 { str1:= Tstringlist.Create;
  Data2.Load_file_upp(data2.game_app_path+ 'dat\const.upp',str1);
  game_ji_begin_c:= strtoint(str1.Values['game_ji_begin_c']);
  game_ji_end_c:=  strtoint(str1.Values['game_ji_end_c']); }
  for i:= 0 to 23 do
   if pl_ji_array[i] > 0 then
     begin
      j:= get_L_16(pl_ji_array[i]);  //�õ����
       k:= get_H_8(pl_ji_array[i]); //�õ��ȼ�
      st1.Append(Data2.get_game_ji(j)+' �ȼ�'+ inttostr(k));
     end;
  // str1.Free;
end;

function Tplayer.get_values(Index: Integer): integer;
begin
   if (index < 0) or (index > 63) then
   result:= 1
   else
     result:= Fvalues[index];
end;

procedure Tplayer.saveupp(const filename: string);
var str1: Tstringlist;
    i: integer;
begin
   //�����������ݱ�
   str1:= Tstringlist.Create;
    str1.Append(ExtractFileName(filename));
     for i:= 0 to 162 do
     begin
      case i of
       0: str1.Append(plname + '<!!!' +pl_old_name);     //����
       1..64: str1.Append(inttostr(plvalues[i-1])); //����
       65..74: str1.Append(inttostr(pl_accouter1[i-65]));    //װ��
       75..98: str1.Append(inttostr(pl_ji_array[i-75]));       //����
       99..162: str1.Append(inttostr(pl_fa_array[i-99]));       //����
       end;
     end;

   data2.save_file_upp(filename,str1); //����upp�ļ�
   str1.Free;
end;

procedure Tplayer.setFname(const Value: string);
begin
  if length(value) > 24 then
   fname:= copy(value,1,24)
   else
    Fname := Value;
end;

procedure Tplayer.setFoldname(const Value: string);
begin
  Foldname := Value;
end;

procedure Tplayer.setFtalkChar(const Value: char);
begin
  FtalkChar1 := Value;
end;

procedure Tplayer.setFtalkChar2(const Value: char);
begin
  FtalkChar2 := Value;
end;

procedure Tplayer.setFtalkChar3(const Value: char);
begin
  FtalkChar3 := Value;
end;

procedure Tplayer.setFtalkChar4(const Value: char);
begin
  FtalkChar4 := Value;
end;

procedure Tplayer.setFtalkChar5(const Value: char);
begin
  FtalkChar5 := Value;
end;

procedure Tplayer.set_pl_accouter1(Index: Integer; const Value: integer);
begin
   if (index > 9) or (index < 0) then
    exit;

    if Game_at_net_G then //����ʱ�������Լ��ĸĶ���Ϣ��������
     if (fpl_accouter1[index]<> value) and (Fvalues[34]= my_s_id_g) then
        data_net.send_player_Fvalues(index+64,fpl_accouter1[index],value);
      //) and (Fvalues[34]= my_s_id_g)
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
     Fpl_accouter1[index]:= value;
end;

procedure Tplayer.set_pl_fa_array(Index: Integer; const Value: integer);
begin
    if (index > 63) or (index < 0) then
    exit;

    if Game_at_net_G then //����ʱ�����͸Ķ���Ϣ��������
     if (fpl_fa_array[index]<> value) and (Fvalues[34]= my_s_id_g) then
      data_net.send_player_Fvalues(index+98,Fpl_fa_array[index],value);
  //
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
  Fpl_fa_array[index]:= value;
end;

procedure Tplayer.set_pl_ji_array(Index: Integer; const Value: integer);
begin
    if (index > 23) or (index < 0) then
    exit;

    if Game_at_net_G then //����ʱ�����͸Ķ���Ϣ��������
     if (Fpl_ji_array[index]<> value) and (Fvalues[34]= my_s_id_g) then
      data_net.send_player_Fvalues(index+74,Fpl_ji_array[index],value);
  //
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
  Fpl_ji_array[index]:= value;
end;

procedure Tplayer.set_values(Index: Integer; const Value: integer);
begin
  if (index > 63) or (index < 0) then
    exit;

    if Game_at_net_G then //����ʱ�����͸Ķ���Ϣ��������
     if (Fvalues[index]<> value) and (Fvalues[34]= my_s_id_g) then
      data_net.send_player_Fvalues(index,Fvalues[index],value);
 //
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
  Fvalues[index]:= value;
end;

end.

unit Unit_net;

interface

uses
  SysUtils, Classes, windows,
  ExtCtrls,unit_glb,forms,
    RaknetDLL,
  RakNetTypes,
  RakNetStruct,
  RaknetMultiplayer;

type

   p_user_id_time= ^T_user_id_time;

   T_user_id_time= record   //�ڿͻ����ϵ��û��б�
   s_id: integer;
   u_id: string[32];     //�����¼id
   nicheng: string[48];
   page: integer;       //��ǰҳ
   dengji: integer; //�ȼ�
   xiaodui: integer;
   xiaodui_dg: integer; //=0��Ա������ģʽ��=1��Ա����ģʽ��=2��ӣ�����ģʽ��=3��ӣ��쵼ģʽ ��4����Ա����ս������
   zhuzhi: integer;
   zhuzhi_dg: integer;
   guojia: integer;
   guojia_dg: integer;
   time: cardinal; //�ϴ�ˢ��ʱ��
   player_id: T_play_id; //��ҵ�playerid
   end;

   T_is_pk_z= record
    is_pk: boolean;   //�Ƿ�pk״̬
    is_zhihui: boolean;     //�Ƿ�����ָ��״̬
    is_kongzhi: boolean; //�Ƿ����Ȩ
    game_zt: integer;   //0����״̬��1�������ʣ�2�ڿ�3��ҩ��4��������5������6ս��
    end;

  TData_net = class(TDataModule)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    procedure SetCallback(xCall: PTMultiPlayerCallbackList);
    procedure reshow_net_id(id,flag,p: integer); //���������û���ҳ�����ʾ
    procedure reshow_net_id_all(c: integer; p: pointer;show: boolean= true); //ˢ��ȫ�������û���ҳ�����ʾ
    procedure game_page_online_data(p: pointer; c: integer); //�յ������������������û�����
    procedure add_s_id_in_list(sid: integer); //��Ӷ�Ա�������Ա�б�
    procedure del_s_id_in_list(sid: integer); //ɾ����Ա�Ӹ����Ա�б�
    procedure nil_s_id_from_list_g(sid: integer); //��ȫ�������б��ÿ�һ��sid
   // procedure send_page_and_home_id(i, h, old: integer);
  public
    { Public declarations }
      LibLoaded:boolean;
  ClientServerInited:boolean;
  MSConnected:boolean;
  asdf:pointer;
  BroadcastPlayer:TRakPlayerID;
  MasterClient:TRaknetMultiplayerClient;
  procedure  InitializateClientServer(const ip: string);
  procedure  UnInitializateClientServer;
  procedure IntIdle;
  function g_start_udpserver2(const ip: string): boolean;  //��������
  procedure send_scene_integer(id,v: integer); //�����¼���ֵ
  procedure send_scene_bool(id,v: integer); //�����¼�bool
  procedure send_page_and_home_id(i,h,old: integer; ldui: boolean); //���͵�ǰҳ���homeҳ�浽���������Ƿ����
  procedure game_dwjh_data(p: pointer; c: integer);  //�յ�������������dwjh����
  function get_s_id_nicheng(sid: integer): string; //��ȡָ��������ǳ�
  procedure send_player_Fvalues(i,v_old,V_new: integer); //��������䶯���ݵ�������
  procedure send_dwjh_pop(flag,shu,guai: integer); //�ӳ�������ָ����������ʻ��ߴ�ִ���
  procedure send_game_cmd(js_sid: word;    //���ܷ����ܹ�������sid
                           fq_m: integer;
                           fq_t: integer;   //�����飬���𷽴��͵�����ֵ
                           fq_l: integer;
                           js_m: integer;   //���ܷ����͵��ǲ�ֵ
                           js_t: integer;
                           js_l: integer;
                           flag: word;    //���ͣ�ָ����0�޶�����1����������2����������3��Ʒ������4��Ʒ�ָ���5�����ָ���6,��7��
                           wu: word); //���ʹ�֣�������ָ��
  procedure send_game_kongzhi(c,d1,d2: integer; sid: word); //���Ϳ���Ȩ����
  end;


          //ȫ�ֺ���****************************************************************
  procedure send_pak_tt(const h: byte; Acmd,Adata1,Adata2: integer; As_id: word; r: TPacketReliability= RELIABLE);
           //��������

  procedure g_send_msg_cmd(p:pointer; i: integer); //����
  procedure g_send_msg_str(const s: string); //��������
  function ip_to_crd(const ip: string):cardinal; //ipתΪcardinal
  function crd_to_ip(c:cardinal): string;
  function net_get_dwjhming(id,tp: integer; n: boolean=false): string;  //tp��0-3����ʾ��ʾ�����ͣ�n����ʾ����
  function get_user_id_time_type(id: integer): p_user_id_time;
  function get_user_id_time_dwjh(id,tp: integer): integer; //����wdjh id��0����3����ʾs_id,С�ӣ����ɣ�����id
  function get_user_id_time_dwjh_dg(id,tp: integer): integer; //���صȼ�

  procedure      ClientReceiveRemoteDisconnectionNotification(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteConnectionLost(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteNewIncomingConnection(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteExistingConnection(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteStaticData(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionBanned(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionRequestAccepted(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveNewIncomingConnection(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionAttemptFailed(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionResumption(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveNoFreeIncomingConnections(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveDisconnectionNotification(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionLost(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceivedStaticData(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveInvalidPassword(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveModifiedPacket(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveVoicePacket(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceivePong(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveAdvertisedSystem(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientProcessUnhandledPacket(Packet:TRakInterface;MessageID:byte;InterfaceType:TRakInterface); stdcall;

var
  Data_net: TData_net;
  my_send_cmd_g,my_rec_cmd_g: Tmsg_cmd_send;
  my_send_cmd_pak_g: Tmsg_cmd_pk; //���͵����ݰ�������һ��ָ��ͷ���������ݰ�
  my_s_id_G: integer; //������s_id �ڷ������ϵ�����λ��
  user_info_time: array of T_user_id_time;
  dwjh_g: array of Tdwjh_type;  //���齭������
  pk_zhihui_g: T_is_pk_z; //�Ƿ���pk����ָ��״̬
  rec_string_g: string;
  net_guai_g: array[0..4] of Tnet_guai;  //5����������Ĺ���Ϣ
  loc_guai_g: array[0..4] of T_loc_guai;  //���عֵĸ�����Ϣ
implementation
    uses unit_player,unit_data,unit1,unit_net_set,zlib,unit_note,Unit_chat,Dialogs,
  Unit_pop;
{$R *.dfm}
procedure send_pak_tt(const h: byte; Acmd,Adata1,Adata2: integer; As_id: word; r: TPacketReliability= RELIABLE);   //��������
var pk: Tmsg_cmd_pk;
begin
   pk.hander:= byte_to_integer(h,false);
   pk.pak.cmd:= Acmd;
   pk.pak.data1:= Adata1;
   pk.pak.data2:= Adata2;
   pk.pak.s_id:= As_id;

   Data_net.MasterClient.Client.SendBuffer(@pk,sizeof(Tmsg_cmd_pk),MEDIUM_PRIORITY,r,0);

end;

function get_user_id_time_dwjh(id,tp: integer): integer; //����id��0����3����ʾs_id,С�ӣ����ɣ�����id
var i: integer;
begin

result:= 0;

  for i:= 0 to high(user_info_time) do
      if user_info_time[i].s_id= id then
         begin
          case tp of
          1: result:= user_info_time[i].xiaodui;
          2: result:= user_info_time[i].zhuzhi;
          3: result:= user_info_time[i].guojia;
          end;

          exit;
         end;

end;

function get_user_id_time_dwjh_dg(id,tp: integer): integer; //���صȼ�
var i: integer;
begin

result:= 0;

  for i:= 0 to high(user_info_time) do
      if user_info_time[i].s_id= id then
         begin
          case tp of
          1: result:= user_info_time[i].xiaodui_dg;
          2: result:= user_info_time[i].zhuzhi_dg;
          3: result:= user_info_time[i].guojia_dg;
          end;

          exit;
         end;

end;

function get_user_id_time_type(id: integer): p_user_id_time;
var i: integer;
begin

result:= nil;
if id= g_nil_user_c then
   exit;

  for i:= 0 to high(user_info_time) do
      if user_info_time[i].s_id= id then
         begin
          result:= @user_info_time[i];
          exit;
         end;
end;

function net_get_dwjhming(id,tp: integer; n: boolean=false): string; //n,����ʾ����
     var k: integer;
        t: cardinal;
        pk: Tmsg_cmd_pk;
        label pp;
begin
      result:= '��';
      if id= 0 then
         exit;

        pp:
       for k:= 0 to high(dwjh_g) do
        begin
         if dwjh_g[k].dwid= id then
            begin
             if n then
             result:= dwjh_g[k].p_name
             else
             result:='<a href="game_show_dwjh('+ inttostr(id)+','+inttostr(tp)+')" title="�鿴����">'+ dwjh_g[k].p_name + '</a>';
             exit;
            end;
         if k= high(dwjh_g) then
          begin  //���û�з��֣���ô������Ϣ���ȴ���ȡ����Ϣ
            t:= GetTickCount;
             Game_wait_ok1_g:= false;
             game_wait_integer_g:= 0;
             pk.hander:= byte_to_integer(g_rep_dwjh_c,false); //ͷ�ļ�
             pk.pak.data1:= id;
             g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //����
             screen.Cursor:= -11;
             while (Game_wait_ok1_g= false) and (GetTickCount -t < 6000) do
               begin
                  application.ProcessMessages;
                  sleep(10);
               end;
             screen.Cursor:= 0;
             if Game_wait_ok1_g and (game_wait_integer_g=1) then
                goto pp;
          end; //end if k
        end; // enf for
end;
//********************************************************�������ݺ�Ĵ���
function get_or_add_user_id_time_type(sid: integer): p_user_id_time;
var w: word;
begin
     //��ȡ����������ڣ���ô���
    result:= get_user_id_time_type(sid); //ȡ��һ��ָ��
     if result= nil then
        begin
         w:= sid;
         data_net.reshow_net_id_all(2,@w,false); //���һ��id�������б�
         result:= get_user_id_time_type(sid); //�ٴλ�ȡ
        end;
end;

procedure pro_g_cmd_zhuzhi_q(sid: integer);
var ss: string;
begin
   //���������
   ss:= '���<a href="game_show_dwjh('+ inttostr(sid)+',0)" title="�鿴��Ϣ">' + Data_net.get_s_id_nicheng(sid)+ '</a>'+
        '��������ᡣ<a href="game_add_user_dwjh(2,'+inttostr(sid)+','+ inttostr(game_player_head_G.zhuzhi_id) +');game_chat_cleans(0)">ͬ������</a> �� <a href="game_chat_cleans(0)">ȡ��</a>';
   form1.game_chat(ss);
end;

procedure pro_g_cmd_zhuzhi_jr(sid,id: integer);
var i: integer;
begin
   //�����˰��
    if (sid= my_s_id_G) and (game_player_head_G.zhuzhi_id= 0) then
    begin
    game_player_head_G.zhuzhi_id:= id;
    game_player_head_G.zhuzhi_dg:= 0;
     form1.game_chat('<b>������׼�����˰�ᡣ</b>');
    end else begin
              if sid<> my_s_id_G then
               begin
                 for i:= 0 to high(user_info_time) do
                   if (user_info_time[i].s_id= sid) and (user_info_time[i].zhuzhi= 0) then
                      begin
                        user_info_time[i].zhuzhi:= id;
                        user_info_time[i].zhuzhi_dg:= 0;
                        user_info_time[i].time:= GetTickCount;
                        exit;
                      end;
               end;
             end;
end;

procedure pro_g_cmd_guojia_q(sid: integer);
var ss: string;
begin
   //����������
   ss:= '���<a href="game_show_dwjh('+ inttostr(sid)+',0)" title="�鿴��Ϣ">' + Data_net.get_s_id_nicheng(sid)+ '</a>'+
        '���������ҡ�<a href="game_add_user_dwjh(3,'+inttostr(sid)+','+ inttostr(game_player_head_G.guojia_id) +');game_chat_cleans(0)">ͬ������</a> �� <a href="game_chat_cleans(0)">ȡ��</a>';
   form1.game_chat(ss);
end;

procedure pro_g_cmd_guojia_jr(sid,id: integer);
var i: integer;
begin
   //�����˹���
   if (sid= my_s_id_G) and (game_player_head_G.guojia_id= 0) then
    begin
    game_player_head_G.guojia_id:= id;
    game_player_head_G.guojia_dg:= 0;
    form1.game_chat('<b>������׼�����˹��ҡ�</b>');
    end else begin
              if sid<> my_s_id_G then
               begin
                 for i:= 0 to high(user_info_time) do
                   if (user_info_time[i].s_id= sid) and (user_info_time[i].guojia= 0) then
                      begin
                        user_info_time[i].guojia:= id;
                        user_info_time[i].guojia_dg:= 0;
                        user_info_time[i].time:= GetTickCount;
                        exit;
                      end;
               end;
             end;
end;

procedure pro_g_cmd_a_game(sid: integer); //Ҫ��������
var ss: string;
begin
  //�����Ի���ѯ���Ƿ�ͬ�������ӡ�
  ss:= '���<a href="game_show_dwjh('+ inttostr(sid)+',0)" title="�鿴��Ϣ">' + Data_net.get_s_id_nicheng(sid)+ '</a>'+
        '�������С�ӡ�<a href="game_add_user_dwjh(1,'+inttostr(sid)+','+ inttostr(game_player_head_G.duiwu_id) +');game_chat_cleans(0)">ͬ������</a> �� <a href="game_chat_cleans(0)">ȡ��</a>';
   form1.game_chat(ss);
end;
procedure pro_g_cmd_game_ok(sid,id: integer); //���������
var
    p2: p_user_id_time;
begin
  //data1= С��id

   if (sid= my_s_id_G) and (game_player_head_G.duiwu_id= 0) then
    begin
    game_player_head_G.duiwu_id:= id;
    game_player_head_G.duiwu_dg:= 1;
    send_pak_tt(g_xiaodui_sid_c,0,0,0,my_s_id_G); //����������Ա��sid
    form1.game_chat('<b>������׼������С�ӡ�</b>');
    end else begin
              if sid<> my_s_id_G then
               begin
                 //����Է���С�Ӻź��Լ�����ͬ����ô�����Լ���С��
                 p2:= get_or_add_user_id_time_type(sid);
                 if p2= nil then exit;

                   p2.time:= GetTickCount;
                 if id= game_player_head_G.duiwu_id then
                 begin
                   
                    p2.xiaodui:= game_player_head_G.duiwu_id;
                    p2.xiaodui_dg:= 1;

                  Data_net.add_s_id_in_list(sid);
                 end else begin
                           p2.xiaodui:= id;
                           p2.xiaodui_dg:= 0;
                         end;
               end;
             end;

end;

procedure pro_g_cmd_a_pk;     //Ҫ�����pk
begin
  //�����Ի���ѯ���Ƿ�ͬ��Է�����pk

end;
procedure pro_g_cmd_pk_ok;    //ͬ�����pk
begin
  //����data1��ֵ�ж϶Է��Ƿ�ͬ�⣬100��ʾͬ�⣬����ֵ�ܾ�

end;
procedure pro_g_cmd_a_jingsai;  //Ҫ����뾺��
begin
   //�����Ի���ѯ���Ƿ�ͬ��Է����뾺��

end;
procedure pro_g_cmd_jingsai_ok;   //ͬ����뾺��
begin
  //����data1��ֵ�ж϶Է��Ƿ�ͬ�⣬100��ʾͬ�⣬����ֵ�ܾ�

end;
procedure pro_g_cmd_icon_need;
begin
  //����ͷ����Ϣ

end;
procedure pro_g_cmd_shu_need;
begin
  //����������Ϣ��data1��ֵָ����Ҫ�ĸ����������

end;
procedure pro_g_cmd_pk_sl;        //pkʤ��
begin
  //pkʤ�����Ӿ���ֵ

end;
procedure pro_g_cmd_pk_sb;        //pkʧ��
begin
   //pkʧ�ܣ�������ֵ

end;
procedure pro_g_cmd_jingsai_sl;    //����ʤ��
begin
   //����ʤ�����Ӿ���ֵ����Ǯ
end;
procedure pro_g_cmd_jingsai_sb;     //����ʧ��
begin
  //ʧ�ܣ���ȥ

end;

procedure pro_g_cmd_g_cmd_dj_xg(p: pointer); //�ȼ��޸�
var p2: p_user_id_time;
    cmd,d_sid: integer;
    pk: Tmsg_cmd_pk3;
begin
   //dwjh ��cmd˵����1=�޸��˶�Աģʽ��2=������µļ���3=�������µļ��� data1��ʾ���޸ĵ� sid��
   //data2��ʾ�µ���ֵ  s_id ��ʾ��Ϣ�����ߵ�id
p2:= nil;
cmd:= longrec(Tmsg_cmd_send(p^).data1).Hi;
d_sid:= longrec(Tmsg_cmd_send(p^).data1).Lo;
   if d_sid<> my_s_id_G then
    begin
     p2:= get_or_add_user_id_time_type(d_sid); //��������޸��Լ�����ôȡ��һ��ָ��
         if p2<>nil then
           begin
            p2.xiaodui:= game_player_head_G.duiwu_id;
            p2.nicheng:= '';
            p2.page:= 0;
           end else exit;

    end;

   case cmd of
   1: begin   //С��
       if d_sid=my_s_id_G then //���޸ĵ����Լ� ������û���Է��Ƿ���Ȩ�޵ļ��
        begin
              if pk_zhihui_g.game_zt >= 5 then  //�������ս��״̬  ���ﴦ��Ĳ��Ǻܺ�
               begin
                    pk.hander:= byte_to_integer(g_rep_zd_c,false); //ת��
                    pk.id:= Tmsg_cmd_send(p^).s_id;
                    pk.hander2:= byte_to_integer(g_rec_cmd_c,false); //��������
                    pk.pak.cmd:= g_cmd_gg_shibai;
                    pk.pak.data1:= 1; //1��ʾ����ս����
                    pk.pak.data2:= d_sid;
                     g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk3));  //�������ս��״̬����ô�Է������޸���Ч
               end else begin
                    game_player_head_G.duiwu_dg:= Tmsg_cmd_send(p^).data2;
                    if game_player_head_G.duiwu_dg > 0 then
                     begin
                      form1.game_chat('���ӳ���Ϊ��<b>����ģʽ��</b>');
                     end else begin
                                form1.game_chat('���ӳ���Ϊ��<b>����ģʽ��</b>');
                              end;
                        end;
        end  else begin
                 //�Է�������Ϊ����״̬����ʱ���������ս���У��޸���Ч������Ƕӳ��������ܾ�ָ��
                if pk_zhihui_g.game_zt >= 5 then  //�������ս��״̬
                  begin
                    if game_player_head_G.duiwu_dg= 100 then
                    begin
                    pk.hander:= byte_to_integer(g_rep_zd_c,false); //ת��
                    pk.id:= d_sid;
                    pk.hander2:= byte_to_integer(g_rec_cmd_c,false); //��������
                    pk.pak.cmd:= g_cmd_gg_shibai;
                    pk.pak.data1:= 1; //1��ʾ����ս����
                    pk.pak.data2:= d_sid;
                     g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk3));  //�������ս��״̬����ô�Է������޸���Ч
                    end;

                    exit;  //�˳�
                  end;

                p2.xiaodui_dg:= Tmsg_cmd_send(p^).data2; //�޸ı���
                if game_player_head_G.duiwu_id= p2.xiaodui then
                 begin
                   if p2.xiaodui_dg > 0 then
                     begin
                      Data_net.add_s_id_in_list(p2.s_id);
                      form1.game_chat(Data_net.get_s_id_nicheng(p2.s_id)+'��Ϊ��<b>����ģʽ��</b>');
                     end else begin
                                Data_net.del_s_id_in_list(p2.s_id);
                                form1.game_chat(Data_net.get_s_id_nicheng(p2.s_id)+'��Ϊ��<b>����ģʽ��</b>');
                              end;
                 end;
               end;
      end;
   2: begin
        if d_sid=my_s_id_G then //���޸ĵ����Լ� ������û���Է��Ƿ���Ȩ�޵ļ��
          game_player_head_G.zhuzhi_dg:= Tmsg_cmd_send(p^).data2
          else p2.zhuzhi_dg:= Tmsg_cmd_send(p^).data2; //�޸ı���
      end;
   3: begin
        if d_sid=my_s_id_G then //���޸ĵ����Լ� ������û���Է��Ƿ���Ȩ�޵ļ��
          game_player_head_G.guojia_dg:= Tmsg_cmd_send(p^).data2
          else p2.guojia_dg:= Tmsg_cmd_send(p^).data2; //�޸ı���
      end;
   end;

end;
procedure pro_g_cmd_page(i: integer); //����ҳ��
begin
  //������ָ����ҳ��
  //=0��Ա������ģʽ��=1��Ա����ģʽ��=2��ӣ�����ģʽ��=3��ӣ��쵼ģʽ ,4��Ա����ָ���
 if game_player_head_G.duiwu_dg= 1 then
   begin
    game_page_from_net_g:= true;
    form1.game_page(i);
    game_page_from_net_g:= false;
   end;
end;
procedure close_all_window;
begin //�رշ�������
   while screen.ActiveForm.Name<> 'Form1' do
         screen.ActiveForm.Close;
end;

procedure pro_g_cmd_zhandou; //����ս��
begin
  //����ս������

end;
procedure pro_g_cmd_bishai; //�������
begin
  //������������


end;
procedure pro_g_cmd_pop(p: pointer); //����������ҳ��
var p2: p_user_id_time;
begin
  //���������ʴ��ڣ�data1ָ����Ҫ��������

   {//�ӳ�������ָ����������ʻ��ߴ�ִ���
      //flag 1�����ʣ�2������Ч���ı����ʴ��ڣ�3��֣�4������Ч���Ĵ�֣�5�������͵Ĵ��
      data1��ʾshu��shu���Ǳ����ʵ��������߹��������
      data2��ʾ�������ͣ�һ�����±�ʾ���ع֣�һ�����ϣ������߶���һ��sid��������������һ��С��id
      }


      p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           (game_player_head_G.duiwu_dg= 1) then
         begin  //ֻ�������Զӳ���ָ�����ȫ����
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop(Tmsg_cmd_send(p^).data1);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_a(p: pointer);  //������
var p2: p_user_id_time;
begin
  p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           (game_player_head_G.duiwu_dg= 1) then
         begin  //ֻ�������Զӳ���ָ�����ȫ����
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_a(Tmsg_cmd_send(p^).data1);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_pk(p: pointer);   //���
var p2: p_user_id_time;
begin
  p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           ((game_player_head_G.duiwu_dg = 1) or (game_player_head_G.duiwu_dg = 2)) then
         begin  //ֻ�������Զӳ���ָ�����ȫ����
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_fight(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_pk_a(p: pointer);    //������
var p2: p_user_id_time;
begin
  p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           ((game_player_head_G.duiwu_dg = 1) or (game_player_head_G.duiwu_dg = 2)) then
         begin  //ֻ�������Զӳ���ָ�����ȫ����
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_fight_a(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_game(p: pointer);   //����
var p2: p_user_id_time;
begin
   p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           ((game_player_head_G.duiwu_dg = 1) or (game_player_head_G.duiwu_dg = 2)) then
         begin  //ֻ�������Զӳ���ָ�����ȫ����
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_game(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
            game_page_from_net_g:= false;
         end;
       end;
end;
procedure pro_g_cmd_gg_shibai(p: pointer);         //����״̬ʧ��
var p2: p_user_id_time;
begin
  //data2��һ������״̬ʧ�ܣ���Ҫ���Ļ�0��sid��
  if Tmsg_cmd_send(p^).data2= my_s_id_g then
     begin
     game_player_head_G.duiwu_dg:= 0;
     //�޸�һ������
     send_pak_tt(g_pl_data_chag,0,5,0,my_s_id_g);
     end else begin
                p2:= get_user_id_time_type(Tmsg_cmd_send(p^).data2);
                if p2<> nil then
                   p2.xiaodui_dg:= 0;
              end;

  case Tmsg_cmd_send(p^).data1 of
  1: form1.game_chat('����״̬ʧ�ܣ��Է�����ս���С�');
  2: form1.game_chat('����״̬ʧ�ܣ��ܾ���');
  3: form1.game_chat('����״̬ʧ�ܣ�ԭ������');
  end;

end;
procedure pro_g_cmd_exit(p: pointer);       //����˳�
begin
  //����Ǳ�С�ӵģ���ô��С�����������
  //Ȼ���ȫ�ֱ����

 if Tmsg_cmd_send(p^).data2= game_player_head_G.duiwu_id then
    Data_net.del_s_id_in_list(Tmsg_cmd_send(p^).s_id);

    Data_net.nil_s_id_from_list_g(Tmsg_cmd_send(p^).s_id);

end;
procedure pro_g_cmd_xiaodui_sid(p: pointer);    //�յ�С��������Աsid ��Ϣ
var p2: p_user_id_time;
begin
  if Tmsg_cmd_send(p^).s_id<> g_nil_user_c then
   begin //�ӳ�
     p2:= get_or_add_user_id_time_type(Tmsg_cmd_send(p^).s_id);
     if p2<> nil then
      begin
        p2.xiaodui:= game_player_head_G.duiwu_id;
        p2.xiaodui_dg:= 100;
      end;
   end;
  if longrec(Tmsg_cmd_send(p^).data1).Lo<> g_nil_user_c then
   begin //��Աһ
    p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data1).Lo);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;

    Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data1).Lo);
   end;
  if longrec(Tmsg_cmd_send(p^).data1).Hi<> g_nil_user_c then
   begin //��Ա��
     p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data1).Hi);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;

     Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data1).Hi);
   end;
  if longrec(Tmsg_cmd_send(p^).data2).Lo<> g_nil_user_c then
   begin //��Ա��
    p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data2).Lo);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;
    Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data2).Lo);
   end;
  if longrec(Tmsg_cmd_send(p^).data2).Hi<> g_nil_user_c then
   begin //��Ա��
     p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data2).Hi);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;

     Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data2).Hi);
   end;
end;
procedure pro_g_cmd_dwjh_exit(p: pointer);   //dwjh�����˳�
var p2: p_user_id_time;
begin
     p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
     if p2= nil then
       exit;

  case Tmsg_cmd_send(p^).data1 of
  1: begin
       //����˳������Ǳ�С�ӵģ���ô����С�������������˳������Ƕӳ�����ô����С�����
       if Tmsg_cmd_send(p^).data2= game_player_head_G.duiwu_id then
           Data_net.del_s_id_in_list(Tmsg_cmd_send(p^).s_id);

          p2.xiaodui:= 0;
          p2.xiaodui_dg:= 0;

     end;
  2: begin
      p2.zhuzhi:= 0;
      p2.zhuzhi_dg:= 0;
     end;
  3: begin
      p2.guojia:= 0;
      p2.guojia_dg:= 0;
     end;
  end;

end;
procedure pro_g_cmd_dj_xd_r(p: pointer);    //�Ƿ������޸�С��ģʽ
begin
  {���Ȳ�ѯ����״̬�����������ô�ٲ鿴���Ķ����Ƿ��Լ���
  ����Լ��ǣ������ǶԷ���Ҫ���ĸ���ģʽ�����͸���ָ��
  ������Ƕӳ�����ô�����ǶԷ���Ҫ�޸��Լ��������Լ�����ָ��
  }

end;
procedure pro_g_cmd_pop_wak;     //���صĳ����¼�ֵ
begin
  //���յ���ָ�������¼���ֵ
  //��Ҫ�ѽ��յ��������Ϊ��

end;
procedure pro_g_cmd_pop_caiyao;           //��Ʒ��¼�¼�  ���ܣ�
begin
   //Ŀǰ����
end;
procedure pro_g_cmd_res_a;
begin
 //���ֵ����Ʒ�¼��б�

end;
procedure pro_g_cmd_res_d;
begin
  //����Ʒ�¼��б�ɾ��

end;
procedure pro_g_cmd_res_r;
begin
  //������Ʒ�¼�ֵ

end;
procedure pro_g_cmd_res_rr;
begin
   //���յ�����Ʒ�¼�
   //�յ��������Ϊ��

end;
procedure pro_g_cmd_wupin;         //��Ʒ���ܣ�
begin
   //Ŀǰ����

end;
procedure pro_g_cmd_wupin_qingkong;     //�����Ʒ
begin
   //��ָ����Ʒ�������

end;
procedure pro_g_cmd_wupin_xiugai;        //�޸���Ʒ����
begin
  //�޸���Ʒ���� data1ֵΪ1��ʾ���ӣ�Ϊ2��ʾ���٣�Ϊ4��ʾ����Ϊdata2ָ����ֵ

end;
procedure pro_g_cmd_wupin_r;             //Ҫ���ȡ��Ʒ����
begin
  //������Ʒ����

end;
procedure pro_g_cmd_wupin_rr;            //���ص���Ʒ����
begin
  //��ȡ������Ʒ��������Ӧ�ȴ���־����Ϊ��

end;
procedure pro_g_cmd_my_atc;             //�ҷ�����
begin
  //�յ�����Ϣ��ʼ����

end;
procedure pro_g_cmd_my_wufa;           //�ҷ�������Ʒ
begin
  //�յ�����Ϣ��ʼʹ����Ʒ���߷���

end;
procedure pro_g_cmd_my_shu;             //�ҷ������޸�
begin
  //�޸�����

end;
procedure pro_g_cmd_guai_atc;           //�ֹ���
begin
   //���￪ʼ����

end;
procedure pro_g_cmd_guai_wufa;          //�ַ�����Ʒ
begin
  //����ʹ������Ʒ���߷���

end;
procedure pro_g_cmd_my_bl;              //�ҷ�����ֵƮ��
begin
  //Ʈ������ֵ

end;
procedure pro_g_cmd_guai_bl;             //�ַ�Ʈ��
begin
  //��Ʈ������ֵ

end;
procedure pro_g_cmd_my_dead;              //�ҷ���������
begin
   //ָ����������

end;
procedure pro_g_cmd_guai_dead;            //������
begin
   //ָ����������

end;
procedure pro_g_cmd_game_over;            //��Ϸ����
begin
  //ս��ʧ��

end;
procedure pro_g_cmd_win;                  //ս��ʤ��
begin
   //ս��ʤ��

end;
procedure pro_g_cmd_chg_m; //�޸Ľ�Ǯ
begin
  //�޸Ľ�Ǯ data1ֵΪ1��ʾ���ӣ�Ϊ2��ʾ���٣�Ϊ4��ʾ����Ϊdata2ָ����ֵ

end;
procedure pro_g_cmd_cl_m;   //��ս�Ǯ
begin
  //��ǮΪ��

end;
procedure pro_g_cmd_r_m;   //Ҫ���ȡ��Ǯ
begin
    //���ͽ�Ǯֵ

end;
procedure pro_g_cmd_rr_m;   //���صĽ�Ǯֵ
begin
   //�����˽�Ǯֵ����Ӧ�ȴ���־����Ϊ��

end;

procedure pro_g_cmd_ip_rr; //�������Լ���ip
begin
  //�յ���ip����������

end;
procedure pro_g_cmd_redirect_ip; //�Ӷ���������������ַ
begin
   //������������ַ

end;

//***************************���죨�����ݣ���Ϣ
procedure pro_g_cmd_chat(p: pointer; c: integer); //˽������
var i,j,k,sid: integer;
    ss: string;
    p2: p_user_id_time;
begin
 //��ʾ������Ϣ
 j:= 0; //ͳ���Ѿ����������촰������������
 k:= -1;
 sid:= integer(p^);
   setlength(ss,c-4);
        move(pointer(dword(p)+ 4)^,pointer(ss)^,c-4);
  p2:= get_or_add_user_id_time_type(sid); //�������ʵ��
     if p2<> nil then
       if p2.u_id= '' then
          p2.nicheng:= Data_net.get_s_id_nicheng(sid);


  for i:= 0 to application.ComponentCount-1 do
   begin
    if application.Components[i] is Tform_chat then
     begin
      if Tform_chat(application.Components[i]).player_chat_id= integer(p^) then
       begin

        Tform_chat(application.Components[i]).add_message(ss);
        Tform_chat(application.Components[i]).Show;
         exit;
       end else begin
                 inc(j);
                 if Tform_chat(application.Components[i]).player_chat_id < 0 then
                    k:= i; //������һ�����ض��˵����촰��
                 if i= application.ComponentCount-1 then
                  begin
                    //����û���ҵ����ʵģ���ô�ٴ�������û����Է��ض��˵����촰�ڴ���
                    if k<> -1 then
                     begin
                      Tform_chat(application.Components[k]).add_message(ss);
                      Tform_chat(application.Components[k]).Show;
                      exit;
                     end else begin
                               with Tform_chat.Create(application) do
                                begin
                                  if j >= 16 then //�������촰�ڲ�Ҫ����
                                    player_chat_id:= -5
                                    else
                                      player_chat_id:= integer(p^);
                                  
                                  add_message(ss);
                                  Show;
                                end;

                              end;
                  end;
                end;
     end;

   end; // for i

   if j= 0 then
    with Tform_chat.Create(application) do
        begin
        player_chat_id:= integer(p^);
        add_message(ss);
        Show;
        end;
end;

procedure pro_g_cmd_name(p: pointer; const ip: string; pt: integer); //������������
begin
 //��ʾ��������
end;
procedure pro_g_cmd_icon(p: pointer; const ip: string; pt: integer); //ͷ������
begin
  //�������ʾͷ��
end;
procedure pro_g_cmd_data(p: pointer; const ip: string; pt: integer); //�Զ������ݰ�
begin
  //�������ݣ�����ͬ����

end;

//***************************************************************************
procedure ClientReceiveConnectionAttemptFailed(Packet,
  InterfaceType:TRakInterface);
begin
  // raktest.MemoServer.Lines.Add('Client recived : Connection Attemp Failed');
end;

procedure ClientReceiveConnectionBanned(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Connection Banned');
 Data_net.MSConnected:= false; //��ֹ����
end;

procedure ClientReceiveConnectionLost(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Connection lost');
 Data_net.MSConnected:= false;         //����Ͽ�

end;

procedure ClientReceiveConnectionRequestAccepted(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Recived Connection Request Accept');
  Data_net.MSConnected:= true; //������һ������
end;

procedure ClientReceiveConnectionResumption(Packet,
  InterfaceType:TRakInterface);
begin
 //  raktest.MemoServer.Lines.Add('Client recived : Connection Resumption ');
  Data_net.MSConnected:= true;         //����ָ�
end;

procedure ClientReceiveDisconnectionNotification(Packet,
  InterfaceType:TRakInterface);
begin
//  raktest.MemoServer.Lines.Add('Client recived : Disconnect Notification ');
end;

procedure ClientReceivedStaticData(Packet, InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Static data');
end;

procedure ClientReceiveInvalidPassword(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Invalid Password');
 Data_net.MSConnected:= false; //������Ч
end;

procedure ClientReceiveModifiedPacket(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived :Mofified Packet ');
end;

procedure ClientReceiveNewIncomingConnection(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : New Incoming Connection');
end;

procedure ClientReceiveNoFreeIncomingConnections(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : No Free Incoming Connection ');
end;

procedure ClientReceivePong(Packet, InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Receive Pong ');

end;

procedure ClientReceiveRemoteConnectionLost(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Remote Connection Lost');
end;

procedure ClientReceiveRemoteDisconnectionNotification(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Disconnect notification ');
end;

procedure ClientReceiveRemoteExistingConnection(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Existing Connection ');
end;

procedure ClientReceiveRemoteNewIncomingConnection(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Remote New Incoming Connection');
end;

procedure ClientReceiveRemoteStaticData(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Remote static data ');
end;

procedure ClientReceiveVoicePacket(Packet, InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Voice Packet');
end;


procedure	 ClientReceiveAdvertisedSystem(Packet,InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Advertise system');
end;

procedure	 ClientProcessUnhandledPacket(Packet:TRakInterface;MessageID:byte;InterfaceType:TRakInterface);
var b:boolean;
    p,p2: pointer;
    ii,c2: integer;
    c: cardinal;
begin   //�յ�����

   c:= TRAKPacket_Length(Packet);

  if c  < 5 then
   exit;

   p:=  TRAKPacket_data(Packet);
   c:= c- 4;  //��ȥ��ͷ�ϵ�4�ֽ�����

   move(p^,(@ii)^,4);
   dword(p):= dword(p) +4;

   case integer_to_byte(ii,b) of
      g_server_gonggao_c : begin
                            //�յ�������ͨ��
                            setlength(rec_string_g,c);
                            move(p^,pointer(rec_string_g)^,c);
                            Form_net_set.richedit1.Text:= rec_string_g;
                           end;
       g_player_rq_c: begin
                     //�յ��������˷��ص��������
                     ZDecompress(p,c,p2,c2);
                     if c2 > 20 then
                      begin
                      game_wait_integer_g:= game_add_player_from_net(p2,c2);
                      Game_wait_ok1_g:= true;
                      end;
                      freemem(p2,c2);
                   end;
       g_wupin_rq_c: begin
                     //�յ��������˷��ص������Ʒ���ݣ���Ϸ��¼ʱ
                       ZDecompress(p,c,p2,c2);
                     if c2 > 20 then
                      begin
                      game_wait_integer_g:= game_add_goods_from_net(p2,c2);
                      Game_wait_ok1_g:= true;
                      end;
                      freemem(p2,c2);

                   end;
       g_secne_rq_bl_c: begin
                     //�յ��������˷��صĳ����¼���bool
                     Game_wait_ok2_g:= true;
                    game_wait_integer2_g:= Tmsg_cmd_send(p^).data1;
                   end;
       g_scene_rq_int_c: begin
                     //�յ��������˷��صĳ����¼���int
                    Game_wait_ok2_g:= true;
                    game_wait_integer2_g:= Tmsg_cmd_send(p^).data1;
                   end;
       g_guojia_page_rq_c: begin
                     //�յ��������˷��صĹ���ҳ����
                     Game_wait_ok2_g:= true;
                    game_wait_integer2_g:= Tmsg_cmd_send(p^).data1;
                   end;
       g_rep_online_page_data_c: begin
                    //�յ��˷����������ĵ�ǰҳ������������ϸ����
                    ZDecompress(p,c,p2,c2);
                    Data_net.game_page_online_data(p2,c2);
                    freemem(p2,c2);
                   end;

       g_rep_dwjh_c: begin
                       //�յ�dwjh���� 53
                      ZDecompress(p,c,p2,c2);
                    Data_net.game_dwjh_data(p2,c2);
                    freemem(p2,c2);
                     end;
       g_rep_guai_c: begin
                       //�յ�������
                       game_wait_integer_g:= c div sizeof(Tnet_guai); //ȡ�ù�����
                        if game_wait_integer_g > 0 then
                          begin
                           move(p^,net_guai_g,c);
                          end;

                       Game_wait_ok1_g:= true;
                     end;
      g_rec_cmd_c: begin
                     //�յ��������˷��صĲ�ѯ���ݻ��߷�������ָ�cmdָ��������************
                     case Tmsg_cmd_send(p^).cmd of
                  g_cmd_zhuzhi_q: pro_g_cmd_zhuzhi_q(Tmsg_cmd_send(p^).s_id);
                  g_cmd_zhuzhi_jr:pro_g_cmd_zhuzhi_jr(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
                  g_cmd_guojia_q: pro_g_cmd_guojia_q(Tmsg_cmd_send(p^).s_id);
                  g_cmd_guojia_jr:pro_g_cmd_guojia_jr(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
                  g_cmd_a_game:pro_g_cmd_a_game(Tmsg_cmd_send(p^).s_id); //Ҫ��������
                  g_cmd_game_ok:pro_g_cmd_game_ok(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2); //ͬ��������
                  g_cmd_a_pk:pro_g_cmd_a_pk;     //Ҫ�����pk
                  g_cmd_pk_ok:pro_g_cmd_pk_ok;    //ͬ�����pk
                  g_cmd_a_jingsai:pro_g_cmd_a_jingsai;  //Ҫ����뾺��
                  g_cmd_jingsai_ok:pro_g_cmd_jingsai_ok;   //ͬ����뾺��
                  g_cmd_icon_need:pro_g_cmd_icon_need;
                  g_cmd_shu_need:pro_g_cmd_shu_need;
                  g_cmd_pk_sl:pro_g_cmd_pk_sl;        //pkʤ��
                  g_cmd_pk_sb:pro_g_cmd_pk_sb;        //pkʧ��
                  g_cmd_jingsai_sl:pro_g_cmd_jingsai_sl;    //����ʤ��
                  g_cmd_jingsai_sb:pro_g_cmd_jingsai_sb;     //����ʧ��
                  g_cmd_dj_xg:pro_g_cmd_g_cmd_dj_xg(p); //�ȼ��޸�
                  g_cmd_page:pro_g_cmd_page(Tmsg_cmd_send(p^).data1); //����ҳ��
                  g_cmd_zhandou:pro_g_cmd_zhandou; //����ս��
                  g_cmd_bishai:pro_g_cmd_bishai; //�������
                  g_cmd_pop:pro_g_cmd_pop(p); //����������ҳ��
                  g_cmd_pop_a:pro_g_cmd_pop_a(p);  //������Ч���ı�����
                  g_cmd_pop_pk:pro_g_cmd_pop_pk(p);   //������
                  g_cmd_pop_pk_a:pro_g_cmd_pop_pk_a(p);    //������Ч���Ĵ��
                  g_cmd_pop_game:pro_g_cmd_pop_game(p);   //����
                  g_cmd_gg_shibai:pro_g_cmd_gg_shibai(p);        //����״̬ʧ��
                  g_cmd_exit:pro_g_cmd_exit(p);       //����˳�
                  g_cmd_xiaodui_sid:pro_g_cmd_xiaodui_sid(p);    //�յ�С��������Աsid��Ϣ
                  g_cmd_dwjh_exit:pro_g_cmd_dwjh_exit(p);    //dwjh �����˳�
                  g_cmd_dj_xd_r:pro_g_cmd_dj_xd_r(p);    //�Ƿ������޸�С�ӵȼ�
                  g_cmd_pop_wak:pro_g_cmd_pop_wak;     //���صĳ����¼�ֵ
                  g_cmd_pop_caiyao:pro_g_cmd_pop_caiyao;           //��Ʒ��¼�¼�  ���ܣ�
                  g_cmd_res_a:pro_g_cmd_res_a;
                  g_cmd_res_d:pro_g_cmd_res_d;
                  g_cmd_res_r:pro_g_cmd_res_r;
                  g_cmd_res_rr:pro_g_cmd_res_rr;
                  g_cmd_wupin:pro_g_cmd_wupin;         //��Ʒ���ܣ�
                  g_cmd_wupin_qingkong:pro_g_cmd_wupin_qingkong;     //�����Ʒ
                  g_cmd_wupin_xiugai:pro_g_cmd_wupin_xiugai;        //�޸���Ʒ����
                  g_cmd_wupin_r:pro_g_cmd_wupin_r;             //Ҫ���ȡ��Ʒ����
                  g_cmd_wupin_rr:pro_g_cmd_wupin_rr;            //���ص���Ʒ����
                  g_cmd_my_atc:pro_g_cmd_my_atc;             //�ҷ�����
                  g_cmd_my_wufa:pro_g_cmd_my_wufa;           //�ҷ�������Ʒ
                  g_cmd_my_shu:pro_g_cmd_my_shu;             //�ҷ������޸�
                  g_cmd_guai_atc:pro_g_cmd_guai_atc;           //�ֹ���
                  g_cmd_guai_wufa:pro_g_cmd_guai_wufa;          //�ַ�����Ʒ
                  g_cmd_my_bl:pro_g_cmd_my_bl;              //�ҷ�����ֵƮ��
                  g_cmd_guai_bl:pro_g_cmd_guai_bl;             //�ַ�Ʈ��
                  g_cmd_my_dead:pro_g_cmd_my_dead;              //�ҷ���������
                  g_cmd_guai_dead:pro_g_cmd_guai_dead;            //������
                  g_cmd_game_over:pro_g_cmd_game_over;            //��Ϸ����
                  g_cmd_win:pro_g_cmd_win;                  //ս��ʤ��
                  g_cmd_chg_m:pro_g_cmd_chg_m; //�޸Ľ�Ǯ
                  g_cmd_cl_m:pro_g_cmd_cl_m;   //��ս�Ǯ
                  g_cmd_r_m:pro_g_cmd_r_m;   //Ҫ���ȡ��Ǯ
                  g_cmd_rr_m:pro_g_cmd_rr_m;   //���صĽ�Ǯֵ
                  g_cmd_ip_rr:pro_g_cmd_ip_rr; //�������Լ���ip
                  g_cmd_redirect_ip:pro_g_cmd_redirect_ip; //�Ӷ���������������ַ

                    end; //end case
                     //****************************************************************8
                   end;
      g_rec_cmd_dw_c: begin
                        //�յ�������Ϣ�ı�
                      end;
      g_rec_nc_dw_c: begin
                        //�յ������ǳƸı�
                     end;
      g_rec_login_c: begin
                     //������������Ϣ��data1ָ���� 1��¼�ɹ���2��¼���ܾ���δͨ����ˣ�3������Ա��ֹ��4�ͻ��˰汾���ͣ�5������������6δ֪�ľܾ�����
                    // move(p^,my_msg_cmd_g,c);
                    Game_wait_ok1_g:= true;
                    game_wait_integer_g:= Tmsg_cmd_send(p^).data1;
                    if game_wait_integer_g= 1 then
                       my_s_id_G:= Tmsg_cmd_send(p^).data2; //�����·������˵�s_id
                   end;
      g_rec_kick_c: begin
                     //���������߳�
                     case Tmsg_cmd_send(p^).data1 of
                     1:form1.game_show_note('��������Ա�߳��˷�������');
                     2: form1.game_show_note('������ʹ����ң����������߳���');
                     3: form1.game_show_note('������Ʒ�����ͷ������ϵĲ�һ�£����ж������ӡ�');
                     4: form1.game_show_note('���������߳���Ϸ��ԭ������');
                     end;
                      Data_net.MasterClient.Client.Disconnect(0,0);
                      Data_net.MSConnected:= false;
                      Game_at_net_G:= false;
                      form1.game_page(14444); //��Ϸ����
                   end;    
      g_rec_reg_c: begin
                     //ע����Ϣ��data1=1��ע��ɹ���2ע��ʧ����ͬ�����ڣ�3ע��ʧ��,��������ֹ������ԭ��
                   // move(p^,my_msg_cmd_g,c);
                    Game_wait_ok1_g:= true;
                    game_wait_integer_g:= Tmsg_cmd_send(p^).data1;
                     if (Tmsg_cmd_send(p^).cmd= 2) and (Tmsg_cmd_send(p^).data1=1) then
                       begin
                          //�����˴���dwjh������
                        case Tmsg_cmd_send(p^).s_id of
                         1: begin
                             game_player_head_G.duiwu_id:= Tmsg_cmd_send(p^).data2;
                             game_player_head_G.duiwu_dg:= 100;
                            end;
                         2: begin
                             game_player_head_G.zhuzhi_id:= Tmsg_cmd_send(p^).data2;
                             game_player_head_G.zhuzhi_dg:= 100;
                            end;
                         3: begin
                             game_player_head_G.guojia_id:= Tmsg_cmd_send(p^).data2;
                             game_player_head_G.guojia_dg:= 100;
                            end;
                         end;
                       end;
                   end;
      g_rec_reg_cx_c: begin
                     //����Ƿ��ע���ѯ����  data1=1������ע�ᣬ2=����ע�ᣬ�������ر�ע�ᣬ3��id�Ѿ�����
                   // move(p^,my_msg_cmd_g,c);
                    Game_wait_ok1_g:= true;
                    game_wait_integer_g:= Tmsg_cmd_send(p^).data1;
                   end;    
      g_rec_chat_c: begin
                     //�������ݣ�����4���ֽ�ָ�������Ե�id���ı���
                     pro_g_cmd_chat(p,c);
                   end;    
      g_rec_note_c: begin
                     //֪ͨ��ͨ����ı�
                     setlength(rec_string_g,c);
                     move(p^,pointer(rec_string_g)^,c);
                     Form_note.add_and_show(rec_string_g);
                   end;    
      g_rec_icon_c: begin
                     //�յ���ͷ�����ݣ�����id���������
                   end;    
      g_rec_player_cmd_c: begin
                     //�յ������ͻ��˷��������� cmd��������
                   end; 
      g_req_player_cmd_c: begin
                    //�����ͻ����������ݣ�cmdָ������Ҫ����������
                   end;
      g_rec_page_chg_c: begin
                    //��id��������˳���ҳ��
                      Data_net.reshow_net_id(Tmsg_cmd_send(p^).s_id,Tmsg_cmd_send(p^).cmd,Tmsg_cmd_send(p^).data1);
                   end;
      g_rec_page_data_c: begin
                    //�յ��˷���˷��͵��û�����id
                       Data_net.reshow_net_id_all(c,p);
                   end;
      g_rec_role_act_c: begin
                    //�յ����������Ķ������ݣ���ʼ����

                   end;
      g_rec_kongzhi_c: begin
                          //�յ��˿���ָ��
                        Form_pop.net_cmd_center(Tmsg_cmd_send(p^).cmd,Tmsg_cmd_send(p^).data1,
                                                Tmsg_cmd_send(p^).data2,Tmsg_cmd_send(p^).s_id);
                       end;
    end;
   //���ݰ�����

end;
//*******************************************************************************


function ip_to_crd(const ip: string):cardinal;
var i,j: integer;
begin
 i:= fastcharpos(ip,'.',1);
 result:= strtoint(copy(ip,1,i-1));
   j:= fastcharpos(ip,'.',i+1);
  result:=result shl 8 + cardinal(StrToInt(copy(ip,i+1,j-1)));
  i:= j;
  j:= fastcharpos(ip,'.',i+1);
  result:=result shl 8+ cardinal(strtoint(copy(ip,i+1,j-1)));
  i:= j;
  result:=result shl 8+ cardinal(strtoint(copy(ip,i+1,3)));
end;

function crd_to_ip(c:cardinal): string;
begin
 result:= inttostr(c and $FF000000) + '.'+
          inttostr(c and $00FF0000) + '.'+
          inttostr(c and $0000FF00) + '.'+
          inttostr(c and $000000FF);
end;


procedure g_send_msg_cmd(p:pointer; i: integer); //��������
begin
 // p.crc:= CRC16_std($FFFF,pchar(p),sizeof(Tmsg_cmd_send)-2); //crc��Ϣ����
  Data_net.MasterClient.Client.SendBuffer(p,i,MEDIUM_PRIORITY,RELIABLE,0);
end;

procedure g_send_msg_str(const s: string); //��������
begin
 //�����ַ���
 Data_net.MasterClient.Client.SendBuffer(pchar(s),length(s),MEDIUM_PRIORITY,RELIABLE,0);
end;

function TData_net.g_start_udpserver2(const ip: string): boolean;  //��ʼ����
begin
  if not MSConnected then
   begin
    try
     InitializateClientServer(ip);

   except
     MSConnected:= false;
    end;

   end;

  result:= MSConnected;
end;


procedure TData_net.Timer1Timer(Sender: TObject);
begin

  IntIdle;

end;


procedure TData_net.InitializateClientServer(const ip: string);
var
    t: cardinal;

begin
MSConnected:= false;
  MasterClient := TRaknetMultiplayerClient.Create;
  SetCallback(MasterClient.GetCallbackList);

    MasterClient.Client.SetPassword('sata');


  MasterClient.Client.SetMTUSize(576);

 // ClientServerInited:= MasterClient.Client.Connect(ip,net_port_c,clinet_port_c,0,0);
    ClientServerInited:= MasterClient.Client.Connect(ip,net_port_c,strtoint(inputbox('�˿�','�˿�','35677')),0,1);
  //MasterClient.Client.RegisterAsRemoteProcedureCall('ClientMessageRPC',ClientRPC,ClientRPC.RpcCallback);
     MasterClient.Client.StartOccasionalPing;
   t:= GetTickCount;
  while (MSConnected= false) and (GetTickCount -t < 9000) do
      begin
        MasterClient.ProcessMessages;
        application.ProcessMessages;
        
      sleep(10);
     end;

      timer1.Enabled:= MSConnected;


end;

procedure TData_net.IntIdle;
begin
 if ClientServerInited then
   MasterClient.ProcessMessages;
end;

procedure TData_net.UnInitializateClientServer;
begin
   ClientServerInited := False;
   MasterClient.Client.Disconnect(0,0);
  // MasterClient.Client.UnregisterAsRemoteProcedureCall('ClientMessageRPC');
   MasterClient.Destroy;
   MSConnected:= false;
end;

procedure TData_net.SetCallback(xCall: PTMultiPlayerCallbackList);
begin

with xCall^ do
  begin
  ReceiveRemoteDisconnectionNotification  :=  ClientReceiveRemoteDisconnectionNotification;
  ReceiveRemoteConnectionLost             :=  ClientReceiveRemoteConnectionLost;
  ReceiveRemoteNewIncomingConnection      :=  ClientReceiveRemoteNewIncomingConnection;
  ReceiveRemoteExistingConnection         :=  ClientReceiveRemoteExistingConnection;
  ReceiveRemoteStaticData                 :=  ClientReceiveRemoteStaticData;
  ReceiveConnectionBanned                 :=  ClientReceiveConnectionBanned;
  ReceiveConnectionRequestAccepted        :=  ClientReceiveConnectionRequestAccepted;
  ReceiveNewIncomingConnection            :=  ClientReceiveNewIncomingConnection;
  ReceiveConnectionAttemptFailed          :=  ClientReceiveConnectionAttemptFailed;
  ReceiveConnectionResumption             :=  ClientReceiveConnectionResumption;
  ReceiveNoFreeIncomingConnections        :=  ClientReceiveNoFreeIncomingConnections;
  ReceiveDisconnectionNotification        :=  ClientReceiveDisconnectionNotification;
  ReceiveConnectionLost                   :=  ClientReceiveConnectionLost;
  ReceivedStaticData                      :=  ClientReceivedStaticData;
  ReceiveInvalidPassword                  :=  ClientReceiveInvalidPassword;
  ReceiveModifiedPacket                   :=  ClientReceiveModifiedPacket;
  ReceiveVoicePacket                      :=  ClientReceiveVoicePacket;
  ReceivePong                             :=  ClientReceivePong;
  ReceiveAdvertisedSystem                 :=  ClientReceiveAdvertisedSystem;
  ProcessUnhandledPacket                  :=  ClientProcessUnhandledPacket;
  end;
end;

procedure TData_net.DataModuleDestroy(Sender: TObject);
begin
   
        if ClientServerInited then
       UnInitializateClientServer;

      sleep(10);

     if LibLoaded then
    UnInitRaknetC;
end;

procedure TData_net.DataModuleCreate(Sender: TObject);
var i: integer;
begin
{
   self.LibLoaded := InitRaknetC;
   my_s_id_G:= g_nil_user_c;
   setlength(user_info_time,200); //����200��id
   for i:= 0 to 199 do
      user_info_time[i].s_id:= g_nil_user_c; //��ʼ��s id

   setlength(dwjh_g,10); //��ʼ��10��С�ӣ���������
   }
end;

procedure TData_net.send_scene_integer(id, v: integer);  //���ͳ���integerֵ
var pk: Tmsg_cmd_pk;
begin
   pk.hander:= byte_to_integer(g_scene_chg_i_c,false);
      pk.pak.s_id:= my_s_id_g;
      pk.pak.data1:= id;
      pk.pak.data2:= v;
      g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //�����������
end;

procedure TData_net.send_scene_bool(id, v: integer);
var pk: Tmsg_cmd_pk;
begin
   pk.hander:= byte_to_integer(g_scene_chg_b_c,false);
      pk.pak.s_id:= my_s_id_g;
      pk.pak.data1:= id;
      pk.pak.data2:= v;
      g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //����������� ��������

end;

procedure TData_net.send_page_and_home_id(i, h,old: integer; ldui: boolean);
var pk: Tmsg_cmd_pk;
    pk2: Tmsg_duiwu_cmd_pk;
begin
   if ldui then //���ģʽ������ӱ�־��ת������Ա
   begin
    pk2.hander:= byte_to_integer(g_rep_dw_W_page_c,false); //��ҳ��������ת��
    pk2.duiyuan[0]:= game_player_head_G.duiyuan[0];
     pk2.duiyuan[1]:= game_player_head_G.duiyuan[1];
     pk2.duiyuan[2]:= game_player_head_G.duiyuan[2];
     pk2.duiyuan[3]:= game_player_head_G.duiyuan[3];
    pk2.pak.s_id:= my_s_id_g;
    pk2.pak.cmd:= old;
    pk2.pak.data1:= i;
    pk2.pak.data2:= h;
    g_send_msg_cmd(@pk2,sizeof(Tmsg_duiwu_cmd_pk)); //����������� ��ǰҳ�ͻس�ҳ
   end
   else begin
    pk.hander:= byte_to_integer(g_page_chg_c,false);
      pk.pak.s_id:= my_s_id_g;
      pk.pak.cmd:= old;
      pk.pak.data1:= i;
      pk.pak.data2:= h;
        g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //����������� ��ǰҳ�ͻس�ҳ
        end;

      

end;

procedure TData_net.reshow_net_id(id, flag,p: integer);
var i: integer;
begin
//flag Ϊ1����ʾ��id���뵱ǰҳ�棬���򣬱�ʾ��id�뿪�����ҳ��

   for i:= 0 to high(user_info_time) do
    begin
     if user_info_time[i].s_id= id then
       begin
         if flag= 1 then
            user_info_time[i].page:= p
            else
               user_info_time[i].page:= 0;
         break;
       end;
    end;
    //ˢ����ʾ
    
    Form1.game_reshow_net_id(false);

end;

procedure TData_net.reshow_net_id_all(c: integer; p: pointer;show: boolean= true);
 var i,j,k,L: integer;
    label pp;
begin
   //ˢ��ȫ����id�ڵ�ǰҳ����ʾ
   pp:
    for i:= 1 to c div 2 do
     begin
       for j:= 0 to high(user_info_time) do
        begin
         if word(p^)= my_s_id_G then
            continue;

          if user_info_time[j].s_id= word(p^) then
            begin
             user_info_time[j].page:= form1.pscene_id;
             break;
            end;
          if j= high(user_info_time) then
           begin   //��ʾû���������ʵ�λ�ã�����ҿ�λ
             for k:= 0 to high(user_info_time) do
               begin
                 if user_info_time[k].s_id= g_nil_user_c then
                  begin
                     user_info_time[k].s_id:= word(p^);
                    user_info_time[k].page:= form1.pscene_id;
                     break;
                  end;
                 if k= high(user_info_time) then
                  begin  //û�п�λ
                    setlength(user_info_time,high(user_info_time)+ 101); //�Ӵ�ռ�
                     for l:= high(user_info_time) downto high(user_info_time)-99 do
                          user_info_time[l].s_id:= g_nil_user_c; //��ʼ��
                    goto pp;
                  end;
               end; // for k
           end;
        end; //for j
       dword(p):= dword(p)+ 2;
     end;  // for i

     if show then
        form1.game_reshow_net_id(false);

end;

procedure TData_net.game_page_online_data(p: pointer; c: integer);
var i,j: integer;
   // t: cardinal;
begin
   //�յ������������������û���ϸ����
 //  t:= GetTickCount;
   for i:= 1 to c div sizeof(Tnet_user_id_exchg) do
    begin
      for j:= 0 to high(user_info_time) do
       begin
        if user_info_time[j].s_id= Tnet_user_id_exchg(p^).Id then
         begin

           with user_info_time[j] do
            begin
            u_id:= Tnet_user_id_exchg(p^).u_id;
            nicheng:= Tnet_user_id_exchg(p^).nicheng;
            dengji:=  Tnet_user_id_exchg(p^).dengji;
            xiaodui:= Tnet_user_id_exchg(p^).duiwuid;
            xiaodui_dg:=Tnet_user_id_exchg(p^).duiwudg;
            zhuzhi:=  Tnet_user_id_exchg(p^).zhuzhiid;
            zhuzhi_dg:=Tnet_user_id_exchg(p^).zhuzhidg;
            guojia:= Tnet_user_id_exchg(p^).guojiaid;
            guojia_dg:= Tnet_user_id_exchg(p^).guojiadg;
            time:= GetTickCount;
            end;

           break;
         end;
       end; //end for j
       dword(p):= dword(p) + sizeof(Tnet_user_id_exchg); //ָ������
    end;

   Form1.game_reshow_net_id(false); //ˢ����ʾ

end;

procedure TData_net.game_dwjh_data(p: pointer; c: integer);
var i: integer;
    label pp;
begin
   pp:
    for i:= 0 to high(dwjh_g) do
     begin
       if dwjh_g[i].dwid= 0 then
        begin
         with dwjh_g[i] do
          begin
          dwid:= Tdwjh_type(p^).dwid;
          p_id:= Tdwjh_type(p^).p_id;
          p_name:= Tdwjh_type(p^).p_name;
          p_rk:= Tdwjh_type(p^).p_rk;
          p_sl:= Tdwjh_type(p^).p_sl;
          p_ms:= Tdwjh_type(p^).p_ms;
          end;
          game_wait_integer_g:= 1;
          break;
        end;
       if i= high(dwjh_g) then
        begin
         setlength(dwjh_g,high(dwjh_g) + 11);
         goto pp;
        end;
     end; //end for

     Game_wait_ok1_g:= true; //
end;

function TData_net.get_s_id_nicheng(sid: integer): string; //��ȡָ��������ǳ�
var i,j: integer;
    w: array[0..2] of word;
begin
      for i:= 0 to high(user_info_time) do
       begin
         if user_info_time[i].s_id= sid then
          begin
           if user_info_time[i].nicheng= '' then
            result:= '{'+ inttostr(sid)+ '}'
           else
            result:= user_info_time[i].nicheng;
            exit;
          end;
         if i= high(user_info_time) then
          begin
           for j:= 0 to high(user_info_time) do
               if user_info_time[j].s_id= g_nil_user_c then
                 begin
                  user_info_time[j].s_id:= sid;
                  break;
                 end;

           pinteger(@w)^:= byte_to_integer(g_rep_online_page_data_c,false);
           w[2]:= sid;
           g_send_msg_cmd(@w,6);  //�������󣬻�ȡ��sid����ϸ����
            result:= '{'+ inttostr(sid)+ '}';
          end;
       end; //end for
end;

procedure TData_net.add_s_id_in_list(sid: integer);   //��Ӷ�Ա��ʵ���������б�
var i,j: integer;
    pk: Tmsg_cmd_pk;
begin
   get_or_add_user_id_time_type(sid);

    for i:= 0 to 3 do
     if game_player_head_G.duiyuan[i]= sid then
        exit;

   for i:= 0 to 3 do
     if game_player_head_G.duiyuan[i]= g_nil_user_c then
       begin
        game_player_head_G.duiyuan[i]:= sid;
         //���ʵ��
         for j:= 0 to Game_role_list.Count-1 do
             begin
              if Assigned(Game_role_list.Items[j]) then
               begin
                if Tplayer(Game_role_list.Items[j]).plvalues[34]= sid then
                   exit;  //���ʵ���Ѿ����ڣ��˳�

               end;
             end; //end for j
         pk.hander:= byte_to_integer(g_player_rq_c,false);
         pk.pak.s_id:= sid;
         g_send_msg_cmd(@pk,sizeof(pk)); //�����������
        exit;
       end;

end;

procedure TData_net.del_s_id_in_list(sid: integer);
var i: integer;
begin
    //ɾ����Ա�Ӹ����Ա�б�
    for i:= 0 to 3 do
     if game_player_head_G.duiyuan[i]= sid then
        game_player_head_G.duiyuan[i]:= g_nil_user_c;

    //������ʵ���б� ���
       for i:= 1 to Game_role_list.Count-1 do
             begin
              if Assigned(Game_role_list.Items[i]) then
               begin
                if Tplayer(Game_role_list.Items[i]).plvalues[34]= sid then
                   begin
                   Tplayer(Game_role_list.Items[i]).Free;
                   Game_role_list.Delete(i);
                   exit;
                   end;
               end;
             end; //end for i
end;

procedure TData_net.nil_s_id_from_list_g(sid: integer);
var i: integer;
begin
    //��ȫ�������б��ÿ�һ��sid
    for i:= 0 to high(user_info_time) do
     begin
       if user_info_time[i].s_id= sid then
          begin
           user_info_time[i].s_id:= g_nil_user_c;
           user_info_time[i].nicheng:= '';
           user_info_time[i].u_id:= '��';
           user_info_time[i].page:= 0;
           user_info_time[i].player_id.addr:= 0;
          end;
     end; //end for
end;

procedure TData_net.send_player_Fvalues(i, v_old, V_new: integer);
begin
     //��������䶯���ݵ�������
     
    send_pak_tt(g_persona_chg_c,i,v_old,V_new,my_s_id_g);

end;

procedure TData_net.send_dwjh_pop(flag, shu, guai: integer);
var pk: Tmsg_duiwu_cmd_zf_pk;
    p2: p_user_id_time;
    i: integer;
    b: boolean;
begin
      {//�ӳ�������ָ����������ʻ��ߴ�ִ���
      //flag 1�����ʣ�2������Ч���ı����ʴ��ڣ�3��֣�4������Ч���Ĵ�֣�5�������͵Ĵ�֣�6�ڿ�7��ҩ
      data1��ʾshu��shu���Ǳ����ʵ��������߹��������
      data2��ʾ�������ͣ�һ�����±�ʾ���ع֣�һ�����ϣ������߶���һ��sid��������������һ��С��id
      }

      if game_player_head_G.duiwu_dg< 100 then
         exit;  //���Ƕӳ����˳�

    b:= false; //����Ƿ��ж�Ա

    pk.hander:= byte_to_integer(g_rep_dw_c,false); //�ϳ��ļ�ͷ
      //�����Աsid����
      for i:= 0 to 3 do
      pk.duiyuan[i]:= g_nil_user_c;  //��ʼ��

      for i:= 0 to 3 do
      begin
      p2:= get_user_id_time_type(game_player_head_G.duiyuan[i]); //ȡ��һ��ָ��
      if p2<> nil then
       begin
         if p2.xiaodui= game_player_head_G.duiwu_id then
            if (p2.xiaodui_dg= 1) or ((p2.xiaodui_dg=2) and (flag>2)) then //�������ȫ���棬��ôֱ�ӷ�����ָ�����Ѵ�ָ��棬��ôֻ��ս��ָ��
              begin
              pk.duiyuan[i]:= p2.s_id;
              b:= true;
              end;
       end;
     end; //end for

     if b= false then
       exit;  //���û�ж�Ա��Ҫ֪ͨ���˳�

    pk.hander2:= byte_to_integer(g_rec_cmd_c,false);
      //����cmd����
      case flag of
      1: pk.pak.cmd:= g_cmd_pop;
      2: pk.pak.cmd:= g_cmd_pop_a;
      3: pk.pak.cmd:= g_cmd_pop_pk;
      4: pk.pak.cmd:= g_cmd_pop_pk_a;
      5: pk.pak.cmd:= g_cmd_pop_game;
      6: pk.pak.cmd:= g_cmd_pop_wak;  //�ڿ�
      7: pk.pak.cmd:= g_cmd_pop_caiyao;   //��ҩ
      end;

      //�ϳ�����
      pk.pak.data1:= shu;
      pk.pak.data2:= guai;
      pk.pak.s_id:= my_s_id_g;

     g_send_msg_cmd(@pk,sizeof(Tmsg_duiwu_cmd_zf_pk)); //�����������
end;

procedure TData_net.send_game_cmd(js_sid: word;    //���ܷ����ܹ�������sid
                                  fq_m: integer;
                                  fq_t: integer;   //�����飬���𷽴��͵�����ֵ
                                  fq_l: integer;
                                  js_m: integer;   //���ܷ����͵��ǲ�ֵ
                                  js_t: integer;
                                  js_l: integer;
                                  flag: word;    //���ͣ�ָ����0�޶�����1����������2����������3��Ʒ������4��Ʒ�ָ���5�����ָ���6,��7��
                                  wu: word);
var pk_ben: Tgame_cmd_dh_pk_ben_xd;
    pk_shuang: Tgame_cmd_dh_pk_shuang_xd;
    i,k: integer;
begin
     {��֣���������Ʒ����Ԯ��ָ��
     ***********�ҷ����ݱ���������������߻ָ��ȶ����󣬷�����ָ�����С���Լ��з�С�ӡ�*******
     �öԷ��������ݣ�����������
     �������� flag��0�޶�����1����������2����������3��Ʒ������4��Ʒ�ָ���5�����ָ���6,��7��
     wu����Ʒ������ţ�������ʱΪ��
     guai�����ܷ����

     ���͵Ĳ���   pk_zhihui_g
     �ҷ��䶯��ֵ����������ֵ

     T_is_pk_z= record
    is_pk: boolean;   //�Ƿ�pk״̬
    is_zhihui: boolean;     //�Ƿ�����ָ��״̬
    game_zt: integer;   //0����״̬��1�������ʣ�2�ڿ�3��ҩ��4��������5������6ս��

     pk_zhihui_g
     }

     //��������Ȩ
     pk_zhihui_g.is_kongzhi:= false;

     k:= 0;  //ͳ��˫��������
     if pk_zhihui_g.is_pk then
      begin
       for i:= 0 to 4 do
        if net_guai_g[i].sid<> g_nil_user_c then
           inc(k);
      end;

      for i:= 0 to 3 do
        if game_player_head_G.duiyuan[i] <> g_nil_user_c then
           inc(k);

     if k <= 4 then
      begin  //ת����4����
       pk_ben.hd:= byte_to_integer(g_rep_dw_c,false);
       k:= 0;
         if pk_zhihui_g.is_pk then
            begin
             for i:= 0 to 4 do
              if net_guai_g[i].sid<> g_nil_user_c then
                 begin
                  if k < 4 then
                  pk_ben.duiyuan[k]:= net_guai_g[i].sid;
                  inc(k);
                 end;
            end;
             for i:= 0 to 3 do
                if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                  begin
                   if k < 4 then
                   pk_ben.duiyuan[k]:= game_player_head_G.duiyuan[i];
                   inc(k);
                  end;
        pk_ben.hd2:= byte_to_integer(g_rec_role_act_c,false);
        pk_ben.pk.fq_sid:= my_s_id_g;
        pk_ben.pk.js_sid:= js_sid;
        pk_ben.pk.fq_m  := fq_m;
        pk_ben.pk.fq_t  := fq_t;
        pk_ben.pk.fq_l  := fq_l;
        pk_ben.pk.js_m  := js_m;
        pk_ben.pk.js_t  := js_t;
        pk_ben.pk.js_l  := js_l;
        pk_ben.pk.flag  := flag;
        pk_ben.pk.wu    := wu;
        g_send_msg_cmd(@pk_ben,sizeof(Tgame_cmd_dh_pk_ben_xd)); //�����������
      end else begin  //ת��������4����
                  pk_shuang.hd:= byte_to_integer(g_dwjh_zf9_c,false);
                  k:= 0;
                   if pk_zhihui_g.is_pk then
                    begin
                     for i:= 0 to 4 do
                      if net_guai_g[i].sid<> g_nil_user_c then
                         begin
                          if k < 9 then
                          pk_shuang.duiyuan[k]:= net_guai_g[i].sid;
                          inc(k);
                         end;
                    end;
                    for i:= 0 to 3 do
                     if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                      begin
                      if k < 9 then
                       pk_shuang.duiyuan[k]:= game_player_head_G.duiyuan[i];
                      inc(k);
                      end;

                  pk_shuang.hd2:= byte_to_integer(g_rec_role_act_c,false);

                  pk_shuang.pk.fq_sid:= my_s_id_g;
                  pk_shuang.pk.js_sid:= js_sid;
                  pk_shuang.pk.fq_m  := fq_m;
                  pk_shuang.pk.fq_t  := fq_t;
                  pk_shuang.pk.fq_l  := fq_l;
                  pk_shuang.pk.js_m  := js_m;
                  pk_shuang.pk.js_t  := js_t;
                  pk_shuang.pk.js_l  := js_l;
                  pk_shuang.pk.flag  := flag;
                  pk_shuang.pk.wu    := wu;
                  g_send_msg_cmd(@pk_shuang,sizeof(Tgame_cmd_dh_pk_shuang_xd)); //�����������
               end;
end;

procedure TData_net.send_game_kongzhi(c, d1, d2: integer; sid: word); //���Ϳ���Ȩ����
var pk_ben: Tmsg_duiwu_cmd_zf_pk;
    pk_shuang: Tmsg_duiwu_cmd_zf9_pk;
    i,k: integer;
begin
     {���Ϳ�������
     data1��
     data2��

     T_is_pk_z= record
    is_pk: boolean;   //�Ƿ�pk״̬
    is_zhihui: boolean;     //�Ƿ�����ָ��״̬
    game_zt: integer;   //0����״̬��1�������ʣ�2�ڿ�3��ҩ��4��������5������6ս��

     pk_zhihui_g
     }


     k:= 0;  //ͳ��˫��������
     if pk_zhihui_g.is_pk then
      begin
       for i:= 0 to 4 do
        if net_guai_g[i].sid<> g_nil_user_c then
           inc(k);
      end;

      for i:= 0 to 3 do
        if game_player_head_G.duiyuan[i] <> g_nil_user_c then
           inc(k);

     if k <= 4 then
      begin  //ת����4����
       pk_ben.hander:= byte_to_integer(g_rep_dw_c,false);
       k:= 0;
         if pk_zhihui_g.is_pk then
            begin
             for i:= 0 to 4 do
              if net_guai_g[i].sid<> g_nil_user_c then
                 begin
                  if k < 4 then
                  pk_ben.duiyuan[k]:= net_guai_g[i].sid;
                  inc(k);
                 end;
            end;
             for i:= 0 to 3 do
                if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                  begin
                   if k < 4 then
                   pk_ben.duiyuan[k]:= game_player_head_G.duiyuan[i];
                   inc(k);
                  end;
        pk_ben.hander2:= byte_to_integer(g_rec_kongzhi_c,false);
        pk_ben.pak.cmd:= c;
        pk_ben.pak.data1:= d1;
        pk_ben.pak.data2  := d2;
        pk_ben.pak.s_id  := sid;

        g_send_msg_cmd(@pk_ben,sizeof(Tmsg_duiwu_cmd_zf_pk)); //�����������
      end else begin  //ת��������4����
                  pk_shuang.hander:= byte_to_integer(g_dwjh_zf9_c,false);
                  k:= 0;
                   if pk_zhihui_g.is_pk then
                    begin
                     for i:= 0 to 4 do
                      if net_guai_g[i].sid<> g_nil_user_c then
                         begin
                          if k < 9 then
                          pk_shuang.duiyuan[k]:= net_guai_g[i].sid;
                          inc(k);
                         end;
                    end;
                    for i:= 0 to 3 do
                     if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                      begin
                      if k < 9 then
                       pk_shuang.duiyuan[k]:= game_player_head_G.duiyuan[i];
                      inc(k);
                      end;

                  pk_shuang.hander2:= byte_to_integer(g_rec_kongzhi_c,false);

                  pk_shuang.pak.cmd:= c;
                  pk_shuang.pak.data1:= d1;
                  pk_shuang.pak.data2  := d2;
                  pk_shuang.pak.s_id  := sid;

                  g_send_msg_cmd(@pk_shuang,sizeof(Tmsg_duiwu_cmd_zf9_pk)); //�����������
               end;

end;

end.

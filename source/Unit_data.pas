unit Unit_data;

interface

uses
  SysUtils, Classes,IniFiles, ImgList, Controls,windows,Unit_net,unit_player,unit_glb,
  ShellCtrls,System.Zip, System.ImageList,System.Hash,VCLUnZip,VCLZip;


//function QueryPerformanceCounter(var lpPerformanceCount: int64): BOOLean; stdcall;
const
  game_const_star_war= $0400 + 31671;
  game_const_script_after= $0400 + 31672;
 zb_td1= 1;
 zb_sc1= 2;
 zb_pf1= 3;
 zb_jc1= 4;
 zb_hw1= 5;
 zb_jz1= 6;
 zb_xl1= 7;
 zb_wq1= 8;
 zb_yg1= 9;
   game_m_quan_qi= 999999999; //����������ȫ��
   game_m_ban_qi = 99999999;  //��������������
   game_m_quan   = 9999999;  //��������ȫ��
   game_m_ban    = 999999;   //������������

 Download_try_count= 7;  //���ز��ɹ����Դ���
 refresh_time_C= 600000;  //ˢ�������û���Ϣ���ʱ��
 banben_const= '1'; //�ͻ��˰汾��
 
type
    Tbg_music_rc=packed record
     bg_img: boolean;   //����ͼ���ã�ֵΪ 1����ʾ����
     bg_tm: integer;    //����ͼ͸����
     bg_music: boolean;    //������������
     bg_yl: integer;     //������������
     bg_lrc: boolean;    // ;�����������
     mg_pop: boolean;    // ;�Թ�����ʽ�����ʴ�������
     pop_img: boolean;   // ;��ҳʽ�����ʴ��ڱ���ͼ����
     pop_img_tm: integer; //;��ҳʽ�����ʴ��ڱ���ͼ͸����
     bg_img_radm: boolean;  //   ;����ͼ�����ʾ
     bg_music_radm: boolean; //   ;���������������
     bg_img_index: integer;    //����ͼ�����
     bg_music_index: integer; //�����������
     bg_music_base: boolean; //�����ص���----��Ϊ����Ч��
     lrc_dir: string[255];
     sch_enable: boolean;   // ;ͼƬ��������
     sch_MAX: integer;      //  ;ͼƬ�����������ֵ��һ2048
     sch_count1: integer;     //ͼƬ��������
     sch_key: string[64];  // ;ͼƬ�����ؼ���
     sch_pic: string[255];  //  ;ͼƬ����
     gum_path: string[255];     // ;gum���ص�ַ
     gum_only: boolean;   //������gum�����ļ��У��ʺ����߰汾
     sch_img_sty: integer; //�������ص�ͼƬ��ʾ��ʽ
     sch_img_height: integer; //ͼƬ�߶�
     not_tiankong: boolean;    // ;��ֹ���ʽѡ��
     type_word: boolean; //;���ü������뱳����
     type_word_flash: boolean;  //������˸
      type_char_spk: boolean;   //��ĸ����
      temp_mg_pop: boolean; //��ʱ�Թ���������
      desktop_word: boolean; //�Ƿ��������汳����
      show_ad_web: boolean; //�����ʾ��web��
      yodao_sound: boolean;  //�Ƿ������е����׵����ʶ�
      number_count: integer; //�����ѱ���������������
      down_readfile: boolean; //���������Ķ�����
      en_type_name: string[32];
      cn_type_name: string[32];
      baidu_vol: integer;
      baidu_sex: integer;
      baidu_spd: integer; //���٣�0-9 Ĭ��5
      baidu_pit: integer; //����
     end;

  //����,���ͣ������壬�飬�٣����������ǣ��ˣ��;ã��۸�����
  Tgame_goods_type=(goods_name1,goods_type1,goods_f1,goods_t1,goods_L1,goods_s1,
                    goods_m1,goods_g1,goods_z1,goods_y1,goods_n1,goods_j1,goods_ms1);
  Tgame_s_type=(G_nil,G_action,G_description,G_chat);

  TData2 = class(TDataModule)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList_sml: TImageList;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  //  procedure IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  //    ABinding: TIdSocketHandle);
    procedure ShellChangeNotifier1Change;
  private
    { Private declarations }

    function read_game_scene(source,dest: Tstringlist):boolean;//��������
    function explain_scene_html(const s: string): string; //�Գ����ڵ�html�ļ����н���
    procedure explain_scene_html_base(var s: string);
    procedure Load_file_ini(const n: string; st1: Tstringlist);
    function get_checkout: integer; //��ȡ��ƷУ����
    procedure chat_if_then(st1: Tstringlist); //�Ի��ڵ�if then ����
    function get_bg_img_filename(s: string): string; //ȡ���Զ��屳��ͼƬ��
     
  public
    { Public declarations }
    game_memini1: TMemIniFile;  //��Ʒ�б�
    game_memini_event: TMemIniFile; //�¼��б�
    procedure load_scene(id: string; St1: Tstringlist);//���볡���ļ�
    procedure Load_file_upp(const n: string; st1: Tstringlist); //������������ļ�
    procedure save_file_upp(const n: string; st1: Tstringlist); //������������ļ�
    procedure save_file_event(const n: string);
    procedure load_goods_file; //������Ʒ�����ļ�
    function get_game_goods_type(i: integer; tp: Tgame_goods_type): integer; //��ȡһ��ָ����ŵ���Ʒ����
    function get_game_goods_type_s(const s: string; tp: Tgame_goods_type): string; //���ַ����ڲ������
    function rep_game_goods_type_s(const s: string; tp: Tgame_goods_type; sub: string): string; //�滻ָ��������
    function get_game_goods_type_a(i: integer): string; //����ֵ�����ȫ������
    procedure get_game_goods_type_a_base(var ss: string);
    function get_game_fa(i2: integer): string; //���ָ����������
    function get_game_ji(i2: integer): string; //���ָ����������
    procedure load_event_file(n: string); //�����¼��ļ�,��Ĭ��ֵ��
    procedure Load_file_event(const n: string; st1: Tstringlist); //�����¼��ļ� base
    function get_goods_all_s(i: integer): string; //������Ʒ�������ȡ��Ʒ�������ַ���
    

    procedure game_save_goods; //������Ʒ
    procedure game_load_goods;

    procedure game_show_task_complete(t: tstrings); //��ʾ����ɵ�����
    procedure game_show_task_uncomplete(t: tstrings); //��ʾû����ɵ�����
    procedure game_addto_complete(s: string); //���һ�����ݵ�����ɵģ�ͬʱɾ����δ���
    procedure game_addto_uncomplete(s: string); //���һ�����ݵ�δ��ɵ�
    procedure game_load_task_file; //���������б�
    procedure game_save_task_file; //���������б�
    function game_get_task_s(id: string): string; //ȡ��task�����ڵ�һ������
    procedure clean_if_then(var s: string); //���ַ����ڵ�if then����Ԥ�жϣ����������ַ���
    procedure function_re_string(var s: string);
    function function_re_string2(s: string): string; //��string ���ͺ������д���
    procedure out_save(s: string; outfilename: string); //���������浵������Ϊ�ļ���·��,����Ϊ���ļ���
    procedure in_save(s: string; saveDir: string); //���뵥���浵������Ϊ�浵�ļ�����Ҫ�������Ϸ�浵Ŀ¼��
  end;

// function QueryPerformanceCounter; external 'kernel32.dll' name 'QueryPerformanceCounter';
 function ExecuteRoutine(AObj: TObject; AName: string;
    Params: array of const): integer;

 function Game_base_random(i: integer): integer;

 function get_L_16(i: integer): integer;  //�õ��������
 function get_H_8(i: integer): integer; //�õ������ȼ�
 function get_HL_8(i: integer): integer; //�õ�ʹ�ô������θ�8λ
 function set_L_16(i,v: integer): integer;  //д�뷨����ţ�����ֵΪ�ϳɺ��ֵ
 function set_H_8(i,v: integer): integer; //д�뷨���ȼ������10�� ������ֵΪ�ϳɺ��ֵ
          {1-3����20����һ����4-6����20����һ����6-9����60����һ��}
 function set_HL_8(i,v: integer): integer; //д��ʹ�ô������θ�8λ��������ֵΪ�ϳɺ��ֵ
 function game_add_shuliang_string(const s: string;k: integer): string;//������ǰ��������
 function strtoint2(const s: string): integer;
 function game_get_touxian(i: integer): string;
 function read_goods_number(id: integer): integer; //��ȡ����
 function write_goods_number(id: integer; nmb: integer): boolean; //д������
 function game_add_goods_from_net(p: pointer; c: integer): integer; //�����Ϸ��Ʒ����
 function get_list_str(t: Tstringlist; i: integer): string; //��tliststring���м��
 function get_down_img_url: string; //�ϳ�������
 function get_second: int64;  //����1899������������

var
  Data2: TData2;
  game_player_head_G: Tplayer_head; //�Լ�������ͷ����
  Game_goods_G2: array[0..1023] of byte;          //��Ʒ
  game_app_path_G: string; //����·��
  game_doc_path_g: string; //�ҵ��ĵ��ļ���
  Game_goods_net_G: array[0..1023] of word; //�����������Ʒ
  Game_goods_Index_G: array[0..1023] of word;   //��Ʒͼ������
  Game_chat_name_G,Game_g_name_G: string; //��ǰ�Ի��������������ص���Ʒ��
  Game_save_path: string; //��Ϸ�ı���·��
  Game_chat_index_G,Game_chat_id_G: integer; //������������ǰ�Ի����ڼ�����
  Game_not_save: boolean;
  Game_scene_author: string;  //��������
  Game_task_comp1,Game_task_uncomp1,game_message_txt: Tstringlist;
  Game_scene_type_G: integer; //ȫ�ֳ������Ա��� 1,��ͨ��2�Թ���4�������ʱ��8����������Ի�������
  Game_is_only_show_G: boolean; //�Ƿ����ʾָ������ñ�����Ӱ�쵽goods���ڵ�checkbox
  Game_script_scene_after,Game_script_scene_G: string; //���볡�������д˴���
  Game_is_reload: boolean; //�ظ�����ʱ�Ƿ���Լ���ǰ��Ľű�ִ��
  Game_can_talk_G: boolean;
  Game_guai_list_G,Game_touxian_list_G: Tstringlist;
  Game_scene_id_string: string; //��ȡ����idΪ�ַ����ĺ�����ʹ��
  Game_inttostr_string_G: string;
  Game_datetime_G,Game_pstringw: string; //ʱ��������ʹ��,�ļ�id
  Game_time_exe_array_G: array[0..511] of word; //��ʱִ�к������������
  Game_cannot_runOff: boolean; //��ֹ����
  Game_migong_xishu: integer; //�Թ��ڹ��﹥����ϵ��
  Game_not_gohome_G: boolean; //�Ƿ�����س�
  Game_ad_count_G: tpoint;
  game_shunxu_g,game_abhs_g: boolean;
  Game_wakuan_zhengque_shu: integer; //ÿ���ڿ���ȷ������
  Game_at_net_G: boolean; //��Ϸ��������״̬
  Game_loading: boolean; //�������������
  Game_pchar_string_G: string; //����pchar�ķ���ֵ
  Game_app_img_path_G,Game_app_img_url_G: string; //��ϷͼƬ·������ϷͼƬ����·��
  Game_error_count_G: integer; //���ش�������������ֵ����100����ʾ��ֹ��ͼƬ
  Game_update_url_G,Game_update_file_G: string;
  Game_show_error_image_G: boolean; //�Ƿ���ʾ����ͼƬ������ʾ�ȴ�ͼƬ
  Game_net_hide_g: boolean; //��ֹ���繦��
  Game_server_addr_g: string; //������ip��ַ
  Game_wait_ok1_g: boolean; //�ȴ���һ�����Է�������ok�ź�
  game_wait_integer_g: integer; //�ȴ���������
  Game_wait_ok2_g: boolean; //�ȴ���һ�����Է�������ok�ź�
  game_wait_integer2_g: integer; //�ȴ���������
  game_auto_temp_g: integer; //��write����tempʱ�Զ����ý�����ʱ�����
  game_debug_handle_g: thandle; //��Ϸ�ű�����
  game_exit_cmd_str_g: string;   //�˳��������
  game_chat_cache_g: string; //���컺��
  game_reload_chat_g: boolean; //�Ƿ�����������¼
  game_NoRevealTrans_g: boolean; //��ֹ�����л���ת��Ч��
  game_page_from_net_g: boolean; //���������ҳ���л�
  game_bg_music_rc_g: Tbg_music_rc; //����ͼƬ������ѡ��
  bg_img_filelist_g,bg_music_filelist_g: Tstringlist;
  game_html_pop_str_g: string; //htmlģʽ��pop���ں������� 36
  temp_pic_file_g: string; //��ʱ���ص�ͼƬ�ļ�
  ugm_down_count_g: integer; //�ۼƵ�����ʧ�ܵĴ���
  not_show_img_tip_g: boolean;   //����ʾ����ͼƬʱ����ʾ����
  re_show_img_tmp_g: string; //����ʱ�Ļ���
  temp_sch_key_g: string; //��ʱ�����ؼ���
//  yodao_udp_g,yodao_tcp_g,yodao_udp_host: string;
  read_text_index_g: integer;
  part_size_g: array of integer; //ÿ��ѭ�����еĵ�����
  game_guid: string;
  ZipHeader1: TZipHeader;
implementation
   uses unit1,unit_downhttp,forms,Unit_mp3_yodao,unit_show,unit_pop;
{$R *.dfm}

function get_second: int64;

var SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  //����1899������������ )��hourof(now)��minuteof(now) ��secondof(now)
  result:= trunc(now) * 86400;

  result:= result+ SystemTime.wHour * 3600+ SystemTime.wMinute * 60 + SystemTime.wSecond;

end;

function get_list_str(t: Tstringlist; i: integer): string; //��tliststring���м��
begin
  
  if (t.Count= 0) or (i<0) or (i>= t.Count) then
   begin
    result:= '1';
   end else
     result:= t.Strings[i];

end;

function game_add_goods_from_net(p: pointer; c: integer): integer; //�����Ϸ��Ʒ����
var i: integer;
begin
   for i:= 1 to 1012 do
    begin
     case (i-1) mod 4 of
     0: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[0] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[0] xor 211;
      end;
      1: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[1] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[1] xor 211;
         end;
     2: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[2] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[2] xor 211;
         end;
     3: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[3] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[3] xor 211;
        end;
      end;
    end;
   result:= 1;
end;

function read_goods_number(id: integer): integer; //��ȡ����
var b1,b2: byte;
begin
 if (id> 1023) or (id < 1) then
    result:= 0
    else begin
  if Game_at_net_G then
   begin
   b1:= WordRec(Game_goods_net_G[id]).Hi xor 135;
   b2:= WordRec(Game_goods_net_G[id]).lo xor 211;
    if b1 < b2 then
       result:= b1
       else result:= b2;
   end else result:= Game_goods_G2[id];

         end;
end;

function write_goods_number(id: integer; nmb: integer): boolean; //д������
var b1,b2: byte;
begin
 if (id> 1023) or (id < 1) then
    result:= false
    else begin
  if Game_at_net_G then
   begin
   b1:= WordRec(Game_goods_net_G[id]).Hi xor 135;
   b2:= WordRec(Game_goods_net_G[id]).lo xor 211;
    if b1 > b2 then
        b1:= b2
         else b2:= b1; //ʹ��������������ֵ������Ϊ��ֹ�����������޸ģ�b2��ֵ������¼ԭֵ

    if nmb<> 0 then
      nmb:= nmb + b1;

    if nmb> 255 then
       b1:= 255
       else if nmb < 0 then
             b1:= 0
              else b1:= nmb;
      WordRec(Game_goods_net_G[id]).Hi:= b1 xor 135;
      WordRec(Game_goods_net_G[id]).lo:= b1 xor 211;

      //�������������Ʒ�����޸���Ϣ��data1��ʾ��Ʒid������Ʒԭ������,data2��ʾ�µ�����

      my_send_cmd_pak_g.hander:= byte_to_integer(g_change_wupin_C,false); //����ͷ��Ϣ
        id:= id shl 16 + b2;
      my_send_cmd_pak_g.pak.data1:= id;
      my_send_cmd_pak_g.pak.data2:= b1;  //������
      my_send_cmd_pak_g.pak.s_id:= my_s_id_G;
      g_send_msg_cmd(@my_send_cmd_pak_g,sizeof(my_send_cmd_pak_g));
    result:= true;
   end else begin
              if nmb= 0 then
                 Game_goods_G2[id]:= 0 //�������Ϊ�㣬�������
                else
                 nmb:= nmb + Game_goods_G2[id];
              if nmb > 255 then
                 Game_goods_G2[id]:= 255
                 else if nmb < 0 then
                       Game_goods_G2[id]:= 0
                        else
                         Game_goods_G2[id]:= nmb;

             result:= true;
            end;

         end;

end;

function game_get_touxian(i: integer): string;  //ȡ��ͷ��
begin
  if (i >= Game_touxian_list_G.Count) or (i < 0) then
    result:= ''
    else
     result:= Game_touxian_list_G.Strings[i];
end;

function strtoint2(const s: string): integer;
begin
  if not TryStrToInt(s,result) then
     result:= 0;
end;
function game_add_shuliang_string(const s: string;k: integer): string;
begin
         result:= s;
         insert('������'+ inttostr(k)+ ',',result,fastcharpos(s,',',1)+1);
end;
function get_L_16(i: integer): integer;  //�õ��������
asm
shl eax, 16
shr eax, 16
end;

function get_H_8(i: integer): integer; //�õ������ȼ�
asm
shr eax, 24

end;

function get_HL_8(i: integer): integer; //�õ�ʹ�ô������θ�8λ
asm
shr eax, 16
xor ah,ah
end;

function set_L_16(i,v: integer): integer;  //д�뷨�����
asm
mov ax,dx
end;

function set_H_8(i,v: integer): integer; //д�뷨���ȼ�
asm
mov cx,ax  //����
shr eax,16
mov ah,dl
shl eax,16
mov ax,cx

end;

function set_HL_8(i,v: integer): integer; //д��ʹ�ô������θ�8λ
asm
mov cx,ax  //����
shr eax,16
mov al,dl
shl eax,16
mov ax,cx
end;

function Game_base_random(i: integer): integer;  //�������
var int1:int64;
     i32: dword;
begin
    if i= 0 then i:= 1;
 //������Ҳ�����ʱ����֮���΢���ϵ����������ȡ�����
  QueryperformanceCounter(int1);
    i32:= Int64Rec(int1).lo;
    i32:= i32 shl 16;
    i32:= i32 shr 16;
   result:= integer(i32 mod i);
   result:= (result + Random(i)) mod i;

end;
function ExecuteRoutine(AObj: TObject; AName: string;
    Params: array of const): integer;
  const
    RecSize = SizeOf(TVarRec); // ѭ����������б�ʱ�������ֽ���
  var
    PFunc: Pointer;
    ParCount: integer;
  begin
    if not Assigned(AObj) then
      raise Exception.Create ('�����������');
    PFunc := AObj.MethodAddress(AName); // ��ȡ������ַ
    if not Assigned(PFunc) then
      raise Exception.CreateFmt('�� %s �ڵĺ���: %s �����ڡ�', [AObj.ClassName,
        AName]);

      ParCount := High(Params) + 1;
    asm
      PUSH        ESI                 // ���� ESI�����Ǵ����Ҫ�õ���

      MOV         ESI, Params         // ESI ָ���������ַ
      CMP         ParCount, 1         // �жϲ�������
      JB          @NoParam
      JE          @OneParam
      CMP         ParCount, 2
      JE          @TwoParams

    @ManyParams: // ������������
      CLD                             // ��շ����־
      MOV         ECX, ParCount
      SUB         ECX, 2              // ѭ�� ParCount - 2 ��
      MOV         EDX, RecSize        // EDX ����ָ��ÿ����������ַ��ÿ�ε��� 8 Bytes
      ADD         EDX, RecSize        // ����ǰ��������
    @ParamLoop:
      MOV         EAX, [ESI][EDX]     // �û�ַ��ַѰַ��ʽȡ��һ������
      PUSH        EAX                 // ������ջ
      ADD         EDX, RecSize        // EDX ָ����һ��������ַ
      LOOP        @ParamLoop

    @TwoParams: // ��������
      MOV         ECX, [ESI] + RecSize

    @OneParam: // һ������
      MOV         EDX, [ESI]

    @NoParam:
      MOV         EAX, AObj           // ����ʵ����ַ���������ز��� Self��
      CALL        PFunc               // ���÷���
      MOV         Result, EAX         // ����ֵ���� Result

      POP         ESI                 // �ǵû�ԭ
    end;
  end;
{ TData2 }
function char_not_in_az(a: char): boolean;
  begin
    result:= not (a in['a'..'z','A'..'Z','0'..'9','_','\','"']);
  end;

procedure TData2.Load_file_ini(const n: string; st1: Tstringlist);
                     {������Ʒ����ini�ļ�}
var
  //  ss: string;
    i: integer;
begin

       st1.Clear;
       load_file_upp(n,st1);
     // st1.LoadFromFile(n);

                   {  ss:= st1.Strings[st1.count-1];
                     st1.Delete(st1.count-1);
                     st1.Append('Code=fuchengrong@hotmail.com');
                     delete(ss,1,5);
                      if Comparetext( ss,THashMD5.GetHashString(st1.text))<> 0 then
                       begin
                         st1.clear;
                         st1.Append('��Ϸ��Ʒ�ļ�����ˮӡ��Ч��');
                       end else begin
                                  st1.Delete(st1.count-1);
                                end;  }


 for i:= st1.Count-1 downto 0 do
    if fastpos(st1.Strings[i],';;',length(st1.Strings[i]),2,1)> 0 then
       st1.Delete(i); //����˫�ֺŵ�ע����

end;
            {������������}
procedure TData2.Load_file_upp(const n: string; st1: Tstringlist);
var
    stream1: TStream;
    ss: string;
    i: integer;
    zip: TVCLUnZip;
begin
  st1.Clear;

  if not FileExists(n) then
    exit;

    ss:= 'uA-G3P@2wQ@3N';
    for i:= 1 to 12 do
     if i mod 2 = 1 then
        delete(ss,i div 2+1,1);
     ss:= copy(ss,1,4);
   // vclzip1.ZipName:= opendialog1.FileName;
   ss:= ss+ '@'+ inttostr(3);
    //vclzip1.Password:= 'AGP2@3%N';
    zip:= TVCLUnZip.create(nil);

      zip.Password:= ss + '%N';
     stream1:= TMemoryStream.Create;
     zip.ZipName:= n;
      //vclzip1.UnZipToStream(stream1,ExtractFileName(n));

        zip.UnZipToStreamByIndex(stream1,0);
      // vclzip1.UnZip;
       stream1.Position:= 0;
       st1.LoadFromStream(stream1);
       zip.free;
   stream1.Free;

   if Comparetext( ExtractFileExt(n),'.usp')<> 0  then  //��Ʒ�ļ�������������ֺ�
     begin
      if not Game_loading then
       begin
                 ss:= st1.Strings[st1.count-1];
                      if ss<> '' then
                       begin
                            delete(ss,1,16);
                            if (game_pstringw<>'') and (ss<> game_pstringw) then
                             begin
                               st1.Clear;
                               messagebox(form1.Handle,'����upp�ļ��������޸ģ����°�װ��Ϸ�������������⡣','error',mb_ok);

                             end;
                       end;
      end;
   for i:= st1.Count-1 downto 0 do
    if fastpos(st1.Strings[i],';;',length(st1.Strings[i]),2,1)> 0 then
       st1.Delete(i); //����˫�ֺŵ�ע����
    end;

end;
      {������Ʒ�������ù�ϣini}
procedure TData2.load_goods_file;
var str1: Tstringlist;
begin
 if not Assigned(game_memini1) then
    begin
    game_memini1:= TMemIniFile.Create('');

   str1:= Tstringlist.Create;
     Load_file_ini(game_app_path_G +'goods.usp',str1);
     assert(str1.Count>1,'��Ч����Ʒ�ļ�');
     game_memini1.SetStrings(str1);
   str1.Free;
    end;
end;

procedure TData2.load_scene(id: string; St1: Tstringlist);
var str1: Tstringlist;
    stream1: TStream;
    ss: string;
    ss_addr: string;
    k,m: integer;
    zip2: TVCLUnZip;
    label pp;
     function FileExists_ugm: boolean;
      var t: dword;
      begin
      result:= false;
       {��������ƽ�����ugm����·��,��ô������Ĭ��·��}
       if not game_bg_music_rc_g.gum_only then
        begin
          ss_addr:= game_app_path_G+'scene\'+ id;
          if FileExists(ss_addr) then
            begin
              result:= true;
              exit;
            end;
        end;
        {Ĭ��·����������Ҫ���ļ�,����ugm����·����Ϊ�� ��ô,��������һ��ugm·��}
        if game_bg_music_rc_g.gum_path<> '' then
         begin
           ss_addr:= game_doc_path_G+'down_ugm\'+ id;
           if FileExists(ss_addr) then
            begin
              result:= true;
              //����ʼ������һ���ļ�
              inc(m);
              if not FileExists(game_doc_path_G+'down_ugm\'+inttostr(m)+'.ugm') then
                 down_http.Create(game_bg_music_rc_g.gum_path+ inttostr(m)+'.ugm',
                                        game_doc_path_G+'down_ugm\'+ inttostr(m)+'.ugm',false);
            end else begin
                       //���������,��ô��������,������س�ʱ��������,����
                       if ugm_down_count_g > 9 then
                        begin
                          m:= 1; //����ʧ�ܴ�������
                          exit;
                        end;
                       down_http.Create(game_bg_music_rc_g.gum_path+ id,
                                        ss_addr,false);
                       //�ȴ����ؽ��
                       t:= GetTickCount;
                       form1.Edit1.Text:= '�������س�������';
                       form1.Edit1.Visible:= true;
                        while GetTickCount -t < 15000 do
                          begin
                            if FileExists(ss_addr) then
                             begin
                              result:= true;
                              form1.Edit1.Visible:= false;
                              exit;
                             end;
                            application.ProcessMessages;
                            sleep(100);
                          end;

                       //���س�ʱ
                       form1.Edit1.Visible:= false;
                       inc(ugm_down_count_g);
                       m:= 3;
                     end;
         end else m:= 2; //��ʾ�ļ�������,������urlҲ������


      end;
begin
m:= strtoint2(id); //����һ���������������ļ�
id:= id + '.ugm';
k:= 0;

  if FileExists_ugm then
   begin
    str1:= Tstringlist.Create;
    //vclzip1.Password:= 'APP2433N';

        pp:
         str1.Clear;
         stream1:= TMemoryStream.Create;
         zip2:= TVCLUnZip.Create(nil);
         zip2.Password:= 'APP2433N';
         zip2.ZipName:= ss_addr;
         zip2.UnZipToStreamByIndex(stream1,0);
         stream1.Position:= 0;

       str1.LoadFromStream(stream1);

          zip2.free;
          stream1.Free;

       if str1.Count= 0 then
        begin
         inc(k);
         if k<= 5 then
         begin
         sleep(100);
         goto pp;
         end;
          St1.Add('�յĳ����ļ���<a href="game_goto_home(0)" title="">�س�</a>');
          stream1.Free;
          str1.Free;
         exit;
        end;

       ss:= trim(str1.Strings[0]) + '.ugm'; //��ȡ��һ���ַ���
       delete(ss,1,3);
        if CompareText(ss,id)<> 0 then
           begin
             str1.Clear;
             St1.Add('��Ϸ����ID��ƥ�䡣<a href="game_goto_home(0)" title="">�س�</a>');
           end else begin

                     ss:= str1.Strings[str1.count-1];
                     str1.Delete(str1.count-1);
                     {str1.Append('Code=ufo2003a@gmail.com');

                     delete(ss,1,5);
                      if CompareStr( ss,THashMD5.GetHashString(str1.text))<> 0 then
                       begin
                         str1.Clear;
                         St1.Add('��Ϸ�����ļ���Ч��<a href="game_goto_home(0)" title="">�س�</a>');
                       end else begin
                                  str1.Delete(str1.count-1);

                                end;   }
                       if str1.count>0 then
                         ss:= str1.Strings[str1.count-1]
                         else
                          ss:= '';


                           if ss<> '' then
                              delete(ss,1,16);

                            if (game_pstringw<>'') and (ss<> game_pstringw) then
                             begin
                               str1.Clear;
                                St1.Add('��Ϸ����CRCУ��ʧ�ܣ����°�װ��Ϸ�������������⡣�����vista����win7��win10�Ȳ���ϵͳ���������Ϸ��װ�ڷ�ϵͳ�̱���D�����ԡ�<a href="game_goto_home(0)" title="">�س�</a>');
                             end;
                    end;


     //stream1.Free;


      if str1.Count > 0 then
       begin // �����ļ�
        if not read_game_scene(str1,st1) then
          st1.Add('�����ļ�����ʧ�ܡ������ļ��Ѿ����ƻ���<a href="game_goto_home(0)" title="">�س�</a>');
       end;

     str1.Free;
   end else begin
              //�ļ������� ����
               {m= 2; //��ʾ�ļ�������,������urlҲ������
                       m:= 3;  //���س�ʱ
                       m:= 1; //����ʧ�ܴ�������}

              st1.Clear;
              st1.Add('<html><body>');
               case m of
               1: st1.Add('������س���ʧ��,�������ٴγ��������ˡ����������Ƿ�ͨ������������Ϸ��ҳ���Է�ӳ���⡣');
               2: st1.Add('�ó��������ڣ��Ҳ����ڿɹ��Զ����ص���ַ��Ϣ��');
               3: st1.Add('������Ϸ������ʱ�����ۼƳ�ʱ'+ inttostr(ugm_down_count_g)+'�Ρ�');
                else
                 st1.Add('�ó��������ڣ��Ƿ��������أ�');
               end;
              st1.Add('<p>');
              st1.Add('����<p>');
              st1.Add('<a href="http://www.finer2.com/wordgame/" title="����Ϸ����ҳ�����Ƿ����µĿ���������" target="_blank">����ҳ�鿴�°汾</a><p>');
              st1.Add('<a href="game_page(-1)" title="">����ǰҳ</a><p>');
              st1.Add('<a href="game_goto_home(0)" title="">�س�</a><p>');
              st1.Add('</body></html>');

            end;
end;

procedure TData2.out_save(s: string; outfilename: string);
var str1: Tstringlist;

begin
   str1:= tstringlist.Create;
    str1.Add(s);
    str1.SaveToFile(s+'\out.txt'); //������out��txt ���ʹ�ðٶ���������ô��ձ����guid Ȼ��ɾ�����ļ�
   str1.Free;


  screen.Cursor:= crhourglass;
    TZipFile.ZipDirectoryContents(outfilename, s+ '\'); //ָ��Ŀ¼ȫ��ѹ��
    {   zip1:= tvclzip.Create(nil);
       with zip1 do
       begin
         RootDir:= extractfilepath(outfilename);
         ZipName:= outfilename;
         FilesList.Clear;
         FilesList.Add(s+ '\*.*');
         Recurse := True;
         RelativePaths := false;
         //RecreateDirs:=true;
         Zip;
       end;
         zip1.Free; }
  screen.Cursor:= crdefault;
end;

function get_down_img_url: string;
var url,ky: string;
     function URIEncode(const S: string): string;
       var
       I: Integer;
       begin
        result:= '';
         for I := 1 to Length(S) do
           Result := Result + '%' + IntToHex(Ord(S[I]), 2);
       end;
begin
  if (game_bg_music_rc_g.sch_pic<> '') and ((game_bg_music_rc_g.sch_key<> '') or (temp_sch_key_g<>'')) then
   begin
     url:= game_bg_music_rc_g.sch_pic;
     if game_bg_music_rc_g.sch_count1 >= game_bg_music_rc_g.sch_MAX then
        game_bg_music_rc_g.sch_count1:= 0; //����ҳ���������

    url:=  StringReplace(url,':number',inttostr(game_bg_music_rc_g.sch_count1),[rfReplaceAll]);
     if temp_sch_key_g<>'' then
        ky:= temp_sch_key_g
        else ky:= game_bg_music_rc_g.sch_key;

    result:=  StringReplace(url,':name',URIEncode(UTF8Encode(ky)),[rfReplaceAll]);

    inc(game_bg_music_rc_g.sch_count1); //�ۼ����ش���
   end else result:= '';
end;

function get_down_img_filename: string;
var ii: integer;
label pp;
begin

    result:= '';
    if Game_scene_type_G and 256= 256 then
       exit;
       
    if temp_sch_key_g= '' then  //�������ʱָ���ļ�����ôÿ�ζ��������أ����ȼ��ػ���
      begin
    if temp_pic_file_g= '' then
       goto pp;
     if not FileExists(temp_pic_file_g) then
         goto pp;
      end else begin  // if temp
                 temp_pic_file_g:= game_app_path_G+ 'img/wait.gif';
               end;
   if  Game_is_reload then //��������ʱ����
    begin
      result:= re_show_img_tmp_g;
      exit;
    end;
             result:= '<img id="img_shc" ';
              if temp_sch_key_g= '' then
                 ii:= game_bg_music_rc_g.sch_img_height
                 else
                  ii:= 44;
             if ii> 0 then
              result:= result+ 'height='+inttostr(ii);



             result:= result+ ' src="file:///'+ temp_pic_file_g +'" style="float:right;">';
             if not not_show_img_tip_g then
              begin
               result:= result+ 'ͼƬ���Թؼ���������<b>';

                if temp_sch_key_g= '' then
                result:= result + game_bg_music_rc_g.sch_key
                else
                  result:= result + 'ҳ��ָ����'+temp_sch_key_g;

                  result:= result+ '</b> ��'+ inttostr(game_bg_music_rc_g.sch_count1) +'�� ������'
                              + '<a href="game_show_set(2)" title="����ϲ����ͼƬ�����ؼ��ֺ���ʾ��ʽ">���Ĺؼ���</a>&nbsp;<a href="game_set_var(1,1);game_infobox(''��ʾ��ȡ���������л�ҳ�����ʧ'')"'+
                                ' title="������ʾ��������">ȡ����ʾ</a>&nbsp;<a href="game_question(''ȷ��Ҫ�ر�ͼƬ��ʾ�����Ժ�Ҳ������ϵͳ�����ڻָ���ʾ��'');game_set_var(2,0);game_infobox(''ͼƬ�ѹرգ������л�ҳ�����ʧ'')" title="������Ϸ�ڲ�����ʾͼƬ">�ر�ͼƬ</a><p>';
              end;
             re_show_img_tmp_g:= result; //����һ������
      pp:
     
          down_http.Create(get_down_img_url,'',(temp_sch_key_g<>''));
end;

function CrossFixFileName(const FileName: String): String;
const
  PrevChar = '\';
  NewChar = '/';

var
  I: Integer;
begin
  Result := FileName;

  for I := 1 to Length(Result) do
    if Result[I] = PrevChar then
      Result[I] := NewChar;
end;

function StringToHex(str: ansistring): string;
var
   i : integer;
   s : string;
begin
   for i:=1 to length(str) do begin
       s := s + InttoHex(Integer(str[i]),2);
   end;
   Result:=s;
end;
function create_img_file(const s: string): string; //����һ��ͼƬ�ļ��������ļ���
begin
    //jpg�ô�д��������ͼƬ���������Сд��ʵ�ֲ�ͬ����
   result:= Game_app_img_path_G+ THashMD5.GetHashString(s).Substring(8,16) +'.JPG';
   if not FileExists(result) then
    begin
     //OutputDebugString(pchar(ss));

      form1.game_pic_from_text(nil,s,result);

      //strem1.Free;
    end;

end;

function TData2.read_game_scene(source, dest: Tstringlist): boolean;
var i,k,j: integer;
    s_type: Tgame_s_type; //�����ڵ���Դ����
     b,b2,b3: boolean;
     ss,s_functions,tmp_ss,kuan: string;
     label pp;
begin
result:= false;
Game_cannot_runOff:= false;

                {
           ����=2 �Թ� 4=�������ʱ��
           8=��ֹ�����Ի� 16=����ǰ���� 32=�������
           64=�سǵ� 128=�˳�ҳ��ʱ����
           256=��ֹ��ʾ������ͼƬ
     }

    form1.GroupBox5.Caption:= source.Values['����'];
    Game_scene_author:= source.Values['����'];  //���泡����������
    temp_sch_key_g:= source.Values['TempKey']; //��ʱkey
    b2:= source.Values['ID']<>'10000';  //��ҳ����������ǰ���ִ��

        if (game_exit_cmd_str_g <> '') and b2 and (Game_is_reload=false) then
           begin
            if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then
                form1.Game_action_exe_S_adv(game_exit_cmd_str_g); //ִ���ϴε��˳�����
            game_exit_cmd_str_g:= '';
           end;

     if source.Values['����'] = '' then
        Game_scene_type_G:= 1
        else
         Game_scene_type_G:= strtoint2(source.Values['����']);  //��������

     if (Game_scene_type_G and 4<> 4) and (game_auto_temp_g<> 2) then
        form1.temp_event_clean; //�����ʱ��
        
        game_auto_temp_g:= 0;

     if Game_scene_type_G and 64= 64 then
        Form1.game_write_home_id; //����سǵ�

     if Game_scene_type_G and 16= 16 then
       begin
         //16 ���볡��ǰִ�ж��� 32Ϊ���볡����
         if not Game_is_reload then //Game_is_reloadֵΪ�棬��ִ�нű�
           begin
        s_functions:= source.Values['����ǰ'];
        if (s_functions <> '') and b2 then
          if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then  //�������磬���Ǹ���
             form1.Game_action_exe_S_adv(s_functions); //ִ�к�������䣬�ɴ�if then
           end;
       end;

    if Game_scene_type_G and 128= 128 then
       begin
         //128 ���˳���ִ�е�
         if not Game_is_reload then //Game_is_reloadֵΪ�棬��ִ�нű�
           begin
             game_exit_cmd_str_g:= source.Values['�˳���'];
           end;
       end;
  b:= false;
  b3:= true; //û����ӹ������û�
  //b_action:= false;
 // b_chat:= false;
  s_type:= G_nil;
  k:= 0; //�������{}�Ƿ����

 for i:= 1 to source.Count-1 do
  begin
   if source.Strings[i]= '' then
    Continue;
   if fastpos(source.Strings[i],';;',10,2,1)> 0 then
     Continue; //����˫�ֺŵ�ע����

   if fastcharpos(source.Strings[i],'{',1)> 0 then
       begin
        if trim(source.Strings[i])= '{' then //{���ռһ��
         begin
          if k= 0 then
           begin
           b:= true;
           inc(k);
           Continue;
           end;
            inc(k);
         end;
       end;

   if not b then
   begin
   if pos('����=',source.Strings[i])> 0 then
     s_type:= G_action;
    if pos('����=',source.Strings[i])> 0 then
     s_type:= G_description;
    if pos('�Ի���Դ=',source.Strings[i])> 0 then
     s_type:= G_chat;
    
   end else begin
             ss:= source.Strings[i];
             if fastcharpos(ss,'}',1)> 0 then
              begin
               if trim(ss)= '}' then
                 begin
                  dec(k);
                  if k= 0 then
                   begin
                    b:= false;
                    Continue;
                   end;
                 end;
              end;

              case s_type of
               G_action: begin
                           //����
                           Game_action_list.Append(ss);
                         end;
               G_description: begin
                              //����
                              if not game_reload_chat_g then
                              begin
                            dest.Append(source.Strings[i]);
                               if b3 then
                                begin
                                 if game_NoRevealTrans_g then
                                  begin  //ȥ��ת����
                                   if FastPos(source.Strings[i],'revealTrans',
                                      length(source.Strings[i]),11,1)> 0 then
                                     dest.Delete(dest.Count-1); //ɾ�����һ�е�ת��Ч��
                                  end;
                                     if FastPosNoCase(source.Strings[i],'</head',
                                                 length(source.Strings[i]),6,1)> 0 then
                                          begin
                                            if (FastPosNoCase(source.Strings[i],'<body',length(source.Strings[i]),5,1)= 0)
                                                 and (FastPosNoCase(source.Strings[i+1],'<body',length(source.Strings[i]),5,1)= 0) then
                                                   begin
                                                   dest.Append('<body>'); //û��body�ļ���body
                                                    goto pp;
                                                   end;
                                          end;
                                 if FastPosNoCase(source.Strings[i],'<body',
                                   length(source.Strings[i]),5,1)> 0 then
                                  begin
                                     pp:
                                     if game_bg_music_rc_g.bg_img then //�Զ��屳��
                                        dest.Strings[dest.Count-1]:= get_bg_img_filename('')
                                        else if game_bg_music_rc_g.sch_enable then
                                             begin
                                               //�������ͼƬ���ܿ�������Ҳ������ ����ͼƬ����Ϊ����
                                               if (game_bg_music_rc_g.sch_img_sty= 2) and
                                                   (temp_pic_file_g<> '') then
                                                    dest.Strings[dest.Count-1]:= get_bg_img_filename(temp_pic_file_g);
                                             end;
                                     if game_bg_music_rc_g.sch_enable and
                                        (game_bg_music_rc_g.sch_img_sty= 0) then
                                      begin
                                        //����ͼƬ����Ϊҳ��
                                           dest.Append(get_down_img_filename);
                                      end;
                                     if game_at_net_g then
                                     dest.Append('<table><tr><td id=cell_net1></td></tr><tr><td><a href="game_reshow_online(0)" title="����˰�ť�����»�ȡ�����������">ˢ���������</a></td></tr></table>');
                                     //���������ʾ����
                                        dest.Append('<div id=layer_chat1 style="position:absolute; top:60%; left:10px; width:90%; height:160px; background-color:FFFFFF; overflow:auto; z-index:64;display:none;">'+
                                        '<table width=70% cellpadding=4 cellspacing=0 rules=none><tr><td id=cell_chat1></td><td valign=top><a href="game_chat_cleans2(0)">�ر�</a></td></tr></table></div>');
                                    b3:= false;
                                  end;
                                end else begin // end b3

                                         end; 
                              end; //end if not
                          end;
               G_chat: begin
                          //����
                       Game_chat_list.Append(ss);
                       end;
               end; //end case
             result:= true;
            end;

  end; //end for

               //������ if then ����+++++++++++++++++++++++
               chat_if_then(Game_action_list);

               //++++++++++++++++++++++++++++++++++++++++++++++++

           //�Ի���if then ����++++++++++++++++++++++++++++++++++++

              chat_if_then(Game_chat_list);
                //��������滻Ϊ��ʵ·��������ʾͼƬ
                
                for i:= 0 to Game_chat_list.Count -1 do
             begin
              if fastpos(Game_chat_list.Strings[i],'$apppath$',
                         length(Game_chat_list.Strings[i]),9,1)> 0 then
                 Game_chat_list.Strings[i]:= CrossFixFileName(stringReplace(Game_chat_list.Strings[i],
                                                               '$apppath$','file:///'+game_app_path_G,[rfReplaceAll]));
               Game_chat_list.Strings[i]:=function_re_string2(Game_chat_list.Strings[i]); //�Ժ��з����ַ����ĺ������з���ֵ��ȡ
             end; //end for

                Game_can_talk_G:= (Game_chat_list.Count > 0);
                
           //++++++++++++++++++++++++++++++++++++++++++++++++++++++++

          //����Դ�Ľ�һ������ ++++++++++++++++++++++++++++++++++++++++++++++++
               if not game_reload_chat_g then  //������ǽ�������Ի�
                 begin
            dest.Text:= explain_scene_html(dest.getText);  //���� if then �ȵ�

            for i:= 0 to dest.Count -1 do    //�滻Ϊ��ʵ·��������ʾͼƬ
             begin
                //��֧���Զ���Э�飬���ǰ������Ϊurl��Ȼ������ʱ�ļ�����
              //if fastpos(dest.Strings[i],'charset=gb2312',length(dest.Strings[i]),14,1)> 0 then
               //  dest.Strings[i]:=stringReplace(dest.Strings[i],'charset=gb2312','charset=ISO-8859-1',[rfReplaceAll]);
               tmp_ss:= dest.Strings[i];
              if fastpos(tmp_ss,'gpic://',length(tmp_ss),7,1)> 0 then
               begin
                  k:= fastpos(tmp_ss,'gpic://',length(tmp_ss),7,1);
                  j:= pos('.bmp',tmp_ss);
                  ss:= copy(tmp_ss,k+7,j+3);

                  kuan:= copy(ss,1,pos(',',ss)-1);  //����img��ǩ�������
                  // ss:= StringToHex(ss);

                   if tmp_ss[j+4]=')' then
                    begin
                     kuan:= 'background-size:'+kuan+'px;';
                     insert(kuan,tmp_ss,pos(';',tmp_ss)+1);
                    end else begin
                              kuan:= 'width="'+kuan+'"';
                              insert(kuan,tmp_ss,j+5);
                             end;


                    //�����ļ�������·��

                 tmp_ss:= copy(tmp_ss,1,k-1)+ 'file:///'+ create_img_file(ss)+
                                   copy(tmp_ss,j+4,512);
                 //stringReplace(dest.Strings[i],'gpic://','http://127.0.0.1:8081/a?p='+ ss+'&v=a.bmp',[rfReplaceAll]);
               end;

                 //�滻Ϊʵ�ʵ��ļ���
              if fastpos(tmp_ss,'$apppath$',length(tmp_ss),9,1)> 0 then
                 tmp_ss:=CrossFixFileName(stringReplace(tmp_ss,'$apppath$','file:///'+game_app_path_G,[rfReplaceAll]));

                dest.Strings[i]:=CrossFixFileName(stringReplace(tmp_ss,'file://f','f',[rfReplaceAll]));
             end; //end for
                  if game_bg_music_rc_g.sch_enable and
                  (game_bg_music_rc_g.sch_img_sty= 1) then
                  dest.Insert(dest.Count-2,get_down_img_filename); //����ͼƬ����Ϊҳ��
                     {
                  if (Game_is_reload=false) and (Game_scene_type_G and 2=2) and ((Game_ad_count_G.X<> 1) or (Game_ad_count_G.Y < 10))
                  then
                  begin
                                           //��ʾ�Թ��ڵĹ�� filter:Alpha(Opacity=55);
                  dest.insert(dest.Count-2,'<p>&nbsp;<p>&nbsp;<hr><table style="width:100%; height:240; z-index:5;"><tr><td id=ad_tabletd1>'+
                  '<iframe id=ad_layer1 align=center src="http://www.finer2.com/wordgame/jiqiao'+inttostr(Random(20)+1)+'.htm" width=900 height=240 framespacing=0 frameborder=0></iframe></td></tr></table>');
                  Game_ad_count_G.Y:= Game_ad_count_G.Y+ 1;
                  end;
                        }
                  dest.Insert(dest.Count-2,'<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;'); //�������
                 end; // end if not
       //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

       
        //���볡����ִ�ж��� 32Ϊ���볡����
     if Game_scene_type_G and 32= 32 then
       begin
        if Game_is_reload or (form1.game_read_temp(form1.pscene_id)= 1) then //���Խű����б�ǵ��Թ�Ҳ����
        begin
         Game_is_reload:= false; //��Ϊfalse����ֵ��ÿ������
        end else begin
                  Game_script_scene_after := source.Values['�����'];
                  if (Game_script_scene_after <> '') and b2 then
                    if Game_script_scene_after[1]= 'D' then
                      begin
                      Game_script_scene_G:= Game_script_scene_after;
                      postmessage(form1.Handle,game_const_script_after,31,0);
                       end else
                           postmessage(form1.Handle,game_const_script_after,29,0);
                 end;
       end;
       

         Game_is_reload:= false; //��Ϊfalse����ֵ��ÿ������ //���Խű�

   if game_debug_handle_g<> 0 then  //���͵�����Ϣ
    begin
      for i:= 0 to Game_action_list.Count-1 do
         Form1.debug_send_func_str(Game_action_list[i],html_C);
      for i:= 0 to dest.Count-1 do
         Form1.debug_send_func_str(dest[i],html_C);
      for i:= 0 to Game_chat_list.Count-1 do
         Form1.debug_send_func_str(Game_chat_list[i],html_C);
    end;
                               
end;

procedure TData2.DataModuleDestroy(Sender: TObject);
begin
 if Assigned(game_memini1) then
    game_memini1.Free;
 if Assigned(game_memini_event) then
    game_memini_event.Free;

 if Assigned(Game_task_uncomp1) then
    Game_task_uncomp1.Free;

 if Assigned(Game_task_comp1) then
    Game_task_comp1.Free;

 if Assigned(game_message_txt) then
    game_message_txt.Free;
 if Assigned(bg_music_filelist_g) then
    bg_music_filelist_g.Free;
 if Assigned(bg_img_filelist_g) then
    bg_img_filelist_g.Free;

Game_guai_list_G.Free;

end;
       
function TData2.get_game_goods_type(i: integer;  //��ȡ��Ʒ�����б�
  tp: Tgame_goods_type): integer;
  var ss: string;
      j: Tgame_goods_type;
      k: integer;
begin
  ss:= game_memini1.ReadString('GOODS',inttostr(i),'');
result:= 0;
 if length(ss) < 10 then
    exit;

   for j:= goods_name1 to high(Tgame_goods_type) do
    begin
      //��������ƺ���������ô�����ַ���
      k:= pos(',',ss);
      if (j= tp) and (j=goods_name1) then
       begin
        Game_g_name_G:= copy(ss,1,k-1);
        result:= integer(pchar(Game_g_name_G));
        exit;
       end;
       if (j=tp) and (j= high(Tgame_goods_type)) then
        begin
          Game_g_name_G:= ss;
          result:= integer(pchar(Game_g_name_G));
         exit;
        end;
        //����integer����
         if j= tp then
           begin
           result:= strtoint2(copy(ss,1,k-1));
           exit;
           end;
       delete(ss,1,k);
    end;
end;
                   {��ȡ��Ʒ���ԣ�����������}
function TData2.get_game_goods_type_a(i: integer): string;
var ss: string;
begin
result:= '';
 if i= 0 then
  exit;

  ss:= game_memini1.ReadString('GOODS',inttostr(i),'');
   get_game_goods_type_a_base(ss);
  result:= ss;
end;

procedure TData2.get_game_goods_type_a_base(var ss: string);
var i,j: integer;
    ss2: string;
begin
  ss2:= get_game_goods_type_s(ss,goods_ms1);//ȡ������
  i:= fastcharpos(ss,',',1);
   if i > 0 then
      delete(ss,i,fastcharpos(ss,',',i+1)-i); //ɾ�����ͺ�ǰ�������

   
  j:= 3;
  i:= fastcharpos(ss,',',1);
   while i > 0 do
    begin

      if (ss[i+ 1]= '0') or (j >10) then
        begin
         if j> 9 then
            delete(ss,i,200)
          else begin
        delete(ss,i,2);
        dec(i,2);
               end;
        end else begin
                 inc(i);

                 
               case j of
               3:insert('��+',ss,i);
               4:insert('��+',ss,i);
               5: insert('��+',ss,i);
               6: insert('��+',ss,i);
               7: insert('��+',ss,i);
               8: insert('��+',ss,i);
               9: insert('��+',ss,i);
              // 10: insert('�� +',ss,i);
               end;
             end;
      i:= fastcharpos(ss,',',i+1);
      inc(j);
    end;

    ss:= StringReplace(ss,'999999999','����ȫ��',[rfReplaceAll]);
    ss:= StringReplace(ss,'99999999','��������',[rfReplaceAll]);
    ss:= StringReplace(ss,'9999999','ȫ��',[rfReplaceAll]);
    ss:= StringReplace(ss,'999999','����',[rfReplaceAll]);
   // delete(ss,1,fastcharpos(ss,',',1)-1);  //ɾ��ǰ�������
  ss:= ss + ','+ ss2;
end;
                {��ȡ�ַ������͵���Ʒ����}
function TData2.get_game_goods_type_s(const s: string;
  tp: Tgame_goods_type): string;
 var  ss: string;
      j: Tgame_goods_type;
      k: integer;
begin
 ss:= s;
result:= '';
   for j:= goods_name1 to high(Tgame_goods_type) do
    begin
      k:= pos(',',ss);
      if (j= tp) and (j=goods_name1) then
       begin
        ss:= copy(ss,1,k-1);
        result:= ss;
        exit;
       end;
       if (j=tp) and (j= high(Tgame_goods_type)) then
        begin
          result:= ss;
         exit;
        end;

         if j= tp then
           begin
           result:=copy(ss,1,k-1);
           exit;
           end;
       delete(ss,1,k);
    end;

end;
                 {��ȡ��������}
function TData2.get_game_fa(i2: integer): string;
var ss: string;
begin
  ss:= game_memini1.ReadString('GOODS',inttostr(i2),'');
  if ss<>'' then
   result:= format('%s, %s',[get_game_goods_type_s(ss,goods_name1),
                                get_game_goods_type_s(ss,goods_ms1)]);
end;
                   {��ȡ��������}
function TData2.get_game_ji(i2: integer): string;
var ss: string;
begin
  ss:= game_memini1.ReadString('GOODS',inttostr(i2),'');
  if ss<>'' then
   result:= format('%s, %s',[get_game_goods_type_s(ss,goods_name1),
                                get_game_goods_type_s(ss,goods_ms1)]);

end;

procedure TData2.load_event_file(n: string); {�����¼��ļ�������}
var str1: Tstringlist;
begin
   if not Assigned(game_memini_event) then
    begin
    game_memini_event:= TMemIniFile.Create('');
    end;

   str1:= Tstringlist.Create;
    if n<> '' then
     Load_file_event(n,str1)
     else begin
           str1.Add('[EVENTS]');
           str1.Add('');
           str1.Add('[FOODS]');
           str1.Add('');
          end;
     game_memini_event.SetStrings(str1);
   str1.Free;
    

end;
                 {�����¼��ļ���base}
procedure TData2.Load_file_event(const n: string; st1: Tstringlist);
var
    stream1: TStream;
    zip2: TVCLUnZip;
begin

   if not FileExists(n) then
    exit;
    zip2:= TVCLUnZip.Create(nil);
   zip2.Password:= 'E1v2e#n%T';

     stream1:= TMemoryStream.Create;
     zip2.ZipName:= n;
      //vclzip1.UnZipToStream(stream1,ExtractFileName(n));

       zip2.UnZipToStreamByIndex(stream1,0);
      // vclzip1.UnZip;
       st1.Clear;
       stream1.Position:= 0;
       st1.LoadFromStream(stream1);
       zip2.free;
   stream1.Free;

end;
              {�����¼��ļ� ����}
procedure TData2.save_file_event(const n: string);
var
    stream1: TStream;
    st1: Tstringlist;
    vclzip1: TVCLZip;
begin
  if n= '' then
   exit;

 if Assigned(game_memini_event) then
    begin
      vclzip1:= TVCLZip.Create(nil);
      vclzip1.Password:= 'E1v2e#n%T';
     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
     // vclzip1.UnZipToStream(stream1,ExtractFileName(n));
      st1:= Tstringlist.Create;
       game_memini_event.GetStrings(st1);
        stream1.Position:= 0;
       st1.SaveToStream(stream1);
        stream1.Position:= 0;
       vclzip1.ZipFromStream(stream1,ExtractFileName(n));

       st1.Free;
       stream1.Free;
       vclzip1.Free;
    end;
end;

function TData2.get_goods_all_s(i: integer): string;
begin
   result:= game_memini1.ReadString('GOODS',inttostr(i),'');
end;

procedure TData2.in_save(s: string; saveDir: string);
begin
 //����浵�ļ�
   //savedir��鿴�����Ƿ��и�
screen.Cursor:= crhourglass;
     TZipFile.ExtractZipFile(s, saveDir+'\');
 {  vclunzip1.ZipName:= s;
   vclunzip1.DestDir:= saveDir;
   //VCLUnZip1.RecreateDirs := True;//�Ƿ񴴽���Ŀ¼
   VCLUnZip1.DoAll := True;
   VCLUnZip1.OverwriteMode := always;
    VCLUnZip1.UnZip;   }

  screen.Cursor:= crdefault;
end;

procedure TData2.save_file_upp(const n: string; st1: Tstringlist);   //������������ļ�
var
    stream1: TStream;
    i: integer;
    ss: string;
    vclzip1: tvclzip;
begin
  if not Assigned(st1) then
     exit;
  if st1.Count= 0 then
    exit;

  if n= '' then
   exit;

      ss:= 'uA-G3P@2wQ@3N';
    for i:= 1 to 12 do
     if i mod 2 = 1 then
        delete(ss,i div 2+1,1);
     ss:= copy(ss,1,4);

   ss:= ss+ '@'+ inttostr(3);
     vclzip1:= tvclzip.Create(nil);
    vclzip1.Password:= ss + '%N';

     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
     // vclzip1.UnZipToStream(stream1,ExtractFileName(n));
        stream1.Position:= 0;
       st1.SaveToStream(stream1);
        stream1.Position:= 0;
       vclzip1.ZipFromStream(stream1,ExtractFileName(n));

       stream1.Free;
        vclzip1.Free;


end;

procedure TData2.game_load_goods;
var iFileHandle:integer;
    i: integer;
begin

 iFileHandle:=Fileopen(Game_save_path + 'wp.upp',0);
  if iFileHandle= 0 then
    exit;

for i:= 0 to 1023 do
   Game_goods_G2[i]:= 0;

 try
  FileSeek(iFileHandle,0,0);
  for i:= 0 to 1023 do
    Fileread(iFileHandle,Game_goods_G2[i],1);
 finally
  FileClose(iFileHandle);
 end;

  if Game_goods_G2[0]<> get_checkout then
   begin
    for i:= 0 to 1023 do
     Game_goods_G2[i]:= 0; //���У���벻�ԣ���ô����ȫ�����
   end;
end;

procedure TData2.game_save_goods; //������Ʒ
var iFileHandle:integer;
   i: integer;
begin
  //��У����
   Game_goods_G2[0]:= get_checkout; //ȡ��У����

 iFileHandle:=FileCreate(Game_save_path + 'wp.upp');
  if iFileHandle= 0 then
    exit;

 try
  for i:= 0 to 1023 do
     FileWrite(iFileHandle,Game_goods_G2[i],1);
 finally
  FileClose(iFileHandle);
 end;

      
end;

function TData2.get_checkout: integer;  //������ƷУ����
var i: integer;
    fak,sum: integer;
begin
   fak := 1023;
   sum:= 0;

   for i:= 1 to 1023 do //��һ��λ�ñ���У����
    begin
    if (fak mod 2) = 0 then
      sum := sum + Game_goods_G2[i]
    else
      sum := sum + Game_goods_G2[i]* 3 ;

      dec(fak);
    end;

     result:= 10-(sum mod 10);

    if result = 10 then
       result:= 0;

end;

function TData2.explain_scene_html(const s: string): string;
var i,i_start,i_len,j: integer;
    in_code: boolean; //���������
    ss: string;
begin
      //�Գ����ڵ�html�ļ����н���
in_code:= false;
// i_len:= 0;
 i_start:= 0;
 result:= '';
 i:= 0;
 j:= length(s);
  while i< j do
   begin
    inc(i);
    if in_code then
     begin
       //��������͵Ĵ����
      if (s[i]= ':') and (s[i+1]= '>') then
       begin
         i_len:= i- i_start; //���볤
         //setlength(ss,i_len);
         //Move(s[I_start],ss[1],I_len); move�ǰ��ֽ��㣬ss��˫�ֽڣ�����������
         ss:= s.Substring(I_start-1,i_len); //substring ���㿪ʼ
          explain_scene_html_base(ss); //����
          result:= result + ss;   //�ϲ�

         in_code:= false;
         inc(i);
       end;
     end else begin //����͵Ĵ�����
               if (s[i]= '<') and (s[i+1]= ':') then
                  begin
                   in_code:= true;
                   i_start:= i+ 2;  //������ʼ���
                   inc(i);
                  end else result:= result+ s[i];

              end;
   end; //end i

  function_re_string(result);  //�ٶԷ����ַ������͵ĺ������д���
end;

procedure TData2.explain_scene_html_base(var s: string);
 var b: boolean;
    ss: string;
    I_else: integer;
    p_pos,i: integer;
begin
 if FastPos(s,'if',length(s),2,1)> 0 then
   begin
     if FastPos(s,'then',length(s),4,9)> 0 then
        begin
         clean_if_then(s);  //�����if then �жϵģ���ô�����ж���������Ȼ���˳������򣬼�ģʽ��������������Ĵ���
        // function_re_string(s);  //�ٶԷ����ַ������͵ĺ������д���
         exit;
        end;
   end;

  p_pos:= -1;
  ss:= '';
  if s[1]= 'D' then
  begin
   ss:= Game_action_list.Values[copy(s,1,5)];
    if ss= '' then
     exit;
     form1.Game_action_exe_S_adv(ss);
     b:= true;
  end else begin
   for i:= 1 to length(s) do
    begin
      //��ȡ���������������Ϊ׼
      if s[i]= '(' then
       begin
        if p_pos= -1 then
           P_pos:= 1
             else
               inc(P_pos);
       end else if s[i]= ')' then
                   dec(P_pos);

      if p_pos= 0 then //��ʾ����ȫ�������ϣ���ǰiָ��������
       begin
        ss:=  trim(copy(s,1,i)); //ȡ�ú��������������������Ž�β
         break;
       end;
    end; //end for
            if ss= '' then
              exit;
              b:= form1.Game_action_exe_A(ss)<> 0;  //ִ�к���
            end;

   I_else:= FastPos(s,'else',length(s),4,1);

   if b then
    begin
     //ȡ��elseǰ�����ȫ��������
     if I_else> 0 then
        delete(s,I_else,length(s)- I_else+ 1);

     delete(s,1,length(ss)); //ɾ��ǰ��ĺ���
    end else begin
              //ȡ��else��������ݣ����else�����ڣ�
               if I_else= 0 then
                 s:= ''
                 else
                   delete(s,1,I_else+ 3);
             end;

end;

procedure TData2.game_show_task_complete(t: tstrings);
var str1: Tstringlist;
    i: integer;
begin
     //��ʾ����ɵ�����
    if not Assigned(Game_task_comp1) then
       exit;

    str1:= Tstringlist.Create;

       Load_file_upp(game_app_path_G+'dat\task.upp',str1); //��������ļ�

        for i:= 0 to Game_task_comp1.Count-1 do
         begin
          t.Append(str1.Values[Game_task_comp1.Strings[i]]);
         end;
    str1.Free;

end;

procedure TData2.game_show_task_uncomplete(t: tstrings);
var str1: Tstringlist;
    i: integer;
begin
                   //��ʾû����ɵ�����
    if not Assigned(Game_task_uncomp1) then
       exit;

    str1:= Tstringlist.Create;

       Load_file_upp(game_app_path_G+'dat\task.upp',str1); //��������ļ�
    //  Load_file_upp(game_app_path+'dat\task_uncomp.upp',str2); //���������ļ�
        for i:= 0 to Game_task_uncomp1.Count-1 do
         begin
          t.Append(str1.Values[Game_task_uncomp1.Strings[i]]);
         end;
    str1.Free;



end;

procedure TData2.game_addto_complete(s: string);
begin
   if not Assigned(Game_task_comp1) then
       Game_task_comp1:= Tstringlist.Create;

      Game_task_comp1.Append(s);  //�����������б�

      if Game_task_uncomp1.IndexOf(s)> -1 then
         Game_task_uncomp1.Delete(Game_task_uncomp1.IndexOf(s));  //��δ����б�ɾ��
end;

procedure TData2.game_addto_uncomplete(s: string);
begin
    if not Assigned(Game_task_uncomp1) then
       Game_task_uncomp1:= Tstringlist.Create;

      Game_task_uncomp1.Append(s);  //�������δ����б�
end;

procedure TData2.game_load_task_file;
begin
   if not Assigned(Game_task_uncomp1) then
       Game_task_uncomp1:= Tstringlist.Create;

   if not Assigned(Game_task_comp1) then
       Game_task_comp1:= Tstringlist.Create;
   if not Assigned(game_message_txt) then
       game_message_txt:= Tstringlist.Create;

   if FileExists(Game_save_path+'task_uncomp.upp') then
   Load_file_upp(Game_save_path+'task_uncomp.upp',Game_task_uncomp1);  //���������б�

   if FileExists(Game_save_path+'task_comp.upp') then
    Load_file_upp(Game_save_path+'task_comp.upp',Game_task_comp1);
game_message_txt.Clear;
   if FileExists(Game_save_path+'message.upp') then
    Load_file_upp(Game_save_path+'message.upp',game_message_txt);  //������Ϣ�б�
end;

procedure TData2.game_save_task_file;
begin
   if Assigned(Game_task_uncomp1) then
   save_file_upp(Game_save_path+'task_uncomp.upp',Game_task_uncomp1); //���������б�

   if Assigned(Game_task_comp1) then
    save_file_upp(Game_save_path+'task_comp.upp',Game_task_comp1);

    if Assigned(game_message_txt) then
    save_file_upp(Game_save_path+'message.upp',game_message_txt);

end;

function TData2.game_get_task_s(id: string): string; //ȡ��task�����ڵ�һ������
var str1: Tstringlist;

begin


    str1:= Tstringlist.Create;

       Load_file_upp(game_app_path_G+'dat\task.upp',str1); //��������ļ�
      result:= str1.Values[id]; //ȡ�ý��
    str1.Free;

end;

procedure TData2.chat_if_then(st1: Tstringlist); //�Ի��ڵ�if then ����
     function kuohao(j88: integer; const s: string): integer;
      var j2: integer;
      begin
       kuohao:= 0;   //ȡ�����ұߵ�����λ��
       for j2:= length(s) downto j88 do
           if s[j2]= ')' then
             begin
              kuohao:= j2;
              exit;
             end;
      end;
      function find_then(const s: string): integer;
        var j3: integer;
      begin
        find_then:= -1;
        for j3:= 3 to length(s)- 3 do
         begin
           if (UpCase(s[j3])='T') and (UpCase(s[j3+1])='H')and (UpCase(s[j3+2])='E')
                and (UpCase(s[j3+3])='N') then
                            begin
                             find_then:= j3;
                             exit;
                            end;

         end;

        end;
     function is_if(const s: string; ex: boolean= true): integer;
       var j: integer;
      begin
       is_if:= -1;
        for j:= 1 to length(s)-2 do
          if s[j]= ' ' then
           Continue
            else if UpCase(s[j])='I' then
                   begin
                    if char_not_in_az(s[j+2]) and (UpCase(s[j+ 1])='F') then
                      begin
                       if ex then
                        begin
                        if form1.game_functions_m(copy(s,j+3,find_then(s)-j-3))<> 0 then
                           is_if:= 1
                            else
                              is_if:= 0;
                        end else is_if:= 0; //����ִ��
                       exit;
                      end;
                   end else begin
                              //is_if:= -1; // -1 ��ʾ���ַ����ڲ���if��ʽ
                              exit;
                            end;
      end;
     function find_else(i2: integer): integer;
       var j3,j4: integer;
      begin
        j4:= 0;
        find_else:= -1;
        for j3:= i2+1 to st1.Count- 1 do
         begin
           if is_if(st1.Strings[j3],false)<> -1 then
              inc(j4) //����if ���λ��һ
              else if (UpperCase(trim(st1.Strings[j3]))= 'END') or (UpperCase(trim(st1.Strings[j3]))= 'END;') then
                 begin
                  if j4= 0 then
                    exit
                  else
                    dec(j4) //����end ���λ��ȥһ
                 end else if UpperCase(trim(st1.Strings[j3]))= 'ELSE' then
                         begin
                           if j4= 0 then //�����if endƥ�䣬��ô���else�кŷ���
                            begin
                             find_else:= j3;
                             exit;
                            end;
                         end;
         end;
      end;
      function find_end(i2: integer): integer;
        var j3,j4: integer;
      begin
        j4:= 1;
        find_end:= -1;
        for j3:= i2+1 to st1.Count- 1 do
         begin
           if is_if(st1.Strings[j3],false)<> -1 then
              inc(j4) //����if ���λ��һ
              else if (UpperCase(trim(st1.Strings[j3]))= 'END') or (UpperCase(trim(st1.Strings[j3]))= 'END;') then
                         begin
                           dec(j4); //����end ���λ��ȥһ
                           if j4= 0 then //�����if endƥ�䣬��ô���else�кŷ���
                            begin
                             find_end:= j3;
                             exit;
                            end;
                         end;
         end;

        end;

var i,k,L,k2: integer;
begin
  for i:= 0 to st1.Count -1 do
   begin
     case is_if(st1.Strings[i]) of
    // -1:
     0: begin
         //�ҵ�if ��������Ϊfalse ��ô����then ��else����end������
         k:= find_else(i);
         k2:= find_end(i);

         if k<> -1 then
              st1.Delete(k2); //���else�д��ڣ���ô��ɾ��end�У�����end�л������汻ɾ��
              
         if k= -1 then
           k:= k2; //���else�����ڣ���ô�͵�endΪֹ

           

          for L:= k downto i do
             st1.Delete(L); //ɾ��elseǰ�����endǰ������

          break;
        end;
     1: begin
         //�ҵ�if��������Ϊ�棬��ô�Ͷ���else ���������
          k:= find_else(i);
          k2:= find_end(i); //����end��λ��
          if k > 0 then
           begin
            for L:= k2 downto k do
                st1.Delete(L);  //�������else ɾ��else���������
           end else st1.Delete(k2); //ɾ��end��
           st1.Delete(i); //ɾ������
           break;
        end;
      end; //end case
   end; //end for

  // st1.SaveToFile('e:\s.txt');
   
   for i:= 0 to  st1.Count -1 do
    begin
     //�ٴβ��ң��������if��䣬��ݹ����
      if is_if(st1.Strings[i]) <> -1 then
       begin
         chat_if_then(st1);
         break;
       end;
    end;
  
end;

procedure TData2.clean_if_then(var s: string);
var k,k2,k88: integer;

     function kuohao(j88: integer): integer;
      var j2,j89: integer;
      begin
       kuohao:= 0;   //ȡ�����ұߵ�����λ��
       j89:= 0;
       for j2:= j88 to length(s) do
           if s[j2]= '(' then
             begin
              inc(j89)
             end else if s[j2]= ')'then
                       begin
                        dec(j89);
                         if j89= 0 then
                          begin
                            kuohao:= j2;
                            exit;
                          end;
                       end;
      end;
     function find_then(i2: integer): integer;
        var j3: integer;
      begin
        find_then:= -1;
        for j3:= i2 to length(s)- 3 do
         begin
           if (s[j3]='t') and (s[j3+1]='h')and (s[j3+2]='e')
                and (s[j3+3]='n') then
                            begin
                             find_then:= j3;
                             exit;
                            end;

         end;

        end;
     function is_if(j90: integer): integer;
       var j,j66: integer;
      begin
        is_if:= -1; // -1 ��ʾ���ַ����ڲ���if��ʽ
        j66:= 0;
        for j:= j90 to length(s)-2 do
         begin
          if (s[j]= '(') or (s[j]= '{') then  //�������ڲ�������
             inc(j66)
              else if (s[j]= ')') or (s[j]= '}') then
                     dec(j66);
           if (j66=0) and (s[j]='i') then
                   begin
                    if char_not_in_az(s[j+2]) and (s[j+ 1]='f') then
                      begin
                        k88:= j;
                        //������if then ʱ��������ʱ����pop����
                        game_bg_music_rc_g.temp_mg_pop:= game_bg_music_rc_g.mg_pop;
                        game_bg_music_rc_g.mg_pop:= true;
                        if form1.game_functions_m(copy(s,j+3,find_then(j)-j-3))<> 0 then
                           is_if:= 1
                            else
                              is_if:= 0;
                       game_bg_music_rc_g.mg_pop:= game_bg_music_rc_g.temp_mg_pop;
                       exit;
                      end;
                   end;
         end;
      end;
     function find_else(i2: integer): integer;
       var j3,j4: integer;
      begin
        j4:= 0;
        find_else:= -1;
        for j3:= i2 to length(s)-4 do
         begin
           if (s[j3]='i') and (s[j3+1]='f')and char_not_in_az(s[j3+2]) then
              inc(j4) //����if ���λ��һ
              else if char_not_in_az(s[j3-1])and(s[j3]='e') and (s[j3+1]='n')and (s[j3+2]='d') then
               begin
                 dec(j4); //����end ���λ��ȥһ
                 if j4=0 then
                    exit;
                end  else if (s[j3]='e') and (s[j3+1]='l')and (s[j3+2]='s')and
                           (s[j3+3]='e')and char_not_in_az(s[j3+4]) then
                         begin
                           if j4= 1 then //�����if endƥ�䣬��ô���else�кŷ���
                            begin
                             find_else:= j3;
                             exit;
                            end;
                         end;
         end;
      end;
      function up_one(i2: integer): integer;
       begin
        if i2< 1 then
         result:= 1
         else
          result:= i2;
       end;
      function find_end(i2: integer): integer;
        var j3,j4: integer;
      begin
        j4:= 1;
        find_end:= -1;
        for j3:= i2 to length(s)- 2 do
         begin
           if(s[j3]='i') and
             (s[j3+1]='f') and char_not_in_az(s[j3+2]) then
              inc(j4) //����if ���λ��һ
              else if char_not_in_az(s[up_one(j3-1)]) and (s[j3]='e') and
                     (s[j3+1]='n')and (s[j3+2]='d') then
                         begin
                           dec(j4); //����end ���λ��ȥһ
                           if j4= 1 then //�����if endƥ�䣬��ô���else�кŷ���
                            begin
                             find_end:= j3;
                             exit;
                            end;
                         end;
         end;

        end;

begin
k88:= 0;
     case is_if(1) of
    // -1:
     0: begin
         //�ҵ�if ��������Ϊfalse ��ô����then ��else����end������
         k:= find_else(k88);
         k2:= find_end(k88);
         if k<> -1 then
            delete(s,k2,3); //�������else����ôԤ��ɾ��end
            
         if k= -1 then
           k:= k2-1; //���else�����ڣ���ô�͵�endΪֹ
                     //��ȥһ����Ϊend��else��һλ

            delete(s,k88,k-k88+4); //ɾ��elseǰ�����endǰ������

            s:= trim(s);  //�����ͷ�Ŀո�
           clean_if_then(s); //�ٴβ��ң��������if��䣬��ݹ����
           
        end;
     1: begin
         //�ҵ�if��������Ϊ�棬��ô�Ͷ���else ���������
          k:= find_else(k88);
          k2:= find_end(k88);
          if k > 0 then
           begin
            delete(s,k,k2+3-k);  //�������else ɾ��else���������
           end else delete(s,k2,3);

          delete(s,k88,find_then(k88)+4 -k88); //ɾ��if
           s:= trim(s);  //�����ͷ�Ŀո�
           clean_if_then(s); //�ٴβ��ң��������if��䣬��ݹ����
        end;
      end; //end case

end;

procedure TData2.function_re_string(var s: string); //����Ҫ�ַ����ĺ������з���ֵ�滻
var k,k_end: integer;
    i,t,k2: integer;
    ss: string;
begin
   t:= 0;
       k:= FastPos(s,'game_',length(s),5,1);  //�����Ƿ�����Ҫ���еĺ���
   k2:= k;
   while k > 4 do
    begin
     inc(t);
     if t> 900 then
       exit;  //��ֹ��ѭ��


     if (s[k-4]='r') and (s[k-3]='u') and (s[k-2]='n') and (s[k-1]=' ') then
      begin
      k_end:= 0; //�������
      for i:= k to length(s) do
         if s[i]= '(' then
            inc(k_end)
             else if s[i]= ')' then
                  begin
                   dec(k_end);
                   if k_end= 0 then
                      begin
                       k_end:= i;
                       break;
                      end;
                  end;
      if k_end > k then
       begin
              ss:= copy(s,k,k_end- k+1);
              form1.Game_action_exe_A(ss);
              delete(s,k-4,k_end-k+5);
              k2:= k-5;
              if s<> '' then
                if s[length(s)]= ';' then
                   delete(s,length(s),1);
       end;
       end else if (s[k-4]='i') and (s[k-3]='n') and (s[k-2]='g') and (s[k-1]=' ') then
             begin
     k_end:= 0; //�������
      for i:= k to length(s) do
         if s[i]= '(' then
            inc(k_end)
             else if s[i]= ')' then
                  begin
                   dec(k_end);
                   if k_end= 0 then
                      begin
                       k_end:= i;
                       break;
                      end;
                  end;
      if k_end > k then
       begin
       // if k_end= length(s) then
       //  s:= ss
       //  else begin
              ss:= copy(s,k,k_end- k+1);
              ss:= pchar( form1.Game_action_exe_A(ss));
                if (s[k-7]='e') and (s[k-6]='x') and (s[k-5]='e') then
                      begin //�Ըô������if then ����
                       if ss<> '' then
                          ss:= explain_scene_html(ss);
                      end;
                      
              delete(s,k-7,k_end-k+8);
              k2:= k-8;

              if s<> '' then
                if s[length(s)]= ';' then
                   delete(s,length(s),1);

                   
               insert(ss,s,k-7);
               inc(k2,length(ss)); //�ٴ�������������ȡ�õ��ַ�
            //  end;
       end;

                             end; //end if(s
      k:= FastPos(s,'game_',length(s),5,k2+1);
      k2:= k;
    end; //end while

end;

function TData2.function_re_string2(s: string): string;
begin
     function_re_string(s);
     result:= s;
end;
function get_ip(const ahost: string): string;
 begin
 result:= '61.135.218.26';
{
var
  pa: PChar;
  sa: TInAddr;
  Host: PHostEnt;
  function TInAddrToString(var AInAddr): string;
   begin
  with TInAddr(AInAddr).S_un_b do
  begin
    result := IntToStr(Ord(s_b1)) + '.' + IntToStr(Ord(s_b2)) + '.' +
      IntToStr(Ord(s_b3)) + '.'
      + IntToStr(Ord(s_b4));
  end;
  end;
begin
  Host := GetHostByName(PChar(AHost));
  if Host = nil then
  begin
    result:='220.181.9.13';
    yodao_error_count:= 5;
  end
  else
  begin
    pa := Host^.h_addr_list^;
    sa.S_un_b.s_b1 := pa[0];
    sa.S_un_b.s_b2 := pa[1];
    sa.S_un_b.s_b3 := pa[2];
    sa.S_un_b.s_b4 := pa[3];
    result := TInAddrToString(sa);
  end;
      }
end;

procedure TData2.DataModuleCreate(Sender: TObject);
begin
// ShellChangeNotifier1.Root:= game_app_path_G+ 'lib\';
Game_guai_list_G:= Tstringlist.Create;
fillchar(Game_goods_Index_G,1024,$FF);

  if FileExists(game_doc_path_G+'save\bg_img.txt') then
   begin
    bg_img_filelist_g:= tstringlist.Create;
    bg_img_filelist_g.LoadFromFile(game_doc_path_G+'save\bg_img.txt');
   end else game_bg_music_rc_g.bg_img:= false;

  if FileExists(game_doc_path_G+'save\bg_music.txt') then
   begin
    bg_music_filelist_g:= tstringlist.Create;
    bg_music_filelist_g.LoadFromFile(game_doc_path_G+'save\bg_music.txt');
   end else game_bg_music_rc_g.bg_music:= false;
          {
       if game_bg_music_rc_g.yodao_sound then
           begin
            form_show.show_info('����������90% ��ʱ��������ȴ�');
             try
             data2.IdUDPServer1.DefaultPort:= 21124+ random(30000);
             data2.IdUDPServer1.Active:= true;  //�����е�udp�˿�����
            except
             data2.IdUDPServer1.DefaultPort:= 31124+ random(30000);
             data2.IdUDPServer1.Active:= true;  //�����е�udp�˿�����
            end;
            yodao_udp_host:= get_ip(yodao_udp_host);  //ȡ����������
           end;
           }
end;

function TData2.rep_game_goods_type_s(const s: string;
  tp: Tgame_goods_type; sub: string): string;
var
      j: Tgame_goods_type;
      k,n: integer;
begin
result:= '';
 n:= 1;
   for j:= goods_name1 to high(Tgame_goods_type) do
    begin

      k:= fastcharpos(s,',',n);
      if (j= tp) then
       begin
       if result<> '' then
        result:= result+','+ sub
        else
          result:= sub;
       end else begin
                 if result<> '' then
                    result:= result+ ','+ copy(s,n,k-n)
                    else
                     result:= copy(s,n,k-1);
                end;
       n:= k+ 1;
    end;

end;


function TData2.get_bg_img_filename(s: string): string;
begin
  if not Assigned(bg_img_filelist_g) then
    begin
     result:= '<body>';
     exit;
    end;

   if game_bg_music_rc_g.bg_img_radm then
      game_bg_music_rc_g.bg_img_index:= Random(bg_img_filelist_g.Count)
      else inc(game_bg_music_rc_g.bg_img_index);

      if game_bg_music_rc_g.bg_img_index>= bg_img_filelist_g.Count then
         game_bg_music_rc_g.bg_img_index:= 0;

      if bg_img_filelist_g.Count= 0 then
       begin
        result:= '<body>';
        exit;
       end;

   //gpic://144,29,(����,134,22,{Bold},{clWindowText}),clWindow,zhumu.jpg,AT1000,0,0/2007.bmp
   //<BODY style="background:url($apppath$img\wuzou.jpg) fixed no-repeat center center;">
   if s= '' then
      s:= bg_img_filelist_g.Strings[game_bg_music_rc_g.bg_img_index]
      else if  Game_is_reload=false then //��������ʱ����
          down_http.Create(get_down_img_url,'',(temp_sch_key_g<>''));

      
    s:= StringReplace(s, '\', '/', [rfReplaceAll]);
   if game_bg_music_rc_g.bg_tm= 0 then
   result:= '<BODY style="background:url('+ s +') fixed no-repeat center center;">'
   else
    result:= '<BODY style="background:url(gpic://1,1,(����,134,22,{Bold},{clWindowText}),clWindow,'+
       s
      +',AT1000,0,'+inttostr(game_bg_music_rc_g.bg_tm)+'/2007.bmp) fixed no-repeat center center;">';

end;
       {
procedure TData2.IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
  var ss: string;
begin             //
 yodao_time:= 0; //�ָ������ݵ���־  �е��ʵ�ʹ��udpͨѶ
aData.Seek(0, 0);
 SetLength(ss, AData.Size);
 AData.Read(ss[1], AData.Size);

  if ss<> '' then
   begin
    ss:= copy(ss,pos('speach":"',ss)+9,128);
    ss:= copy(ss,1,pos('"',ss)-1);
   end;

   if mp3_yodao1.Suspended then
    begin
   mp3_yodao1.Tcp_path:= StringReplace(yodao_tcp_g,'$wordid$',ss,[]); //���ص�url
  // mp3_yodao1.file_name:= StringReplace(ss,'/','',[]); //���ص��ļ��������ʶ���������
   mp3_yodao1.Resume;
    end; //����߳��������أ���ô����
end;
            }
procedure TData2.ShellChangeNotifier1Change;
begin
  //�дʿ�ı��ˡ� �������Ѿ�����  ����������
   game_lib_change; //�ʿ�ı���
end;

end.

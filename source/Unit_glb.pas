unit Unit_glb;
interface

uses
  SysUtils, Classes,RakNetStruct;

  const
  pl_count_c= 1024;
  net_port_c= 30806;
  clinet_port_c= 30805;

 g_cmd_buf_count= 63; //���������
 g_str_buf_count= 63; //�������ݻ�������
 g_user_id_buf_count= 63; //����id��������
 g_nil_user_c= $FFFF; //�����ڵ��û�

 //���������֡���������������������������������������

  g_scene_chg_b_c=1;   //�Ķ������¼�bool��data1�����˳���id���辭�����㣬һ��integer������30��boolֵ��data2����ֵ

  g_scene_chg_i_c=2;  //�Ķ������¼�integer��data1����id��data2ֵ
  g_wupin_chg_c=  3;  //�Ķ���Ʒ�¼���data1����Ʒ�¼���ţ��辭�����㣬һ��integer������30��ֵ��data2����Ʒ�¼�ֵ��bool����
  g_persona_chg_c=4;   //�Ķ��������ԣ��������������ӽ�Ǯ�ȣ�cmd��ʾ�������Ա�ţ�data1��ʾԭֵ data2��ʾ������ֵ��Ϊ��ֱ������
  g_page_chg_c=   5;   //�л������ڵ�ҳ�� data1����ҳ��ֵ


  g_player_exit_c=   6;   //����˳���data1��ʾ���˳���144
  g_player_login_c=  7; //��ҵ�¼--�����ݣ�������¼id�����룬�ͻ��˰汾��
  g_player_reg_c=    8;  //���ע�ᣬ�޸�--�����ݣ�������ע����Ϣ���� | �ָ�
  g_nicheng_chg_c=   9;   //����޸����ǳƣ�������
  g_icon_chg_c=      10;  //��Ҹ�����ͷ������4�ֽڱ�����id�����������

  g_xiaodui_cj_c=    11;  //��Ҵ�����С�ӣ������ݣ�������ҵ�¼id��С������ �߶� 1��2��3��ʾС�ӣ���֯������ ***ע

  g_xiaodui_jr_c=    12;  //��Ҽ�����С�ӣ�cmd=1С�ӣ�2��֯��3���ң�data1��ʾs_id��data2��ʾС����֯���
  g_xiaodui_js_c=    13;  //��ҽ�ɢ��С�ӣ�cmd=1С�ӣ�2��֯��3���ң�data1��ʾs_id��data2��ʾС����֯���
  g_xiaodui_tc_c=    14;  //����˳���С�ӣ�cmd=1С�ӣ�2��֯��3���ң�data1��ʾs_id��data2��ʾС����֯���

  g_xiaodui_td_c=    15;  //��ұ��ӳ��߳���С�� data1Ϊ1��2��3������С�ӣ���֯�����ң�data2��ʾ��֯id ********** ע

  g_xiaodui_sz_c=    16;  //��ұ�����Ϊ�ӳ������4�ֽڱ������id�������С�ӱ��

  g_zhuzhi_cj_c=    17;  //****************************************************�޸��� dwjh����ֵ
         {dwjh ��cmd˵����1=�޸��˶�Աģʽ��2=������µļ���3=�������µļ��� data1��ʾsid��data2��ʾ�µ���ֵ}

  g_xiaodui_sid_c=    18;  //���������С��������Աsid

  g_pl_data_chag=    19;  //��ҽ����޸������߶�̬���ݣ���ת��֪ͨ data1��1��9��ʾ�ӵ�ǰҳ�����ҵȼ���data2����
  g_dwjh_zf9_c=    20;  //ת����9����ң����������9��sid

  g_zhuzhi_td_c=    21;  //����޸������ƣ���ע���������ĸ��ֽڣ��߶�Ϊ1��2��3���Ͷ�Ϊs_id************************ ע

  g_zhuzhi_sz_c=    22;  //��ұ�����Ϊ�ϴ󣬽�msg���ͣ�data1ָ���˱��޸ĵ�id��data2ָ������֯id��ֻ���ϴ�����������ϴ�
  g_zhuzhi_sz2_c=   23;  //�������֯�ڵĵȼ����޸ģ���msg���ͣ�data1ָ���˱��޸ĵ�id��data2���µĵȼ���

  g_guojia_cj_c=    24;  //**************************************************************��Ų����
  g_guojia_jr_c=    25;  //��Ҽ����˹��ң����4�ֽڱ������id������ǹ��ұ��
  g_guojia_js_c=    26;  //��ҽ�ɢ�˹��ң�ֻ�й������Խ�ɢ�����4�ֽڱ������id�����4�ֽڱ�������֯���
  g_guojia_tc_c=    27;  //����˳��˹��ң����4�ֽڱ������id�����4�ֽڱ����˹��ұ��

  g_guojia_td_c=    28;  //��ұ��ϴ��߳��˹��� *********************ע ��Ų����

  g_guojia_sz_c=    29;  //��ұ�����Ϊ��������msg���ͣ�data1ָ���˱��޸ĵ�id��data2ָ���˹���id��ֻ�й������������¹���
  g_guojia_sz2_c=   30;  //�������֯�ڵĵȼ����޸ģ���msg���ͣ�data1ָ���˱��޸ĵ�id��data2���µĵȼ���

  g_player_isreg_c= 31;  //��ѯ������Ƿ��Ѿ�ע�ᣬ�������ݣ���ҵ�¼id
  g_player_isonline_c= 32; //��ѯ������Ƿ����ߣ��������ݣ���ҵ�¼id
  g_player_need_data_c=33; //�ͻ��������ѯ���ݣ�cmdָ�������Ҫ��ѯ������

  g_rep_zd_c=    34;  //ת�����ݵ�ָ���ˣ���4���ֽ�ָ����һ��id
  g_rep_dw_c=    35;  //������ת������8���ֽڱ�ʾ4��id
  g_rep_ddww_c=  36;  //���͵�ָ�����飬��4���ֽ�ָ���˶���id
  g_rep_all_c=   37;  //���͵���������������
  g_rep_gj_c=    38;  //���͵����������ڣ���4���ֽ�ָ���˹���id
  g_rep_zz_c=    39;  //���͵�ָ����֯����4���ֽ�ָ������֯id
  g_rep_jz_c=    40;  //���͵�ָ������
  g_rep_page_c=  41;  //���͵���ǰҳ���������
  g_rep_dwjh_z_c=  42;  //ת����ָ����֯����߳��٣�С�Ӹ��ӳ�����֯��90���ϵȼ������Ҹ�70���ϵȼ�
  g_rep_dw_w_c=    43;  //��д��������ת������8���ֽڱ�ʾ4��id *********************
  g_server_gonggao_c= 44; //���ͷ���������
  g_change_wupin_C= 45; //�Ķ���Ʒ����
  g_rep_dw_W_page_c=    46;  //��ҳ��������ת������8���ֽڱ�ʾ4��id *********************

  g_player_rq_c=    47;   //���������������
  g_wupin_rq_c=     48;   //���������Ʒ���ݣ�����ʱ
  g_secne_rq_bl_c=     49;   //������󳡾�bool����
  g_scene_rq_int_c= 50;      //������󳡾�intֵ
  g_guojia_page_rq_c= 51;     //����������ҳ������
  g_rep_online_page_data_c=52;  //����ǰҳ�������������ϸ����
  g_rep_dwjh_c=    53;  //������������֯����ϸ����
  g_rep_guai_c=    54; //��ȡ������

  (*�Ķ���Ʒ��Tmsg_cmd_send ����
s_id �������ĸ�id���ӷ������б�ȡ����Ӧ���û���¼����Ȼ���޸�
data1��������Ʒ�ı�ţ���Ʒ��ԭʼ����
data2��������Ʒ��������   *)

 //�ͻ��˲���******************************************************************************

  g_rec_cmd_c=    55;    //�յ��������˷��صĲ�ѯ���ݻ��߷�������ָ�cmdָ��������
  g_rec_cmd_dw_c=    56;    //�յ��������ݸı�ָ��
  g_rec_nc_dw_c=    57;    //�յ������ǳƸı�ָ��

  g_rec_login_c=  58;    //������������Ϣ��data1ָ���� 1��¼�ɹ���2��¼���ܾ���δͨ����ˣ�3������Ա��ֹ��4�ͻ��˰汾���ͣ�5������������6δ֪�ľܾ�����
  g_rec_kick_c=   59;    //���������߳���data1=1,����Ա�߳���2������ң�3��Ʒԭʼ���ݲ�һ�£��������� 4,����ԭ��
  g_rec_reg_c=    60;    //ע����Ϣ��data1=1��ע��ɹ���2ע��ʧ����ͬ�����ڣ�3ע��ʧ�ܣ�f��������ֹע�ᣬ4������ԭ��
                             //cmd= 1,����ע����Ϣ��cmd=2�����ش���dwjh��Ϣ

  g_rec_reg_cx_c= 61;    //����Ƿ��ע���ѯ����  data1=1������ע�ᣬ2=����ע�ᣬ�������ر�ע�ᣬ3��id�Ѿ�����
  g_rec_chat_c=   62;    //�������ݣ�����4���ֽ�ָ�������Ե�id���ı���
  g_rec_note_c=   63;    //֪ͨ��ͨ����ı���������ʾ������� http�������������
  g_rec_icon_c=   64;     //�յ���ͷ�����ݣ�����id���������
  g_rec_player_cmd_c= 65; //�յ������ͻ��˷��������� cmd��������

  g_req_player_cmd_c= 66; //�����ͻ����������ݣ�cmdָ������Ҫ����������
  g_rec_page_chg_c= 67; //����ҽ�������˳���ҳ��
  g_rec_page_data_c= 68;  //�յ������������������id����
  g_rec_role_act_c= 69;   //�յ����ﶯ������ֵ���������ݣ���ʼ����
  g_rec_kongzhi_c=  70;   //�յ��˿���ָ�������ǰ��ÿ���Ȩ������


//�ͻ��ˣ�cmd����
 g_cmd_zhuzhi_q=0; //���������֯
 g_cmd_zhuzhi_jr=1; //��������֯
 g_cmd_guojia_q=2; //����������
 g_cmd_guojia_jr=3; //�����˹���
 g_cmd_a_game=4; //Ҫ��������
 g_cmd_game_ok=5; //���������
 g_cmd_a_pk=6;     //Ҫ�����pk
 g_cmd_pk_ok=7;    //ͬ�����pk
 g_cmd_a_jingsai=8;  //Ҫ����뾺��
 g_cmd_jingsai_ok=9;   //ͬ����뾺��
 g_cmd_icon_need=10;
 g_cmd_shu_need=11;
 g_cmd_pk_sl=12;        //pkʤ��
 g_cmd_pk_sb=13;        //pkʧ��
 g_cmd_jingsai_sl=14;    //����ʤ��
 g_cmd_jingsai_sb=15;     //����ʧ��
 g_cmd_dj_xg=16; //***************�ȼ��޸�
 g_cmd_page=17; //����ҳ��
 g_cmd_zhandou=18; //����ս��-pk
 g_cmd_bishai=19; //�������
 g_cmd_pop=20; //����������ҳ��--���Զӳ��������
 g_cmd_pop_a=21;  //�п�ʼЧ���ı����� --���Զӳ�
 g_cmd_pop_pk=22;   //��� --���Զӳ�
 g_cmd_pop_pk_a=23;    //�п�ʼЧ���Ĵ�� --���Զӳ�
 g_cmd_pop_game=24;   //����  --���Զӳ�
 g_cmd_gg_shibai=25;         //����Ϊ��ָ��������ȫ����ʧ�ܣ�����Է�ս����
 g_cmd_exit=26;       //����˳������
 g_cmd_xiaodui_sid=27;    //�յ�����������������С�Ӷ�Ա��data1��2���ֱ�洢��4��sid
 g_cmd_dwjh_exit=28;    //����˳���С�ӣ���֯������
 g_cmd_dj_xd_r=29;    //�Ƿ������޸�С�Ӹ���ģʽ **
 g_cmd_pop_wak=30;     //�ڿ�
 g_cmd_pop_caiyao=31;           //��ҩ
 g_cmd_res_a=32;
 g_cmd_res_d=33;
 g_cmd_res_r=34;
 g_cmd_res_rr=35;
 g_cmd_wupin=36;         //��Ʒ���ܣ�
 g_cmd_wupin_qingkong=37;     //�����Ʒ
 g_cmd_wupin_xiugai=38;        //�޸���Ʒ����
 g_cmd_wupin_r=39;             //Ҫ���ȡ��Ʒ����
 g_cmd_wupin_rr=40;            //���ص���Ʒ����
 g_cmd_my_atc=41;             //�ҷ�����
 g_cmd_my_wufa =42;           //�ҷ�������Ʒ
 g_cmd_my_shu=43;             //�ҷ������޸�
 g_cmd_guai_atc=44;           //�ֹ���
 g_cmd_guai_wufa=45;          //�ַ�����Ʒ
 g_cmd_my_bl=46;              //�ҷ�����ֵƮ��
 g_cmd_guai_bl=47;             //�ַ�Ʈ��
 g_cmd_my_dead=48;              //�ҷ���������
 g_cmd_guai_dead=49;            //������
 g_cmd_game_over=50;            //��Ϸ����
 g_cmd_win=51;                  //ս��ʤ��
 g_cmd_chg_m=52; //�޸Ľ�Ǯ
 g_cmd_cl_m=53;   //��ս�Ǯ
 g_cmd_r_m=54;   //Ҫ���ȡ��Ǯ
 g_cmd_rr_m=55;   //���صĽ�Ǯֵ
 g_cmd_guangbo= 56; //�㲥��ѯ��ң����ص�¼��Ϣ��
 g_cmd_ip= 57; //Ҫ�󷵻��Լ��Ĺ���ip
 g_cmd_ip_rr= 59; //�������Լ���ip
 g_cmd_redirect_ip= 60; //�Ӷ���������������ַ

type
  PRakPlayerID= ^TRakPlayerID;

  Tnet_user_id_exchg= packed record  //�û�id
   Id: integer; //���Է�������һ��idֵ����ʾһ��Ψһ���û�
   u_id: string[32];     //����id
   nicheng: string[48];
   duiwuid: integer;
   duiwudg: integer;
   zhuzhiid: integer;
   zhuzhidg: integer;
   guojiaid: integer;
   guojiadg: integer;
   dengji: integer;
   end;

   T_play_id= packed record  //playerid�ṹ
    addr: cardinal;
    port: word;
    end;

  Pmsg_cmd_send= ^Tmsg_cmd_send;
  Tmsg_cmd_send=packed record
   cmd: integer;
   data1: integer;
   data2: integer;
   s_id: word;  //������id
   crc: word;//crc
   end;
  Tmsg_cmd_pk= packed record  //����־ͷ�����ݰ�
    hander: integer;
    pak: tmsg_cmd_send;
    end;

  Tmsg_cmd_pk2= packed record  //��ת�����ܵ����ݰ�
    hander: integer;
    hander2: integer;
    pak: tmsg_cmd_send;
    end;

   Tmsg_cmd_pk3= packed record  //ת����ָ���˵����ݰ�
    hander: integer;    //ת����ʶ
    id: integer;       //���շ�id
    hander2: integer;  //���շ����ݱ�ʶ
    pak: tmsg_cmd_send;
    end;

   Tmsg_duiwu_cmd= packed record
    duiyuan: array[0..3] of word; //�������4����Աid
    pak: tmsg_cmd_send;
    end;
    
  Tmsg_duiwu_cmd_pk= packed record
    hander: integer;
    duiyuan: array[0..3] of word; //�������4����Աid
    pak: tmsg_cmd_send;
    end;

  Tmsg_duiwu_cmd_zf_pk= packed record //�������4����Աid ��ֱ��ת��
    hander: integer;
    duiyuan: array[0..3] of word;
    hander2: integer;
    pak: tmsg_cmd_send;
    end;
  Tmsg_duiwu_cmd_zf9_pk= packed record //�������9����Աid ��ֱ��ת��
    hander: integer;
    duiyuan: array[0..8] of word;
    hander2: integer;
    pak: tmsg_cmd_send;
    end;

   //��Ϸ��������
   Tplayer_type=packed record
    nicheng: string[48];
    guanzhi: string[32];
    hdata: array[0..13] of integer; //ͷ������
    player_data: array[0..161] of integer; //��������
    end;
    Tplayer_type_pk=packed record
     hander: integer;
     tp: Tplayer_type;
     end;
   //��Ϸ��Ʒ����
   Tgame_wupin=packed record
    wupin: array[0..253] of integer;  //��Ʒ���ֻ��1012��
    end;
   Tgame_wupin_pk=packed record
    hander: integer;
    tp: Tgame_wupin;
    end;

    //��Ϸ��������ͷ
    Tplayer_head=packed record
     duiwu_id: integer;
     duiwu_dg: integer; //=0��Ա������ģʽ��=1��Ա����ģʽ��=2��Ա����ָ���,=100���
     zhuzhi_id: integer;
     zhuzhi_dg: integer;
     guojia_id: integer;
     guojia_dg: integer;
     duiyuan: array[0..3] of word; //�ĸ���Ա
     kongzhiquan: word;  //��ǰ����Ȩ
     tag: word;
     guanzhi: string[32];
     end;

    Tdwjh_type=packed record
     dwid: integer;
     p_id: string[32]; //����
     p_name: string[32];  //С�ӻ�����֯������
     p_rk: integer;
     p_sl: integer;    //��ֵС��100����ʾ���ҵ�˰�ʣ�����100С��1000����ʾ������֯������1000��ʾС��
     p_ms: string[255];
     end;

     {�����������ֵ���ݰ�}
    Tgame_cmd_dh=packed record                   //������
      fq_sid: word;   //����sid
      js_sid: word;    //���ܷ����ܹ�������sid �����ֵΪ $FFFF ��ʾȫ��
      fq_m: word;
      fq_t: word;   //�����飬���𷽴��͵�����ֵ
      fq_l: word;
      js_m: smallint;   //���ܷ����͵��ǲ�ֵ
      js_t: smallint;
      js_l: smallint;
      js_g: smallint;
      js_f: smallint;
      js_shu:smallint;
      flag: word;    //���ͣ�ָ����0�޶�����1����������2����������3��Ʒ������4��Ʒ�ָ���5�����ָ���6,��7�ӣ�8���������
      wu: word;  //����������Ʒ�ı��
      end;

    Tgame_cmd_dh_pk=packed record
    hd: integer;
    pk: Tgame_cmd_dh;
    end;

    Tgame_cmd_dh_pk_dfxd=packed record //ת����ָ��С�ӵİ�
    hd: integer;  //ת����־
    xdid: integer; //С��id
    hd2: integer; //����־��ָ������ĳ���
    pk: Tgame_cmd_dh;
    end;

    Tgame_cmd_dh_pk_ben_xd=packed record //ת������С�ӵİ�
    hd: integer;  //ת����־
    duiyuan: array[0..3] of word; //С�Ӷ�Աsid
    hd2: integer; //����־��ָ������ĳ���
    pk: Tgame_cmd_dh;
    end;

    Tgame_cmd_dh_pk_shuang_xd=packed record //ת��������С�ӵİ�
    hd: integer;  //ת����־
    duiyuan: array[0..8] of word; //С�Ӷ�Աsid
    hd2: integer; //����־��ָ������ĳ���
    pk: Tgame_cmd_dh;
    end;

     Tnet_guai=packed record
      sid: word;       //��������Ĺ֣�sid
      ming: integer;  //������ǰֵ
      ti:   integer;
      ling: integer;
      ming_gu: integer;  //������
      ti_gu:   integer;
      ling_gu: integer;
      shu:  integer;
      gong: integer;
      fang: integer;
      L_fang:word; //��ʱ����ֵ
      end;
    T_loc_guai=packed record
      name1: string[32];
      fa_wu: integer;  //����������Ʒid
      wu_shu: integer;    //�����ʩ����Ʒ����ô��Ʒ����
      wu_diao: integer;    //�������Ʒ
      wu_diao_shu: integer;  //������Ʒ������
      wu_diao_gai: integer;   //������Ʒ�ĸ���
      qian: integer;           //����Ľ�Ǯ
      qian_diao_gai: integer;   //�����Ǯ�ĸ���
      jingyan: integer; //����
      icon: integer;
      end;
  TColor4 = array[0..3] of Cardinal;
function CRC16_std(InitCrc: Word; Buffer: PChar; Length: Integer): Word;
function CRCInfo(const asInfo: string): string;
function integer_to_byte(i: integer; var b: boolean): byte; //��鲢������ֵ�����У�鲻ͨ�������� 0
function byte_to_integer(bt: byte;b: boolean): integer; //�ϳɴ�У��� b��ʾ�Ƿ�ѹ��

implementation

function integer_to_byte(i: integer; var b: boolean): byte; //��鲢������ֵ�����У�鲻ͨ�������� 0
var
    i2: integer;
begin
  i2:= i shl 8;
  i2:= i2 shr 24;
  b:= i2= 1;  //1 ��ʾѹ��

  i2:= i shr 24;
  i:= i shl 16;
  i:= i shr 16;
  if i = (i2 div 2 +189) then
    result:= i2
    else
     result:= 0;

end;

function byte_to_integer(bt: byte;b: boolean): integer; //�ϳɴ�У��� b��ʾ�Ƿ�ѹ��
begin
  result:= bt;
  result:= result shl 8;
  if b then
   result:= result + 1;

   result:= result shl 16;

   result:= result + bt div 2 + 189;
end;

function CRC16_std(InitCrc: Word; Buffer: PChar; Length: Integer): Word;
const
  Crc16Table: array[0..$FF] of Word =
  (
    $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241,
    $C601, $06C0, $0780, $C741, $0500, $C5C1, $C481, $0440,
    $CC01, $0CC0, $0D80, $CD41, $0F00, $CFC1, $CE81, $0E40,
    $0A00, $CAC1, $CB81, $0B40, $C901, $09C0, $0880, $C841,
    $D801, $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40,
    $1E00, $DEC1, $DF81, $1F40, $DD01, $1DC0, $1C80, $DC41,
    $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680, $D641,
    $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040,
    $F001, $30C0, $3180, $F141, $3300, $F3C1, $F281, $3240,
    $3600, $F6C1, $F781, $3740, $F501, $35C0, $3480, $F441,
    $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41,
    $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840,
    $2800, $E8C1, $E981, $2940, $EB01, $2BC0, $2A80, $EA41,
    $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1, $EC81, $2C40,
    $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640,
    $2200, $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041,
    $A001, $60C0, $6180, $A141, $6300, $A3C1, $A281, $6240,
    $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480, $A441,
    $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41,
    $AA01, $6AC0, $6B80, $AB41, $6900, $A9C1, $A881, $6840,
    $7800, $B8C1, $B981, $7940, $BB01, $7BC0, $7A80, $BA41,
    $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40,
    $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640,
    $7200, $B2C1, $B381, $7340, $B101, $71C0, $7080, $B041,
    $5000, $90C1, $9181, $5140, $9301, $53C0, $5280, $9241,
    $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440,
    $9C01, $5CC0, $5D80, $9D41, $5F00, $9FC1, $9E81, $5E40,
    $5A00, $9AC1, $9B81, $5B40, $9901, $59C0, $5880, $9841,
    $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81, $4A40,
    $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41,
    $4400, $84C1, $8581, $4540, $8701, $47C0, $4680, $8641,
    $8201, $42C0, $4380, $8341, $4100, $81C1, $8081, $4040
  );

var
  Crc: Word;
begin
  Crc := 0;
  while Length > 0 do
  begin
    Crc := (Crc shr 8) xor CRC16Table[(Crc xor (Byte(Buffer^))) and $00FF];
    Inc(Buffer);
    Dec(Length);
  end;
  Result := Crc;
end;

function CRCInfo(const asInfo: string): string;
var
 wdCRC: Word;
 bytLow, bytHi: Byte;
 M: PChar;
 i: Integer;
begin
  M := PChar(asInfo);
  i := StrLen(M);
  wdCRC := CRC16_std($FFFF, M, I);
  bytLow := Lo(wdCRC);
  bytHi := Hi(wdCRC);
  Result := Chr(bytLow) + Chr(bytHi);
end;
end.

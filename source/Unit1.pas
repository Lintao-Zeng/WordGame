unit Unit1;

interface
  // {$DEFINE game_downbank}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,shellapi, ExtCtrls, ActnList, Menus,mmsystem, ImgList,
  ComCtrls, OleCtrls, Activex,Unit_data, AppEvnts,Unit_player
  {�Ҽ��˵�,IEDocHostUIHandler,IEConst},inifiles, Buttons,Registry,Langji.Wke.Webbrowser,
  Langji.Miniblink.types, Langji.Miniblink.libs,Langji.Wke.types,jpeg;

const
  html_C=   WM_USER + $5101;
  func_C=   WM_USER + $5102;
  event_c1= WM_USER + $5103;
  event_c2= WM_USER + $5104;
  res_c1=   WM_USER + $5105;
  res_c2=   WM_USER + $5106;
  goods_c1=  WM_USER + $5107;
  goods_c2=  WM_USER + $5108;
  page_c1=  WM_USER + $5109;
  page_c2=  WM_USER + $5110;
  stop_c=   WM_USER + $5111;
  player_c1= WM_USER + $5112;
  player_c2= WM_USER + $5113;
  WM_MYTRAYICONCALLBACK = WM_USER + 1002;
type
  //ie ����ʱ���ִ���Ĵ�����*****************************************************
      // Event types exposed from the Internet Explorer interface
  // Event component for Internet Explorer
       {
  TIEEvents = class(TComponent, IUnknown, IDispatch)
  private
     // Private declarations
    FConnected: Boolean;
    FCookie: Integer;
    FCP: IConnectionPoint;
    FSinkIID: TGuid;
    FSource: IWebBrowser2;
  protected
     // Protected declaratios for IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
     // Protected declaratios for IDispatch
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID:
      Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;

     // Protected declarations
    procedure DoOnNavigateError(const pDisp: IDispatch;
                                  var URL: OleVariant;
                                  var TargetFrameName: OleVariant;
                                  var StatusCode: OleVariant;
                                  var Cancel: wordbool); safecall;
  public
     // Public declarations
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConnectTo(Source: IWebBrowser2);
    procedure Disconnect;
    property SinkIID: TGuid read FSinkIID;
    property Source: IWebBrowser2 read FSource;
//  published
     // Published declarations
    property WebObj: IWebBrowser2 read FSource;
    property Connected: Boolean read FConnected;
  end;
          }
  //�����************************************************************************

  TForm1 = class(TForm)
    Button3: TButton;
    Button2: TButton;
    Button4: TButton;
    Button13: TButton;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    ComboBox2: TComboBox;
    ApplicationEvents1: TApplicationEvents;
    Button1: TButton;
    Button5: TButton;
    Button6: TButton;
    PopupMenu3: TPopupMenu;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    Button7: TButton;
    Timer1: TTimer;
    Edit1: TEdit;
    Timer_exe: TTimer;
    Button8: TButton;
    N6: TMenuItem;
    N8: TMenuItem;
    SpeedButton1: TSpeedButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    CheckBox1: TCheckBox;
    Button9: TButton;
    Button10: TButton;
    Timer_duihua: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer_exeTimer(Sender: TObject);
    procedure ComboBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBox2MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Button8Click(Sender: TObject);
    procedure WebBrowser2StatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure N6Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure SpeedButton1Click(Sender: TObject);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure N10Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Timer_duihuaTimer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    //FDocHostUIHandler: TDocHostUIHandler;  //�����Ҽ��˵�
    Phome_id: integer; //�سǵ�scene id
    g_time_count: integer; //��Ϸ����ʱ����ʣ��ʱ��
    g_time_page: integer; //��ʱ����ʱ��ķ���ҳ��
    talkchar1,talkchar2,talkchar3,talkchar4,talkchar5: char;
    Game_temp_event: Tstringlist; //��ʱ�¼���
    game_time_exe_list: Tstringlist; //��ʱִ�к�����
    hot_wordgame_h: integer; //�ȼ�id
    ad_mtl_time: dword; //������ �������ʱ��
    is_down_readlist: boolean;
    game_url: string;

    procedure TrayShow(Sender: TObject); //��ʾ����ͼ��
    procedure WMMyTrayIconCallBack(var Msg : TMessage); message WM_MYTRAYICONCALLBACK;
    procedure Game_action_exe_S(s: string);  //ִ�к��������ܴ�if then
    procedure Game_talk_run(id,role_id: integer); //��ʾ���컰��
    function Game_talk_random(id: integer; const n: string): integer; //����һ�������������䣬�ڶ�����������
    procedure Game_scr_clean2; //˽�Ĵ�������
    procedure Game_scr_clean3; //˽�Ĵ������������
    procedure initialize_role(n: string; new: integer);
    //function game_extfile_rename(oldname,newname: string): boolean; //�޸���������ļ�
    procedure button_stat(b: boolean);
    //function WBLoadFromStream(const   AStream:   TStream;   WB:   TWebBrowser):   HRESULT;
    procedure game_script_message(var msg: TMessage); message game_const_script_after;
    procedure game_reset_role_chatid; //��������id����
    procedure OnContent(const url:String; var Stream:TStream);  //�Զ���Э�鴫�������
    procedure OnAccept(const URL:String;var Accept:Boolean); //�����Զ���Э��

    procedure game_load_image_to_imglist;
    procedure game_page_id_change(new_id: integer); //�����仯
    function wait_scene_int_bool(b: boolean;id: integer): integer; //�ȴ������¼�


    procedure msg_event_c1(var msg: TMessage); message event_c1;  //�յ��˲�ѯ��Ϣ
    procedure msg_event_c2(var msg: TMessage); message event_c2;  //�յ�������
    procedure msg_res_c1(var msg: TMessage); message res_c1;
    procedure msg_res_c2(var msg: TMessage); message res_c2;
    procedure msg_goods_c1(var msg: TMessage); message goods_c1;
    procedure msg_goods_c2(var msg: TMessage); message goods_c2;
    procedure msg_player_c1(var msg: TMessage); message player_c1;
    procedure msg_player_c2(var msg: TMessage); message player_c2;
    procedure msg_page_c2(var msg: TMessage); message page_c2;
    procedure msg_stop_c(var msg: TMessage); message stop_c;

    procedure html_pop(i: integer); //htmlģʽ�ı�����
    procedure change_html_by_id(const id,html: string); //����id����html
    procedure visible_html_by_id(const id: string; canshow: boolean); //����id������ʾ��������
    procedure loadurlbegin(Sender: TObject; sUrl: string;  out bHook,bHandled:boolean);
  public
    { Public declarations }
    pscene_id,old_pscene_id: integer; //��ǰ��ʾ�ĳ���id,ǰһ������id
    web1: TWkeWebbrowser;
    procedure game_start(flag: integer); //��Ϸ��ʼ
    procedure game_save2;
    procedure Game_action_exe(const id: string); //ִ�ж����������������D��ĸ��ͷ����ôֱ��ִ�в���
    function Game_action_exe_A(const F: string): integer; //ִ�ж����ڵĵ�������
    procedure Game_action_exe_S_adv(const s: string);  //ִ�к�������䣬�ɴ�if then
    procedure Game_add_line_to_web2(const s: string);
    procedure game_role_clean; //�����ɫ
    function game_get_roleByNmae(n: string): Tplayer;
    procedure game_load_friend_list(n: string); //�������б�
    procedure game_save_friend_list(n: string); //�������б�
    procedure game_load_doc(path: string);  //����浵������Ϊ�浵Ŀ¼
    procedure game_load_doc_net; //��ʼ�������ļ�
    procedure game_save_doc(path: string);    // ����浵
     procedure game_save_doc_net; //�����������ã�һЩ����
     procedure game_write_scene_event(i,v: integer);  //д�볡����ţ���һ��������ʾ��ţ�1000����Ϊ����ϵͳ��
     function game_read_scene_event(i: integer): integer;   //��ȡ�����ţ���һ��������ʾ��ţ�1000����Ϊϵͳ��
     procedure temp_event_clean; //�����ʱ�¼���
     procedure game_write_home_id; //�ѵ�ǰid��ֵ���سǵ�id
     function game_get_blood_l(id: integer): integer; //��ȡ�����Ѫֵ�͵�
     function game_get_blood_h(id: integer): integer; //��ȡ�����Ѫֵ�ߵ�
     function game_get_ti_l(id: integer): integer;
     function game_get_ti_h(id: integer): integer;
     function game_get_ling_l(id: integer): integer;
     function game_get_ling_h(id: integer): integer;
     function game_doc_is_ok(s: string): boolean; //�жϴ����ļ��Ƿ���Ч����������
     procedure shell_exe(s: string); //�ٴ�ִ�У�������,������Ҫ��ʾ����Ϣ
     procedure game_error_net_user(ip:cardinal;pt: integer); //������󣬶Ͽ����û�������
     procedure game_reshow_net_id(all : boolean); //ˢ��ҳ�������id��ʾ
     procedure debug_send_func_str(const s: string; flag: integer); //���͵���ʱ������Ϣ
     procedure show_ad_error; //����治�ܼ���ʱ��ʾ������Ϣ
     procedure DeleteDirNotEmpty(DirName: string); //���Ŀ¼
     procedure load_sch_pic; //ˢ�����ص�ͼƬ
     procedure update_caption(i: integer); //���±���������������
     function game_create_guid: string;   //����һ��guid
     procedure game_pic_from_text(Stream:TStream; s: string; path: string=''); //�����ַ�������ͼƬ����
  published
    
    function game_show_scene(id: integer): integer; //��ʾ����
    procedure game_cmd_execute(const s: string); //�������
    function game_pop(i: integer): integer;     //���������ʴ���
    function game_pop_love(i: integer; const n: string): integer;     //����ֻ��ʾ�����˵ı����ʴ���
    function game_pop_dig(i: integer): integer;     //�ڿ� Ĭ������Ϊһ��
    function game_pop_fight(i: integer; i2: integer): integer;     //ս������һ���������������ڶ���������������
    function game_pop_game(i: integer; i2: integer): integer;     // ���� ���Է���������������
    function game_page(id: integer): integer;   //�������µ�ҳ�����촰������
    function game_direct_scene(id: integer): integer; //ֱ�Ӷ�ȡҳ�棬���Խű���ת��Ч��
    function game_direct_page(id: integer): integer; //ֱ�Ӷ�ȡҳ�棬���Խű���ת��Ч�������촰������
    function game_infobox(s: string): integer; //����һ����Ϣ��
    function game_trade(id,flag: integer): integer; //���״��� ,flag=0��ʾ��1��ʾ��
    function game_chat(const s: string): integer; //�����촰����ʾһ�仰
    function game_delay(i: integer):integer; //��ʱ����������
    function game_question(s: string): integer;
    function game_goods_change(id,values: integer):integer; //�޸���Ϸ��Ʒ����
    function game_goods_change_n(n: string; values: integer):integer; //�޸���Ϸ��Ʒ����������Ʒ��
    function game_attribute_change(p,id,v: integer): integer;
    //�޸�����ֵ����һ����������ɫ��0��ʾȫ��,1��ʾ��һ�����2�ڶ������ڶ����������Ա�ţ��������������Ӽ�ֵ

    function game_write_name(s: string): integer; //�޸ĵ�ǰ�Ի�������
    function game_save(i: integer): integer; //��Ϸ���̣�0=�ֶ����̣�1=�Զ����̣�2=
    function game_talk(const n: string): integer;  //���죬������ ����
    function game_talk_char_set(c1: string; role_id: integer): integer; //�޸Ľ�ɫ������char
    function game_talk_stop(i: integer): integer; //��������
    function game_npc_talk(const n: string): integer;
    function game_accouter1_wid(i1: integer): integer; //�����������ԣ�װ������
    function game_add_res_event(id: integer): integer; //��Ӽ�ʰ��Ʒ�¼�
    function game_check_res_event(id: integer): integer; // �����Ʒ�¼��Ƿ��������Ƿ���true
     function game_not_res_event(id: integer): integer; // ���鲻���ڣ�����true
                           //���and �����Ʒ�¼��Ƿ�ȫ�����������Ƿ���true
      function game_check_res_event_and(s: string): integer;
                          //���and ���鶼�����ڣ�����true
       function game_not_res_event_and(s: string): integer;
                              //����¼���һ������or
             function game_check_res_event_or(s: string): integer;
                          //���or ������һ�������ڣ�����true
              function game_not_res_event_or(s: string): integer;

    function game_del_res_event(id: integer): integer; // ɾ����Ʒ�¼�
    function game_add_scene_event(id: integer): integer; //��Ӿ����¼�
     function game_check_scene_event(id: integer): integer; // �������¼��Ƿ����� �����ڷ���true
     function game_not_scene_event(id: integer): integer; // ���鲻���ڣ����� true
     function game_inc_scene_event(id:integer; v: integer):integer; //�¼�ֵ�ۼӺ�������Ѳ���ֵ������ԭ�ȱ���������ۼ�,����ֵ��Ϊ1��ʾִ�гɹ�
     function game_dec_scene_event(id: integer; v: integer):integer; //�¼�ֵ�ۼ���������������ԭ�ȱ��������ȥ����,����ֵ��Ϊ1��ʾִ�гɹ�
        //���and �����Ʒ�¼��Ƿ�ȫ�����������Ƿ���true
      function game_check_scene_event_and(s: string): integer;
                          //���and ���鶼�����ڣ�����true
       function game_not_scene_event_and(s: string): integer;
                              //����¼���һ������or
             function game_check_scene_event_or(s: string): integer;
                          //���or ������һ�������ڣ�����true
              function game_not_scene_event_or(s: string): integer;

     function game_write_scene_string(id: integer;const values: string): integer; //д���ַ�����������
     function game_read_scene_string(id: integer): pchar;  //�ӳ������ȡ�ַ���

    function game_del_scene_event(id: integer): integer; // ɾ�������¼�
    function game_prop_enbd(b: integer): integer; //������߽���װ�����԰�ť��0���ã�1����
    function game_add_friend(n: string; new: integer): integer; //���һ������
    function game_del_friend(n: string;b: integer): integer; //ɾ��һ������
    function game_over(i: integer): integer; //��Ϸ����
    function game_random_chance(i: integer): integer; //�ж���������Ƿ�����
                   //�ж���������Ƿ���������ʱ�Բ�����������
    function game_random_chance_at_sleep(i: integer): integer;
    function game_rename(oldname: string): integer; //�޸��������� ��oldnameΪԭ������
    function game_rename_byid(id: integer;const newname: string): integer; //�޸��������� ��oldnameΪԭ������
             //��������Ƿ���Ӣ�ģ����ȣ�����Ϊ�ձ�ʾ������ǣ��ú�����Ҫ��Ϊ��Ϸ����һ����˼��
             //�ú����жϵ�һ���ֽ��Ƿ�Ϊ����ǰ׺�����˶���
    function game_checkname_abc(n: string): integer;
    function game_reload(i: integer): integer; //�������뵱ǰ����
    function game_reload_direct(i: integer): integer; //�������뵱ǰ����,�����Խű���ת��Ч��
    function game_add_message(const s: string): integer;  //���һ����ʾ��Ϣ
    function game_add_task(id: integer): integer;      //�������
    function game_comp_task(id: integer): integer; //�������
    function game_check_goods_nmb(n: string; i: integer): integer; //���ĳ��Ʒ�����Ƿ��м������У����� 1

                 //���ĳ�������ĳ����ֵ�Ƿ�ﵽĳֵ
    function game_check_role_values(n: string; i,v: integer): integer;

              {��ʱ�¼�������ʱ��һ�������볡��ʱ����գ����ǳ�������ע��������ʱ�¼����������Թ��ڣ�}
    function game_write_temp(id,values: integer): integer; //д��һ����ʱ�¼�,id���¼�����values���¼�����
    function game_read_temp(id: integer): integer;  // ��ȡ�¼���ֵ�������ڣ�����0
    function game_write_temp_string(id: integer;const values: string): integer;
    function game_read_temp_string(id: integer): pchar;
    function game_check_temp(id,values: integer): integer; //�Ƚ��¼������Ƿ���ڵ���ָ��ֵ

    function game_enabled_scene(i: integer): integer; // 1,��������ڣ�0�����ó�������
    function game_can_stop_chat(i: integer): integer; //1,���Խ�������  0, ��ֹ�������죨���ڱ��������ȥ�ĶԻ�)
    function game_functions_m(const s: string): integer; //һ��ִ�в����ڶຯ���������ʽ�����
    function game_role_is_exist(n: string): integer; //������������ڣ����� 1
    function game_set_role_0_hide(n: string; x: integer): integer; //����ĳ�������������1��ʾ��0����
    function game_role_only_show(n: string): integer; //����ʾ���ˣ���������ȫ��
    function game_role_reshow: integer; //�ָ�����ԭ�ȵ�����״̬
    function game_bet(id,flag: integer): integer; //��Ǯ������Ϊһ����ʱ��id��ѹ��С��1��0С��Ӯ�˷��� 1
    function game_newname_from_oldname(const n: string): pchar; //����ԭʼ������ȡ�µ���������
    function game_pop_a(i: integer): integer;     //������Ч���ĵ��������ʴ���
    function game_change_money(i: integer):integer; //�޸Ľ�Ǯ
    function game_role_count(c: integer): integer; //��ѯ������������Ϊ�㣬�������������������㣬������ڵ���c������1
    function game_role_sex_count(x: integer): integer; //����ָ���Ա��������������1Ϊ�У�0ΪŮ
    function game_get_newname_at_id(x: integer): pchar; //�������кŷ����µ����֣�1Ϊ��һ����2Ϊ�ڶ���
    function game_get_oldname_at_id(x: integer): pchar; //�������кŷ����µ����֣�1Ϊ��һ����2Ϊ�ڶ���

    function game_goto_home(i: integer): integer; //�س�
    function game_id_is_name(id: integer; n: string): integer; //�жϴ�id�Ƿ�ָ������,����idΪ��ǰrole�б�����к�+1

    function game_sex_from_id(id: integer): integer; //�жϴ�id������Ů��idΪrole�б����š�+ 1���з���1
    function game_sex_from_name(const n: string): integer; //�жϴ���������Ů���з���1
    function game_check_money(v: integer): integer; //�ȶԽ�Ǯ��������ڵ��� v ���� 1
    function game_pop_fight_a(i: integer; i2: integer): integer; //������ս����������
    function game_write_scene_integer(id,v: integer): integer; //��scene�¼���д��һ��ֵ
    function game_read_scene_integer(id: integer): integer;    //��scene�¼����ȡһ��ֵ
    function game_integer_comp(i1: integer; c: string;i2: integer): integer; //��i1��i2���бȽϣ�c��ȡ�ȽϷ����� =,>,<
    function game_chat_cleans(i: integer): integer; //���촰����������������
    function game_chat_cleans2(i: integer): integer; //���촰����������������
    function game_grade(n: string; g: integer): integer; //���������Ƿ���ڵ�������ȼ���
    function game_start_now(i:integer): integer; //��Ϸ��ʼ
    function game_change_sex(n: string; sex: integer): integer;//�����Ա�,sexΪ1��ʾ�У�0��ʾŮ
    function game_get_fm_1(sex: integer): integer; //���ص�һ��ָ���Ա����ţ�1Ϊ��һ��
    function game_id_exist(id: integer): integer; //���ָ����������Ƿ���ڣ�1��ʾ��һ��
    function game_del_friend_byid(a,b: integer): integer; //ͨ��idɾ������
    function game_move_money(id1,id2,m: integer): integer; //ת�ƽ�Ǯ����id1ת�Ƶ�id2��1��ʾ��һ������
    function game_role_all_mtl(p: integer): integer; //������ȫ����p=0��ʾȫ�壬1��ʾ��һ������
    function game_clear_money(i: integer): integer; //��Ǯ��գ�����Ϊ1�����
    function game_get_money(i: integer): integer; //���ؽ�Ǯ,����Ϊ1��ʾ��һ������
    function game_get_role_suxing(i,v: integer): integer; //��������ֵ,����Ϊ1��ʾ��һ�����v��ʾҪȡ�����Ա��
    function game_get_goods_count(n: string): integer; //����ָ�����Ƶ���Ʒ����
    function game_set_game_time(t,page: integer): integer; //������ʱ������ʱ��������ʱ�������ҳ��
    function game_kill_game_time(i:integer):integer; //ȡ����ʱ
    function game_spk_string(const s: string): integer; //�ʶ�
    function game_not_rename(i: integer): integer; //�Ƿ����
    function game_clear_temp(i: integer): integer; //�����ʱ��
    function game_random_chance_2(i: integer): integer; //����һ�������
    function game_get_pscene_id(i: integer): integer; //���ص�ǰҳid�Ͳ������ۼ�ֵ
    function game_role_value_half(id: integer): integer; //����ֵ���� idΪ0��ʾȫ����룬Ϊ1��ʾ��һ������
    function game_get_pscene_id_s(i: integer): pchar; //����ҳ�ţ��ַ���ʽ��id�Ͳ������ۼ�ֵ
    function game_inttostr(i: integer): pchar;  // �������ֵ��ַ���ʽ
    function game_get_read_txt(i: integer): pchar; //����һ���Ķ����ϵ��ַ������������Ϊ�㣬��ʾ��������򷵻�ָ����
    function game_include_str(const s: string): pchar; //��ȡ�����ļ�
    function game_true(i: integer): integer; //����Ϊһ����true������Ϊ�㷵��false
    function game_weather(i: integer): integer; //ָ��ս����������-1�رգ�0�Զ���Ĭ�ϣ� 1����ѩ��2���꣬3��Ҷ��4��Сѩ
    function game_get_accoutre(i,idx: integer): integer; //����װ��ֵ��iΪ1��ʾ��һ�����idx��ʾҪȡ��װ������
    function game_get_TickCount(i: integer): integer; //���ؿ��������ĺ�������������Ϊ1���򷵻���
    function game_get_date(i: integer): pchar; //�������ڣ��ַ��ͣ��������Ϊ�㣬����ϵͳ����
    function game_get_time(i: integer): pchar; //����ʱ�䣬�ַ��ͣ��������Ϊ�㣬����ϵͳʱ��
    function game_get_datetime(i: integer): pchar; //�������ں�ʱ�䣬�ַ��ͣ��������Ϊ�㣬����ϵͳ����ʱ��
    function game_int_datetime(i: integer): integer; //�������ε�����ʱ�䣬��������
    function game_int_date(i: integer): integer; //�������ε����ڣ���������
    function game_int_time(i: integer): integer; //�������ε�ʱ�� ����������
    function game_time_exe(i: integer;const s: string): integer; //��ʱ��������ָ��������ִ������
    function game_webform_isshow(i: integer): integer; //�������Ƿ���ǰ��
    function game_run_off_no(i: integer): integer; //��ֹ���ܣ�0��ʾ��ֹ��1��ʾ����
    function game_write_factor(i: integer): integer; //д������Ѷ�ϵ��
    function game_read_factor(i: integer): integer; //��ȡ�����Ѷ�ϵ��
    function game_allow_gohome(i: integer): integer;   //�Ƿ�����سǣ�1������0��ֹ
    function game_id_from_oldname(const s: string): integer; //�����Ʒ���id������1��ʾ��һ��
    function game_lingli_add(p,t: integer): integer; //�����������ٷֱȣ���һ������Ϊ���ʾȫ�壬��һ��������ʾ�ٷֱ�
    function game_check_role_values_byid(id,id2,values: integer): integer; //���ָ�������id��1��ʾ��һ�����ڶ�����ָ���Ǹ�ֵ
    function game_goto_oldpage(i: integer): integer; //����ǰһҳ��ֻ�ʺ�ֻ��Ψһ��Դ��ҳ��ʹ��
    function game_is_net_hide(i: integer): integer;  //�Ƿ������������ʾ
    function game_show_logon(const ip: string): integer; //��ʾ��¼����
    function game_is_online(i: integer): integer; //�Ƿ�������Ϸ
    function game_show_note(const s: string): integer; //��ʾͨ��
    function game_netuserinfo(i: integer): integer; // �ڶԻ�������ʾ�����Ϣ
    function game_reshow_online(i: integer): integer; //������ʾ��������
    function game_show_dwjh(id,tp: integer): integer; //��ʾ���飬���ң���֯��Ϣ
    function game_show_chat(id: integer): integer; //��ʾ���촰��
    function game_send_pk_msg(id: integer): integer; //����pk����
    function game_show_trade(id: integer): integer; //��ʾ���״���
    function game_send_game_msg(id: integer): integer; //���;�������
    function game_add_user_dwjh(tp,sid,dwjh_id: integer): integer; //ͬ�⣬��Ӵ��û�
    function game_reload_chatlist(i: integer): integer; //�������������б�
    function game_asw_html_in_pop(i: integer): integer; //htmlģʽ�ı�����
    function game_show_set(i: integer): integer; //��ʾ���ô���
    function game_set_var(i,v: integer): integer; //����ָ��������ֵ
    function game_inner_html(i: integer; s: string): integer; //����html
    function game_biao_html(i: integer): integer; //�����
    function game_res_goods(i,sl: integer; const s: string): pchar; //id,���������ơ�����һ����Ʒ�Ƿ�񵽵ı�׼�ַ���
    function game_can_fly(i: integer): integer; //�Ƿ�������У���������
    function game_bubble(bb: integer): integer; //����������������������
    function game_wuziqi(bb: integer): integer; //�����壬�����ǵȼ���1-4���ӵ͵���
    function game_save_count(i: integer): integer; //ȡ�ô浵����
    function game_chinese_spk(const s: string): integer; //�ʶ�����
    function game_chat_spk_add(const s: string): integer; //���һ�仰���ȴ��������б������������
    function game_showshare_readtext(i: integer): integer; //��ʾһ���ϴ���Դ�Ĵ���
  end;


 function game_read_values(id,index: integer): integer;
 function game_write_values(id,index,value: integer): boolean;
 function game_get_role_H: integer; //���ض�Ա��������
 function game_add_player_from_net(p: pointer; c: integer): integer; //�����Ϸ�������ݣ����ǣ�
 procedure game_lib_change; //�ʿ�ı���
 procedure img_zoom(oldbmp,newbmp: tbitmap; new_w,new_h: integer); //�Ŵ���СͼƬ
 function getBilv(i: integer): integer; //��һ����ֵ����dpi_bilv
 function HexToStr(s:ansistring):string; //16����ת�ִ�
var
  Form1: TForm1;
  Game_friend_list: Tstringlist; //����б�
    Game_role_list: Tlist;  //�����б�
    Game_action_list: Tstringlist;
    Game_Chat_list: Tstringlist;
    Game_read_stringlist: Tstringlist;
    Game_pscene_img_list: Tstringlist; //��ǰҳ�Ѿ����ص�ͼƬ����ֹͼƬ�ظ����أ��л�ҳ��ʱ�����
    Game_duihua_list: Tstringlist; //�Ի��ʶ��б�
    game_effect_ini: Tinifile;
    game_hide_windows_h: boolean;
    dpi_bilv: single;
    In_xp_system: boolean;
    //IEEvents1: TIEEvents;
    MyTrayIcon : TNotifyIconData;   //����һ������ͼ�����
    show_share_text: string; //Ԥ��ȡ����ʾ�Ķ��Ĳ���

implementation
  uses unit_save,unit_trade,unit_pop,
  Unit_goods,unit_task,AAFont,GDIPAPI,GDIPOBJ,unit_zj_ly, Unit_set,unit2,
  unit_net,unit_chat,Unit_net_set,unit_download,unit_note,unit_glb,
  unit_dwjh,unit_downhttp,unit_chinese,unit_exit,unit_langdu,unit_mp3_yodao,unit_httpserver,unit_down_tips;
{$R *.dfm}

   const 
 csfsBold      = '|Bold';     
 csfsItalic    = '|Italic';   
 csfsUnderline = '|Underline';
 csfsStrikeout = '|Strikeout';
function getBilv(i: integer): integer; //��һ����ֵ����dpi_bilv
begin
  result:= round(i * dpi_bilv);
end;
procedure img_zoom(oldbmp,newbmp: tbitmap; new_w,new_h: integer); //�Ŵ���СͼƬ
var
  gdibmp: TGPBitmap;
  //hb: HBITMAP;
  //ss: string;
  Graphic: TGPGraphics;
  I: Integer;

begin
  // ͼƬ�Ŵ���С
  if oldbmp.Width=0 then
   exit;

  gdibmp := TGPBitmap.Create(oldbmp.Handle, oldbmp.Palette);

  with newbmp do
    begin
      Width :=new_w;
      Height := new_h;
      PixelFormat := pf24bit;
    end;

     Graphic := TGPGraphics.Create(newbmp.Canvas.Handle);
  Graphic.SetInterpolationMode(InterpolationModeHighQualityBicubic);  // bicubic resample
  Graphic.DrawImage(gdibmp, 0, 0, newbmp.Width, newbmp.Height);

  Graphic.Free;
   gdibmp.Free;
end;
procedure game_lib_change; //�ʿ�ı���
var s: string;
 hFile : THandle; 
 FT,ft2 : TFileTime;
 ST : TSystemTime;
 d,t,d2,t2: word;
begin
  s:= game_app_path_G+'lib\'+ form_pop.combobox1.Text;
  if not FileExists(s) then
     begin
       messagebox(screen.ActiveForm.handle,'��ǰ�ʿⲻ���ڡ�','����',mb_ok or MB_ICONERROR);
     end else begin
             hFile := FileOpen(s, fmOpenRead);
              GetFileTime(hFile, nil, nil, @FT);
              FileClose(hFile);
              
              DateTimeToSystemTime(now, ST);
              SystemTimeToFileTime(ST, FT2);
              LocalFileTimeToFileTime(FT2, FT2);

            FileTimeToDosDateTime(ft,d,t);
            FileTimeToDosDateTime(ft2,d2,t2);
               if (t2- t) < 15 then
                 begin
                   //��ǰ�ʿⱻ�޸�
                  if messagebox(screen.ActiveForm.handle,'��ǰ�ʿⱻ�޸ģ��Ƿ��������롣','ˢ��',mb_yesno or MB_ICONWARNING)= mryes then
                     begin
                      form_pop.wordlist1.Clear;
                      form_pop.wordlist1.LoadFromFile(s);
                     end;
                 end else begin
                             //�ļ��б䶯����������ʿ�
                           // form_pop.show_ck;
                          end;
                  form_pop.show_ck; //��ʾ��ʱ��׼��������ˢ�´ʿ��б�
              end;
end;

function game_add_player_from_net(p: pointer; c: integer): integer; //�����Ϸ��������
var
    i: integer;
    j: integer;
begin
//����������ݳɹ�������1�����򷵻�2

    j:= Game_role_list.Add(Tplayer.Create('net'));

    if j= 0 then //��ʼ������Լ�
    begin
    game_player_head_G.duiwu_id:= Tplayer_type(p^).hdata[3];
    game_player_head_G.duiwu_dg:= Tplayer_type(p^).hdata[4];

     if game_player_head_G.duiwu_dg<>100 then
        begin
        game_player_head_G.duiwu_dg:= 0; //��Ա��ʼ��Ϊ����ģʽ
        game_player_head_G.duiwu_id:= 0; //����С�����µ�¼��Ͳ������ˣ�������С�ӻ��Ǽ�������
        end;

    game_player_head_G.zhuzhi_id:= Tplayer_type(p^).hdata[5];
    game_player_head_G.zhuzhi_dg:= Tplayer_type(p^).hdata[6];
    game_player_head_G.guojia_id:= Tplayer_type(p^).hdata[7];
    game_player_head_G.guojia_dg:= Tplayer_type(p^).hdata[8];
    game_player_head_G.guanzhi:=  Tplayer_type(p^).guanzhi;
       game_player_head_G.duiyuan[0]:= g_nil_user_c;
       game_player_head_G.duiyuan[1]:= g_nil_user_c;
       game_player_head_G.duiyuan[2]:= g_nil_user_c;
       game_player_head_G.duiyuan[3]:= g_nil_user_c;

   end; // end j
     Assert(j<>-1,'��������Խλ');
     Tplayer(Game_role_list.Items[j]).plname:= Tplayer_type(p^).nicheng;
      Game_at_net_G:= false; //��ʼ����������
     for i:= 0 to 161 do
     begin
      case i of
       0..63: Tplayer(Game_role_list.Items[j]).plvalues[i]:= Tplayer_type(p^).player_data[i];  //����
       64..73: Tplayer(Game_role_list.Items[j]).pl_accouter1[i-64]:= Tplayer_type(p^).player_data[i];    //װ��
       74..97: Tplayer(Game_role_list.Items[j]).pl_ji_array[i-74]:= Tplayer_type(p^).player_data[i];       //����
       98..161: Tplayer(Game_role_list.Items[j]).pl_fa_array[i-98]:= Tplayer_type(p^).player_data[i];       //����
       end;
     end;

      Game_at_net_G:= true;  //��ʼ������
  result:= 1;
end;

function game_get_role_H: integer; //���ض�Ա��������
begin

    result:= Game_role_list.Count -1;
end;

function game_read_values(id,index: integer): integer;
begin
result:= 0;
          Assert(id<>-1,'��������Խλ');
           if id < Game_role_list.Count then
            begin
             if Assigned(Game_role_list.Items[id]) then
                result:= Tplayer(Game_role_list.Items[id]).plvalues[index];
            end;

end;

function game_write_values(id,index,value: integer): boolean;
begin
 result:= false;


            if id < Game_role_list.Count then
             begin
             if Assigned(Game_role_list.Items[id]) then
               begin
                Tplayer(Game_role_list.Items[id]).plvalues[index]:= value;
                result:= true;
              end;
             end;

        
end;

//���ַ���ת��Ϊ�����������ԣ�
//sFont�����ĸ�ʽ: ����,134,9,[Bold],[clRed]
procedure StringToFont(sFont : string; Font : TFont );
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
    Charset :=StrToInt2( Copy( sFont, 1, p-1 ) );
    Delete( sFont, 1, p );

    // get font size
    p := Pos( ',', sFont );
    Size :=StrToInt2( Copy( sFont, 1, p-1 ) );
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

function Get_WindowsDirectory: string;
var
    pcWindowsDirectory        : PChar;
    dwWDSize                  : DWORD;

begin
    dwWDSize := MAX_PATH + 1;
    result := '';
    GetMem(pcWindowsDirectory, dwWDSize);
    try
        if Windows.GetWindowsDirectory(pcWindowsDirectory, dwWDSize) <> 0 then
            Result := pcWindowsDirectory;
    finally
        FreeMem(pcWindowsDirectory);
    end;
end;
function Get_SystemDirectory: string;
var
    pcSystemDirectory         : PChar;
    dwSDSize                  : DWORD;
begin
    dwSDSize := MAX_PATH + 1;
    result := '';
    GetMem(pcSystemDirectory, dwSDSize);
    try
        if Windows.GetSystemDirectory(pcSystemDirectory, dwSDSize) <> 0 then
            Result := pcSystemDirectory;
    finally
        FreeMem(pcSystemDirectory);
    end;
end;
procedure TForm1.DeleteDirNotEmpty(DirName: string);
var
 sr: TSearchRec;
 f: integer;
begin
 if DirName[Length(DirName)] <> '\' then
   DirName := DirName + '\';
 f := FindFirst(DirName + '*.*', faAnyFile, sr);
 while f = 0 do
   begin
     if (sr.Name <> '.') and (sr.Name <> '..') then
       begin
         if (sr.Attr and faDirectory <> 0) then
           DeleteDirNotEmpty(DirName + sr.Name + '\')
         else
          // begin
            //  FileSetAttr(DirName + sr.Name, 0);
              if not DeleteFile(DirName + sr.Name) then Exit;
          // end;
       end;
     f := FindNext(sr);
   end;
 FindClose(sr);
 //RemoveDir(DirName);
end;

function GetMyDocPath: string;
var
Reg:TRegistry;
begin
Reg:=TRegistry.Create;
try
Reg.RootKey:=HKEY_CURRENT_USER;
if Reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders') then
Result:=Reg.ReadString('Personal')
finally
Reg.CloseKey;
Reg.Free;
end;
end;

function getDPI(var h1:integer; var h2: integer): integer;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetDeviceCaps(DC, logpixelsx); //��ȡ�߼�dpi�������ϵͳ����������ô��ȡ��ֵ�̶�Ϊ96
  h1:=  GetDeviceCaps(DC, DESKTOPHORZRES); //���������ԣ����ݣ����ĸ�dpi���ã���dpi���������ѡ�� Ӧ�ó�����ô h1��h2��ͬ
  h2:=  GetDeviceCaps(DC, HORZRES);   //���������ԣ����ݣ����ĸ�dpi���ã���dpi���������ѡ�� ϵͳ����ô h2�� h1 С
  ReleaseDC(0, DC);
end;

procedure TForm1.FormCreate(Sender: TObject);
var ss: string;
    k,h1,h2: integer;
begin
  if sametext(TOSVersion.Name,'Windows XP') then
   begin
    self.Caption:= self.Caption+' '+ TOSVersion.Name;
    In_xp_system:= true;

   end;

 Randomize; //��ʼ�������
 // show_inst_game;
    k:= getDPI(h1,h2);
    if h1=h2 then
    begin
     //������Ӧ�ó���ִ��
        if k=96 then
         dpi_bilv:= 1
        else
          dpi_bilv:= k / 96;
     end   else  begin
                  //������ϵͳִ�� ϵͳ����ϵͳ��ǿdpi����Ϊ96
                  //showmessage(k.ToString); ϵͳ�е�ģ�� ϵͳ��ǿ����
                  if k=96 then
                    dpi_bilv:= 1
                    else
                      dpi_bilv:= h1 / h2;
                  showmessage('��ǰ��DPI���õ�����ʾЧ�����ѣ������ڳ���ͼ��������Ҽ������ԡ����ٵ㿪�������ԡ���ǩҳ��Ȼ��'+#13#10
                  +'��win10 ��������ĸ�DPI���á���Ȼ��ȡ����ѡ�������dpi������Ϊ����������ִ��ѡ��Ϊ��Ӧ�ó��򡱣�'+#13#10+
                  '��win7 �빴ѡ�����ø� DPI ��ʾ���š���');
                 end;

     web1:= TWkeWebbrowser.Create(form1);

  web1.Parent:= groupbox5;
  web1.Align:=  alclient;
  web1.OnBeforeLoad := WebBrowser1BeforeNavigate2;
   web1.OnLoadUrlBegin:= loadurlbegin;
  web1.LoadHTML('<html><body><p>��Ϸ�����У����Ժ󡭡�</body></html>');

 //
 game_app_path_G:= ExtractFilePath(application.ExeName);
  ss:= game_app_path_G;

 game_doc_path_g:= GetMyDocPath+ '\����Ϸ������';
  if not DirectoryExists(game_doc_path_g) then
     CreateDir(game_doc_path_g);
  if not DirectoryExists(game_doc_path_g+'\img') then
     CreateDir(game_doc_path_g+'\img');
  if not DirectoryExists(game_doc_path_g+'\scene') then
     CreateDir(game_doc_path_g+'\scene');

  if not DirectoryExists(game_doc_path_g) then
   begin
          CreateDir(game_doc_path_g);
          CreateDir(game_doc_path_g+'\save');
          CreateDir(game_doc_path_g+'\dat');
          CreateDir(game_doc_path_g+'\tmp');
          CreateDir(game_doc_path_g+'\down_img');
          CreateDir(game_doc_path_g+'\down_ugm');
   end;
  game_doc_path_g:= game_doc_path_g+'\'; //·�����б�ܣ��Ա��ֳ�����ͳһ



 Game_app_img_path_G:= game_doc_path_g + 'img\'; //������ϷͼƬ·��


 Game_action_list:= Tstringlist.Create;
  Game_chat_list:= Tstringlist.Create;
  Game_role_list:= Tlist.Create;
  Game_friend_list:= Tstringlist.Create;
  Game_temp_event:= Tstringlist.Create;  //��ʱ�¼���
  game_time_exe_list:= Tstringlist.Create; //��ʱִ�к�����
   Game_read_stringlist:= Tstringlist.Create;
   Game_pscene_img_list:= Tstringlist.Create;
   Game_duihua_list:= Tstringlist.Create; //�ȴ������ĶԻ��б�

 //FDocHostUIHandler := TDocHostUIHandler.Create;

     Game_touxian_list_G:= Tstringlist.Create;
               {
 DynamicProtocol.ProtocolName := 'gpic'; //game picture Э��
  DynamicProtocol.Enabled := True;
  DynamicProtocol.OnGetContent := OnContent;
  DynamicProtocol.OnAccept := OnAccept;
                           }
 game_effect_ini:= Tinifile.Create(ss +'dat\effect.ini');


    hot_wordgame_h:= GlobalAddAtom('wordgame_H');

    try
     RegisterHotKey(Handle,hot_wordgame_h , mod_alt or MOD_CONTROL, ord('D')); //ע��D��
    except

    end;

  // IEEvents1:= TIEEvents.create(application);
    // IdHTTPServer1.Active:= True;

 {  httpserver1:= Thttpserver.Create();
   httpserver1.FreeOnTerminate:= True;
      httpserver1.Resume;   }

  {$IFDEF game_downbank}
   caption:= caption + ' -- www.downbank.cn ��������ר��';
   button13.Caption:= '������������';
   button13.Font.Style:= [fsBold];
   button13.hint:= '�������У��ṩ��Ʒ������ء���ַ��http://www.downbank.cn �������';
  {$ENDIF}
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
ShellExecute(Handle,
              'open','http://www.finer2.com/wordgame/bbs.htm',nil,nil,sw_shownormal);

{ShellExecute(Handle,
  'open','rundll32.exe',
  'url.dll,FileProtocolHandler http://www.finer2.com/wordgame/bbs.htm',nil,sw_shownormal);}
end;



procedure TForm1.FormDestroy(Sender: TObject);
begin
// httpserver1.Terminate; //���������߳�

 Game_read_stringlist.Free;
 Game_action_list.Free;
 Game_Chat_list.Free;
 game_role_clean; //�����ɫ����
 Game_role_list.Free;
 Game_friend_list.Free;
 Game_temp_event.Free;
 game_effect_ini.Free;
 game_time_exe_list.Free;
 Game_touxian_list_G.Free;
 Game_pscene_img_list.Free;
 Game_duihua_list.Free;
  web1.Free;
end;
  {
function get_ad_IWeb2: IWebBrowser2;
var pDoc:  IHTMLDocument3;
    tt: IHTMLElement;
begin
  result:= nil;
  pdoc:= Form1.WebBrowser1.Document as IHTMLDocument3;
    if pdoc<> nil then
     begin
      tt:= pdoc.getElementById('ad_layer1');
       if tt<> nil then
        result:= tt as IWebBrowser2;
     end;
end;
   }
procedure TForm1.FormShow(Sender: TObject);
var
    vv: Variant;
  //  Content: string;
begin
   checkbox1.Visible:= DebugHook=1;
 { pdoc:= WebBrowser2.Document as IHTMLDocument2;
  vv := VarArrayCreate([0, 0], varVariant);
  Content :='��ӭ�������������硣';
  vv[0] := Content;
  pdoc.writeln(PSafeArray(TVarData(vv).VArray));}
     vv := VarArrayCreate([0, 0], varVariant);
     vv[0] :='����Ϸ������ 2007-2012�����ٰ�Ȩ����';
  // pdoc:= WebBrowser1.Document as IHTMLDocument2;
  //  pdoc.writeln(PSafeArray(TVarData(vv).VArray));

  self.WindowState:= wsMaximized;
  web1.ZoomPercent:=  round(dpi_bilv * 100);

 // web1.ScaleForPPI(96);
   if (ParamCount > 0) then
   begin

       if pos('debug-',ParamStr(1))= 1 then
        begin
          game_debug_handle_g:= strtoint(copy(ParamStr(1),7,32));
          form1.Caption:= form1.Caption +'--�����С���';
          sendmessage(game_debug_handle_g,page_c1,handle,1800);
          game_show_scene(10000);
        end else begin

    form_save.cunpan:= ParamStr(1);
    form_save.Button2Click(form1); //����
                 end;
   end else
       game_show_scene(10000);

  kill1:= Tkill.Create(false);
    {
if (CompareText(form_set.combobox1.Text,'VW paul')=0) or
     (CompareText(form_set.combobox1.Text,'VW kate')=0) then
      begin
        game_bg_music_rc_g.yodao_sound:= false;
      end;
       }
  Game_ad_count_G.Y:= 10; //�رչ��
end;

function TForm1.game_show_scene(id: integer): integer;
var str1: Tstringlist;
   // pDoc:  IHTMLDocument2;
  //  AStream:   TMemoryStream;
begin
 if DebugHook=1 then
  self.Caption:= '����Ϸ������-'+ inttostr(id);
screen.Cursor:= crhourglass;
  str1:= Tstringlist.Create;
  Game_action_list.Clear; //�������
  Game_chat_list.Clear;
  game_reset_role_chatid; //���������¼�ָ�

      game_page_id_change(id); //�����ϳ�������ս������id
      //pscene_id:= id; //���泡��id

      game_tianqi_G:= 0;  //����ս��������������Ч��Ϊ�Զ�
    data2.load_scene(inttostr(id),str1); //��ֳ�����html

     //str1.SaveToFile('e:\a.txt');
    web1.LoadHTML(str1.Text);
screen.Cursor:= crdefault;
      //���ڴ�������html��webbrowser
   {   AStream   :=   TMemoryStream.Create;
      try
          str1.SaveToStream(AStream);
          WBLoadFromStream(AStream   ,   WebBrowser1);
      finally
          AStream.Free;
      end;
          }
   // pdoc:= WebBrowser1.Document as IHTMLDocument2;
       //ֱ�Ӳ���html���룬���˷�����֧��ȫ����html����head�λᱻ����
  //  pdoc.body.innerHTML:= str1.Text;
       //���нű�
    //IHtmlWindow2(pdoc.parentWindow).execScript('div1.filters[0].apply();div1.filters[0].play();','JavaScript');
  str1.Free;

 // Button_talk.Enabled:= Game_can_talk_G;


result:= 1;

end;

procedure TForm1.WebBrowser1BeforeNavigate2(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean);
var k: integer;
begin
 Game_script_scene_G:= sUrl;
  if pos('file:',Game_script_scene_G)>0 then
   begin
    k:= pos('/',Game_script_scene_G);
     while k>0 do
       begin
       delete(Game_script_scene_G,1,k);
        k:= pos('/',Game_script_scene_G);
       end;
   end;
 if Game_script_scene_G<> 'about:blank' then
  begin
   if pos('about:blank',Game_script_scene_G)= 1 then
      delete(Game_script_scene_G,1,11)
      else if pos('about:',Game_script_scene_G)= 1 then
      delete(Game_script_scene_G,1,6);

  end;

         if Game_script_scene_G[1]= 'g' then
             begin
              Cancel:= true;
              postmessage(Handle,game_const_script_after,32,0);
              //Game_action_exe(Game_script_scene_G);
             end else if Game_script_scene_G[1]= 'i' then
                       begin
                        Cancel:= true;
                        postmessage(Handle,game_const_script_after,33,0);
                        //Game_action_exe_S_adv(Game_script_scene_G);
                       end else
                       if Game_script_scene_G[1]= 'D' then
                       begin
                        Cancel:= true;
                        postmessage(Handle,game_const_script_after,31,0);
                        //Game_action_exe_S_adv(Game_script_scene_G);
                       end else
                    if length(Game_script_scene_G)=5 then
                      begin
                        Cancel:= true;
                        postmessage(Handle,game_const_script_after,34,0);
                        //game_show_scene(strtoint(Game_script_scene_G));
                      end;
end;

procedure TForm1.game_start(flag: integer);
begin

      game_role_clean;
      game_role_list.Add(Tplayer.create(game_app_path_G+'persona\Player0.upp'));
  //��ʼ�������ɫ

   Data2.load_goods_file; //������Ϸ��Ʒ������
   Data2.load_event_file(''); //�����¼�ϵͳ

   //����ͷ��
    data2.Load_file_upp(game_app_path_G+'dat\touxian.upp',Game_touxian_list_G);

   Game_not_save:= true;
   button_stat(true); //����button״̬
   if flag= 0 then
      game_show_scene(10001);  //���뿪ʼ����
    game_load_image_to_imglist;
end;

procedure TForm1.game_cmd_execute(const s: string);
begin                         //ִ����Ϸ����
 if s='Pstart' then
    game_start(0)
    else if s='Psave' then
       game_save2;
end;

procedure TForm1.game_save2;
begin
 if not Game_not_save then
     Form_save.addr:= ''
     else
       Form_save.addr:= groupbox5.Caption;

  Form_save.ShowModal;

end;

      {ִ����Ϸ�������ɶ���������}
procedure TForm1.Game_action_exe(const id: string);
begin
    //��Ϸ�����ڵĶ��������ִ��
 if id= '' then
    exit;

  if id[1]= 'D' then
   begin
   
      Game_action_exe_S_adv(Game_action_list.Values[copy(id,1,5)]);

   end else
        Game_action_exe_S_adv(id);
end;

function TForm1.Game_action_exe_A(const F: string): integer;  //ִ�е����ű��ڵĺ���
    function strtoint3(const s: string): integer;
     begin
      //������� game_ ��������ʾ��һ����������ô��������ֵ
      if fastpos(s,'game_',length(s),5,1)> 0 then
         result:= Game_action_exe_A(s)
         else
          result:= strtoint(s);
     end;
    function youkuohao(const s: string; index: integer): integer;
      var i87,i86: integer;
     begin
      youkuohao:=0;
      i86:= 0;
       for i87:= index to length(s) do
           if s[i87]= '(' then
              inc(i86)
              else if s[i87]= ')' then
                    begin
                     dec(i86);
                     if i86= 0 then
                        begin
                          youkuohao:= i87;
                          exit;
                        end;
                    end;
     end;
    function strFromstr2(const s: string): string;
     var i88,i89: integer;
     begin
       i88:= fastpos(s,'game_',length(s),5,1);
       if i88> 1 then
        begin
          if (s[i88-1]='=') or (s[i88-1]='"') then
             exit; //�����������ڵĺ���������
        end;

       if i88 > 0 then
        begin
         result:= '';
         i89:= length(s);
         if (fastpos(s,'ing ',length(s),4,1)> 0) and
            (fastpos(s,'ing ',length(s),4,1)< i88) then
             begin //�ַ���
             i89:=youkuohao(s,i88);
              if i88 > 8 then
                 result:= copy(s,1,i88-8);
              result:= result + pchar(Game_action_exe_A(copy(s,i88,i89-i88+1)));
             end else begin  //������
                        if i88 >= 1 then
                           result:= copy(s,1,i88-1);
                        result:= result + inttostr(Game_action_exe_A(copy(s,i88,i89-i88+1)));
                      end;
         if i89< length(s) then
          result:= result + copy(s,i89+ 1,length(s)-i89);
          
         result:= strFromstr2(result);
        end else
             result:= s;
     end;
    function ss2int(var s1: string): integer;
     begin
       delete(s1,1,1);
       s1:= trimleft(s1);
       if fastpos(s1,'game_',length(s1),5,1)> 0 then
         ss2int:= Game_action_exe_A(s1)
          else
           ss2int:= strtoint2(s1);
     end;
var a: array of TVarRec;
    i,j,k: integer;
    ss,ss2,ss3,ss4: string;
    b,b_not: boolean;
    a2: array[0..7] of word; //һ�������������7����������ǰ��һ��Ų��������
begin
 if length(f)< 2 then
  begin
   result:= 0;
   exit;
  end;
 if f[1]= 'D' then
  begin
    Game_action_exe(f);
   result:= 1;
    exit;
  end;

 i:= FastCharPos(f,'(',1);
 if i= 0 then
  begin
   messagebox(handle,pchar('���󣬺���'+f +'�Ĳ��������ڡ�'),'����',mb_ok or MB_ICONERROR);
   result:= 0;
   exit;
  end;
  ss:= trim(copy(f,1,i -1));  //��ú�������
  ss:= ansilowercase(ss); //ת��ΪСд
  if pos('not ',ss)= 1 then
   begin
    b_not:= true;
    delete(ss,1,4);
   end else b_not:= false;

k:= 0;
  //ȡ�ò�������ƥ��
   for j:= i to length(f) do
    begin
       if f[j]= '(' then
         inc(k)
         else if f[j]=')' then
          begin
           dec(k);
           if k= 0 then
              begin
               k:= j;
               break;
              end;
          end;
    end; //end for j

          if k=1  then
               begin
                k:= length(f)+1;
               end;
  ss2:=trim(copy(f,i+ 1,k- i-1)); //��ú�������

  if k < length(f) then
     ss4:= copy(f,k+1,length(f))
     else
      ss4:= '';    //ss4�����˺���������

  if (length(ss2)= 0) then
   begin
    result:= 0;
     exit;
   end;

  if (ss2[length(ss2)]= ')') then
     delete(ss2,length(ss2),1);

  if fastcharpos(ss2,'^',1)> 0 then
        ss2:= stringReplace(ss2, '^', '''', [rfReplaceAll]);  //����ת���

  b:= false;
  j:= 1;
  k:= 0;

  a2[0]:= 0; //����ֵ�ܱ���ȷ��ֵ�������ʼ��

   for i:= 1 to length(ss2) do //��ȡ��������
    begin
      if ss2[i]= '''' then
       begin
        if not b then
          b:= true
          else begin
                if i= length(ss2) then
                    b:= false
                    else if (ss2[i+1]= ',') or (ss2[i+1]= ' ') or (ss2[i+1]= ')') then
                           b:= false;
               end;
       end;

      

       if not b then
        begin
         if ss2[i]= '(' then
         inc(k)
          else if ss2[i]= ')' then
              dec(k);
       if k > 0 then //����������ڣ�������������ͳ��
         Continue;
        if ss2[i]= ',' then
         begin
          a2[j]:= i; //���������ָ��λ�ã���λ��1��ʼ
          inc(j);
         end;
        end;
    end;

       a2[j]:= length(ss2)+ 1;

    setlength(a,j); //Ϊ���������ڴ�ռ�
    for i:= 0 to j-1 do
     begin
       if ss2[1]= '''' then
        begin
         ss3:= strFromstr2(copy(ss2,2,a2[i+1]- a2[i]-3));
         if ss3= '' then
           a[i].VAnsiString:= nil
           else
             a[i].VAnsiString:= @ss3[1];
         delete(ss2,1,FastCharPos(ss2,'''',2)+1);
        end else begin
                  if a2[i+1] > 0 then
                   begin
                    a[i].VInteger:= strtoint3(copy(ss2,1,a2[i+1]- a2[i]-1));
                    delete(ss2,1,a2[i+1]- a2[i]);
                   end else
                      a[i].VInteger:= strtoint3(ss2);
                 end;


     end;

    result:= ExecuteRoutine(self,ss,a);

    if ss4<> '' then
     begin
       //��������
       ss4:= trim(ss4);

       if ss4<> '' then
        begin
         case ss4[1] of
          '+': result:= result + ss2int(ss4);
          '-': result:= result - ss2int(ss4);
          '*': result:= result * ss2int(ss4);
          '/': begin
                if result= 0 then
                   result:= 0
                    else
                     result:= result div ss2int(ss4);
               end;
          end;
        end;
     end;

    if b_not then  //not �ؼ��ִ���
       if result= 0 then
          result:= 1
           else
            result:= 0;

    if game_debug_handle_g<> 0 then  //���͵�����Ϣ
       begin
        ss4:= f + ':'+ inttostr(result);
         debug_send_func_str(ss4,func_C);
       end;
end;

   {��ʾ�����ʴ���}
function TForm1.Game_pop(i: integer): integer;
begin
        if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ�������ģʽ�����������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

    if checkbox1.Checked then
      begin
        result:= 1;  //����ģʽ��ֱ��·��
        exit;
      end;

  form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 1; //������

   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(1, i,0);

      result:= ord (form_pop.ShowModal= mrok);

   
end;

      {���볡���ļ�}
function TForm1.game_page(id: integer): integer;
begin


        if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����л�ҳ��
            game_chat('����������ȫ�������ģʽ�������Լ��л�ҳ�档<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

     // Game_scr_clean2; //���촰������

 // combobox2.ItemIndex:= -1;
 // combobox2.Text:= '����б�';
  if id <> 0 then
   begin
    if id < 10000 then //���idС��1������ϵ�ǰҳ�� ����idΪ 1 ���൱��������һҳ
       game_show_scene(id + pscene_id)
       else
         game_show_scene(id);
   end;

   if id=0 then
    begin
     //��ʾ�Թ��ڵĹ��
         if (Game_ad_count_G.X<> 1) or (Game_ad_count_G.Y < 10)then
           begin
           game_chat('<iframe src="http://www.finer2.com/wordgame/jiqiao'+inttostr(Random(20)+1)+'.htm"  width=100%  height=100% framespacing=0 frameborder=0></iframe>');
           //Game_ad_count_G.Y:= Game_ad_count_G.Y+ 1;
           end;

    end;
  result:= 1;
end;

    {����һ����Ϣ����}
function TForm1.game_infobox(s: string): integer;
begin
  messagebox(screen.ActiveForm.handle,pchar(s),'����Ϸ������',mb_ok or MB_ICONINFORMATION);
  result:= 1;
end;

   {�����촰�������һ�仰}
function TForm1.game_chat(const s: string): integer;
begin

  Game_add_line_to_web2(s);
  result:= 1;
end;

   {��ʾ���״���}
function TForm1.game_trade(id,flag: integer): integer;  //,flag=0��ʾ��1��ʾ��
begin
  if not Assigned(form_trade) then
     form_trade:= Tform_trade.Create(application);
  form_trade.game_trade_id:= id;
  form_trade.game_flag:= flag;
  form_trade.ShowModal;
  result:= 1;
end;

  {�����촰�������һ�仰��ʵ�ֲ���}
procedure TForm1.Game_add_line_to_web2(const s: string);
var ss: string;
begin
      visible_html_by_id('layer_chat1',true);
      //web1.WebView.RunJS('document.getElementById("layer_chat1").display="inline";');


     {if pdoc.getElementById('cell_chat1').innerText = '' then
       game_chat_cache_g:= s
     else }
      ss:= 'document.getElementById("cell_chat1").innerHTML=document.getElementById("cell_chat1").innerHTML+"<br>'+
        StringReplace(s,'"','\"',[rfReplaceAll]) +'";';
     // ss:= 'document.getElementById("cell_chat1").innerHTML="pppp";';

     web1.ExecuteJavascript(ss);



 {  if pdoc<> nil then
    begin

    for i := 0 to pdoc.all.length-1 do
     begin
       Disp := pdoc.all.item(i, 0);
       if (SUCCEEDED(Disp.QueryInterface(HTMLDivElement, dd)) ) then
          if dd.id= 'layer_chat1' then
             dd.style.display:= '""';
       if (SUCCEEDED(Disp.QueryInterface(HTMLTableCell, tt)) ) then
        begin
         if tt.id= 'cell_chat1' then
          begin
            tt.innerHTML:= tt.innerHTML + '<br>'+ s;
            break;
          end;
        end;
     end; //end for i
    end; }


end;
    {��ʱ����}
function TForm1.game_dec_scene_event(id, v: integer): integer;
begin
  result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),0);
  result:= result - v;
   data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),result);

   result:= 1;
end;

function TForm1.game_delay(i: integer): integer;
var t,t2: cardinal;
begin
  t:= GetTickCount;
  t2:= i;
    while GetTickCount - t < t2 do
     begin
      application.ProcessMessages;
       sleep(10);
     end;
 result:= 1;
end;
    {����һ��ѯ�ʴ���}
function TForm1.game_question(s: string): integer;
begin
   if messagebox(screen.ActiveForm.handle,pchar(s),'ѯ��',mb_yesno or MB_ICONQUESTION)= mryes then
    result:= 1
    else
     result:= 0;
end;

           //�޸���Ϸ��Ʒ����
function TForm1.game_goods_change(id, values: integer): integer;
begin
  Game_not_save:= true;
  result:= 1;
  write_goods_number(id, values);
 { showmessage(format('����%d�ţ����ƣ�%s ����%d��������%s',[Game_goods_G[id],pchar(Data2.get_game_goods_type(id,goods_name1)),
  Data2.get_game_goods_type(id,goods_type1),
  pchar(Data2.get_game_goods_type(id,goods_ms1))])); }
end;
         //�޸ĵ�ǰ�Ի��˵�����
function TForm1.game_write_name(s: string): integer;
var i: integer;
begin

Game_chat_index_G:= 0;
 Game_chat_id_G:= 0;
 Game_chat_name_G:= s;
 i:= combobox2.Items.IndexOf(s);
 if i<> -1 then
    combobox2.ItemIndex:= i;
 result:= 1;
end;
         //��Ϸ����
function TForm1.game_save(i: integer): integer;
begin
result:= 1;
 if game_at_net_g then  //������Ϸ���ô���
    exit;

 case i of
   0: game_save2;
   1: begin
       if not Game_not_save then
        Form_save.addr:= ''
         else
          Form_save.addr:= groupbox5.Caption;

         Form_save.Button1Click(form1);
      end;
   end;
end;
          //��Ϸ��ɫ�������
procedure TForm1.game_role_clean;
var i: integer;
begin
   for i:= 0 to game_role_list.Count-1 do
      Tplayer(game_role_list.Items[i]).Free;

   game_role_list.Clear;
end;

             //��Ϸ����
function TForm1.game_talk(const n: string): integer;
         function get_talk_index(const s2: string): integer;
          var i2: integer;
          begin  //��ȡ�����ı��ڵ�index��
            i2:= fastcharpos(s2,']',2)+1;
            if i2= 1 then
              i2:= fastcharpos(s2,'=',2)+1;
            result:= strtoint2(Copy(s2,i2,fastcharpos(s2,',',i2)-i2));
          end;

var i,j,player_i: integer;

     ss: string;
     b: boolean;
begin

player_i:= -1;
    //��ȡ��ǰ�����̸��index  Game_chat_index_G,Game_chat_id_G
 Game_chat_name_G:= n;

      for i:= 0 to game_get_role_H do
        if Assigned(game_role_list.Items[i]) then
           if Tplayer(game_role_list.Items[i]).pl_old_name= n then
              begin
               Game_chat_id_G:= game_read_values(i,22);  //22�ż�¼����ǰ̸��ǰ����
               inc(Game_chat_id_G);  //̸��ǰ���ļ�һ
               game_write_values(i,22,Game_chat_id_G);
               Game_chat_index_G:= game_read_values(i,23); //̸����������
               talkchar1:= Tplayer(game_role_list.Items[i]).pltalkchar1;
               talkchar2:= Tplayer(game_role_list.Items[i]).pltalkchar2;  //��ȡ�������
               talkchar3:= Tplayer(game_role_list.Items[i]).pltalkchar3;
               talkchar4:= Tplayer(game_role_list.Items[i]).pltalkchar4;
               talkchar5:= Tplayer(game_role_list.Items[i]).pltalkchar5;
               player_i:= i; //�����ֵ��Ϊ�������������������ڳ�Ա��ġ�
               break;
              end;


   if player_i < 0 then  //��������ڲ�����̸������ôid��һ
    begin
     inc(Game_chat_id_G);

    end;

  b:= false;
  for j:= 1 to 6 do
  begin
    case j of
    1: begin
        if talkchar5= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2+ ','+talkchar3+ ','+talkchar4+ ','+talkchar5;
       end;
    2: begin
        if talkchar4= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2+ ','+talkchar3+ ','+talkchar4;
       end;
    3: begin
        if talkchar3= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2+ ','+talkchar3;
       end;
    4: begin
        if talkchar2= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2;
       end;
    5: begin
        if talkchar1= #0 then Continue;
        ss:= n+ ','+ talkchar1;
       end;
    6: ss:= n;
    end;

   for i:= Game_chat_index_G to Game_Chat_list.Count - 1 do
    begin
      if fastpos(Game_Chat_list.Strings[i],ss,length(Game_Chat_list.Strings[i]),length(ss),1) =1 then
         begin
          if get_talk_index(Game_Chat_list.Strings[i])= Game_chat_id_G then   //�Ѿ��ҵ�
           begin
              Game_chat_index_G:= Game_talk_random(i,ss);
              Game_talk_run(Game_chat_index_G,player_i);
              inc(Game_chat_index_G); //�����µ�����ֵ
            b:= true;
            break;
           end;
         end;
    end; //for i

   if b then
    break
     else if j= 6 then
         begin
            Game_scr_clean2;
          game_chat('.');

         // Button_talk.Enabled:= true;
         end;
 end; //for j

  if player_i > 0 then  //���ڲ�����̸������ô�����µ�����ֵ
    begin
    game_write_values(player_i,23,Game_chat_index_G);
    end;
  result:= 1;
end;

procedure TForm1.Game_action_exe_S(s: string);
var i,j: integer;
    s2: string;
begin
  s:= trim(s);
 { if pos('if ',s)> 0 then //���������ж��if��䣬��ִֻ��ifǰ���
    s:= copy(s,1,pos('if ',s)-1);   }

 if s[length(s)]<>';' then s:= s + ';';
   i:= 1;
   while FastCharPos(s,';',i)> 0 do
    begin
    s2:= copy(s,i,FastCharPos(s,';',i)-i);
     j:= Game_action_exe_A(s2);
     i:= FastCharPos(s,';',i)+1;

      if j = 0 then  //һ����������false�����ж�ִ��
       break
       else if j= 1881 then
            begin //�� gamepop��popa�����⴦��
              if (game_bg_music_rc_g.mg_pop=false) and (Game_scene_type_G and 2=2) and
                  (pos('game_pop_a(',s2)=1) then
                begin

                  game_html_pop_str_g:= copy(s,i,1024); //������Թ�popģʽ�����ݴ�����
                  exit;
                end;
            end;


    end;

end;

procedure TForm1.Game_action_exe_S_adv(const s: string);
var ss2{,ss3}: string;
    //i,j: integer;
begin
  ss2:= StringReplace(s, '%20', ' ', [rfReplaceAll]); //%20 �滻Ϊ�ո�

   data2.clean_if_then(ss2);

   if (game_bg_music_rc_g.mg_pop=false) and (Game_scene_type_G and 2=2)
      and (length(game_html_pop_str_g)= 3) then
      game_html_pop_str_g:= ss2; //������Թ�popģʽ�����ݴ�����

     if ss2 <> '' then
        Game_action_exe_S(ss2);

end;

procedure TForm1.Game_talk_run(id,role_id: integer); //����ִ��
var ss,ss2,ss3,ss4,ss5,ss6: string;
    i,j,k,k2: integer;
    b: boolean;
     function get_id: integer;
      var q2: integer;
      begin
        result:= fastcharpos(ss,']',2); //�ҵ��������ţ���λ̸��id
   if result > 0 then
    begin
     q2:= fastcharpos(ss,',',result); //�ҵ��ұߵĵ�һ������
     result:= strtoint2(copy(ss,result+1,q2- result-1));
    end else begin
              result:= fastcharpos(ss,'=',2);
              q2:= fastcharpos(ss,',',result);
              result:= strtoint2(copy(ss,result+1,q2- result-1));
             end;
      end;
begin
//

b:= false;
 ss:= Game_Chat_list.Strings[id];  //�õ��Է�����ĶԻ�������
  data2.clean_if_then(ss); //������̸���ڵ�if then�����жϹ���
     k:= get_id;
   i:= fastcharpos(ss,',',2) +1;
  ss3:= Copy(ss,i,fastcharpos(ss,'=',2)-i);
  if ss3= '' then
    ss3:= 'I'
    else ss3:= 'I,'+ ss3;

 delete(ss,1,fastcharpos(ss,'=',2)); //ɾ�����ں�ǰ��


  i:= fastcharpos(ss,'[',1);
  if (i >0)  and (i < 5) then
   begin
    inc(i);
     ss2:= copy(ss,i,fastcharpos(ss,']',i)-i);
     ss2:= trim(ss2);  //ȡ�ú���

    delete(ss,1,fastcharpos(ss,']',2)+1); //ɾ����������
   end;

   delete(ss,1,fastcharpos(ss,',',1)); //ɾ��idǰ��
   ss:= trim(ss);
     if ss<> '' then
      begin
        k2:= fastcharpos(ss,'@',1);
         if k2 > 0 then
           begin
           ss6:= copy(ss,1,k2 -1);
            delete(ss,1,k2);
           end else
            ss6:= game_newname_from_oldname(Game_chat_name_G);

        ss:= ss6 +'��<strong>' +ss + '</strong>';
        game_chat(ss);   //��ʾһ�仰
      end;

      if ss2<> '' then   //ִ�к���
      begin
       if ss2[1]= 'D' then
       Game_action_exe(ss2) //ִ����������ڵĶ���
        else begin
            // if ss2[length(ss2)]<> ';' then
              //  ss2:= ss2+ ';';
             Game_action_exe_S_adv(ss2); // ִ����������ڵ�ֱ�Ӻ���
             end;
      end;

  for i:= Game_chat_index_G to Game_Chat_list.Count-1 do
   begin
    if fastpos(Game_Chat_list.Strings[i],ss3,length(Game_Chat_list.Strings[i]),length(ss3),1) =1 then
       begin
        b:= true;

        ss:= Game_Chat_list.Strings[i];
         if get_id<> k then
          break;

         j:= fastcharpos(ss,',',2) +1;  //��ȡ���� ss4
         ss4:= Copy(ss,j,fastcharpos(ss,'=',2)-j);
         if ss4= '' then
            ss4:= '0';

         //��ȡ����������еĻ�
         delete(ss,1,fastcharpos(ss,'=',2));
          data2.clean_if_then(ss); //���ҷ�̸���ڵ�if then�����жϹ���
          Data2.function_re_string(ss); //�Է����ַ������͵ĺ������д���

           j:= fastcharpos(ss,'[',1) +1;  //��ȡ����
           if j> 1 then
            begin
         ss5:= Copy(ss,j,fastcharpos(ss,']',j)-j);
         if ss5='' then
          Continue;

          if ss5[1]='D' then
            ss5:= Game_action_list.Values[ss5];
         delete(ss,1,fastcharpos(ss,']',j)+1);

          if (length(ss5)> 1) and (ss5[length(ss5)]<> ';') then
             ss5:=ss5+ ';';

            end else ss5:= '';

           delete(ss,1,fastcharpos(ss,',',1));

         ss5:= 'game_chat_cleans(0);'+ ss5 + 'game_talk_char_set('''+ ss4+''','+ inttostr(role_id)+ ');';
         ss:= trim(ss);
            if ss<> '' then //�ҷ���䲻Ϊ��ʱ��ʾ
           begin
            k2:= fastcharpos(ss,'@',1);
             if k2 > 0 then
               begin
                ss6:= copy(ss,1,k2 -1);
                delete(ss,1,k2);
               end else
                    ss6:= Tplayer(Game_role_list.Items[0]).plname;

              ss:= ss6 + '��<a href="'+ ss5+ '">'+ ss+ '</a>';
              game_chat(ss);
           end;
       end else begin
                  if b then
                   break;
                end;
   end; //end for i

    {
   if Game_scene_type_G and 8 <> 8 then  //��������8�����ڣ�����Խ�������
      game_chat('<a href="game_talk_stop(0)">�����Ի�</a>');
     }

end;

function TForm1.game_talk_char_set(c1: string;
  role_id: integer): integer;
  var
     i,j: integer;
begin
 talkchar1:= #0;
talkchar2:= #0;
talkchar3:= #0;
talkchar4:= #0;
talkchar5:= #0;

  //Game_scr_clean2;  //����



   j:= 1;
      for i:= 1 to length(c1) do    //���������β�������������5��
       begin
        if c1[i]= ',' then Continue;
         case j of
          1: talkchar1:= c1[i];
          2: talkchar2:= c1[i];
          3: talkchar3:= c1[i];
          4: talkchar4:= c1[i];
          5: talkchar5:= c1[i];
          end;
         inc(j);
       end; //end for

   if (role_id > 0) and (role_id <= game_get_role_H) then
    begin
      Tplayer(game_role_list.Items[role_id]).pltalkchar1:= talkchar1;
      Tplayer(game_role_list.Items[role_id]).pltalkchar2:= talkchar2;
      Tplayer(game_role_list.Items[role_id]).pltalkchar3:= talkchar3;
      Tplayer(game_role_list.Items[role_id]).pltalkchar4:= talkchar4;
      Tplayer(game_role_list.Items[role_id]).pltalkchar5:= talkchar5;
    end;

   game_talk(Game_chat_name_G);

result:= 1;
end;

function TForm1.game_talk_stop(i: integer): integer;
begin
      //��ֹ����
//WebBrowser2.Navigate('about:blank');
Game_scr_clean3; //���촰������
result:= 1;
end;

function TForm1.game_npc_talk(const n: string): integer; //npc talk
begin
 Game_chat_index_G:= 0;
 Game_chat_id_G:= 0;
 game_write_name(n);
   result:= game_talk(n); //����talk����

end;

function TForm1.Game_talk_random(id: integer; const n: string): integer;
var i: integer;
begin
result:= id;
    //����һ�������������䣬�ڶ�����������
  for i:= id to Game_Chat_list.Count-1 do
   begin
     if fastpos(Game_Chat_list.Strings[i],n,length(Game_Chat_list.Strings[i]),length(n),1) <>1 then
       begin
        result:= id + Game_base_random(i-id);
        break;
       end;
   end;

end;

procedure TForm1.Game_scr_clean2;     //˽�Ĵ�������

begin
   change_html_by_id('cell_chat1','');
   visible_html_by_id('layer_chat1',false);

   game_chat_cache_g:= ''; //������컺��
end;

function TForm1.game_accouter1_wid(i1: integer): integer;
begin
result:= 0;
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'��Ϸû�п�ʼ����������ġ���ʼ������Ϸ�����ߡ���ʼ������Ϸ����������Ϸ���ߴ�ȡ���ȡ�','��Ϸû��ʼ',mb_ok);
   exit;
  end;

    if not Assigned(Form_goods) then
     Form_goods:= TForm_goods.Create(application);

  Form_goods.ShowModal;
 result:= 1; 
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  game_accouter1_wid(0);
end;

function TForm1.game_get_roleByNmae(n: string): Tplayer;
var i: integer;
begin
result:= nil;

for i:= 0 to game_get_role_H do
     if Assigned(game_role_list.Items[i]) then
       if Tplayer(game_role_list.Items[i]).pl_old_name= n then
          result:= Tplayer(game_role_list.Items[i]);
end;

function TForm1.game_add_res_event(id: integer): integer;
begin
  if game_at_net_g then
   begin
    result:= 1;
    exit; //������Ϸʱ���ú��������κζ���
   end;

    if id < 1001 then
   begin
     messagebox(handle,'�����¼����1000������Ϊϵͳ��������ʹ��1000���ϡ�','����',mb_ok or MB_ICONERROR);
     result:= 0;
   end else begin
            Game_not_save:= true;
            data2.game_memini_event.WriteInteger('FOODS',inttostr(id),1);
            result:= 1;
           end;
end;

function TForm1.game_add_scene_event(id: integer): integer;
begin
  if (id < 1001) and (game_at_net_g= false) then
   begin
     messagebox(handle,'�����¼����1000������Ϊϵͳ��������ʹ��1000���ϡ�','����',mb_ok or MB_ICONERROR);
     result:= 0;
   end else begin
             Game_not_save:= true;
            data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),1);
         if game_at_net_g then  //�����Ϸ��������״̬����ôͬʱд��һ����¼�¼�����Ʒ����Ϊ��Ʒ�¼����������²���
             begin
               //�����¼�
               Data_net.send_scene_bool(id,1);
             end;
             result:= 1;
            end;
end;

function TForm1.game_check_res_event(id: integer): integer;
begin
 if game_at_net_g then //����ʱ����Ʒ�¼����Ƿ��� 1
  result:= 1
  else
   result:= data2.game_memini_event.ReadInteger('FOODS',inttostr(id),0);

end;

function TForm1.game_check_scene_event(id: integer): integer;
begin
 result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),-1);
   if result= -1 then
    begin
      if game_at_net_g then
       begin
        //����ʱ�����Ϊ-1����������ȡ
        data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),1);
        result:= wait_scene_int_bool(true,id);
       end else result:= 0;
    end;
end;

function TForm1.game_del_res_event(id: integer): integer;
begin
 if not game_at_net_g then
    data2.game_memini_event.DeleteKey('FOODS',inttostr(id));
  result:= 1;
end;

function TForm1.game_del_scene_event(id: integer): integer;
begin
 data2.game_memini_event.DeleteKey('EVENTS',inttostr(id));
        if game_at_net_g then  //�����Ϸ��������״̬����ôͬʱд��һ����¼�¼�����Ʒ����Ϊ��Ʒ�¼����������²���
             begin
               //�����¼�
               Data_net.send_scene_bool(id,0);
             end;
 result:= 1;
end;

function TForm1.game_prop_enbd(b: integer): integer;
begin
  button1.Enabled:= (b= 1);
  result:= 1;
end;

function TForm1.Game_pop_dig(i: integer): integer;
begin
  form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 2; //�ڿ�
  
      if game_at_net_g and (game_player_head_G.duiwu_dg= 1) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ����ӳ������������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
    begin
     if i= 100 then
        data_net.send_dwjh_pop(5, i,0);  //�ڿ�
     if i= 200 then
        data_net.send_dwjh_pop(6, i,0);  //��ҩ���ߴ���
    end;
  if form_pop.game_pop_count >= 1000 then
   begin
   form_pop.ShowModal;
   if form_pop.game_kaoshi<= 35 then
      result:= Game_wakuan_zhengque_shu
      else
        result:= 0;
   end else
        result:= ord(form_pop.ShowModal= mrok);
end;

function TForm1.Game_pop_fight(i, i2: integer): integer;
begin
      if game_at_net_g and ((game_player_head_G.duiwu_dg= 1) or ((game_player_head_G.duiwu_dg= 2))) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ����ӳ����ߴ�ָ��棬���������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

  if checkbox1.Checked then
    begin
     result:= 1;    //����ʱֱ���Թ�
     exit;
    end;

 if i< 1 then
    i:= 1;

   form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 3; //ս��
  form_pop.game_monster_type:= i2;  //��������

  if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(3, i,i2);

     result:= ord( form_pop.ShowModal= mrok);
end;

function TForm1.Game_pop_game(i, i2: integer): integer;
begin
      if game_at_net_g and ((game_player_head_G.duiwu_dg= 1) or ((game_player_head_G.duiwu_dg= 2))) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ����ӳ����ߴ�ָ��棬���������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

  if i< 1 then
    i:= 1;
    
  form_pop.game_pop_count:= i; //�Է�����
  form_pop.game_pop_type:= 4; //����
  form_pop.game_monster_type:= i2;  //������������
        if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(5, i,i2);

     result:= ord(form_pop.ShowModal= mrok);
end;

procedure TForm1.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
  key:= #0;
end;

function TForm1.game_add_friend(n: string; new: integer): integer;
begin
   //���һ�����ѵ��б� nΪ�������
  if Game_friend_list.IndexOf(n)= -1 then
     begin
     
       //��ʼ���������
       Game_loading:= true;
       initialize_role(n,new);
       Game_friend_list.Append(n);
       combobox2.Items.Append(n);
       Game_loading:= false;
       messagebox(handle,pchar(n+ ' �����˶��顣'),'��Ϣ',mb_ok or MB_ICONINFORMATION);
       
       result:= 1;
     end else result:= 0;

end;

procedure TForm1.game_load_friend_list(n: string);
var i: integer;
begin
//�������б�
  Game_friend_list.Clear;
  combobox2.Items.Clear;
  data2.Load_file_upp(n,Game_friend_list);
  combobox2.Items.Assign(Game_friend_list);

   for i:= 0 to Game_friend_list.Count-1 do
     initialize_role(Game_friend_list.Strings[i],1); //�ڶ�������Ϊ1����ʾ����ȡdat��

end;

procedure TForm1.game_save_friend_list(n: string);
var i: integer;
    str1: Tstringlist;
    ss: string;
begin
 //�������б�,�������ѹ���ļ�
   data2.save_file_upp(n,Game_friend_list);

     str1:= Tstringlist.Create;
     data2.Load_file_upp(game_app_path_G+ 'persona\ext.upp',str1);
     Assert(str1.count > 0,'��Ч��������ձ�������Ϸ��ɫʧ�ܡ�');

   for i:= 1 to Game_role_list.Count-1 do  //���������ݣ��������������
    begin
      //�����б��ڵ�ÿ����������
      ss:= str1.Values[Tplayer(Game_role_list.Items[i]).pl_old_name]; //ȡ����Ϸ������ļ���
     Tplayer(Game_role_list.Items[i]).saveupp(Game_save_path + ss);
    end;

   str1.Free;
end;

procedure TForm1.initialize_role(n: string; new: integer);
var i: integer;
    str1: Tstringlist;
    ss: string;
begin
      for i:= 1 to Game_role_list.Count-1 do
        begin
         if Tplayer(Game_role_list.Items[i]).pl_old_name = n then
            exit;  //����ý�ɫ�Ѿ����ڣ��˳�

        end;

 //������ձ�
   str1:= Tstringlist.Create;
     data2.Load_file_upp(game_app_path_G+ 'persona\ext.upp',str1);
     Assert(str1.count > 0,'��Ч��������ձ���ʼ����Ϸ��ɫʧ�ܡ�');
     ss:= str1.Values[n]; //ȡ����Ϸ������ļ���
   str1.Free;

    //���dat·�����ļ����ڣ����ȶ�ȡ����ģ���ʾ����������뿪�������
    //���new=1 ���Զ�dat�ļ���������ǿ�ƶ�ȡ���ļ�
   //����ж���·�����ڣ����ȶ�ȡ��·��
   //�������·�������ڻ���·����û����Ҫ���ļ������ȡԭʼλ��
    if (new= 0) and fileExists(game_doc_path_g+ 'dat\'+ ss) then
       ss:= game_doc_path_g+ 'dat\'+ ss
       else
       if Game_save_path= '' then
          ss:= game_app_path_G+ 'persona\'+ ss
           else begin
             if FileExists(Game_save_path+ ss ) then
              ss:= Game_save_path+ ss
               else
                ss:= game_app_path_G+ 'persona\'+ ss;
                end;

   //��ʼ���������ݣ�����ӵ������б�
   if not FileExists( ss) then
     raise Exception.Create('���ش��󣬽�ɫ�����ļ������ڡ�������Ϸ��װ��������������������װ��Ϸ���ԡ�');

   game_role_list.Add(Tplayer.create(ss));

end;

function TForm1.game_not_res_event(id: integer): integer;
begin
       //�¼�������ʱ����true
 if game_at_net_g then          //����ʱ���¼�����0
 result:= 0
 else begin
 if data2.game_memini_event.ReadInteger('FOODS',inttostr(id),0)= 0 then
  result:= 1
   else
    result:= 0;
       end;
end;

function TForm1.game_not_scene_event(id: integer): integer;
begin
   //�¼�������ʱ����true
 if game_check_scene_event(id) = 0 then
  result:= 1
   else
    result:= 0;
end;

function TForm1.game_over(i: integer): integer;
begin
  //��Ϸ����
  game_kill_game_time(0); //ֹͣ���ܵĶ�ʱ��
  Game_not_save:= false;
  combobox2.Items.Clear;
  game_page(14444);
   button_stat(false); //����button״̬
   game_role_clean; //�����ɫ���ݡ�
   Game_scene_type_G:= 2;
  result:= 1;
end;

function TForm1.game_check_res_event_and(s: string): integer;

begin
    //�����Ʒȫ�������ڣ����� 1
result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //ֻҪһ�������ڣ��ͷ��� 0 �˳�
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_check_res_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_not_res_event_and(s: string): integer;
begin
   //�����Ʒ�� �� ���ڣ����� 1
   result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //ֻҪһ�������ڣ��ͷ��� 0 �˳�
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_not_res_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_check_res_event_or(s: string): integer;
begin
   //�����Ʒ��һ�����ڣ����� 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //ֻҪһ�����ڣ��ͷ��� 1 �˳�
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_check_res_event(strtoint2(s));

     end else result:= 0;

end;

function TForm1.game_not_res_event_or(s: string): integer;
begin
  //�����Ʒ��һ�� �� ���ڣ����� 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //ֻҪһ�������ڣ��ͷ��� 1 �˳�
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_not_res_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_check_scene_event_and(s: string): integer;
begin
  result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //ֻҪһ�������ڣ��ͷ��� 0 �˳�
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_check_scene_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_check_scene_event_or(s: string): integer;
begin
    //�����Ʒ��һ�����ڣ����� 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //ֻҪһ�����ڣ��ͷ��� 1 �˳�
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_check_scene_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_not_scene_event_and(s: string): integer;
begin
  //�����Ʒ�� �� ���ڣ����� 1
   result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //ֻҪһ�������ڣ��ͷ��� 0 �˳�
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_not_scene_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_not_scene_event_or(s: string): integer;
begin
   //�����Ʒ��һ�� �� ���ڣ����� 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //ֻҪһ�������ڣ��ͷ��� 1 �˳�
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //ͨ��whileѭ�����ټ�����һ��
       if s<> '' then
        result:= game_not_scene_event(strtoint2(s));

     end else result:= 0;

end;

function TForm1.game_pop_love(i: integer; const n: string): integer;
var j,k,m: integer;
begin
result:= 0;
               //����ֻ��ʾ�����˵ı����ʴ���
    if game_at_net_g then
     begin
      //����ʱ��������
      game_chat('����ʱ���ù��ܲ����á�');
       exit;
     end;
 form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 5; //�����˵���
  form_pop.game_love_word_role:= n;
  
    if  form_pop.ShowModal= mrok then
     begin
      //ÿ��20�����ʣ��аٷ�֮һ�Ļ���ʹ�ð���ֵ����һ��
       k:= i div 20;
       for j:= 1 to game_get_role_H do
        begin
         if Tplayer(Game_role_list.Items[j]).pl_old_name = n then
            begin
             for m:= 1 to k do
              begin
              if Game_base_random(100)= 1 then
                begin
                game_write_values(j,14,game_read_values(j,14)+1);
                 game_write_values(j,15,game_read_values(j,15)+1);

                end;
              end; //end for m
            end;  //if
        end; //for j

      result:= 1;
     end;

end;

procedure TForm1.game_load_doc(path: string);

    function bianli_dir(Path2: string): boolean;
   var
  FindData: TWin32FindData;
  FindHandle: THandle;
  FileName: string;
   begin
  Result := false;

  Path2 := Path2 + '*.*';

  FindHandle := Windows.FindFirstFile(PChar(Path2), FindData);
  while FindHandle <> INVALID_HANDLE_VALUE do
  begin
    FileName := StrPas(FindData.cFileName);
    if (FileName <> '.') and (FileName <> '..') and
      ((FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then
    begin
      if FileExists(Game_save_path+ FileName + '\Player0.upp') then
      begin
       Game_save_path:= Game_save_path + FileName +'\';
       result:= true;
       break;
      end else begin
                Game_save_path:= Game_save_path + FileName +'\';
                result :=bianli_dir(Game_save_path); //�ݹ����
                if result then
                  break;
               end;
    end;

    if not Windows.FindNextFile(FindHandle, FindData) then
      FindHandle := INVALID_HANDLE_VALUE;
  end;
  Windows.FindClose(FindHandle);
   end;

begin
    //����浵������Ϊ�浵Ŀ¼
   if not game_doc_is_ok(path) then
    begin
      messagebox(handle,'��Ч�Ĵ����ļ������ܴ����ļ��������޸ġ�','��Ч',mb_ok);
      exit;
    end;

    Game_loading:= true;
    
  Game_save_path:= path; //����·�����������ļ���
   temp_event_clean; //�����ʱ��

     if not FileExists(Game_save_path +'Player0.upp') then
      begin
        if not bianli_dir(Game_save_path) then
        begin
        messagebox(handle,'��Ϸ�����ļ������ڣ����̲��ɹ���','��Ч',mb_ok);
        Game_loading:= false;
         exit;
         end;
      end;

   form_pop.load_game_progress(path+ 'default.sav');
   //�����������
   game_role_clean;
     
   game_role_list.Add(Tplayer.create(Game_save_path +'Player0.upp'));
  game_load_friend_list(Game_save_path + 'friend.fpp'); //�������б�

  if not FileExists(Game_save_path +'event.fpp') then
      begin
        messagebox(handle,'��Ϸ��¼�ļ������ڣ����̲��ɹ���','��Ч',mb_ok);
        Game_loading:= false;
         exit;
      end;
  data2.load_event_file(Game_save_path + 'event.fpp');   //�����¼�
  //����ͷ��
    data2.Load_file_upp(game_app_path_G+'dat\touxian.upp',Game_touxian_list_G);

  Phome_id:= game_read_scene_event(999); //��ȡ�س���
  Data2.load_goods_file; //������Ϸ��Ʒ������
  Data2.game_load_goods; //������Ʒ
   game_load_image_to_imglist; //��������ͷ��
   Data2.game_load_task_file; //���������б�
   Form_pop.laod_fashu_wupin_k(Game_save_path + 'fwk.dat');   //���뷨����Ʒ��ݼ��б�
  button_stat(true); //����button״̬
   form_pop.load_abhs; //����abhs��
 // if (Game_scene_type_G and 2 = 2) or (Game_scene_type_G =1) then  //���Թ�
  //  Game_is_reload:= true; //��������ǰ����

    //���out�ļ����ڣ���ô�ؽ�guid������ʱ�����Ŀ¼Ȼ��out�ļ��ͱ�ɾ���ˡ�
    if FileExists(Game_save_path+'out.txt') then
           game_guid:= game_create_guid
           else
            game_guid:= game_read_scene_string(998); //��ȡguid��������ڣ������guid


  game_page(game_read_scene_event(1000)); //��ʾ���̵ĳ���
  Game_loading:= false; //���ñ��������¿�ʼ�ļ�id���

end;

procedure TForm1.game_save_doc(path: string);
begin
           // ����浵
  Game_save_path:= path; //����·�����������ļ���
  {
  1  �����������
  2  �������б�
  3  �����¼��б�
  4  ������Ʒ
  }


    DeleteDirNotEmpty(path); //���Ŀ¼
   Tplayer(Game_role_list.Items[0]).saveupp(Game_save_path + 'Player0.upp');
   game_save_friend_list(Game_save_path + 'friend.fpp');
    game_write_scene_string(998,game_guid); //����guid
    game_write_scene_event(999,Phome_id);  //����سǵ�
    game_write_scene_event(1000,pscene_id);          //���浱ǰ����id
   data2.save_file_event(Game_save_path + 'event.fpp');
   Data2.game_save_goods; //������Ʒ
   Data2.game_save_task_file; //���������б�
   Form_pop.save_fashu_wupin_k(Game_save_path + 'fwk.dat');   //���淨����Ʒ�����

      form_pop.save_abhs; //����abhs��
      form_pop.save_set(path);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   form_exit.Button2.Enabled:= Game_not_save and not game_at_net_g;
   //form_exit.Button1.Enabled:= game_bg_music_rc_g.desktop_word;
   
    case form_exit.ShowModal of
     mrcancel: canclose:= false;
     mrok: begin
             //�������汳����
             canclose:= false;
             postmessage(handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
           end;
     mryes: begin
             //���̲��˳�
             game_save(0);
            end;
     //mrno: ֱ���˳�
     end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if game_at_net_g then
     begin
      messagebox(handle,'������Ϸ�����ȡ���ȡ�','��ʾ',mb_ok);
     exit;
     end;
   game_save2;
end;

function TForm1.game_read_scene_event(i: integer): integer;  //��ȡ���̵ĳ���id���߱������
begin
 if Game_at_net_G then  //�����������ȡ��һ������
  result:= game_read_scene_integer(i)
 else
  result:= data2.game_memini_event.readInteger('EVENTS',inttostr(i),10001);
end;

procedure TForm1.game_write_scene_event(i,v: integer);
begin
  if Game_at_net_G then  //���������д����һ������
   game_write_scene_integer(i,v)
  else
  data2.game_memini_event.WriteInteger('EVENTS',inttostr(i),v);

end;

function TForm1.game_del_friend(n: string; b: integer): integer; //ɾ��һ�����ѣ�b=1 ��ʾ����
var i: integer;
str1: Tstringlist;
    ss,ss2: string;
begin
     str1:= Tstringlist.Create;
     data2.Load_file_upp(game_app_path_G+ 'persona\ext.upp',str1);
     Assert(str1.count > 0,'��Ч��������ձ�������Ϸ��ɫʧ�ܡ�');
       ss:= str1.Values[n]; //ȡ����Ϸ������ļ���
     str1.Free;
  if Game_friend_list.IndexOf(n)> -1 then
     begin
     Game_friend_list.Delete(Game_friend_list.IndexOf(n));
     combobox2.Items.Delete(combobox2.Items.IndexOf(n));
     combobox2.Text:= '����б�';
       for i:= 0 to game_role_list.Count- 1 do
        begin
          //��λ
          //�����ɫ���ݵ�dat�ļ�����
          //���ڴ�ж������
          if Tplayer(Game_role_list.Items[i]).pl_old_name = n then
           begin
            Tplayer(Game_role_list.Items[i]).
             saveupp(game_doc_path_g+ 'dat\'+ ss); //�����α��߳�������
              if b= 1 then  //b����һ����ʾ��ʾ����
               begin
               if game_read_values(i,ord(g_sex))= 1 then
                  ss2:= 'Ϧ�����£�������һ��ĬĬ�����ˡ�'
                  else
                   ss2:= '��ת�����ĵ���ȥ�ˡ�';
              messagebox(handle,pchar('�����������߳���'+ n +'��'+ ss2),
                      '���ڲ�����',mb_ok or MB_ICONINFORMATION);
               end;
             Tplayer(Game_role_list.Items[i]).Free;
             game_role_list.Delete(i); //���б���ɾ������
             
             break;
           end;
        end;

       result:= 1;
     end else result:= 0;

end;

function TForm1.game_random_chance(i: integer): integer;
var a,b: integer;
begin
       //�ж���������Ƿ�����
   result:= ord( Game_base_random(i)= 1);
    if result= 0 then
     begin
      a:= i * 5;
      b:= i* 10;
           //����������ֵӰ�����
       i:=a+ round(abs(1-abs((game_get_role_suxing(1,1) + game_get_role_suxing(1,7)-100)) /100) * b);
       result:= ord( Game_base_random(i)= 1);
       
     end;
end;

function TForm1.game_random_chance_at_sleep(i: integer): integer;
begin
     //�ж���������Ƿ���������ʱ�Բ�����������

     sleep(1);
    result:= game_random_chance(i);
end;

function TForm1.game_rename(oldname: string): integer;
var b: boolean;
    i: integer;
    newname: string;
begin
result:= 0;
b:= false;

        newname:= inputbox('������һ���µ�������','�µ�������    ','');

   if trim(newname)= '' then
    begin
     exit;
    end else if pos('',newname)> 0 then
                 b:= true
                  else if pos('fuck',newname)> 0 then
                   b:= true
                   else if pos('kao',newname)> 0 then
                   b:= true
                   else if pos('cao',newname)> 0 then
                   b:= true
                   else if pos('��',newname)> 0 then
                   b:= true
                   else if pos('��',newname)> 0 then
                   b:= true
                   else if pos('����',newname)> 0 then
                   b:= true
                   else if pos('����',newname)> 0 then
                   b:= true
                   else if pos('��',newname)> 0 then
                   b:= true
                   else if pos('����',newname)> 0 then
                   b:= true
                   else if pos('���',newname)> 0 then
                   b:= true
                   else if pos('����',newname)> 0 then
                   b:= true
                   else if pos('��',newname)> 0 then
                   b:= true
                   else if pos('����',newname)> 0 then
                   b:= true
                   else if pos('<!!!',newname)> 0 then
                   b:= true
                   else if pos('(',newname)> 0 then
                   b:= true
                   else if pos('��',newname)> 0 then
                   b:= true
                   else begin
                          if oldname= '' then
                            Tplayer(Game_role_list.Items[0]).plname:= trim(newname)
                             else begin  //�޸��������������
                                   for i:= 0 to  Game_role_list.Count-1do
                                    begin
                                      if Tplayer(Game_role_list.Items[i]).pl_old_name= oldname then
                                       begin
                                        // if game_extfile_rename(oldname, newname) then
                                            Tplayer(Game_role_list.Items[i]).plname:= trim(newname);

                                         exit;
                                       end;
                                    end;
                                  end;
                        end;
  if b then
   messagebox(handle,'���������ں��в����ʻ�������ţ��������','���õ�����',mb_ok or MB_ICONWARNING);

end;
 {

function TForm1.game_extfile_rename(oldname, newname: string): boolean;   //��������ձ�������µ�����
var str1: Tstringlist;
begin

     str1:= Tstringlist.Create;
     data2.Load_file_upp(ExtractFilePath(application.ExeName)+ 'persona\ext.upp',str1);

     Assert(str1.count > 0,'��Ч��������ձ��޸Ļ������ʧ�ܡ�');

     if str1.Values[newname]<> '' then
      begin
       messagebox(handle,pchar(newname +' �Ѿ���ͬ��������ڡ�'),'ע��',mb_ok or MB_ICONWARNING);
       result:= false;
       str1.Free;
       exit;
      end;

      str1.Append(newname+ '='+ str1.Values[oldname]); //���һ���µĶ�������

      data2.save_file_upp(ExtractFilePath(application.ExeName)+ 'persona\ext.upp',str1); //����
     str1.Free;

     result:= true;
end;
          }
function TForm1.game_checkname_abc(n: string): integer;
var i: integer;
begin
      //��������Ƿ����ģ�����Ϊ�ձ�ʾ������ǣ��ú�����Ҫ��Ϊ��Ϸ����һ����˼��
      //�ú����жϵ�һ���ֽ��Ƿ�Ϊ����ǰ׺�����˶���

result:= 0;
       if n= '' then
        n:= Tplayer(Game_role_list.Items[0]).pl_old_name;

      //�����ں�����ĸ���ֵȣ�����true
      for i:= 1 to length(n) do
       if ByteType(n,i)= mbSingleByte then
        begin
          result:= 1;
          exit;
        end;
end;

function TForm1.game_reload(i: integer): integer;  //�������뵱ǰ����
begin
   if game_auto_temp_g= 1 then
      game_auto_temp_g:= 2;  //������д����ʱ������ģ��������ر��
   result:= game_show_scene(pscene_id);
end;

function TForm1.game_add_message(const s: string): integer;
begin
        //���һ����ʾ��Ϣ
    if not Assigned(game_message_txt) then
       game_message_txt:= Tstringlist.Create;

      game_message_txt.Append(s);
result:= 1;
end;

function TForm1.game_add_task(id: integer): integer; //�������
begin

  //���¼���¼����Ӽ�¼
   if self.game_not_res_event(id)=1 then  //�¼������ڣ���ӣ����ظ����
    begin
  self.game_add_res_event(id);
  Data2.game_addto_uncomplete(inttostr(id));//��δ����б�����Ӽ�¼
    end;

  game_reload_chatlist(0);
result:= 1;
end;

function TForm1.game_comp_task(id: integer): integer;    //�������
var ss: string;
   i,j,k,m,n: integer;
begin
    //�������
result:= 0;

    if self.game_not_res_event(id)=1 then    //��������¼������ڣ��˳�
      exit;

  self.game_del_res_event(id);
  Data2.game_addto_complete(inttostr(id));

  //�����Ʒ����Ǯ������ֵ
   ss:= Data2.game_get_task_s(inttostr(id)); //ȡ�ؾ�������

   if ss= '' then
    begin
     game_chat('��ȡ����ʧ�ܣ����������ļ���ɾ����');
     exit;
    end;

j:= 0;
m:= 0;
n:= 0;
    for i:= 1 to length(ss) do
     begin
       if ss[i] in['0'..'9'] then
          begin
           if j= 0 then
             j:= i;
          end else begin
                    if (j<> 0) and (i>j) then
                     begin
                      k:= strtoint2(copy(ss,j,i-j));
                      j:= 0 ; //j�ָ�Ϊ��ֵ
                      inc(m);
                       case m of
                        1: begin
                            game_write_values(0,0,game_read_values(0,0) +k); //��ӽ�Ǯ
                            game_chat('��Ǯ���ӣ�'+ inttostr(k));
                           end;
                        2: begin
                            game_write_values(0,19,game_read_values(0,19) +k);
                             //���
                             game_chat('����ֵ���ӣ�'+ inttostr(k));
                             k:= form_pop.game_upgrade(1);
                             if k> 0 then
                              game_chat('�ȼ���������'+ inttostr(k));
                           end;
                        3: n:= k; //��Ʒ����
                        end;
                     end;
                   end;

     end; //end for

     if n> 0 then
      begin
        j:= pos('��',ss);
        k:= pos('��',ss);
        if (j>0) and (k>j) then
         begin
           write_goods_number(form_goods.get_goods_id(copy(ss,j+2,k-j-2)),n);
            game_chat('�õ���Ʒ'+copy(ss,j+2,k-j-2)+' ������'+ inttostr(n));
         end;
      end;
      game_write_values(0,ord(g_morality),game_read_values(0,ord(g_morality)) +1);
     //���ӵ���ֵһ��
 game_reload_chatlist(0);
 result:= 1;
end;

function TForm1.game_create_guid: string;
 var g: tguid;
begin
     CoCreateGUID(g);
   result:= GUIDToString(g);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if game_role_list.Count=0 then
  begin
   messagebox(handle,'��Ϸû�п�ʼ����������ġ���ʼ������Ϸ�����ߡ���ʼ������Ϸ����������Ϸ���ߴ�ȡ���ȡ�','��Ϸû��ʼ',mb_ok);
   exit;
  end;

  if not Assigned(form_task) then
     form_task:= Tform_task.Create(application);

     form_task.ShowModal;
end;

procedure TForm1.Game_scr_clean3;   //�������򼸸���

begin
      change_html_by_id('cell_chat1','����');

  game_chat_cache_g:= ''; //������컺��

end;

procedure TForm1.button_stat(b: boolean);
begin
    button1.Enabled:= b;
  button5.Enabled:= b;
end;

procedure TForm1.change_html_by_id(const id, html: string);
var ss: string;
begin
   ss:= StringReplace(html,'\','/',[rfReplaceAll]);
   ss:= StringReplace(ss,'"','\"',[rfReplaceAll]);
   ss:= StringReplace(ss,#13#10,'',[rfReplaceAll]);
   ss:= 'document.getElementById("'+id+ '").innerHTML="'+ss+'";';



   web1.ExecuteJavascript(ss);
end;

function TForm1.game_check_goods_nmb(n: string; i: integer): integer;
var j: integer;
begin
       //���ĳ��Ʒ�����Ƿ��м������У����� 1
     if n= '' then
      result:= 0
       else begin
              j:= form_goods.get_goods_id(n);
              if j= 0 then
               result:= 0
                else if read_goods_number(j)>= i then
                        result:= 1
                         else
                          result:= 0;
            end;

end;

procedure TForm1.temp_event_clean;
begin
   Game_migong_xishu:= 0; //������﹥��ϵ��
   Game_temp_event.Clear;
end;

function TForm1.game_check_temp(id, values: integer): integer;
begin
 //�Ƚ��¼������Ƿ���ڵ���ָ��ֵ
  if Game_temp_event.Values[inttostr(id)]= '' then
     result:= 0
      else if strtoint2(Game_temp_event.Values[inttostr(id)]) >= values then
       result:= 1
        else result:= 0;
end;

function TForm1.game_read_temp(id: integer): integer;
begin
  // ��ȡ�¼���ֵ�������ڣ�����0
   if Game_temp_event.Values[inttostr(id)]= '' then
     result:= 0
      else
       result:= strtoint2(Game_temp_event.Values[inttostr(id)]);
end;

function TForm1.game_write_temp(id, values: integer): integer;
begin
  //д��һ����ʱ�¼�,id���¼�����values���¼�����
  game_auto_temp_g:= 1; 
  Game_temp_event.Values[inttostr(id)]:= inttostr(values);
  result:= 1;
end;

function TForm1.game_can_stop_chat(i: integer): integer;
begin
//1,���Խ�������  0, ��ֹ�������죨���ڱ��������ȥ�ĶԻ�)
     //����ֵ 8 Ϊ��ֹ��������
  if i= 0 then
   begin
   Game_scene_type_G:= Game_scene_type_G or 8;
    button3.Enabled:= false;
   end else begin
             Game_scene_type_G:= Game_scene_type_G and not 8;
             button3.Enabled:= true;
            end;
            
 game_enabled_scene(i);
result:= 1;
end;


function TForm1.game_enabled_scene(i: integer): integer;
var
    ss: string;
begin


     // 1,��������ڣ�0�����ó�������
    if i= 1 then
     begin
      game_reload_direct(0);

     end else begin
                 ss:= 'var div=document.createElement("<div style=width:100%;background:#cccccc;position:absolute;left:0;right:0;top:0;bottom:0;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:63;height:100%;>");'+
                  'var iframe=document.createElement("<iframe style=width:100%;background:#cccccc;position:absolute;left:0;right:0;top:0;bottom:0;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:62;height:100%;>");'+
                  'document.getElementsByTagName("body")[0].appendChild(iframe);'+
                  'document.getElementsByTagName("body")[0].appendChild(div);';
                web1.ExecuteJavascript(ss);
              { tt:= pdoc.createElement('div');
               tt.id:= 'sce_1';
               tt.style.backgroundColor:= clblue;
               tt.style.zIndex:= 2;   }

              // <script>
 // function   test()
  {
    var   div   =   document.createElement("<div   class='dis'   oncontextmenu='return   false;'>");
    var   iframe   =   document.createElement("<iframe   class='dis'   style='z-index:8;'>");
    document.getElementsByTagName("body")[0].appendChild(iframe);
    document.getElementsByTagName("body")[0].appendChild(div);
  }   
 // </script>
               //  (pdoc.body as DispHTMLGenericElement).appendChild(tt);
              // tt.parentElement:= pdoc.body;

              // (WebBrowser1.Document as IHTMLDocument2).body.all
             //  (WebBrowser1.Document as IHTMLDocument3).getElementsByTagName('body').appendChild(
                                               

              // (WebBrowser1.Document as IHTMLDocument3).getElementsByTagName('body').item[0].appendChild(
                             //    pdoc.createElement('iframe');
              end;

 result:= 1;
end;

function TForm1.game_functions_m(const s: string): integer;
var i,p_pos,p_end,j,k: integer;
    ss,ss_result: string;
     function get_L_integer(i_pos: integer): integer;
      var i9: integer;
      begin
        get_L_integer:= 0;
        for i9:= I_pos downto 1 do
         begin
          if not (ss[i9] in ['0'..'9','-']) then
            begin
             get_L_integer:= strtoint2(copy(ss,i9+ 1,I_pos-i9));
             break;
             end;
           if i9= 1 then
              get_L_integer:= strtoint2(copy(ss,1,I_pos));
         end;
      end; //end function
     function get_R_integer(i_pos: integer): integer;
      var i9: integer;
      begin
        get_R_integer:= 0;
        for i9:= I_pos to length(ss) do
         begin
          if not (ss[i9] in ['0'..'9','-']) then
            begin
             get_R_integer:= strtoint2(copy(ss,i_pos,i9-i_pos));
             break;
             end;
           if i9= length(ss) then
              get_R_integer:= strtoint2(copy(ss,i_pos,length(ss)));
         end;
      end; //end function
     procedure set_space(i_pos: integer; v: char); //��������λΪ�ո����һλ��ֵ
       var i9: integer;
      begin
         ss[i_pos]:= ' ';
        for i9:= I_pos-1 downto 1 do
          if ss[i9] in ['0'..'9'] then
             ss[i9]:= ' '
             else break;

        for i9:= I_pos+1 to length(ss) do
         begin
            if ss[i9] in ['0'..'9'] then
            ss[i9]:= ' '
             else begin
                   ss[i9-1]:= v;
                   break;
                  end;
            if i9= length(ss) then
               ss[i9]:= v;
         end;
      end;
      procedure set_space_insert(i_pos: integer; v: integer); //��������λΪ�ո����һλ��ֵ
       var i9: integer;
      begin
       ss[i_pos]:= ' ';
        for i9:= I_pos-1 downto 1 do
          if ss[i9] in ['0'..'9','-'] then
             ss[i9]:= ' '
             else break;

        for i9:= I_pos+1 to length(ss) do
         begin
            if ss[i9] in ['0'..'9','-'] then
            ss[i9]:= ' '
             else begin
                   insert(inttostr(v),ss,i9-1);
                   break;
                  end;
            if i9= length(ss) then
               insert(inttostr(v),ss,i9);;
         end;
      end;
     procedure ccc(L: integer);
      var i8: integer;
      begin
        for i8:= L to length(ss) do //���ȴ���not��
          begin
            case ss[i8] of
            '!': begin
                if ss[I8+ 1]='0' then
                    ss[I8+ 1]:='1'
                     else
                      ss[I8+ 1]:= '0';
                 ss[I8]:= ' ';
                 end;
            '*': begin
                  set_space_insert(i8, get_L_integer(I8-1) *
                                       get_R_integer(I8+1));
                 end;
            '/': begin
                  set_space_insert(i8, get_L_integer(I8-1) div
                                       get_R_integer(I8+1));
                 end;
            ')': begin
                   break;
                 end;
              end;
          end;

         ss:= stringReplace(ss, ' ', '', [rfReplaceAll]);  //���˿ո�

          for i8:= L to length(ss) do //�ٴ��� and or
          case ss[I8] of
            '+': begin
                  set_space_insert(i8, get_L_integer(I8-1) +
                                       get_R_integer(I8+1));
                 end;
            '-': begin
                  set_space_insert(i8, get_L_integer(I8-1) -
                                       get_R_integer(I8+1));
                 end;
           '&': begin  //and �жϣ���һ��Ϊ�㣬���Ϊ��
                 if (ss[I8-1]= '1') and (ss[I8+1] = '1') then
                    ss[I8+1]:= '1'
                     else
                      ss[I8+1]:= '0';
                 ss[I8-1]:= ' ';
                 ss[I8] := ' ';
                end;
           '|': begin
                 if (ss[I8-1]='1') or (ss[I8+1]= '1') then
                    ss[I8+1]:= '1'
                     else
                      ss[I8+1]:= '0';
                 ss[I8-1]:= ' ';
                 ss[I8] := ' ';
                end;
           ')': break;
           end;

         ss:= stringReplace(ss, ' ', '', [rfReplaceAll]);  //���˿ո�

        for i8:= L to length(ss) do   //����� ���ڣ�������
          case ss[I8] of
           '<': begin
                 if get_L_integer(I8-1) < get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');

                end;
           '>': begin
                 if get_L_integer(I8-1) > get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');

                end;
           '=': begin
                 if get_L_integer(I8-1)= get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
           '$': begin
                 if get_L_integer(I8-1)<= get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
            '@': begin
                 if get_L_integer(I8-1) >= get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
           '#': begin
                 if get_L_integer(I8-1)<> get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
           ')': begin
                 ss[I8]:= ' ';
                 exit;
                end;
           end;
      end;
begin
     //һ��ִ�в����ڶຯ������or and�ؼ��ִ����
     //������Ϊ���������������or and�ؼ��֣��� game_xxx(0)and game_xxx2(0)
     //��ת���^����Ϊ������

ss_result:= '';
if s= '' then
 begin
  result:= 0;
  exit;
 end;
     if fastcharpos(s,'^',1)> 0 then
        ss:= stringReplace(s, '^', '''', [rfReplaceAll])
         else
           ss:= s;

      //Ԥ�ȼ��㺯������ֵ
         p_end:= 0;
         p_pos:= fastpos(ss,'game_',length(ss),5,1);
         while p_pos >0  do
          begin
           ss_result:= ss_result + copy(ss,p_end+1,p_pos-p_end-2);
                k:= 0; //�������
               for j:= p_pos to length(ss) do
                  if ss[j]= '(' then
                     inc(k)
                      else if ss[j]= ')' then
                             begin
                              dec(k);
                              if k= 0 then
                                begin
                                 p_end:= j;
                                 break; //�˳�for
                                end;
                             end;

              if p_end > p_pos then
               begin
                i:= Game_action_exe_A(copy(ss,p_pos,p_end-p_pos+1));
                if (i= 1881) and (pos('game_pop_a(',ss)= p_pos) then
                 begin
                   i:= 1;  //������game_pop_a
                   game_html_pop_str_g:= '123'; //����һ��3���ֵ�ֵ���Է���length=3�����
                 end;
                 ss_result:= ss_result + inttostr(i);
               end;
           p_pos:= fastpos(ss,'game_',length(ss),5,p_end);
            if p_pos= 0 then
             begin
               if p_end < length(ss) then
                  ss_result:= ss_result + copy(ss,p_end+ 1,length(ss)-p_end);
             end;
          end; //end while
          if ss_result = '' then
             ss_result:= ss;
      //�滻�ַ�Ϊ������
         ss:= stringReplace(ss_result, ' ', '', [rfReplaceAll]);  //���˿ո�
         ss:= stringReplace(ss, 'and', '&', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, 'or', '|', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, 'not', '!', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, '<>', '#', [rfReplaceAll,rfIgnoreCase]);
          ss:= stringReplace(ss, '<=', '$', [rfReplaceAll,rfIgnoreCase]);
          ss:= stringReplace(ss, '>=', '@', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, ';', '', [rfReplaceAll]);

        if length(ss)= 1 then //���ֵֻ��һλ����ô������һ������
         begin
          result:= strtoint2(ss);  //����
          exit;
         end;
      //���Ŵ���
       for i:= length(ss) downto 1 do
        begin
          if ss[i]= '(' then
            begin
              ss[i]:= ' ';
              ccc(i + 1);
              ss:= stringReplace(ss, ' ', '', [rfReplaceAll]);  //���˿ո�
            end;
        end;

          for i:= 0 to 10 do
           if length(ss)> 1 then
            ccc(1); //����������ķ���

         ss:= trim(ss);  //���˿ո�

         if length(ss)<> 1 then
         result:= 0
         else
          result:= strtoint2(ss);  //����


end;

function TForm1.game_role_is_exist(n: string): integer;
var i: integer;
begin
                 //������������ڣ����� 1
result:= 0;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        result:= 1;
        exit;
      end;

end;

function TForm1.game_set_role_0_hide(n: string; x: integer): integer;
var i: integer;
begin
        //�������أ���ʾĳ������ֶ����ص�������ֶ���ʾ
        //��Ϊ�������ֻ����ս��ʱ�Ƿ���ʾ���ѣ��Ի����ǰ������ļ����ġ�
        //���ǵ� n= ����
result:= 1;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        game_write_values(i,4, x);
        exit;
      end;



end;

function TForm1.game_role_only_show(n: string): integer; //����ʾ���ˣ���������ȫ��
var i: integer;
begin
  
  for i:= 0 to Game_role_list.Count-1 do
   begin
    game_write_values(i,29,
                game_read_values(i,4)); //����ԭ�ȵ�״̬
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        game_write_values(i,4,1);
      end else
           game_write_values(i,4,0);
   end; //end for

  Game_is_only_show_G:= true; //����only show ��־����goods�����ж�
 result:= 1;
end;

function TForm1.game_role_reshow: integer;  //�ָ������������ʾ
var i: integer;
begin
  for i:= 0 to Game_role_list.Count-1 do
    game_write_values(i,4,
                game_read_values(i,29)); //�ָ�ԭ�ȵ�״̬

    Game_is_only_show_G:= false; //�ָ� only show ��־
result:= 1;
end;

function TForm1.game_bet(id, flag: integer): integer;
var m: integer;
begin
        //��Ǯ������Ϊһ����ʱ��id��Ѻ��С��1��0С��Ӯ�˷��� 1
result:= 0;

    m:= game_read_temp(id);  //ȡ��Ѻ�Ľ��
    if m= 0 then
     begin
      m:= game_read_values(0,0);
      game_write_temp(id,m);
     end;
    if game_pop(1)= 1 then
       begin

     if flag= 1 then
      begin
       //Ѻ��
       if Game_base_random(3)= 1 then   //Ӯ�Ļ���������֮һ
          result:= 1;
      end else begin
                 if Game_base_random(3)= 0 then
                    result:= 1;
               end;

       end;

      //Ӯ�ˣ���Ǯ����
    if result= 1 then
       game_write_values(0,0,
            game_read_values(0,0) + m)
            else
             game_write_values(0,0,
            game_read_values(0,0) - m);

end;

function TForm1.game_read_temp_string(id: integer): pchar;
begin

        Game_pchar_string_G:= Game_temp_event.Values[inttostr(id)];
        if Game_pchar_string_G='' then
           Game_pchar_string_G:= ' ';

        result:= pchar(Game_pchar_string_G);

end;

function TForm1.game_write_temp_string(id: integer; const values: string): integer;
begin
  game_auto_temp_g:= 1;
  Game_temp_event.Values[inttostr(id)]:= values;
  result:= 1;
end;

function TForm1.game_check_role_values(n: string; i, v: integer): integer;
var j: integer;
begin
       //���ĳ�������ĳ����ֵ�Ƿ�ﵽĳֵ
result:= 0;
     for j:= 0 to game_get_role_H do
      begin
       if Tplayer(Game_role_list.Items[j]).pl_old_name= n then
        begin
          if game_read_values(j,i)>= v then
           begin
            result:= 1;
            exit;
           end;
        end;

      end; //end for
end;

function TForm1.game_newname_from_oldname(const n: string): pchar;
var i: integer;
begin

result:= pchar(n); //���û���ҵ�����ô����ԭ��

      for i:= 0 to Game_role_list.Count-1 do
      if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
        begin
         Game_pchar_string_G:= Tplayer(Game_role_list.Items[i]).get_name_and_touxian;
          result:= pchar(Game_pchar_string_G);
          exit;
        end;

        //����ԭʼ������ȡ�µ��������ƣ���Ϊ��Ϸ��������޸����Ǻ���ǵ�����


end;

function TForm1.game_pop_a(i: integer): integer;
begin
        //���������ʴ��ڣ�������Ч��
  if checkbox1.Checked then //����ģʽ��ֱ��·��
      begin
       result:= 1;
       exit;
      end;

         if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ�������ģʽ�����������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

    form_pop.game_pop_count:= i;
    form_pop.game_is_a:= true;
    form_pop.game_pop_type:= 1; //������
    if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(2, i,0);

    if (game_bg_music_rc_g.mg_pop=false) and (Game_scene_type_G and 2=2) then
     begin

        html_pop(i); //�Թ�������htmlģʽ�ĵ��������ʴ���
        result:= 1881;  //1881,Լ����ָ���ֵ

     
     end else
          result:= ord (form_pop.ShowModal= mrok);
   Perform($000B, 1, 0);
  // RedrawWindow(self.WebBrowser1.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE + RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);
end;
   {
function   TForm1.WBLoadFromStream(const   AStream:   TStream;   WB:   TWebBrowser):   HRESULT;
  var
      PersistStream:   IPersistStreamInit;
  begin

        try
      PersistStream   :=   WB.Document   as   IPersistStreamInit;
      PersistStream.InitNew;
      AStream.seek(0,   0);
     // (WB.Document   as   IPersistStreamInit).Load(nil);
      Result   :=   (WB.Document   as   IPersistStreamInit).Load(TStreamadapter.Create(AStream));
       finally
      PersistStream._Release;
      PersistStream := nil;
       end;
  end;
       }
function TForm1.game_change_money(i: integer): integer; //�޸Ľ�Ǯ
begin
   game_write_values(0,0,
            game_read_values(0,0) + i);

  result:= 1;
end;

function TForm1.game_direct_page(id: integer): integer; //ֱ�Ӷ���html�����Խű���ת��Ч��������������
begin
        if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ�������ģʽ�����������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

     Game_scr_clean2; //���촰������
  game_direct_scene(id);
  result:= 1;
end;

function TForm1.game_direct_scene(id: integer): integer; //ֱ�Ӷ���html�����Խű���ת��Ч��
var str1: Tstringlist;

begin
  str1:= Tstringlist.Create;
  Game_action_list.Clear; //�������
  Game_chat_list.Clear;

      game_page_id_change(id);//���泡��id

      game_tianqi_G:= 0;  //����ս��������������Ч��Ϊ�Զ�
    data2.load_scene(inttostr(id),str1); //��ֳ�����html

    if not game_reload_chat_g then  //��������������¼���򲻶���
    begin
    web1.LoadHTML(str1.Text);
    end;

  str1.Free;
result:= 1;

end;

function TForm1.game_reload_direct(i: integer): integer; //���Խű���ת��Ч�����������뵱ǰҳ��
begin
   if game_auto_temp_g= 1 then
      game_auto_temp_g:= 2;  //������д����ʱ������ģ��������ر��
      
   Game_is_reload:= true; //��������ǰ��ű���ִ��
   result:= game_direct_scene(pscene_id);

   if game_chat_cache_g<> '' then
     begin
      if pos('<iframe',game_chat_cache_g)> 0 then
         game_chat_cache_g:= ''
         else
          game_chat(game_chat_cache_g); //������ʾ�������
     end;
end;

function TForm1.game_read_scene_string(id: integer): pchar;
begin
     //�ӳ������ȡ�ַ���
     Game_pchar_string_G:= data2.game_memini_event.ReadString('EVENTS',inttostr(id),'');
   result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_write_scene_string(id: integer;
  const values: string): integer;
begin
     //д���ַ�����������
  Game_not_save:= true;
  data2.game_memini_event.WriteString('EVENTS',inttostr(id),values);
  result:= 1;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin

  form_langdu.CheckBox1.Checked:= game_bg_music_rc_g.yodao_sound;
 form_langdu.Show;
end;

procedure TForm1.Button13Click(Sender: TObject);
var ss: string;
begin
{$IFDEF game_downbank}
    // ss:= 'url.dll,FileProtocolHandler http://www.downbank.cn';
     ss:= 'http://www.downbank.cn';
   {$ELSE}
      ss:= 'http://tieba.baidu.com/f?ie=utf-8&kw=%E7%A5%9E%E9%95%9C%E4%BC%A0%E8%AF%B4';

    // ss:= 'url.dll,FileProtocolHandler http://hi.baidu.com/3030/blog/item/41bd36d19aa47b3a9b502783.html';
  {$ENDIF}

ShellExecute(Handle,
              'open',pchar(ss),nil,nil,sw_shownormal);
              
{ShellExecute(Handle,
  'open','rundll32.exe',
  pchar(ss),nil,sw_shownormal);}

end;

function TForm1.game_role_count(c: integer): integer;
begin
    //��ѯ������������Ϊ�㣬�������������������㣬���бȽϡ�������ڵ���c������1�����򷵻���
    if c= 0 then
     result:= Game_role_list.Count
      else begin
       if Game_role_list.Count >= c then
          result:= 1
           else
            result:= 0;
       end;

end;

function TForm1.game_role_sex_count(x: integer): integer;
var i: integer;
begin
       //����ָ���Ա��������������1Ϊ�У�0ΪŮ
result:= 0;

    for i:= 0 to Game_role_list.Count - 1 do
        begin
          if game_read_values(i,12)= x then
             inc(result);
        end; //end for i

end;

function TForm1.game_get_newname_at_id(x: integer): pchar;  //�������кŷ����µ����֣�1Ϊ��һ����2Ϊ�ڶ���
begin
if x<=0 then
x:= 1;


        if Game_role_list.Count >= x then
           Game_pchar_string_G:= Tplayer(game_role_list.Items[x-1]).get_name_and_touxian
           else
             Game_pchar_string_G:= ' ';

result:= pchar(Game_pchar_string_G);


end;

procedure TForm1.game_write_home_id;
begin
  //��ǰ��ʾ�ĳ���id����Ϊ�سɵ�
    Phome_id:= pscene_id;
end;

function TForm1.game_goto_home(i: integer): integer;
begin
   //�س�
   if (Game_scene_type_G and 8 = 8) or timer1.Enabled or Game_not_gohome_G then  //����������Ի������߶�ʱ�������£�������س�
    begin
     if i= 0 then
       messagebox(handle,'�س�ʧ�ܣ���ǰ����������سǡ�','�س�ʧ��',mb_ok);
     result:= 0;
    end else begin
   if Phome_id= 0 then
    result:= 0
    else begin
          game_page(Phome_id);
          result:= 1;
         end;
            end;
end;

function TForm1.game_attribute_change(p, id, v: integer): integer;
var i: integer;
begin
 result:= 1;
     //�޸�����ֵ����һ����������ɫ��0��ʾȫ��,1��ʾ��һ�����2�ڶ������ڶ����������Ա�ţ��������������Ӽ�ֵ

   if p= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
           game_write_values(i,id,game_read_values(i,id) +v);
           if game_read_values(i,id)< 0 then
              game_write_values(i,id,0);

        end;
    end else begin
              if p<= game_get_role_H+1 then
               begin
                 game_write_values(p-1,id,game_read_values(p-1,id) +v);
                 if game_read_values(p-1,id)< 0 then
                     game_write_values(p-1,id,0);
               end  else
                  result:= 0;
             end;
end;

function TForm1.game_id_is_name(id: integer; n: string): integer; //��id�Ƿ����ָ���������idΪ��ǰrole�б�����к�+1
begin
   if Game_role_list.Count < id then
           result:=0
           else begin
                 if n=  Tplayer(game_role_list.Items[id-1]).pl_old_name then
                     result:= 1
                      else
                       result:= 0;
                end;
end;

function TForm1.game_goods_change_n(n: string; values: integer): integer; //ͨ����Ʒ���޸���Ʒ����
var id: integer;
begin
    if values> 255 then
      values:= 1;

  id:= form_goods.get_goods_id(n);
  if id> 0 then
   begin
  Game_not_save:= true;

        write_goods_number(id, values);
  result:= 1;
  end else result:= 0;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  popupmenu3.Popup(button6.ClientOrigin.X,button6.ClientOrigin.Y+button6.Height);
 // popupmenu3.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm1.N20Click(Sender: TObject);
begin
    //�Ӷ����߳�һ������
 if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'��Ϸ��û��ʼ�����ȵ����Ļ�ϵġ���ʼ��Ϸ�����ӡ�','��Ϸû��ʼ',mb_ok);
    exit;
   end;

 if combobox2.ItemIndex >= 0 then
   begin
    if messagebox(handle,'�Ƿ�ѣ��Ӷ������߳������棺����ÿ�����ﶼ��Ե���ں�������Ϸ���ٴ�������',
        '�߳�����',mb_yesno or MB_ICONQUESTION)= mryes then
         game_del_friend(combobox2.Items.Strings[combobox2.ItemIndex],1);
   end else begin
             messagebox(handle,'������߻���б���ѡ��һ����','��ѡ��',mb_ok or MB_ICONWARNING);
            end;

end;

function TForm1.game_sex_from_id(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_sex));
                end;
end;

function TForm1.game_get_blood_h(id: integer): integer;
begin
 if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_gdsmz27));
                end;
end;

function TForm1.game_get_blood_l(id: integer): integer;
begin
 if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_life));
                end;
end;

function TForm1.game_get_ling_h(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_gdll26));
                end;
end;

function TForm1.game_get_ling_l(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_lingli));
                end;
end;

function TForm1.game_get_ti_h(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_gdtl25));
                end;
end;

function TForm1.game_get_ti_l(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_tili));
                end;
end;

procedure TForm1.N17Click(Sender: TObject);
begin
 if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'��Ϸ��û��ʼ�����ȵ����Ļ�ϵġ���ʼ��Ϸ�����ӡ�','��Ϸû��ʼ',mb_ok);
    exit;
   end;
  if combobox2.ItemIndex >= 0 then
   begin
    game_pop_love(20,combobox2.Items.Strings[combobox2.ItemIndex]);
   end else begin
             messagebox(handle,'������߻���б���ѡ��һ��������б�Ϊ�գ�������û�п�ʼ��Ϸ��������Ϸ�ڻ�û�����Ա����Ա����С�����ҵ���','��ѡ��',mb_ok or MB_ICONWARNING);
            end;

end;

procedure TForm1.N19Click(Sender: TObject);
begin
 if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'��Ϸ��û��ʼ�����ȵ����Ļ�ϵġ���ʼ��Ϸ�����ӡ�','��Ϸû��ʼ',mb_ok);
    exit;
   end;

 if combobox2.Items.Count= 0 then
   begin
    messagebox(handle,'���Ķ�����Ŀǰû�ж�Ա������Ǻ��������ڵĶ�Ա�Ի��õġ�','��ѡ��',mb_ok or MB_ICONWARNING);

   exit;
   end;
 if ComboBox2.Tag < combobox2.Items.Count then
    combobox2.ItemIndex:= ComboBox2.Tag;

 if combobox2.ItemIndex >= 0 then
   begin
    if game_at_net_g then
     begin
       game_show_chat(game_read_values(combobox2.ItemIndex,34));

     end else
          game_talk(combobox2.Items.Strings[combobox2.ItemIndex]);
   end else begin
             messagebox(handle,'������߻���б���ѡ��һ���������ťֻ�ܺͶ����ڵĳ�Ա���죬����������泡���ڵ����һ�����������ô��������Ĵ����Ƿ��Ѿ�������������䣿','��ѡ��',mb_ok or MB_ICONWARNING);
        end;
end;

function TForm1.game_check_money(v: integer): integer;   //�ȶԽ�Ǯ��������ڵ��� v ���� 1
begin

   if  game_read_values(0,ord(g_money)) >= v then
      result:= 1
      else
       result:= 0;

end;

procedure TForm1.game_script_message(var msg: TMessage); //�Զ�����Ϣ�����볡��������
begin

   if msg.WParam= 29 then //���볡��������
    if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then
     Game_action_exe_S_adv(Game_script_scene_after); //ִ�к�������䣬�ɴ�if then

   if msg.WParam= 30 then
     game_cmd_execute(Game_script_scene_G);

   if msg.WParam= 31 then
     if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then
     Game_action_exe(Game_script_scene_G);

   if msg.WParam= 32 then     //�������ʱִ��
     Game_action_exe_S_adv(Game_script_scene_G);

   if msg.WParam= 33 then
     Game_action_exe_S_adv(Game_script_scene_G);

   if msg.WParam= 34 then
     game_show_scene(strtoint2(Game_script_scene_G));

   if msg.WParam= 35 then
      form_net_set.ShowModal;

   if msg.WParam= 36 then
     begin
     Game_action_exe_S_adv(game_html_pop_str_g);  //htmlģʽ��pop�����ʵĺ�������
      game_html_pop_str_g:= ''; //��մ�����
     end;
   if msg.WParam= 37 then
     begin
      show_ad_error;
     end;

   if (msg.WParam= 1086) or (msg.WParam= 1087) then
    begin
      //��ʾ��ǰ������Ҫ����
       if msg.WParam= 1087 then
         Game_show_error_image_G:= true;  //1087��ʾ����ʧ��

      if msg.LParam= pscene_id then
         game_reload_direct(0)
         else if msg.LParam= pscene_id * 2 then //����2��ʾ����ͼƬ
                 game_reload(0);

    end;

    

end;

function TForm1.game_pop_fight_a(i, i2: integer): integer;  //�������������ڵ�ս��
begin
   if checkbox1.Checked then //����ģʽ��ֱ��·��
      begin
       result:= 1;
       exit;
      end;

       if game_at_net_g and ((game_player_head_G.duiwu_dg= 1) or ((game_player_head_G.duiwu_dg= 2))) and (game_page_from_net_g= false) then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2����Ա����ս������
            //����ģʽ�£���Ա�����Լ���������
            game_chat('����������ȫ����ӳ����ߴ�ָ��棬���������ж���<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">��������</a>');
             result:= 0;
            exit;
           end;

 if i< 1 then
    i:= 1;

      form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 3; //ս��
  form_pop.game_is_a:= true;   //����������
  form_pop.game_monster_type:= i2;  //��������

    if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(4, i,i2);

     result:= ord( form_pop.ShowModal= mrok);
     
   Perform($000B, 1, 0);  //����ˢ����Ļ����Ȼwin10������в����Ļ���
   //�ػ���Ļ�Ĵ����Ȳ������Կ�
  // RedrawWindow(self.WebBrowser1.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE + RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);

end;

function TForm1.game_read_scene_integer(id: integer): integer; //��scene�¼����ȡһ��ֵ
begin
  result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),-1);
  if result= -1 then
  begin
   if game_at_net_g then
       begin
        //����ʱ�����Ϊ-1����������ȡ
         result:= wait_scene_int_bool(false,id);
        data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),result);
        
       end else result:= 0;
  end;

end;

function TForm1.game_write_scene_integer(id, v: integer): integer; //��scene�¼���д��һ��ֵ
begin
  if (id < 1001) and (game_at_net_g=false) then
   begin
     messagebox(handle,'�����¼����1000������Ϊϵͳ��������ʹ��1000���ϡ�','����',mb_ok or MB_ICONERROR);
     result:= 0;
   end else begin
            Game_not_save:= true;
            if Assigned(data2.game_memini_event) then
            data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),v);
            if game_at_net_g then  //�����Ϸ��������״̬����ôͬʱд��һ����¼�¼�����Ʒ����Ϊ��Ʒ�¼����������²���
             begin
               //�����¼�
               Data_net.send_scene_integer(id,v);
             end;
            result:= 1;
            end;
end;

function TForm1.game_integer_comp(i1: integer; c: string;
  i2: integer): integer;
begin
               //��i1��i2���бȽϣ�c��ȡ�ȽϷ����� =,>,<
result:= 0;

   if c= '=' then
     result:= ord(i1= i2)
      else if c= '>' then
       result:= ord(i1 > i2)
        else if c= '<' then
       result:= ord(i1 < i2)
        else if c= '<>' then
       result:= ord(i1 <> i2)
        else if c= '>=' then
       result:= ord(i1 >= i2)
        else if c= '<=' then
       result:= ord(i1 <= i2);

end;

procedure TForm1.game_reset_role_chatid; //��������id����
var i: integer;
begin
  for i:= 1 to Game_role_list.Count-1 do
        if Assigned(game_role_list.Items[i]) then
              begin
               game_write_values(i,22,0);
               game_write_values(i,23,0);
                 //22�ż�¼����ǰ̸��ǰ����
                //̸����������
               Tplayer(game_role_list.Items[i]).pltalkchar1:= #0;
               Tplayer(game_role_list.Items[i]).pltalkchar2:= #0;  //�������
               Tplayer(game_role_list.Items[i]).pltalkchar3:= #0;
               Tplayer(game_role_list.Items[i]).pltalkchar4:= #0;
               Tplayer(game_role_list.Items[i]).pltalkchar5:= #0;
              end;
end;

function TForm1.game_chat_cleans(i: integer): integer; //���촰������
begin
  Game_scr_clean2;
  result:= 1;
end;

procedure TForm1.ComboBox2Select(Sender: TObject);
begin
   ComboBox2.Tag:= combobox2.ItemIndex;
  // Button_talk.Enabled:= true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//FDocHostUIHandler.Free;
 if Assigned(kill1) then
   if TerminateThread(kill1.Handle,0) then
      kill1.Free;

game_save_doc_net; //����������Ϸ����

 UnregisterHotKey(Handle, GlobalAddAtom('wordgame_H'));
   GlobalDeleteAtom(GlobalAddAtom('wordgame_H')); //ɾ��ȫ�ֱ�ʶ

   if game_debug_handle_g<> 0 then
      sendmessage(game_debug_handle_g,stop_c,88,0); //����ʱ�����ж���Ϣ
      
 Shell_NotifyIcon(NIM_DELETE, @MyTrayIcon);//ɾ������ͼ��
end;
   (*
procedure TForm1.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
{var
hr: HResult;
CustDoc: ICustomDoc; }
begin
   if pos('finer2', (pDisp as IWebbrowser2).LocationURL)> 0 then
    IEEvents1.ConnectTo(pDisp as IWebbrowser2);
{
hr := WebBrowser1.Document.QueryInterface(ICustomDoc, CustDoc);
if hr = S_OK then
CustDoc.SetUIHandler(FDocHostUIHandler); }

 
end;
 *)

procedure TForm1.OnAccept(const URL: String; var Accept: Boolean);
begin
 Accept:= true;
end;

procedure TForm1.OnContent(const url: String; var Stream: TStream);
begin
  //���Զ���Э��������������
  game_pic_from_text(stream,url);
end;
function min(arg1,arg2:integer):integer;
begin
    if arg1 < arg2 then
      result  := arg1
    else
      result := arg2;
end;
function max(arg1,arg2:integer):integer;
begin
    if arg1 < arg2 then
      result  := arg2
    else
      result  := arg1;
end;
//����Ч��
procedure EmbossClick(BMP: Tbitmap);
var
   i, j: integer;
   p1, p2: pbyteArray;
   Value: integer;

begin

   for i := 0 to bmp.Height - 2 do
      begin
         p1 := Bmp.ScanLine[i];
         p2 := Bmp.ScanLine[i + 1];
         for j := 0 to Bmp.Width - 1 do
            begin
               Value := (p1[3 * j + 2] - p2[3 * j + 2]) + 156;
               p1[3 * j + 2] := Min(255, Max(0, Value));
               Value := p1[3 * j + 1] - p2[3 * j + 1] + 156;
               p1[3 * j + 1] := Min(255, Max(0, Value));
               Value := p1[3 * j] - p2[3 * j] + 156;
               p1[3 * j] := Min(255, Max(0, Value));
            end;
      end;
end;
// ֱ�����ŵ�������С 
function GDIBitmapGetThumbnailImage(Bmp:TGPBitmap;Width,Height:integer):TGPBitmap;
begin 
  Result:=TGPBitmap(Bmp.GetThumbnailImage(Width,Height));
end;

// ��������񣬻� GDI+ ͼ�ε� Delphi �Ļ��������� 
procedure DrawGDIBitmapToCanvas(Canvas:TCanvas;Bmp:TGPBitmap;Center:Boolean); 
var 
Graphics:TGPGraphics; 
W,H:cardinal;
begin 
if Canvas.Handle<>0 then 
begin 
  Graphics:=TGPGraphics.Create(Canvas.Handle); 
  if Center then 
   begin 
    W:=Canvas.ClipRect.Right-Canvas.ClipRect.Left;
    H:=Canvas.ClipRect.Bottom-Canvas.ClipRect.Top;
    Graphics.DrawImage(Bmp,(W-Bmp.GetWidth) shr 1,(H-Bmp.GetHeight) shr 1,Bmp.GetWidth,Bmp.GetHeight);
   end 
  else 
    Graphics.DrawImage(Bmp,0,0); 
  Graphics.Free; 
end; 
end; 

function LockedFile(const Fn: string): Boolean;  //�ж��ļ��Ƿ�����
var 
AFile: THandle; 
SecAtrrs: TSecurityAttributes; 
begin 
FillChar(SecAtrrs, SizeOf(SecAtrrs), #0); 
SecAtrrs.nLength := SizeOf(SecAtrrs); //�ṹ�峤�� 
SecAtrrs.lpSecurityDescriptor := nil; //��ȫ���� 
SecAtrrs.bInheritHandle := True; //�̳б�־ 
AFile := CreateFile(PChar(Fn), GENERIC_READ or GENERIC_WRITE, 
FILE_SHARE_Read, @SecAtrrs, OPEN_EXISTING, 
FILE_ATTRIBUTE_Normal, 0); 
if AFile = INVALID_HANDLE_VALUE then 
begin 
Result := True; //�ļ�������
//showmessage(SysErrorMessage(GetLastError));
end 
else begin
      CloseHandle(afile);
       Result := False;
      end;
end;

procedure TForm1.game_pic_from_text(Stream: TStream; s: string; path: string='');  //�����ַ�������ͼƬ����
var aafont: TAAFontEx;
    bmp,bmp2 : TBitmap;
    text_e,w,h: integer; //����Ч��
    afont: Tfont;
    acolor: Tcolor;
    atouming,afudiao,jpg_pos: integer;
    axiaoguo,atext,ss: string;
    sBlendFunction: BlendFunction; // ����Alpha���ʱ��Ҫ��һ�����Ͳ���
    apos: integer; //�Ƿ��������ʱ���Զ�λ
    apos_w,apos_h: integer; //���Զ�λ��λ��
    apos_string: string;
    jpg: Tjpegimage;
    gdibmp: Tgpbitmap;
    aw,ah: integer;
    filestr: TMemoryStream;
    label pp;
begin
     {
          flag
          1000 ��Ч��
          1001  ����
          1002  ����
          1003  ģ��
          1004  ����
          1005  ��͸��
          1006  ��������б
          1007  ��������б
          1008  ��Ӱ
         }

   text_e:= fastpos(s,'://',length(s),3,1);
  if (text_e > 0) and (text_e < 9) then
     delete(s,1,text_e+ 2);  //ɾ���ַ���ǰ��Ķ���gpic��־

    s:=StringReplace(s, '%20', ' ', [rfReplaceAll]); //%20 �滻Ϊ�ո�

    if (length(s)< 50) and (length(s)> 0) then
     begin
      //���������ļ����ļ������ڵģ���ָ��ҳ������
      if  Game_error_count_G < 100 then
      begin
      while s[length(s)]= '/' do
         delete(s,length(s),1);

       if FileExists(Game_app_img_path_G + s) then
        begin
        s:= Game_app_img_path_G + s;
         if LockedFile(s) then  //�ļ�����
            s:= game_app_path_G + 'img\space'+ ExtractFileExt(s);
        end else begin
                   //�ļ������ڣ����أ�������ض��ʧ�ܣ�ֱ����ʾ����ʧ��
                   if Game_show_error_image_G or (Game_error_count_G >= Download_try_count) then   //���س��Դ���
                   begin
                   Game_show_error_image_G:= false;
                    s:= game_app_path_G + 'img\error'+ ExtractFileExt(s);

                    if Game_error_count_G >= Download_try_count then
                       inc(Game_error_count_G,10); //�ۼƴ���������ô���ͼƬ����ʾ���κ�����ʾ
                   end else begin
                               //��������
                              if Game_pscene_img_list.IndexOf(s)= -1 then
                               begin
                                Game_pscene_img_list.Append(s); //�������������б�
                                gm_download.Create(s,pscene_id,form1.handle);
                               end;
                             s:= game_app_path_G + 'img\wait'+ ExtractFileExt(s);
                            end;
                 end;

       end else begin
                 //��ֹ��ͼƬ
                  s:= game_app_path_G + 'img\space'+ ExtractFileExt(s);
                end;
      if s[length(s)]='/' then
         delete(s,length(s),1);


      filestr:= TMemoryStream.Create;
      filestr.LoadFromFile(s);
      filestr.SaveToStream(Stream);
      filestr.Free;

      exit;
     end;

   //���ߣ����壬����ɫ�����ݣ�Ч����͸����

    try
     aw:= round(strtoint2(copy(s,1,fastcharpos(s,',',1)-1))* dpi_bilv);
      //aw:= strtoint2(copy(s,1,fastcharpos(s,',',1)-1));
     delete(s,1,fastcharpos(s,',',1));
    except
     aw:= 0;
    end;
     try
      ah:= round(strtoint2(copy(s,1,fastcharpos(s,',',1)-1))* dpi_bilv);
      // ah:= strtoint2(copy(s,1,fastcharpos(s,',',1)-1));
     delete(s,1,fastcharpos(s,',',1));
    except
     ah:= 0;
    end;

     if aw= 0 then
       aw:= web1.Width-20;
     if ah= 0 then
      ah:= web1.Height;

    afont:= Tfont.Create; //����

       try
    StringToFont(copy(s,2,fastcharpos(s,')',1)-2),afont);
    delete(s,1,fastcharpos(s,')',1)+1);

     acolor:= StringTocolor(copy(s,1,fastcharpos(s,',',1)-1));
    delete(s,1,fastcharpos(s,',',1));  //������ɫ

     atext:= copy(s,1,fastcharpos(s,',',1)-1);
    delete(s,1,fastcharpos(s,',',1));  //����
     if atext='' then
        atext:= ' ';

        axiaoguo:= copy(s,1,fastcharpos(s,',',1)-1);
    delete(s,1,fastcharpos(s,',',1));  //��ʾЧ��

         afudiao:= strtoint2(copy(s,1,fastcharpos(s,',',1)-1));
      delete(s,1,fastcharpos(s,',',1));  //�Ƿ񸡵�

        atouming:= strtoint2(copy(s,1,fastcharpos(s,'/',1)-1));  //͸��
        atouming:=255- round(255 * (100- atouming) /100);

       except
         acolor:= clwindow;
         axiaoguo:='AT1000';
         afudiao:= 0;
         atouming:= 0;
         atext:='$grass';
       end;

    bmp:=TBitmap.Create;

      bmp.PixelFormat:=pf24bit;
       jpg_pos:= FastPos(atext,'.jpg',length(atext),4,1); //�Ƿ���Ҫ����ͼƬ,jpg ��Сд ����д����Ϊ��̬����ͼƬ

       if jpg_pos>0 then
         if FastPos(atext,':/',length(atext),2,1)> 1 then
            jpg_pos:= 9999;

      if jpg_pos > 1 then
       begin
        //����jpg
       // jpg:= Tjpegimage.Create;
        //  jpg.LoadFromFile(data2.game_app_path + 'img\'+
            //  copy(atext,1,jpg_pos +3));
         if jpg_pos= 9999 then
            ss:= atext
            else
              ss:= game_app_path_G + 'img\'+ atext;

          atext:= '';

         ss:=StringReplace(ss, '/', '\', [rfReplaceAll]);

         if not FileExists(ss) then
             ss:= game_app_path_G + 'img\space.jpg';

           
            gdiBmp:=TGPBitmap.Create(ss);

          if (aw > 0) and (aw < 10) then //ͼƬ��С�ı�������
             aw:= integer(gdiBmp.getWidth) * aw;
          if (ah > 0) and (ah < 10) then
             ah:= integer(gdiBmp.getHeight) * ah;

          bmp.Width:= aw;
          bmp.Height:= ah;

         //bmp.Canvas.StretchDraw(Rect(0,0,aw,ah), jpg);

           try
            if aw<> integer(gdiBmp.getWidth) then
              gdiBmp:=GDIBitmapGetThumbnailImage(gdiBmp,aw,ah);
           DrawGDIBitmapToCanvas(bmp.Canvas,gdiBmp,True);
           finally
           gdiBmp.Free;
           end;

       // jpg.Free;
      //  delete(atext,1,pos(',',atext)); //ȥ��atext�ڵ�ͼƬ·����ʣ����������
       end else begin

                 bmp.Width:=aw;
                 bmp.Height:=ah;
                 bmp.Canvas.Brush.Color:= acolor;
                 bmp.Canvas.FillRect(rect(0,0,aw,ah));
                 if atext='$tree' then
                   begin
                     //����
                     form_pop.draw_random_pic_base(bmp,true);
                     atext:=' ';
                   end else if atext='$grass' then
                              begin
                               form_pop.draw_random_grass(bmp);
                               atext:=' ';
                              end else if (atext[1]= '$') and (atext[2]= 'i') and (atext[3]= 'f') and(atext[4]= 's') then
                               begin
                                 if length(atext)= 4 then
                                  begin
                                   form_pop.draw_random_XX(bmp,0);
                                  end else begin
                                            if fastcharpos(atext,'-',1)> 0 then
                                             begin
                                              delete(atext,1,fastcharpos(atext,'-',1));
                                              if length(atext)> 0 then
                                                  form_pop.draw_random_XX(bmp,strtoint2(atext))
                                                  else
                                                    form_pop.draw_random_XX(bmp,0);
                                             end else
                                                form_pop.draw_random_XX(bmp,0);
                                           end;
                                  atext:= ' ';
                               end;
                end;

        if atouming > 0 then
                  begin
                   bmp2:= TBitmap.Create; //
                   bmp2.Width:=aw; //����ǽ�����Ϊ͸������ı����õ�
                   bmp2.Height:=ah;  //
                  end;

       if atext= '' then
          goto pp;

      AAFont := TAAFontEx.Create(bmp.Canvas);
      aafont.Effect.LoadFromIni(game_effect_ini,axiaoguo);
      aafont.Effect.Shadow.Color:= clblack;
      aafont.Effect.Gradual.StartColor:= afont.Color;  //����ɫ����Ϊ������ɫ
      aafont.Effect.Gradual.EndColor:= not afont.Color;

        with bmp.Canvas do
        begin
          Font:= afont;

          Brush.Style := bsClear; // ����͸������
        end;

        
        W := AAFont.TextWidth(atext);
        H := AAFont.TextHeight(atext);
         apos:= fastcharpos(atext,'{',1);
         if apos > 0 then
          begin
           //���Զ�λ
           while apos > 0 do
            begin
             delete(atext,1,apos);
             apos_w:= round(strtoint2(copy(atext,1,fastcharpos(atext,'@',2)-1)) * dpi_bilv); //ȡ�ÿ��
              if apos_w < 0 then
                apos_w:= aw+ apos_w; //���Ϊ��ֵ��ʾ���ұ߿�ʼ��
              delete(atext,1,fastcharpos(atext,'@',2));
              apos_H:= round(strtoint2(copy(atext,1,fastcharpos(atext,'}',2)-1)) * dpi_bilv);   //ȡ�ø߶�
               if apos_H < 0 then
                apos_H:= ah+ apos_H; //�߶�Ϊ��ֵ��ʾ�����濪ʼ��
              delete(atext,1,fastcharpos(atext,'}',2));
              apos:= fastcharpos(atext,'{',1);
              if apos> 0 then
                 begin
                 apos_string:= copy(atext,1,apos-1); //ȡ������
                 end else
                       apos_string:= atext;

             AAFont.TextOut(apos_w, apos_H, apos_string);
             
            end;
          end else begin
                     //������ʾ
                     with bmp do // �ڿؼ���������ı�
                      AAFont.TextOut((Width - W) div 2, (Height - H) div 2, atext);
                   end;
        
        afont.Free;
        AAFont.Free;

        
          pp:

         if afudiao= 1 then
            EmbossClick(bmp); //������

        if atouming > 0 then //͸������
         begin
        with sBlendFunction do // ���ó�ֵ
          begin
           BlendOp := AC_SRC_OVER; // ĿǰΨһ֧�ֵ�һ�ֻ�Ϸ�ʽ
           BlendFlags := 0; // ����Ϊ��
           SourceConstantAlpha:= atouming;
           AlphaFormat := 0 // ȱʡ
          end;
          windows.AlphaBlend(bmp.Canvas.Handle,0,0,
           bmp.Width,bmp.Height,bmp2.Canvas.Handle,
             0,0, bmp.Width,bmp.Height,sBlendFunction); // Alpha��ϴ���
          bmp2.Free;//
         end;

          if path='' then
           begin
            Stream.Position:= 0;
            bmp.SaveToStream(Stream);
           end else begin
                   jpg:= Tjpegimage.Create;
                   jpg.Assign(bmp);
                   jpg.CompressionQuality:= 80;
                   jpg.Compress;
                   jpg.SaveToFile(path);
                   jpg.Free;
                 end;
      bmp.Free;

end;

function TForm1.game_grade(n: string; g: integer): integer;  //���������Ƿ���ڵ�������ȼ���
var i: integer;
begin

result:= 0;

   for i:= 0 to game_get_role_H do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
       if game_read_values(i,ord(g_grade))>= g then
             result:= 1;
        exit;
      end;
   

end;

function TForm1.game_change_sex(n: string; sex: integer): integer;
var i: integer;
begin
           //������Ϸ�����Ա�
result:= 0;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        game_write_values(i,ord(g_sex),sex);
        game_write_values(i,ord(g_icon_index),sex-1);
        result:= 1;
        exit;
      end;
  // if messagebox(handle,'�����Ը�����Ϸ���ǵ��Ա𣬰���ȷ�����Ա�Ϊ�У�����ȡ�����Ա�ΪŮ��','ѡ���Ա�',mb_okcancel or MB_ICONQUESTION)= mrcancel then
end;

function TForm1.game_start_now(i: integer): integer;
begin
  game_start(i);
  result:= 1;
end;

function TForm1.game_sex_from_name(const n: string): integer;  //�жϴ���������Ů���з���1
var i: integer;
begin

result:= 0;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
       result:= game_read_values(i,ord(g_sex));
        exit;
      end;

end;

function TForm1.game_get_fm_1(sex: integer): integer;
var i: integer;
begin
result:= 1;
  for i:= 0 to Game_role_list.Count-1 do
       if game_read_values(i,ord(g_sex))= sex then
        begin
         result:= i + 1; //���������ڵ����������Ǵ� 1 ��ʼ��
         exit;
        end;

end;

function TForm1.game_id_exist(id: integer): integer; //���ָ����������Ƿ���ڣ�1��ʾ��һ��
begin
   if id <= Game_role_list.Count then
     result:= 1
     else
      result:= 0;
end;

function TForm1.game_del_friend_byid(a, b: integer): integer;
begin
  result:= 0;
   if (a > Game_role_list.Count) or (a= 1) then
    exit;

    result:= game_del_friend(Tplayer(Game_role_list.Items[a-1]).pl_old_name,b);
end;

function TForm1.game_move_money(id1, id2, m: integer): integer;
begin    //ת�ƽ�Ǯ����id1ת�Ƶ�id2��1��ʾ��һ������
   if (id1<= Game_role_list.Count) and (id2<= Game_role_list.Count) and
      (game_read_values(id1-1,0) >= m) then
    begin
     game_write_values(id1-1,0,game_read_values(id1-1,0) -m);
     game_write_values(id2-1,0,game_read_values(id2-1,0) +m);
    end;
   result:= 1;
end;

function TForm1.game_get_oldname_at_id(x: integer): pchar;  //�������кŷ����ϵ����֣�1Ϊ��һ����2Ϊ�ڶ���
begin
 if Game_role_list.Count < x then
           Game_pchar_string_G:= ' '
           else
             Game_pchar_string_G:= Tplayer(game_role_list.Items[x-1]).pl_old_name;

 result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_role_all_MTL(p: integer): integer; //������ȫ����p=0��ʾȫ�壬1��ʾ��һ������
var i: integer;
begin
 result:= 1;

   if p= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
        game_write_values(i,ord(g_life),game_read_values(i,ord(g_gdsmz27)));
         game_write_values(i,ord(g_tili),game_read_values(i,ord(g_gdtl25)));
         game_write_values(i,ord(g_lingli),game_read_values(i,ord(g_gdll26)));

        end;
    end else begin
              if p<= game_get_role_H+1 then
                 begin
                  game_write_values(p-1,ord(g_life),game_read_values(p-1,ord(g_gdsmz27)));
                  game_write_values(p-1,ord(g_tili),game_read_values(p-1,ord(g_gdtl25)));
                  game_write_values(p-1,ord(g_lingli),game_read_values(p-1,ord(g_gdll26)));

                 end else
                      result:= 0;
             end;

end;

procedure TForm1.game_load_image_to_imglist; //��������ͷ��
var i: integer;
  bmp,bmp_zoom: Tbitmap;
 sr: TSearchRec;
 f,k: integer;
begin
 bmp:= Tbitmap.Create;
  data2.ImageList_sml.Clear;
   k:= data2.ImageList_sml.Width;
  data2.ImageList_sml.Width:= round(16 * dpi_bilv);
  data2.ImageList_sml.Height:= round(16 * dpi_bilv);

   if k<> data2.ImageList_sml.Width then
     bmp_zoom:= Tbitmap.Create;

 f := FindFirst(game_app_path_G + 'sml\*.bmp', faAnyFile, sr);
 while f = 0 do
   begin
     if (sr.Name <> '.') and (sr.Name <> '..') then
       begin
         if sr.Attr and faDirectory = 0 then
          begin
            bmp.LoadFromFile(game_app_path_G + 'sml\'+ sr.Name);
             if k<> data2.ImageList_sml.Width then
              begin
                img_zoom(bmp,bmp_zoom,data2.ImageList_sml.Width,data2.ImageList_sml.Height);
                bmp.Assign(bmp_zoom);
              end;
            Game_goods_Index_G[strtoint2(copy(sr.Name,1,length(sr.Name)-4))]:=
                         data2.ImageList_sml.AddMasked(bmp,clfuchsia);
          end;
       end;
     f := FindNext(sr);
   end;
 FindClose(sr);

 data2.ImageList2.Clear;
   data2.ImageList2.Width:= round(48 * dpi_bilv);
  data2.ImageList2.Height:= round(48 * dpi_bilv);
  for i:= 0 to 199 do
   begin
     if FileExists(game_app_path_G +'img\'+ inttostr(i-1) + '.bmp') then
      begin
       if (i< 2) and game_at_net_g and FileExists(Game_save_path + inttostr(i-1) + '.bmp') then
        bmp.LoadFromFile(Game_save_path + inttostr(i-1) + '.bmp')
        else
         bmp.LoadFromFile(game_app_path_G +'img\'+ inttostr(i-1) + '.bmp');

         if k<> data2.ImageList_sml.Width then
              begin
                img_zoom(bmp,bmp_zoom,data2.ImageList2.Width,data2.ImageList2.Height);
                bmp.Assign(bmp_zoom);
              end;
        data2.ImageList2.AddMasked(bmp,clfuchsia);
       //data2.ImageList2.FileLoad(rtbitmap,,clfuchsia)
      end  else
         break;
   end;

 bmp.Free;

 if k<> data2.ImageList_sml.Width then
     bmp_zoom.Free;

 speedbutton1.Visible:= game_at_net_g;
 combobox2.Visible:= not game_at_net_g;
  if game_at_net_g then    //����ʱ��ʾСͼ
   begin
     speedbutton1.Enabled:= true;
     speedbutton1.Glyph.Width:=  speedbutton1.Width;
      speedbutton1.Glyph.Height:=  speedbutton1.Height;
     data2.imagelist2.Draw(speedbutton1.Glyph.Canvas,0,0,
     Tplayer(Game_role_list.Items[0]).plvalues[ord(g_Icon_index)]+ 1);
   end;

end;

function TForm1.game_clear_money(i: integer): integer;
begin
if i=0 then
  game_write_values(0,0,0)
  else if i=1 then
        game_write_values(0,0,game_read_values(0,0) div 2);

  result:= 1;
end;

function TForm1.game_get_money(i: integer): integer;
begin
 if i > Game_role_list.Count then
   result:= game_read_values(0,0)
 else if i > 0 then
       result:= game_read_values(i-1,0)
      else
       result:= game_read_values(0,0);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'��Ϸû�п�ʼ����������ġ���ʼ������Ϸ�����ߡ���ʼ������Ϸ����������Ϸ���ߴ�ȡ���ȡ�','��Ϸû��ʼ',mb_ok);
   exit;
  end;

  if not Assigned(form_ZJ_LY) then
     form_ZJ_LY:= Tform_ZJ_LY.Create(application);

     form_ZJ_LY.ShowModal;
end;

function TForm1.game_get_role_suxing(i, v: integer): integer;
begin
 if i= 0 then
    i:= 1;

  if i > Game_role_list.Count then
   result:= 0
   else
       result:= game_read_values(i-1,v);

end;

function TForm1.game_get_goods_count(n: string): integer;
var j: integer;
begin
  //���ĳ��Ʒ�����Ƿ��м���
     if n= '' then
      result:= 0
       else begin
              j:= form_goods.get_goods_id(n);
              if j= 0 then
               result:= 0
                else result:= read_goods_number(j);
            end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin

     Form_set.ShowModal;
end;

function TForm1.game_kill_game_time(i: integer): integer;
begin

   edit1.Visible:= false;
   timer1.Enabled:= false;

 result:= 1;
end;

function TForm1.game_set_game_time(t, page: integer): integer;
begin
//������ʱ����

   g_time_count:= t;
   g_time_page:= page;
   edit1.text:= 'ʣ�ࣺ'+ inttostr(g_time_count) + '��';
   edit1.Left:= web1.Width- edit1.Width- 18;
  edit1.Visible:= true;
  edit1.BringToFront;
  timer1.Enabled:= true;
result:= 1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  dec(g_time_count);
  edit1.text:= 'ʣ�ࣺ'+ inttostr(g_time_count) + '��';
  if g_time_count <= 0 then
   begin
    edit1.Visible:= false;
    timer1.Enabled:= false;
    game_page(g_time_page);
   end;
end;

function TForm1.game_spk_string(const s: string): integer;
begin
 //�ʶ������checkbox2��ѡ����ô˵���ʶ����ܲ�����
  if form_pop.CheckBox2.Enabled and (s<> '') then
     form_pop.skp_string(s);
 result:= 1;    
end;

function TForm1.game_not_rename(i: integer): integer;
begin
if i= 0 then
   i:= 1;
   
   if Tplayer(Game_role_list.Items[i-1]).pl_old_name= Tplayer(Game_role_list.Items[i-1]).plname then
    result:= 1
     else
      result:= 0;
end;

function TForm1.game_clear_temp(i: integer): integer;
begin
   temp_event_clean; //�����ʱ��
   result:= 1;
end;

function TForm1.game_random_chance_2(i: integer): integer; //���������
begin
   result:= Game_base_random(i);
end;

function TForm1.game_get_pscene_id(i: integer): integer; //���ص�ǰҳid�Ͳ������ۼ�ֵ
begin
 result:= pscene_id + i;
end;

function TForm1.game_role_value_half(id: integer): integer;
var i: integer;
begin
 //����ֵ���� idΪ0��ʾȫ����룬Ϊ1��ʾ��һ������
    result:= 1;
    
   if id= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
         game_write_values(i,ord(g_life),game_read_values(i,ord(g_life)) div 2);
        end;
    end else begin
              if id<= game_get_role_H+1 then
               begin
                 game_write_values(id-1,ord(g_life),game_read_values(id-1,ord(g_life)) div 2);

               end  else
                  result:= 0;
             end;


end;

function TForm1.game_get_pscene_id_s(i: integer): pchar;
begin
    //����ҳ�ţ��ַ���ʽ��id�Ͳ������ۼ�ֵ
    Game_scene_id_string:= inttostr(pscene_id + i);
    result:= pchar(Game_scene_id_string);
end;

function TForm1.game_inttostr(i: integer): pchar;
begin
    Game_inttostr_string_G:= inttostr(i);
    result:= pchar(Game_inttostr_string_G);
end;

function TForm1.game_doc_is_ok(s: string): boolean;
var vSearchRec: TSearchRec;
  fdate:integer;
  K: Integer;
begin
result:= true;
  fdate:= 0;

  K := FindFirst(s+'*.*', faDirectory, vSearchRec);
  while K = 0 do
  begin
    if not((vSearchRec.Attr and faDirectory)>0) then
    begin
     if fdate= 0 then
        fdate:=vSearchRec.Time
        else begin
              if (abs(fdate - vSearchRec.Time) > 30) and (vSearchRec.Name<>'out.txt') then
                begin

                  result:= false;
                  FindClose(vSearchRec);
                  exit;
                end;
             end;

    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

end;

function TForm1.game_get_read_txt(i: integer): pchar;
var t: integer;
    b: boolean;
    j: integer;
    ss: string;
begin

    if show_share_text='' then
     begin
      if not Game_is_reload then
      begin
      if i= 0 then
       read_text_index_g:= Random(game_read_stringlist.Count)
       else begin
             if i >= game_read_stringlist.Count then
               read_text_index_g:= Random(game_read_stringlist.Count)
               else
               read_text_index_g:= i;
            end;
      end;

     Game_pchar_string_G:= '<br>'+game_read_stringlist.Strings[read_text_index_g];
     end else begin
               Game_pchar_string_G:= show_share_text;
               show_share_text:= '';
               if (game_bg_music_rc_g.down_readfile= true) or (game_read_stringlist.Count=0) then
                down_tip1.Resume;
              end;
 //��Ӣ�ķ����ϲ����ʶ���ť
 if Game_pchar_string_G= '' then
    Game_pchar_string_G:=' ';

 t:= 1;
 b:= false;
 j:= 0;
 while t < length(Game_pchar_string_G) do
  begin
   if Game_pchar_string_G[t] = '<' then
     b:= true //���������ƥ��ȴ�
     else if Game_pchar_string_G[t] = '>' then
          b:= false
          else if (Game_pchar_string_G[t] in[' ','a'..'z','A'..'Z','$'..'@']) and (b=false) then
            begin
             if j= 0 then
              j:= t; //��¼���ʼ��Ӣ��λ��
            end else if ((b= false) and (j> 0)) or b then
                      begin
                        //���t����j�ܶ࣬������ʶ�����
                         if b and (j> 0) then
                            dec(t);
                        if (j> 0) and (t- j > 15) then
                         begin
                          if Game_pchar_string_G[j+1]= ':' then
                             inc(j,2);
                          ss:= ' <a href="game_spk_string(''' + copy(Game_pchar_string_G,j,t-j) +''')" title="�ʶ��ô���">�ʶ�</a>';
                          insert(ss,Game_pchar_string_G,t);
                          t:= t + length(ss);
                         end;
                        if b and (j> 0) then
                            inc(t);
                        j:= 0;
                      end;
     inc(t);
  end;

  if CompareText(form_set.combobox1.Text,'Microsoft Sam')=0 then
     Game_pchar_string_G:= Game_pchar_string_G +'<p>С��ʿ����Ҫ����Ȼ������û�л���ζ�������ʶ����鿴<a href="http://www.finer2.com/wordgame/wordlib.htm#tts" target="_blank">�������</a>��<br>';

    if Game_base_random(10)=0 then
      Game_pchar_string_G:= Game_pchar_string_G + '<p>�кõ�ѧϰ�ĵû���Ӣ�����յľ�Ʒ�Ķ����ϣ����<a href="game_showshare_readtext(0)">�ϴ�����</a>';
 result:= pchar(Game_pchar_string_G);

end;

function TForm1.game_true(i: integer): integer;
begin
     if i= 0 then
      result:= 0
      else
       result:= 1;
end;

function TForm1.game_weather(i: integer): integer;
begin
   game_tianqi_G:= i;
   result:= 1;
end;

function TForm1.game_get_accoutre(i, idx: integer): integer; //ȡ��װ������
begin
 try
  result:= Tplayer(game_role_list.Items[i-1]).pl_accouter1[idx];
 except
  result:= 0;
 end;
end;

procedure TForm1.shell_exe(s: string);
var ss: string;
begin
   if s<>'' then
    showmessage(s);

    ss:= game_doc_path_G +'tmp\up.exe';
    if FileExists(ss) then
     ShellExecute(0,
               'open',pchar(ss),nil,nil,sw_shownormal);
  {
 if form_save.cunpan <> '' then
   begin
    ShellExecute(0,
  'open',pchar(game_app_path_G +'game.exe'),pchar(form_save.cunpan),nil,sw_shownormal);
   end else begin
              ShellExecute(0,
               'open',pchar(game_app_path_G +'game.exe'),nil,nil,sw_shownormal);
            end;
        }
end;

procedure TForm1.show_ad_error;
begin

end;

function TForm1.game_get_TickCount(i: integer): integer;
begin
  result:= GetTickCount;
  if i= 1 then
   result:= result div 1000;

end;

function TForm1.game_get_date(i: integer): pchar;
begin
  if i= 0 then
   Game_datetime_G:= datetostr(date)
   else
    Game_datetime_G:= datetostr(filedatetodatetime(i));

    result:= pchar(Game_datetime_G);

end;

function TForm1.game_get_datetime(i: integer): pchar; //ȡ���ַ��͵�ʱ�����ڣ��������Ϊ�㣬���ز���ֵ���ַ�����
begin
   if i= 0 then
     Game_datetime_G:= datetimetostr(now)
   else
    Game_datetime_G:= datetimetostr(filedatetodatetime(i));

    result:= pchar(Game_datetime_G);
end;

function TForm1.game_get_time(i: integer): pchar;
begin
   if i= 0 then
   Game_datetime_G:= datetostr(time)
   else
    Game_datetime_G:= datetostr(filedatetodatetime(i));

    result:= pchar(Game_datetime_G);
end;

function TForm1.game_int_date(i: integer): integer;
begin
     result:= DateTimeToFileDate(date);
end;

function TForm1.game_int_datetime(i: integer): integer;
begin
   result:= DateTimeToFileDate(now);    //���ʱ�����ڵ���������
end;

function TForm1.game_int_time(i: integer): integer;
begin
  result:= DateTimeToFileDate(time);
end;

function TForm1.game_time_exe(i: integer; const s: string): integer;
begin
   //��ʱ��������ָ��������ִ������
   game_time_exe_list.Append(s);
   if game_time_exe_list.Count= 1 then
      Timer_exe.Enabled:= true;

             if game_time_exe_list.Count > 512 then
              begin
               game_time_exe_list.Delete(game_time_exe_list.Count-1);
                messagebox(handle,'��ʱ���������࣬ͬʱ���еĲ��ܶ���512��','ע��',mb_ok);
                result:= 0;
              end else begin
                        if i > 60000 then
                         begin
                          i:= 60;
                          messagebox(handle,'һ����ʱ�����Ĳ�������ȷ�����ܴ���5���Ѿ����޸�Ϊ60��','ע��',mb_ok);
                         end;
                        Game_time_exe_array_G[game_time_exe_list.Count-1]:= i;
                        result:= 1;
                       end;


end;

procedure TForm1.Timer_duihuaTimer(Sender: TObject);
begin
   if game_duihua_list.Count=0 then
    begin
      timer_duihua.Enabled:= false;
      exit;
    end;

  if baidu_busy=false then
      begin
        form_pop.skp_string(game_duihua_list.Strings[0]);
        game_duihua_list.Delete(0);
      end;
  
end;

procedure TForm1.Timer_exeTimer(Sender: TObject);
var i: integer;
begin

   for i:= 0 to game_time_exe_list.Count -1 do
    begin
     if Game_time_exe_array_G[i]> 1 then
        Game_time_exe_array_G[i]:= Game_time_exe_array_G[i]-1;
     if Game_time_exe_array_G[i]= 1 then
      begin
       Game_time_exe_array_G[i]:= 0;
       Game_action_exe(game_time_exe_list.Strings[i]);
      end;
    end;

  for i:= game_time_exe_list.Count -1 downto 0 do
   begin
    if Game_time_exe_array_G[i]= 0 then
       game_time_exe_list.Delete(i)
       else
        break;
   end;

  if game_time_exe_list.Count= 0 then
      Timer_exe.Enabled:= false;
end;

function TForm1.game_webform_isshow(i: integer): integer;
begin

  if Screen.ActiveForm= form1 then
    result:= 1
    else
     result:= 0;
end;

function TForm1.game_run_off_no(i: integer): integer;
begin
result:= 1;
     Game_cannot_runOff:= i=0;

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var str1: Tstringlist;
begin
  str1:= Tstringlist.Create;
    str1.Text:= web1.GetSource;
    str1.SaveToFile('e:\b.txt');
  str1.Free;
end;

procedure TForm1.ComboBox2DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
ComboBox2.Canvas.FillRect(Rect);
   ComboBox2.Canvas.CopyMode:=cmSrcCopy;
  ComboBox2.Canvas.TextOut(Rect.Left+26, Rect.Top+ 1, ComboBox2.Items[Index]);
 form_goods.draw22(ComboBox2.Canvas,Rect.Left,Rect.Top+ 1,24,24,game_read_values(Index+1,ord(g_Icon_index))+ 1);

end;

procedure TForm1.ComboBox2MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height:= 26;
end;

function TForm1.game_read_factor(i: integer): integer;
begin
  result:= Game_migong_xishu;
end;

function TForm1.game_write_factor(i: integer): integer;
begin
    Game_migong_xishu:= i;
    result:= 1;
end;
function getlocalhost: string;
var 
 computername:pchar; 
 size:cardinal; 
begin 
 size:=MAX_COMPUTERNAME_LENGTH+1;   
 getmem(computername,size); 
 if getcomputername(computername,size) then 
   result:=strpas(computername) 
 else
   result:='';
 freemem(computername); 
end;
procedure TForm1.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
 // var ss: string;
begin

  if pos('��������',e.Message)> 0 then
   begin
    messagebox(screen.ActiveForm.Handle,pchar('�����ʱ���'+Form_pop.get_error_words+'û�е��ںŷָ���ߵ��ں�ǰ����������ı���ַ������������ʹ�õ������Ĵʿ���ô����Ҫ��װ������Ϸ������ʹ�������ʶ����档'),'����',mb_ok);
   end else if pos('ע��',e.Message)> 0 then
       begin
        game_bg_music_rc_g.yodao_sound:= true; //�е������ʶ�
         if messagebox(screen.ActiveForm.Handle,'�ʶ����淢��������Ϣ�����û��ע�ᣬ���ָ����⣬���������tts���氲װ����ȷ���𣬰ٶ����緢���Զ����ã���������������������ʶ�û���⡣����ǣ��鿴�������','����',mb_yesno)=mryes then
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005699423',nil,sw_shownormal);
       end else if pos('OLE',e.Message)> 0 then
          begin
           game_bg_music_rc_g.yodao_sound:= true; //�е������ʶ�
         if messagebox(screen.ActiveForm.Handle,'�ʶ����淢��������Ϣ��OLE ���󣬳��ָ����⣬���������tts���氲װ����ȷ������������������(ע����ЩTTS�ʶ����氲װʱ��������˰�װ·��Ҳ���ܵ��´�����)���е����緢���Զ����ã���������������������ʶ�û���⡣����ǣ��鿴�������','����',mb_yesno)=mryes then
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005699423',nil,sw_shownormal);
          end else if pos('mshtml',e.Message)> 0 then
          begin
            ApplicationEvents1.Tag:= ApplicationEvents1.Tag +1;
             if ApplicationEvents1.Tag= 1 then
              begin
           if messagebox(screen.ActiveForm.Handle,'�����������ִ�����Ϣ������ǣ��鿴�������','����',mb_yesno)=mryes then
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005699423',nil,sw_shownormal);
              end;
          end else
           begin
           if messagebox(screen.ActiveForm.Handle,pchar('�����ˣ������Ϸ����������ֻ��û��Ӣ���ʶ���������ô����Ϸ���ý����ڹ�ѡ����ʹ�ðٶ��ʶ�������������,�Ƿ��Զ����ã�������ϢΪ��'+ e.Message +'��'),'����',mb_yesno)=mryes then
              game_bg_music_rc_g.yodao_sound:= true;
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005705882',nil,sw_shownormal);
      { ss:= 'http://www.finer2.com/add_error.asp?tit='+application.Title+ '&err='+inttostr(pscene_id) +screen.ActiveControl.Name +  getlocalhost +e.Message;
        if messagebox(screen.ActiveForm.Handle,pchar('��������˴��󣬴�����ϢΪ��'+ e.Message +'���Ƿ��ʹ�����Ϣ��'),'���ʹ�����Ϣ',MB_ICONWARNING or MB_YESNO)=mryes then
          begin
           ShellExecute(Handle,
              'open','IEXPLORE.EXE',pchar(ss),nil,sw_shownormal);
          end; }

            end;
end;

function TForm1.game_allow_gohome(i: integer): integer;
begin
   Game_not_gohome_G:= not(i=1); //����1������س�
   result:= 1;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
if Game_ad_count_G.X= 0 then
 game_chat('�����ȵ��һ�θ���Ȥ�Ĺ�棬Ȼ���ٵ�˰�ť�Ϳɹرչ�档ע���������ܻ��������ȫ���Ľ����������ν�����������40���ӡ�')
else begin
 if Game_ad_count_G.X= 2 then
    Game_ad_count_G.X:= 1;

 if Game_ad_count_G.Y >= 10 then
  messagebox(handle,'����Ѿ��ر�','��ʾ',mb_ok)
 else begin
       Game_ad_count_G.Y:= 10;
       game_chat('����ѹرա�ע���粻�رչ�棬��ôÿ�ε����潫���������ȫ���Ľ�����40������ֻ��ʹ��һ�Ρ�');
       game_reload_direct(0);
      end
      end;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
showmessage('��סCTRL�� Ȼ����������־Ϳ��Ե��������С�����Ϲ�������¹���С��');
end;

procedure TForm1.WebBrowser2StatusTextChange(Sender: TObject;
  const Text: WideString);
begin
   game_url:= text;
end;

function TForm1.game_id_from_oldname(const s: string): integer;
var i: integer;
begin
result:= -1;
   for i:= 0 to Game_role_list.Count-1 do
       if s=  Tplayer(game_role_list.Items[i]).pl_old_name then
        begin
         result:= i + 1;
         exit;
        end;

end;

function TForm1.game_lingli_add(p,t: integer): integer;
var i: integer;
begin
 result:= 1;

   if p= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
       // game_write_values(i,ord(g_life),game_read_values(i,ord(g_gdsmz27)));
        // game_write_values(i,ord(g_tili),game_read_values(i,ord(g_gdtl25)));
         game_write_values(i,ord(g_lingli),game_read_values(i,ord(g_lingli))+
                          round(game_read_values(i,ord(g_gdll26)) * t / 100));
         if game_read_values(i,ord(g_lingli)) > game_read_values(i,ord(g_gdll26)) then
            game_write_values(i,ord(g_lingli),game_read_values(i,ord(g_gdll26)));
         if game_read_values(i,ord(g_lingli)) < 0 then
            game_write_values(i,ord(g_lingli),0);
        end;
    end else begin
              if p<= game_get_role_H+1 then
                 begin
                //  game_write_values(p-1,ord(g_life),game_read_values(p-1,ord(g_gdsmz27)));
                 // game_write_values(p-1,ord(g_tili),game_read_values(p-1,ord(g_gdtl25)));
                  game_write_values(p-1,ord(g_lingli),game_read_values(p-1,ord(g_lingli))+
                                         round(game_read_values(p-1,ord(g_gdll26)) * t / 100));

                  if game_read_values(p-1,ord(g_lingli)) > game_read_values(p-1,ord(g_gdll26)) then
                      game_write_values(p-1,ord(g_lingli),game_read_values(p-1,ord(g_gdll26)));
                  if game_read_values(p-1,ord(g_lingli)) < 0 then
                      game_write_values(p-1,ord(g_lingli),0);
                 end else
                      result:= 0;
             end;

end;

procedure TForm1.N6Click(Sender: TObject);
begin
   if Game_role_list.Count= 0 then
    messagebox(handle,'��Ϸ��û��ʼ�����ȵ����Ļ�ϵġ���ʼ��Ϸ�����ӡ�','��Ϸû��ʼ',mb_ok)
    else
           game_pop_dig(300);


end;

procedure TForm1.PopupMenu3Popup(Sender: TObject);
begin
  n6.Enabled:= not Game_at_net_G;
  n17.Enabled:= not Game_at_net_G;
  n19.Enabled:= not Game_at_net_G;
  n20.Enabled:= not Game_at_net_G;
end;


procedure TForm1.game_error_net_user(ip:cardinal;pt: integer);
begin
     //������󣬶Ͽ����û�������

end;

function TForm1.game_rename_byid(id: integer;
  const newname: string): integer;
begin
   if Assigned(Game_role_list.Items[id-1]) then
    begin
    // if game_extfile_rename(Tplayer(Game_role_list.Items[id-1]).pl_old_name, newname) then
        Tplayer(Game_role_list.Items[id-1]).plname:= newname;
    end;
result:= 1;
end;

function TForm1.game_check_role_values_byid(id, id2,
  values: integer): integer;
begin
       //���ĳ�������ĳ����ֵ�Ƿ�ﵽĳֵ��
result:= 0;
if id= 0 then
   id:= 1;

       if Game_role_list.Count<= id then
        begin
          if game_read_values(id-1,id2)>= values then
           begin
            result:= 1;
           end;
        end;


end;

procedure TForm1.game_page_id_change(new_id: integer);
begin
   if game_debug_handle_g<> 0 then
      sendmessage(game_debug_handle_g,page_c1,new_id,0);

    if new_id <> pscene_id then
     begin
      old_pscene_id:= pscene_id;
      pscene_id:= new_id;
      Game_pscene_img_list.Clear; //���ҳ���Ѿ����ص��ļ��б�
          if game_at_net_g then
           begin
               //=0��Ա������ģʽ��=1��Ա����ģʽ��=2��ָ��棬100=���
            if game_player_head_G.duiwu_dg= 100 then
             Data_net.send_page_and_home_id(pscene_id,Phome_id,old_pscene_id,true)
            else
              Data_net.send_page_and_home_id(pscene_id,Phome_id,old_pscene_id,false); //���͵�ǰҳ���homeҳ�浽��������
           end;
     end;
end;

function TForm1.game_goto_oldpage(i: integer): integer;
begin

   result:= game_page(old_pscene_id);
    
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  //���е�ͼ
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'��Ϸû�п�ʼ��������Ļ�ϵġ���ʼ������Ϸ�����ߡ���ʼ������Ϸ����������Ϸ���ߴ�ȡ���ȡ�','��Ϸû��ʼ',mb_ok);
   exit;
  end;

 if game_check_res_event(5232)=1 then
 begin
 if game_can_fly(0)= 0 then  //����������Ի������߶�ʱ�������£�������س�

       messagebox(handle,'��ǰ������������С�','����ʧ��',mb_ok)
     else
        game_page(14445);
 end else begin
            messagebox(handle,'��û��ѧ�����֮����','����ʧ��',mb_ok);
          end;
end;

function TForm1.game_is_net_hide(i: integer): integer;
begin
  if Game_net_hide_g then
    result:= 1
    else
     result:= 0;
end;

function TForm1.game_show_logon(const ip: string): integer;
begin
   Game_server_addr_g:= ip;
   postmessage(form1.Handle,game_const_script_after,35,0);
   result:= 1;
end;

function TForm1.game_is_online(i: integer): integer;
begin
   if Game_at_net_G then
    result:= 1
    else
     result:= 0;
end;

function TForm1.game_show_note(const s: string): integer;
begin
   form_note.add_and_show(s);
   result:= 1;
end;

procedure TForm1.WMHotKey(var Msg: TWMHotKey);
begin
  if msg.HotKey= hot_wordgame_h then
   begin
    if game_hide_windows_h then
     begin
       ShowWindow(screen.ActiveForm.Handle, SW_show);
      ShowWindow(application.Handle, SW_show);
     end else begin
                 ShowWindow(screen.ActiveForm.Handle, SW_HIDE);
                ShowWindow(application.Handle, SW_HIDE);
              end;
     game_hide_windows_h:= not game_hide_windows_h;
   end;
end;

procedure TForm1.game_load_doc_net;
var i: integer;
begin
   Game_loading:= true;
    Game_save_path:= game_doc_path_G+ 'save\'+ form_net_set.Edit2.Text;
    if not DirectoryExists(Game_save_path) then
       MkDir(Game_save_path);
   Game_save_path:= Game_save_path + '\';
      //��¼idΪĿ¼��

   temp_event_clean; //�����ʱ��
   form_pop.load_game_progress(Game_save_path+ 'default.sav');

   //��ʼ���¼��������Ҫ���������¼��ļ�
  data2.load_event_file('');   //�����¼���Ϊ�գ�����һ���յ��¼�

  //����ͷ��
    data2.Load_file_upp(game_app_path_G+'dat\touxian.upp',Game_touxian_list_G);
    
  Phome_id:= game_read_scene_event(999); //��ȡ�سǵ�
  if Phome_id= 0 then
     Phome_id:= 14447; //�������ҳ

  Data2.load_goods_file; //������Ϸ��Ʒ������

 // Data2.game_load_goods; //������Ʒ

   game_load_image_to_imglist; //��������ͷ��

   Data2.game_load_task_file; //���������б�

   Form_pop.laod_fashu_wupin_k(Game_save_path + 'fwk.dat');   //���뷨����Ʒ��ݼ��б�

  button_stat(true); //����button״̬

   form_pop.load_abhs; //����abhs��

 // if (Game_scene_type_G and 2 = 2) or (Game_scene_type_G =1) then  //���Թ�
  //  Game_is_reload:= true; //��������ǰ����

  i:= game_read_scene_event(1000); //��ʾ���ĳ���
  if i= 0 then
     i:= 14447;

  game_page(i); 

  Game_loading:= false; //���ñ��������¿�ʼ�ļ�id���
end;

function TForm1.wait_scene_int_bool(b: boolean; id: integer): integer;
var t: cardinal;
     pk: Tmsg_cmd_pk;
begin
   Game_wait_ok2_g:= false; //�ȴ������¼�ֵ
    game_wait_integer2_g:= 0;
    t:= GetTickCount;
       if b then
        pk.hander:= byte_to_integer(g_secne_rq_bl_c,false)
       else
        pk.hander:= byte_to_integer(g_scene_rq_int_c,false);

      pk.pak.data1:= id;
      pk.pak.s_id:= my_s_id_g;

      g_send_msg_cmd(@pk,sizeof(pk)); //�����������

    while (Game_wait_ok2_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;

        if Game_wait_ok2_g then
        begin
         //�յ���������
         if game_wait_integer2_g= -1 then
          result:= 0
         else
         result:= game_wait_integer2_g;

        end else begin
                  // label9.Caption:= '��ȡ��ɫ���ݳ�ʱ��ʧ��';
                   result:= 0;
                 end;
end;

procedure TForm1.game_save_doc_net;
var pk: Tmsg_cmd_pk;
begin

 if not game_at_net_g then
   exit;

    Game_save_path:= game_doc_path_G+ 'save\'+ form_net_set.Edit2.Text + '\'; //����·�����������ļ���

    DeleteDirNotEmpty(Game_save_path); //���Ŀ¼

    game_write_scene_event(999,Phome_id);  //����سǵ�
    if pscene_id= 14444 then
       pscene_id:= old_pscene_id;
    game_write_scene_event(1000,pscene_id);          //���浱ǰ����id

  // data2.save_file_event(Game_save_path + 'event.fpp');
  // Data2.game_save_goods; //������Ʒ

   Data2.game_save_task_file; //���������б�
   Form_pop.save_fashu_wupin_k(Game_save_path + 'fwk.dat');   //���淨����Ʒ�����

      form_pop.save_abhs; //����abhs��
      form_pop.save_set(Game_save_path);

      pk.hander:= byte_to_integer(g_player_exit_c,false);  //�˳�
      pk.pak.s_id:= my_s_id_g;
      g_send_msg_cmd(@pk,sizeof(pk)); //�����������
      sleep(100);
       Data_net.MasterClient.Client.Disconnect(0,0); //�Ͽ�����
end;

procedure TForm1.game_reshow_net_id(all : boolean);
var
    ss: string;
    i,j,k: integer;
    t: cardinal;
    w: array of word;
begin
    //ˢ������id��ʾ

    j:= 0;
    ss:= '';


    //1�ϳɴ���2���
    for i:= 0 to high(user_info_time) do
     begin
      if (user_info_time[i].page= pscene_id) and (user_info_time[i].s_id<> -1) then
       begin
        if user_info_time[i].u_id= '' then
          begin
           user_info_time[i].nicheng:= '���ڽ�������';
          end;
        ss:= ss + '<a href="game_netuserinfo(' +inttostr(user_info_time[i].s_id)  + ')" title="'+user_info_time[i].u_id +'">'+user_info_time[i].nicheng +'</a>&nbsp;';
         inc(j);
       end;
      if all= false then
       begin
        if j= 10 then
          begin
            ss:= ss+ '������ʾȫ���û�';
            break;
          end;
       end;
     end;  //end for �ϳ�

      change_html_by_id('cell_net1',ss);


      //���������û�������
      //ȡ������
      k:= 0;
      t:= GetTickCount;
      for i:= 0 to high(user_info_time) do
       begin
          if (user_info_time[i].page= pscene_id) and (t - user_info_time[i].time > refresh_time_C) then
             inc(k)
              else if (user_info_time[i].page= pscene_id) and (user_info_time[i].u_id= '') then
                      inc(k);
       end;

    //�����ڴ棬���
    if k= 0 then
      exit;

      k:= k+2;
     setlength(w,k);
       for i:= 0 to high(user_info_time) do
       begin

          if (user_info_time[i].page= pscene_id) and (t - user_info_time[i].time > refresh_time_C) then
           begin
             dec(k);
             w[k]:= user_info_time[i].s_id;
           end
              else if (user_info_time[i].page= pscene_id) and (user_info_time[i].u_id= '') then
                  begin
                    dec(k);
                       w[k]:= user_info_time[i].s_id;
                  end;

       end;
   //����
   pinteger(w)^:= byte_to_integer(g_rep_online_page_data_c,false);
   g_send_msg_cmd(pointer(w),(high(w)+1)*2);

end;

function TForm1.game_netuserinfo(i: integer): integer;
var j: integer;
    ss: string;

begin
     //�ڶԻ�������ʾ�����Ϣ  i ������id
    //��ʾ���ң���֯��С������������
    for j:= 0 to high(user_info_time) do
     begin
        if user_info_time[j].s_id= i then
         begin
          ss:= '���ID��<a href="game_show_dwjh('+ inttostr(i)+',0)" title="�鿴��Ϣ">' + user_info_time[j].u_id + '</a>���ǳƣ�'+ user_info_time[j].nicheng;
           ss:= ss + '������С�ӣ�'+net_get_dwjhming(user_info_time[j].xiaodui,1);
           ss:= ss + '��������֯��'+net_get_dwjhming(user_info_time[j].zhuzhi,2);
           ss:= ss + '�����ڹ��ң�'+net_get_dwjhming(user_info_time[j].guojia,3);
             ss:= ss + '��<a href="game_show_chat('+ inttostr(i)+')" title="�����������">����</a>';
             ss:= ss + '��<a href="game_show_trade('+ inttostr(i)+')" title="������ѽ�����Ʒ">����</a>';
             ss:= ss + '��<a href="game_send_game_msg('+ inttostr(i)+')" title="��������������">����</a>';
             ss:= ss + '��<a href="game_send_pk_msg('+ inttostr(i)+')" title="������������Ծ�">PK</a>';
               
          game_chat(ss);
          break;
         end;
     end; // end for
   result:= 1;
end;

function TForm1.game_reshow_online(i: integer): integer;
begin
   //������ʾ��������
   Data_net.send_page_and_home_id(pscene_id,Phome_id,old_pscene_id,false); //���͵�ǰҳ���homeҳ�浽��������
  result:= 1;
end;

function TForm1.game_show_dwjh(id,tp: integer): integer;
begin
    //��ʾ���飬���ң���֯����Ϣ���� ����idΪdwjh��id
   if not Assigned(Form_dwjh) then
       Form_dwjh:= TForm_dwjh.Create(application);

     Form_dwjh.PageControl1.Parent:= Form_dwjh;
     Form_dwjh.show_tp:= tp;
       Form_dwjh.show_data_sid:= g_nil_user_c;
       Form_dwjh.show_data_xiaodui:=0;
       Form_dwjh.show_data_zhuzhi:=0;
       Form_dwjh.show_data_guojia:=0;
     case tp of
     0: Form_dwjh.show_data_sid:=id;
     1: Form_dwjh.show_data_xiaodui:= id;
     2: Form_dwjh.show_data_zhuzhi:= id;
     3: Form_dwjh.show_data_guojia:= id;
     end;
     Form_dwjh.Show;
  result:= 1;
end;

function TForm1.game_send_pk_msg(id: integer): integer;
begin
    //����pk���� ��������ܱ���������pk���ܷ��ͣ��������Ӧ��������ȴ��Է���Ӧ�������������������
    result:= 0;
end;

function TForm1.game_showshare_readtext(i: integer): integer;
begin
  button10.Click;
end;

function TForm1.game_show_chat(id: integer): integer;
begin
    //��ʾ����Ի�����
   with Tform_chat.Create(application) do
    begin
     player_chat_id:= id; //�����id
     Show;
    end;
result:= 1;
end;

function TForm1.game_send_game_msg(id: integer): integer;
begin
//���;�������
   result:= 0;
end;

function TForm1.game_show_trade(id: integer): integer;
begin
     //��ʾ���״���
  result:= 0;
end;

function TForm1.game_add_user_dwjh(tp, sid, dwjh_id: integer): integer;
begin
    //ͬ������������������ͼ�������Ȼ���÷������ٹ㲥��������
     
    if tp= 1 then
     begin
      if (game_player_head_G.duiyuan[0]< g_nil_user_c) and (game_player_head_G.duiyuan[1]< g_nil_user_c) and
          (game_player_head_G.duiyuan[2]< g_nil_user_c) and (game_player_head_G.duiyuan[3]< g_nil_user_c) then
           begin
            game_chat('��Ա�����Ѵ����ޣ�һ��С��ֻ��5�ˣ������Լ�����');
             result:= 0;
            exit;
           end;
     end;

           send_pak_tt(g_xiaodui_jr_c,tp,sid,dwjh_id,0);
           result:= 1;
end;
//*****************************************************������Ϣ
procedure TForm1.msg_event_c1(var msg: TMessage);
begin
   //�յ������¼���ѯ
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= game_check_scene_event(msg.WParam);
end;

procedure TForm1.msg_event_c2(var msg: TMessage);
begin
   //�յ������¼�����
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= game_write_scene_integer(msg.WParam,msg.LParam);
         end;
end;

procedure TForm1.msg_goods_c1(var msg: TMessage);
begin
   //��Ʒ��ѯ
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= read_goods_number(msg.WParam);
end;

procedure TForm1.msg_goods_c2(var msg: TMessage);
begin
    //��Ʒ�޸�
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= ord(write_goods_number(msg.WParam,msg.LParam));
         end;
end;

procedure TForm1.msg_page_c2(var msg: TMessage);
begin
    //goto ҳ��
   if game_at_net_g or (game_debug_handle_g=0) or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
           game_page(msg.WParam);
            msg.Result:= 1;
         end;
end;

procedure TForm1.msg_player_c1(var msg: TMessage);
begin
   //��ѯ����  game_read_values
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= game_read_values(msg.WParam,msg.LParam);
end;

procedure TForm1.msg_player_c2(var msg: TMessage);
begin
   //д������ֵ
    if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= ord(game_write_values(msg.WParamLo,msg.WParamHi,msg.LParam));
         end;
end;

procedure TForm1.msg_res_c1(var msg: TMessage);
begin
  //��ѯ���¼�
  if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= game_check_res_event(msg.WParam);
end;

procedure TForm1.msg_res_c2(var msg: TMessage);
begin
   //д�����¼�
    if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= 1;
           if msg.LParam= 1 then
             game_add_res_event(msg.WParam)
            else
             game_del_res_event(msg.WParam);  //��Ʒ�¼�ֻ��д��1������
         end;
end;

procedure TForm1.msg_stop_c(var msg: TMessage);
begin
  //������Ϸ
  if game_at_net_g or (game_debug_handle_g=0) then
    msg.Result:= -1
    else begin
           msg.Result:= 1;
           TerminateProcess(GetCurrentProcess, 1);
         end;
end;

procedure TForm1.debug_send_func_str(const s: string; flag: integer); //���͵����ı�
var
  Data: TCopyDataStruct;
begin
 if game_debug_handle_g= 0 then
    exit;
    //���͵����ı���flagָ�������� html_C func_C
  Data.dwData := flag;
  Data.cbData := Length(s);
  Data.lpData := AllocMem(Length(s));
  move(pointer(s)^, pchar(Data.lpData)^, length(s));
  SendMessage(game_debug_handle_g, wm_copyData,handle, Integer(@Data));
  freemem(Data.lpData, length(s));

end;

//*************************************************������Ϣ����

function TForm1.game_reload_chatlist(i: integer): integer;
begin
       //�������������¼
       game_reload_chat_g:= true;
          game_direct_scene(pscene_id);
       game_reload_chat_g:= false;

  result:= 1;
end;

function TForm1.game_chat_cleans2(i: integer): integer; //���촰�ڹرհ�ť
begin
     if Game_scene_type_G and 8= 8 then
      game_chat('���ζԻ���ֹ��;�˳������Ƚ����Ի���')
      else
       game_scr_clean2;
result:= 1;
end;

function TForm1.game_chat_spk_add(const s: string): integer;
begin
  game_duihua_list.Add(s);
  timer_duihua.Enabled:= true;
result:= 1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
    if game_at_net_g then  //��ʾС����Ϣ
   begin
    game_show_dwjh(my_s_id_G,0);
   end else begin
              messagebox(handle,'�ù����ڲ�������Ϸʱ�����á�','������',mb_ok);
            end;
end;

procedure TForm1.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin

 if (pos('finer2',game_url)=0) then
    begin
      if Game_ad_count_G.X<> 1 then
         Game_ad_count_G.X:= 2;

     if GetTickCount - ad_mtl_time > 2400000 then
        begin
         game_role_all_mtl(0);
         ad_mtl_time:= GetTickCount;
         game_chat('������ȫ�����ٴ�ʹ�ô˼��ܣ�����40���ӣ���'+ timetostr(time + 0.02774));
        end else begin
                  game_chat('������Ч���´�ʹ�ô˼��ܵ�ʱ��Ϊ��'+ timetostr(time +
                  ((2400000 -(GetTickCount - ad_mtl_time)) /86405530)
                  ));
                 end;
    end;
end;

function TForm1.game_asw_html_in_pop(i: integer): integer;
var ss: string;
begin

     //visible_html_by_id('layer_chat1',true);
     //change_html_by_id('cell_chat1','');
     ss:= form_pop.html_asw_string(i);
     change_html_by_id('cell_chat1',ss);

   game_chat_cache_g:= ''; //������컺��
    result:= 1;
end;

procedure TForm1.html_pop(i: integer);
var ss: string;
begin
    ss:='document.getElementById("layer_chat1").height=368;'+
        'document.getElementById("layer_chat1").top='+ inttostr((web1.height-268) div 2)+ ';'+
        'document.getElementById("layer_chat1").style.display="block";'+
        'document.getElementById("cell_chat1").innerHTML="'+StringReplace(form_pop.get_pop_string(i),'"','\"',[rfReplaceAll])+'";';

   web1.ExecuteJavascript(ss);

   game_chat_cache_g:= ''; //������컺��

end;

function HexToStr(s:ansistring):string; //16����ת�ִ�
var
    HexS,TmpStr:ansistring;
    i:Integer;
    a:Byte;
begin
    HexS:=s;
    if Length(HexS) mod 2=1 then
    begin
        HexS:=HexS+'0';
    end;
    TmpStr:='';
    for i:=1 to(Length(HexS)div 2)do
    begin
        a:=StrToInt('$'+HexS[2*i-1]+HexS[2*i]);
        TmpStr:=TmpStr+ansiChar(a);
    end;
    Result:=TmpStr;
end;

{
procedure TForm1.show_ad_error;
var pDoc:  IHTMLDocument3;
    tt: IHTMLElement;
begin
  pdoc:= Form1.WebBrowser1.Document as IHTMLDocument3;
    if pdoc<> nil then
     begin
      tt:= pdoc.getElementById('ad_layer1');
       if tt= nil then
        begin
         sleep(200);
         tt:= pdoc.getElementById('ad_layer1');
        end;

       if tt<> nil then
        tt.style.display:='none';

        if Game_ad_count_G.Y < 14 then
        Game_ad_count_G.Y:= Game_ad_count_G.Y + 2
        else
          Game_ad_count_G.X:= 1; //��������7�Σ���ֹ��ʾ���

     end;

end;
     }
function TForm1.game_set_var(i, v: integer): integer;
begin
     case i of
     1: not_show_img_tip_g:= (v=1);  //i=1 ���ڡ�����ʾͼƬ��ʾ������
     2: game_bg_music_rc_g.sch_enable:= (v=1); //����ͼƬ�Ƿ���ʾ
     3: game_bg_music_rc_g.bg_img:= (v=1);   //����ͼ���ã�ֵΪ 1����ʾ����
     4: game_bg_music_rc_g.bg_music:= (v=1);    //������������
     5: game_bg_music_rc_g.mg_pop:= (v=1);    // ;�Թ�����ʽ�����ʴ�������
     6: game_bg_music_rc_g.pop_img:= (v=1);   // ;��ҳʽ�����ʴ��ڱ���ͼ����
     7: game_bg_music_rc_g.sch_enable:= (v=1);   // ;ͼƬ��������
     8: game_bg_music_rc_g.not_tiankong:= (v=1);    // ;��ֹ���ʽѡ��
     9: game_bg_music_rc_g.type_word:= (v=1); //;���ü������뱳����
     10: game_bg_music_rc_g.type_word_flash:= (v=1);  //������˸
     11: game_bg_music_rc_g.type_char_spk:= (v=1);   //��ĸ����
     end;

     result:= 1;
end;

function TForm1.game_show_set(i: integer): integer;
begin

 form_set.PageControl1.ActivePageIndex:= i;
  form_set.ShowModal;
  result:= 1;
end;

procedure TForm1.loadurlbegin(Sender: TObject; sUrl: string; out bHook,
  bHandled: boolean);
begin
  showmessage(surl);
end;

procedure TForm1.load_sch_pic;  //ˢ�����ص�ͼƬ
var ss: string;
begin
  down_http.Create(get_down_img_url,'',false);
  ss:= 'document.getElementById("img_shc").height='+game_bg_music_rc_g.sch_img_height.tostring+';'+
                 'document.getElementById("img_shc").src="+temp_pic_file_g +";';
  ss:= StringReplace(ss,'"','\"',[rfReplaceAll]);
  web1.ExecuteJavascript(ss);

        temp_pic_file_g:= '';
         temp_sch_key_g:= '';



end;


function TForm1.game_include_str(const s: string): pchar;
var str1: Tstringlist;
begin
      //��ȡ����ִ�е�����
      str1:= Tstringlist.Create;
      Data2.Load_file_upp(game_app_path_G + 'dat\'+ s, str1);
    if str1.Count= 0 then
       Game_pchar_string_G:= 'no string find'
       else
        Game_pchar_string_G:= str1.Text;

        str1.Free;
     result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_inc_scene_event(id, v: integer): integer;
begin
    result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),0);
  result:= result + v;
   data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),result);

   result:= 1;
end;

function TForm1.game_inner_html(i: integer; s: string): integer;

begin

                                                    //����html
  change_html_by_id('bo_'+ inttostr(i),s);
  result:=1;


end;

function TForm1.game_biao_html(i: integer): integer; //�����
var ss: string;
begin
  result:= 0;
     if i= 1 then
           ss:= '<a href="game_write_temp(game_get_pscene_id(0),0);game_biao_html(0)" title="ȡ�����">'
                         +'<img src="file:///'+game_app_path_G+'img\img_flag.gif" border="0">'+ inttostr(pscene_id -10000)+ '</a>'
                         else
           ss:= '<a href="game_write_temp(game_get_pscene_id(0),1);game_biao_html(1)"'
                         +'title="������������ǣ��������������ˡ�">���<b>�������</b></a>';

     change_html_by_id('biao_1',ss);

    // file:///'+game_app_path_G+'img/img_flag.gif
            result:=1;


end;

function TForm1.game_res_goods(i,sl: integer; const s: string): pchar;

 function get_pic: string;
  begin
  // 1=װ����2=ʳ��ҩƷ��4=Ͷ�������࣬8=ұ���࣬16=����,32=��ҩ
  //��64=������Ʒ,128=�����鼮,256=������ǿ��
     case data2.get_game_goods_type(form_goods.get_goods_id(s),goods_type1) of
     1: result:= 'img_w_1.gif';
     2: result:= 'img_w_2.gif';
     4: result:= 'img_w_4.gif';
     8: result:= 'img_w_8.gif';
     16: result:= 'img_w_16.gif';
     32: result:= 'img_w_32.gif';
     64: result:= 'img_w_64.gif';
     128:result:= 'img_w_128.gif';
     256:result:= 'img_w_256.gif';
     else
        result:= 'img_w_0.gif';
     end;
     result:= '<img src="file:///'+game_app_path_G+'img/'+ result +'" border="0">';
  end;
begin    //����һ����Ʒ�Ƿ�񵽵ı�׼�ַ���
        {
        iֵ��С�ڵ�����ģ���game pscene id ���
        �����㣬С�ڵ���100�ģ���ʾһ���������
        ����100�ģ���ʾһ����Ʒ�¼�id
        }

       if (i> 0) and (i <= 100) then  //���������Ʒ
           begin
             if (game_random_chance(i)=1) and (not Game_at_net_G) then
               begin
                i:= i+ random(100); //span id ����һ�����id
                Game_pchar_string_G:='<span id="bo_'+inttostr(i)+
       '"><a href="game_goods_change_n('''+ s +''','+inttostr(sl)+
       ');game_chat(''��'+s + inttostr(sl)+''');'+
       'game_inner_html('+inttostr(i)+','' '')" title="����">'+get_pic+'</a></span>';

               end else Game_pchar_string_G:= ' ';

           end else begin  //***********************************

                      if i<= 0 then
                        i:= game_get_pscene_id(i);
    if game_not_res_event(i)=1 then
      begin
       Game_pchar_string_G:='<span id="bo_'+inttostr(i)+
       '"><a href="game_goods_change_n('''+ s +''','+inttostr(sl)+
       ');game_chat(''��'+s + inttostr(sl)+''');game_add_res_event('+inttostr(i)+
       ');game_inner_html('+inttostr(i)+','' '')" title="����">'+get_pic+'</a></span>';
      end else
            Game_pchar_string_G:= ' ';
                   end;  //*************************************

    result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_can_fly(i: integer): integer;
begin
    result:= ord(not (
    (Game_scene_type_G and 8 = 8) or timer1.Enabled or Game_not_gohome_G));
end;

procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
   if (Msg.message = WM_RBUTTONDOWN) and IsChild(Web1.Handle, Msg.Hwnd) then
  begin
  popupmenu3.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);//�Լ�����Ĳ˵�
  Handled := True;
  end;

end;

function TForm1.game_bubble(bb: integer): integer;  //����������������������
begin
   {
    ��������������
   }
   showmessage('��������ʱ����ʹ�ã���ȴ��°汾��');
   result:= ord (false);
   exit;

   form_pop.game_pop_count:= bb;
  form_pop.game_pop_type:= 6; //������

    {������Ŀǰ������
   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(1, i,0);  }

      result:= ord (form_pop.ShowModal= mrok);
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  //������
    if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'��Ϸ��û��ʼ�����ȵ����Ļ�ϵġ���ʼ��Ϸ�����ӡ�','��Ϸû��ʼ',mb_ok);
    exit;
   end;
   game_bubble(Tmenuitem(sender).Tag);
end;

procedure TForm1.N14Click(Sender: TObject);
begin
   if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'��Ϸ��û��ʼ�����ȵ����Ļ�ϵġ���ʼ��Ϸ�����ӡ�','��Ϸû��ʼ',mb_ok);
    exit;
   end;
   game_wuziqi(Tmenuitem(sender).Tag);
end;

function TForm1.game_wuziqi(bb: integer): integer;
begin
    {
    ���������崰��
   }
   showmessage('��������ʱ����ʹ�ã���ȴ��°汾��');
   result:= ord (false);
   exit;

   form_pop.game_pop_count:= bb;
  form_pop.game_pop_type:= 7; //������

    {������Ŀǰ������
   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(1, i,0);  }

      result:= ord (form_pop.ShowModal= mrok);
end;

procedure TForm1.TrayShow(Sender: TObject);
begin
//�趨 TNotifyIconData �ļ�¼����
  MyTrayIcon.cbSize :=SizeOf(tnotifyicondata);
  //ȷ�����ó���Ĵ�����
  MyTrayIcon.Wnd :=Handle;
  //ȷ��ͼ��� uID
  MyTrayIcon.uID :=1;
  //�趨��ʾ���
  MyTrayIcon.uFlags :=NIF_ICON or NIF_TIP or NIF_MESSAGE;
  //�û��Զ�����Ϣ
  MyTrayIcon.uCallbackMessage := WM_MYTRAYICONCALLBACK;
  //����ͼ��ľ��
  MyTrayIcon.hIcon := Application.Icon.Handle;
  //����ͼ�����ʾ��Ϣ
   strcopy(MyTrayIcon.szTip,pchar(application.title));
  //�����������ͼ��
  Shell_NotifyIcon(NIM_ADD,@mytrayicon);
end;
procedure show_gamewordow;
begin
  form_chinese.close;
   Application.Restore;  //�ָ�����
   Application.BringToFront; //�ᵽǰ����ʾ
    Form1.N24.Visible:= false;
   Shell_NotifyIcon(NIM_DELETE, @MyTrayIcon);//ɾ������ͼ��
end;

procedure TForm1.WMMyTrayIconCallBack(var Msg: TMessage);
var
  CursorPos : TPoint;
begin
  case Msg.lParam of
    //�������
    WM_LBUTTONDOWN : begin
                      // application.MainForm.BringToFront;   ������ǰ
                      show_gamewordow;
                     end;
    //���˫��
    WM_LBUTTONDBLCLK : begin                                //������������ʾ
                         //Application.MainForm.Visible := not Application.MainForm.Visible;
                         //SetForegroundWindow(Application.Handle);
                         if IsIconic(Application.Handle) = True then  //�����Ƿ���С��
                          begin
                           show_gamewordow;
                          end;
                       end;
    //�Ҽ�����
    WM_RBUTTONDOWN :   begin                                //��ʾ�����˵�
                         GetCursorPos(CursorPos);
                         PopupMenu3.Popup(CursorPos.x,CursorPos.y);
                       end;
   end//case

end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
    //��С��ʱ�Ĳ��� �����ڵ�ǰ������ǰ��Ĵ���ʱ��ִ�����汳���ʲ���
    if game_bg_music_rc_g.desktop_word then
    begin
    TrayShow(sender);
    N24.Visible:= true;
    ShowWindow(Application.Handle, SW_HIDE);
    if not Assigned(form_chinese) then
       form_chinese:= TForm_chinese.Create(application);  //���������ʶ�����
       form_chinese.show;
       SetWindowPos(form_chinese.handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove or swp_NoSize);
       //form_chinese.FormStyle:= fsStayOnTop;
       //SetactiveWindow(form_chinese.Handle);
    end;
end;

procedure TForm1.N24Click(Sender: TObject);
begin
   show_gamewordow;
end;

function TForm1.game_save_count(i: integer): integer;  //ȡ�ô浵����
var vSearchRec: TSearchRec;
  vPathName: string;
  K: Integer;
  ct: integer;
begin
   ct:= 0;

   vPathName := game_doc_path_G+'save\*.*';
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      inc(ct);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

   vPathName := game_app_path_G+'save\*.*';
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      inc(ct);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  vPathName := form_save.get_app_data_path + '\��������Ϸ��������\*.*';  //�ٴ�����app·��
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      inc(ct);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  result:= ct;
end;

function TForm1.game_chinese_spk(const s: string): integer;
begin

     form_pop.skp_string(s);
  result:= 1;
end;

procedure TForm1.update_caption(i: integer);
begin
   caption:= application.Title + ' '+ '�ѱ�������' + inttostr(i);
   if part_size_g<> nil then
     caption:= caption + '/' + inttostr(high(part_size_g));

end;

procedure TForm1.visible_html_by_id(const id: string; canshow: boolean);
var ss: string;
begin
      ss:= 'document.getElementById("'+id+ '").';
       if canshow then
        ss:= ss+ 'style.display="block";'
        else
         ss:= ss+ 'style.display="none";';

   web1.ExecuteJavascript(ss);
end;

end.

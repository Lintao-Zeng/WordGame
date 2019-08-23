unit Unit_pop;

interface
 //{$DEFINE IBM_SPK}
  {$DEFINE MS_SPK}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  Unit_player,Unit_data,jpeg,KSVOICELib_TLB,
  {$IFDEF MS_SPK}OleServer,SpeechLib_TLB,{$ENDIF} AsphyreDb, AsphyreFonts,
  AsphyreImages, AsphyreSubsc, AsphyreDevices, Asphyre2D, AsphyreCanvas,
  AsphyreTimers,AsphyreDef,shellapi, ActnList, AsphyreParticles, Menus,
  DXSounds,unit_glb,Unit_wuziqi,SHDocVw;



 const
  um_ontimer=wm_user+259;
  um_quitthread=wm_user+261;
   pic_start= 5;
   jit_delay= 60;
   jit_words_i_c= 2; //Ĭ��������ʾ������Ϊ3

   game_bmp_h1= 42;  // ���ʵĸ߶�

   game_bmp_h2= 32;   //���͵ĸ߶�
   game_bmp_role_width= 80; //�ֺ��ҷ�����Ŀ��
   game_bmp_role_h= 48;  //�ֺ��ҷ�����ĸ߶�
   G_all_pic_n= 0;  //ȫ��gl�����ֹѡ��
   G_words_Pic_y=1; //���ʴ�gl�����ѡ
   G_g_pic_y=2; //����gl�����ѡ��
   G_my_pic_y=3; //�ҷ���Ա����ͼƬ��ѡ��
   gl_count_plane= 14; //glplane������
   gl_role_show_count= 5; //ȫ�����ϳ�ս��������������
   game_amt_length= 60; //����֡
   game_amt_delay= 30; //��ʱ����
   g_result_w1= 256;  //�����ʾ 384
   g_result_h1= 128;

    G_C_role_top= 400;  //�ҷ����ﶥ��
    G_C_guai_top= 40;    //���ﶥ��
    G_C_role_left1= 20;   //�ҷ�����͹�����������
    G_C_role_left2= 140;
    G_C_role_left3= 260;
    G_C_role_left4= 380;
    G_C_role_left5= 500;

    G_checked_color:TColor4 =($00FFFFFF, $00FFFFFF, $FFFFAF00, $FFFFAF00); //����ѡ�к����ɫ
    G_right_color:TColor4 =($00FFFFFF, $00FFFFFF, $FFFF00AF, $FFFF00AF); //������ȷ����ɫ
    G_checked_guai_color:TColor4 =($FF8060A0, $FF8060A0, $FF8060A0, $FF8060A0); //��ѡ�к����ɫ
    G_checked_role_color:TColor4 =($FF8060A0, $FF8060A0, $FF8060A0, $FF8060A0); //roleѡ�к����ɫ

    G_C_danci_top= 170;
    G_C_jieshi1_top= 220;
    G_C_jieshi2_top= 260;
    G_C_jieshi3_top= 300;

    g_C_DonghuaQianWenZi= 400; //����ǰ������ʾʱ�� ����
    g_boll_w_cn= 30; //������Ŀ�͸�
    g_boll_h_cn= 26;
    g_boll_21_cn= 20;  //������� 21��
    g_boll_14_cn= 14; //������� 15��
    g_ball_color_cpt= 1;
    g_ball_color_me= 3; //�ҷ���������ɫ

type
      T_caoshi_list= record
       sid: word;
       caoshi: word;
       end;

      ttime_list= record
       Timer_wo_gongji: boolean;
       Timer_guai_gongji: boolean;
       Timer_wo_fashugongji: boolean;
       Timer_guai_fashugongji: boolean;
       Timer_wupin_gongji: boolean;
       Timer_wupin_huifu: boolean;
       Timer_fashu_huifu: boolean;
       Timer_gong: boolean;
       Timer_donghua: boolean;
       Timer_bubble: boolean; //����������������
       Timer_show_jit_word: integer; //��3���������ʾ
       Timer_show_jit_alpha: integer; //���ʺͽ��͵�͸���任
       end;
      Tbubble_data= record
       boll_show: boolean;  //��ʾ�˶�����
       boll_color: integer;   //��ɫ����
       boll_left: integer;
       boll_top: integer;
       next_color: integer; //��һ���ȴ��������ɫ������ֵ
       arrow_Angle: real; //��ͷ�Ƕ�
       boll_path_length: integer; //�򳤶�
       sycs: integer; //ʣ��Ĵ����ݴ���
       start_X: integer; //ԭ��
       start_Y: integer;
       zt: integer; //״̬��0��ʾ���ƶ���1��ʾ����ʧ
       last_y: integer;
       last_x: integer; //���һ��������ȥ����
       dot_line_count: integer; //����ʾ���ߴ���
       end;
      twuziqi_rec= record
       me_row: integer;  //�ҷ��������λ��
       me_col: integer;
       cpt_row: integer; //�����������λ��
       cpt_col: integer;
       row: integer;    //������ӣ��������ҷ����ߵ��ԣ����ڻ�����
       col: integer;
       cpt_count: integer; //�Է���������
       me_count: integer; //�ҷ���������
       xy0: boolean;
       x0,y0,x1,y1: integer; //����
       word_showing: boolean; //������ʾ������
       word_time: integer;   //��ʾ��ʱ��
       cpt_win: boolean; //�Ƿ����Ӯ��
       end;
     TBranchColor=record
      r,g,b:Byte;
      end;
     Tparticle_rec=record
      xian: boolean;
      xuli: integer;
      xiaoguo: integer;
      end;
     {PError_word= ^TError_word;
     TError_word= packed record
      wordid: word;
      RepCount: word;
      next: perror_word;
      end; }
      //��ǰ��Ϸ״̬ wuziqi1=������״̬��wuziqi2=��ʾ����״̬
      T_game_Status=(g_start,G_word,G_chelue,G_animation,g_bubble,g_boll_move,g_wuziqi1,g_wuziqi2,G_end);
        //��ǰ���λ��
      T_Mouse_at=(mus_nil,mus_guai1,mus_guai2,mus_guai3,mus_guai4,mus_guai5,
                  mus_role1,mus_role2,mus_role3,mus_role4,mus_role5,
                  mus_danci1,mus_jieshi1,mus_jieshi2,mus_jieshi3,mus_wuziqi);
      T_word_QianHouZhui= record
       qian_start: word;
       qian_end: word;
       hou_start: word;
       hou_end: word;
       end;
      T_donghua_weizhi= record
        weizhi: TRect;   //������ǰλ��
        xianshi: boolean;    //�Ƿ���Ҫ��ʾ
        zhen: integer;    //��ǰͼ�ڼ�֡
        time: integer; //������ʱʱ�䣬Ϊ���ʾ����
        alpha: byte; //͸����
        end;
      T_zhi_piaodong= record
       xianshi: boolean;
       left1: integer;
       top1: integer;
       peise: cardinal;
       xiaoguo: cardinal;
       zhi: string[12];
       end;
      T_word_weizi= record
       weizi: Trect;
       alpha: byte;
       end;

 TGameSave= record
     me_win: integer; //�ҷ�Ӯ������
    sch_count:integer;
    koucu: integer;
    leiji: integer; //�ۼ���Ϸʱ��
    cpt_win: integer;          //����Ӯ������
    music_index:integer;
    img_index: integer;
    zhuangtai: integer;
    index: integer;
    tip1: integer;
    tip2: integer;
    tip3: integer;
    tip4: integer;
    tip5: integer;
    tip6: integer;
    tip7: integer; //��¼˳��ֵ
    zqbs: integer;
    cwbs: integer;
  end;
    Lon_SmallInt_rec= packed record
      case Integer of
      0: (Lo, Hi: SmallInt);
      1: (Words: array [0..1] of Word);
      2: (int: integer);
     end;
    Tmtl_rec=packed record   //������ṹ�飬��ֵ
     m: Lon_SmallInt_rec;  //���ز�ֵ���߶�Ϊ�������ٲ�ֵ���Ͷ�Ϊ�������ֵ SmallInt
     t: Lon_SmallInt_rec;  //��
     l: Lon_SmallInt_rec;   //�� �Ͷ�Ϊ��
     end;
     
  TForm_pop = class(TForm)
    GroupBox3: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox8: TCheckBox;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox1: TListBox;
    StatusBar1: TStatusBar;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Label1: TLabel;
    Panel1: TPanel;
    AsphyreDevice1: TAsphyreDevice;
    AsphyreTimer1: TAsphyreTimer;
    AsphyreCanvas1: TAsphyreCanvas;
    AsphyreImages1: TAsphyreImages;
    AsphyreFonts1: TAsphyreFonts;
    Timer_donghua: TTimer;
    ASDb1: TASDb;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    Action15: TAction;
    AsphyreParticles1: TAsphyreParticles;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Action16: TAction;
    Action17: TAction;
    Action18: TAction;
    Action19: TAction;
    Action20: TAction;
    Button11: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    DXSound1: TDXSound;
    DXWaveList1: TDXWaveList;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Timer_auto_attack: TTimer;
    Timer5: TTimer;
    Action21: TAction;
    Timer_daojishi: TTimer;
    Edit1: TEdit;
    Action_az1: TAction;
    Action_az2: TAction;
    Action_az3: TAction;
    Action22: TAction;
    Action23: TAction;
    Action24: TAction;
    Action25: TAction;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckBox8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer4Timer(Sender: TObject);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure AsphyreDevice1Initialize(Sender: TObject;
      var Success: Boolean);
    procedure AsphyreTimer1Timer(Sender: TObject);
    procedure AsphyreDevice1Render(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer_donghuaTimer(Sender: TObject);
    procedure Timer_wo_gongjiTimer;
    procedure Timer_guai_gongjiTimer;
    procedure Timer_wo_fashugongjiTimer;
    procedure Timer_guai_fashugongjiTimer;
    procedure Timer_wupin_gongjiTimer;
    procedure Timer_wupin_huifuTimer;
    procedure Timer_fashu_huifuTimer;
    procedure Timer_gongTimer;
    procedure Timer_bubbleTimer; //���������򶯻�
    procedure Action1Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure Action14Execute(Sender: TObject);
    procedure Action15Execute(Sender: TObject);
    procedure AsphyreTimer1Process(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button6DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Action16Execute(Sender: TObject);
    procedure Action17Execute(Sender: TObject);
    procedure Action18Execute(Sender: TObject);
    procedure Action19Execute(Sender: TObject);
    procedure Action20Execute(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N7Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Timer_auto_attackTimer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure Action21Execute(Sender: TObject);
    procedure Timer_daojishiTimer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ActionList1Execute(Action: TBasicAction;
      var Handled: Boolean);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Action_az1Execute(Sender: TObject);
    procedure Action_az2Execute(Sender: TObject);
    procedure Action_az3Execute(Sender: TObject);
    procedure Action22Execute(Sender: TObject);
    procedure Action23Execute(Sender: TObject);
    procedure Action24Execute(Sender: TObject);
    procedure Action25Execute(Sender: TObject);
    procedure SpVoice1EndStream(Sender: TObject; StreamNumber: Integer;
      StreamPosition: OleVariant);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
  private
    { Private declarations }
    jit_koucu: integer; //�Ѿ��۳������������Ľ�Ǯ
     jit_leiji: integer;
     jit_time: integer;
    // jit_total: integer; //�ۼƴ���
     jit_num: integer; //�������ѱ�����
     goods_time_list: Tstringlist; //��һ��ʱ������Ч����Ʒ�б����ں�ɾ��
     fashu_wupin_kuaijie_list: Tstringlist; //������Ʒ��ݼ���¼
     jit_tmp_3: integer;
     Jit_kssj: tdatetime; //��ʼʱ��
     jit_del: boolean; //�Ƿ���ɾ��������
     jit_word_p: integer; //ָ�򵥴ʱ�ǰ���ʵ�ָ��
     //jit_game_start: boolean; //��Ϸ�Ƿ�ʼ
     
       game_E_color_R,game_E_color_G,game_E_color_B: byte;
       game_C_color_R,game_C_color_G,game_C_color_B: byte;
       game_BE_color_R,game_BE_color_G,game_BE_color_B: byte;
       game_BC_color_R,game_BC_color_G,game_BC_color_B: byte;

       game_WA_color_R,game_WA_color_G,game_WA_color_B: byte;
       game_WB_color_R,game_WB_color_G,game_WB_color_B: byte;

       Jit_words: string; //��ǰ��ʾ�ĵ���
       game_word_1,game_word_2,game_word_3: string; //����

       game_pic_check_area: integer; //gl������Щ�������ѡ��
       Fgame_guai_cu,Fgame_my_cu: integer; //��ǰ�ֱ�� ,��ǰս��������
       F_Attack_type: integer;
       F_is_Attack: boolean; //�Ƿ񹥻�״̬
       F_time_role_id: integer; //������ӵ���ʱ���ڵģ�������������
       game_can_close: boolean; //�Ƿ�����رմ���
       // guai_lifeblood1: array[0..4] of integer;  //����Ѫֵ
      // guai_list1: array[0..4] of string; //�����б�
       game_p_list: array[0..9] of integer; //�ٶ�ֵ�б�
       blood_show_list: array[0..4] of integer;
       game_musmv_ready: boolean;
       game_guai_escape: boolean; //�������һֻ�Ƿ����ܵ�
        game_dangqian_word_id: integer; //��ǰ���ʱ�ţ����ڷ��ִ���ʱ��������ظ��б���
      // game_tts_index: integer; //��ǰʹ�õ�tts����
       game_beijing_index_i,game_beijing_index_cur: integer; //�������
       g_guai_show1,g_guai_show2,g_guai_show3,g_guai_show4,g_guai_show5: boolean;
       g_role_show1,g_role_show2,g_role_show3,g_role_show4,g_role_show5: boolean;
       g_guai_jialiang1,g_guai_jialiang2,g_guai_jialiang3,g_guai_jialiang4,g_guai_jialiang5: boolean; //�ֿɼ���
       g_role_jialiang1,g_role_jialiang2,g_role_jialiang3,g_role_jialiang4,g_role_jialiang5: boolean; //�ҷ��ɼ���
       g_show_result_b: boolean; //��ʾ����ʱͼƬ
       g_dangqian_zhuangtai: T_game_Status; //��ǰ��ʾ״̬
       g_show_text_up,g_show_text_down: boolean;
       g_danci_weizhi,g_jieshi_weizhi1,g_jieshi_weizhi2,g_jieshi_weizhi3: T_word_weizi;
       G_mus_at: T_Mouse_at; //��ǰ������ڵ�λ��
       g_danci_donghua_id,G_danci_donghua_count: integer; //������źͶ�����ʱ
       game_word_qianzhui,game_word_houzhui: Tstringlist;
       image_word,image_cn1,image_cn2,image_cn3,image_up,image_down :TAsphyreImage;
       image_guai1,image_guai2,image_guai3,image_guai4,image_guai5: TAsphyreImage;
       image_role1,image_role2,image_role3,image_role4,image_role5: TAsphyreImage;
       image_result1: TAsphyreImage; //��������ͼƬ
       g_icon_image: TAsphyreImage;
       image_bg_1_1,image_bg_1_2: TAsphyreImage; //����ͼƬ
       image_bubble,imgae_arrow: TAsphyreImage;

       //���巨��������������Ʒ���������巨���ָ���������Ʒ�ָ�
       g_DanTiFaShuGongJi,G_dantiWuPinGongji,G_DanTiFaShuHuiFu,G_DanTiWuPinHuiFu: T_donghua_weizhi;
       G_QuanTiFaShuGongji,G_Quantifashuhuifu,G_Guai_Fashu: T_donghua_weizhi;
       G_PuTongGongji,G_Guai_PuTongGongji: T_donghua_weizhi;
       g_gong,g_gong_xiaoguo,g_icon: T_donghua_weizhi;
       g_particle_rec: Tparticle_rec;
       g_is_tingli_b,g_Dragging,g_tiankong: boolean; //�Ƿ�������״̬
       g_wo_guai_dangqian: integer; //���ٶ��б��ص�ֵ
       g_auto_attack: integer; //�Զ�������ʱ
       g_is_word_right: boolean; //�������������ȷ
       g_timer_count_5: integer; //5�붨ʱ
       g_time_5,g_time_30,g_time_240: integer; //������˹����ָ��
       g_day_1,g_day_2,g_day_4,g_day_7,g_day_15: integer; //������˹����ָ��
       g_string_abhs: string;
       g_on_abhs: boolean; //��ǰ�ĵ�����abhs���ṩ����ֹ�ظ�����
       g_abhs_index,g_abhs_count: integer;
       time_list1: ttime_list;
       game_guai_xishu_f: integer; //���﹥��ϵ��������ش���ȷ���
       game_guai_fanghu_xishu_f: integer; //�ַ���ϵ��
       game_state_answer: boolean; //Ϊfalse��ʾ��ʼ��ʾ��Ϊtrue��ʾ����ʾ
       game_edit1_bmp: Tbitmap;
          // WebBrowser1: TWebBrowser;
      procedure word_lib_save;
      function get_filename_ck(isNew: boolean): string; //���شʿ��ļ���
      procedure show_check(i: integer);  //��ʾ�ر�ʱ��ѡ����״̬
      procedure save_check;
      procedure My_FindFiles(sPath: string);

      function check_asw(i: integer;h_b: boolean): string;
      procedure save_game_progress(filename: string);
      procedure draw_asw(s: string; flag: integer; c: integer=0); //������ѡ�𰸣�flag 1��3��3��
      procedure game_intl_pic; //��ʼ����ͼ
      procedure draw_random_pic; //��ʾ�ӳ���ʾǰ�����ͼ
      procedure after_check_asw(b: boolean);
      procedure after_check_asw1(b: boolean);  //1�������ʺ�������
      procedure after_check_asw2(b: boolean);  //   �ڿ��������
      procedure after_check_asw3(b: boolean);   //  ս����������
      procedure show_text(up: boolean; const s: string); //��ʾ���֣�up��ʾ���ϲ���ʾ
      procedure show_text_hint(const s: string); //��ʾ����hint
      procedure draw_game_role(p: integer); //������Ϸ���-1������ȫ��������İ�rolelist�ڵ���Ż�
      procedure draw_game_role_base(p: integer);
      procedure draw_game_role_base2(p: integer; tpl: Tplayer);
      procedure create_guai_list; //���������б�
      procedure draw_game_guai(p: integer); //�������-1 ����ȫ��������İ�guailist�ڵı�Ż�
      procedure draw_game_guai_base(p: integer);
      procedure game_star_fight_message(var msg: TMessage); message game_const_star_war;
      procedure guai_Attack(t,z: integer); //���﹥��������Ϊ�����ţ�����Ϊ����ָ��
      function game_p_list_ex: integer; //�ٶȣ���������ֵ����������
      function game_get_role_su(i: integer): integer; //�����ϳ���������ȡ�����ٶ�
      function game_get_role_from_i(i: integer): Tplayer; //�����ϳ�����ı�����������ʵ��
      function game_get_role_from_sid(i: integer): Tplayer; //����sid�ı�����������ʵ��
      function game_get_guai_su(i: integer): integer; //�����ϳ���������ȡ�����ٶ�
      procedure My_Attack(m,p,d: integer); //�ҷ�����������Ϊ������,����id�͹�����ʽ��0Ϊ��ͨ����
      procedure My_comeback(m,p,d: integer); //�ָ���
      procedure highlight_guai(id: integer); //����ָ�����-1,����ȫ��
      procedure highlight_guai_base(id: integer); //����ָ������
      procedure un_highlight_guai(id: integer); //�ָ�����ָ�����-1,�ظ�����ȫ��
      procedure un_highlight_guai_base(id: integer); //�ָ�����ָ������
      procedure highlight_my(id: integer); //����ָ�����-1,����ȫ��
      procedure highlight_my_base(id: integer); //����ָ������
      procedure un_highlight_my(id: integer); //�ָ�����ָ�����-1,�ظ�����ȫ��
      procedure un_highlight_my_base(id: integer); //�ָ�����ָ������
      function  get_pid_from_showId(i: integer): integer; //ͨ���ϳ�id���������rolelist�ı��
      function  get_r_role_id: integer; //���һ������ϳ������id
      function  get_r_role_all_count: integer; //ȡ���ҷ�ȫ���ϳ���������������������ɫ
      function  get_r_role_all_count_NoDead: integer; //ȡ���ҷ�ȫ���ϳ������������������Ѿ�������
      procedure game_Animation(up: boolean; p1,p2,p3:integer); //��������up��ʾ�ҷ���ֹ���
      procedure game_blood_add_one; //ս��������������ɫѪ��ָ�Ϊһ
      function game_fight_result: integer;  //�ж�ս�����,result:= 1 //�ҷ�����
      procedure game_fight_result_adv;
      procedure game_guai_Attack_blood; //���ֹ�����۳��ҷ�Ѫ��
      procedure game_my_Attack_blood; //�ҷ�������۳���Ѫ��
      function game_get_Attack_value(z1,z2: integer): Tmtl_rec; //���ݹ���ָ���͹������ͷ��ع�����
      function game_get_my_Attack_value(z1: integer): Tmtl_rec; //ȡ���ҷ������� ����Ϊ��������
      procedure game_fight_keep; //��һ��ս��������ս��
      procedure game_word_amt; //���ʶ���
      procedure go_amt_00(t: integer);
      procedure go_amt_01(t: integer);
      procedure go_amt_02(t: integer);
      procedure go_amt_03(t: integer);
      procedure go_amt_04(t: integer);
       procedure go_amt_05(t: integer);
       procedure go_amt_06(t: integer);
      procedure game_victory; //ս��ʤ�����Ӿ��飬����������
      procedure game_up_role; //�ж�����
      function get_guai_count: integer; //��ȡ�������
      function get_guai_only: integer; //��ȡ��ʣ�Ĺֱ��
      function can_escape: boolean; //�Ƿ���������
      procedure listbox1_click1;   //�����ȷʵ��������
      procedure procedure_2(const s: string);  //ʳƷҩƷ�ദ��
      procedure procedure_4(const s: string);  //Ͷ�������ദ��
      procedure procedure_128(const s: string); //�����ദ��
      procedure procedure_256(const s: string); //��ǿ�����ദ��
      procedure draw_text_17(const s: string; flag: integer; c: Tcolor; f_size: integer=32); //������Ч����
                           //����������
       procedure draw_text_17_m(st1: Tstringlist; flag: integer; c: Tcolor);
      procedure game_Animation_base1(up: boolean);  //���ֵĶ��������ڹ����ȹ���
      procedure game_Animation_base2(up: boolean);
      procedure game_Animation_base3(up: boolean);
      procedure game_Animation_base4(up: boolean);
      procedure game_Animation_base5(up: boolean);
                              {��ʾѪֵ����ʾλ�ã����£���ֵ�������ţ����ͣ�Ѫ������������}
      procedure game_show_blood(up: boolean; value: integer; id: integer; type1: integer);
                               //���һ����Ʒ����ʱ�����б�,������Ʒid��������
      procedure game_add_to_goods_time_list(id: integer);
      function game_get_xtl_values(p,v,t: integer): integer; //����vֵ�����������ҷ�����ȫֵ����ֵ��ԭֵ
                     //����vֵ���������ع���ȫֵ����ֵ��ԭֵ
      function game_get_xtl_values_guai(p,v,t: integer): integer;
      function game_return_filter(p: integer;type1: integer): Tmtl_rec; //�������ٹ�����ʱ��������ֵ

      function is_can_jingyan(p: integer): boolean; //�Ƿ�ɽ��ܾ���ֵ���������ϳ�������

      procedure game_hide_role(n: string); //�����˱�����ʱ����ʱ���������ˣ�����Ϊ��Ҫ��ʾ����
      procedure game_unhide_role; //ȡ����ʱ����

                 //�����ĵȼ����ˣ�����ֵΪ�ȼ����޵ȼ��ķ���10�������������ڴ˹�����
      function game_fashu__filter(var i: integer): integer;
      procedure game_wordow_Animate(form: Tform); //������ʾ����
      function lingli_is_ok(const s: string): boolean; //�ȶԵ�ǰ����������Ƿ񹻷��ӷ���
      procedure tili_add_100; //�������Ӱٷ�֮һ
      procedure add_to_errorword_list(id: integer); //���һ�����󵥴ʵ��б�
      procedure clear_errorword_list; //�������

      function get_Random_EXX: integer;
      function get_abhs_value: integer;
      procedure get_word_fen(out f: T_word_QianHouZhui;const s: string); //ȡ�õ��ʷ�ɫ
      procedure g_game_delay(i: integer); //�ӳ�
      procedure g_guai_A_next; //���ﶯ������ĺ�������
      procedure g_wo_A_next; //�ҷ���������ĺ�������
      procedure G_huifu_next; //�ָ�����������
      function g_get_roleAndGuai_left(i: integer): integer; //ȡ�ùֻ���������������
      procedure g_miao_shou(g_id,s_id: integer); //͵����
      procedure kuaijie_12345(id: integer); //��ݼ�1-5
      function need_wait: boolean;  //�������߷����Ƿ������
      procedure clean_lable2_11; //�������
      procedure write_label2_11; //ˢ������
      procedure show_fashuwupin_k(const s: string); //��ʾ������Ʒ������ݵ���ť
      procedure show_hint_button; //��ʾ��ť�Ŀ�ݼ�
      procedure play_sound(i: integer); //������Ч
      function create_net_guai(id: integer): boolean; //������������Ĺ��б�
      function sid_to_roleId(sid: integer): integer; // ��sidת��Ϊrole����guai����Ļid
      function roleId_to_sid(roleid: integer): integer; // ��role����guai����Ļidת��Ϊsid
      procedure gong_js(f,j,w: integer;guai: boolean); //�����ҷ������˺�ֵ�����һ�������������Ƿ�����
      procedure huifu_js(f,j,w: integer); //����ָ�ֵ
      procedure huifu_donghua; //�ָ�����
      procedure HandleCTLColorEdit(var Msg: TWMCTLCOLOREDIT);message WM_CTLCOLOREDIT;
      procedure wuziqi_msg(var Msg: TMessage);message wuziqi_msg_c;  //����������������Ϣ
      procedure wuziqi_sendstr(s: string); //��������������
      procedure create_edit_bmp(s: string); //��edit ������ͼ
      function get_comp_word: boolean;
      procedure set_Action_az; //���ÿ�ݼ�
      procedure show_bubble_on_scr; //��ʾ����������Ļ
      procedure show_wuziqi_on_src; //��ʾ�����嵽��Ļ
      procedure show_a_word_on_wzq; //��������ʱ��ʾһ������
      procedure create_top_ad; //����һ����ҳ���С����
  public
    { Public declarations }
    game_pop_count: integer; //������ʾ�Ĵ���
    game_pop_type: integer;  //1�������ʣ�2���ڿ�3��ս����4������̨��5�����˱�����
    game_is_a: boolean; //�Ƿ񶯻���ʾ����
    game_monster_type: integer; //�������ͣ���ֵ��Ϊ��ʱ��pop_countΪ���������
    game_en_size,game_cn_size: integer;
    game_speed_a: boolean; //���������ٶ�
    game_is_sooth: boolean; //����ʹ�����˷���
    game_opengl_d: boolean; //opengl��ǰ��֧��Ӳ�����٣����ö���
    game_rep: integer;//���ʴ����ظ������ʷ�ɫ
    game_m_color: integer;//���ʴ����ظ������ʷ�ɫ
    game_tingli_i: integer; //������ϰ
    game_not_bg_black: boolean; //��ɫ�����Ƿ���
    game_bmp_width: integer;   // ���ʺͽ��͵Ŀ��
    g_word_show_left: integer; //���ʺͽ�����ʾ�����λ��
    game_love_word_role: string; //�����˱�����ʱ��Ҫ��ʾ����һ����
    stringlist_abhs5,stringlist_abhs30,stringlist_abhs240: Tstringlist; //������˹��¼
    stringlist_abhs_d1,stringlist_abhs_d2,stringlist_abhs_d4,stringlist_abhs_d7,stringlist_abhs_d15: Tstringlist;
      game_kaoshi: integer; //���Դ����ĵ���ʱ
      wordlist1: Tstringlist;
      SpVoice1: TSpVoice;
     function get_word_safe(i: integer): string;  //��������Ļ�ȡ���ʣ�һ���ô˺�������
     procedure show_ck;    //����ʿ�
     procedure show_ad(add_i: integer); //ˢ�¹����ʾ
     procedure skp_string(const s: string);
     procedure skp_string_tongbu(const s: string);
     procedure draw_random_pic_base(b: Tbitmap;one: boolean=false); //�������ľ
     procedure draw_random_grass(b: Tbitmap); //�������
     procedure draw_random_XX(bt: Tbitmap;flag: integer); //���������ֲ��
     procedure leiji_show; //��ʾ�ۼ���ȷ���ߴ������Ϣ
     procedure del_word_in_lib; //ɾ��һ������
     procedure add_lib;  //����ʿ�
     procedure out_Lib; //�����ʿ�
     function start_show_word(h_b: boolean): string; //��ʾ�������
     function game_upgrade(p: integer): integer; //��Ϸ��������������ֵΪ�µļ�����Ϊ���ʾû����
     procedure game_kptts_init; //��ʼ����ɽ���˷�����Ԫ
     function game_can_spvoice1: boolean; //���ttsģ���Ƿ����
     function game_get_opengl_info: string;
     procedure del_a_word;
     procedure gong; //����
     procedure laod_fashu_wupin_k(const s: string); //���뷨����Ʒ��ݼ�
     procedure save_fashu_wupin_k(const s: string); //���淨����Ʒ��ݼ�
     procedure init_weizi;  //��ʼ������λ��
     procedure init_tiame_day_abhs; //��ʼ��������˹ָ��
     procedure save_abhs; //����abhs��
     procedure del_abhs; //ɾ��abhs��
     function get_error_words: string; //���ص�ǰ�д���ĵ���
     procedure load_abhs;
     procedure save_set(const s: string); //���沿������
     procedure load_game_progress(const filename: string);
     procedure CreateParams(var Para:TCreateParams);override;
     function get_pop_string(c: integer): string; //�����ַ������͵ĵ�������
     function html_asw_string(c: integer): string; //���ش𰸻ش���html
     procedure net_cmd_center(c,d1,d2: integer; sid: word); //����ʱ������Ȩ������������
     procedure net_cmd_send_center; //����ʱ�����������
     function get_Word_id:integer; //��ȡһ�����ʺ� �д��󵥴�ʱ������ȡ��

                     {����ʱ����ָ�����}
     procedure      net_rec_game_cmd(fq_sid: word;   //����sid
                                  js_sid: word;    //���ܷ����ܹ�������sid
                                  fq_m: integer;
                                  fq_t: integer;   //�����飬���𷽴��͵�����ֵ
                                  fq_l: integer;
                                  js_m: integer;   //���ܷ����͵��ǲ�ֵ
                                  js_t: integer;
                                  js_l: integer;
                                  flag: word;    //���ͣ�ָ����0�޶�����1����������2����������3��Ʒ������4��Ʒ�ָ���5�����ָ���6,��7��
                                  wu: word);
  end;

 {$IFDEF IBM_SPK}
 type
  Tjit_spk = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    spk: string;
    constructor create(COM_232:string);
  end;

  function eciSpeakText(text: pchar; annot: boolean): integer; stdcall; external 'ibmeci.dll';
  function eciNew: thandle; stdcall; external 'ibmeci.dll';
   function eciDelete(h: thandle): integer; stdcall; external 'ibmeci.dll';
  function eciSynthesize(h: thandle): integer; stdcall; external 'ibmeci.dll';
  function eciAddText(h: thandle ; s: pchar): integer; stdcall; external 'ibmeci.dll';
  function eciSynchronize(h: thandle): integer; stdcall; external 'ibmeci.dll';
  function eciCopyVoice(h: thandle; i: word; j: word): integer; stdcall; external 'ibmeci.dll';
  function eciSetVoiceParam(h: thandle; i: word; j: word; k: word): integer; stdcall; external 'ibmeci.dll';
  {$ENDIF}

  function get_caoshi_list_value(sid: word): boolean;     //ȡ���Ƿ�ʱ��Ĭ��2�μ����й�
  procedure set_caoshi_list_value(sid: word); //���ӳ�ʱ����һ�����sidΪ��Чֵ�����ʼ��
var
  Form_pop: TForm_pop;
  GameSave1:TGameSave;
  f_type_g: integer; //ѡ������ͣ����������٣����
  speed_limt_G: integer; //�ٶ�����
//  kp_tts: TKDVoice;
  game_init_Success_G: boolean;
  game_tianqi_G: integer; //�Ƿ�ָ������Ч��
  game_error_word_list_G: array[0..63] of word; //���󵥴�����

  text_show_array_G: array[0..5] of T_zhi_piaodong; //Ʈ��ֵ 5���ڵ���ʱ��ʾ
  g_hint_array_g: array[0..14] of string;  //��ʾ��Ϣ��0-4�ҷ���ʾ��5-9����ʾ 10-15������������ʾ
  mouse_down_xy: Tpoint;
  caoshi_list1: array[0..9] of T_caoshi_list; //��ʱ�б�
  mtl_game_cmd_dh1: Tgame_cmd_dh; //�����鹦�Ų���
  bubble_boll_g_array: array[0..g_boll_14_cn,0..g_boll_21_cn] of dword; //�����������飬0��ʾ����������ʾĳ����ɫ����
       {bubble_boll_g_array,0..3byte��3��ʾ��ɫ��������1��ʾ��2��ʾ�ߣ�0��ʾ�Ƿ���ͬɫͳ����}
  bubble_data1: Tbubble_data;
  wuziqi_tread: Twuziqi;
  wuziqi_rec1: twuziqi_rec; //������״̬��¼
  {$IFDEF IBM_SPK}
  jit_spk1: Tjit_spk;
  jit_h: thandle;
  {$ENDIF}
implementation
   uses { VectorGeometry, } unit1, Unit_goods, AAFont, inifiles,FastStrings,
        Registry,unit_net,unit_chinese,unit_mp3_yodao,unit_show,unit_msg;
{$R *.dfm}
function get_caoshi_list_value(sid: word): boolean;     //ȡ���Ƿ�ʱ��Ĭ��2�μ����й�
var i: integer;
begin
result:= false;

  for i:= 0 to 9 do
   if (caoshi_list1[i].sid= sid) and (caoshi_list1[i].caoshi >= 2) then
      result:= true; //��ʱ���εģ��ͷ���true
end;

procedure set_caoshi_list_value(sid: word); //���ӳ�ʱ����һ�����sidΪ��Чֵ�����ʼ��
var i: integer;
begin
     if sid= g_nil_user_c then
      begin
        for i:= 0 to 9 do
           begin
            caoshi_list1[i].sid:= g_nil_user_c;
            caoshi_list1[i].caoshi:= 0;
           end;
      end else begin
                for i:= 0 to 9 do
                  if caoshi_list1[i].sid= sid then
                      begin
                        caoshi_list1[i].caoshi:= caoshi_list1[i].caoshi + 1;
                        exit;
                      end else if caoshi_list1[i].sid= g_nil_user_c then
                                  begin
                                   caoshi_list1[i].sid:= sid;
                                   caoshi_list1[i].caoshi:= 1;
                                  end;
               end;

end;

{ jit_spk }
 {$IFDEF IBM_SPK}
constructor Tjit_spk.create(COM_232: string);
begin
  inherited create(false);
  freeonterminate:=false;
end;

procedure Tjit_spk.Execute;
var m: TMsg;
begin
 jit_h:= eciNew; //��������ʵ��
 eciSetVoiceParam(jit_h, 0, 7, 99); //��������
 while not Terminated do
  begin
    while getMessage(M,0,0,0) do
    begin
      if m.message=um_ontimer  then
      begin
       eciAddText(jit_h, pchar(spk));
       eciSynthesize(jit_h);
       eciSynchronize(jit_h);
       // eciSpeakText(pchar(spk),false);//����
      end;
      if m.message=um_quitthread then
        break;
    end;
  end;

 eciDelete(jit_h); //ɾ������ʵ��
end;
{$ENDIF}

function boll_can_stk(y,x,by: integer): boolean;   //����Ϊ row��col ����ǰ�����ں�
begin
    {bubble_boll_g_array,0..3byte��3��ʾ��ɫ��������1��ʾ��2��ʾ�ߣ�0��ʾ�Ƿ���ͬɫͳ����}
result:= false;
if (y> g_boll_14_cn) or (x >g_boll_21_cn) or
   (y<0) or (x <0)then
  exit;

   if LongRec(bubble_boll_g_array[y,x]).Bytes[3] > 0 then
     result:= false
     else if y=0 then
           result:= true
           else if x=0 then
                 begin
                   if y mod 2= 0 then
                    begin //ż���� ���ж�һ��
                     if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]> 0) or
                        (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]> 0)  then
                        result:= true;

                    end else begin  //������
                               if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0)or
                                  (LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3] > 0) or
                                  (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3] > 0)  then
                               result:= true;
                             end;
                 end else if g_boll_21_cn- y mod 2 = x then //�����ұ�Ե����������һ����
                           begin
                            if y mod 2= 0 then
                            begin //ż���� ���ж�һ��
                                 if (LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3] > 0) or
                                    (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0)  then
                                    result:= true;

                            end else begin  //������
                                           if x= g_boll_21_cn then
                                            result:= false
                                            else
                                           if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0)or
                                              (LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3] > 0) or
                                              (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0)  then
                                           result:= true;
                                     end;
                           end else begin
                                     //�м�λ��
                                     if y mod 2= 0 then
                                     begin //ż���� ���ж�һ��
                                          if (LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3] > 0) or
                                             (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0) or
                                             (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0) or
                                             (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3] > 0) then
                                             result:= true;

                                     end else begin  //������
                                                   if x= g_boll_21_cn then
                                                   result:= false
                                                   else
                                                    if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0)or
                                                       (LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3] > 0) or
                                                       (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0) or
                                                       (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3] > 0) then
                                                    result:= true;
                                              end;

                                    end;
end;

procedure Random_boll(r: integer);
var i,j: integer;
begin
  //���������
    {bubble_boll_g_array,0..3byte��3��ʾ��ɫ��������1��ʾ��2��ʾ�ߣ�0��ʾ�Ƿ���ͬɫͳ����}
  for i:= 0 to g_boll_14_cn -1 do //�������12�У�������
   begin
     for j:= 0 to g_boll_21_cn do
      begin
       if r= 0 then
          exit;
        
       if (Random(2)= 1) and boll_can_stk(i,j,0) then
          begin
           dec(r);
           LongRec(bubble_boll_g_array[i,j]).Bytes[3]:= Random(7)+1;
           LongRec(bubble_boll_g_array[i,j]).Bytes[1]:= 32; //��
           LongRec(bubble_boll_g_array[i,j]).Bytes[2]:= 32; //��
          end;
      end;
   end;


end;

procedure TForm_pop.FormShow(Sender: TObject);
var i: integer;
    p2: p_user_id_time;
begin
  button14.Visible:= DebugHook=1;
 //��������ģ����ñ�С���ڵ���������������
 AsphyreTimer1.Enabled:= true;
    set_caoshi_list_value(g_nil_user_c);
  if game_at_net_g then
   begin
     set_caoshi_list_value(g_nil_user_c); //��ʼ����ʱ
     for i:= 1 to Game_role_list.Count- 1 do
       begin
         if Assigned(Game_role_list.Items[i]) then
          begin
            p2:= get_user_id_time_type(Tplayer(game_role_list.Items[i]).plvalues[34]);
            if p2<> nil then
             begin
              if p2.xiaodui_dg= 0 then
                 Tplayer(game_role_list.Items[i]).plvalues[ord(g_hide)]:= 0
                 else
                   Tplayer(game_role_list.Items[i]).plvalues[ord(g_hide)]:= 1; //��������ж��ģ����أ�������ʾ
             end;
          end;
       end;
   end;
      
   if game_speed_a then
          Timer_donghua.Interval:= game_amt_delay div 2
          else
            Timer_donghua.Interval:= game_amt_delay; //�����ٶ�

 Game_wakuan_zhengque_shu:= 0; //�ڿ���ȷ������

 game_musmv_ready:= false;
 clean_lable2_11; //����Ŷ���ʾ

    g_guai_show1:= false; //���ﲻ��ʾ
    g_guai_show2:= false;
    g_guai_show3:= false;
    g_guai_show4:= false;
    g_guai_show5:= false;

 Game_not_save:= true;


     //�������ͳ�ʼ������
  show_text(false,'');
  show_text(true,'');
  g_show_result_b:= false;
   groupbox3.Visible:= false;
   g_gong.xianshi:= false;
    un_highlight_my(-1);
    un_highlight_guai(-1);


    for i:= 0 to 9 do
        game_p_list[i]:= 0;

     //����ѩ����Ч��
     if game_tianqi_G > -1 then
      begin
     if (Random(9)= 0) or (game_tianqi_G > 0) then
      begin
      g_particle_rec.xian:= true;
        if game_tianqi_G > 0 then
           i:= game_tianqi_G
           else
            i:= Random(5);
      case i of
      0,1: begin
        g_particle_rec.xuli:= 0; //��ѩ��Ʈ��
        g_particle_rec.xiaoguo:= 0; //���Ư��
       end;
       2: begin
         g_particle_rec.xuli:= 1; //����
        g_particle_rec.xiaoguo:= 1; //�̶�����Ư��
       end;
       3: begin
        g_particle_rec.xuli:= 2; //���棬���Ʈ��
        g_particle_rec.xiaoguo:= 0;
       end;
       4: begin
        g_particle_rec.xuli:= 3; //Сѩ��Ʈ��
        g_particle_rec.xiaoguo:= 0; //���Ư��
       end;
       end; //end case
      end else g_particle_rec.xian:= false;
      end; //end if game_tianqi_G

   //pk_zhihui_g.game_zt: integer;   //0����״̬��1�������ʣ�2�ڿ�3��ҩ��4��������5������6ս��
    jit_num:= 1;

     if game_pop_type<> 7 then
       wuziqi_rec1.word_showing:= false;
       
  case game_pop_type of
   1: begin//�����ʣ�
        //���ع���
          pk_zhihui_g.game_zt:= 1; //��ǰ״̬

          game_beijing_index_i:= Random(2)+ 1; //����ͼ���
         game_kaoshi:= game_pop_count * 3+5;
        caption:= '������'+ inttostr(game_pop_count) + '��';
        game_can_close:= true;
        dec(game_pop_count);
       // start_show_word;
        postmessage(handle,game_const_star_war,6,8);
        //��ʾʣ�൥����
      end;
   2: begin//�ڿ�
        pk_zhihui_g.game_zt:= 2;

        game_beijing_index_i:= Random(2)+ 3; //����ͼ
       game_can_close:= true;
       if game_pop_count= 200 then
       begin
       caption:= '��ҩ������ʱ����';
       pk_zhihui_g.game_zt:= 3;
       end else  if game_pop_count= 300 then
        begin
         caption:= '����������ʱ����';
         pk_zhihui_g.game_zt:= 4;
        end else if game_pop_count> 1000 then
        begin
         caption:= '���� '+ inttostr(game_pop_count- 1000) + '��';
         game_kaoshi:= (game_pop_count- 1000) * 3+5;
        end else
             caption:= '�ڿ󣬿���ʱ����';
       //dec(game_pop_count);
      // start_show_word;
       postmessage(handle,game_const_star_war,6,8);
      end;
   3,4: begin//ս��������
         
         game_beijing_index_i:= Random(3)+ 5; //����ͼ
        game_can_close:= false;
        if game_pop_type= 3 then
          begin
            caption:= 'ս��';
            pk_zhihui_g.game_zt:= 6;
          end   else  begin
                        caption:= 'ս��'; //����
                        pk_zhihui_g.game_zt:= 5;
                      end;
        groupbox3.Visible:= false;
        g_gong.xianshi:= false;
       create_guai_list; //���������б�
       draw_game_guai(-1); //����ȫ������
       //����ս��
       Fgame_guai_cu:= 0; //Ĭ�ϵ�һ���ֲ�ս
       Fgame_my_cu:= get_r_role_id; //ȡ��һ���ϳ���������id

          //��ʼ�ٶȼ�ȥ
       dec(game_p_list[0],game_get_role_su(0));
       dec(game_p_list[5],game_get_guai_su(0));
         speed_limt_G:= game_get_role_su(0) * 20; //�ٶ�ͳ�Ƶ����ޣ�Ϊ20����
         {�ٶ�ͳ�Ƶı���Խ�ߣ�ͳ�����ԽС����Ҫ��Ӧ����ÿ���ͳ�ƴ�����20��ʱ���ԼΪ5%}
         Timer4.Enabled:= true; //�ٶ�ͳ�ƶ�ʱ����ʼ
       postmessage(handle,game_const_star_war,6,6);
      end;
   5: begin//�����˱����ʣ�����������
         game_beijing_index_i:= Random(2)+ 1; //����ͼ
        caption:= '���˱�����'+ inttostr(game_pop_count) + '��';
        game_can_close:= true;
        game_hide_role(game_love_word_role);
        dec(game_pop_count);
       // start_show_word;
        postmessage(handle,game_const_star_war,6,8);
        //��ʾʣ�൥����
      end;
   6: begin //������
        game_beijing_index_i:= 2; //����ͼ
        caption:= '������ - '+ inttostr(game_pop_count);
        game_can_close:= true;
        game_hide_role('��');
        //�������������
        fillchar(bubble_boll_g_array,sizeof(bubble_boll_g_array),0);
        //��ʼ������
         Random_boll(game_pop_count);
        //״̬����Ϊ����������
        pk_zhihui_g.game_zt:= 1; //������״̬
        show_text(false,'���Ҽ�ͷ�ƶ������ϼ�ͷ����');

        //����������ͼƬ
        if not assigned(image_bubble) then
          begin
           image_bubble:= tasphyreimage.Create;
           with image_bubble do
           begin
           Size:= point(128,64);
           VisibleSize:= point(128,64); //���ô�С
           PatternSize:= point(128,64);
           end;
            image_bubble.LoadFromFile(game_app_path_G+ 'img\bubble2.bmp',true,0,0);
           imgae_arrow:= tasphyreimage.Create;
           with imgae_arrow do
           begin
           Size:= point(64,64);
           VisibleSize:= point(64,64); //���ô�С
           PatternSize:= point(64,64);
           end;
            imgae_arrow.LoadFromFile(game_app_path_G+ 'img\zhizhen.bmp',true,0,0);

           AsphyreImages1.AddFromFile(game_app_path_G+ 'img\bubble.png',point(32,32),point(32,32),point(64,128),aqMedium,alMask,true,$FF000000,0);
          end;
        bubble_data1.next_color:= Random(7); //��ʼ��������������ɫ
        bubble_data1.arrow_Angle:= 0; //��ʼ����ͷλ��
        bubble_data1.boll_show:= false; //�ƶ���������
        postmessage(handle,game_const_star_war,6,8); //���һ������Ϊ8ʱ���������������ʣ��������޸ĵ�ǰ��Ϸ״̬
      end;
      7: begin
           //������
           // game_pop_count:= 0;  //��˵�׳ռ��������������������嶼�������
            if game_pop_count>0 then
               dec(game_pop_count);

          case game_pop_count of
          0: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'pela.exe',handle);  //�׳ռ���˼�����1��
              caption:= '������ - �׳ռ�';
              sleep(500);
              wuziqi_sendstr('info timeout_turn 1000');
             end;
          1: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'pela.exe',handle);  //������˼�����4��
              caption:= '������ - ���ż�';
              sleep(500);
              wuziqi_sendstr('info timeout_turn 4000');
             end;
          2: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'pela.exe',handle); //�м���˼�����8��
               caption:= '������ - ������';
               sleep(500);
               wuziqi_sendstr('info timeout_turn 8000');
             end;
          3: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'Tito.exe',handle); //�߼���˼�����5��
               caption:= '������ - �м�';
               sleep(500);
              wuziqi_sendstr('info timeout_turn 5000');
              end;
          else
            //���
            wuziqi_tread:= twuziqi.Create(game_app_path_G+'Tito.exe',handle);//˼�����18��
             caption:= '������ - �߼�';
             sleep(500);
              wuziqi_sendstr('info timeout_turn 18000');
          end;
          fillchar(wuziqi_rec1,sizeof(Twuziqi_rec),0);
          game_beijing_index_i:= 8; //����ͼ
          game_can_close:= true;
         //�������������
          fillchar(bubble_boll_g_array,sizeof(bubble_boll_g_array),0);
        //��ʼ��������

        //״̬����Ϊ����������
        pk_zhihui_g.game_zt:= 1; //������״̬
        //����ͼƬ
        if AsphyreImages1.Image['bubble.png']=nil then
          begin
           AsphyreImages1.AddFromFile(game_app_path_G+ 'img\bubble.png',point(32,32),point(32,32),point(64,128),aqMedium,alMask,true,$FF000000,0);
          end;
         g_dangqian_zhuangtai:= g_wuziqi1; //����״̬Ϊ������
         if not Assigned(form_chinese) then
            form_chinese:= TForm_chinese.Create(application);  //���������ʶ�����
         end; //end 7
   end; //end case


try
   draw_game_role(-1); //��ʾ����
except
 raise Exception.Create('����λ�ã�5.1');
end;


  if game_is_a then
     game_wordow_Animate(self);


  game_is_a:= false; //��ʾ��ɺ�����Ϊ����ʾ
    game_musmv_ready:= true;
     AsphyreTimer1.Enabled:= game_init_Success_G;

    if game_beijing_index_cur <> game_beijing_index_i then
     begin
     image_bg_1_1.LoadFromFile(game_app_path_G+ 'img\bg'+ inttostr(game_beijing_index_i)+'-1.jpg',false,0,0);
     image_bg_1_2.LoadFromFile(game_app_path_G+ 'img\bg'+ inttostr(game_beijing_index_i)+'-2.jpg',false,0,0);

      game_beijing_index_cur:= game_beijing_index_i;
     end;

  show_hint_button; //��ʾ��ť��ʾ;

  Timer_donghua.Enabled:= true;
end;

function kongge2(const s: string): integer;
var i: integer;
begin
 if length(s)<= 2 then
 result:= 2
 else
   result:= 0;

   for i:= 1 to length(s) do
       if s[i]= ' ' then
         inc(result);

   if result= 0 then
     if ByteType(s,1)= mbLeadByte then
        result:= 2; //��������ģ�Ҳ���ʶ�
end;

procedure TForm_pop.skp_string(const s: string);
var b: boolean;
begin
 {$IFDEF IBM_SPK}
  if not Assigned(jit_spk1) then
    begin
    jit_spk1:= Tjit_spk.create('hello');
    sleep(500);
    end;

  jit_spk1.spk:= s;
  postthreadmessage(jit_spk1.ThreadID,um_ontimer,0,0);
  {$ENDIF}

 {$IFDEF MS_SPK}
  //�����ϳ� ,����bd_vsp=������֧�ְٶ�����
   if game_bg_music_rc_g.yodao_sound=false then
      b:= pos('bd_vsp=',s)>0;

   if game_bg_music_rc_g.yodao_sound or b then
    begin
      //1����udpȡ��id��2����idȡ��������3����������base.dll��4���ʶ�
      //���ðٶȵ�mp3�ļ�
      if not Assigned(mp3_yodao1) then
     begin
      if token='' then
       begin
        if not assigned(form_msg) then
         form_msg:= tform_msg.Create(application);

         form_msg.Timer1.Enabled:= true;
         form_msg.Show;
       end;

     mp3_yodao1:= Tmp3_yodao.Create(game_doc_path_G+'tmp\',form_chinese.Handle);

           if game_guid='' then
                game_guid:= form1.game_create_guid;


     mp3_yodao1.guid:= game_guid;
     end;

      mp3_yodao1.file_name:= trim(s); //���ص��ļ���
      mp3_yodao1.Resume;

      //�ո��滻Ϊ%20��Ȼ���滻��֧�����ڵ�wordλ�ã�Ȼ�󷢳�
      //���յ���Ϣ���ٴλ��mp3��Ȼ���ʶ�
    end else
    
   if game_is_sooth then
   begin
    showmessage('��ɽ�ʰ��ʶ��Ѳ�֧�֣������ðٶ����������ϳɡ�');
  {   if kp_tts= nil then exit;
    if kp_tts.IsExistSoundEx(s) then
     begin
      try
       kp_tts.PlaySound(s);
      except
       game_is_sooth:= false;
      end;
     end else begin
                try
               if SpVoice1= nil then
                  SpVoice1:= TSpVoice.Create(application);

                SpVoice1.Speak(s, SVSFlagsAsync);
                except
                  game_bg_music_rc_g.yodao_sound:= true;
                  showmessage('��ʼ��tts��������Ѿ������ٶ����������������Լ����ʶ���');

                end;
              end; }
   end else     
           begin
                try
                if SpVoice1= nil then
                  SpVoice1:= TSpVoice.Create(application);


                 SpVoice1.Speak(s, SVSFlagsAsync);
                except
                  game_bg_music_rc_g.yodao_sound:= true;
                  showmessage('��ʼ��tts��������Ѿ������ٶ����������������Լ����ʶ���');
                  skp_string(s); //�ٴεݹ����
                end;
             end;
 {$ENDIF}
end;

procedure TForm_pop.skp_string_tongbu(const s: string);
begin
   SpVoice1.Speak(s, SVSFDefault);
end;

procedure TForm_pop.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
edit1.Visible:= false;

 if not game_can_close then
  begin
   if not can_escape then
     begin
     if Game_cannot_runOff then
     show_text(false,'��ֹ���ܡ�')
     else
      show_text(false,'����ʧ�ܡ�');
      CanClose:= false;
      if g_gong.xianshi then
         button5click(sender)
         else
           check_asw(2,false);
     end;
  end else begin
              if Game_wakuan_zhengque_shu > 0 then
               begin
                if Game_wakuan_zhengque_shu > 100 then
                   Game_wakuan_zhengque_shu:= 100;

                form1.game_attribute_change(0,19,Game_wakuan_zhengque_shu * Game_wakuan_zhengque_shu
                                                 div 10); //ȫ�����Ӿ���ֵ1000
                 show_text(false,'���⽱������ֵ��'+ inttostr(Game_wakuan_zhengque_shu * Game_wakuan_zhengque_shu
                                                 div 10));
                 G_game_delay(1000);

                 game_up_role; //��������
               end;
              // AnimateWindow(Handle,400,AW_BLEND or AW_HIDE);
           end;

end;

procedure TForm_pop.word_lib_save;
var ss: string;
begin
  {����ʿ�}
  case messagebox(handle,'ѡ���ǡ��滻��ǰ�ʿ�Ϊ���ĺ�����ݣ�ѡ�񡰷񡱱�����º�Ĵʿ�Ϊһ���´ʿ�����','����ʿ�', mb_yesnocancel or MB_ICONWARNING) of
  mrno: begin
          ss:= get_filename_ck(true);
          wordlist1.SaveToFile(ss);
          jit_del:= false;
          messagebox(handle,pchar('�Ķ���Ĵʿ��Ѿ�����Ϊ���ļ���'+ ss +' ���������������������ڿ�ѡ��Ĵʿ��б��ڡ�'),'�ѱ���', mb_ok or MB_ICONINFORMATION);

         end;
  mryes:  begin
         ss:= get_filename_ck(false);
          wordlist1.SaveToFile(ss);
          jit_del:= false;
          messagebox(handle,pchar('��ǰ�ʿ��ļ���'+ ss +' �Ѿ����¡�'),'�ѱ���', mb_ok or MB_ICONINFORMATION);
         end;
  end;

end;

function TForm_pop.get_filename_ck(isNew: boolean): string;
var ss: string;
    i: integer;
begin
result:= '';

ss:= game_app_path_G+'Lib\'+ ComboBox1.Text;


 if isnew then
  begin
   {����һ�����ļ���}
     ss:= copy(ss,1,length(ss)-4);
     if pos('\Lib\',ss)= 0 then
      begin
        {�����Ĭ��voa�����������Ŀ¼}
        insert('\Lib',ss,pos('\words',ss));
      end;
     i:= 1;
      Repeat
       if not FileExists(ss + inttostr(i) + '.ini')then
        begin
         result:= ss + inttostr(i) + '.ini';
         break;
        end;
        inc(i);
      until i= 1024;
  end else begin
             {����ԭ�ļ���}
            result:= ss;
           end;

end;

procedure TForm_pop.del_word_in_lib;
var i : integer;
begin
 if messagebox(handle,'�Ƿ�Ӵʿ���ɾ����ǰ���ʣ�','ȷ��',mb_yesno or MB_ICONWARNING)= mryes then
  begin
   screen.Cursor:= crhourglass;
   wordlist1.Delete(jit_word_p);
      if part_size_g<> nil then
       begin
         for i:= 1 to high(part_size_g) do
          if part_size_g[i]= jit_word_p then
             begin
             part_size_g[i]:= 0;
             part_size_g[0]:= 0; //��ս���ָʾ
             end;
       end;
      for i:= stringlist_abhs5.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs5.Strings[i],fastcharpos(stringlist_abhs5.Strings[i],',',1)+1,5)) then
             stringlist_abhs5.Delete(i);
        for i:= stringlist_abhs_d15.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d15.Strings[i],fastcharpos(stringlist_abhs_d15.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d15.Delete(i);
        for i:= stringlist_abhs_d7.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d7.Strings[i],fastcharpos(stringlist_abhs_d7.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d7.Delete(i);
       for i:= stringlist_abhs_d4.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d4.Strings[i],fastcharpos(stringlist_abhs_d4.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d4.Delete(i);
      for i:= stringlist_abhs_d2.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d2.Strings[i],fastcharpos(stringlist_abhs_d2.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d2.Delete(i);
     for i:= stringlist_abhs_d1.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d1.Strings[i],fastcharpos(stringlist_abhs_d1.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d1.Delete(i);
    for i:= stringlist_abhs240.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs240.Strings[i],fastcharpos(stringlist_abhs240.Strings[i],',',1)+1,5)) then
             stringlist_abhs240.Delete(i);
      for i:= stringlist_abhs30.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs30.Strings[i],fastcharpos(stringlist_abhs30.Strings[i],',',1)+1,5)) then
             stringlist_abhs30.Delete(i);
   jit_del:= true;
   start_show_word(false);
   screen.Cursor:= crdefault;
  end;

end;

procedure TForm_pop.leiji_show;  //��ʾ�ۼ���Ϣ
var ss: string;
   i,j: integer;
begin

  gamesave1.leiji:= gamesave1.leiji + Trunc((now - jit_kssj) *24*60*60); //����ʱ��
   jit_kssj:= now; //�����µ���ʼʱ���
   i:= gamesave1.leiji div 86400;
   ss:= inttostr(i) + '�� ';
    j:= gamesave1.leiji - i * 86400;   //һ���ڵ�����
    i:= j div 3600;
    ss:= ss + inttostr(i) + 'Сʱ��';
    j:= j - i * 3600; //ʣ�µ�����
    i:= j div 60;
    ss:= ss + inttostr(i) + '�֣�';
    j:= j- i * 60;
    ss:= ss + inttostr(j) + '��';
  messagebox(handle,pchar('�ۼ���Ϸʱ�䣺'+ ss + #13#10 +
  '�ۼ���ȷ�ĵ����'+ inttostr(gamesave1.zqbs)+ #13#10 +
  '�ۼƴ���ĵ����'+inttostr(gamesave1.cwbs)),'��Ϣ',mb_ok or MB_ICONINFORMATION);


end;

procedure TForm_pop.FormDestroy(Sender: TObject);
begin

  if jit_del then
  begin
  if messagebox(handle,'�ʿ��ļ������ģ��Ƿ񱣴�˸��ģ�','����ʿ�', mb_yesno or MB_ICONWARNING)= mryes then
     word_lib_save;

  end;

  {$IFDEF IBM_SPK}
  if Assigned(jit_spk1) then
   begin
    jit_spk1.Terminate;
    postthreadmessage(jit_spk1.ThreadID,um_quitthread,0,0);
    jit_spk1.Free;
   end;
   {$ENDIF}

   wordlist1.Free;

   if Assigned(goods_time_list) then
   goods_time_list.Free;

 game_word_qianzhui.Free;
 game_word_houzhui.Free;
      stringlist_abhs5.Free;
     stringlist_abhs30.Free;
    stringlist_abhs240.Free;
    stringlist_abhs_d1.Free;
    stringlist_abhs_d2.Free;
    stringlist_abhs_d4.Free;
    stringlist_abhs_d7.Free;
   stringlist_abhs_d15.Free;

 fashu_wupin_kuaijie_list.Free;

    image_word.Free;
    image_cn1.Free ;
    image_cn2.Free ;
    image_cn3.Free ;
    image_up.Free  ;
    image_down.Free;

    image_guai1.Free;
    image_guai2.Free;
    image_guai3.Free;
    image_guai4.Free;
    image_guai5.Free;

       image_role1.Free;
       image_role2.Free;
       image_role3.Free;
       image_role4.Free;
       image_role5.Free;

    image_result1.Free;
     g_icon_image.Free;
     image_bg_1_1.Free;
     image_bg_1_2.Free;
  if assigned(image_bubble) then
     image_bubble.Free;
  if assigned(imgae_arrow) then
     imgae_arrow.Free;
  if Assigned(game_edit1_bmp) then
        game_edit1_bmp.Free;

 AsphyreDevice1.Finalize();
end;

procedure TForm_pop.show_check(i: integer);
begin

  checkbox2.Checked:= false;
  checkbox3.Checked:= false;
  checkbox8.Checked:= false;


  if GameSave1.zhuangtai and 2 = 2 then
   checkbox2.Checked:= true;
  if GameSave1.zhuangtai and 4 = 4 then
   begin
   checkbox2.Checked:= false;
    checkbox2.Enabled:= false;
    checkbox3.Checked:= true;
   end;
 { if GameSave1.zhuangtai and 8 = 8 then
   checkbox4.Checked:= true;
  if GameSave1.zhuangtai and 16 = 16 then
   checkbox5.Checked:= true; 
  if GameSave1.zhuangtai and 32 = 32 then
   checkbox6.Checked:= true;
  if GameSave1.zhuangtai and 64 = 64 then
   checkbox7.Checked:= true;  }
  if GameSave1.zhuangtai and 128 = 128 then
   checkbox8.Checked:= true;
 { if GameSave1.zhuangtai and 256 = 256 then
   checkbox9.Checked:= true; }
end;

procedure TForm_pop.save_check;
begin
GameSave1.zhuangtai:= 0;

  if checkbox2.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 2;
 if checkbox3.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 4;
     {
 if checkbox4.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 8;
 if checkbox5.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 16;
 if checkbox6.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 32;
   if checkbox7.Checked then  }
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 64;
  if checkbox8.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 128;
{  if checkbox9.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 256;  }
end;

procedure TForm_pop.My_FindFiles(sPath: string);
var
  sr:TSearchRec;
begin

  if FindFirst(sPath,faAnyFile,sr)=0 then
  begin
    if not((sr.Attr and faDirectory)>0) then
      combobox1.Items.Add(sr.Name);
    while FindNext(sr)=0 do
    begin
      if not((sr.Attr and faDirectory)>0) then
        combobox1.Items.Add(sr.Name);
    end;
  end;
  FindClose(sr);

end;

procedure TForm_pop.ComboBox1Change(Sender: TObject);
begin
if combobox1.ItemIndex= -1 then
   exit;
   
      if combobox1.text= '�༭���ظ���ʿ⡭��' then
            begin
             ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar('http://www.finer2.com/wordgame/wordlib.htm'),nil,sw_shownormal);
             ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar(game_app_path_G+'lib\'),nil,sw_shownormal);
             combobox1.ItemIndex:= combobox1.Tag;
            end else
               begin

            if FileExists(game_app_path_G+'Lib\'+ ComboBox1.Text) then
             begin
               if pos('��',combobox1.Text)> 0 then
                 begin
                  if game_bmp_width<> 512 then
                   begin
                    messagebox(handle,'�����õĴʿ�������ӣ��������ܱȽϳ�,����ʾ����ȫ������������Ϸ�ġ�ϵͳ����ҳ�桱�ڿ�����������˫����ȡ����ܡ�','��ʾ',mb_ok);
                   end;
                 end;
             combobox1.Tag:= combobox1.ItemIndex;
              wordlist1.Clear;
                wordlist1.LoadFromFile(game_app_path_G+'Lib\'+ ComboBox1.Text);
             g_string_abhs:= ComboBox1.Text + '.abhs';
             end else messagebox(handle,'�ʿ��ļ������ߣ���ѡ�����������ԡ�','�ļ�������',mb_ok or MB_ICONERROR);
                     end;

    if g_string_abhs<> '' then
    load_abhs;

  if wordlist1.Count < 3 then
   begin
    messagebox(handle,'�ʿⵥ�������٣����ܵ���ѡ��ѭ��������','���ش���',mb_ok or MB_ICONERROR);
    wordlist1.Add('aa=���޸Ĵʿ�');
    wordlist1.Add('bb=����̫����');
    wordlist1.Add('cc=�����ӵ���');
   end;
end;

procedure TForm_pop.show_ck;
begin
  combobox1.Items.Clear;
 if DirectoryExists(game_app_path_G+'Lib') then
  begin
   My_FindFiles(game_app_path_G+ 'Lib\*.ini');
  end;

 combobox1.Items.Add('�༭���ظ���ʿ⡭��');
 if combobox1.Tag> 0 then
 combobox1.ItemIndex:= combobox1.Tag
 else
 combobox1.ItemIndex:= 0;
end;

procedure TForm_pop.CheckBox3Click(Sender: TObject);
begin
 if checkbox3.Checked then
  begin
  checkbox2.Checked:= false;
  checkbox2.Enabled:= false;
  end else begin
            checkbox2.Checked:= true;
            checkbox2.Enabled:= true;
           end;
end;

procedure TForm_pop.add_lib;  //����ʿ��ļ�
begin
  opendialog1.FilterIndex:= 1;
   if opendialog1.Execute then
    begin
     if not DirectoryExists(game_app_path_G+'Lib') then
        mkdir(game_app_path_G+'Lib');

    copyFile(pchar(opendialog1.FileName),pchar(game_app_path_G+'Lib\'+ExtractFileName(opendialog1.FileName)),false);
      show_ck;
     end;
end;

procedure TForm_pop.out_Lib;
begin
  savedialog1.DefaultExt:='.ini';
  savedialog1.FilterIndex:= 1;
   if savedialog1.Execute then
    begin

            if FileExists(game_app_path_G+'Lib\'+ ComboBox1.Text) then
             begin
              copyFile(pchar(game_app_path_G+'Lib\'+ ComboBox1.Text),pchar(savedialog1.FileName),false);
             end else messagebox(handle,'�ʿ��ļ������ߣ���ѡ�����������ԡ�','�ļ�������',mb_ok or MB_ICONERROR);

    end;
end;

function TForm_pop.check_asw(i: integer; H_b: boolean): string;
//var int1:int64;
begin
result:= '';
game_state_answer:= true;
  g_tiankong:= false;
  
 if jit_tmp_3= -1 then
  exit;

      if h_b then
      begin
       game_pic_check_area:= G_all_pic_n; //��ֹѡ��

       timer5.Enabled:= false;
       show_text(false,'');
      end;

    //��ɫ
    if not h_b then
    begin
    case jit_tmp_3 of
    0: draw_asw(game_word_1,1,2);
    1: draw_asw(game_word_2,2,2);
    2: draw_asw(game_word_3,3,2);
    end;
    end;

   if g_is_tingli_b and (not h_b) then
                begin
                     //����״̬ ������ʾ����
                   draw_asw(Jit_words,0,0);
                   AsphyreTimer1Timer(self); //�ػ�
                 end;

 if i= jit_tmp_3 then
  begin

    jit_time:= -1;
    inc(GameSave1.zqbs);
    if (g_on_abhs= false) and game_abhs_g then
    stringlist_abhs5.Append(inttostr(DateTimeToFileDate(now))+
                           ','+ inttostr(game_dangqian_word_id)); //����һ����¼��abhs��

     g_on_abhs:= false; //��������Ϊfalse
    //ѡ����ȷ����һ������
    inc(game_bg_music_rc_g.number_count); //���ֱ�����������һ
       //��ʾ��ҳ�����
       Form1.update_caption(game_bg_music_rc_g.number_count);
       
    if h_b then
    begin  //*************************************����html
        tili_add_100; //��������
        
    if game_pop_count > 0 then
     begin
     dec(game_pop_count);
     inc(jit_num);
     result:= start_show_word(true);
     end else begin
               result:= '<tr><td>pass!</td></tr>';
               pk_zhihui_g.game_zt:=0;
               //ִ�к�������
                postmessage(form1.Handle,game_const_script_after,36,0);
              end;
           //*********************************************
    end else after_check_asw(true);

  end else begin

              if h_b then
              begin
               result:= '<tr><td>�𰸴���</td></tr><tr><td>'+Jit_words +' ��ȷ���ǣ�';
               pk_zhihui_g.game_zt:=0;
                  case jit_tmp_3 of
                    0: result:= result + game_word_1;
                    1: result:= result + game_word_2;
                    2: result:= result + game_word_3;
                    end;
                  result:= result + '</td></tr>';
              end else begin
               case i of
               0: draw_asw(game_word_1,1,1);
               1: draw_asw(game_word_2,2,1);
               2: draw_asw(game_word_3,3,1);
               end;
               jit_time:= -1;
             jit_tmp_3:= -1;
             inc(GameSave1.cwbs);
             //ѡ����󣬺�ɫ��ʾ����һ������
            if game_rep>= 0 then
               add_to_errorword_list(game_dangqian_word_id);
               
             after_check_asw(false);
                        end;
           end;


end;

function TForm_pop.start_show_word(h_b: boolean): string;
var ss,ss2,s_s: string;
    a,b,c,d,I_I: integer;
begin
//a:= 0;  h_s��ʾ�� H_bΪ��ʱ����h_sд��html
   {
   ������״̬����û�п���Ȩ���Ҳ�������ģʽ����ô�˳�
   }
   game_state_answer:= false; //��ʼ��ʾ��
   if edit1.Visible then
      edit1.Visible:= false;
   
    if game_at_net_g then
     begin
       if (game_player_head_G.duiwu_dg= 1) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt<>4) then
          exit;  //�������ȫ���棬��û�п���Ȩ���Ҳ��Ǵ�������ô���ʲ���ʾ
       if (game_player_head_G.duiwu_dg= 2) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt >4) then
          exit;  //����Ǵ�ָ��棬��û�п���Ȩ������ս��״̬����ô��������ʾ
     end;


result:= '';
 time_list1.Timer_show_jit_word:= 0;
 time_list1.Timer_show_jit_alpha:= 0;
 
b:= 0; //ʹ�����״�ʿ��ڣ��𵽻�������

  game_pic_check_area:= G_all_Pic_n;


 jit_tmp_3:= Random(3);
 jit_time:= 0;
 I_I:= 0; //�Ƿ�����ճ���

 jit_word_p:= get_Word_id; //ȡ�õ��ʱ�ţ�����д����ظ�ѡ����ȡ�ش��󵥴ʱ��


  ss:= get_word_safe(jit_word_p);
  while ss='' do
   begin
    jit_word_p:= get_Word_id;
    ss:= get_word_safe(jit_word_p);
   end;

    c:= fastcharpos(ss,'=',1);

    if checkbox3.Checked then
     Jit_words:= copy(ss,c+1,64)    //����ѧϰ
      else
       Jit_words:= copy(ss,1,c-1);

       if Jit_words= '' then
         Jit_words:='��'+ inttostr(jit_word_p)+'��ȱ=����';

     ss2:= copy(ss,c+1,256);
     a:= fastpos(ss2,';+',length(ss2),2,1);
     if a= 0 then
       a:= fastpos(ss2,';-',length(ss2),2,1);

     if a > 0 then
      begin
       b:= fastpos(ss2,';+',length(ss2),2,a+1);
        if b= 0 then
          b:= fastpos(ss2,';-',length(ss2),2,a+1);
        if b= 0 then
          b:= fastpos(ss2,';-',length(ss2),2,1); //���ڼ����п�����ǰ�棬����Ҫ�����һ��
        if b= a then
           b:= 0; //������ظ��ģ�Ϊ��
      end;

      if a > b then
       begin
          
          if ss2[a+ 1]= '-' then
            a:= strtoint2(ss2[a+ 2]) * -1
          else
           a:= strtoint2(ss2[a+ 2]);


         if b> 0 then
          begin
           if ss2[b+ 1]= '-' then
           b:= strtoint2(ss2[b+ 2]) * -1
            else
            b:= strtoint2(ss2[b+ 2]);
          end;
       end else if b> a then
                 begin
                   
                    if ss2[b+ 1]= '-' then
                      b:= strtoint2(ss2[b+ 2]) * -1
                      else
                      b:= strtoint2(ss2[b+ 2]);

                    if a> 0 then
                     begin
                      if ss2[a+ 1]= '-' then
                      a:= strtoint2(ss2[a+ 2]) *-1
                      else
                       a:= strtoint2(ss2[a+ 2]);
                     end;
                 end;

     s_s:= Jit_words;
     g_tiankong:= false;
     if (not game_bg_music_rc_g.not_tiankong) and (ByteType(Jit_words,1)<> mbLeadByte) and
        (not checkbox3.Checked) and (Random(4)=0) then
        begin //���
        //  if (length(Jit_words) > 32) and (pos(' ',Jit_words)> 0) then �Ǿ���
          i_i:=  Random(length(Jit_words))+1;
          while s_s[i_i]= ' ' do
              i_i:=  Random(length(Jit_words))+1;

         // s_s:= s_s +'(���)';
          s_s[i_i]:= '_';
          g_tiankong:= true;
        end;
        //�����ж��Ƿ���Ҫƴд��ϰ
     if length(Jit_words)>= 15 then
        g_tiankong:= true;
     if wordlist1.Count< 2000 then
        begin
          if length(Jit_words)<= 3 then
             g_tiankong:= true;
        end else if wordlist1.Count< 5000 then
                  begin
                    if length(Jit_words)<= 4 then
                      g_tiankong:= true;
                  end else 
                           begin
                             if length(Jit_words)<= 5 then
                                g_tiankong:= true;
                           end;
     if h_b then
     begin
       result:= '<tr><td><a href="game_spk_string('''+ Jit_words+''')" title="�ٴ��ʶ�" style="color:#000000;text-decoration:none">';
       if (I_I=0) and (game_tingli_i> 0) and (Game_base_random(game_tingli_i)=0) and (checkbox3.Checked= false) then
          result:= result +'��������</a></td></tr>'
          else
           result:= result +s_s +'</a></td></tr>';
      skp_string(Jit_words); //�ʶ�
     end else
        draw_asw(s_s,0);

     if (a= 0) and (b= 0) and game_shunxu_g then
      begin
        //û�мӼ���ָʾ��Ȼ��˳�򱳣���ô��ʹ��˳���� tip7�Ѿ���һ�ˣ����Լ�ȥһ
        //˳�򱳵���ʱ����3��Ϊһ�顣
        case (gamesave1.tip7- 1) mod 3 of
         0: begin
             a:= 1;
             b:= 2;
            end;
         1: begin
             a:= -1;
             b:= 1;
            end;
         2: begin
             a:= -1;
             b:= -2;
            end;
         end;
      end;

  if jit_tmp_3= 0 then
    begin    //111-------****
     if checkbox3.Checked then
        game_word_1:= copy(ss,1,pos('=',ss)-1)
        else
        game_word_1:= copy(ss,pos('=',ss)+1,128);

      if a <> 0 then
       c:= jit_word_p + a
      else
        c:= Random(wordlist1.Count);

      while c= jit_word_p do   //�ظ����ڶ�ȡһ��
           c:= Random(wordlist1.Count);

         ss:= get_word_safe(c);
         d:= c; //������������Ϊ�ظ������

         if checkbox3.Checked then
            game_word_2:= copy(ss,1,pos('=',ss)-1)
              else
               game_word_2:= copy(ss,pos('=',ss)+1,128);
      if b <> 0 then
      c:= jit_word_p + b
      else
       c:= Random(wordlist1.Count);

      while (c= d) or (c= jit_word_p) do
            c:= Random(wordlist1.Count);

          ss:= get_word_safe(c);
          if checkbox3.Checked then
              game_word_3:= copy(ss,1,pos('=',ss)-1)
                else
                 game_word_3:= copy(ss,pos('=',ss)+1,128);
      if i_i >0 then  //���
        begin
          c:= Random(26);
           while Jit_words[i_i]= chr(c+97) do
                 c:= Random(26);
         game_word_2:= chr(c+97)+ ' (���)'+ game_word_1;
          c:= Random(26);
           while (Jit_words[i_i]= chr(c+97)) or (game_word_2[1]=chr(c+97) ) do
                 c:= Random(26);
         game_word_3:= chr(c+97)+ ' (���)'+ game_word_1;
         game_word_1:= Jit_words[i_i]+ ' (���)'+ game_word_1;
        end; //ned ���
    end else if jit_tmp_3= 1 then begin   //111 222 -------------- ****

     if checkbox3.Checked then
      game_word_2:= copy(ss,1,pos('=',ss)-1)    //����ѧϰ
        else
            game_word_2:= copy(ss,pos('=',ss)+1,128);

        if a <> 0 then
      c:= jit_word_p + a
      else
        c:= Random(wordlist1.Count);
        while c= jit_word_p do
             c:= Random(wordlist1.Count);

          ss:= get_word_safe(c);
          d:= c;

         if checkbox3.Checked then
            game_word_1:= copy(ss,1,pos('=',ss)-1)
             else
               game_word_1:= copy(ss,pos('=',ss)+1,128);

       if b <> 0 then
      c:= jit_word_p + b
      else
       c:= Random(wordlist1.Count);
       while (c= d) or (c=jit_word_p) do
          c:= Random(wordlist1.Count);
       ss:= get_word_safe(c);

           if checkbox3.Checked then
              game_word_3:= copy(ss,1,pos('=',ss)-1)
               else
                game_word_3:= copy(ss,pos('=',ss)+1,128);

      if i_i >0 then  //���
        begin
         
          c:= Random(26);
           while Jit_words[i_i]= chr(c+97) do
                 c:= Random(26);
         game_word_1:= chr(c+97)+ ' (���)'+ game_word_2;
          c:= Random(26);
           while (Jit_words[i_i]= chr(c+97)) or (game_word_1[1]=chr(c+97) ) do
                 c:= Random(26);
         game_word_3:= chr(c+97)+ ' (���)'+ game_word_2;
         game_word_2:= Jit_words[i_i]+ ' (���)'+ game_word_2;
        end; //ned ���
    end else begin   ///222 333 ---------------  ************

               if checkbox3.Checked then
                game_word_3:= copy(ss,1,pos('=',ss)-1)   //����ѧϰ
                  else
                   game_word_3:= copy(ss,pos('=',ss)+1,128);

        if a <> 0 then
      c:= jit_word_p + a
      else
        c:= Random(wordlist1.Count);
        while (c= jit_word_p) do
           c:= Random(wordlist1.Count);
           ss:= get_word_safe(c);
           d:= c;
             if checkbox3.Checked then
               game_word_1:= copy(ss,1,pos('=',ss)-1)
                else
                 game_word_1:= copy(ss,pos('=',ss)+1,128);

       if b <> 0 then
      c:= jit_word_p + b
      else
       c:= Random(wordlist1.Count);
       while (c= d) or (c= jit_word_p) do
           c:= Random(wordlist1.Count);
          ss:= get_word_safe(c);
       
             if checkbox3.Checked then
                game_word_2:= copy(ss,1,pos('=',ss)-1)
                 else
                  game_word_2:= copy(ss,pos('=',ss)+1,128);

        if i_i >0 then  //���
        begin
         
          c:= Random(26);
           while Jit_words[i_i]= chr(c+97) do
                 c:= Random(26);
         game_word_2:= chr(c+97)+ ' (���)'+ game_word_3;
          c:= Random(26);
           while (Jit_words[i_i]= chr(c+97)) or (game_word_2[1]=chr(c+97) ) do
                 c:= Random(26);
         game_word_1:= chr(c+97)+ ' (���)'+ game_word_3;
         game_word_3:= Jit_words[i_i]+ ' (���)'+ game_word_3;
        end; //ned ���

             end;      ///333


   // button1.SetFocus;
     //���� ;+ ;-
     a:= fastpos(game_word_1,';+',length(game_word_1),2,1);
     b:= fastpos(game_word_1,';-',length(game_word_1),2,1);
     if (a > b) and (b > 0) then
      a:= b;
     if (a < b) and (a= 0) then
      a:= b;
     if a > 0 then
        game_word_1:= copy(game_word_1,1,a-1);
     a:= fastpos(game_word_2,';+',length(game_word_2),2,1);
     b:= fastpos(game_word_2,';-',length(game_word_2),2,1);
     if (a > b) and (b > 0) then
      a:= b;
     if (a < b) and (a= 0) then
      a:= b;
     if a > 0 then
        game_word_2:= copy(game_word_2,1,a-1);
     a:= fastpos(game_word_3,';+',length(game_word_3),2,1);
     b:= fastpos(game_word_3,';-',length(game_word_3),2,1);
     if (a > b) and (b > 0) then
      a:= b;
     if (a < b) and (a= 0) then
      a:= b;
     if a > 0 then
        game_word_3:= copy(game_word_3,1,a-1);

     if H_b then
     begin
      result:= result +'<tr><td><a href="game_asw_html_in_pop(0)">' +game_word_1 +'</a></td></tr>'+
                 '<tr><td><a href="game_asw_html_in_pop(1)">' +game_word_2 +'</a></td></tr>'+
                 '<tr><td><a href="game_asw_html_in_pop(2)">' +game_word_3 +'</a></td></tr>';
     end else begin
               //�����ӳ���ʾ��
               if (checkbox8.Checked= true) or
                  (game_read_values(0,ord(g_30_yanchi)) = 0) then
                 begin
                   checkbox8.Checked:= true;
                   if game_pop_type in[1,2,5] then
                      show_text(true,'���Եȣ���ѡ���ӳټ������ʾ��');

                   //�����ͼ
                   draw_random_pic;
                  //�ӳ���ʾ��ʼ��ʱ
                  timer1.Enabled:= true;
                 end else begin
                           timer1.Enabled:= false;
                          if game_pop_type in[1,2,5] then
                             show_text(true,'��ѡ��һ����ȷ�Ĵ𰸡�');

                            draw_asw(game_word_1,1);
                            draw_asw(game_word_2,2);
                            draw_asw(game_word_3,3);

                            game_write_values(0,ord(g_30_yanchi),game_read_values(0,ord(g_30_yanchi))-1);
                            //�ۼ�������ʾ����

                            checkbox8.Hint:= '��ǰʣ��ʱ����ٴ�����' +
                                            inttostr(game_read_values(0,ord(g_30_yanchi)));
                          end;

              end; //end h_b

  game_word_amt;   //����
  set_Action_az;
end;

procedure TForm_pop.Timer1Timer(Sender: TObject);
begin
  //������ʾ
  if game_pop_type in[1,2,5] then
     show_text(true,'��ѡ��һ����ȷ�Ĵ𰸡�');
 draw_asw(game_word_1,1);
 draw_asw(game_word_2,2);
 draw_asw(game_word_3,3);
  timer1.Enabled:= false;

  if game_bg_music_rc_g.type_word and
      (g_is_tingli_b=false) and (g_tiankong=false) then
      if timer1.Enabled= false then
        begin

         edit1.Visible:= true;
         create_edit_bmp(game_word_1); //������ͼ
         edit1.Repaint;
         edit1.SetFocus;
         Timer_daojishi.Tag:= 600;
         Timer_daojishi.Enabled:= true;
        end;

end;

procedure TForm_pop.save_game_progress(filename: string);
var File1: File Of TGameSave;
begin


             GameSave1.sch_count:=game_bg_music_rc_g.sch_count1;

             GameSave1.music_index:= game_bg_music_rc_g.bg_music_index;
             GameSave1.koucu:=jit_koucu;
             GameSave1.img_index:= game_bg_music_rc_g.bg_img_index;
            // GameSave1.leiji:=jit_leiji;
             GameSave1.index:= combobox1.ItemIndex;
 if not DirectoryExists(ExtractFileDir(filename)) then
     mkdir(ExtractFileDir(filename));

 AssignFile(File1,filename);
 Rewrite(File1);
 try
   write(File1,GameSave1);
 finally
   CloseFile(File1);
   end;


end;
function GetFileSize(const FileName: string): LongInt;
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := SearchRec.Size
    else Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;
procedure TForm_pop.load_game_progress(const filename: string);
var File1: File Of TGameSave;
begin
 if GetFileSize(filename) = sizeof(GameSave1) then
  begin
  AssignFile(File1,filename);
  Reset(File1);
 try
   if not Eof(File1) then
   Read(File1,GameSave1);
 finally
   CloseFile(File1);
   end;
            game_bg_music_rc_g.sch_count1:= GameSave1.sch_count;
            game_bg_music_rc_g.bg_music_index:=GameSave1.music_index;
             
            jit_koucu:= GameSave1.koucu;
            game_bg_music_rc_g.bg_img_index:= GameSave1.img_index;
            jit_leiji:= GameSave1.leiji;
            
     if gamesave1.index= -1 then
        gamesave1.index:= 0;
     combobox1.ItemIndex:= gamesave1.index;
     ComboBox1Change(combobox1); //���뵥�ʱ�

  end else begin
            GameSave1.me_win:= 0;
            GameSave1.cpt_win:= 0;
            jit_koucu:= 0;
            jit_leiji:= 0;
            GameSave1.zhuangtai:= 195;
            GameSave1.index:= 0; //��ʼ�����ʱ�Ϊ����900
            GameSave1.tip1:= 0;
            GameSave1.tip2:= 0;
            GameSave1.tip3:= 0;
            GameSave1.tip4:= 0;
            GameSave1.tip5:= 0;
            GameSave1.tip6:= 0;
            GameSave1.tip7:= 0;
            GameSave1.zqbs:= 0;
            GameSave1.cwbs:= 0;
           end;

end;
procedure CreateMutexes(const MutexName: String);
const
  SECURITY_DESCRIPTOR_REVISION = 1;  { Win32 constant not defined in Delphi 3 }
var
  SecurityDesc: TSecurityDescriptor;
  SecurityAttr: TSecurityAttributes;
begin
  { By default on Windows NT, created mutexes are accessible only by the user
    running the process. We need our mutexes to be accessible to all users, so
    that the mutex detection can work across user sessions in Windows XP. To
    do this we use a security descriptor with a null DACL. }
  InitializeSecurityDescriptor(@SecurityDesc, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@SecurityDesc, True, nil, False);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := @SecurityDesc;
  SecurityAttr.bInheritHandle := False;
  CreateMutex(@SecurityAttr, False, PChar(MutexName));
  //CreateMutex(@SecurityAttr, False, PChar('Global\' + MutexName));
end;
function create_guid: string;
var  T:Tguid;
begin
  createguid(T);
  result := Guidtostring(t);
  result := StringReplace(result,'-','',[rfReplaceAll]);
  result:= copy(result,2,17);
end;

procedure TForm_pop.FormCreate(Sender: TObject);
var str1: Tstringlist;
    ss,ss2: string;
    i: integer;
begin

   jit_kssj:= now;  //���濪ʼʱ��
   game_beijing_index_cur:= -1;
// ��ʼ�� Asphyre Device
   form_show.show_info('��ʼ��DirectX�豸����3%');
  AsphyreDevice1.WindowHandle:= panel1.Handle;
  if (not AsphyreDevice1.Initialize()) then begin
    if Messagebox(handle,'��Ϸ��ʼ��DirectX����ʧ�ܣ���ȷ���Կ���Ӳ�����������á������������������������ԣ�������ǡ��鿴����ԭ��ͽ��������', '��ʼ��ʧ��',mb_yesno)
       =mryes then
       ShellExecute(handle,'open',pchar(game_app_path_G+'dat\error.txt'),nil,nil,sw_shownormal);

    application.Terminate;
    Exit;
  end;

  form_show.show_info('����������Ϣ����20%');
   //��ʼ�������
   Randomize; //��ʼ�������
   str1:= Tstringlist.Create;  //��ʼ���������ı��ͱ�����ɫ
   if not FileExists(game_app_path_G+'dat\set.txt') then
    begin
     messagebox(handle,'set.txt�������ļ������ڣ�������Ϸ��װ����ɡ����http://www.finer2.com/wordgame/ ���������汾��','����',mb_ok);
     application.Terminate;
    end;

   if FileExists(game_doc_path_g+'dat\set.txt') then
     str1.LoadFromFile(game_doc_path_g+'dat\set.txt')
     else
      str1.LoadFromFile(game_app_path_G+'dat\set.txt');

    game_E_color_R:= strtoint2(str1.Values['game_E_color_R']);
    game_E_color_G:= strtoint2(str1.Values['game_E_color_G']);
    game_E_color_B:= strtoint2(str1.Values['game_E_color_B']);
       game_C_color_R:= strtoint2(str1.Values['game_C_color_R']);
       game_C_color_G:= strtoint2(str1.Values['game_C_color_G']);
       game_C_color_B:= strtoint2(str1.Values['game_C_color_B']);
       game_BE_color_R:= strtoint2(str1.Values['game_BE_color_R']);
       game_BE_color_G:= strtoint2(str1.Values['game_BE_color_G']);
       game_BE_color_B:= strtoint2(str1.Values['game_BE_color_B']);
       game_BC_color_R:= strtoint2(str1.Values['game_BC_color_R']);
       game_BC_color_G:= strtoint2(str1.Values['game_BC_color_G']);
       game_BC_color_B:= strtoint2(str1.Values['game_BC_color_B']);
                   //�����ǵ��ʷ�ɫ��ɫ
       game_WB_color_R:= strtoint2(str1.Values['game_WB_color_R']);
       game_WB_color_G:= strtoint2(str1.Values['game_WB_color_G']);
       game_WB_color_B:= strtoint2(str1.Values['game_WB_color_B']);
       game_WA_color_R:= strtoint2(str1.Values['game_WA_color_R']);
       game_WA_color_G:= strtoint2(str1.Values['game_WA_color_G']);
       game_WA_color_B:= strtoint2(str1.Values['game_WA_color_B']);

       game_en_size:= strtoint2(str1.Values['game_en_size']);
       game_cn_size:= strtoint2(str1.Values['game_cn_size']);
        game_speed_a:= str1.Values['game_speed_a']='1'; //�����Ƿ������ʾ
       // game_tts_index:= strtoint2(str1.Values['game_tts_index']); ��Щֵ��unit_set ��Ԫ������


          game_not_bg_black:= (str1.Values['game_bk'] <> '1');  //�Ƿ�ʹ�ú�ɫ����
          game_shunxu_g:=  (str1.Values['game_shunxu'] = '1');
         game_abhs_g:= (str1.Values['game_abhs'] = '1');

          if str1.Values['game_width'] = '1' then
           begin
             game_bmp_width:= 512;
             g_word_show_left:= 64; //���ʺͽ�����ʾ�����λ��
           end   else  begin
                game_bmp_width:= 256; //���������ϵ��
                g_word_show_left:= 192; //���ʺͽ�����ʾ�����λ��
                       end;
    if strtoint2(str1.Values['delay_show_word']) < 3000 then
       timer1.Interval:= 3000
       else
        timer1.Interval:= strtoint2(str1.Values['delay_show_word']);

     game_m_color:= strtoint2(str1.Values['game_m_color']); //���ʷ�ɫ
     game_tingli_i:= strtoint2(str1.Values['game_tingli_i']); //�����������
     game_rep:= strtoint2(str1.Values['game_rep']) -1; //�����ظ�ѧϰ

     Game_net_hide_g:= str1.Values['game_net_hide'] = '1';

      game_pstringw:= str1.Values['game_id']; //������Ϸ���������־
      Game_app_img_url_G:= str1.Values['image_path'];
      if str1.Values['no_image']= '1' then
         Game_error_count_G:= 100;

      Game_update_file_G:= str1.Values['update_file'];
      Game_update_url_G:=  str1.Values['update_url'];
      game_NoRevealTrans_g:= (str1.Values['No_RevealTrans']= '1');
       with game_bg_music_rc_g do
       begin
       bg_img:= (str1.Values['bg_img']= '1');
       bg_tm:= strtoint2(str1.Values['bg_tm']);
       bg_music:= (str1.Values['bg_music']= '1');
       bg_yl:= strtoint2(str1.Values['bg_yl']);
       bg_lrc:= (str1.Values['bg_lrc']= '1');
       mg_pop:= (str1.Values['mg_pop']= '1');
       pop_img:= (str1.Values['pop_img']= '1');
       pop_img_tm:= strtoint2(str1.Values['pop_img_tm']);
       bg_img_radm:= (str1.Values['bg_img_radm']= '1');
       bg_music_radm:= (str1.Values['bg_music_radm']= '1');
       bg_music_base:= (str1.Values['bg_music_base']= '1');
       lrc_dir:= str1.Values['lrc_dir'];
       sch_enable:=  (str1.Values['sch_enable']= '1');
       sch_max:=strtoint2(str1.Values['sch_MAX']); //�������ĵ����ؼ�����������
       sch_key:= str1.Values['sch_key'];
       sch_pic:= str1.Values['sch_pic']; //������ͼƬ·��
       gum_path:= str1.Values['gum_path'];
       gum_only:= (str1.Values['gum_only']= '1'); //������gum·��
       sch_img_sty:= strtoint2(str1.Values['sch_img_sty']);
       sch_img_height:=  strtoint2(str1.Values['sch_img_height']);
       not_tiankong:=    (str1.Values['not_tiankong']='1');
       type_word:=       (str1.Values['type_word']= '1');
       type_word_flash:=  (str1.Values['type_word_flash']='1');
       type_char_spk:=  (str1.Values['type_char_spk']='1');
       desktop_word:=  (str1.Values['desktop_word']='1');
       show_ad_web:=  (str1.Values['show_ad_web']='1');
       yodao_sound:=  (str1.Values['yodao_sound']='1');
       down_readfile:=  (str1.Values['down_readfile']='1');
       en_type_name:= str1.Values['en_type_name'];
       cn_type_name:= str1.Values['cn_type_name'];
       baidu_vol:= strtoint2(str1.Values['baidu_vol']);
        if baidu_vol=0 then
           baidu_vol:= 5;
        baidu_sex:= strtoint2(str1.Values['baidu_sex']);
        baidu_spd:= strtoint2(str1.Values['baidu_spd']);
         if baidu_spd=0 then
           baidu_spd:= 5;
        baidu_pit:= strtoint2(str1.Values['baidu_pit']);
         if baidu_pit=0 then
           baidu_pit:= 5;
       end;

         token:= str1.Values['token'];  //�ٶ���������Ȩ��
         if token<>'' then
          begin
           //���token�Ƿ����
            ss2:= str1.Values['expires'];
            if ss2<>'' then
             begin
              if strtoint64(ss2)- get_second < 72000 then
                 token:= ''; //��Ч��С��20Сʱ�����

             end else token:= '';
          end;
         {
         yodao_udp_host:= create_guid; //ȡ��һ��guid��־
       yodao_udp_g:= StringReplace(str1.Values['yodao_udp_path'],'$guid$',yodao_udp_host,[]);
       yodao_tcp_g:= StringReplace(str1.Values['yodao_tcp_path'],'$guid$',yodao_udp_host,[]);

       yodao_udp_host:= str1.Values['yodao_udp_host'];   }

       if (game_bg_music_rc_g.sch_key= '') or (game_bg_music_rc_g.sch_pic= '') then
          game_bg_music_rc_g.sch_enable:= false;   //����ؼ���Ϊ�ջ���������ַΪ��,�򲻼���˹���

      if game_rep >= 0 then
         game_error_word_list_G[0]:= game_rep;

         form_show.show_info('ע���ݼ�����35%');
         //�����ȼ�
      Action1.ShortCut:= TextToShortCut(str1.Values['game_gong']);
      Action2.ShortCut:= TextToShortCut(str1.Values['game_fang']);
      Action3.ShortCut:= TextToShortCut(str1.Values['game_shu']);
      Action4.ShortCut:= TextToShortCut(str1.Values['game_wu']);
      Action5.ShortCut:= TextToShortCut(str1.Values['game_tao']);
      Action6.ShortCut:= TextToShortCut(str1.Values['game_word1']) ;
      Action7.ShortCut:= TextToShortCut(str1.Values['game_word2']) ;
      Action9.ShortCut:= TextToShortCut(str1.Values['game_word3']) ;
      Action8.ShortCut:= TextToShortCut(str1.Values['game_del']); //ShortCutToText



      form_show.show_info('��ʼ�����ʱ���50%');
      clear_errorword_list; //��ʼ�����ʴ����б�

    form_show.show_info('����ͼƬ��Դ����65%');
   image_word := TAsphyreImage.Create; //����ͼ
    image_cn1 := TAsphyreImage.Create;
    image_cn2 := TAsphyreImage.Create;
    image_cn3 := TAsphyreImage.Create;

    image_up  := TAsphyreImage.Create;
    image_down:= TAsphyreImage.Create;


    image_guai1 := TAsphyreImage.Create;
     with image_guai1 do begin
      Size:= point(128,64);
      VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai2 := TAsphyreImage.Create;
     with image_guai2 do begin
       Size:= point(128,64);
       VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai3 := TAsphyreImage.Create;
     with image_guai3 do begin
     Size:= point(128,64);
     VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai4 := TAsphyreImage.Create;
     with image_guai4 do begin
     Size:= point(128,64);
     VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai5 := TAsphyreImage.Create;
     with image_guai5 do begin
     Size:= point(128,64);
     VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;

       image_role1 := TAsphyreImage.Create;
        with image_role1 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
        PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
        end;
       image_role2 := TAsphyreImage.Create;
        with image_role2 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
        PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
        end;
       image_role3 := TAsphyreImage.Create;
        with image_role3 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
       image_role4 := TAsphyreImage.Create;
        with image_role4 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
       image_role5 := TAsphyreImage.Create;
        with image_role5 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
       end;

       image_result1:= TAsphyreImage.Create;
        with image_result1 do begin
        Size:= point(256,128);
        VisibleSize:= point(g_result_w1,g_result_h1);
        PatternSize:= point(g_result_w1,g_result_h1);
       end;
        g_icon_image:= TAsphyreImage.Create;
          with g_icon_image do begin
          Size:= point(64,64);
          VisibleSize:= point(48,48);
          PatternSize:= point(48,48);
         end;

        image_bg_1_1:= TAsphyreImage.Create;
         image_bg_1_1.Size:= point(512,512);
        image_bg_1_2:= TAsphyreImage.Create;
         image_bg_1_2.Size:= point(128,512);

         image_bg_1_1.VisibleSize:= point(512,480); //���ô�С
     image_bg_1_1.PatternSize:= point(512,480);
      image_bg_1_2.VisibleSize:= point(128,480);
     image_bg_1_2.PatternSize:= point(128,480);

  form_show.show_info('����abhs����80%');

  if fileExists(game_doc_path_G+'save\default.sav') then
    load_game_progress(game_doc_path_G+'save\default.sav')
   else
     load_game_progress(game_app_path_G+'save\default.sav');
     
 wordlist1:= Tstringlist.Create;
 stringlist_abhs5:= Tstringlist.Create;
  stringlist_abhs30:= Tstringlist.Create;
  stringlist_abhs240:= Tstringlist.Create;
    stringlist_abhs_d1:= Tstringlist.Create;
    stringlist_abhs_d2:= Tstringlist.Create;
    stringlist_abhs_d4:= Tstringlist.Create;
    stringlist_abhs_d7:= Tstringlist.Create;
    stringlist_abhs_d15:= Tstringlist.Create;
 show_ck; //����ʿ�
 if gamesave1.index= -1 then
    gamesave1.index:= 0;
  combobox1.ItemIndex:= gamesave1.index;
 ComboBox1Change(combobox1); //���뵥�ʱ�
  show_check(gamesave1.zhuangtai);


  GroupBox3.Left:= 216; //��������ѡ�񴰿ڿ��ұ�

    init_weizi; //��ʼ������λ��

  //���뱳��ͼƬ
                
    ss:= game_app_path_G;
  fashu_wupin_kuaijie_list:= Tstringlist.Create;

 //���뵥��ǰ׺�ͺ�׺
 game_word_qianzhui:= Tstringlist.Create;
 game_word_houzhui:= Tstringlist.Create;
  game_word_qianzhui.LoadFromFile(ss+ 'dat\qian.txt');
   game_word_houzhui.LoadFromFile(ss+ 'dat\hou.txt');
      game_init_Success_G:= true;

   form_show.show_info('��������Ч������85%');
   //�������� Ч��
   for i:= 1 to 16 do
   with DXWaveList1 do
    begin
    Items.add;
    Items[i-1].Wave.LoadFromFile(ss+'music\w'+ inttostr(i)+'.wav');
    Items[i-1].Restore;
    end;

  if DebugHook = 0 then
     CreateMutexes('finer_gameword'); //�ں˻�����󣬰�װ����ã������˳�ʱ���Զ�����

  if not game_bg_music_rc_g.show_ad_web then
   create_top_ad;

   form_show.show_info('��ʼ�������ϳ��������90%');

   if game_bg_music_rc_g.yodao_sound=false then
    begin
     //���ʹ�ðٶ������ģ��򲻼�����Щ����
     if game_can_spvoice1 then
      begin
         try
           //SpVoice1.Rate:= round(5 / 0);
          SpVoice1:= TSpVoice.Create(application);
          SpVoice1.Rate:=  strtoint2(str1.Values['game_tts_rate']);
            SpVoice1.Volume:= strtoint2(str1.Values['game_tts_vol']);

            if str1.Values['game_tts_sooth'] = '1' then
              game_kptts_init;   //��ʼ����ɽ�����ʶ��ؼ�

          except
           SpVoice1:= nil;
          // checkbox2.Checked:= false; //��ʼ��tts����������ֹ
           //checkbox2.Enabled:= false;

           game_bg_music_rc_g.yodao_sound:= true; //Ĭ�����ðٶ�����
           if Messagebox(handle,'�����ϳ������ʼ��ʧ�ܣ��ٶ������ʶ��Զ����ã���������������������ǡ��鿴����ԭ��ͽ��������', 'TTS����ʧ��',mb_yesno)
              =mryes then
           ShellExecute(handle,'open',pchar(game_app_path_G+'dat\ttserror.txt'),nil,nil,sw_shownormal);
         end;
      end else begin
                game_bg_music_rc_g.yodao_sound:= true; //Ĭ�����ðٶ�����
                showmessage('΢��tts������װ����ȷ�����Զ������˰ٶ������ϳɣ���Ϸ�ѿ��������ʶ���Ӣ�ġ�');
               end;
   end;

   game_guid:= str1.Values['guid'];
    if game_guid='' then
      begin
         game_guid:= form1.game_create_guid;
         str1.Values['guid']:= game_guid;
         str1.saveToFile(game_doc_path_g+'dat\set.txt');
      end;
   str1.Free;
end;

procedure TForm_pop.draw_asw(s: string; flag: integer; c: integer=0); //����cΪ1��ʾ��ɫ��2��ʾ��ɫ����
var
   bmp : TBitmap;
   r1: Trect;
   qianhouzhui: T_word_QianHouZhui; //����ǰ��׹��λ��
   a,b: string;
begin
 game_pic_check_area:= G_words_Pic_y; //���ʿɱ�ѡ��

 bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
         if flag= 0 then
          begin
           bmp.Width:=game_bmp_width;
           bmp.Height:=game_bmp_h1;
           bmp.Canvas.Font.Name:=game_bg_music_rc_g.en_type_name;
           bmp.Canvas.Font.Size:= game_en_size;
           bmp.Canvas.Font.Color:= rgb(game_E_color_R,game_E_color_G,game_E_color_B);
           bmp.Canvas.Brush.Style:= bsClear;
            bmp.Canvas.Brush.Color:=rgb(game_BE_color_R,game_BE_color_G,game_BE_color_B);
            bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h1));
             if (timer_daojishi.Enabled=false) and (g_tiankong=false) and (game_tingli_i> 0)
                 and (Game_base_random(game_tingli_i)=0) and (checkbox3.Checked= false) then
              begin
               bmp.Canvas.TextOut(5, 8, '��������(��R������)'); //��б�ܵı�ʾ����ճ��� ������
               g_is_tingli_b:= true;
              end else  begin
                         g_is_tingli_b:= false;
                         if bmp.Canvas.TextWidth(s)> bmp.Width then
                      begin
                       //����
                       if game_cn_size > 14 then
                          bmp.Canvas.Font.Size:= 14;  //��С����
                          r1:= rect(2,1,bmp.Width,bmp.Height);
                        DrawTextEx(bmp.Canvas.Handle,pchar(s),length(s),r1,DT_WORDBREAK,nil);

                      end else begin
                           bmp.Canvas.TextOut(5, 8, s);
                            if (game_m_color > 0) and (pos(' ',s)=0) then
                             begin
                              //���濪ʼ���ʷ�ɫ��ʾ
                            get_word_fen(qianhouzhui,s); //ȡ�õ��ʷ�ɫλ��
                             if qianhouzhui.qian_start > 0 then
                               begin
                               //ǰ׺��ɫ
                               b:= copy(s,qianhouzhui.qian_start,qianhouzhui.qian_end);
                               bmp.Canvas.Font.Color:= rgb(game_WB_color_R,game_WB_color_G,game_WB_color_B);
                               bmp.Canvas.TextOut(5, 8, b);
                               end;
                             if qianhouzhui.hou_start > 0 then
                               begin
                               //��׺��ɫ
                               a:= copy(s,qianhouzhui.hou_start,qianhouzhui.hou_end);
                               bmp.Canvas.Font.Color:= rgb(game_WA_color_R,game_WA_color_G,game_WA_color_B);
                               bmp.Canvas.TextOut(5+ bmp.Canvas.TextWidth(copy(s,1,qianhouzhui.hou_start-1)), 8, A);
                               end;
                             end;
                                end; //end ����
                        end;
              with image_word do
               begin
                LoadFromBitmap(bmp,false,0,0); //���µ���Ļ
               end;
          end else begin
                    bmp.Width:=game_bmp_width;
                    bmp.Height:=game_bmp_h2;
                    bmp.Canvas.Font.Name:=game_bg_music_rc_g.cn_type_name;
                      bmp.Canvas.Font.Size:= game_cn_size;
                       case c of
                        0:bmp.Canvas.Font.Color:= rgb(game_C_color_R,game_C_color_G,game_C_color_B);
                        1: bmp.Canvas.Font.Color:= clred;
                        2: bmp.Canvas.Font.Color:= clgreen;
                       end;
                    bmp.Canvas.Brush.Style:= bsClear;
                     bmp.Canvas.Brush.Color:=rgb(game_BC_color_R,game_BC_color_G,game_BC_color_B);
                    bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));
                    if not game_state_answer then
                    begin
                    //��ʼ��ʾ
                    if game_bg_music_rc_g.type_word and
                       (g_is_tingli_b=false) and (g_tiankong=false) then
                       begin
                        if flag=1 then
                          begin
                           if jit_tmp_3> 0 then //��ȷֵʼ��Ϊ��һ��
                              begin
                               case jit_tmp_3 of
                                1: game_word_1:= game_word_2;
                                2: game_word_1:= game_word_3;
                                end;
                                jit_tmp_3:= 0;
                                s:= game_word_1;
                              end;
                          end else if flag=3 then
                                       begin
                                       if not edit1.Visible then
                                          s:= '����Ӣ�� ����Ctrl + P �ر�ƴд';
                                       end{ else if flag=2 then s:= ''};
                       //edit1.Visible:= true;
                       end;
                       end else begin
                                 //��ȷ����ʾ������ȫ����ʾ��ȷ��
                                   case jit_tmp_3 of
                                  0: s:= game_word_1;
                                  1: s:= game_word_2;
                                  2: s:= game_word_3;
                                  end;

                                end;
                     if bmp.Canvas.TextWidth(s)> bmp.Width then
                      begin
                       //����
                       if game_cn_size > 11 then
                          bmp.Canvas.Font.Size:= 11;  //��С����
                          r1:= rect(2,1,bmp.Width,bmp.Height);
                        DrawTextEx(bmp.Canvas.Handle,pchar(s),length(s),r1,DT_WORDBREAK,nil);

                      end else
                            bmp.Canvas.TextOut(5, 8, s);

                     case flag of
                      1: begin
                          with image_cn1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
                      2: begin
                          with image_cn2 do
                          LoadFromBitmap(bmp,false,0,0);

                         end;
                      3: begin
                          with image_cn3 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
                      end;
                   end;


      // GLMaterialLibrary1.Materials.Items[flag].Material.Texture.image.Assign(bmp);
      bmp.Free;
// G_dangqian_zhuangtai:=G_word;  ת�Ƶ�������
end;

procedure TForm_pop.game_intl_pic;
var
   bmp : TBitmap;
begin
   // ��ʼ��ͼƬ

      bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;

     // bmp.LoadFromFile(game_app_path_G+ 'sg.BMP');
        bmp.Width:=game_bmp_width;
        bmp.Height:=game_bmp_h1;
      bmp.Canvas.Font.Name:='����';
      bmp.Canvas.Font.Size:= 21;
      bmp.Canvas.Brush.Style:= bsClear;

         bmp.Canvas.TextOut(5, 8, '������Ϸ������');
     // bmp.Canvas.TextOut(3, 65, 'ufo2003@126.com');
         with image_word do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;



        bmp.Canvas.Font.Size:= 16;
        bmp.Width:=game_bmp_width;
        bmp.Height:=game_bmp_h2;
        bmp.Canvas.Brush.Color:=rgb(165,255,255);
        bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));
         bmp.Canvas.TextOut(5, 5, 'ufo2003@126.com');

       with image_cn1 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;
       with image_cn2 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;
        with image_cn3 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;


       //��������������ʼ��
         bmp.Canvas.Font.Size:= 12;
        bmp.Width:=game_bmp_role_width;
        bmp.Height:=game_bmp_role_h;
        bmp.Canvas.Brush.Color:=rgb(255,255,255);
        bmp.Canvas.FillRect(rect(0,0,game_bmp_role_width,game_bmp_role_h));
         bmp.Canvas.TextOut(5, 2, '����');


      bmp.Free;


end;

procedure TForm_pop.draw_random_pic; //�������ͼ��
var
   bmp : TBitmap;
begin
game_pic_check_area:= G_all_pic_n; //����ʾ�ȴ��ڣ�ȫ��gl�����ֹѡ�С�
 bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
                    bmp.Width:=game_bmp_width;
                    bmp.Height:=game_bmp_h2;
                         //������������ɫ
                     bmp.Canvas.Brush.Color:=rgb(220,218,232);
                    bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));

              draw_random_pic_base(bmp);

                          with image_cn1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;

                          with image_cn2 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;


                          with image_cn3 do
                           begin
                          
                          LoadFromBitmap(bmp,false,0,0);
                            end;

      bmp.Free;

end;

procedure TForm_pop.draw_random_pic_base(b: Tbitmap;one: boolean=false);
var FGenPointFrom: tpoint;
     FBranchColor: TBranchColor;
     FBranchWidth: integer;
     FGenLength: single;
  const
       PI   =   3.14159;
      PI2   =   2   *   PI;
      GEN_ANGLE_DEVIATION   =   PI2   /   16;
      BRANCH_RATIO   =   0.80;
      PROBABILITY_THREASHOLD   =   0.1;
       FGenAngle   =   PI2   *   3   /   4;

 procedure DrawFractalTree(GenPointFrom:   TPoint;   GenLength,
      GenAngle:   Real;   BranchWidth:   Integer;   BranchColor:   TBranchColor);   
    function   CanTerminate(GenPoint:   TPoint;   GenLength:Real):   Boolean;   
      begin   
          if   (GenPoint.X   <   0)   or   (GenPoint.X   >   b.Width)
              or   (GenPoint.Y   <   0)   or   (GenPoint.Y   >   b.Width)
              or   (GenLength   <   1)   then   
              Result   :=   True   
          else   
              Result   :=   False;   
      end;   
    
      function   ToPoint(GenPointFrom:   TPoint;   GenLength,   GenAngle:   Real;   IsLeft:   Boolean):   TPoint;   
      begin   
          if   IsLeft   then   
          begin   
              Result.X   :=   GenPointFrom.X   +   Trunc(GenLength   *   cos(GenAngle   -   GEN_ANGLE_DEVIATION));   
              Result.Y   :=   GenPointFrom.Y   +   Trunc(GenLength   *   sin(GenAngle   -   GEN_ANGLE_DEVIATION));   
          end   
          else   
          begin   
              Result.X   :=   GenPointFrom.X   +   Trunc(GenLength   *   cos(GenAngle   +   GEN_ANGLE_DEVIATION));
              Result.Y   :=   GenPointFrom.Y   +   Trunc(GenLength   *   sin(GenAngle   +   GEN_ANGLE_DEVIATION));   
          end;   
      end;

  var   
      GenPointTo:   TPoint;   
  begin   
      if   CanTerminate(GenPointFrom,   GenLength)   then   
      begin   //   �жϻ���   
          System.Exit;   
      end   
      else   
      begin   //   ������������   
         // Application.ProcessMessages();
          if   BranchWidth   >   2   then   Dec(BranchWidth,   2)   else   BranchWidth   :=   1;   
          if   BranchColor.g   <   222   then   Inc(BranchColor.g,   8)   else   BranchColor.g   :=   229;
          if   System.Random   >   PROBABILITY_THREASHOLD   then   
          begin     //   ����������   
              GenPointTo   :=   ToPoint(GenPointFrom,   GenLength,   GenAngle,   True);   
              b.Canvas.Pen.Width   :=   BranchWidth;
              b.Canvas.Pen.Color   :=   RGB(BranchColor.r,   BranchColor.g,   BranchColor.b);
              b.Canvas.MoveTo(GenPointFrom.X,   GenPointFrom.Y);
              b.Canvas.LineTo(GenPointTo.X,   GenPointTo.Y);
              DrawFractalTree(GenPointTo,   GenLength*BRANCH_RATIO,   GenAngle-GEN_ANGLE_DEVIATION,   BranchWidth,   BranchColor);
          end;   
          if   System.Random   >   PROBABILITY_THREASHOLD   then   
          begin     //   ����������   
              GenPointTo   :=   ToPoint(GenPointFrom,   GenLength,   GenAngle,   False);   
              b.Canvas.Pen.Width   :=   BranchWidth;
              b.Canvas.Pen.Color   :=   RGB(BranchColor.r,   BranchColor.g,   BranchColor.b);
              b.Canvas.MoveTo(GenPointFrom.X,   GenPointFrom.Y);
              b.Canvas.LineTo(GenPointTo.X,   GenPointTo.Y);
              DrawFractalTree(GenPointTo,   GenLength*BRANCH_RATIO,   GenAngle+GEN_ANGLE_DEVIATION,   BranchWidth,   BranchColor);   
          end;   
      end;   
  end;
begin
      //����ӳ���ʾʱ�ȴ�ͼƬ����Ч
       FGenPointFrom.Y   :=   b.Height;
       FBranchColor.r   :=   45;   //
       FBranchColor.g   :=   45;   //
       FBranchColor.b   :=   45;   //
       if one then
        begin  //��һ����
          FGenLength   :=   b.Height   /   3.1;
         FGenPointFrom.X   :=   b.Width div 3;
       FBranchWidth   :=   Random(b.Width div 20)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
        end else begin //��5����
                   FGenLength   :=   b.Height   /   2.4;
       FGenPointFrom.X   :=   round(game_bmp_width  /   6);
       FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
      FGenPointFrom.X   :=   round(game_bmp_width  /   2.75);
      FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
     FGenPointFrom.X   :=   round(game_bmp_width  /   2);
     FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
      FGenPointFrom.X   :=   round(game_bmp_width  /   1.5);
      FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
     FGenPointFrom.X   :=   round(game_bmp_width  /   1.2);
     FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
                  end;
end;

procedure TForm_pop.after_check_asw(b: boolean);
begin
//��ѡ����һ������
 game_pic_check_area:= G_all_pic_n; //��ֹѡ��

 case game_pop_type of
   1: after_check_asw1(b);//�����ʣ�
   2: after_check_asw2(b);//�ڿ�
   3,4: after_check_asw3(b);//ս��������̨
   5: after_check_asw1(b);//�����ʣ�love
   6: begin
       //������
       if b then
       begin
        G_game_delay(500);
        g_dangqian_zhuangtai:= g_bubble;
        bubble_data1.sycs:= 2;
        show_ad(1);
       end
       else begin
             G_game_delay(1000);
             start_show_word(false);
             end;
      end;
  end;

end;

procedure TForm_pop.after_check_asw1(b: boolean);
begin
   //�����ʺ�������
  if b then
   begin
     //��ʾ��Ϣ
     show_text(true,
                    format('��ȷ�� ��� %d �ܼ� %d',[jit_num,game_pop_count+ jit_num]));
     G_game_delay(1000);
     tili_add_100; //��������
    if game_pop_count > 0 then
     begin
     dec(game_pop_count);
     inc(jit_num);
      start_show_word(false);
     end else begin
               self.ModalResult:= mrok;
              end;
   end else begin
             //��ʾ������Ϣ
              show_text(true,'��û�д�ԡ�');
             G_game_delay(2000);
             self.ModalResult:= mrcancel;
            end;
end;

procedure TForm_pop.after_check_asw2(b: boolean);
var i,j: integer;
    str1: Tstringlist;
    ss: string;
begin

  //�ڿ��������
  
    dec(game_kaoshi,3);

  if (not b) or (game_pop_count= 1000)  then
   begin
    if game_pop_count=200 then
     show_text(true,'��û�д�ԣ���ҩ������')
     else  if game_pop_count=300 then
     show_text(true,'��û�д�ԣ�����������')
     else if game_pop_count> 1000 then
     show_text(true,'���Դ���һ�⡣')
     else
       show_text(true,'��û�д�ԣ��ڿ������');

    G_game_delay(2000);
     if game_pop_count<= 1000 then
       begin  //С�ڵ���1000�ҵ��ʴ����˳�
       self.ModalResult:= mrcancel;
       exit;
       end;
   end;

      if game_pop_count=300 then
      begin
      show_text(false,'�ָ�����1%');
      end else if game_pop_count > 1000 then
       begin
        if b then
           show_text(false,'������ȷ'+ inttostr(Game_wakuan_zhengque_shu+ 1)+ '��ʣ��'+ inttostr(game_pop_count-1001) +'��');
       end  else  begin  //************************************
       show_text(false,'���Ӿ���ֵ5');

    str1:= Tstringlist.Create;
    if game_pop_count=200 then
     Data2.Load_file_upp(game_app_path_G+ 'dat\const_cy.upp',str1)
    else
     Data2.Load_file_upp(game_app_path_g+ 'dat\const.upp',str1);
  for i:= 0 to str1.Count- 1 do
   begin
    j:= fastcharpos(str1.Strings[i],'=',1);
    if j > 0 then
      begin
       ss:= copy(str1.Strings[i],1,j-1);
       if ss<> '' then
        begin
          if Trystrtoint(ss,j) then
            begin
             if Game_base_random(j)= 1 then
               begin
                ss:= str1.Values[ss];
                break;
               end else ss:= '';
            end else ss:= '';
        end;
      end;
   end;
  str1.Free;

     if ss<> '' then
      begin
       if gamesave1.tip5= 0 then
          play_sound(6);
          
       draw_text_17(ss+' �ڵ�һ',1000,clgreen,18);
       G_game_delay(2500);
      end else begin
           show_text(true,
                    format('ѡ����ȷ�� ��ǰ %d ��',[jit_num]));
                    show_ad(0);

            end;

  if ss<> '' then
    begin
     form1.game_goods_change_n(ss,1); //���Ӹ���Ʒ
    end;
                     end; //*************************************************
   G_game_delay(1000);
   G_show_result_b:= false;
 // dec(game_pop_count);
  inc(jit_num);
   show_text(false,'');

    if game_pop_count=300 then
    begin
    Form1.game_lingli_add(0,1);
    draw_game_role(-1);
    end else if b then
              begin
              form1.game_attribute_change(0,19,5); //ȫ�����Ӿ���ֵ5

              inc(Game_wakuan_zhengque_shu); //�ڿ���ȷ�ļ�һ
            if (Game_wakuan_zhengque_shu= 100) and (game_pop_count < 1000) then
              begin
                Game_wakuan_zhengque_shu:= 0;
                form1.game_attribute_change(0,19,1000); //ȫ�����Ӿ���ֵ1000
               show_text(false,
                    '��������ֵ1000');
              G_game_delay(1000);
              end;
               game_up_role; //��������
              end;
  G_show_result_b:= false;
  
    if game_pop_count> 1000 then
      dec(game_pop_count); //����1000����ʾ����

     if game_pop_count= 1000 then
      begin
      show_text(true,'���Խ�������ȷ'+ inttostr(Game_wakuan_zhengque_shu));
       G_game_delay(2000);
       self.ModalResult:= mrcancel;
      end else
           start_show_word(false);
end;

procedure TForm_pop.after_check_asw3(b: boolean);
begin
  //ս����������
  if b then
   show_text(true,'�ش���ȷ��')
   else
      show_text(true,'�����ˣ����Ӳ��������顣');

   if b then
    game_guai_xishu_f:= Game_base_random(6)+ 2 //�ش���ȷ�����7�ɹ���
    else
     game_guai_xishu_f:= Game_base_random(6)+ 10; //�ش����,�ֿ��ܳ�ˮƽ���ӣ�10-15�ɹ���
     
  G_game_delay(1000);
  guai_Attack(Fgame_guai_cu,game_guai_xishu_f); //���﹥��
end;

procedure TForm_pop.show_text(up: boolean; const s: string);
var
   bmp : TBitmap;
begin

  if s= '' then
   begin
    if up then
      g_show_text_up:= false
      else
       g_show_text_down:= false;
    exit;
   end;
 bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
        bmp.Canvas.Font.Name:='����';

           bmp.Width:=game_bmp_width;
           bmp.Height:=game_bmp_h2;
           bmp.Canvas.Font.Name:='����';
           bmp.Canvas.Font.Size:= 14;
           bmp.Canvas.Font.Color:= clwindow;
           bmp.Canvas.Brush.Style:= bsClear;
            bmp.Canvas.Brush.Color:=clwindowtext;
            bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));
            bmp.Canvas.TextOut(5, 8, s);
       if up then
        begin
          with image_up do
         begin

         LoadFromBitmap(bmp,true,0,0);
         end;

        g_show_text_up:= true;
        end else begin
                  with image_down do
         begin
         
         LoadFromBitmap(bmp,true,0,0);
         end;

           g_show_text_down:= true;
                 end;
      bmp.Free;

end;

procedure TForm_pop.show_text_hint(const s: string);
begin
  StatusBar1.Panels[0].Text:= s;
end;

procedure TForm_pop.draw_game_role(p: integer);
var i: integer;
begin
//����Ϊ-1����ʾȫ����ʾ��5����
//�����Ĳ�������ʾ����ָ��������������ʾ��ң���������
 if p= -1 then
  begin
   g_role_show1:= false;
   g_role_show2:= false;
   g_role_show3:= false;
   g_role_show4:= false;
   g_role_show5:= false;
   for i:= 0 to 4 do
     draw_game_role_base(i);

  end else begin
              draw_game_role_base(p);
           end;

end;

procedure TForm_pop.draw_game_role_base(p: integer); //��������ͼ��
var i,j: integer;
begin

j:= 0;
  for i:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(i,4)= 1 then
        inc(j);  //�������������ϳ����ˣ�ֻ�е���1�ģ��ż���

      if j = p + 1 then
       begin //��������
        if Assigned(Game_role_list.Items[i]) then
           draw_game_role_base2(p,Game_role_list.Items[i]);
        exit;
       end;
    end; //end for

end;
procedure M_bmp_bw(bmp: Tbitmap); //��ɫת�ڰ�
var
  p :PByteArray;
  Gray,x,y :Integer;
begin

  for y:=0 to Bmp.Height-1 do
  begin
    p:=Bmp.scanline[y];
    for x:=0 to Bmp.Width-1 do
    begin
      Gray:=Round(p[x*3+2]*0.3+p[x*3+1]*0.59+p[x*3]*0.11);
      p[x*3]:=Gray;
      p[x*3+1]:=Gray;
      p[x*3+2]:=Gray;
    end;
  end;


end;
procedure TForm_pop.draw_game_role_base2(p: integer; tpl: Tplayer);   //��������ͼ��
  const lt= 32;
var
      bmp : TBitmap;
      ss: string;
      i: integer;

begin
      if not Assigned(tpl) then
         exit;
      try
        if tpl.plvalues[ord(g_gdsmz27)]< 1 then
           tpl.plvalues[ord(g_gdsmz27)]:= 1;
        if tpl.plvalues[ord(g_gdtl25)]< 1 then
           tpl.plvalues[ord(g_gdtl25)]:= 1;
        if tpl.plvalues[ord(g_gdll26)]< 1 then
           tpl.plvalues[ord(g_gdll26)]:= 1;
      except
        exit;
      end;


      bmp:=TBitmap.Create;

      bmp.PixelFormat:=pf24bit;
      bmp.Width:=game_bmp_role_width;
      bmp.Height:=game_bmp_role_h;
      with bmp.Canvas do
       begin
      Font.Name:='����';
      Font.Size:= 9;
       

       if tpl.plvalues[ord(g_life)]> 0 then
          Brush.Color:=rgb(213,206,180)   //��������ɫ
          else begin
               Brush.Color:=rgb(255,255,255); //��ɫ�����󱳾�ɫ
               game_p_list[p]:= 0; //������ɫ���ٶ�Ϊ��
               end;
      FillRect(rect(0,0,game_bmp_role_width,game_bmp_role_h));
      data2.ImageList2.Draw(bmp.Canvas,33,0,tpl.plvalues[ord(g_Icon_index)]+ 1);
      //�ѵ�ǰ����ͼ�񿽱���һ��icon�ڣ����빥�����Դ�����
      Brush.Style:= bsClear;

      TextOut(3, 2, tpl.get_name_and_touxian);
      Pen.Mode:=pmCopy;
         Pen.Color:= clwhite;
         MoveTo(3,game_bmp_role_h);
         LineTo(3,game_bmp_role_h-lt);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h-lt);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h-lt);

        // ����ֵ
          if tpl.plvalues[ord(g_life)]<= 0 then
             begin
               Pen.Color:= clred;
               ss:= '״̬����������';
             end else if tpl.plvalues[ord(g_gdsmz27)]* 4 > tpl.plvalues[ord(g_life)]* 10 then
             begin
               Pen.Color:= clred;
               ss:= format('״̬������ |����ֵ��%d / %d',[tpl.plvalues[ord(g_life)],tpl.plvalues[ord(g_gdsmz27)]]);
             end else if tpl.plvalues[ord(g_gdsmz27)]* 7 > tpl.plvalues[ord(g_life)]* 10 then
                       begin
                        Pen.Color:= clyellow;
                        ss:= format('״̬��һ�� |����ֵ��%d / %d',[tpl.plvalues[ord(g_life)],tpl.plvalues[ord(g_gdsmz27)]]);
                       end else begin
                                 Pen.Color:= clgreen;
                                 ss:= format('״̬������ |����ֵ��%d / %d',[tpl.plvalues[ord(g_life)],tpl.plvalues[ord(g_gdsmz27)]]);
                                end;
          i:= round(tpl.plvalues[ord(g_life)] / tpl.plvalues[ord(g_gdsmz27)] * (lt-3))+3;
         if tpl.plvalues[ord(g_life)] > 0 then
          begin
          MoveTo(3,game_bmp_role_h);
         LineTo(3,game_bmp_role_h-i);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h-i);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h-i);
          end;
        // ����
          
          i:= round(tpl.plvalues[ord(g_tili)] / tpl.plvalues[ord(g_gdtl25)] * (lt-3))+3;

            ss:= ss + format(' |������%d / %d',[tpl.plvalues[ord(g_tili)],tpl.plvalues[ord(g_gdtl25)]]);
         if tpl.plvalues[ord(g_tili)]> 0 then
          begin
          Pen.Color:= clwhite;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-lt);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-lt);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-lt);
          Pen.Color:= clblue;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-i);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-i);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-i);
          end;
        // ����
          
          i:= round(tpl.plvalues[ord(g_lingli)] / tpl.plvalues[ord(g_gdll26)] * (lt-3))+3;
          if i<= 3 then
             i:= 3;

            ss:= ss + format(' |������%d / %d',[tpl.plvalues[ord(g_lingli)],tpl.plvalues[ord(g_gdll26)]]);
          if tpl.plvalues[ord(g_lingli)]> 0 then
          begin
          Pen.Color:= clwhite;
          MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-lt);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-lt);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-lt);
           Pen.Color:= clpurple;
           MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-i);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-i);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-i);
          end;
        end; //end with

          if tpl.plvalues[ord(g_life)]<= 0 then
             M_bmp_bw(bmp); //��ɫת�ڰ�

       case p of
          0: begin
                          with image_role1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          1: begin
                          with image_role2 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          2: begin
                          with image_role3 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          3: begin
                          with image_role4 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          4: begin
                          with image_role5 do
                           begin
                          
                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          end;
      bmp.Free;
       
      ss:= ss + format(' |�ٶȣ�%d |����%d',[tpl.plvalues[ord(g_speed)],tpl.plvalues[ord(g_defend)]]);
      g_hint_array_g[p]:= ss;
   case p of
    0: begin
        g_role_show1:= true;
      //  GLPlane10.Hint:= ss; //�����ʾ
       end;
    1: begin
        g_role_show2:= true;
       // GLPlane11.Hint:= ss;
       end;
    2: begin
        g_role_show3:= true;
       // GLPlane12.Hint:= ss;
       end;
    3: begin
        g_role_show4:= true;
      //  GLPlane13.Hint:= ss;
       end;
    4: begin
        g_role_show5:= true;
      //  GLPlane14.Hint:= ss;
       end;
    end;
end;

procedure TForm_pop.create_guai_list;
var
    ss,ss2: string;
    i,j: integer;

    function get_s: string;
     begin
      if pos(',',ss)> 0 then
       begin
       result:= copy(ss,1,pos(',',ss)-1);
       delete(ss,1, pos(',',ss));
       end else begin
             result:= ss;
             ss:= '';
            end;
     end;
     {

  Tgame_goods_type=(
  ����goods_name1,����goods_type1,����ֵgoods_f1,Ѫֵgoods_t1,
  ����ħ��goods_L1,����ֵgoods_s1,
  ������Ʒgoods_m1,�����Ǯgoods_g1,
  ������Ʒ��goods_z1,���������goods_y1,
  �ٶ�goods_n1,ͷ�����goods_j1,goods_ms1);
            }
    procedure set_guai(k: integer; const ss3: string);
    begin
       with net_guai_g[k] do
                 begin
                 sid:= g_nil_user_c- k -1; //���ùֵ�sidΪ�߶�
                 ming:= strtoint2(data2.get_game_goods_type_s(ss3,goods_t1));
                     if ming < 0 then
                        ming:= game_read_values(0,ord(g_attack))* ming * -1; //������
                     if Game_migong_xishu > 0 then
                       ming:= ming * Game_migong_xishu div 10;  //����Ѫϵ��

                 ti:= ming div 2; //������Ĭ��Ϊ������2
                 ling:= ming * 2; //����Ĭ��Ϊ������2
                 ming_gu:= ming;
                  if ming_gu<= 0 then
                     ming_gu:= 1;
                 ti_gu:= ti;
                   if ti_gu<= 0 then
                      ti_gu:= 1;
                   
                 ling_gu:= ling;
                  if ling_gu<= 0 then
                     ling_gu:= 1;

                 shu:= strtoint2(data2.get_game_goods_type_s(ss3,goods_n1));
                 gong:= strtoint2(data2.get_game_goods_type_s(ss3,goods_type1));
                         if Game_migong_xishu > 0 then
                          gong:= gong * Game_migong_xishu div 10;  //���﹥ϵ��
                 fang:= strtoint2(data2.get_game_goods_type_s(ss3,goods_F1));
                 L_fang:= 0;
                 end;
              with loc_guai_g[k] do
              begin
               name1:= data2.get_game_goods_type_s(ss3,goods_name1);
               fa_wu:= strtoint2(data2.get_game_goods_type_s(ss3,goods_L1));
               wu_shu:= net_guai_g[k].ming div 100; //Ĭ����Ʒ����Ϊ����100��֮һ
               wu_diao:= strtoint2(data2.get_game_goods_type_s(ss3,goods_m1));
               wu_diao_shu:= strtoint2(data2.get_game_goods_type_s(ss3,goods_z1));
               wu_diao_gai:= strtoint2(data2.get_game_goods_type_s(ss3,goods_y1));
               qian:= strtoint2(data2.get_game_goods_type_s(ss3,goods_g1));
               qian_diao_gai:= 1; //Ǯ���ʣ����ǵ�
               jingyan:= strtoint2(data2.get_game_goods_type_s(ss3,goods_s1));
                  if Game_migong_xishu > 0 then
                       jingyan:= jingyan * Game_migong_xishu div 10;  //��ֵ���ľ���
               icon:= strtoint2(data2.get_game_goods_type_s(ss3,goods_j1));
              end;
    end;
begin
        //���������б�
         zeromemory(@loc_guai_g,sizeof(T_loc_guai)* length(loc_guai_g));
         zeromemory(@net_guai_g,sizeof(Tnet_guai)* length(net_guai_g));
        for i:= 0 to 4 do
           net_guai_g[i].sid:= g_nil_user_c;


        if (game_monster_type< 0) or (game_monster_type > 10000) then
         begin
          //������������Ĺ�
          pk_zhihui_g.is_pk:= create_net_guai(game_monster_type); //ֻҪ����������Ĺִ����ˣ���ô�����Ƿ�pk����Ҫ����Ϊpk
          if pk_zhihui_g.is_pk then
              exit
              else
               game_monster_type:= 1; //�����������ֲ��ɹ�����ô����ָ����һ�������Ĺ�

         end;

           {�����������������ô�����Ѿ��˳������򣬼����������ع��ﵵ}

        if Game_guai_list_G.Count= 0 then
          data2.Load_file_upp(game_app_path_G+'dat\guai.upp',Game_guai_list_G);
        Assert(Game_guai_list_G.Count> 0,'�����ļ���Ч��');
        ss:= Game_guai_list_G.Values[inttostr(game_monster_type)];
        j:= pos('(',ss);
        if j > 0 then
        begin
          ss:= copy(ss,j+ 1,pos(')',ss)-j-1);
          j:= 0;
         for i:= 0 to game_pop_count - 1 do
          begin
            ss2:= ss;
            while length(ss2)> 0 do
             begin
              set_guai(j,Game_guai_list_G.Values[get_s]);

              inc(j);        
              if j= 5 then
               exit; //�������5��
             end; //end while
          end; //end for
        end else begin
                  for i:= 0 to game_pop_count - 1 do
                     begin
                       if i= 5 then
                        exit;  //�������5��

                         set_guai(i,ss);
                     end; //end for
                 end;
     


end;

procedure TForm_pop.draw_game_guai(p: integer); //�������-1����ȫ��
var i: integer;
begin

  if p= -1 then
  begin
   g_guai_show1:= false;
   g_guai_show2:= false;
   g_guai_show3:= false;
   g_guai_show4:= false;
   g_guai_show5:= false;
   for i:= 0 to 4 do
     draw_game_guai_base(i);

  end else begin
              draw_game_guai_base(p);
           end;
end;

procedure TForm_pop.draw_game_guai_base(p: integer);
const lt= 32;
var
      bmp : TBitmap;
      ss: string;
      i: integer;
begin
if p>= 5 then
   p:= p -5;

     if net_guai_g[p].ming<= 0 then
        begin
         game_p_list[p+5]:= 0; //�����ֵ��ٶ�Ϊ��
          case p of
          0: g_guai_show1:= false;
          1: g_guai_show2:= false;
          2: g_guai_show3:= false;
          3: g_guai_show4:= false;
          4: g_guai_show5:= false;
          end;
         exit;
        end; //��������

      bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
      bmp.Width:=game_bmp_role_width;
      bmp.Height:=game_bmp_role_h;

     with bmp.Canvas do    //��ֵ��ɫ
       begin
           Pen.Color:= clwhite;
          MoveTo(3,game_bmp_role_h);
         LineTo(3,game_bmp_role_h-lt);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h-lt);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h-lt);
       end;
        // ����ֵ
          if net_guai_g[p].ming_gu* 4 > net_guai_g[p].ming * 10 then
             begin
               bmp.Canvas.Pen.Color:= clred;
               ss:= format('������� |����ֵ��%d / %d',[net_guai_g[p].ming,net_guai_g[p].ming_gu]);
             end else if net_guai_g[p].ming_gu* 7 > net_guai_g[p].ming* 10 then
                       begin
                        bmp.Canvas.Pen.Color:= clyellow;
                        ss:= format('���һ�� |����ֵ��%d / %d',[net_guai_g[p].ming,net_guai_g[p].ming_gu]);
                       end else begin
                                 bmp.Canvas.Pen.Color:= clgreen;
                                 ss:= format('���ǿ׳ |����ֵ��%d / %d',[net_guai_g[p].ming,net_guai_g[p].ming_gu]);
                                end;

          ss:= ss + format(' |�ٶȣ�%d |����%d',[game_get_guai_su(p),net_guai_g[p].fang]);

          i:= round(net_guai_g[p].ming / net_guai_g[p].ming_gu * (lt-3))+3;

     with bmp.Canvas do
       begin
      Font.Name:='����';
      Font.Size:= 10;
      //Brush.Color:=rgb(213,206,180);   //������������ɫ
      FillRect(rect(0,0,game_bmp_role_width,game_bmp_role_h));

      if loc_guai_g[p].icon > 0 then
          data2.ImageList2.Draw(bmp.Canvas,33,0,loc_guai_g[p].icon + 1);

      Brush.Style:= bsClear;
      TextOut(3, 2, loc_guai_g[p].name1);
      
          MoveTo(3,game_bmp_role_h);  //������
         LineTo(3,game_bmp_role_h -i);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h -i);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h -i);

         //���������

        // ����

          i:= round(net_guai_g[p].ti / net_guai_g[p].ti_gu * (lt-3))+3;

           // ss:= ss + format(' |������%d / %d',[tpl.plvalues[ord(g_tili)],tpl.plvalues[ord(g_gdtl25)]]);

          Pen.Color:= clwhite;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-lt);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-lt);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-lt);
          Pen.Color:= clblue;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-i);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-i);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-i);

        // ����
          
          i:= round(net_guai_g[p].ling / net_guai_g[p].ling_gu * (lt-3))+3;

           // ss:= ss + format(' |������%d / %d',[tpl.plvalues[ord(g_lingli)],tpl.plvalues[ord(g_gdll26)]]);

          Pen.Color:= clwhite;
          MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-lt);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-lt);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-lt);
           Pen.Color:= clpurple;
           MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-i);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-i);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-i);
       end;

         case p of
          0: begin
                          with image_guai1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          1: begin
                          with image_guai2 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          2: begin
                          with image_guai3 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          3: begin
                          with image_guai4 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          4: begin
                          with image_guai5 do
                           begin
                          
                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          end;
      // GLMaterialLibrary1.Materials.Items[p+ 4].Material.Texture.image.Assign(bmp);
      bmp.Free;
    g_hint_array_g[p+ 5]:= ss; //�����ʾ
   case p of
    0: begin
        g_guai_show1:= true;
       // GLPlane5.Hint:= ss;  //�����ʾ
       end;
    1: begin
        g_guai_show2:= true;
      //  GLPlane6.Hint:= ss;
       end;
    2: begin
        g_guai_show3:= true;
       // GLPlane7.Hint:= ss;
       end;
    3: begin
        g_guai_show4:= true;
      //  GLPlane8.Hint:= ss;
       end;
    4: begin
        g_guai_show5:= true;
      //  GLPlane9.Hint:= ss;
       end;
    end;

end;

procedure TForm_pop.game_star_fight_message(var msg: TMessage);  //����ս��
var b: boolean;
begin
game_musmv_ready:= false;
time_list1.Timer_donghua:= false;

  if (msg.WParam<> 6) or (msg.LParam<> 6) then
    begin
     if msg.LParam= 8 then
        start_show_word(false);

     exit;
    end;
   b:= (Random(2)= 1);
  //����һ��ս����������
  // boll_show(b);

  if b then
   begin
   g_wo_guai_dangqian:= Fgame_my_cu;
   show_text(true,'�������÷�������Ʒ���߹���');
   G_dangqian_zhuangtai:=G_chelue;
   //groupbox3.Visible:= true;
   g_gong.weizhi.Top:= 165;
   g_gong.weizhi.Left:= 640-180;
   g_gong.time:= game_amt_length;

   time_list1.timer_gong:= true;
   //reshow_su; //����ǡ�������������ʾ
   show_text(true,'');
   //show_text(false,'���ҵġ�');
   highlight_my(Fgame_my_cu);
   end else begin
              g_wo_guai_dangqian:= 5;
              show_text(true,'���ܴ�ԣ���ֻʹ2-8�ɹ���');
              show_text(false,'');
             G_dangqian_zhuangtai:=G_word;
             g_gong.xianshi:= false;
             groupbox3.Visible:= false;
             time_list1.Timer_gong:= false;
             highlight_guai(Fgame_guai_cu);  //����
             start_show_word(false);
            end;
  game_musmv_ready:= true;
  write_label2_11; //ˢ������
end;

function get_min_guai_f: integer;  //��ȡһ��Ѫֵ��͵Ĺ�
var i,j: integer;
    function min_guai(a,b: integer): integer;
     begin
       if net_guai_g[a].ming> net_guai_g[b].ming then
        begin
         if net_guai_g[b].ming= 0 then
          result:= a
           else result:= b;

        end else  begin
                    if net_guai_g[a].ming= 0 then
                       result:= b
                       else
                        result:= a;
                  end;

     end;
begin
   j:= -1;
     for i:= 0 to 3 do //�����֣��ҳ�Ѫֵ��͵ġ�
        begin
         if j= -1 then
           j:= min_guai(i,i+1)
           else
            j:= min_guai(j,i+1);
        end;
   result:= j;
end;

procedure TForm_pop.guai_Attack(t,z: integer); //���﹥��������Ϊ�����ţ�����ָ��
var g,g_mofa: integer; //���������ţ�-1��ʾȫ��,g2Ϊ���ʾ������������ֵ��ʾ��������
    b: boolean;
begin
  //
  {
   1���Զ�ѡ��һ�������������ȫ�幥��
   2���������ﱾ��ͱ�������
   3�����Ŷ���
   4���۳���������Ѫ��
   5��ȥ���������ػ�
   6���жϽ��
  }
  if t>= 5 then
     t:= t-5;
  b:= false; //�Ƿ�����Լ�
  game_guai_escape:= false; //��ʼ��Ϊ����û������
g:= 0;


   //highlight_guai(t);  //�������ڹ���ǰ���Ѿ�������



       // ѡ�񹥻���ʽ��ȷ��Ҫ����id
       g_mofa:= loc_guai_g[t].fa_wu;
      if g_mofa > 0 then //�������ʾ�˹ֻ�ħ������һ������ʹ��ħ��
       begin
        if Game_base_random(4)= 1 then
           begin
            //���ݷ���������Ʒ����������Ⱥ����������Ⱥ�ָ������ָ�
              case data2.get_game_goods_type(g_mofa,goods_type1) of
                2:   begin  //�ָ�
                      g:= get_min_guai_f;
                      b:= true;
                     end;
                4:   begin   //����
                       g:= get_r_role_id;
                     end;
                128: begin    //����
                      if data2.get_game_goods_type(g_mofa,goods_j1)=1 then
                         begin  //����
                          if data2.get_game_goods_type(g_mofa,goods_y1)=1 then  //Ϊһ��ʾ����
                            g:= get_r_role_id
                            else  g:= -1;
                         end else begin  //�ָ�
                                   if data2.get_game_goods_type(g_mofa,goods_y1)=1 then
                                      g:= get_min_guai_f
                                      else  g:= -1;
                                      b:= true;
                                  end;
                     end;
                256: begin    //��ǿ
                       g:= get_min_guai_f;
                       b:= true;
                     end;
                end;

           end else begin
                      g:= get_r_role_id;
                      g_mofa:= 0;
                     end;
       end else begin
                  g:= get_r_role_id;
                  mtl_game_cmd_dh1.wu:= 0;
                  if g_mofa < 0 then //С�����ʾ�˹ֻ�����
                    begin
                     if Game_base_random(abs(g_mofa))=1 then
                       begin
                        loc_guai_g[t].wu_diao:= 0; //���ܵ�û�ж�������
                        loc_guai_g[t].qian:= 0;
                        net_guai_g[t].ming:= 0;
                        net_guai_g[t].shu:= 0;
                        game_p_list[t+5]:= 0;
                        show_text(true,'����');
                          draw_game_guai(t);
                        game_guai_escape:= true; //�����Ѿ�����
                        G_game_delay(800);
                        g_guai_A_next;  //���빥�����������������
                        exit;
                       end;
                    end;
                end;
   


      //����Ʒ��ʱ����ʹ�õı�����0-4���ҷ����5-9���з�����
         if b and (g<> -1) then
          g:= g+ 5;


   application.ProcessMessages;

       { //�趨��Ѫ����
        sid_to_roleId(mtl_game_cmd_dh1.fq_sid):= t;
        sid_to_roleId(mtl_game_cmd_dh1.js_sid):= g;
        g_sub_boold_array_G[2]:= z;
        g_sub_boold_array_G[3]:= g2;  }

        //�趨���﹥����
          gong_js(t+5, g,g_mofa,true);  //����ֵĹ����������úùֲ���

          //���Ŷ���
        game_Animation(false,t,g,g_mofa); //���¹������ֱ�ţ��������߱�ţ���������

        //���������󣬶�ʱ��������ת�붯����������  g_guai_A_next

end;

function TForm_pop.game_p_list_ex: integer;   //�ٶȣ�������ֵ�������ٶ���ߵı��
var i: integer;
    t: Tplayer;
begin
    //�ٶȵ��ۼ����ٶ�ͳ�ƶ�ʱ���ڽ��У�20��ʱ��ֹ
  //0--4���ҷ���ţ�5--9���з����
result:= 0;

  for i:= 0 to 9 do
   begin
     if game_p_list[i] > game_p_list[result] then
       result:= i;
   end; //end for i

       if (result= 0) and (game_p_list[result]= 0) then
          begin
            //�쳣����ٶȶ�Ϊ��  ��ô�ж�һ���Ƿ���Ϸ��Ҫ������
           result:= -1;
           exit;
          end
          else
           game_p_list[result]:= 0; //�������ģ�������
      if result > 4 then
       begin
       if net_guai_g[result-5].ming= 0 then
          result:= game_p_list_ex;
       end else begin
                 t:= game_get_role_from_i(result);
                 if t<>nil then
                    if t.plvalues[ord(g_life)]<= 0 then
                       result:= game_p_list_ex;
                end;
end;

function TForm_pop.game_get_role_from_i(i: integer): Tplayer; //�����ϳ�����ı�����������ʵ��
var j,k: integer;
begin
k:= 0;
result:= nil;
  for j:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(j,4)= 1 then
        inc(k);  //�������������ϳ����ˣ�ֻ�е���1�ģ��ż���

      if k = i + 1 then
       begin
        result:= Tplayer(Game_role_list.Items[j]);
        exit;
       end;
    end;

end;

function TForm_pop.game_get_role_su(i: integer): integer; //�����ϳ���������ȡ�����ٶ�
var t: Tplayer;
    k: Tmtl_rec;
begin
result:= 0;

  t:= game_get_role_from_i(i);

  if t<> nil then
    if t.plvalues[ord(g_life)]> 0 then //�Ѿ������Ľ�ɫ�ٶȲ��ۼ�
        result:= t.plvalues[2];
 if result> 0 then
  begin
   //͸����Ʒ��ʱ�������������Ƿ���ƫ��ֵ��
    //��һ�����������0-4�ҷ���5-9�з����ڶ���������1=�ˣ�2=�١�3=����4��
    k:= game_return_filter(i,1);
   result:= result + k.l.Hi;
   if result< 0 then
      result:= 0;
  end;
end;

function TForm_pop.game_get_guai_su(i: integer): integer; //�����ϳ���������ȡ�����ٶ�
var k: Tmtl_rec;
begin

   //guai_lifeblood1: array[0..4] of integer;  //����Ѫֵ
   //    guai_list1: array[0..4] of string; //�����б�
    result:= 0;
   if i > 4 then
     i:= i-5;

   if (net_guai_g[i].shu > 0) and (net_guai_g[i].ming > 0) then
    result:= net_guai_g[i].shu;
      

  if result> 0 then
  begin
   //͸����Ʒ��ʱ�������������Ƿ���ƫ��ֵ��
    //��һ�����������0-4�ҷ���5-9�з����ڶ���������1=�ˣ�2=�١�3=����4��
    k:= game_return_filter(i+ 5,1);
   result:= result +  k.l.Hi;
   if result< 0 then
      result:= 0;
  end;

end;

procedure TForm_pop.My_Attack(m,p, d: integer);
begin
     //�ҷ�����������Ϊ�����ߣ�����id�͹�����ʽ��0Ϊ��ͨ����������ֵΪ������������
     //����id-1����ʾ��������ȫ��
     //�������̣����ݶԷ��ķ�ֵ����ȥ���ʵ�Ѫֵ
    {
    ��������������
    1���������˺ͱ���������
    2�����Ŷ���
    3���۳�������������������
    4���۳��Է�Ѫ��
    5��ȥ������ ���ػ�
    6���жϽ��
    }



    //�����Ѫ����
     if p<> -1 then
        p:= p + 5;
     gong_js(m, p,d,false); //�ҷ������������������������������Ϊ �����ߣ��������ߣ��������ͣ�




          //���Ŷ���
        if d> 0 then
         begin
          if data2.get_game_goods_type(d,goods_z1)= 3 then //������
            g_miao_shou(p, d)
          else
            game_Animation(true,m,p,d);
         end else
               game_Animation(true,m,p,d); //���¹������ֱ�ţ��������߱�ţ���������

        //������Ϻ󣬶�ʱ����������ת�붯������ g_wo_a_next �жϽ�����ػ���Ա��




end;

procedure TForm_pop.highlight_guai(id: integer); //����ָ�����-1,����ȫ��
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       highlight_guai_base(i);

   end else highlight_guai_base(id);
end;

procedure TForm_pop.highlight_guai_base(id: integer);
begin
  if (id= 0) then
   G_guai_jialiang1:= true
   else if (id= 1) then
   G_guai_jialiang2:= true
   else if (id= 2) then
   G_guai_jialiang3:= true
   else if (id= 3) then
   G_guai_jialiang4:= true
   else if (id= 4) then
   G_guai_jialiang5:= true;

end;

procedure TForm_pop.un_highlight_guai(id: integer); //�ָ�����ָ�����-1,�ظ�����ȫ��
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       un_highlight_guai_base(i);

   end else un_highlight_guai_base(id);

end;

procedure TForm_pop.un_highlight_guai_base(id: integer);
begin

  if (id= 0) then
   G_guai_jialiang1:= false
   else if (id= 1) then
   G_guai_jialiang2:= false
   else if (id= 2) then
   G_guai_jialiang3:= false
   else if (id= 3) then
   G_guai_jialiang4:= false
   else if (id= 4) then
   G_guai_jialiang5:= false;

end;

procedure TForm_pop.highlight_my(id: integer);
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       highlight_my_base(i);

   end else highlight_my_base(id);

end;

procedure TForm_pop.highlight_my_base(id: integer);
begin
  if (id= 0) then
   g_role_jialiang1:= true
   else if (id= 1) then
   g_role_jialiang2:= true
   else if (id= 2) then
   g_role_jialiang3:= true
   else if (id= 3) then
   g_role_jialiang4:= true
   else if (id= 4) then
   g_role_jialiang5:= true;
end;

procedure TForm_pop.un_highlight_my(id: integer);
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       un_highlight_my_base(i);

   end else un_highlight_my_base(id);

end;

procedure TForm_pop.un_highlight_my_base(id: integer);
begin
   if (id= 0) then
   g_role_jialiang1:= false
   else if (id= 1) then
   g_role_jialiang2:= false
   else if (id= 2) then
   g_role_jialiang3:= false
   else if (id= 3) then
   g_role_jialiang4:= false
   else if (id= 4) then
   g_role_jialiang5:= false;
end;
            {ͨ���ϳ�id 0--4 ������������б��ڵı�ţ���Ϊ�в��ϳ�����Ĵ��ڣ�����Ҫ������}
function TForm_pop.get_pid_from_showId(i: integer): integer;
var j,k: integer;
begin
k:= 0;
result:= -1;

if i= -1 then
 begin
   //-1��ֱ�ӷ��أ��������ж�
 exit;
 end;

  for j:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(j,4)= 1 then
        inc(k);  //�������������ϳ����ˣ�ֻ�е���1�ģ��ż���

      if k = i + 1 then
       begin
        result:= j;
        exit;
       end;
    end;

end;

function TForm_pop.get_r_role_id: integer; //���һ������ϳ������id
var j,k,m: integer;
    label pp;
begin

   k:= get_r_role_all_count; //��ȡȫ���ϳ�������

m:= 0;

     pp:
   result:= Random(k);  //ȡ��һ�����id
   inc(m);
   if m > 100 then
    begin
     result:= 0;
     exit; //�˳���ѭ��
    end;

      j:= get_pid_from_showId(result); //�����ϳ�id���ʵ��id
      if j= -1 then
        goto pp;
        
    if game_read_values(j,ord(g_life))<= 0 then
        goto pp; //����˽�ɫ�������������ѡ��

end;

procedure TForm_pop.game_Animation(up: boolean; p1, p2, p3: integer);
var ss: string;
    c1: Tcolor;
    i,fq1,js1: integer;
    function shezhi_fx:boolean;
     var j,g2,w2: integer;
     begin
      g2:= 0;
      w2:= 0;
       for j := 0 to 4 do
         begin
          if net_guai_g[j].sid= mtl_game_cmd_dh1.fq_sid then
             g2:= 1
              else if net_guai_g[j].sid= mtl_game_cmd_dh1.js_sid then
                       w2:= 1;

         end;
       for j := 0 to 4 do
         begin
          if game_player_head_G.duiyuan[j]= mtl_game_cmd_dh1.fq_sid then
             g2:= 2
              else if net_guai_g[j].sid= mtl_game_cmd_dh1.js_sid then
                       w2:= 2;

         end;
       result:= w2 > g2;
     end;
begin
        //��������up��ʾ�ҷ���ֹ���
        //p123��ʾ�������߱�ţ��������߱�ţ���Ϊ�ϳ���ʾ��ţ����������ͣ�0��ʾ������
     g_gong.xianshi:= false;
     groupbox3.Visible:= false;
     // g_show_text_up:= false;
     //g_show_text_down:= false;
     { if p3= 0 then
       begin
        show_text(not up,'����');
       end else begin
                ss:= data2.get_goods_all_s(p3);
                show_text(not up,data2.get_game_goods_type_s(ss,goods_name1));
                end;   }
        {
        �������� ���� mtl_game_cmd_dh1  ��ֵ���¶������  �������̵Ĳ���
        Ȼ�����跢����������
        ������Ϻ����豻��������������
        }

        Timer_auto_attack.Enabled:= false; //�Զ�����ֹͣ
        g_auto_attack:= 0;
        game_pic_check_area:= G_all_Pic_n; //ȫ��gl�����ֹѡ��


         fq1:= sid_to_roleId(mtl_game_cmd_dh1.fq_sid);
         js1:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);


        p1:= sid_to_roleId(mtl_game_cmd_dh1.fq_sid);   //mtl�����ڵ�ֵ��s_id,��ת��
        // p2:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);   //�����roleid�ǰ���Ļ�������
           if mtl_game_cmd_dh1.wu > 1023 then
              mtl_game_cmd_dh1.wu := 0;
              
          p3:= mtl_game_cmd_dh1.wu;  //����������
        if game_at_net_g then
         begin
           //�����������Ϸ����ô��Ҫ�����趨up��ֵ
           up:= shezhi_fx;
         end;

        if fq1>= 5 then
          highlight_guai(fq1-5)
          else
            highlight_my(fq1); //��������

         if js1>= 5 then
          highlight_guai(js1-5)
          else if js1= -1 then
                begin
                 if up then
                   highlight_guai(js1)
                   else
                     highlight_my(js1);
                end else
                 highlight_my(js1); //��������

         //���跢�𷽵�����ֵ****************************************
        if game_at_net_g then
         begin
           //�����������Ϸ���������÷��������ֵ
           if mtl_game_cmd_dh1.fq_sid= my_s_id_g then
             begin
              game_write_values(0,8,mtl_game_cmd_dh1.fq_m);
              game_write_values(0,5,mtl_game_cmd_dh1.fq_t);
              game_write_values(0,6,mtl_game_cmd_dh1.fq_l);
             end else begin
                        for i := 0 to 4 do
                          begin
                            if net_guai_g[i].sid= mtl_game_cmd_dh1.fq_sid then
                               begin
                                net_guai_g[i].ming:= mtl_game_cmd_dh1.fq_m;
                                net_guai_g[i].ti:= mtl_game_cmd_dh1.fq_t;
                                net_guai_g[i].ling:= mtl_game_cmd_dh1.fq_l;
                                 break;
                               end;
                          end;
                        for I := 0 to 4 do
                          begin
                            if game_read_values(get_pid_from_showId(i),34)= mtl_game_cmd_dh1.fq_sid then
                               begin
                                game_at_net_g:= false; //����Ϊfalse��׼���������������ֵ
                                game_write_values(get_pid_from_showId(i),8,mtl_game_cmd_dh1.fq_m);
                                game_write_values(get_pid_from_showId(i),5,mtl_game_cmd_dh1.fq_t);
                                game_write_values(get_pid_from_showId(i),6,mtl_game_cmd_dh1.fq_l);
                                 game_at_net_g:= true;
                                 break;
                               end;
                          end;
                      end;
           
         end else begin
                   //����ǵ�������ô����up��ֵ��ȷ�������������ֵ
                    if up then
                     begin
                      //�ҷ��ǹ�����
                      game_write_values(get_pid_from_showId(p1),8,mtl_game_cmd_dh1.fq_m);
                      game_write_values(get_pid_from_showId(p1),5,mtl_game_cmd_dh1.fq_t);
                      game_write_values(get_pid_from_showId(p1),6,mtl_game_cmd_dh1.fq_l);
                     end else begin
                                //���ǹ�����
                                if p1> 4 then
                                  dec(p1,5);
                                net_guai_g[p1].ming:= mtl_game_cmd_dh1.fq_m;
                                net_guai_g[p1].ti:= mtl_game_cmd_dh1.fq_t;
                                net_guai_g[p1].ling:= mtl_game_cmd_dh1.fq_l;
                              end;
                  end;

         //���跢�𷽵�����ֵ****************************************����

      show_text(true,'');
      show_text(false,'');
     if up then
      c1:= clblue
       else
        c1:= clblack;
     if p3= 0 then
      begin
      i:= 1001;
      ss:= '';
      end else begin
                ss:= data2.get_goods_all_s(p3);
                i:= strtoint2(data2.get_game_goods_type_s(ss,goods_type1));
                 if i and 2= 2 then
                   i:= 1004
                    else if i and 4= 4 then
                     i:= 1003
                      else if i and 128 = 128 then
                        begin
                          if strtoint2(data2.get_game_goods_type_s(ss,goods_j1))= 0 then
                             i:= 1005
                             else
                              i:= 1012;
                        end;

                 ss:= data2.get_game_goods_type_s(ss,goods_name1);

               end;
   {
          flag
          1000 ��Ч��
          1001  ����
          1002  ����
          1003  ģ��
          1004  ����
          1005  ��͸��
          1006  ����δ�ã�

         }

       if ss<> '' then
         draw_text_17(ss,i,c1);

  game_musmv_ready:= false;

   g_dangqian_zhuangtai:= G_animation; //��Ϸ���ڶ���״̬


   if mtl_game_cmd_dh1.flag= 8 then
      begin
       draw_text_17('Miss',1000,clmaroon,18);
       G_game_delay(1000);
       G_show_result_b:= false;
        un_highlight_my(-1);  //�ָ�����
        un_highlight_guai(-1);
        game_fight_result_adv; //�жϽ��
        mtl_game_cmd_dh1.flag:= 0;
      end else begin
               case i of
                1001: game_Animation_base1(up);
                1012: game_Animation_base2(up);
                1003: game_Animation_base3(up);
                1004: game_Animation_base4(up);
                1005: game_Animation_base5(up);
               end;
              end;
   game_musmv_ready:= true;

end;

procedure TForm_pop.game_blood_add_one; //ս��������������ɫѪ��ָ�Ϊһ
var j: integer;

begin

  for j:= 0 to Game_role_list.Count-1 do
      if game_read_values(j,ord(g_life))<= 0 then
         game_write_values(j,ord(g_life),1);



end;

function GetWinDir: string;
var
dir: array [0..MAX_PATH] of Char;
begin
GetWindowsDirectory(dir, MAX_PATH);
Result := StrPas(dir);
end;

function GetSystemDir: string;
var
dir: array [0..MAX_PATH] of Char;
begin
GetSystemDirectory(dir, MAX_PATH);
Result := StrPas(dir);
end;

function TForm_pop.game_can_spvoice1: boolean;
var Reg: TRegistry;
   ss: string;
begin

result:= false;

  Reg := TRegistry.Create;
    with Reg do
     begin
    RootKey := HKEY_LOCAL_MACHINE;
    if KeyExists('SOFTWARE\Classes\CLSID\{96749377-3391-11D2-9ee3-00c04f797396}\InProcServer32') then
      begin
       if OpenKeyReadOnly('SOFTWARE\Classes\CLSID\{96749377-3391-11D2-9ee3-00c04f797396}\InProcServer32') then
        begin
        ss:= readstring('');
        if pos('%',ss)>0 then
         begin
           delete(ss,1,pos('%',ss));
           delete(ss,1,pos('%',ss));
           if pos('ystem',ss)>0 then
             ss:= GetWinDir+ ss
             else
               ss:= GetSystemDir+ ss;
         end;
        if FileExists(ss) then
           result:= true;
        closekey;
        end;
      end;
    Free;
    end;

end;

function TForm_pop.game_fight_result: integer;  //�ж�ս�����,result:= 1 //�ҷ�����
var i,j: integer;
    b1,b2: boolean;
begin
 if button14.Tag=1 then
  begin
    result:= 2;
    exit; //���ԣ�ֱ��ʤ��
  end;

b1:= false;
b2:= false;
   for i:= 0 to 4 do
    begin
     if net_guai_g[i].ming > 0 then
        b1:= true;
        j:= get_pid_from_showId(i);
        if j>= 0 then
         if game_read_values(j,ord(g_life))> 0 then
           b2:= true;
    end; //end for

    if b1 and b2 then
    result:= 0
     else if b1 then
          result:= 1 //�ҷ�����
           else result:= 2; //��������
end;

procedure TForm_pop.game_guai_Attack_blood;   //�ֹ������۳��ҷ�Ѫֵ
    procedure blood2(t: integer); //��Ƕ���̣��ҷ���ţ����﹥����
      var p: Tplayer;
      begin
         p:= game_get_role_from_i(t);
         if p= nil then
           exit;

            if p.plvalues[ord(g_life)]= 0 then
               exit;  //�Ѿ�������ɫ�˳�ֵƮ��


             p.plvalues[ord(g_linshifang)]:= 1; //ÿ��ʹ�ú���ʱ����ϵ������



               //�˺�ֵ��Ʈ��
              //�˺�ֵ��Ʈ����Ʈ������false���£�Ʈ����ֵ������id�����ͣ�1Ѫ������������������
              
                 game_show_blood(true,mtl_game_cmd_dh1.js_m,t,1);
                 p.plvalues[ord(g_life)]:=  p.plvalues[ord(g_life)] +mtl_game_cmd_dh1.js_m;

                 //�������� ********************************************
                 if p.plvalues[ord(g_life)] <= 0 then
               begin
                p.plvalues[ord(g_life)]:= 0; //Ѫֵ���Ϊ��
                if gamesave1.tip5= 0 then
                 begin
                  if p.plvalues[ord(g_sex)]= 0 then
                     play_sound(11)
                     else
                      play_sound(10); //�е���������
                 end;
               end else begin
                          if (game_guai_fanghu_xishu_f<= 10) and (mtl_game_cmd_dh1.js_m < 0) then
                          begin
                           if gamesave1.tip6= 0 then
                            begin
                             if p.plvalues[ord(g_sex)]= 0 then
                                play_sound(13)
                                else
                                 play_sound(12); //�еı�����
                            end;
                          end;
                        end;
               //�������� ����������������������������������������������������������������

               if mtl_game_cmd_dh1.js_t<> 0 then
                begin
                 G_game_delay(500);
                 game_show_blood(true,mtl_game_cmd_dh1.js_t,t,2);
               end;
               
              if mtl_game_cmd_dh1.js_l<> 0 then
              begin
              G_game_delay(500);
              game_show_blood(true,mtl_game_cmd_dh1.js_l,t,3);
              end;

             p.plvalues[ord(g_tili)]:=  p.plvalues[ord(g_tili)] +mtl_game_cmd_dh1.js_t;
             p.plvalues[ord(g_lingli)]:=  p.plvalues[ord(g_lingli)] +mtl_game_cmd_dh1.js_l;
               if p.plvalues[ord(g_tili)]< 0 then
                  p.plvalues[ord(g_tili)]:= 0;
               if p.plvalues[ord(g_lingli)]< 0 then
                  p.plvalues[ord(g_lingli)]:= 0;



      end;
var i,t2: integer;
begin
    //���ֹ�����۳��ҷ�Ѫ��
    //t1���ֱ�ţ�t2,�ҷ����-1����ʾȫ�壬t3������������ָ���͹��������������

   t2:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);
   if t2 >= 5 then
      t2:= t2 -5;

  if t2= -1 then
   begin
    for i:= 0 to 4 do
        blood2(i);

   end else blood2(t2);

end;

function TForm_pop.game_get_Attack_value(z1, z2: integer): Tmtl_rec; //��ȡ��ǰ�ֵĹ�����
var i,j,m: integer;
    k: Tmtl_rec;
    b: boolean;

begin
      //���ݹ���ָ���͹������ͷ��ع�����
      //����������Ǳ��ع�ʹ�ã���Ϊ����֣�Ҳ���ǶԷ�����ʵ���ˣ���������õ��������
 result.m.int:= 0;
 result.t.int:= 0;
 result.l.int:= 0;
  b:= false;

     mtl_game_cmd_dh1.fq_m:= net_guai_g[Fgame_guai_cu].ming;
      mtl_game_cmd_dh1.fq_t:= net_guai_g[Fgame_guai_cu].ti;
      mtl_game_cmd_dh1.fq_l:= word(net_guai_g[Fgame_guai_cu].ling);

      if z2<= 0 then
       begin
         //������,��ȡ��ǰ�ֵĹ�����
         i:= net_guai_g[Fgame_guai_cu].gong;
         if i < 0 then //������Ϊ����ʱ����ֵ����10 ������������ֵ
            i:= i * game_read_values(0,ord(g_gdsmz27)) div 10;

         result.m.lo:= i;
       end else begin
                  //�ж��Ƿ���������������Ʒ����
                  b:= true;
                  i:= data2.get_game_goods_type(z2,goods_type1); //ȡ������
               if i and 128= 128 then
                begin
                 //������ֱ�ӵõ�����ֵ
                // result:= data2.get_game_goods_type(z2,goods_m1) * z1 div 10;
                  //�۳�������ȡ��������ֵ
                   j:= data2.get_game_goods_type(z2,goods_L1);
                   if j > mtl_game_cmd_dh1.fq_l then
                      mtl_game_cmd_dh1.fq_l:= 0
                      else
                        mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- j;


                 //������ֱ�ӵõ���Ѫֵ
                 result.m.Lo:= data2.get_game_goods_type(z2,goods_m1);  //��
                 result.t.Lo:= data2.get_game_goods_type(z2,goods_t1);   //��
                 result.m.Hi:= data2.get_game_goods_type(z2,goods_g1);   //��
                 result.t.Hi:= data2.get_game_goods_type(z2,goods_z1);   //��
                 result.l.Hi:= data2.get_game_goods_type(z2,goods_s1);   //��
                end else if (i and 4= 4) or (i and 2= 2) or (i and 256= 256) then
                          begin

                            //�۳���Ʒ����
                             if loc_guai_g[Fgame_guai_cu].wu_shu<= 0 then
                                exit;
                             loc_guai_g[Fgame_guai_cu].wu_shu:= loc_guai_g[Fgame_guai_cu].wu_shu-1;
                            //��������Ʒ��������ֱ�ӹ���ֵ�⣬��Ҫ��ʱ
                                m:= net_guai_g[Fgame_guai_cu].shu + 1;
                                m:= round((game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_defend))
                                          /m+1) * 10);
                              if Random(m)> 10 then
                                begin
                                   //������� �ҷ�������ԶԷ��ٶȵ�ϵ���������ҷ����������ã��Է�Ͷ��ʧ��
                                   mtl_game_cmd_dh1.flag:= 8; //���������
                                  exit;
                                end;

                             {����}
                            m:= data2.get_game_goods_type(z2,goods_m1);
                               if (m<> game_m_quan) then
                                 m:= game_read_values(0,ord(g_gdsmz27));
                               if (m<>game_m_ban) then
                                 m:= game_read_values(0,ord(g_gdsmz27)) div 2;
                              result.m.lo:= m;
                              {���� ����ʱ������Ч}
                            // result.m.Hi:= data2.get_game_goods_type(z2,goods_g1);
                              {����������ʱ������Ч}
                            //  result.t.Hi:=  data2.get_game_goods_type(z2,goods_f1);

                              {���٣�����ʱ������Ч}
                            //   result.l.Hi:= data2.get_game_goods_type(z2,goods_s1);
                               {����}
                           m:= data2.get_game_goods_type(z2,goods_t1);
                              if (m<> game_m_quan) then
                                 m:= game_read_values(0,ord(g_gdtl25));
                               if (m<>game_m_ban) then
                                 m:= game_read_values(0,ord(g_gdtl25)) div 2;
                             result.t.lo:= m;
                               {����}
                            m:=  data2.get_game_goods_type(z2,goods_l1);
                               if (m<> game_m_quan) then
                                 m:= game_read_values(0,ord(g_gdll26));
                               if (m<>game_m_ban) then
                                 m:= game_read_values(0,ord(g_gdll26)) div 2;
                              result.l.lo:= m;   

                           if data2.get_game_goods_type(z2,goods_n1)<>0 then
                              begin
                                //���嶨ʱ��
                                game_add_to_goods_time_list(z2);
                              end;

                          end;
                end; //end if


     result.m.lo:= result.m.lo * z1 div 10;  //����ϵ��������ش����ȷ���
     result.t.Lo:= result.t.Lo * z1 div 10;
     result.l.Lo:= result.l.Lo * z1 div 10;
     
   //����������Ϊ���� ������Ʒ����Ϊ4����j1����Ϊ 1
      if not b then   //��������Ʒ��������Ӱ��
     begin
      k:= game_return_filter(Fgame_guai_cu +5 ,3);
      result.m.Lo:= result.m.Lo + k.m.Lo;
        if result.m.Lo < 0 then
           result.m.Lo:= 0;
      result.t.Lo:= result.t.Lo + k.t.Lo;
        if result.t.Lo < 0 then
           result.t.Lo:= 0;
      result.l.Lo:= result.l.Lo + k.l.Lo;
         if result.l.Lo < 0 then
           result.l.Lo:= 0;
      result.m.Hi:= result.m.Hi + k.m.hi;
        if result.m.Hi < 0 then
           result.m.Hi:= 0;
      result.t.Hi:= result.t.Hi + k.t.hi;
        if result.t.Hi < 0 then
           result.t.Hi:= 0;
      result.l.Hi:= result.l.Hi + k.l.hi;
        if result.l.Hi < 0 then
           result.l.Hi:= 0;
    end;

   if (z2<= 0) or (i and 4= 4) or (data2.get_game_goods_type(z2,goods_j1)=1) then
   begin
   result.m.Lo:= result.m.Lo * -1;
   result.t.Lo:= result.t.Lo * -1;
   result.l.Lo:= result.l.Lo * -1;
   result.m.Hi:= result.m.Hi * -1;
   result.t.Hi:= result.t.Hi * -1;
   result.l.Hi:= result.l.Hi * -1;
   end;
        //͸����Ʒ��ʱ�������������Ƿ���ƫ��ֵ��
    //��һ�����������0-4�ҷ���5-9�з����ڶ���������1=�ˣ�2=�١�3=����4��

     
end;

procedure TForm_pop.game_fight_keep;
begin
       //��һ��ս��

       if game_at_net_g then
     begin
       if (game_player_head_G.duiwu_dg= 1) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt<>4) then
          exit;  //�������ȫ���棬��û�п���Ȩ���Ҳ��Ǵ�������ô���ʲ���ʾ
       if (game_player_head_G.duiwu_dg= 2) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt >4) then
          exit;  //����Ǵ�ָ��棬��û�п���Ȩ������ս��״̬����ô��������ʾ
     end;


  g_wo_guai_dangqian:=  game_p_list_ex; //�õ��ֵ�ս��������id�����ٶ���

      // 0--4���ҷ���Ա��5--9���з���Ա
   {============================================= }
     //������Ҫ��ӹ�������


  { ==============================================}
    if g_wo_guai_dangqian= -1 then
       g_wo_guai_dangqian:= 5;

   if g_wo_guai_dangqian> 4 then
     begin
     show_text(true,'��ѡ����ȷ���ֹ�����������');
      Fgame_guai_cu:= g_wo_guai_dangqian- 5;   //���浱ǰ�ֱ��
      //���﷢��ս��
      //�����˹�
       highlight_guai(Fgame_guai_cu);  //����
       time_list1.timer_gong:= false;
       g_gong.xianshi:= false;
       //��ʾ���ʴ���
       start_show_word(false);
     end else begin
                //�ҷ�����ս��

                show_text(true,'�������÷�������Ʒ���߹���');
               Fgame_my_cu:= g_wo_guai_dangqian;
               highlight_my(Fgame_my_cu);  //����
                g_gong.weizhi.Top:= 165;
                   g_gong.weizhi.Left:= 640-180;
                   g_gong.time:= game_amt_length;

               time_list1.Timer_gong:= true;
               //groupbox3.Visible:= true;

              end;
  write_label2_11; //������ʾ
end;

procedure TForm_pop.game_word_amt;
begin
  g_danci_donghua_count:= 0; //������ʼ֡��

 game_musmv_ready:= false;

  g_danci_donghua_id:= Game_base_random(7);


   time_list1.Timer_donghua:= true;
end;

function weizhi_get_alpha(t: integer):byte;
 begin
  result:= round((t / game_amt_length) * (t / game_amt_length)* 245)+10;
 end;
function weizhi_get_nn(t: integer):integer;
 begin
  result:= (game_amt_length -t) div 2;
 end;

procedure TForm_pop.go_amt_00(t: integer);
begin   //�������ƶ�
     if GameSave1.tip1= 0 then
      begin
    g_danci_weizhi.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_danci_weizhi.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));
     

    g_jieshi_weizhi1.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_jieshi_weizhi1.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));

    g_jieshi_weizhi2.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_jieshi_weizhi2.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));

    g_jieshi_weizhi3.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_jieshi_weizhi3.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));
       end;
      if GameSave1.tip2= 0 then
       begin
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_01(t: integer);
begin    //��С���󣬴������ҵ���
       if GameSave1.tip1= 0 then
      begin
     g_danci_weizhi.weizi.right:= round(t / game_amt_length * game_bmp_width) + g_word_show_left;

     g_jieshi_weizhi1.weizi.right:=  round(t / game_amt_length * game_bmp_width)+ g_word_show_left;

     g_jieshi_weizhi2.weizi.right:=  round(t / game_amt_length * game_bmp_width)+ g_word_show_left;

     g_jieshi_weizhi3.weizi.right:= round(t / game_amt_length * game_bmp_width)+ g_word_show_left;
      end;
      if GameSave1.tip2= 0 then
      begin
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_02(t: integer);
begin  //���ҵ���
     if GameSave1.tip1= 0 then
      begin
    g_danci_weizhi.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    g_danci_weizhi.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      
    g_jieshi_weizhi1.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    g_jieshi_weizhi1.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi2.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));

    g_jieshi_weizhi2.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi3.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    g_jieshi_weizhi3.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      end;
      if GameSave1.tip2= 0 then
      begin
    g_danci_weizhi.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_03(t: integer);
begin //���ϵ���
       if GameSave1.tip1= 0 then
      begin
  g_danci_weizhi.weizi.top:= round(t / game_amt_length * G_C_danci_top);
   g_danci_weizhi.weizi.Bottom:= round(t / game_amt_length * G_C_danci_top)+ game_bmp_h1;
         
  g_jieshi_weizhi1.weizi.top:= round(t / game_amt_length * G_C_jieshi1_top);
  g_jieshi_weizhi1.weizi.Bottom:= round(t / game_amt_length * G_C_jieshi1_top)+ game_bmp_h2;

  g_jieshi_weizhi2.weizi.top:= round(t / game_amt_length * G_C_jieshi2_top);
  g_jieshi_weizhi2.weizi.Bottom:= round(t / game_amt_length * G_C_jieshi2_top)+ game_bmp_h2;

  g_jieshi_weizhi3.weizi.top:= round(t / game_amt_length * G_C_jieshi3_top);
  g_jieshi_weizhi3.weizi.Bottom:= round(t / game_amt_length * G_C_jieshi3_top)+ game_bmp_h2;
       end;
       if GameSave1.tip2= 0 then
      begin
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_04(t: integer);
begin
  //���µ���
   if GameSave1.tip1= 0 then
      begin
  g_danci_weizhi.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_danci_top))- weizhi_get_nn(t);
  g_danci_weizhi.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_danci_top))+ game_bmp_h1- weizhi_get_nn(t);
      

  g_jieshi_weizhi1.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_jieshi1_top))- weizhi_get_nn(t);
  g_jieshi_weizhi1.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_jieshi1_top))+ game_bmp_h2- weizhi_get_nn(t);

  g_jieshi_weizhi2.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_jieshi2_top))- weizhi_get_nn(t);
  g_jieshi_weizhi2.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_jieshi2_top))+ game_bmp_h2- weizhi_get_nn(t);

  g_jieshi_weizhi3.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_jieshi3_top))- weizhi_get_nn(t);
  g_jieshi_weizhi3.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_jieshi3_top))+ game_bmp_h2- weizhi_get_nn(t);
      end;
      if GameSave1.tip2= 0 then
      begin
     g_danci_weizhi.alpha:= weizhi_get_alpha(t);
     g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
     g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
     g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_05(t: integer);
begin  //���ҵ��󣬷�ת
     if GameSave1.tip1= 0 then
      begin
    g_danci_weizhi.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_danci_weizhi.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      
    g_jieshi_weizhi1.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
   // g_jieshi_weizhi1.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi2.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));

   // g_jieshi_weizhi2.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi3.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_jieshi_weizhi3.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      end;
      if GameSave1.tip2= 0 then
      begin
    g_danci_weizhi.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_06(t: integer);
begin  //��λ�ò���
      if GameSave1.tip2= 0 then
      begin
   // g_danci_weizhi.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_danci_weizhi.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
   // g_jieshi_weizhi1.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
   // g_jieshi_weizhi1.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
       g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
  //  g_jieshi_weizhi2.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
       g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
   // g_jieshi_weizhi2.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

   // g_jieshi_weizhi3.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_jieshi_weizhi3.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
    g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.game_victory;  //ս��ʤ�����Ӿ��飬����������
var i,j,k,k2,k3: integer;
    jingyan,jinqian: integer;
    wp: array[0..4,0..1] of integer; //������Ʒ
    jyz: array[0..4] of integer; //����ľ���ֵ
    b: boolean;
    t: Tplayer;
    str1: Tstringlist;
begin
    show_text(true,'');
        show_text(false,'');

         if GameSave1.tip5= 0 then
            play_sound(14);

        draw_text_17('ս��ʤ��',1000,clgreen);
        G_game_delay(1000);
        
   //�Ӿ���ֵ
  jingyan:= 0;
  jinqian:= 0;
  b:= false;
  k2:= 0;
  
   for i:= 0 to 4 do
    begin
     wp[i,0]:= 0;
      wp[i,1]:= 0;
      jyz[i]:= 0;
    end;

 for i:= 0 to 4 do
  begin

       jingyan:= jingyan + loc_guai_g[i].jingyan;
       jinqian:= jinqian + loc_guai_g[i].qian;
       if (loc_guai_g[i].wu_diao > 0) and(loc_guai_g[i].wu_diao_shu > 0) then
          begin
           b:= true;
          wp[i,0]:=loc_guai_g[i].wu_diao; //������Ʒ����
          //������Ʒ����������
           j:= loc_guai_g[i].wu_diao_gai;
            //������Ʒ����
           wp[i,1]:= loc_guai_g[i].wu_diao_shu;
            if j> 1 then
             begin
              if random(j)<> 1 then
                 wp[i,1]:= 0;
             end;

         end;

  end; //end for

   t:= game_get_role_from_i(0);
   t.plvalues[0]:= t.plvalues[0] + jinqian; //���ӽ�Ǯ
   
   //���侭��
       k3:= get_r_role_all_count_NoDead;  //ȡ������侭��ֵ������
       if k3> 1 then
        begin  //���˷���
         k2:= jingyan div k3; //ȡ��ƽ��ֵ
         k:= round(k2 * 1.2); //���ս����Ա����ֵ1.2��
          k2:= k2 - (k-k2) div (k3-1); //������Ա�����˾���ֵ
        end else k:= jingyan;  //���˷���


     for i:= 0 to 4 do
      begin
      if is_can_jingyan(i) then
       begin
        if i= Fgame_my_cu then
         jyz[i]:= k  //���ս����Ա����ֵҪ��һЩ
          else
           jyz[i]:= k2;
       end;
      end;

      //�����б�
      //���Ӿ���ֵ

      str1:= Tstringlist.Create;
       str1.Append(format('�õ���Ǯ��%d',[jinqian]));
         for i:= 0 to 4 do
         begin
          if jyz[i] > 0 then
           begin
             t:= game_get_role_from_i(i);
             t.plvalues[19]:= t.plvalues[19] + jyz[i];
             str1.Append(t.plname + ' ���Ӿ���ֵ��'+ inttostr(jyz[i]));
           end;
         end;

    if b then
     begin
       //��ʾ�������Ʒ
      for i:= 0 to 4 do
       begin
        if wp[i,1]> 0 then
          begin
           write_goods_number(wp[i,0],wp[i,1]); //������Ʒ����

             str1.Append(pchar(data2.get_game_goods_type(wp[i,0],goods_name1)) +'��'+inttostr(wp[i,1]));
          end;
       end; //end for
     end;

      //��ʾ����
       draw_text_17_m(str1,1000,clblack);
       G_game_delay(3000);
       str1.Free;
     //�ж�����
      game_up_role;
     
end;

procedure TForm_pop.Button1Click(Sender: TObject);
var t: Tplayer;
begin

if need_wait then
 exit;

       
   //�� ��ť
   {
   1�������ҷ���Ա
   2������ж�����ˣ��ȴ����ѡһ������
   3������ǵ������ˣ�ֱ�ӹ���
   4�����ù�������
   }
      t:= game_get_role_from_i(Fgame_my_cu); //��ȡ��ǰ�����ʵ��
       if t=nil then
         exit;

     if t.plvalues[ord(g_tili)]= 0 then
      begin
       messagebox(handle,'�������㡣','��������',mb_ok);
       exit;
      end else begin
                t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_tili)] - t.plvalues[ord(g_gdtl25)] div 50 -1;
                if t.plvalues[ord(g_tili)] < 0 then
                   t.plvalues[ord(g_tili)]:= 0;
               end;
   f_type_g:= 1;

   listbox1.Visible:= false;
   groupbox3.Visible:= false;
   time_list1.timer_gong:= false;
   g_gong.xianshi:= false;
   //highlight_my(Fgame_my_cu);  //����

   if get_guai_count > 1 then
    begin
     F_Attack_type:= 0; //��������Ϊ������
     show_text(true,'����һ������������');
      game_pic_check_area:= G_g_pic_y; //��������ѡ��
      Timer_auto_attack.Enabled:= true;
    end else
         My_Attack(Fgame_my_cu,get_guai_only,0);

  f_type_g:= 1;
   
end;

function TForm_pop.get_guai_count: integer;//��ȡ���ڵĹֵĸ���
 var i: integer;
begin
result:= 0;

   for i:= 0 to 4 do
     if net_guai_g[i].ming> 0 then
       inc(result);
end;

function TForm_pop.get_guai_only: integer;   //��ȡ��ʣ�Ĺ�id
  var i: integer;
begin
result:= 0;

   for i:= 0 to 4 do
     if net_guai_g[i].ming> 0 then
       result:= i;
end;

procedure TForm_pop.Button2Click(Sender: TObject);
var t: Tplayer;
begin
 // ������ť
 if need_wait then
 exit;
 
   listbox1.Visible:= false;
   groupbox3.Visible:= false;
   time_list1.timer_gong:= false;
   g_gong.xianshi:= false;
    un_highlight_my(Fgame_my_cu);  //�ָ�����

    t:= game_get_role_from_i(Fgame_my_cu);
    t.plvalues[ord(g_linshifang)]:= 2; //����ֵ��ʱ�ӱ�
   //���ü���ս������
  //game_fight_keep;
     game_fight_result_adv; //�жϽ��
 f_type_g:= 2; 
end;

procedure TForm_pop.Button5Click(Sender: TObject);
begin
   //���� ��ť
   if need_wait then
 exit;
 
   un_highlight_my(sid_to_roleId(mtl_game_cmd_dh1.fq_sid));  //�ָ�����

    if can_escape then
     begin
      game_can_close:= true;
      g_gong.xianshi:= false;
      self.Close;
     end else begin
                if Game_cannot_runOff then
                show_text(false,'��һ��ս��������ӡ�')
                else
                show_text(false,'����ʧ�ܡ�');
                groupbox3.Visible:= false;
                time_list1.timer_gong:= false;
                g_gong.xianshi:= false;
                //game_fight_keep;
                game_fight_result_adv; //�жϽ��
              end;
 listbox1.Visible:= false;             
 f_type_g:= 5;
end;

function TForm_pop.can_escape: boolean;   //�Ƿ���������
var i: integer;
begin
 if Game_cannot_runOff then
   begin
    //��ֹ����
    result:= false;
    exit;
   end;

 if form1.game_check_goods_nmb('���ٹ�',1)=1 then
  begin
   if messagebox(handle,'�Ƿ�ʹ��һ�����ٹ������ܡ�','����',mb_yesno or MB_ICONQUESTION)= mryes then
    begin
     form1.game_goods_change_n('���ٹ�',-1);
     result:= true;
     exit;
    end;
  end;
  if game_get_role_su(Fgame_my_cu) > game_get_guai_su(Fgame_guai_cu) then
     i:= 5
     else
      i:= 30; //����ҷ��ٶȱȹִ����ܸ�����5��֮һ��������30��֮һ

    result:=( Game_base_random(i)= 1);
end;

procedure TForm_pop.Button3Click(Sender: TObject);
var i,j,k: integer;
    t: Tplayer;
begin
if need_wait then
 exit;
       //��������
       
       listbox1.Items.BeginUpdate;
        listbox1.Items.Clear;
        t:= game_get_role_from_i(Fgame_my_cu); //��ȡ��ǰ�����ʵ��

       listbox1.Items.Append('--�ָ��෨��--');
       for i:= 0 to 63 do
        begin
         if t.pl_fa_array[i]> 0 then
           begin
             j:= get_L_16(t.pl_fa_array[i]); //�õ��������
             k:= get_H_8(t.pl_fa_array[i]); //�õ������ȼ�
            if Data2.get_game_goods_type(j,goods_j1)= 0 then
               listbox1.Items.Append(Data2.get_game_fa(j)+' �ȼ�'+ inttostr(k));
           end;
        end;
      listbox1.Items.Append('--�����෨��--');
       for i:= 0 to 63 do
        begin
         if t.pl_fa_array[i]> 0 then
          begin
           j:= get_L_16(t.pl_fa_array[i]); //�õ��������
             k:= get_H_8(t.pl_fa_array[i]); //�õ������ȼ�
            if Data2.get_game_goods_type(j,goods_j1)= 1 then
               listbox1.Items.Append(Data2.get_game_fa(j)+' �ȼ�'+ inttostr(k));
          end;
        end;
      listbox1.Items.EndUpdate;

  g_gong.time:= 0;
  time_list1.timer_gong:= false;
  g_gong.xianshi:= false;
  
  groupbox3.Visible:= true;
  listbox1.Visible:= true;
  listbox1.SetFocus;
 f_type_g:= 3;
end;

procedure TForm_pop.Button4Click(Sender: TObject);
var i,j: integer;
    str1,str2: Tstringlist;

begin
if need_wait then
 exit;
 f_type_g:= 4;
       //��Ʒ
       listbox1.Items.BeginUpdate;
       listbox1.Items.Clear;

       str1:= Tstringlist.Create;
       str2:= Tstringlist.Create;
       listbox1.Items.Append('--ʳƷҩƷ--');
       for i:= 1 to 1023 do
        begin
         if read_goods_number(i)> 0 then
          begin
           j:= Data2.get_game_goods_type(i,goods_type1); //ȡ����Ʒ����
            if j and 2= 2 then
               listbox1.Items.Append(game_add_shuliang_string(Data2.get_game_goods_type_a(i),read_goods_number(i)))
               else if j and 256= 256 then
                     str1.Append(game_add_shuliang_string(Data2.get_game_goods_type_a(i),read_goods_number(i)))
                     else if j and 4= 4 then
                       str2.Append(game_add_shuliang_string(Data2.get_game_goods_type_a(i),read_goods_number(i)));
          end;
        end;
       if str1.Count > 0 then
       begin
       listbox1.Items.Append('--��ǿ��--');
        for i:= 0 to str1.Count- 1 do
           listbox1.Items.Append(str1.Strings[i]);

       end;
       
       if str2.Count > 0 then
       begin
       listbox1.Items.Append('--Ͷ��������--');
        for i:= 0 to str2.Count- 1 do
           listbox1.Items.Append(StringReplace(str2.Strings[i],'+','-',[rfReplaceAll]));

       end;
       str1.Free;
       str2.Free;
       
     listbox1.Items.EndUpdate;

     g_gong.time:= 0;
  time_list1.timer_gong:= false;
  g_gong.xianshi:= false;

  groupbox3.Visible:= true;
  listbox1.Visible:= true;
  listbox1.SetFocus;
end;

procedure TForm_pop.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
  listbox1_click1;
end;

procedure TForm_pop.listbox1_click1;
var ss: string;
    id,j: integer;
begin
 if (listbox1.ItemIndex= -1) or need_wait then
    exit;

  ss:= listbox1.Items.Strings[listbox1.ItemIndex];
  if (ss= '') or (ss[1]= '-') then
   begin
    if listbox1.Items.Count<= 2 then
     if f_type_g = 4 then
      messagebox(handle,'��û�п��õ���Ʒ��ҩ�ģ�����Ʒ������Ұ��񵽻����ڳ���ĵ������򵽡�','����',mb_ok or MB_ICONWARNING)
     else
     messagebox(handle,'��û��ѧ�ᷨ���������ؼ��������Թ��ҵ�������һЩ�ض����ﴦ��á�','����ð��',mb_ok or MB_ICONWARNING);
   exit;   //�ָ��ߣ��˳�
   end;
   //��������ʱ�˳������Ȼ�÷������ƣ�Ȼ��ȡid��Ȼ��ȡ������Ȼ��͵�ǰ����ȶ�ʣ������
    if not lingli_is_ok(ss) then
     begin
      messagebox(handle,'��������������ʹ�ô˷�����','��������',mb_ok or MB_ICONWARNING);
       exit;
     end;
  groupbox3.Visible:= false;
  g_gong.xianshi:= false;
  id:= Form_goods.get_goods_id(ss); //��ȡ��Ʒid

   F_Attack_type:= id; //���浱ǰ��Ʒ���߷�����id

  ss:= Data2.get_goods_all_s(id);  //ȡ������Ʒ�ַ���������

   j:= strtoint2(data2.get_game_goods_type_s(ss,goods_type1)); //ȡ������


   if j and 2=2 then
     procedure_2(ss)
     else if j and 4=4 then
          procedure_4(ss)
          else if j and 128= 128 then
           procedure_128(ss)
            else if j and 256 = 256 then
                procedure_256(ss);

end;

procedure TForm_pop.procedure_128(const s: string); //�����ദ��
var i: integer;
begin
  // ��ȡ�������ͣ�����ȫ�壬���壬�������ͣ��ָ�����
  i:= strtoint2(data2.get_game_goods_type_s(s,goods_j1));
  if i= 0 then
   begin
    //�ָ���
    F_is_Attack:= false;
    i:= strtoint2(data2.get_game_goods_type_s(s,goods_y1));
    if i= 1 then
     begin
        //����ָ�
      procedure_2(s);
     end else begin
                //ȫ��ָ�
                My_comeback(Fgame_my_cu,-1,F_Attack_type);
              end;
   end else begin
             //������
             F_is_Attack:= true;
              i:= strtoint2(data2.get_game_goods_type_s(s,goods_y1));
              if i= 1 then
                 begin
                  //���幥��
                  procedure_4(s);
                 end else begin
                            //ȫ�幥��
                           //�ҷ�����������Ϊ�����ߣ�����id�͹�����ʽ��0Ϊ��ͨ����������ֵΪ������������
                            My_Attack(Fgame_my_cu,-1,F_Attack_type);
                          end;
            end;
end;

procedure TForm_pop.procedure_2(const s: string);  //ʳƷҩƷ�ദ��
begin
  //ʳƷҩƷ��������Ե����˵�
  //�����ж��ҷ��м��ˣ�������������ɫ
  F_is_Attack:= false;
  if get_r_role_all_count > 1 then
   begin
    game_pic_check_area:= G_my_pic_y; //�ҷ�����ѡ��
    show_text(false,'����һ���ҷ�����');
   end else begin
              //�ҷ��ָ�
              My_comeback(Fgame_my_cu,Fgame_my_cu,F_Attack_type);
            end;
end;

procedure TForm_pop.procedure_256(const s: string);  //��ǿ�����ദ��
begin
   procedure_2(s);
end;

procedure TForm_pop.procedure_4(const s: string);   //Ͷ�������ദ��
begin
  //Ͷ���඼����Ը��˵�
 // get_guai_count: integer; //��ȡ�������
  //get_guai_only: integer; //��ȡ��ʣ�Ĺֱ��
  if pos('���ٹ�',s)=1 then
    begin
      close;
      exit;
    end;
  F_is_Attack:= true;
  if get_guai_count > 1 then
   begin
    game_pic_check_area:= G_g_pic_y; //������ѡ��
    Timer_auto_attack.Enabled:= true; //һ���Ӻ��Զ�����
    show_text(false,'����һ��Ҫ�����Ĺ�');
   end else begin
             My_Attack(Fgame_my_cu,get_guai_only,F_Attack_type);
            end;
end;

function TForm_pop.get_r_role_all_count: integer;  //ȡ���ҷ�ȫ���ϳ���������������������ɫ
var j: integer;
begin
result:= 0;
      for j:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(j,4)= 1 then
        inc(result);  //�������������ϳ����ˣ�ֻ�е���1�ģ��ż���
    end;

  if result> 5 then
   result:= 5;

end;

procedure TForm_pop.My_comeback(m, p, d: integer);//�ָ���

begin
   //����Ϊ�ָ������ߣ��ָ������ߣ��ָ�����
   //�ж�����Ʒ�ָ����Ƿ����ָ����۳���Ʒ�������۳��������ĵ�����
   //p����-1����ʾȫ��ָ�

   {�ָ����ļ������
   �ָ����Ķ�������}

             //���÷�������Ʒ�ָ��Ķ�������

      huifu_js(m, p, d);   //����ָ�ֵ

       huifu_donghua;  //�ָ�ʱ����

 {  un_highlight_my(-1);            ��Щ�����Ѿ��ƶ�����ʱ����
   draw_game_role(-1); //�ػ�ȫ��
   game_pic_check_area:= G_all_pic_n; //ȫ�ֽ�ֹѡ��
   show_text(false,'');


   game_fight_result_adv; //�жϽ��       }
end;

procedure TForm_pop.game_my_Attack_blood; //�ҷ�������۳���Ѫ��
     procedure blood2(t: integer); //��Ƕ���̣��ҷ���ţ�������
      begin
           if net_guai_g[t].ming<= 0 then
             exit;  //�����򲻴��ڵĹ��˳�

             net_guai_g[t].ming:= net_guai_g[t].ming + mtl_game_cmd_dh1.js_m;
             net_guai_g[t].ti:= net_guai_g[t].ti + mtl_game_cmd_dh1.js_t;
             net_guai_g[t].ling:= net_guai_g[t].ling + mtl_game_cmd_dh1.js_l;

             //�˺�ֵ��Ʈ����Ʈ������false���£�Ʈ����ֵ������id�����ͣ�1Ѫ������������������
               game_show_blood(false,mtl_game_cmd_dh1.js_m,t,1);
                 // �������� **************************************
                   if net_guai_g[t].ming<= 0 then
                begin
                net_guai_g[t].ming:= 0;
                net_guai_g[t].shu:= 0;
                if gamesave1.tip5= 0 then
                  play_sound(9); //����������
                end else begin
                          if (game_guai_fanghu_xishu_f<= 10) and (mtl_game_cmd_dh1.js_m < 0) then
                            begin
                            if gamesave1.tip6= 0 then
                               play_sound(7);

                            end;
                         end;
                 //�������� *****************************************
               if mtl_game_cmd_dh1.js_t <> 0 then
               begin
              G_game_delay(500);
              game_show_blood(false,mtl_game_cmd_dh1.js_t,t,2);
               end;
              if mtl_game_cmd_dh1.js_l <> 0 then
              begin
              G_game_delay(500);
              game_show_blood(false,mtl_game_cmd_dh1.js_l,t,3);
              end;
                  if net_guai_g[t].ti< 0 then
                     net_guai_g[t].ti:= 0;
                  if net_guai_g[t].ling< 0 then
                     net_guai_g[t].ling:= 0;
              if not game_at_net_g then //��������ʱ�����Կ۳�����Ĺ�����
               begin
                 net_guai_g[t].gong:= net_guai_g[t].gong+ mtl_game_cmd_dh1.js_g;
                 net_guai_g[t].fang:= net_guai_g[t].fang+ mtl_game_cmd_dh1.js_f;
                 net_guai_g[t].shu:= net_guai_g[t].shu+ mtl_game_cmd_dh1.js_shu;
                  if net_guai_g[t].gong< 0 then
                     net_guai_g[t].gong:= 0;
                  if net_guai_g[t].fang< 0 then
                     net_guai_g[t].fang:= 0;
                  if net_guai_g[t].shu< 0 then
                     net_guai_g[t].shu:= 0;
               end;
              

      end;
var i, t2: integer;
begin
  t2:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);
   if t2 >= 5 then
      t2:= t2 -5;

  if t2= -1 then
   begin
    for i:= 0 to 4 do
        blood2(i);

   end else blood2(t2);
    //t1���ҷ���ţ�t2,�ֱ��-1����ʾȫ�壬t3������������ָ���͹������������

end;

function TForm_pop.game_get_my_Attack_value(z1: integer): Tmtl_rec;  //ȡ���ҷ������� ����Ϊ��������
var
    i: integer;
    j,w: integer; //�ȼ�
    k: Tmtl_rec;
    b: boolean;
begin
result.m.int:= 0;
 result.t.int:= 0;
 result.l.int:= 0;
 i:= 0;
  b:= false;
              {mtl�߶�Ϊ�����٣��Ͷ�Ϊ�����飬���ǲ�ֵ}
 // t:= game_get_role_from_i(Fgame_my_cu);

 //����ҷ���������
      mtl_game_cmd_dh1.fq_m:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_life));
      mtl_game_cmd_dh1.fq_t:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_tili));
      mtl_game_cmd_dh1.fq_l:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_lingli));

   if z1= 0 then
    begin

       result.m.Lo:= game_read_values(get_pid_from_showId(Fgame_my_cu),3);

    end else begin
                b:= true;
               i:= data2.get_game_goods_type(z1,goods_type1); //ȡ������
               if i and 128= 128 then
                begin
                  j:= game_fashu__filter(z1); //���صȼ�����������Ʒ���
                 //�۳�������ȡ��������ֵ
                   i:= data2.get_game_goods_type(z1,goods_L1);
                   if i > mtl_game_cmd_dh1.fq_l then
                      mtl_game_cmd_dh1.fq_l:= 0
                      else
                        mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- i;


                 //������ֱ�ӵõ���Ѫֵ
                 result.m.Lo:= data2.get_game_goods_type(z1,goods_m1) * (j-1 + 10) div 10;  //��
                 result.t.Lo:= data2.get_game_goods_type(z1,goods_t1) * (j-1 + 10) div 10;   //��
                 result.m.Hi:= data2.get_game_goods_type(z1,goods_g1) * (j-1 + 10) div 10;   //��
                 result.t.Hi:= data2.get_game_goods_type(z1,goods_z1) * (j-1 + 10) div 10;   //��
                 result.l.Hi:= data2.get_game_goods_type(z1,goods_s1) * (j-1 + 10) div 10;   //��
                end else if (i and 4= 4) or (i and 2= 2) or (i and 256= 256) then
                          begin

                            //�۳���Ʒ����
                            write_goods_number(z1,-1);
                            w:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_speed))+1; //�õ��٣���ֹ����

                            w:=  round((net_guai_g[Fgame_guai_cu].fang
                                /w+1) * 10); //����ķ�

                             if Random(w)> 10 then
                                begin
                                   //������� ϵ�������ڶԷ����������ã�Ͷ��ʧ��
                                  mtl_game_cmd_dh1.flag:= 8; //���������
                                  exit;
                                end;

                            //��������Ʒ��������ֱ�ӹ���ֵ�⣬��Ҫ��ʱ
                             {����}
                           result.m.Lo:= data2.get_game_goods_type(z1,goods_m1);

                              {��������ʱ������Ч}
                            // result.m.Hi:= data2.get_game_goods_type(z1,goods_g1);
                              {���� ��ʱ������Ч}
                             // result.t.Hi:=  data2.get_game_goods_type(z1,goods_f1);

                              {���٣���ʱ������Ч}
                             //  result.l.Hi:= data2.get_game_goods_type(z1,goods_s1);
                               {����}
                           result.t.Lo:= data2.get_game_goods_type(z1,goods_t1);
                               {����}
                            result.l.Lo:=  data2.get_game_goods_type(z1,goods_l1);

                           if data2.get_game_goods_type(z1,goods_n1)<>0 then
                              begin
                                //���嶨ʱ��
                                game_add_to_goods_time_list(z1);
                              end;

                          end;
             end;
    
     //����������Ϊ����
   if (z1= 0) or (i and 4= 4) or (data2.get_game_goods_type(z1,goods_j1)=1) then
     begin
   result.m.Lo:= result.m.Lo * -1;
   result.t.Lo:= result.t.Lo * -1;
   result.l.Lo:= result.l.Lo * -1;
   result.m.Hi:= result.m.Hi * -1;
   result.t.Hi:= result.t.Hi * -1;
   result.l.Hi:= result.l.Hi * -1;
     end;
        //͸����Ʒ��ʱ�������������Ƿ���ƫ��ֵ��
    //��һ�����������0-4�ҷ���5-9�з����ڶ���������1=�ˣ�2=�١�3=����4��
    if not b then   //��������Ʒ��������Ӱ��
    begin
    k:= game_return_filter(Fgame_my_cu,3);
   result.m.Lo:= result.m.Lo + k.m.Lo;
   result.t.Lo:= result.t.Lo + k.t.Lo;
   result.l.Lo:= result.l.Lo + k.l.Lo;
   result.m.Hi:= result.m.Hi + k.m.hi;
   result.t.Hi:= result.t.Hi + k.t.hi;
   result.l.Hi:= result.l.Hi + k.l.hi;
    end;

end;

procedure TForm_pop.game_fight_result_adv; //�жϽ��
begin
   case game_fight_result of
    0: begin
         //����ս��
         game_can_close:= false;
        game_fight_keep;
       end;
    1: begin
        //�ҷ�������������Ǵ��ޣ���Ϸ����
        if GameSave1.tip5= 0 then
            play_sound(15);

        game_can_close:= true;
        show_text(true,'');
        show_text(false,'');

        draw_text_17('ս��ʧ��',1000,clred);
        G_game_delay(2000);
        G_show_result_b:= false;
        self.ModalResult:= mrcancel;
          game_blood_add_one; //ս��������������ɫѪ��ָ�Ϊһ

        if game_at_net_g then
         form1.game_goto_home(0)
        else
        if game_pop_type= 3 then
           form1.game_over(0);  //ս��ʧ�ܣ���Ϸ����

       end;
    2: begin
         //ս��ʤ�����Ӿ���ֵ
         game_can_close:= true;
         game_victory;
          game_blood_add_one; //ս��������������ɫѪ��ָ�Ϊһ
          //��ս��״̬������һֻ�����ܵ��ģ����巵��falseֵ
          if game_guai_escape and (game_pop_type= 3) then
           self.ModalResult:= mrcancel
          else
           self.ModalResult:= mrok;
       end;
    end;
end;

procedure TForm_pop.draw_text_17(const s: string; flag: integer; c: Tcolor; f_size: integer=32);
var aafont: TAAFontEx;
    bmp : TBitmap;
    w,h: integer;
begin

  if s= '' then
   begin
   G_show_result_b:= false;
    exit;
   end;

    bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
           bmp.Width:=g_result_w1;
           bmp.Height:=g_result_h1;
         {
          flag
          1000 ��Ч��
          1001  ����
          1002  ����
          1003  ģ��
          1004  ����
          1005  ��͸��
          1006  ����δ�ã�

         }

      AAFont := TAAFontEx.Create(bmp.Canvas);

      aafont.Effect.LoadFromIni(game_effect_ini,'AT'+ inttostr(flag));
      aafont.Effect.Shadow.Color:= clblack;
      aafont.Effect.Gradual.StartColor:=c;
      aafont.Effect.Gradual.EndColor:= not c;
      try
        with bmp.Canvas do
        begin
          Font.Name := '����'; // ��������
          Font.Size := f_size;
          Font.Color := c;
          Brush.Style := bsClear; // ����͸������
        end;
        W := AAFont.TextWidth(S);
        H := AAFont.TextHeight(S);
        with bmp do // �ڿؼ���������ı�
          AAFont.TextOut((Width - W) div 2, (Height - H) div 2, S);
        //AAFont.Canvas := Image1.Canvas; // Ҳ�����л�����һ����
        //AAFont.TextOut(10, 10, S); // ����ʱ��ʹ��Image1.Canvas����������
      finally
        AAFont.Free;
      end;

         with image_result1 do
         begin
         LoadFromBitmap(bmp,false,$FFFFFFFF,0);
         end;
      bmp.Free;
      //������Ч����

   G_show_result_b:= true;
   g_dangqian_zhuangtai:= G_animation; //��Ϸ���ڶ���״̬
end;

procedure TForm_pop.game_Animation_base1(up: boolean);

begin
    //��ͨ�������� ���ɽ���Զ
  // game_amt_length= 60; //����֡
   //game_amt_delay


       G_PuTongGongji.time:= game_amt_length;
       G_Guai_PuTongGongji.time:= game_amt_length;


      g_game_delay(g_C_DonghuaQianWenZi); //�ӳ�
     G_show_result_b:= false;

     if up then
       time_list1.timer_wo_gongji:= true
       else
         time_list1.timer_guai_gongji:= true;



end;

procedure TForm_pop.game_Animation_base2(up: boolean);

begin
  //����������������������

       g_DanTiFaShuGongJi.time:= game_amt_length;
       G_QuanTiFaShuGongji.time:= game_amt_length;
       G_Guai_Fashu.time:= game_amt_length;


      g_game_delay(g_C_DonghuaQianWenZi); //�ӳ�
     G_show_result_b:= false;

     if up then
       time_list1.timer_wo_fashugongji:= true
       else
         time_list1.timer_guai_fashugongji:= true;

    


end;

procedure TForm_pop.game_Animation_base3(up: boolean);

begin
    //ʹ����Ʒ��������

             G_dantiWuPinGongji.time:= game_amt_length;


          g_game_delay(g_C_DonghuaQianWenZi); //�ӳ�
     G_show_result_b:= false;

         time_list1.Timer_wupin_gongji:= true;
end;

procedure TForm_pop.game_Animation_base4(up: boolean);

begin
    // ��Ʒ�ָ���������͸��
            G_DanTiWuPinHuiFu.time:= game_amt_length;



                  g_game_delay(g_C_DonghuaQianWenZi); //�ӳ�
     G_show_result_b:= false;

         time_list1.Timer_wupin_huifu:= true;
end;

procedure TForm_pop.game_Animation_base5(up: boolean);

begin
   //�����ָ��������ɺ�䵭
       G_DanTiFaShuHuiFu.time:= game_amt_length;
       G_Quantifashuhuifu.time:= game_amt_length;


                  g_game_delay(g_C_DonghuaQianWenZi); //�ӳ�
     G_show_result_b:= false;

         time_list1.Timer_fashu_huifu:= true;
end;

procedure TForm_pop.game_show_blood(up: boolean; value, id,
  type1: integer);
  var c: Cardinal;
begin
      {��ʾѪֵ����ʾλ�ã����£���ֵ�������ţ����ͣ�Ѫ������������}
 c:= 0;
   case type1 of
    1: if value > 0 then
       c:= $FF008800
        else
         c:= $FF;
    2: if value > 0 then
        c:= $FFFF0000
         else
          c:= $FFFFFFFF;
    3: if value > 0 then
        c:= $FF000080
         else
          c:= $FF000000;
    end;

    if id<0 then
       id:= 0;

    if up then
     begin
      text_show_array_G[id].top1:= g_C_role_top;
     end else begin
                  text_show_array_G[id].top1:= g_C_guai_top+ 40;

              end;

     text_show_array_G[id].peise:= c;
      text_show_array_G[id].left1:= g_get_roleAndGuai_left(id);
      text_show_array_G[id].xiaoguo:= fxAdd;
   if value > 0 then
      text_show_array_G[id].zhi:= '+'+ inttostr(value)
       else
         text_show_array_G[id].zhi:= inttostr(value);

   text_show_array_G[id].xianshi:= true;

    if up then //���ϻ�������Ʈ
     blood_show_list[id]:= 10
      else
       blood_show_list[id]:= -10;

       //������ʱ��
       
       if not timer2.Enabled then
         timer2.Enabled:= true;
end;

procedure TForm_pop.Timer2Timer(Sender: TObject);
var i: integer;
    b: boolean;
begin
   //ѪֵƮ����ʱ��
   //���ÿ��id��Ʈ��ֵ����Ϊ��Ķ�Ʈ����λ��
   //ȫ��Ϊ�㣬��ֹͣ��ʱ��
b:= false;
   for i:= 0 to 4 do
    begin
      if blood_show_list[i]<> 0 then
       begin
        //����ʵ��
        b:= true;
         if blood_show_list[i] > 0 then
           begin
            text_show_array_G[i].top1:= text_show_array_G[i].top1 -3; //�ҷ���Ʈ
            dec(blood_show_list[i]);
           end else begin
             text_show_array_G[i].top1:= text_show_array_G[i].top1 +3;  //�з���Ʈ
             inc(blood_show_list[i]);
                    end;
        if blood_show_list[i]= 0 then
          begin
          text_show_array_G[i].xianshi:= false;
           b:= false;
          end;
       end;
    end; //end for

  timer2.Enabled:= b;
end;

procedure TForm_pop.game_add_to_goods_time_list(id: integer);  //���һ����Ʒ����ʱ�����б�
var ss: string;
begin         
   //����Ϊ��Ʒid
  // F_time_role_id: integer; //������ӵ���ʱ���ڵģ�������������
  //0-4���ҷ����5-9���з�����

  ss:= data2.get_goods_all_s(id);
   if ss= '' then
    exit;


    //����Ʒ�ĵ�һ�����������ƣ���Ϊ�������߱�ţ������һ����ʱ����λ�ã���10��������

    delete(ss,1,pos(',',ss));
    ss:= '0,'+ inttostr(F_time_role_id)+','+ss;

    if not Assigned(goods_time_list) then
       goods_time_list:= Tstringlist.Create;

       //��ӵ���ʱ��Ʒ�б�
     goods_time_list.Append(ss);

     //������ʱ��
     if timer3.Enabled= false then
      timer3.Enabled:= true;

end;

procedure TForm_pop.Timer3Timer(Sender: TObject);
var i,j,tm,k,m,p: integer;
    ss: string;
     procedure ppp2(add: boolean);
      var t: Tplayer;
          i2,i3: integer;
      begin
       if add then
        i3:= 1
         else
          i3:= -1;
        if p< 5 then
         begin
          //ȡ���ҷ�ʵ��������ֵ
          t:= game_get_role_from_i(p);
          if t<> nil then
           begin

              //Ѫֵ
              i2:= strtoint2(data2.get_game_goods_type_s(ss,goods_m1));
              i2:= game_get_xtl_values(p,i2,3)* i3;
              game_show_blood(true,i2,p,1); //Ʈ��������ֵ

              t.plvalues[ord(g_life)]:= t.plvalues[ord(g_life)] + i2;
                if t.plvalues[ord(g_life)] > t.plvalues[ord(g_gdsmz27)] then
                   t.plvalues[ord(g_life)]:= t.plvalues[ord(g_gdsmz27)]
                    else if t.plvalues[ord(g_life)] < 0 then
                            t.plvalues[ord(g_life)]:= 0;
               G_game_delay(500); //Ʈ��ʱ��
              //��
               i2:= strtoint2(data2.get_game_goods_type_s(ss,goods_t1));
               i2:= game_get_xtl_values(p,i2,1)* i3;
                game_show_blood(true,i2,p,2);   //Ʈ��������ֵ

              t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_tili)] + i2;
                if t.plvalues[ord(g_tili)] > t.plvalues[ord(g_gdtl25)] then
                   t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_gdtl25)]
                    else if t.plvalues[ord(g_tili)] < 0 then
                            t.plvalues[ord(g_tili)]:= 0;
                G_game_delay(500); //Ʈ��ʱ��
              //��
              i2:= strtoint2(data2.get_game_goods_type_s(ss,goods_l1));
              i2:= game_get_xtl_values(p,i2,2) * i3;
              t.plvalues[ord(g_lingli)]:= t.plvalues[ord(g_lingli)] + i2;
               game_show_blood(true,i2,p,3); //Ʈ��������ֵ
                if t.plvalues[ord(g_lingli)] > t.plvalues[ord(g_gdll26)] then
                   t.plvalues[ord(g_lingli)]:= t.plvalues[ord(g_gdll26)]
                    else if t.plvalues[ord(g_lingli)] < 0 then
                            t.plvalues[ord(g_lingli)]:= 0;
            draw_game_role_base(p); //�ػ�
           end;
         end else begin
                    //ȡ�õз�ʵ��������ֵ
                    dec(p,5); //��Ϊ���ʵĵз�idֵ
                    if net_guai_g[p].ming<= 0 then
                       exit;
                       
                    i2:=strtoint2(data2.get_game_goods_type_s(ss,goods_m1)) ;
                    i2:= game_get_xtl_values_guai(p,i2,3)* i3;
                    game_show_blood(false,i2,p,1); //Ʈ��������ֵ,�֣�����Ʈ

              net_guai_g[p].ming:= net_guai_g[p].ming + i2;

               if net_guai_g[p].ming < 0 then
                            net_guai_g[p].ming:= 0;

                   draw_game_guai_base(p); //�ػ���
                  end;
      end;
begin

  for i:= goods_time_list.Count- 1 downto 0 do
   begin
     ss:= goods_time_list.Strings[i];
     if ss<> '' then
      begin
       if ss[1]= '9' then
        begin
         //��������,����ǹ����Ļ��ǻָ��ģ������ļ����ָ��ļ�
         
          delete(ss,1,2); //ɾ�����׵Ķ�ʱ���ñ��

           p:= strtoint2(copy(ss,1,pos(',',ss)-1)); //ȡ������id
               //0-4���ҷ����5-9���з�����

           if data2.get_game_goods_type_s(ss,goods_type1)= '256' then
            begin
             //����
              ppp2(true);
            end else begin
                      //����
                       ppp2(false);
                     end;
         
         //ȡ��ʱ�䣬������1��ʾ10��
         tm:= strtoint2(data2.get_game_goods_type_s(ss,goods_n1));
         dec(tm);
         if tm= 0 then //���Ϊ�㣬ɾ������Ʒ�Ӷ�ʱ���б�
          begin
              goods_time_list.Delete(i);
          end else begin
                   //��д
                    m:= 0; //ȡ��ʱ��֮ǰ������λ��
                    for k:= 1 to 10 do
                       m:= fastcharpos(ss,',',m+1);

                   ss:= '0,'+ copy(ss,1,m)+ inttostr(tm)+ ',0'; //�۸�Ϊ����
                   goods_time_list.Strings[i]:= ss;
                 end;

        end else begin
                   //�ۼƣ���9ʱ��ʾ���Է������ã�ÿ������һ��
                   j:= strtoint2(ss[1]);
                   inc(j);
                   delete(ss,1,2);
                   ss:= inttostr(j)+ ',' + ss;

                    goods_time_list.Strings[i]:= ss;
                 end;
      end; //end if
   end; //end for

  if goods_time_list.Count= 0 then
     timer3.Enabled:= false;
end;

function TForm_pop.game_get_xtl_values(p, v, t: integer): integer;
  var t2: Tplayer;
begin
   //����vֵ�����������ҷ�����ȫֵ����ֵ��ԭֵ
   //�����ǣ�����id��ֵ�����ͣ��壬�飬Ѫ��
    t2:= game_get_role_from_i(p);
          if t2<> nil then
           begin
            if (v= game_m_quan) or (v= game_m_quan_qi) then
              result:= t2.plvalues[t+ 24]
               else if (v= game_m_ban) or (v= game_m_ban_qi) then
                   result:= t2.plvalues[t+ 24] div 2
                    else result:= v;

           end else result:= 0;

end;

function TForm_pop.game_get_xtl_values_guai(p, v, t: integer): integer;
begin
                       //����vֵ���������ع���ȫֵ����ֵ��ԭֵ
                       //��������ͣ����һ����������Ϊ1��ֻȡ��ֵ
  if p > 4 then
    dec(p,5);
    if (v= game_m_quan) or (v= game_m_quan_qi) then
              result:= net_guai_g[p].ming_gu
               else if (v= game_m_ban) or (v= game_m_ban_qi) then
                   result:= net_guai_g[p].ming_gu div 2
                    else result:= v;
end;

function TForm_pop.game_return_filter(p: integer; type1: integer): Tmtl_rec;
        function get_t_y: integer; //����idȡ��ԭʼֵ
          var t: Tplayer;
         begin
          get_t_y:= 0;
           //pֵ��0-4���ҷ����5-9���з�����
           if p < 5 then
            begin
             t:= game_get_role_from_i(p);
              if t<> nil then
               begin
                 case type1 of
                 1: get_t_y:= t.plvalues[1];
                 2: get_t_y:= t.plvalues[2];
                 3: get_t_y:= t.plvalues[3];
                 4: get_t_y:= t.plvalues[20];
                 5: get_t_y:= t.plvalues[27]; //�̶���
                 6: get_t_y:= t.plvalues[25]; //��
                 7: get_t_y:= t.plvalues[26];  //��
                 end;
               end;
              //�ҷ�����
            end else begin
                       p:= p-5;
                       case type1 of
                       1: get_t_y:= 0;
                       2: get_t_y:= net_guai_g[p].shu;
                       3: get_t_y:= net_guai_g[p].gong;
                       4: get_t_y:= net_guai_g[p].fang;
                       5: get_t_y:= net_guai_g[p].ming_gu;  //��
                       6: get_t_y:= net_guai_g[p].ti_gu;  //��
                       7: get_t_y:= net_guai_g[p].ling_gu;  //��
                       end;
                     end;
         end;
        function get_t(const s: string): integer;
          var i2: integer;
         begin
          i2:= 0;
           case type1 of
            1:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_y1)); //ȡ����ֵ
            2:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_s1)); //ȡ����
            3:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_g1)); //ȡ�ù�
            4:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_f1)); //ȡ�÷���
            5:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_m1)); //��
            6:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_t1)); // ��
            7:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_l1)); // ��

           end;
              //�����Ƿ�ȫ�������������ͷ��غ��ʵ�ֵ
           if (i2= game_m_quan) or (i2 = game_m_quan_qi) then
                   get_t:= get_t_y
                    else if (i2= game_m_ban) or (i2 = game_m_ban_qi) then
                       get_t:= get_t_y div 2
                        else get_t:= i2;

         end;
var i,j,k: integer;
    ss: string;
begin
     result.m.int:= 0;
     result.t.int:= 0;
     result.l.int:= 0;
             {�˺���ÿ�θ���type����������һ����Ӧ��ֵ
             �ָ���Ϊһ�η���ȫ������
             1234�����ٹ���
             567��������}

 if not Assigned(goods_time_list) then
    exit;


                //���� �ˣ��٣�����������ʱ��������ֵ
                //pֵ��0-4���ҷ����5-9���з�����
   for i:= 0 to goods_time_list.Count -1 do
      begin
       if i >= goods_time_list.Count then
           exit;
           
       ss:= goods_time_list.strings[i];
       if ss='' then exit;

       if inttostr(p)= data2.get_game_goods_type_s(ss,goods_type1) then
        begin
          delete(ss,1,2); //ȥ�����׵Ķ�ʱ���
          for k := 2 to 7  do
           begin
             type1:= k;
             j:= get_t(ss);
           //�ж����ʱ��¼ʱ��ȡ����
            case k of
             2: begin
                 if j> abs(result.l.Hi) then  //��
                   begin
                   result.l.Hi:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.l.Hi:= result.l.Hi* -1;
                   end;
             end;
             3: begin
                 if j> abs(result.m.Hi) then  //��
                   begin
                   result.m.Hi:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.m.Hi:= result.m.Hi* -1;
                   end;
             end;
             4: begin
                 if j> abs(result.t.Hi) then  //��
                   begin
                   result.t.Hi:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.t.Hi:= result.t.Hi* -1;
                   end;
             end;
             5: begin
                 if j> abs(result.m.Lo) then  //��
                   begin
                   result.m.Lo:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.m.Lo:= result.m.Lo* -1;
                   end;
             end;
             6: begin
                 if j> abs(result.t.Lo) then  //��
                   begin
                   result.t.Lo:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.t.Lo:= result.t.Lo* -1;
                   end;
             end;
             7: begin
                 if j> abs(result.l.Lo) then  //��
                   begin
                   result.l.Lo:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.l.Lo:= result.L.Lo* -1;
                   end;
             end;
            end; //end case

           end;
        end;

      end; //end for

end;

function TForm_pop.get_r_role_all_count_NoDead: integer;  //ȡ���ҷ�ȫ���ϳ������������������Ѿ�������
var j: integer;
begin
result:= 0;
      for j:= 0 to Game_role_list.Count-1 do
    begin
      if (game_read_values(j,4)= 1) and
         (game_read_values(j,ord(g_life))> 0) then
           inc(result);  //�������������ϳ����ˣ���������������
    end;

  if result> 5 then
   result:= 5;
   
  if result= 0 then
    result:= 1; //��ó������
end;

function TForm_pop.is_can_jingyan(p: integer): boolean; //�Ƿ�ɽ��ܾ���ֵ���������ϳ�������

var t: Tplayer;
begin
result:= false;
     t:= game_get_role_from_i(p);
     if t<> nil then
      begin
        if t.plvalues[ord(g_life)]> 0 then
         result:= true;
      end;


end;

procedure TForm_pop.draw_text_17_m(st1: Tstringlist; flag: integer;
  c: Tcolor);
var aafont: TAAFontEx;
    bmp : TBitmap;
    i: integer; 
begin
   if st1.Count= 0 then
   begin
   G_show_result_b:= false;
    exit;
   end;

    bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
           bmp.Width:=g_result_w1;
           bmp.Height:=g_result_h1;
         {
          flag
          1000 ��Ч��
          1001  ����
          1002  ����
          1003  ģ��
          1004  ����
          1005  ��͸��
          1006  ����δ�ã�

         }

      AAFont := TAAFontEx.Create(bmp.Canvas);

      aafont.Effect.LoadFromIni(game_effect_ini,'AT'+ inttostr(flag));
      aafont.Effect.Shadow.Color:= clblack;
      aafont.Effect.Gradual.StartColor:=c;
      aafont.Effect.Gradual.EndColor:= not c;

      try
        with bmp.Canvas do
        begin
          Font.Name := '����'; // ��������
          Font.Size := 10;
          Font.Color := c;
          Brush.Style := bsClear; // ����͸������
        end;
      //  W := AAFont.TextWidth(S);
      //  H := AAFont.TextHeight(S);
        for i:= 0 to st1.Count- 1 do
          AAFont.TextOut(16, I * 15+ 8, st1.Strings[i]);

        //AAFont.Canvas := Image1.Canvas; // Ҳ�����л�����һ����
        //AAFont.TextOut(10, 10, S); // ����ʱ��ʹ��Image1.Canvas����������
      finally
        AAFont.Free;
      end;



         with image_result1 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;

      bmp.Free;
      //������Ч����

   G_show_result_b:= true;
   g_dangqian_zhuangtai:= G_animation; //��Ϸ���ڶ���״̬
      //������Ч����


end;

function TForm_pop.game_upgrade(p: integer): integer;
var t: Tplayer;
    r: integer;
begin
      //��Ϸ��������������ֵΪ�µļ�����Ϊ���ʾû����

   {
   �������200����
   ���� 2000��ÿ���� 10��
   ���� 10000��ÿ���� 50��
   ���� 5000�� ÿ���� 25��
   ����ֵ����һ��500����һ�����Ժ���ֵ���Եȼ�
   �٣��ǣ�����ÿ����һ��

  }
   result:= 0;
     t:= game_get_role_from_i(p);
     if t<> nil then
      begin
        if t.plvalues[19]>= t.plvalues[ord(g_upgrade)] then
         begin
           //��ȥ�������õľ���ֵ
           t.plvalues[19]:= t.plvalues[19]- t.plvalues[ord(g_upgrade)];

           //���Ӽ������Ӧ������
           t.plvalues[ord(g_grade)]:= t.plvalues[ord(g_grade)] + 1; //��ߵȼ�

             r:= Game_base_random(5) + 8; //���һ�������,��Ϊ��ͷ����
              //���� 2000��ÿ���� 10�㣬��һ����50��
           t.plvalues[ord(g_gdtl25)]:= t.plvalues[ord(g_gdtl25)] + 9 + Game_base_random(5);  //�̶�����
           t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_gdtl25)]; //����
             if t.plvalues[ord(g_grade)] * 12 > t.plvalues[ord(g_gdtl25)] then
               t.plvalues[ord(g_gdtl25)]:= t.plvalues[ord(g_grade)] * 14 + 60; //������������ȼ�����ֵ���͵�bug

           //���� 10000��ÿ���� 50��
            t.plvalues[ord(g_gdll26)]:= t.plvalues[ord(g_gdll26)]+ 40 + Game_base_random(15); //�̶�����
           t.plvalues[ord(g_lingli)]:= t.plvalues[ord(g_gdll26)]; //����
             if t.plvalues[ord(g_grade)] * 44 > t.plvalues[ord(g_gdll26)] then
               t.plvalues[ord(g_gdll26)]:= t.plvalues[ord(g_grade)] * 45 + 100; //������������ȼ�����ֵ���͵�bug

           //���� 5000�� ÿ���� 25��
            t.plvalues[ord(g_gdsmz27)]:= t.plvalues[ord(g_gdsmz27)] + 20 + Game_base_random(8); //�̶�����
           t.plvalues[ord(g_life)]:= t.plvalues[ord(g_gdsmz27)];  //����ֵ
              if t.plvalues[ord(g_grade)] * 23 > t.plvalues[ord(g_gdsmz27)] then
                t.plvalues[ord(g_gdsmz27)]:= t.plvalues[ord(g_grade)] * 25 + 130; //������������ȼ�����ֵ���͵�bug

           t.plvalues[ord(g_upgrade)]:= t.plvalues[ord(g_grade)] * 500 * r div 10; //�´�������Ҫ�ľ���ֵ

            t.plvalues[2]:= t.plvalues[2]+ 1;  //��
             t.plvalues[3]:= t.plvalues[3]+ 5; //��
              t.plvalues[7]:= t.plvalues[7]+ 1;   //��
              t.plvalues[20]:= t.plvalues[20]+ 2; //��

          result:= t.plvalues[ord(g_grade)];
         end;

        if t.plvalues[19]>= t.plvalues[ord(g_upgrade)] then
           result:= game_upgrade(p); //�ݹ����

      end;

end;

procedure TForm_pop.game_hide_role(n: string);
var i: integer;
begin
            //�����˱�����ʱ����ʱ���������ˣ�����Ϊ��Ҫ��ʾ����
    for i:= 1 to Game_role_list.Count-1 do
    begin
      if Tplayer(Game_role_list.Items[i]).pl_old_name = n then
         begin
           //����ԭ���ϳ�ֵ����ʱ
           game_write_values(i,29,
            game_read_values(i,4));
            //��Ҫ��ʾ�����ԭ�Ȳ����Ƿ��ϳ���������
            game_write_values(i,4,1);
         end else begin
                   //����ԭ���ϳ�ֵ����ʱ
                   game_write_values(i,29,
                      game_read_values(i,4));
                    //�ϳ�ֵ��Ϊ��
                   game_write_values(i,4,0);
                  end;
    end;
end;

procedure TForm_pop.game_unhide_role;
var i: integer;
begin
        //ȡ����ʱ����

        for i:= 1 to Game_role_list.Count-1 do
    begin
       game_write_values(i,4,
            game_read_values(i,29));
    end;
end;

procedure TForm_pop.FormClose(Sender: TObject; var Action: TCloseAction);
begin

    text_show_array_G[5].xianshi:= false;
    edit1.Visible:= false;
    Timer_daojishi.Enabled:= false;
 
     if g_particle_rec.xian then
      begin
       g_particle_rec.xian:= false;  //ֹͣ����Ч��
       AsphyreParticles1.Clear;
      end;
      //�˳�ʱ�������Ʒ��ʱ���ڵ���Ʒ

     timer3.Enabled:= false;

     if Assigned(goods_time_list) then
       goods_time_list.Clear;

   //˫�˱����ʣ���������������ָ����ص�����
 if (game_pop_type= 5) or (game_pop_type= 6) then
    game_unhide_role;

 Timer4.Enabled:= false; //�ٶ�ͳ�ƶ�ʱ��ֹͣ
  Timer_donghua.Enabled:= false;

  edit1.text:= '';
  AsphyreTimer1.Enabled:= false;
  if game_pop_type= 7 then
    begin
     if Assigned(wuziqi_tread) then
        begin
        wuziqi_tread.Terminate; //����������ֹͣ
        //wuziqi_tread.WaitFor;
        end;
     {if wuziqi_rec1.cpt_win then
        self.ModalResult:= mrcancel
        else
         self.ModalResult:= mrok;  }
    end;
end;

function TForm_pop.game_fashu__filter(var i: integer): integer;
var j: integer; //�ȼ�
    k: integer; //ʹ�ô���
    t: Tplayer;
    i2: integer;
begin
        //�����ĵȼ����ˣ�����ֵΪ�ȼ����޵ȼ��ķ���10�������������ڴ˹�����
        {
         �����ͼ����Ƕ��ֵ��ϵģ�����ֱ��ʹ�ã�����˵�
        }

      t:= game_get_role_from_i(Fgame_my_cu); //ȡ�õ�ǰ�����ʵ��


      for i2:= 0 to 63 do   //���������ת��Ϊ�������ֵ
       begin
         if get_L_16(t.pl_fa_array[i2])= i then
          begin
            i:= t.pl_fa_array[i2];
            break;
          end;
       end;
      for i2:= 0 to 23 do   //����
       begin
         if get_L_16(t.pl_ji_array[i2])= i then
          begin
            i:= t.pl_ji_array[i2];
            break;
          end;
       end;

      if i< 1024 then
       begin
        result:= 10;
        exit;
       end;

      j:= get_H_8(i); //�õ������ȼ�
      k:= get_HL_8(i); //�õ�ʹ�ô���
      
      //����Ƿ�����
       inc(k);
      if k> 60 then //Ϊ�˱��ֺ���ǰ���ϴ浵����
         k:= 0;


    // t:= game_get_role_from_i(Fgame_my_cu); //ȡ�õ�ǰ�����ʵ��


      for i2:= 0 to 63 do   //����
       begin
         if t.pl_fa_array[i2]= i then
          begin
              case j of
                   1..3: if k= 15 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   4..6: if k= 35 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   7..9: if k= 60 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   end;
                  if j> 10 then
                     j:= 10;
            t.pl_fa_array[i2]:= set_H_8(t.pl_fa_array[i2],j); //д�뷨���ȼ������10��
            t.pl_fa_array[i2]:= set_HL_8(t.pl_fa_array[i2],k);  //д��ʹ�ô������θ�8λ
            break;
          end;
       end;

       for i2:= 0 to 23 do   //����
       begin
         if t.pl_ji_array[i2]= i then
          begin
              case j of
                   1..3: if k= 10 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   4..6: if k= 10 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   7..9: if k= 10 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   end;
                  if j> 10 then
                     j:= 10;
            t.pl_ji_array[i2]:= set_H_8(t.pl_ji_array[i2],j); //д�뷨���ȼ������10��
            t.pl_ji_array[i2]:= set_HL_8(t.pl_ji_array[i2],k);  //д��ʹ�ô������θ�8λ
            break;
          end;
       end;

    i:= get_L_16(i); //���ص�16λֵ
    result:= j;
end;

procedure TForm_pop.game_wordow_Animate(form: Tform);  //��������ʱ�Ķ�������
var
  FDesktopCanvas: TCanvas;
  FDesktopHandle: Hwnd;
  FDesktopBitmap: TPicture;
  SRect: TRect;
  aPos1,aPos2,
  N,FLeft,FTop: Integer;
  KLeft,KTop,KRight,KBottom,
  FStep: Double;
begin
  FDesktopHandle := form1.Handle;
  FDesktopBitmap := TPicture.Create;
  FDesktopCanvas := TCanvas.Create;
  FDesktopBitmap.Bitmap.Width := Screen.Width;
  FDesktopBitmap.Bitmap.Height := Screen.Height;

  FLeft := Form.Left;
  FTop  := Form.Top;
  if Form.Position = poScreenCenter then
  begin
    if Form.FormStyle = fsMDIChild then
    begin
      FLeft := (Application.MainForm.ClientWidth - Form.Width) div 2;
      FTop := (Application.MainForm.ClientHeight - Form.Height) div 2;
    end else
    begin
      FLeft := (Screen.Width - Form.Width) div 2;
      FTop := (Screen.Height - Form.Height) div 2;
    end;
    if FLeft < 0 then FLeft := 0;
    if FTop < 0 then FTop := 0;
  end
  else if Form.Position = poDesktopCenter then
  begin
    if Form.FormStyle = fsMDIChild then
    begin
      FLeft := (Application.MainForm.ClientWidth - Form.Width) div 2;
      FTop := (Application.MainForm.ClientHeight - Form.Height) div 2;
    end else
    begin
      FLeft := (Screen.DesktopWidth - Form.Width) div 2;
      FTop := (Screen.DesktopHeight - Form.Height) div 2;
    end;
    if FLeft < 0 then FLeft := 0;
    if FTop < 0 then FTop := 0;
  end;

  FDesktopCanvas.Handle := GetWindowDC(FDesktopHandle);
  SendMessage(FDesktopHandle, WM_PAINT, integer(FDesktopCanvas.Handle), 0);
  SRect := Rect(0, 0, Screen.Width, Screen.Height);
  FDesktopBitmap.Bitmap.Canvas.CopyRect(SRect,FDesktopCanvas,SRect);

  FDesktopCanvas.Brush.Color := clBtnFace;
  FDesktopCanvas.Brush.Style := bsClear;
  if game_pop_type= 1 then
     FDesktopCanvas.Pen.Color := rgb(173,252,127)
     else
       FDesktopCanvas.Pen.Color := rgb(245,128,78);
  FDesktopCanvas.Pen.Width := 2;
  FDesktopCanvas.Pen.Style := psDot;

  N := Form.Width div 32;
  if N<=0 then
    N := 8;

  aPos1 := (Form.Width div 2)+FLeft;
  aPos2 := (Form.Height div 2)+FTop;
  KTop := aPos2;   KLeft := aPos1;
  KRight  := aPos1;  KBottom := aPos2;

  FStep := Form.Height / Form.Width;
  while KLeft>FLeft do
  begin
    KLeft   := KLeft - N;
    KTop    := KTop - FStep*N;
    KRight  := KRight + N;
    KBottom := KBottom + FStep*N;
    if (KLeft<FLeft) or (KTop<FTop+1) then Break;
    Sleep(25);
    FDesktopCanvas.Rectangle(Trunc(KLeft)+2,Trunc(KTop)+2,Trunc(KRight),Trunc(KBottom));
   // BitBlt(FDesktopCanvas.Handle,Trunc(KLeft),Trunc(KTop),
    //  Trunc(KRight-KLeft),Trunc(KBottom-KTop),
    //  FDesktopBitmap.Bitmap.Canvas.Handle,Trunc(KLeft),Trunc(KTop),SRCCOPY);

  end;
  {BitBlt(FDesktopCanvas.Handle,FLeft,FTop,Width,Height,
      FDesktopBitmap.Canvas.Handle,FLeft,FTop,SRCCOPY);}
  ReleaseDC(0, FDesktopCanvas.Handle);
  FDesktopBitmap.Free;
  FDesktopCanvas.Free;


end;

function TForm_pop.lingli_is_ok(const s: string): boolean;
var t: Tplayer;
    L: integer;
begin
  if f_type_g = 4 then
   begin
    result:= true;
    exit; //������Ʒ�����жϴ�ֵ
   end;
       //�ȶԵ�ǰ����������Ƿ񹻷��ӷ���
  t:= game_get_role_from_i(Fgame_my_cu); //ȡ�õ�ǰ�����ʵ��
  L:= Form_goods.get_goods_id(s); //ȡ����Ʒid
   Assert(L > 0,'��ǰ����Ʒid��Ч');
   L:= data2.get_game_goods_type(L,goods_L1); //�����඼��������

     result:= (L <= t.plvalues[ord(g_lingli)]);
end;

procedure TForm_pop.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
    ListBox1.Canvas.FillRect(Rect);
   {case index mod 5 of
   0: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,5);

       if get_jb= 1 then
        imagelist1.Draw(ListBox1.Canvas,140,rect.top,13);
      end;
   1: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,11);
      end;
   2: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,10);
      end;
   3: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,12);
      end;
   4: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,4);
      end;
   end;  }
     Assert(Index<>-1,'�����Ͷ�Խλ');
     Assert(Index<ListBox1.Items.count,'�����߶�Խλ');
     if fastcharpos(ListBox1.Items[Index],'-',1)= 1 then
        ListBox1.Canvas.Font.Style:= [fsbold]
        else  begin
              ListBox1.Canvas.Font.Style:= [];
              data2.ImageList_sml.Draw(ListBox1.Canvas,rect.left+2,rect.top+3,
                        Game_goods_Index_G[form_goods.get_goods_id(ListBox1.Items[Index])]);
               if odSelected in State then
                ListBox1.Canvas.Font.Color:= clwindow
                else
                  if lingli_is_ok(ListBox1.Items[Index]) then
                      ListBox1.Canvas.Font.Color:= clwindowtext
                     else
                       ListBox1.Canvas.Font.Color:= clred;
              end;

  ListBox1.Canvas.TextOut(Rect.Left+20, Rect.Top+3, ListBox1.Items[Index]);

end;

procedure TForm_pop.CheckBox8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CheckBox8.Checked= false then
   begin
     if game_read_values(0,ord(g_30_yanchi)) = 0 then
       if form1.game_check_goods_nmb('ʱ�������',1)=1 then
         begin
          if messagebox(handle,'����Ҫʹ��һ��ʱ�����������ȡ20��������ʾ���ܣ��Ƿ�ʹ�ã�','ѯ��',mb_yesno or MB_ICONQUESTION)=mryes then
            begin
             form1.game_goods_change_n('ʱ�������',-1);
              game_write_values(0,ord(g_30_yanchi),20);
            end else begin
                       checkbox8.Checked:= true;
                     end;
         end else begin
                   messagebox(handle,'����Ҫ����ʱ������衱����ȡ���ӳ���ʾ��','��ʾ',mb_ok);
                   checkbox8.Checked:= true;
                  end;
   end;
end;

procedure TForm_pop.Timer4Timer(Sender: TObject);
var i: integer;
begin
  //ÿ��10���ۼ��ٶȣ�20���ⶥ��������ʹ���ٶȵıȽ������ٵ�5%
   for i:= 0 to 9 do
    begin
     if game_p_list[i] >= speed_limt_G then
       exit; //��һ���ٶȴ���ָ��ֵ���˳��ٶ��ۼ�
    end;

    //�ٶ��ۼ�
     for i:= 0 to 9 do
      begin
       if i < 5 then
        begin  //�ҷ���Ա�ٶ��ۼ�
         inc(game_p_list[i],game_get_role_su(i));
        end else begin //�з���Ա�ٶ��ۼ�
                  inc(game_p_list[i],game_get_guai_su(i -5)); //������ȥ5
                 end;
      end;

     write_label2_11;
end;

procedure TForm_pop.tili_add_100;
var
    i: integer;
begin
 //�ڱ�����ʱ�������������������С�ڹ̶���������ÿ�����Ӱٷ�֮һ
  for i:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(i,ord(g_tili)) <
          game_read_values(i,ord(g_gdtl25)) then
          begin
            game_write_values(i,ord(g_tili),
             game_read_values(i,ord(g_tili)) +
              game_read_values(i,ord(g_gdtl25)) div 100 + 1);

              if  game_read_values(i,ord(g_tili)) >
                  game_read_values(i,ord(g_gdtl25)) then
                  game_write_values(i,ord(g_tili),
                   game_read_values(i,ord(g_gdtl25)));
          end;

    end;
end;

procedure TForm_pop.ListBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 if ssleft in shift then
 begin
  if abs(mouse_down_xy.y- y)> 5 then
   begin
  if not ListBox1.Dragging then
    begin
     g_Dragging:= true;
    ListBox1.BeginDrag(false);
    end;
   end;
  exit;
 end else
      g_Dragging:= false;

   ListBox1.Tag:= ListBox1.ItemAtPos(Point(X,Y),True);

     if ListBox1.Tag <> listbox1.ItemIndex then
        begin
        listbox1.ItemIndex:= ListBox1.Tag;
        if listbox1.ItemIndex > -1 then
         if listbox1.Canvas.TextWidth(listbox1.Items[listbox1.Itemindex]) > listbox1.ClientWidth then
          begin
          listbox1.Hint:= listbox1.Items[listbox1.Itemindex];
          listbox1.ShowHint:= true;
          end else begin
                    listbox1.Hint:= '';
                    listbox1.ShowHint:= false;
                   end;
        end;
end;

procedure TForm_pop.ListBox1MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
   height:= 22;
end;


procedure TForm_pop.game_kptts_init;
var Reg: TRegistry;
   ss: string;
begin

game_is_sooth:= false;
     (*
  Reg := TRegistry.Create;
    with Reg do
     begin
    RootKey := HKEY_LOCAL_MACHINE;
    if KeyExists('SOFTWARE\Classes\CLSID\{385B9F5A-B588-4050-B787-B2CB7960F27C}\InProcServer32') then
      begin
       OpenKeyReadOnly('SOFTWARE\Classes\CLSID\{385B9F5A-B588-4050-B787-B2CB7960F27C}\InProcServer32');
        ss:= readstring('');
        if FileExists(ss) then
         begin
       try
        kp_tts:= TKDVoice.Create(application);
        kp_tts.InitSoundEngine;
        game_is_sooth:= true;
       except
        kp_tts:= nil;
        game_is_sooth:= false;
       end;
         end;
      end;
    closekey;
    Free;
    end; *)
end;

function TForm_pop.game_get_opengl_info: string;
begin

  result:= '';

end;

procedure TForm_pop.add_to_errorword_list(id: integer);
var i: integer;
begin
//��ӵ��б����ȴ�ָ�봦������ӣ����û�п�λ����ӿ�ͷ��ָ�봦�������һ��
   for i:= game_error_word_list_G[1] to high(game_error_word_list_G) do
       if game_error_word_list_G[i]= 0 then
        begin
          game_error_word_list_G[i]:= id;
          exit;
        end;

   for i:=2 to game_error_word_list_G[1] do
      if game_error_word_list_G[i]= 0 then
        begin
          game_error_word_list_G[i]:= id;
          exit;
        end;
end;

procedure TForm_pop.clear_errorword_list;
begin
   fillchar(game_error_word_list_G,sizeof(game_error_word_list_G),0);
    if game_rep >= 0 then
       game_error_word_list_G[0]:= game_rep;//��ʾ���󵥴��ظ��ļ��
    game_error_word_list_G[1]:= 2; //ָ��ָ���ٽ���һ����ַ
end;

function TForm_pop.get_Word_id: integer;
begin
//��ȡ����ĵ���
//1�����ȼ���Ƿ��д��󵥴ʲ����������������û�����ȡ�����

 if game_error_word_list_G[game_error_word_list_G[1]]= 0 then
  begin
    //���û�г���ĵ������ظ�����ôȡ��������ú������ж�˳���л��߰�����˹
     result:= get_Random_EXX;

  end else begin
             if game_error_word_list_G[0] = 0 then //��ʾ�����������ٱ�
               begin
                 //ȡֵ
                 result:= game_error_word_list_G[game_error_word_list_G[1]];
                 game_error_word_list_G[game_error_word_list_G[1]]:= 0;
                  if game_rep >= 0 then
                     game_error_word_list_G[0]:= game_rep; //����������ֵ
                 inc(game_error_word_list_G[1]); //ָ���һ
                 if game_error_word_list_G[1] > high(game_error_word_list_G) then
                    game_error_word_list_G[1]:= 2; //���ָ�뵽�ף���ô����ͷ

                 if result >= wordlist1.Count then
                    result:= get_Random_EXX;
               end else begin
                          //ֵ��ȥһ  ȡ�����
                          dec(game_error_word_list_G[0]);
                          result:= get_Random_EXX;
                        end;
           end;
  game_dangqian_word_id:= result; //�������ʱ�ţ����ڲ�������б���
end;

procedure TForm_pop.get_word_fen(out f: T_word_QianHouZhui;
  const s: string);
  function qian1: boolean; //����ǰ׺
    var i: integer;
    begin
     qian1:= false;
     for i:= game_word_qianzhui.Count- 1 downto 0 do
       begin
         if fastpos(s,game_word_qianzhui.Strings[i],length(s),length(game_word_qianzhui.Strings[i]),1)> 0 then
          begin
           f.qian_start:= 1;
           f.qian_end:= length(game_word_qianzhui.Strings[i]);
           qian1:= true;
           exit;
          end;
       end;
    end;
  function hou1: boolean; //������׺
    var i: integer;
    begin
     hou1:= false;
     for i:= game_word_houzhui.Count- 1 downto 0 do
       begin
         if Pos(game_word_houzhui.Strings[i],s)=
            (length(s)-length(game_word_houzhui.Strings[i])+ 1) then
          begin
           f.hou_start:= fastpos(s,game_word_houzhui.Strings[i],length(s),length(game_word_houzhui.Strings[i]),1);
           f.hou_end:= length(game_word_houzhui.Strings[i]);
           hou1:= true;
           exit;
          end;
       end;
    end;

begin       //ȡ�õ��ʷ�ɫ
  {0����ɫ  game_m_color
                             1 ǰ׺���ȣ���ȡһ
                             2 ��׺���ȣ���ȡһ
                             3 ǰ׺���ȣ�ȫ��
                             4 ��׺���ȣ�ȫ��
                             game_word_qianzhui,game_word_houzhui
                             }

  case game_m_color of
    1: begin
         if not qian1 then
            hou1;
       end;
    2: begin
         if not hou1 then
            qian1;
       end;
    3: begin
        qian1;
        hou1;
       end;
    4: begin
        hou1;
        qian1;
       end;
    end;

end;

procedure TForm_pop.AsphyreDevice1Initialize(Sender: TObject;
  var Success: Boolean);
   var   ss: string;
begin

 if game_app_path_G= '' then
    game_app_path_G:= ExtractFilePath(application.ExeName);
 ss:= game_app_path_G;

  // װ������
 ASDb1.FileName:= ss + 'fonts.asdb';
 Success:= AsphyreFonts1.LoadFromASDb(ASDb1);
 
 game_beijing_index_i:= 1; //��ʼ���������Ϊ1
 // װ��ͼ��
 if (Success) then
    begin
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\particle.bmp',point(16,16),point(16,16),point(32,32),aqMedium,alMask,true,$FF000000,0);
       if not Success then
        showmessage('��������ͼ��ʧ�ܡ�'+ SysErrorMessage(getlasterror));

   {  for i:= 1 to 7 do
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\bg'+ inttostr(i)+'.jpg',point(640,480),point(640,480),point(1024,512),aqMedium,alNone,false,0,0);

      if not Success then
        showmessage('���뱳��ʧ�ܡ�'+ SysErrorMessage(getlasterror));  }
      //�����ද��++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\jian.jpg',point(64,64),point(64,64),point(256,256),aqMedium,alMask,true,0,0);
       if not Success then
        showmessage('����jianʧ�ܡ�'+ SysErrorMessage(getlasterror));
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\dao.jpg',point(64,64),point(64,64),point(256,256),aqMedium,almask,true,0,0);
        if not Success then
        showmessage('����daoʧ�ܡ�'+ SysErrorMessage(getlasterror));
       //�ҷ�  �������� �ָ�++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wohuifu_f_d.jpg',point(128,128),point(128,128),point(512,512),aqMedium,almask,true,$FF000000,0);
        if not Success then
        showmessage('����wohuifu_f_d.bmpʧ�ܡ�'+ SysErrorMessage(getlasterror));
       //�ҷ��������幥��++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wofashugong_D.jpg',point(128,128),point(128,128),point(512,512),aqMedium,almask,true,$FF000000,0);
        if not Success then
        showmessage('����wofashugong_D.bmpʧ�ܡ�'+ SysErrorMessage(getlasterror));
      //�ҷ�����ȫ�幥��++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wogong_q.jpg',point(256,256),point(256,256),point(512,512),aqMedium,almask,true,0,0);
         if not Success then
        showmessage('����wogong_q.jpgʧ�ܡ�'+ SysErrorMessage(getlasterror));
      //�ҷ���Ʒ���幥��++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wowugong_d.jpg',point(128,128),point(128,128),point(512,512),aqMedium,almask,true,0,0);
        if not Success then
        showmessage('����wowugong_d.bmpʧ�ܡ�'+ SysErrorMessage(getlasterror));
      //�ҷ� ��Ʒ�ָ�++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wupinhuifu_d.jpg',point(128,128),point(128,128),point(512,512),aqMedium,alMask,true,$FF000000,0);
         if not Success then
        showmessage('����wupinhuifu_d.bmpʧ�ܡ�'+ SysErrorMessage(getlasterror));
      //�ҷ�����ȫ��ָ�++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wohuifu_q.jpg',point(256,256),point(256,256),point(512,512),aqMedium,almask,true,0,0);
          if not Success then
        showmessage('����wohuifu_q.jpgʧ�ܡ�'+ SysErrorMessage(getlasterror));
       //�ַ���ȫ�幥��++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\guaigong_q.jpg',point(256,256),point(256,256),point(512,512),aqMedium,almask,true,0,0);
         if not Success then
        showmessage('����guaigong_q.jpgʧ�ܡ�'+ SysErrorMessage(getlasterror));
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\gong.bmp',point(225,150),point(225,150),point(256,256),aqMedium,alNone,false,0,0);
         if not Success then
        showmessage('����gong.bmpʧ�ܡ�'+ SysErrorMessage(getlasterror));
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\gong_xiaoguo.bmp',point(38,36),point(39,36),point(256,64),aqMedium,alNone,false,0,0);
         if not Success then
        showmessage('����gong_xiaoguo.bmpʧ�ܡ�'+ SysErrorMessage(getlasterror));
    end;
   game_init_Success_G:= Success;
end;

procedure TForm_pop.AsphyreTimer1Timer(Sender: TObject);
begin
// ��
  AsphyreDevice1.Render(0, True);

   AsphyreTimer1.Process(1.0);
  // ����
  AsphyreDevice1.Flip();
end;

function RGBA(Red, Green, Blue, Alpha: Cardinal): tcolor4;
begin
 Result:=cColor1( Red or (Green shl 8) or (Blue shl 16) or (Alpha shl 24));
end;

procedure TForm_pop.AsphyreDevice1Render(Sender: TObject);

begin
  //��Ⱦ+++++++++++++++++++++��ʼ

//����ͼ
   if game_not_bg_black then
   begin
   AsphyreCanvas1.Draw(image_bg_1_1, 0, 0, 0, fxNone);
   AsphyreCanvas1.Draw(image_bg_1_2, 512, 0, 0, fxNone);
   end;
   
//��������

   if game_pop_type= 6 then  //��ʾ������
        show_bubble_on_scr;

   if game_pop_type= 7 then  //��ʾ������
      begin
        show_wuziqi_on_src;
        exit;
      end;

   if G_dangqian_zhuangtai =G_word then
     begin
     //����ͼ
     AsphyreCanvas1.DrawEx(image_word,g_danci_weizhi.weizi,Cardinal( 255 or (255 shl 8)
              or (255 shl 16) or (g_danci_weizhi.alpha shl 24)),0, fxBlend);
     //����ͼ

     
    if (game_pic_check_area = G_words_Pic_y) and (G_mus_at= mus_jieshi1) then //���������ʱ��ɫ
     begin
      if g_is_word_right then
        AsphyreCanvas1.TexMap(image_cn1,pBounds4(g_jieshi_weizhi1.weizi.Left,
                                               g_jieshi_weizhi1.weizi.Top,
                                               image_cn1.VisibleSize.X,
                                               image_cn1.VisibleSize.Y),
                                               G_right_color,tcNull,fxBlend)
      else
      AsphyreCanvas1.TexMap(image_cn1,pBounds4(g_jieshi_weizhi1.weizi.Left,
                                               g_jieshi_weizhi1.weizi.Top,
                                               image_cn1.VisibleSize.X,
                                               image_cn1.VisibleSize.Y),
                                               G_checked_color,tcNull,fxBlend);
     end else
      AsphyreCanvas1.DrawEx(image_cn1, g_jieshi_weizhi1.weizi,Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_danci_weizhi.alpha shl 24)), 0, fxBlend);

    if (game_pic_check_area = G_words_Pic_y) and (G_mus_at= mus_jieshi2) then
    begin
      if g_is_word_right then
       AsphyreCanvas1.TexMap(image_cn2,pBounds4(g_jieshi_weizhi2.weizi.Left,
                                               g_jieshi_weizhi2.weizi.Top,
                                               image_cn2.VisibleSize.X,
                                               image_cn2.VisibleSize.Y),
                                               G_right_color,tcNull,fxBlend)
      else
      AsphyreCanvas1.TexMap(image_cn2,pBounds4(g_jieshi_weizhi2.weizi.Left,
                                               g_jieshi_weizhi2.weizi.Top,
                                               image_cn2.VisibleSize.X,
                                               image_cn2.VisibleSize.Y),
                                               G_checked_color,tcNull,fxBlend);
   end else
    AsphyreCanvas1.DrawEx(image_cn2, g_jieshi_weizhi2.weizi,Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_danci_weizhi.alpha shl 24)), 0, fxBlend);

    if (game_pic_check_area = G_words_Pic_y) and (G_mus_at= mus_jieshi3) then
     begin
      if g_is_word_right then
       AsphyreCanvas1.TexMap(image_cn3,pBounds4(g_jieshi_weizhi3.weizi.Left,
                                               g_jieshi_weizhi3.weizi.Top,
                                               image_cn3.VisibleSize.X,
                                               image_cn3.VisibleSize.Y),
                                               G_right_color,tcNull,fxBlend)
      else
      AsphyreCanvas1.TexMap(image_cn3,pBounds4(g_jieshi_weizhi3.weizi.Left,
                                               g_jieshi_weizhi3.weizi.Top,
                                               image_cn3.VisibleSize.X,
                                               image_cn3.VisibleSize.Y),
                                               G_checked_color,tcNull,fxBlend);
    end else
    AsphyreCanvas1.DrawEx(image_cn3, g_jieshi_weizhi3.weizi,Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_danci_weizhi.alpha shl 24)), 0, fxBlend);
    end;

//�ַ���ʾ
    if g_show_text_up then
    AsphyreCanvas1.Draw(image_up, 192, 125, 0, fxBlend);
//�ҷ���ʾ
   if g_show_text_down then
   AsphyreCanvas1.Draw(image_down, 192, 340, 0, fxBlend);

   if game_pop_type= 6 then
       exit; //������ʱ������ʾ���������


//�ҷ�����ͼ
    if g_role_show1 then
      begin
       if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role1)) or g_role_jialiang1 then
        AsphyreCanvas1.TexMap(image_role1,pBounds4(G_C_role_left1,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role1, G_C_role_left1, G_C_role_top, 0, fxNone);
      end;
    if g_role_show2 then
      begin
       if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role2)) or g_role_jialiang2 then
        AsphyreCanvas1.TexMap(image_role2,pBounds4(G_C_role_left2,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role2, G_C_role_left2, G_C_role_top, 0, fxNone);
      end;
    if g_role_show3 then
     begin
      if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role3)) or g_role_jialiang3 then
        AsphyreCanvas1.TexMap(image_role3,pBounds4(G_C_role_left3,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role3, G_C_role_left3, G_C_role_top, 0, fxNone);
     end;
    if g_role_show4 then
     begin
      if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role4)) or g_role_jialiang4 then
        AsphyreCanvas1.TexMap(image_role4,pBounds4(G_C_role_left4,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role4, G_C_role_left4, G_C_role_top, 0, fxNone);
     end;
    if g_role_show5 then
     begin
      if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role5)) or g_role_jialiang5 then
        AsphyreCanvas1.TexMap(image_role5,pBounds4(G_C_role_left5,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role5, G_C_role_left5, G_C_role_top, 0, fxNone);
     end;
//����ͼ
   if g_guai_show1 then
     begin
      if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai1)) or g_guai_jialiang1 then
        AsphyreCanvas1.TexMap(image_guai1,pBounds4(G_C_role_left1,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_guai1, G_C_role_left1, G_C_guai_top, 0, fxNone);
     end;
   if g_guai_show2 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai2))or g_guai_jialiang2 then
        AsphyreCanvas1.TexMap(image_guai2,pBounds4(G_C_role_left2,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai2, G_C_role_left2, G_C_guai_top, 0, fxNone);
    end;
   if g_guai_show3 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai3))or g_guai_jialiang3 then
        AsphyreCanvas1.TexMap(image_guai3,pBounds4(G_C_role_left3,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai3, G_C_role_left3, G_C_guai_top, 0, fxNone);
    end;
   if g_guai_show4 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai4))or g_guai_jialiang4 then
        AsphyreCanvas1.TexMap(image_guai4,pBounds4(G_C_role_left4,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai4, G_C_role_left4, G_C_guai_top, 0, fxNone);
    end;
   if g_guai_show5 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai5))or g_guai_jialiang5 then
        AsphyreCanvas1.TexMap(image_guai5,pBounds4(G_C_role_left5,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai5, G_C_role_left5, G_C_guai_top, 0, fxNone);
    end;
//��������ͼ
  with g_DanTiFaShuGongJi do //���巨������
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wofashugong_D.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_dantiWuPinGongji do //������Ʒ����
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wowugong_d.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_DanTiFaShuHuiFu do //���巨��--�ָ�
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wohuifu_f_d.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_DanTiWuPinHuiFu do //������Ʒ--�ָ�
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wupinhuifu_d.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_QuanTiFaShuGongji do //ȫ��--��������
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wogong_q.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_Quantifashuhuifu do //ȫ��--����--�ָ�
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wohuifu_q.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_Guai_Fashu do //��--����--����ȫ��
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['guaigong_q.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_PuTongGongji do //����-- ��ͨ����
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['jian.jpg'],weizhi.Left, weizhi.top, zhen, fxadd);
   end;
   with G_Guai_PuTongGongji do //��--��ͨ---����
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['dao.jpg'],weizhi.Left, weizhi.top, zhen, FXadd);
   end;



//ʤ��ʧ�ܣ����tu

   if g_show_result_b then
      AsphyreCanvas1.Draw(image_result1, 192,176 , 0, fxblend);

//�ҷ��������Դ���
     with g_gong do
      begin
      if xianshi then
       begin
         AsphyreCanvas1.Drawex(AsphyreImages1.Image['gong.bmp'],weizhi.Left, weizhi.top,
         Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_gong.alpha shl 24)),0, FXblend);

         if g_icon.xianshi then
            AsphyreCanvas1.Drawex(g_icon_image, g_icon.weizhi.left, g_icon.weizhi.top,
             Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_gong.alpha shl 24)),0, fxBlend);
         if g_gong_xiaoguo.xianshi then //���������
            AsphyreCanvas1.Draw(AsphyreImages1.Image['gong_xiaoguo.bmp'],g_gong_xiaoguo.weizhi.Left, g_gong_xiaoguo.weizhi.top, g_gong_xiaoguo.zhen, FXblend);
       end;
      end;

 //ֵƮ��
     with text_show_array_G[0] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[1] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[2] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[3] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[4] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[5] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
   // AsphyreCanvas1.Draw(AsphyreImages1.Image['gunzi.image'], 240, 0, 0, fxBlend);
   if g_particle_rec.xian then
      AsphyreParticles1.Render;
 //��Ⱦ����
end;

procedure TForm_pop.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not game_musmv_ready then
    exit;
  if game_pop_type= 7 then  //��ʾ������
        exit;

 //G_mus_at:= mus_nil;
 if game_pic_check_area<> G_all_pic_n then
  begin
   //��ȡ������ڵ����
    if game_pic_check_area = G_g_pic_y then   //�ֿ�ѡ
     begin
      if (y> G_C_guai_top) and (y < G_C_guai_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width) then
          G_mus_at:= mus_guai1
           else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width) then
                     G_mus_at:= mus_guai2
                     else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width) then
                     G_mus_at:= mus_guai3
                     else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width) then
                     G_mus_at:= mus_guai4
                     else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
                     G_mus_at:= mus_guai5
                     else G_mus_at:= mus_nil;
       end;
     end;

    if game_pic_check_area = G_my_pic_y then   //�ҷ���ѡ
     begin
      if (y> G_C_role_top) and (y < G_C_role_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width)then
          G_mus_at:= mus_role1
          else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width)then
          G_mus_at:= mus_role2
          else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width)then
          G_mus_at:= mus_role3
          else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width)then
          G_mus_at:= mus_role4
          else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
          G_mus_at:= mus_role5
          else G_mus_at:= mus_nil;
       end;
     end;

    if  game_pic_check_area = G_words_Pic_y then   //���ʿ�ѡ
      begin
        if (x> g_jieshi_weizhi1.weizi.Left) and (x < g_jieshi_weizhi1.weizi.Right)
          and (y> g_jieshi_weizhi1.weizi.Top) and (y < g_jieshi_weizhi1.weizi.Bottom) then
          begin
           if G_mus_at<> mus_jieshi1 then
            begin
             G_mus_at:= mus_jieshi1;
              g_timer_count_5:= 0;
              timer5.Enabled:= true;
            end;
          end else if (x> g_jieshi_weizhi2.weizi.Left) and (x < g_jieshi_weizhi2.weizi.Right)
          and (y> g_jieshi_weizhi2.weizi.Top) and (y < g_jieshi_weizhi2.weizi.Bottom) then
          begin
           if G_mus_at<> mus_jieshi2 then
            begin
              G_mus_at:= mus_jieshi2;
              g_timer_count_5:= 0;
              timer5.Enabled:= true;
            end;
          end else if (x> g_jieshi_weizhi3.weizi.Left) and (x < g_jieshi_weizhi3.weizi.Right)
          and (y> g_jieshi_weizhi3.weizi.Top) and (y < g_jieshi_weizhi3.weizi.Bottom) then
          begin
            if G_mus_at<> mus_jieshi3 then
             begin
              G_mus_at:= mus_jieshi3;
              g_timer_count_5:= 0;
              timer5.Enabled:= true;
             end;
          end else G_mus_at:= mus_nil;
      end;
   end else G_mus_at:= mus_nil;

   //����hint++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     show_text_hint('');
   if (y> G_C_guai_top) and (y < G_C_guai_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width) then
          show_text_hint(g_hint_array_g[5])
           else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[6])
                     else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[7])
                     else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[8])
                     else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[9]);
       end;

    if (y> G_C_role_top) and (y < G_C_role_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[0])
          else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[1])
          else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[2])
          else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[3])
          else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
          show_text_hint(g_hint_array_g[4]);
       end;
   //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if g_gong.xianshi then
     begin
      if g_gong.time=0 then
      begin
      if (y> 270) and (y < 306) then
      begin
       if (x > 349) and (x< 386)  then
          begin
          g_gong_xiaoguo.weizhi.Left:= 349;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 0;
          show_text_hint('�Թ�ʹ��������������ݼ� G');
          end else if (x > 392) and (x< 430) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 392;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 1;
          show_text_hint('���ڷ���״̬���ɼ����˺�����ݼ� F');
          end else if (x > 437) and (x< 475) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 436;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 2;
          show_text_hint('ѡ��һ���������������ṩ����Ĺ���Ч������ݼ� S');
          end else if (x > 480) and (x< 518) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 481;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 3;
          show_text_hint('ʹ����Ʒ��������ֵ�������ȣ�����ʹ�ð�����������ݼ� W');
          end else if (x > 521) and (x< 550) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 521;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 4;
          show_text_hint('�˳�ս���������ܲ�һ���ܳɹ����������ٶ�ֵ�йء���ݼ� T');
          end else g_gong_xiaoguo.xianshi:= false;
      end else g_gong_xiaoguo.xianshi:= false;
      end else g_gong_xiaoguo.xianshi:= false;
     end;


end;

function wuziqi_result: integer; //��������������0��ʾ������1��ʾʧ�ܣ�2��ʾʤ����3��ʾ����
var i,j,k,tmp: integer;
    t1,t2: tpoint;
    b: boolean;
    label pp;
begin
  //g_ball_color_me
  result:= 0;
  k:= 0;
  for i:= 0 to 14 do
  begin
   tmp:= 0; //�������ӵ�����
   b:= false;
   for j:= 1 to 14 do
    begin
     if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i,j-1]).Bytes[3]) then
        begin
         inc(tmp);
         if not b then
          begin
            b:= true;
            t1.X:= j-1;
            t1.Y:= i;
          end;
         if tmp > k then
           begin
            k:= tmp;
            t2.X:= j;
            t2.Y:= i;
            result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
           end;
        end else tmp:= 0;
    end; // for j
    if k >= 4 then
     goto pp;
  end; // for i

  for j:= 0 to 14 do
  begin
   tmp:= 0; //�������ӵ�����
   b:= false;
   for i:= 1 to 14 do
    begin
     if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i-1,j]).Bytes[3]) then
        begin
         inc(tmp);
         if not b then
          begin
            b:= true;
            t1.X:= j;
            t1.Y:= i-1;
          end;
         if tmp > k then
           begin
            k:= tmp;
            t2.X:= j;
            t2.Y:= i;
            result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
           end;
        end else tmp:= 0;
    end; // for j
    if k >= 4 then
     goto pp;
  end; // for i

  k:= 0;
   //��б
  for i:= 0 to 10 do
   begin
     for j:= 0 to 10 do
      begin
        if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+1,j+1]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+2,j+2]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+3,j+3]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+4,j+4]).Bytes[3]) then
        begin
          t1.X:= j;
          t1.Y:= i;
          t2.X:= j+ 4;
          t2.Y:= i +4;
          k:= 5;
          result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
          goto pp;
        end;
      end; // for j
   end;// for i

   //��б
  for i:= 0 to 10 do
   begin
     for j:= 4 to 14 do
      begin
        if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+1,j-1]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+2,j-2]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+3,j-3]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+4,j-4]).Bytes[3]) then
        begin
          t1.X:= j;
          t1.Y:= i;
          t2.X:= j- 4;
          t2.Y:= i +4;
          k:= 5;
          result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
          goto pp;
        end;
      end; // for j
   end;// for i

   pp:
   if k>= 4 then
           begin
            with wuziqi_rec1 do
              begin
              x0:= t1.x * 32 +68;
              y0:= t1.y * 32 +16;
              x1:= t2.x * 32 +68;
              y1:= t2.y * 32 +16;
              xy0:= true;
              end;

             if result= g_ball_color_cpt then
                result:= 1
                else
                 result:= 2; //�ҷ�ʤ��
           end else result:= 0;
end;

procedure wuziqi_shengli;
var i,j: integer;
begin
   form_pop.g_tiankong:=true; //��ֹ������ʾ
   case form_pop.game_pop_count of
   0: begin
        i:= 100;
        j:= 200;
      end;
   1: begin
        i:= 200;
        j:= 400;
      end;
   2: begin
        i:= 400;
        j:= 500;
      end;
   3: begin
        i:= 800;
        j:= 700;
      end;
   4: begin
        i:= 1600;
        j:= 900;
      end;
   else
    i:= 100;
    j:= 100;
   end;
   form1.game_attribute_change(0,19,i); //ȫ�����Ӿ���ֵ
   form1.game_attribute_change(1,0,j); //���ӽ�Ǯ
   form_pop.draw_asw('����ʤ��ȫ��Ӿ���'+inttostr(i)+' �ӽ�Ǯ'+inttostr(j),0,0);
   wuziqi_rec1.word_showing:= true;
   form_pop.G_game_delay(3000);
   wuziqi_rec1.cpt_win:= false;
   form_pop.ModalResult:= mrok;
end;

procedure TForm_pop.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var t: Tpoint;
begin
  if game_pop_type= 7 then  //������
     begin
       if g_dangqian_zhuangtai= g_wuziqi1 then
       begin
       GetCursorPos(T);
       t:= panel1.ScreenToClient(t);
       if (t.X< 52) or (t.X> 531) or (t.Y< 0) or (t.Y>479) then
         exit;
         x:= (t.X-52) div 32;
         y:= t.Y div 32;
       if LongRec(bubble_boll_g_array[y,x]).Bytes[3]= 0 then
         begin
          if (t.Y mod 32 in[8..24]) and ((t.X-52) mod 32 in[8..24]) then
           begin
             g_dangqian_zhuangtai:= g_wuziqi2;
             LongRec(bubble_boll_g_array[y,x]).Bytes[3]:= g_ball_color_me;
             inc(wuziqi_rec1.me_count);
             wuziqi_rec1.me_row:= y;
             wuziqi_rec1.me_col:= X;
             wuziqi_rec1.row:= y;
             wuziqi_rec1.col:= X;
             form1.game_attribute_change(0,19,3); //ȫ�����Ӿ���ֵ3
             show_ad(1); //��ʾ��棬����ʮ����֮��
             statusbar1.Panels[0].Text:= 'ȫ�����Ӿ���ֵ3������˼���С���';
             if wuziqi_result=2 then //��������������0��ʾ������1��ʾʧ�ܣ�2��ʾʤ����3��ʾ����
             begin
              wuziqi_shengli; //�������ʤ
             end
             else begin
                   
                   wuziqi_sendstr('turn '+ inttostr(x)+','+ inttostr(y));
                  end;
           end;
         end;

       end;
        exit;
     end;

  if (not game_musmv_ready) or edit1.Visible then
    exit;

    if g_gong.xianshi then
    begin
     if g_gong_xiaoguo.xianshi then
      begin
      case g_gong_xiaoguo.zhen of
      0: Button1Click(self);
      1: Button2Click(self);
      2: Button3Click(self);
      3: Button4Click(self);
      4: Button5Click(self);
      end;
      end;
    end;

         case game_pic_check_area of
              G_g_pic_y: begin
                          //����gl�����ѡ��ʱ�����
                          //�ҷ�����������Ϊ�����ߣ�����id�͹�����ʽ��0Ϊ��ͨ����������ֵΪ������������
                          if mbRight = Button then
                          begin
                           game_pic_check_area:= G_all_pic_n;
                           //groupbox3.Visible:= true;
                           g_gong.xianshi:= true;
                          end;
                         end;
              G_my_pic_y:begin
                          //�ҷ���Ա����ͼƬ��ѡ�� ʱ�����
                          if mbRight = Button then
                          begin
                           game_pic_check_area:= G_all_pic_n;
                           //groupbox3.Visible:= true;
                           g_gong.xianshi:= true;
                          end;
                         end;

              end; //end case

   if game_pic_check_area= G_all_pic_n then
       exit; //�˳�



               case game_pic_check_area of
                 G_words_Pic_y: begin
                                 case G_mus_at of
                                  mus_jieshi1: check_asw(0,false);
                                  mus_jieshi2: check_asw(1,false);
                                  mus_jieshi3: check_asw(2,false);
                                 end;
                                 if mbRight = Button then //��ӵ��ʵ������б�
                                      add_to_errorword_list(game_dangqian_word_id);
                                end;
                 G_g_pic_y: begin
                          //����gl�����ѡ��ʱ�����
                          //�ҷ�����������Ϊ�����ߣ�����id�͹�����ʽ��0Ϊ��ͨ����������ֵΪ������������
                           case G_mus_at of
                            mus_guai1:  My_Attack(Fgame_my_cu,0,F_Attack_type);
                            mus_guai2:  My_Attack(Fgame_my_cu,1,F_Attack_type);
                            mus_guai3:  My_Attack(Fgame_my_cu,2,F_Attack_type);
                            mus_guai4:  My_Attack(Fgame_my_cu,3,F_Attack_type);
                            mus_guai5:  My_Attack(Fgame_my_cu,4,F_Attack_type);
                           end;
                         end;
              G_my_pic_y:begin
                          //�ҷ���Ա����ͼƬ��ѡ�� ʱ�����
                          case G_mus_at of
                           mus_role1: My_comeback(Fgame_my_cu,0,F_Attack_type);
                           mus_role2: My_comeback(Fgame_my_cu,1,F_Attack_type);
                           mus_role3: My_comeback(Fgame_my_cu,2,F_Attack_type);
                           mus_role4: My_comeback(Fgame_my_cu,3,F_Attack_type);
                           mus_role5: My_comeback(Fgame_my_cu,4,F_Attack_type);
                          end;
                         end;
              end; //end case


end;

procedure TForm_pop.Timer_donghuaTimer(Sender: TObject);
begin
 {
  if yodao_time> 0 then
    begin
      dec(yodao_time);
      if yodao_time= 10 then
         skp_string(jit_words);
    end; }
  if wuziqi_rec1.word_showing then
   begin
    //�����屳����
    if (wuziqi_rec1.word_time<= 0) and (g_dangqian_zhuangtai= g_wuziqi1) then
       wuziqi_rec1.word_showing:= false;

     dec(wuziqi_rec1.word_time);
    exit;
   end;

 if time_list1.Timer_donghua then
 begin
  case g_danci_donghua_id of
   0: go_amt_00(G_danci_donghua_count);
   1: go_amt_01(G_danci_donghua_count);
   2: go_amt_02(G_danci_donghua_count);
   3: go_amt_03(G_danci_donghua_count);
   4: go_amt_04(G_danci_donghua_count);
   5: go_amt_05(G_danci_donghua_count);
   6: go_amt_06(G_danci_donghua_count);
  end;
   G_dangqian_zhuangtai:=G_word; //��ʾ���ʻ���

   if G_danci_donghua_count = game_amt_length then
   begin
    time_list1.Timer_donghua:= false;
      AsphyreTimer1Timer(self); //�ػ�
    game_musmv_ready:= true;

      if game_bg_music_rc_g.type_word and
      (g_is_tingli_b=false) and (g_tiankong=false) then
      begin
      //��ʾ����򣬲���������ʱ��

       edit1.SetBounds(g_jieshi_weizhi2.weizi.Left + panel1.Left,
                       g_jieshi_weizhi2.weizi.Top + panel1.Top,
                       g_jieshi_weizhi2.weizi.Right- g_jieshi_weizhi2.weizi.Left,
                       g_jieshi_weizhi2.weizi.Bottom - g_jieshi_weizhi2.weizi.Top);

      
        text_show_array_G[5].left1:= g_jieshi_weizhi2.weizi.Right + 9;
        text_show_array_G[5].top1:=  g_jieshi_weizhi2.weizi.Top;
       if timer1.Enabled= false then
        begin
         edit1.Visible:= true;
         create_edit_bmp(game_word_1); //������ͼ
         edit1.Repaint;
         edit1.SetFocus;
         Timer_daojishi.Tag:= 600;
         Timer_daojishi.Enabled:= true;
        end;
      end;

     //��������
      if checkbox2.Checked then
     begin
     {$IFDEF IBM_SPK}
     jit_spk1.spk:= Jit_words;
      postthreadmessage(jit_spk1.ThreadID,um_ontimer,0,0);
     {$ENDIF}

     {$IFDEF MS_SPK}
       skp_string(Jit_words);
       //  ΢��speck;
      {$ENDIF}

     end;
   end;
   inc(G_danci_donghua_count);
  end;

  if time_list1.Timer_wo_gongji then
     Timer_wo_gongjiTimer;
  if time_list1.Timer_guai_gongji then
     Timer_guai_gongjiTimer;
  if time_list1.Timer_wo_fashugongji then
     Timer_wo_fashugongjiTimer;
  if time_list1.Timer_guai_fashugongji then
     Timer_guai_fashugongjiTimer;
  if time_list1.Timer_wupin_gongji then
     Timer_wupin_gongjiTimer;
  if time_list1.Timer_wupin_huifu then
     Timer_wupin_huifuTimer;
  if time_list1.Timer_fashu_huifu then
     Timer_fashu_huifuTimer;
  if time_list1.Timer_gong then
     Timer_gongTimer;
  if time_list1.Timer_bubble then
     Timer_bubbleTimer;  //���������򶯻��ڼ�
end;

procedure TForm_pop.g_game_delay(i: integer);
   var t,t2: cardinal;
begin
  t:= GetTickCount;
  t2:= i;
    AsphyreTimer1.Enabled:= false;
    while GetTickCount - t < t2 do
     begin
      AsphyreTimer1Timer(self);
      AsphyreTimer1Process(self);
      application.ProcessMessages;
       sleep(10);
     end;
     AsphyreTimer1.Enabled:= true;
end;

procedure TForm_pop.g_guai_A_next;
begin
 //�۳�Ѫ��
      // game_guai_Attack_blood(t,g,game_get_Attack_value(z,g2));
        game_guai_Attack_blood;

   un_highlight_my(-1);  //�ָ�����
   un_highlight_guai(-1);
   //�ػ��ҷ���Ա
   // draw_game_role(get_pid_from_showId(sid_to_roleId(mtl_game_cmd_dh1.js_sid)));
      draw_game_role(sid_to_roleId(mtl_game_cmd_dh1.js_sid));

    //�жϽ��
    game_fight_result_adv; //�жϽ��
end;

procedure TForm_pop.g_wo_A_next;
begin
  //�۳�Ѫ��
      // game_my_Attack_blood(m,p,game_get_my_Attack_value(d));

      { ���ڹ�����ֵ�Ѿ���������Թ�����Ŀ�Ѫ��ֻ�����Ԥ������������
      }
       game_my_Attack_blood;
   un_highlight_guai(-1);  //�ָ�����
   un_highlight_my(-1);

   //�ػ��ҷ���Ա
      draw_game_role(sid_to_roleId(mtl_game_cmd_dh1.fq_sid));

      draw_game_guai(sid_to_roleId(mtl_game_cmd_dh1.js_sid)); //�ػ���

    //�жϽ��
     game_fight_result_adv; //�жϽ��
end;

procedure TForm_pop.Timer_wo_gongjiTimer;
begin
    //�ҷ��������� ��ʱ
       //����-- ��ͨ���� ���� 16 ֡
        //1����ȡ������������꣬��ȡ��������������꣬ȡ�ò�ֵ
       //2.��ȡ������top�ͱ�������top��ȡ�ò�ֵ

       G_PuTongGongji.zhen:= (game_amt_length- G_PuTongGongji.time) div 4;
       G_PuTongGongji.weizhi.Top:= round(G_C_role_top * (G_PuTongGongji.time / game_amt_length)) + G_C_guai_top;
        if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)= sid_to_roleId(mtl_game_cmd_dh1.js_sid) then  //���λ����ͬ��ֱ��ʹ�ù̶�����
          G_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))
          else begin
                 if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)> sid_to_roleId(mtl_game_cmd_dh1.js_sid) then
                   begin
                    //�ҷ���Ŵ��ڹ֣��������Ӵ���С�仯
                    G_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) + round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))) *
                       (G_PuTongGongji.time / game_amt_length));
                   end else begin  //��Ŵ�С���仯
                            G_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) - round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))) *
                       (G_PuTongGongji.time / game_amt_length));
                            end;
               end;

      G_PuTongGongji.xianshi:= true;
    if G_PuTongGongji.time= 0 then
       begin
       time_list1.Timer_wo_gongji:= false;
       G_PuTongGongji.xianshi:= false;
       g_wo_A_next;
       end;
     dec(G_PuTongGongji.time);
end;

procedure TForm_pop.Timer_guai_gongjiTimer;
begin
   //���﹥������ ��ʱ 16 zhen

       G_Guai_PuTongGongji.zhen:= (game_amt_length- G_Guai_PuTongGongji.time) div 4;

       G_Guai_PuTongGongji.weizhi.Top:= G_C_role_top- round((G_C_role_top- G_C_Guai_top) * (G_Guai_PuTongGongji.time / game_amt_length));

        if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)= sid_to_roleId(mtl_game_cmd_dh1.js_sid) then  //���λ����ͬ��ֱ��ʹ�ù̶�����
          G_Guai_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))
          else begin
                 if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)> sid_to_roleId(mtl_game_cmd_dh1.js_sid) then
                   begin
                    //�ַ���Ŵ����ң��������Ӵ���С�仯
                    G_Guai_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) + round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))) *
                       (G_Guai_PuTongGongji.time / game_amt_length));
                   end else begin  //��Ŵ�С���仯
                            G_Guai_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) - round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))) *
                       (G_Guai_PuTongGongji.time / game_amt_length));
                            end;
               end;

      G_Guai_PuTongGongji.xianshi:= true;
   if G_Guai_PuTongGongji.time= 0 then
       begin
       time_list1.Timer_guai_gongji:= false;
       G_Guai_PuTongGongji.xianshi:= false;
       g_guai_A_next;
       end;
     dec(G_Guai_PuTongGongji.time);
end;

procedure TForm_pop.Timer_wo_fashugongjiTimer;
begin
    //�ҷ������� ���塢ȫ�� ������ʱ��Pattern���㿪ʼ
          

 if sid_to_roleId(mtl_game_cmd_dh1.js_sid)= -1 then //ȫ�幥������ 4 ֡����ʮ֡�����漸֡�̶�����
  begin
     g_quanTiFaShuGongJi.zhen:= (game_amt_length-g_quanTiFaShuGongJi.time) div 6;
     g_quanTiFaShuGongJi.weizhi.Left:= 160;
     g_quanTiFaShuGongJi.weizhi.top:= 120;
    g_quanTiFaShuGongJi.xianshi:= true;
    if g_quanTiFaShuGongJi.time= 0 then
    begin
    time_list1.Timer_wo_fashugongji:= false;
    g_quanTiFaShuGongJi.xianshi:= false;
    g_wo_A_next;
    end;
      if game_amt_length = g_quanTiFaShuGongJi.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(4);  //�ҷ���ȫ�幥��������
    end;
    dec(g_quanTiFaShuGongJi.time);
  end else begin
               //���幥�� 16 zhen
                g_DanTiFaShuGongJi.zhen:= (game_amt_length- g_DanTiFaShuGongJi.time) div 4;
                g_DanTiFaShuGongJi.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));  //�ֵ�����
                g_DanTiFaShuGongJi.weizhi.top:= G_C_Guai_top;
              g_DanTiFaShuGongJi.xianshi:= true;
             if g_DanTiFaShuGongJi.time= 0 then
                begin
                 time_list1.Timer_wo_fashugongji:= false;
                 g_DanTiFaShuGongJi.xianshi:= false;
                 g_wo_A_next;
                end;
                if game_amt_length = g_DanTiFaShuGongJi.time then
                 begin
                 if gamesave1.tip5= 0 then
                   play_sound(3);  //�ҷ������幥��������
                 end;
               dec(g_DanTiFaShuGongJi.time);
          end;
end;

procedure TForm_pop.Timer_guai_fashugongjiTimer;
begin
    //�ַ������� ȫ�� ������ʱ 10 ֡
                  G_Guai_Fashu.zhen:= (game_amt_length- G_Guai_Fashu.time) div 6;
                  G_Guai_Fashu.weizhi.Left:= 160;
                  G_Guai_Fashu.weizhi.top:= 120;
            G_Guai_Fashu.xianshi:= true;
           if G_Guai_Fashu.time= 0 then
                begin
                 Time_list1.Timer_guai_fashugongji:= false;
                 G_Guai_Fashu.xianshi:= false;
                 g_guai_A_next;
                end;

  if game_amt_length = G_Guai_Fashu.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(5);  //�ַ�������������
    end;

               dec(G_Guai_Fashu.time);
end;

procedure TForm_pop.Timer_wupin_gongjiTimer;
begin
    //�ҷ���Ʒ���� ������ʱ 16 ֡

         G_dantiWuPinGongji.zhen:= 15- G_dantiWuPinGongji.time div 4;
         G_dantiWuPinGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));  //��
         G_dantiWuPinGongji.weizhi.top:= G_C_Guai_top;

      G_dantiWuPinGongji.xianshi:= true;
    if G_dantiWuPinGongji.time= 0 then
       begin
       time_list1.Timer_wupin_gongji:= false;
       G_dantiWuPinGongji.xianshi:= false;
       g_wo_A_next;
       end;

     if game_amt_length = G_dantiWuPinGongji.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(2);  //��Ʒ�����������
    end;

     dec(G_dantiWuPinGongji.time);
end;

procedure TForm_pop.Timer_wupin_huifuTimer;
begin
  //�ҷ���Ʒ �ָ� ������ʱ 16 ֡
             G_DanTiWuPinHuiFu.zhen:= (game_amt_length- G_DanTiWuPinHuiFu.time) div 4;
             G_DanTiWuPinHuiFu.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));
             G_DanTiWuPinHuiFu.weizhi.top:= G_C_role_top + game_bmp_role_h -156; //��ȥͼ���
     G_DanTiWuPinHuiFu.xianshi:= true;
   if G_DanTiWuPinHuiFu.time= 0 then
       begin
       time_list1.Timer_wupin_huifu:= false;
       G_DanTiWuPinHuiFu.xianshi:= false;
       G_huifu_next;  //�ָ�����������
       end;
   if game_amt_length = G_DanTiWuPinHuiFu.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(0);  //������Ʒ�������
    end;

     dec(G_DanTiWuPinHuiFu.time);
end;

procedure TForm_pop.Timer_fashu_huifuTimer;
begin
    //�����ָ� ���塢ȫ�� ������ʱ

   if sid_to_roleId(mtl_game_cmd_dh1.js_sid)= -1 then //ȫ�巨���ָ� 10֡
  begin
           G_quanTiFaShuHuiFu.zhen:= (game_amt_length- G_quanTiFaShuHuiFu.time) div 6;
           G_quanTiFaShuHuiFu.weizhi.Left:= 160;
           G_quanTiFaShuHuiFu.weizhi.top:= 120;
    G_quanTiFaShuHuiFu.xianshi:= true;
    if G_quanTiFaShuHuiFu.time<= 0 then
    begin
    time_list1.Timer_fashu_huifu:= false;
    G_quanTiFaShuHuiFu.xianshi:= false;
    G_huifu_next;   //�ָ�����������
    end;
    if game_amt_length = G_quanTiFaShuHuiFu.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(8);  //ȫ�巨���ָ�������
    end;
    dec(G_quanTiFaShuHuiFu.time);
  end else begin
               //���巨���ָ� 16 ֡
                    G_DanTiFaShuHuiFu.zhen:= (game_amt_length- G_DanTiFaShuHuiFu.time) div 4;
                    G_DanTiFaShuHuiFu.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));
                    G_DanTiFaShuHuiFu.weizhi.top:= G_C_role_top+ game_bmp_role_h -156; //��ȥͼ���;
               G_DanTiFaShuHuiFu.xianshi:= true;
             if G_DanTiFaShuHuiFu.time= 0 then
                begin
                 time_list1.Timer_fashu_huifu:= false;
                 G_DanTiFaShuHuiFu.xianshi:= false;
                 G_huifu_next;
                end;
             if game_amt_length = G_DanTiFaShuHuiFu.time then
                 begin
               if gamesave1.tip5= 0 then
                  play_sound(1);  //���巨���ָ�������
                 end;
               dec(G_DanTiFaShuHuiFu.time);
          end;
end;


function TForm_pop.g_get_roleAndGuai_left(i: integer): integer;
begin
result:= 0;
    if i> 4 then
       i:= i -5;

    case i of
     0: result:= G_C_role_left1;
     1: result:= G_C_role_left2;
     2: result:= G_C_role_left3;
     3: result:= G_C_role_left4;
     4: result:= G_C_role_left5;
     end;
end;


procedure TForm_pop.G_huifu_next;   //�ָ�����������
begin
  un_highlight_my(-1);
   draw_game_role(-1); //�ػ�ȫ��
   game_pic_check_area:= G_all_pic_n; //ȫ�ֽ�ֹѡ��
   show_text(false,'');


   game_fight_result_adv; //�жϽ��
end;

procedure TForm_pop.Timer_gongTimer;
var bmp: tbitmap;
    tpl: Tplayer;
begin
    //�ҷ��������ڳ��ֵĶ���
     if GameSave1.tip3=0 then
      begin
    g_gong.weizhi.Left:= g_gong.weizhi.Left- 2;
    g_icon.weizhi.Left:= g_gong.weizhi.Left + 81; //Сͷ��λ��
     g_icon.weizhi.top:= g_gong.weizhi.top + 37;
      end else begin
                 g_gong.weizhi.Left:= 340;
                 g_icon.weizhi.Left:= g_gong.weizhi.Left + 81; //Сͷ��λ��
                 g_icon.weizhi.top:= g_gong.weizhi.top + 37;
               end;

     if g_gong.time= game_amt_length then
      begin
        bmp:= tbitmap.Create;
        tpl:= game_get_role_from_i(Fgame_my_cu);
        with g_icon_image do
        begin
        data2.ImageList2.GetBitmap(tpl.plvalues[ord(g_Icon_index)]+ 1,bmp);
        LoadFromBitmap(bmp,false,0,0);
        end;
       bmp.Free;
       g_icon.xianshi:= true;
       show_fashuwupin_k(tpl.pl_old_name);
      end;

    dec(g_gong.time);

    if GameSave1.tip4=0 then
       g_gong.alpha:= weizhi_get_alpha(game_amt_length- g_gong.time);

    if g_gong.time= 0 then
     time_list1.Timer_gong:= false;

      g_gong.xianshi:= true;
      g_gong_xiaoguo.xianshi:= false;
  //reshow_su; //����ǡ�������������ʾ
end;

procedure TForm_pop.g_miao_shou(g_id,s_id: integer); //�ӹ�����͵��ʲô
var b: boolean;
    v: integer;
    k: Tmtl_rec;
    label pp;
begin
    //�������Ϊ����id�ͷ���id
    
    //�жϹ����ͣ�����ǻ�ħ���Ĺ֣�ֻ͵Ǯ����Ϊ����ִ����boss��������Ʒһ��������ģ����ʺ϶��͵��
    //�������͵Ĺ֣�����֮һ��͵Ǯ������֮һ��͵��

   if g_id>= 5 then
     g_id:= g_id -5;

  if net_guai_g[g_id].sid< (g_nil_user_c- 10) then
   begin
     //��������Ĺ֣�����͵
    draw_text_17('�����ֹ',1000,clblack);
    g_game_delay(500);
    goto pp;
   end;
  
  if loc_guai_g[g_id].fa_wu<= 0 then
    begin
     b:= (Game_base_random(2)= 0);

    end else begin
              b:= true; //͵Ǯ
             end;

    if b then
     v:= loc_guai_g[g_id].qian //Ǯ
      else
       v:= loc_guai_g[g_id].wu_diao; //��

       sleep(10);
       k:= game_get_my_Attack_value(s_id);  //���ص��Ǹ���
        {���ֵĿ�ѪֵΪ10������10��ʱΪ20��ֵ�����ﷵ���Ǹ���}
       if Game_base_random(23) <= abs(k.m.Lo) then
        begin
         //͵�Գɹ�
         if Assigned(Game_role_list.Items[0]) then
          begin
           if Tplayer(Game_role_list.Items[0]).plvalues[ord(g_morality)]=0 then
            begin
             draw_text_17('����ֵ����',1000,clblue,18);
            end else begin //************************
                     if Game_base_random(5)= 0 then
                       Tplayer(Game_role_list.Items[0]).change_g_morality(-1);
             if b then
             begin
              form1.game_change_money(v);
              draw_text_17('͵����Ǯ��'+ inttostr(v),1000,clblue,18);
             end else begin
                     if v= 0 then
                    begin
                     draw_text_17('û����Ʒ',1000,clblue,18);
                    end else begin
                             if read_goods_number(v) < $FF then
                                write_goods_number(v,1); //������Ʒ1
                                draw_text_17('͵����Ʒ��'+ pchar(data2.get_game_goods_type(v,goods_name1)),1000,clblue,18);
                             end;
                   end;

                     end;  //******************

          end;
         
         g_game_delay(600);
        end else begin
                   //͵��ʧ��
                   draw_text_17('����ʧ��',1000,clblack);
                  g_game_delay(500);
                 end;
     pp:
   G_show_result_b:= false;  
  un_highlight_guai(-1);  //������
   un_highlight_my(-1);
   draw_game_role(Fgame_my_cu); //�ػ���Ա
   game_fight_result_adv; //�жϽ��
end;

procedure TForm_pop.del_a_word;
begin
 if G_word = g_dangqian_zhuangtai then
  del_word_in_lib
  else messagebox(handle,'��ǰ����ʾ�ĵ��ʡ�','����ɾ��',mb_ok);
end;

procedure TForm_pop.gong;
begin
  if g_gong.xianshi or groupbox3.Visible then
   begin
    button1click(self);
   end;
end;

procedure TForm_pop.Action1Execute(Sender: TObject);
begin
 gong;
end;

procedure TForm_pop.Action8Execute(Sender: TObject);
begin
  del_a_word;

end;

procedure TForm_pop.Action2Execute(Sender: TObject);
begin
   //����ݼ�
  if g_gong.xianshi or groupbox3.Visible then
   begin
    button2click(self);
   end;


end;

procedure TForm_pop.Action3Execute(Sender: TObject); //����ݼ�
begin
   if g_gong.xianshi or groupbox3.Visible then
   begin
    g_gong.xianshi:= false;
    button3click(self);
   end;

end;

procedure TForm_pop.Action4Execute(Sender: TObject);//���ݼ�
begin
   if g_gong.xianshi or groupbox3.Visible then
   begin
    g_gong.xianshi:= false;
    button4click(self);
   end;
end;

procedure TForm_pop.Action5Execute(Sender: TObject); //�ӿ�ݼ�
begin
  if g_gong.xianshi or groupbox3.Visible then
   begin
    button5click(self);
   end;
end;

procedure TForm_pop.Action6Execute(Sender: TObject);
begin
 if game_pic_check_area =G_words_Pic_y then
       check_asw(0,false); //��һ��ݼ�


end;

procedure TForm_pop.Action7Execute(Sender: TObject);
begin
   if game_pic_check_area =G_words_Pic_y then
       check_asw(1,false);
end;

procedure TForm_pop.Action9Execute(Sender: TObject);
begin
   if game_pic_check_area =G_words_Pic_y then
         check_asw(2,false);
end;

procedure TForm_pop.Action10Execute(Sender: TObject);
begin
  leiji_show; //��ʾ�ۼƴ��������ȷ����Ϣ ��ݼ� I
end;

procedure TForm_pop.Action11Execute(Sender: TObject);
begin
   //��ݼ� 1
   kuaijie_12345(1);
end;

procedure TForm_pop.Action12Execute(Sender: TObject);
begin
  //��ݼ� 2
  kuaijie_12345(2);
end;

procedure TForm_pop.Action13Execute(Sender: TObject);
begin
  //��ݼ� 3
  kuaijie_12345(3);
end;

procedure TForm_pop.Action14Execute(Sender: TObject);
begin
 //��ݼ� 4
 kuaijie_12345(4);
end;

procedure TForm_pop.Action15Execute(Sender: TObject);
begin
   //��ݼ� 5
   kuaijie_12345(5);
end;

procedure TForm_pop.kuaijie_12345(id: integer);  //��ݼ�����
begin
if not game_musmv_ready then
    exit;

   if g_gong.xianshi then
    begin

      case id of
      1: Button1Click(self);
      2: Button2Click(self);
      3: Button3Click(self);
      4: Button4Click(self);
      5: Button5Click(self);
      end;
     exit;
    end;

    if game_pic_check_area= G_all_pic_n then
   exit; //�˳�

               case game_pic_check_area of
                 G_words_Pic_y: begin
                                 case id of
                                  1: check_asw(0,false);
                                  2: check_asw(1,false);
                                  3: check_asw(2,false);
                                 end;
                                end;
                 G_g_pic_y: begin
                          //����gl�����ѡ��ʱ�����
                          //�ҷ�����������Ϊ�����ߣ�����id�͹�����ʽ��0Ϊ��ͨ����������ֵΪ������������
                           case id of
                            1:  My_Attack(Fgame_my_cu,0,F_Attack_type);
                            2:  My_Attack(Fgame_my_cu,1,F_Attack_type);
                            3:  My_Attack(Fgame_my_cu,2,F_Attack_type);
                            4:  My_Attack(Fgame_my_cu,3,F_Attack_type);
                            5:  My_Attack(Fgame_my_cu,4,F_Attack_type);
                           end;
                         end;
              G_my_pic_y:begin
                          //�ҷ���Ա����ͼƬ��ѡ�� ʱ�����
                          case id of
                           1: My_comeback(Fgame_my_cu,0,F_Attack_type);
                           2: My_comeback(Fgame_my_cu,1,F_Attack_type);
                           3: My_comeback(Fgame_my_cu,2,F_Attack_type);
                           4: My_comeback(Fgame_my_cu,3,F_Attack_type);
                           5: My_comeback(Fgame_my_cu,4,F_Attack_type);
                          end;
                         end;
              end; //end case
end;

procedure TForm_pop.AsphyreTimer1Process(Sender: TObject);
begin
    if g_particle_rec.xian then
     begin
      if Random(3)= 0 then
       begin
       with AsphyreParticles1.CreateImage(0, Point2(Random(600), 1), 180, fxBlendNA) do
     begin
      // set random speed
       Patt:= g_particle_rec.xuli;
      Velocity:= Point2((Random(10) - 5) / 20,  (Random(20) / 5));
      // set particle acceleration
       if g_particle_rec.xiaoguo= 0 then //���Ʈ��
          Accel:= Point2((0.002 + ((Random(10)-3) / 300)), (0.002 + (Random(10) / 300)))
          else if g_particle_rec.xiaoguo= 1 then //�̶�����
            Accel:= Point2(0, (0.502 + (Random(10) / 300)));
     end;
      end;
 // move the particles
      AsphyreParticles1.Update();
     end;
end;

procedure draw_grass(b: tbitmap; x, y: integer; angle: double;
  len, minlen: single);
  var x1,y1: integer;
begin
  if len > minlen then
   begin
    x1:= round(cos(angle) * len) + x;
    y1:= round(sin(angle) *len) + y;
    b.Canvas.MoveTo(x,y);
    b.Canvas.LineTo(x1,y1);
    draw_grass(b,(x+x1)div 2,(y1+y)div 2,angle- pi /8,len / 2,minlen);
     if Random(5)= 0 then
      draw_grass(b,x1,y1,angle +pi /6,len / 1.5,minlen)
     else
    draw_grass(b,x1,y1,angle -pi /6,len / 1.5,minlen);
   end;
end;

procedure TForm_pop.draw_random_grass(b: Tbitmap); //������ݣ�����߶� 200�������� 400
var i: integer;
begin
   b.Canvas.Pen.Color:= clgreen;
 for i:= 0 to 15 do
  draw_grass(b,(i-2) * (15 + Random(20)),round(b.Height /1.15)+Random(40),-pi/12,100,0.5);

end;
function floattobyte(f: single): byte;
begin
  result:= lo(round(f));
end;
procedure TForm_pop.draw_random_XX(bt: Tbitmap;flag: integer);  //���������ͼ
var x,y,newx,newy,a,b,c,d,e,f,r,y_c1,Y_C2,x_c1,X_C2: single;
   n,i,j: integer;
   m: array[0..6,0..6] of single;
begin
 n:= 100000;
 x:= 0;
 y:= 0;

 x_c1:= 0.5;
      X_C2:= 2;
      y_c1:= 0.25;
      Y_C2:= 1.25;

  //++++++++++++++++++++
    for i:= 0 to 6 do
       for j:= 0 to 6 do
         m[i,j]:= 0;

     if flag= 0 then
        flag:= Random(21)
        else
         flag:= flag -1;

     case flag of
     0: begin
      m[0,0]:= 0.5;
      m[0,1]:= -0.5;
      m[0,2]:= 0.5;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.5;

      m[1,0]:= 0.5;
      m[1,1]:= 0.5;
      m[1,2]:= -0.5;
      m[1,3]:= 0.5;
      m[1,4]:= 0.5;
      m[1,5]:= 0.5;
      m[1,6]:= 0.5;
      x_c1:= 0.55;
      X_C2:= 2.1;  //2
      y_c1:= 0.4;
      Y_C2:= 1.6; //1.25
       end;
      1:begin
      m[0,0]:= 0.25;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.154;

      m[1,0]:= 0.5;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.5;
      m[1,4]:= -0.25;
      m[1,5]:= 0.5;
      m[1,6]:= 0.307;
      m[2,0]:= -0.25;
      m[2,1]:= 0;
      m[2,2]:= 0;
      m[2,3]:= -0.25;
      m[2,4]:= 0.25;
      m[2,5]:= 1;
      m[2,6]:= 0.078;

      m[3,0]:= 0.5;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.5;
      m[3,4]:= 0;
      m[3,5]:= 0.75;
      m[3,6]:= 0.307;
      m[4,0]:= 0.5;
      m[4,1]:= 0;
      m[4,2]:= 0;
      m[4,3]:= -0.25;
      m[4,4]:= 0.5;
      m[4,5]:= 1.25;
      m[4,6]:= 0.154;
      x_c1:= 0.5;
      X_C2:= 1.6;  //1.5
      y_c1:= 0;
      Y_C2:= 1.6; //1.25
       end;
      2:begin
      m[0,0]:= 0.787879;
      m[0,1]:= -0.424242;
      m[0,2]:= 0.242424;
      m[0,3]:= 0.859848;
      m[0,4]:= 1.758647;
      m[0,5]:= 1.408065;
      m[0,6]:= 0.9;

      m[1,0]:= -0.121212;
      m[1,1]:= 0.257576;
      m[1,2]:= 0.05303;
      m[1,3]:= 0.05303;
      m[1,4]:= -6.721654;
      m[1,5]:= 1.377236;
      m[1,6]:= 0.05;
      m[2,0]:= 0.181818;
      m[2,1]:= -0.136364;
      m[2,2]:= 0.090909;
      m[2,3]:= 0.181818;
      m[2,4]:= 6.086107;
      m[2,5]:= 1.568035;
      m[2,6]:= 0.05;
      x_c1:= 7;
      X_C2:= 15;  //14.015
      y_c1:= 0;
      Y_C2:= 9.65; //9.56
       end;
      3:begin
      m[0,0]:= 0.255;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.255;
      m[0,4]:= 0.3726;
      m[0,5]:= 0.6714;
      m[0,6]:= 0.2;

      m[1,0]:= 0.255;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.255;
      m[1,4]:= 0.1146;
      m[1,5]:= 0.2232;
      m[1,6]:= 0.2;
      m[2,0]:= 0.255;
      m[2,1]:= 0;
      m[2,2]:= 0;
      m[2,3]:= 0.255;
      m[2,4]:= 0.6306;
      m[2,5]:= 0.2232;
      m[2,6]:= 0.2;
      m[3,0]:= 0.37;
      m[3,1]:= -0.642;
      m[3,2]:= 0.642;
      m[3,3]:= 0.37;
      m[3,4]:= 0.6356;
      m[3,5]:= -0.0061;
      m[3,6]:= 0.4;
      x_c1:= 0;
      X_C2:= 0.9;  //0.846
      y_c1:= 0;
      Y_C2:= 1; //0.9012
       end;
      4:begin
      m[0,0]:= 0.382;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.382;
      m[0,4]:= 0.3072;
      m[0,5]:= 0.619;
      m[0,6]:= 0.2;
      m[1,0]:= 0.382;
      m[1,1]:= 1;
      m[1,2]:= 0;
      m[1,3]:= 0.382;
      m[1,4]:= 0.6033;
      m[1,5]:= 0.4044;
      m[1,6]:= 0.2;
      m[2,0]:= 0.382;
      m[2,1]:= 0;
      m[2,2]:= 0;
      m[2,3]:= 0.382;
      m[2,4]:= 0.0139;
      m[2,5]:= 0.4044;
      m[2,6]:= 0.2;
      m[3,0]:= 0.382;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.382;
      m[3,4]:= 0.1253;
      m[3,5]:= 0.0595;
      m[3,6]:= 0.2;
      m[4,0]:= 0.382;
      m[4,1]:= 1;
      m[4,2]:= 0;
      m[4,3]:= 0.382;
      m[4,4]:= 0.492;
      m[4,5]:= 0.0595;
      m[4,6]:= 0.2;
      x_c1:= 0;
      X_C2:= 0.95;  //0.942
      y_c1:= 0;
      Y_C2:= 1; //1
       end;
      5:begin
      m[0,0]:= 0.745455;
      m[0,1]:= -0.459091;
      m[0,2]:= 0.406061;
      m[0,3]:= 0.887121;
      m[0,4]:= 1.460279;
      m[0,5]:= 0.691072;
      m[0,6]:= 0.912675;

      m[1,0]:= -0.424242;
      m[1,1]:= -0.065152;
      m[1,2]:= -0.175758;
      m[1,3]:= -0.218182;
      m[1,4]:= 3.809567;
      m[1,5]:= 6.741476;
      m[1,6]:= 0.087325;
      x_c1:= 6.12;
      X_C2:= 12.18;  //14.015
      y_c1:= 0.12;
      Y_C2:= 10.2; //9.56
       end;
      6:begin
      m[0,0]:= 0;
      m[0,1]:= -0.5;
      m[0,2]:= 0.5;
      m[0,3]:= 0;
      m[0,4]:= 0.5;
      m[0,5]:= 0;
      m[0,6]:= 0.333;

      m[1,0]:= 0;
      m[1,1]:= 0.5;
      m[1,2]:= -0.5;
      m[1,3]:= 0;
      m[1,4]:= 0.5;
      m[1,5]:= 0.5;
      m[1,6]:= 0.333;
      m[2,0]:= 0.5;
      m[2,1]:= -3;
      m[2,2]:= 0.2;
      m[2,3]:= 0.5;
      m[2,4]:= 0.25;
      m[2,5]:= 0.5;
      m[2,6]:= 0.8;
      x_c1:= 0;
      X_C2:= 1.5;  //14.015
      y_c1:= 0;
      Y_C2:= 1.5; //9.56
       end;
       7:begin
      m[0,0]:= 0.824074;
      m[0,1]:= 0.281482;
      m[0,2]:= -0.212346;
      m[0,3]:= 0.864198;
      m[0,4]:= -1.882290;
      m[0,5]:= -0.110607;
      m[0,6]:= 0.8;

      m[1,0]:= 0.088272;
      m[1,1]:= 0.520988;
      m[1,2]:= -0.463889;
      m[1,3]:= -0.377778;
      m[1,4]:= 0.785360;
      m[1,5]:= 8.095795;
      m[1,6]:= 0.2;

      x_c1:= 6.2;
      X_C2:= 12.3;  //14.015
      y_c1:= 0.17;
      Y_C2:= 10.3; //9.56
       end;
       8:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.05;
      m[1,0]:= 0.42;
      m[1,1]:= -0.42;
      m[1,2]:= 0.42;
      m[1,3]:= 0.42;
      m[1,4]:= 0;
      m[1,5]:= 0.2;
      m[1,6]:= 0.4;
      m[2,0]:= 0.42;
      m[2,1]:= 0.42;
      m[2,2]:= -0.42;
      m[2,3]:= 0.42;
      m[2,4]:= 0;
      m[2,5]:= 0.2;
      m[2,6]:= 0.4;
      m[3,0]:= 0.1;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.4;
      m[3,4]:= 0;
      m[3,5]:= 0.2;
      m[3,6]:= 0.15;

      x_c1:= 0.2388;
      X_C2:= 0.5;  //0.942
      y_c1:= 0;
      Y_C2:= 0.5; //1
       end;
       9:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.05;
      m[1,0]:= 0.42;
      m[1,1]:= -0.42;
      m[1,2]:= 0.42;
      m[1,3]:= 0.42;
      m[1,4]:= 0;
      m[1,5]:= 0.2;
      m[1,6]:= 0.4;
      m[2,0]:= 0.42;
      m[2,1]:= 0.42;
      m[2,2]:= -0.42;
      m[2,3]:= 0.42;
      m[2,4]:= 0;
      m[2,5]:= 0.2;
      m[2,6]:= 0.4;
      m[3,0]:= 0.1;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.3;
      m[3,4]:= 0;
      m[3,5]:= 0.6;
      m[3,6]:= 0.15;

      x_c1:= 0.4;
      X_C2:= 0.8;  //0.942
      y_c1:= 0;
      Y_C2:= 0.9; //1
       end;
       10:begin
      m[0,0]:= -0.04;
      m[0,1]:= 0;
      m[0,2]:= -0.19;
      m[0,3]:= -0.47;
      m[0,4]:= -0.12;
      m[0,5]:= 0.3;
      m[0,6]:= 0.25;
      m[1,0]:= 0.65;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.56;
      m[1,4]:= 0.06;
      m[1,5]:= 1.56;
      m[1,6]:= 0.25;
      m[2,0]:= 0.41;
      m[2,1]:= 0.46;
      m[2,2]:= -0.39;
      m[2,3]:= 0.61;
      m[2,4]:= 0.46;
      m[2,5]:= 0.4;
      m[2,6]:= 0.25;
      m[3,0]:= 0.52;
      m[3,1]:= -0.35;
      m[3,2]:= 0.25;
      m[3,3]:= 0.74;
      m[3,4]:= -0.48;
      m[3,5]:= 0.38;
      m[3,6]:= 0.25;

      x_c1:= 2.6;
      X_C2:= 5.1;  //0.942
      y_c1:= 0.4;
      Y_C2:= 4.4; //1
       end;
       11:begin
      m[0,0]:= 0.6;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.6;
      m[0,4]:= 0.18;
      m[0,5]:= 0.36;
      m[0,6]:= 0.25;
      m[1,0]:= 0.6;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.6;
      m[1,4]:= 0.18;
      m[1,5]:= 0.12;
      m[1,6]:= 0.25;
      m[2,0]:= 0.4;
      m[2,1]:= 0.3;
      m[2,2]:= -0.3;
      m[2,3]:= 0.4;
      m[2,4]:= 0.27;
      m[2,5]:= 0.36;
      m[2,6]:= 0.25;
      m[3,0]:= 0.4;
      m[3,1]:= -0.3;
      m[3,2]:= 0.3;
      m[3,3]:= 0.4;
      m[3,4]:= 0.27;
      m[3,5]:= 0.09;
      m[3,6]:= 0.25;

      x_c1:= -0.1;
      X_C2:= 0.75;  //0.942
      y_c1:= 0;
      Y_C2:= 1; //1
       end;
       12:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.25;
      m[0,4]:= 0;
      m[0,5]:= -0.14;
      m[0,6]:= 0.02;
      m[1,0]:= 0.85;
      m[1,1]:= 0.02;
      m[1,2]:= -0.02;
      m[1,3]:= 0.83;
      m[1,4]:= 0;
      m[1,5]:= 1;
      m[1,6]:= 0.84;
      m[2,0]:= 0.09;
      m[2,1]:= -0.28;
      m[2,2]:= 0.3;
      m[2,3]:= 0.11;
      m[2,4]:= 0;
      m[2,5]:= 0.6;
      m[2,6]:= 0.07;
      m[3,0]:= -0.09;
      m[3,1]:= 0.25;
      m[3,2]:= 0.3;
      m[3,3]:= 0.09;
      m[3,4]:= 0;
      m[3,5]:= 0.7;
      m[3,6]:= 0.07;

      x_c1:= 1.6;
      X_C2:= 3;  //0.942
      y_c1:= 0;
      Y_C2:= 5.9; //1
       end;
       13:begin
      m[0,0]:= 0.05;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.6;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.1;
      m[1,0]:= 0.05;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= -0.5;
      m[1,4]:= 0;
      m[1,5]:= 1.0;
      m[1,6]:= 0.1;
      m[2,0]:= 0.46;
      m[2,1]:= 0.32;
      m[2,2]:= -0.386;
      m[2,3]:= 0.383;
      m[2,4]:= 0;
      m[2,5]:= 0.6;
      m[2,6]:= 0.2;
      m[3,0]:= 0.47;
      m[3,1]:= -0.154;
      m[3,2]:= 0.171;
      m[3,3]:= 0.423;
      m[3,4]:= 0;
      m[3,5]:= 1;
      m[3,6]:= 0.2;
      m[4,0]:= 0.43;
      m[4,1]:= 0.275;
      m[4,2]:= -0.26;
      m[4,3]:= 0.476;
      m[4,4]:= 0;
      m[4,5]:= 1;
      m[4,6]:= 0.2;
      m[5,0]:= 0.421;
      m[5,1]:= -0.357;
      m[5,2]:= 0.354;
      m[5,3]:= 0.307;
      m[5,4]:= 0;
      m[5,5]:= 0.7;
      m[5,6]:= 0.2;
      x_c1:= 0.8;
      X_C2:= 1.73;  //0.942
      y_c1:= 0;
      Y_C2:= 1.95; //1
       end;
       14:begin
      m[0,0]:= 0.195;
      m[0,1]:= -0.488;
      m[0,2]:= 0.344;
      m[0,3]:= 0.433;
      m[0,4]:= 0.4431;
      m[0,5]:= 0.2452;
      m[0,6]:= 0.25;
      m[1,0]:= 0.462;
      m[1,1]:= 0.414;
      m[1,2]:= -0.252;
      m[1,3]:= 0.361;
      m[1,4]:= 0.2511;
      m[1,5]:= 0.5692;
      m[1,6]:= 0.25;
      m[2,0]:= -0.058;
      m[2,1]:= -0.07;
      m[2,2]:= 0.453;
      m[2,3]:= -0.111;
      m[2,4]:= 0.5976;
      m[2,5]:= 0.0969;
      m[2,6]:= 0.25;
      m[3,0]:= -0.035;
      m[3,1]:= 0.07;
      m[3,2]:= -0.469;
      m[3,3]:= -0.022;
      m[3,4]:= 0.4884;
      m[3,5]:= 0.5069;
      m[3,6]:= 0.2;
      m[4,0]:= -0.637;
      m[4,1]:= 0;
      m[4,2]:= 0;
      m[4,3]:= 0.501;
      m[4,4]:= 0.8562;
      m[4,5]:= 0.2513;
      m[4,6]:= 0.05;

      x_c1:= 0;
      X_C2:= 1;  //0.942
      y_c1:= 0;
      Y_C2:= 0.88; //1
       end;
       15:begin
      m[0,0]:= 0.05;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.4;
      m[0,4]:= -0.06;
      m[0,5]:= -0.47;
      m[0,6]:= 0.2;
      m[1,0]:= -0.05;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= -0.4;
      m[1,4]:= -0.06;
      m[1,5]:= -0.47;
      m[1,6]:= 0.2;
      m[2,0]:= 0.03;
      m[2,1]:= -0.14;
      m[2,2]:= 0;
      m[2,3]:= 0.26;
      m[2,4]:= -0.16;
      m[2,5]:= -0.01;
      m[2,6]:= 0.1;
      m[3,0]:= -0.03;
      m[3,1]:= 0.14;
      m[3,2]:= 0;
      m[3,3]:= -0.26;
      m[3,4]:= -0.16;
      m[3,5]:= -0.1;
      m[3,6]:= 0.1;
      m[4,0]:= 0.56;
      m[4,1]:= 0.44;
      m[4,2]:= -0.37;
      m[4,3]:= 0.51;
      m[4,4]:= 0.3;
      m[4,5]:= 0.15;
      m[4,6]:= 0.3;
      m[5,0]:= 0.19;
      m[5,1]:= 0.07;
      m[5,2]:= -0.1;
      m[5,3]:= 0.15;
      m[5,4]:= -0.2;
      m[5,5]:= 0.28;
      m[5,6]:= 0.05;
      m[6,0]:= -0.33;
      m[6,1]:= -0.34;
      m[6,2]:= -0.3;
      m[6,3]:= 0.34;
      m[6,4]:= -0.54;
      m[6,5]:= 0.39;
      m[6,6]:= 0.05;
      x_c1:= 0.95;
      X_C2:= 1.95;  //0.942
      y_c1:= 0.8;
      Y_C2:= 1.65; //1
       end;
       16:begin
      m[0,0]:= 0.387;
      m[0,1]:= 0.43;
      m[0,2]:= 0.43;
      m[0,3]:= -0.387;
      m[0,4]:= 0.256;
      m[0,5]:= 0.522;
      m[0,6]:= 0.333;
      m[1,0]:= 0.441;
      m[1,1]:= -0.091;
      m[1,2]:= -0.009;
      m[1,3]:= -0.322;
      m[1,4]:= 0.4219;
      m[1,5]:= 0.5059;
      m[1,6]:= 0.333;
      m[2,0]:= -0.468;
      m[2,1]:= 0.02;
      m[2,2]:= -0.113;
      m[2,3]:= 0.015;
      m[2,4]:= 0.4;
      m[2,5]:= 0.4;
      m[2,6]:= 0.334;

      x_c1:= 0;
      X_C2:= 0.9;  //0.942
      y_c1:= 0;
      Y_C2:= 0.75; //1
       end;
       17:begin
      m[0,0]:= 0.8;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= -0.8;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.5;
      m[1,0]:= 0.4;
      m[1,1]:= -0.2;
      m[1,2]:= 0.2;
      m[1,3]:= 0.4;
      m[1,4]:= 1.1;
      m[1,5]:= 0;
      m[1,6]:= 0.5;

      x_c1:= 0;
      X_C2:= 1.78;  //0.942
      y_c1:= 0.4445;
      Y_C2:= 1; //1
       end;
       18:begin
      m[0,0]:= 0.5;
      m[0,1]:= 0.25;
      m[0,2]:= 0.25;
      m[0,3]:= -0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.5;
      m[1,0]:= 0.75;
      m[1,1]:= -0.25;
      m[1,2]:= 0.25;
      m[1,3]:= 0.75;
      m[1,4]:= 0.75;
      m[1,5]:= 0;
      m[1,6]:= 0.5;

      x_c1:= 0;
      X_C2:= 2.2211;  //0.942
      y_c1:= 0.46;
      Y_C2:= 2.18; //1
       end;
       19:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.16;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.01;
      m[1,0]:= 0.85;
      m[1,1]:= 0.04;
      m[1,2]:= -0.04;
      m[1,3]:= 0.85;
      m[1,4]:= 0;
      m[1,5]:= 1.6;
      m[1,6]:= 0.85;
      m[2,0]:= 0.2;
      m[2,1]:= -0.26;
      m[2,2]:= 0.23;
      m[2,3]:= 0.22;
      m[2,4]:= 0;
      m[2,5]:= 1.6;
      m[2,6]:= 0.07;
      m[3,0]:= -0.15;
      m[3,1]:= 0.28;
      m[3,2]:= 0.26;
      m[3,3]:= 0.24;
      m[3,4]:= 0;
      m[3,5]:= 0.44;
      m[3,6]:= 0.07;
      x_c1:= 2.185;
      X_C2:= 4.88;  //0.942
      y_c1:= 0;
      Y_C2:= 10; //1
       end;
       20:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.25;
      m[0,4]:= 0;
      m[0,5]:= -0.04;
      m[0,6]:= 0.02;
      m[1,0]:= 0.92;
      m[1,1]:= 0.05;
      m[1,2]:= -0.05;
      m[1,3]:= 0.93;
      m[1,4]:= -0.002;
      m[1,5]:= 0.5;
      m[1,6]:= 0.84;
      m[2,0]:= 0.035;
      m[2,1]:= -0.2;
      m[2,2]:= 0.16;
      m[2,3]:= 0.04;
      m[2,4]:= -0.09;
      m[2,5]:= 0.02;
      m[2,6]:= 0.07;
      m[3,0]:= -0.04;
      m[3,1]:= 0.2;
      m[3,2]:= 0.16;
      m[3,3]:= 0.04;
      m[3,4]:= 0.083;
      m[3,5]:= 0.12;
      m[3,6]:= 0.07;
      x_c1:= 1.08;
      X_C2:= 4.4;  //0.942
      y_c1:= 0.18;
      Y_C2:= 5.7; //1
       end;
      end;
  //++++++++++++++++++++
  while n> 0 do
   begin
    r:= Random;
     if r <= m[0,0] then
      begin
       a:= m[0,0];
       b:= m[0,1];
       c:= m[0,2];
       d:= m[0,3];
       e:= m[0,4];
       f:= m[0,5];
      end else if r <=m[0,6] + m[1,6] then
       begin
       a:= m[1,0];
       b:= m[1,1];
       c:= m[1,2];
       d:= m[1,3];
       e:= m[1,4];
       f:= m[1,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6] then
       begin
       a:= m[2,0];
       b:= m[2,1];
       c:= m[2,2];
       d:= m[2,3];
       e:= m[2,4];
       f:= m[2,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6]+m[3,6] then
       begin
       a:= m[3,0];
       b:= m[3,1];
       c:= m[3,2];
       d:= m[3,3];
       e:= m[3,4];
       f:= m[3,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6]+m[3,6]+ m[4,6] then
       begin
       a:= m[4,0];
       b:= m[4,1];
       c:= m[4,2];
       d:= m[4,3];
       e:= m[4,4];
       f:= m[4,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6]+m[3,6]+ m[4,6] +m[5,6] then
       begin
       a:= m[5,0];
       b:= m[5,1];
       c:= m[5,2];
       d:= m[5,3];
       e:= m[5,4];
       f:= m[5,5];
      end else begin
       a:= m[6,0];
       b:= m[6,1];
       c:= m[6,2];
       d:= m[6,3];
       e:= m[6,4];
       f:= m[6,5];
      end;

      newx:= a *x + b *y + e;
      newy:= c*x + d* y + f;
      x:= newx;
      y:= newy;


      bt.Canvas.Pixels[round(bt.Width *(X+X_C1)/X_C2),round(bt.Height-bt.Height *(y+Y_C1)/Y_C2)]:=
      rgb(floattobyte(255*X),floattobyte(255 *R),floattobyte(255*Y));

    dec(n);
   end; //end while
  // showmessage(floattostr(min2) + ',' +floattostr(max2) + ','+floattostr(min3) + ','+floattostr(max3));
end;

function TForm_pop.need_wait: boolean;
begin
 result:=  (time_list1.Timer_wo_gongji or time_list1.Timer_wo_fashugongji
     or time_list1.Timer_wupin_gongji or time_list1.Timer_wupin_huifu or time_list1.Timer_fashu_huifu);


end;

procedure TForm_pop.clean_lable2_11;
begin
 label2.Caption:= '';
 label3.Caption:= '';
 label4.Caption:= '';
 label5.Caption:= '';
 label6.Caption:= '';
 label7.Caption:= '';
 label8.Caption:= '';
 label9.Caption:= '';
 label10.Caption:= '';
 label11.Caption:= '';
end;

procedure TForm_pop.write_label2_11;
var g: array[0..9,0..1] of integer;
    i,j,k,k2: integer;
    t: Tplayer;
    function get_09name(L,L2: integer): string;
    begin
     if l2= 0 then
       begin
       get_09name:= '';
       end else begin
     if L > 4 then
      begin
       //�зű��
       result:= loc_guai_g[l-5].name1;
      end else begin
                t:= game_get_role_from_i(l);
                if t<> nil then
                  get_09name:= t.plname;
               end;
               end;
    end;
begin
   clean_lable2_11;
    //0--4���ҷ���ţ�5--9���з����
   for i:= 0 to 9 do
    begin
    g[i,0]:= game_p_list[i];
    g[i,1]:= i;
    end;

    for j:= 0 to 9 do
     begin
    for i:= 1 to 9 do
     if g[i,0] > g[i-1,0] then
        begin
         k:= g[i,0];
         k2:= g[i,1];
         g[i,0]:= g[i-1,0];
         g[i-1,0]:= k;
          g[i,1]:= g[i-1,1];
         g[i-1,1]:= k2;
        end;
     end; //end j

      label11.Caption:= get_09name(g_wo_guai_dangqian,1); //��ǰ����

     if g_wo_guai_dangqian > 4 then
     label11.Font.Color:= clred
     else
       label11.Font.Color:= clgreen;

     label10.Caption:= get_09name(g[0,1],g[0,0]);
     label9.Caption:= get_09name(g[1,1],g[1,0]);
     label8.Caption:= get_09name(g[2,1],g[2,0]);
     label7.Caption:= get_09name(g[3,1],g[3,0]);
     label6.Caption:= get_09name(g[4,1],g[4,0]);
     label5.Caption:= get_09name(g[5,1],g[5,0]);
     label4.Caption:= get_09name(g[6,1],g[6,0]);
     label3.Caption:= get_09name(g[7,1],g[7,0]);
     label2.Caption:= get_09name(g[8,1],g[8,0]);
   //  label2.Caption:= get_09name(g[9,1],g[9,0]);
end;

procedure TForm_pop.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

 if button = mbRight then
  begin
   groupbox3.Visible:= false;
   g_gong.xianshi:= true;
  end else begin
            if not g_Dragging then
              if listbox1.ItemIndex > -1 then
                listbox1_click1;
            //�����϶�
            if g_Dragging then
             begin
              ListBox1.EndDrag(true);
              g_Dragging:= false;
             end;
           end;


end;

procedure TForm_pop.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 accept:= true;
end;

procedure TForm_pop.Button6DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
 accept:= true;
end;

procedure TForm_pop.Button6DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var ss: string;
      t: Tplayer;
begin
  if source<> listbox1 then
     exit;

   if listbox1.Itemindex= -1 then
    exit;

     ss:= listbox1.Items.Strings[listbox1.ItemIndex];
  if (ss= '') or (ss[1]= '-') then
   begin
    (sender as tbutton).Caption:= '���-��';
    if listbox1.Items.Count<= 2 then
     if f_type_g = 4 then
      messagebox(handle,'��û�п��õ���Ʒ��ҩ�ģ�����Ʒ������Ұ��񵽻����ڳ���ĵ������򵽡�','����',mb_ok or MB_ICONWARNING)
     else
     messagebox(handle,'��û��ѧ�ᷨ���������ؼ��������Թ��ҵ�������һЩ�ض����ﴦ��á�','����ð��',mb_ok or MB_ICONWARNING);
   exit;   //�ָ��ߣ��˳�
   end;


  (sender as tbutton).Caption:= data2.get_game_goods_type_s(ss,goods_name1); //��ȡ��Ʒid

  t:= game_get_role_from_i(fgame_my_cu);

   if button6.Caption='���-��' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'1']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'1']:= button6.Caption;

   if button7.Caption='���-��' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'2']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'2']:= button7.Caption;
    if button8.Caption='���-��' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'3']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'3']:= button8.Caption;
    if button9.Caption='���-��' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'4']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'4']:= button9.Caption;
    if button10.Caption='���-��' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'5']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'5']:= button10.Caption;
end;

procedure TForm_pop.laod_fashu_wupin_k(const s: string);
begin
 if FileExists(s) then
    fashu_wupin_kuaijie_list.LoadFromFile(s);
end;

procedure TForm_pop.save_fashu_wupin_k(const s: string);
begin
   fashu_wupin_kuaijie_list.SaveToFile(s);
end;

procedure TForm_pop.show_fashuwupin_k(const s: string);
begin
  if fashu_wupin_kuaijie_list.Values[s+'1']= '' then
     button6.Caption:='���-��'
     else
       button6.Caption:= fashu_wupin_kuaijie_list.Values[s+'1'];
  if fashu_wupin_kuaijie_list.Values[s+'2']= '' then
     button7.Caption:='���-��'
     else
       button7.Caption:= fashu_wupin_kuaijie_list.Values[s+'2'];
  if fashu_wupin_kuaijie_list.Values[s+'3']= '' then
     button8.Caption:='���-��'
     else
       button8.Caption:= fashu_wupin_kuaijie_list.Values[s+'3'];
  if fashu_wupin_kuaijie_list.Values[s+'4']= '' then
     button9.Caption:='���-��'
     else
       button9.Caption:= fashu_wupin_kuaijie_list.Values[s+'4'];
  if fashu_wupin_kuaijie_list.Values[s+'5']= '' then
     button10.Caption:='���-��'
     else
       button10.Caption:= fashu_wupin_kuaijie_list.Values[s+'5'];
end;

procedure TForm_pop.Button6Click(Sender: TObject);
var ss: string;
   id,j: integer;
   procedure b6_end;
   begin
        time_list1.timer_gong:= false;
  groupbox3.Visible:= false;
  g_gong.xianshi:= false;
   end;
begin
   if  (groupbox3.Visible= false ) and (g_gong.xianshi= false) then
     exit;    //��û����ʾʱ��ݼ�������

   if (sender as tbutton).Caption= '���-��' then
     exit;

   if need_wait then
    exit;

  ss:= (sender as tbutton).Caption;

  id:= Form_goods.get_goods_id(ss); //��ȡ��Ʒid

   F_Attack_type:= id; //���浱ǰ��Ʒ���߷�����id
   f_type_g:= 4;

  ss:= Data2.get_goods_all_s(id);  //ȡ������Ʒ�ַ���������

   j:= strtoint2(data2.get_game_goods_type_s(ss,goods_type1)); //ȡ������


   if j and 2=2 then
    begin
    if read_goods_number(id)> 0 then
    begin
     b6_end;
     procedure_2(ss);
    end  else begin
             messagebox(handle,pchar('��Ʒ���㣬���Ѿ�������'+(sender as tbutton).Caption),'��Ʒ����',mb_ok or MB_ICONWARNING);
           end;
    end else if j and 4=4 then
         begin
          if read_goods_number(id)> 0 then
           begin
           b6_end;
          procedure_4(ss);
          end
           else begin
             messagebox(handle,pchar('��Ʒ���㣬���Ѿ�������'+(sender as tbutton).Caption),'��Ʒ����',mb_ok or MB_ICONWARNING);
            end;
         end else if j and 128= 128 then
           begin
           f_type_g:= 3;
           if lingli_is_ok(ss) then
            begin
               b6_end;
             procedure_128(ss);
            end else begin  //��������ʱ�˳������Ȼ�÷������ƣ�Ȼ��ȡid��Ȼ��ȡ������Ȼ��͵�ǰ����ȶ�ʣ������
                   messagebox(handle,pchar('��������������ʹ�ô˷�����'+ (sender as tbutton).Caption),'��������',mb_ok or MB_ICONWARNING);
                  end;
           end else if j and 256 = 256 then
                       begin
                        if read_goods_number(id)> 0 then
                          begin
                             b6_end;
                           procedure_256(ss);
                          end else begin
                            messagebox(handle,pchar('��Ʒ���㣬���Ѿ�������'+(sender as tbutton).Caption),'��Ʒ����',mb_ok or MB_ICONWARNING);
                          end;
                       end;
     
end;

procedure TForm_pop.Action16Execute(Sender: TObject);
begin
  Button6Click(button6);  //��Ʒ�����Ŀ�ݼ�
end;

procedure TForm_pop.Action17Execute(Sender: TObject);
begin
  Button6Click(button7);
end;

procedure TForm_pop.Action18Execute(Sender: TObject);
begin
     Button6Click(button8);
end;

procedure TForm_pop.Action19Execute(Sender: TObject);
begin
    Button6Click(button9);
end;

procedure TForm_pop.Action20Execute(Sender: TObject);
begin
    Button6Click(button10);
end;

procedure TForm_pop.show_hint_button;
begin
     button6.Hint:= '��Ʒ���߷����Ŀ�ݼ������϶���Ʒ�������ˣ���ݼ�'+ ShortCutToText(Action16.ShortCut);
     button7.Hint:= '��Ʒ���߷����Ŀ�ݼ������϶���Ʒ�������ˣ���ݼ�'+ ShortCutToText(Action17.ShortCut);
     button8.Hint:= '��Ʒ���߷����Ŀ�ݼ������϶���Ʒ�������ˣ���ݼ�'+ ShortCutToText(Action18.ShortCut);
     button9.Hint:= '��Ʒ���߷����Ŀ�ݼ������϶���Ʒ�������ˣ���ݼ�'+ ShortCutToText(Action19.ShortCut);
     button10.Hint:= '��Ʒ���߷����Ŀ�ݼ������϶���Ʒ�������ˣ���ݼ�'+ ShortCutToText(Action20.ShortCut);

     button1.Hint:= '���������ͨ����������ݼ� '+ ShortCutToText(Action1.ShortCut);
     button2.Hint:= '�������״̬���ɼ����˺�����ݼ�'+ ShortCutToText(Action2.ShortCut);
     button3.Hint:= 'ʹ�÷�������������߻ָ���Ա����ݼ�'+ ShortCutToText(Action3.ShortCut);
     button4.Hint:= 'ʹ�ûָ�����Ʒ�������Ͷ������Ʒ��������ݼ�'+ ShortCutToText(Action4.ShortCut);
     button5.Hint:= '��ʮ���ƣ���Ϊ�ϼƣ���ݼ�'+ ShortCutToText(Action5.ShortCut);
end;

procedure TForm_pop.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mouse_down_xy.X:= X;
  mouse_down_xy.Y:= Y; //������갴��ʱ��λ�ã���������϶�
end;

procedure TForm_pop.N7Click(Sender: TObject);
begin
 game_not_bg_black:= not game_not_bg_black;
   if not game_not_bg_black then
  begin
  messagebox(handle,'��ɫ�����Ѿ���ʱ���ã����豣������ã�������Ϸ�ġ�ϵͳ���á�ҳ�棬��������Ĳ����档','ע��',mb_ok);
  end else begin
               messagebox(handle,'��ɫ�����Ѿ���ʱ�رգ����豣������ã�������Ϸ�ġ�ϵͳ���á�ҳ�棬��������Ĳ����档','ע��',mb_ok);
            end;
end;

procedure TForm_pop.play_sound(i: integer);
begin
   Assert(i<>-1,'����Խλ');
    With DXWaveList1.items[i] Do
    Begin
      volume := -1000;
      pan := 0;
      play(false);
    End;
end;

procedure TForm_pop.Button11Click(Sender: TObject);
begin
 popupmenu1.Popup(Button11.ClientOrigin.X,Button11.ClientOrigin.Y+Button11.Height);
end;

procedure TForm_pop.PopupMenu1Popup(Sender: TObject);
begin
  if GameSave1.tip1= 0 then
     n1.Caption:= '�رյ��ʶ���'
     else n1.Caption:= '�������ʶ���';

  if GameSave1.tip2= 0 then
     n2.Caption:= '�رյ���͸��Ч��'
     else n2.Caption:= '��������͸��Ч��';

  if GameSave1.tip3= 0 then
     n4.Caption:= '�رղ��Դ��ڶ���'
     else n4.Caption:= '�������Դ��ڶ���';
  if GameSave1.tip4= 0 then
     n5.Caption:= '�رղ��Դ���͸��'
     else n5.Caption:= '�������Դ���͸��';
  if GameSave1.tip5= 0 then
     n9.Caption:= '�ر�ս����Ч'
     else n9.Caption:= '����ս����Ч';
  if GameSave1.tip6= 0 then
     n10.Caption:= '�رչ������'
     else n10.Caption:= '�����������';

  if not game_not_bg_black then
    n7.Caption:= '�رպ�ɫ����'
   else
     n7.Caption:= '���ú�ɫ����';
end;

procedure TForm_pop.N1Click(Sender: TObject);
begin
  GameSave1.tip1:= not GameSave1.tip1;

end;

procedure TForm_pop.N2Click(Sender: TObject);
begin
    GameSave1.tip2:= not GameSave1.tip2;
end;

procedure TForm_pop.N4Click(Sender: TObject);
begin
   GameSave1.tip3:= not GameSave1.tip3;
end;

procedure TForm_pop.N5Click(Sender: TObject);
begin
GameSave1.tip4:= not GameSave1.tip4;
end;

procedure TForm_pop.N9Click(Sender: TObject);
begin
  GameSave1.tip5:= not GameSave1.tip5;
end;

procedure TForm_pop.N10Click(Sender: TObject);
begin
  GameSave1.tip6:= not GameSave1.tip6;
end;

procedure TForm_pop.N12Click(Sender: TObject);
begin
    GameSave1.tip1:= 0;
    GameSave1.tip2:= 0;
    GameSave1.tip3:= 0;
    GameSave1.tip4:= 0;
    GameSave1.tip5:= 0;
    GameSave1.tip6:= 0;
    game_not_bg_black:= true;
end;

procedure TForm_pop.Timer_auto_attackTimer(Sender: TObject);

begin
    //�Զ����������һ��

  inc(g_auto_attack);
   if g_auto_attack= 10 then
    begin
      Timer_auto_attack.Enabled:= false;
      g_auto_attack:= 0;

      case get_min_guai_f of
      0: G_mus_at:= mus_guai1;
      1: G_mus_at:= mus_guai2;
      2: G_mus_at:= mus_guai3;
      3: G_mus_at:= mus_guai4;
      4: G_mus_at:= mus_guai5;
      end;

      Panel1MouseDown(self,mbLeft,[ssleft],0,0);
    end;
end;

procedure TForm_pop.init_weizi;
begin
 with g_danci_weizhi.weizi do //��ʼ�����ʺ���ʾ��λ�úʹ�С
     begin
     Left:= g_word_show_left;
     Top:= G_C_danci_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= Top+ game_bmp_h1;
     end;
    g_danci_weizhi.alpha:= 255;

    with g_jieshi_weizhi1.weizi do
    begin
     Left:= g_word_show_left;
     Top:= G_C_jieshi1_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= Top + game_bmp_h2;
     end;
     g_jieshi_weizhi1.alpha:= 255;

    with g_jieshi_weizhi2.weizi do
     begin
     Left:= g_word_show_left;
     Top:= G_C_jieshi2_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= top + game_bmp_h2;
     end;
    g_jieshi_weizhi2.alpha:= 255;

    with g_jieshi_weizhi3.weizi do
     begin
     Left:= g_word_show_left;
     Top:= G_C_jieshi3_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= top + game_bmp_h2;
     end;
     g_jieshi_weizhi3.alpha:= 255;

     with image_word do
       begin
       Size:= point(game_bmp_width,64);
       PatternSize:= point(game_bmp_width,game_bmp_h1);
       VisibleSize:= point(game_bmp_width,game_bmp_h1);
       end;

     with image_cn1 do
       begin
       Size:= point(game_bmp_width,32);
       PatternSize:= point(game_bmp_width,game_bmp_h2);
       VisibleSize:= point(game_bmp_width,game_bmp_h2);
       end;
     with image_cn2 do
       begin
       Size:= point(game_bmp_width,32);
       PatternSize:= point(game_bmp_width,game_bmp_h2);
       VisibleSize:= point(game_bmp_width,game_bmp_h2);
       end;
     with image_cn3 do
       begin
      Size:= point(game_bmp_width,32);
      PatternSize:= point(game_bmp_width,game_bmp_h2);
       VisibleSize:= point(game_bmp_width,game_bmp_h2);
       end;


     with image_up do
      begin
      Size:= point(game_bmp_width,32);
      PatternSize:= point(game_bmp_width,32);
       VisibleSize:= point(game_bmp_width,32);
      end;
    with image_down do
      begin
       Size:= point(game_bmp_width,32);
       PatternSize:= point(game_bmp_width,32);
       VisibleSize:= point(game_bmp_width,32);
      end;
      game_intl_pic;
      
end;

procedure TForm_pop.Timer5Timer(Sender: TObject);
begin
  inc(g_timer_count_5); //�ۼ�ʱ�䣬����ۼƵ�
  if G_mus_at= mus_nil then
    begin
    g_is_word_right:= false;
     exit;
    end;

  if g_timer_count_5= 50 then
   begin
     if ((G_mus_at= mus_jieshi1) and (jit_tmp_3=0)) or
        ((G_mus_at= mus_jieshi2) and (jit_tmp_3=1)) or
        ((G_mus_at= mus_jieshi3) and (jit_tmp_3=2))  then
        begin
         if form1.game_check_money(60)=1 then
           begin
            form1.game_change_money(-60);
            show_text(false,'��ȷ������60��Ǯ��');
            g_is_word_right:= true;
             add_to_errorword_list(game_dangqian_word_id); //��ӵ����󵥴ʱ���ϰ��
           end else show_text(false,'��Ǯ������������ʾ��');
        end else begin
                  g_is_word_right:= false;
                  if form1.game_check_money(60)=1 then
                   begin
                    show_text(false,'����´𰸲���ȷ��');
                   end else show_text(false,'��Ǯ������������ʾ��');
                 end;
   end else if  g_timer_count_5= 1 then
     begin
      show_text(false,'');

     end else if g_timer_count_5= 15 then
               show_text(false,'������ͣ��5�����ʾ��ʾ');
end;

function TForm_pop.get_Random_EXX: integer;
 function get_part_postion: integer;   //ȡ���ڷֶα�����ʱ�ĵ���id
  begin
   {�ֶα��������ֵĵ�һ��λ�ñ���һ������ָ��}
   result:= -1;
   if part_size_g= nil then exit;
   if length(part_size_g)= 1 then exit;
    //��һ��λ�ã�����ָ��
   if part_size_g[0]> 0 then
     begin
      if part_size_g[0]> high(part_size_g) then
         part_size_g[0]:= 1;
      result:= part_size_g[part_size_g[0]];
      inc(part_size_g[0]);
     end;
  end;
 procedure set_part_postion(t: integer);
 var i: integer;
  begin
    if part_size_g= nil then exit;
      if part_size_g[0]= 0 then
      begin
       for i:= 1 to length(part_size_g)-1 do
        begin
          if i=  high(part_size_g) then
                part_size_g[0]:= 1; //��⵽���һ��λ��ʱ��Ϊ1������и�С���⣬�����������;����ģ�����ȡһ������
          if part_size_g[i]= 0 then
            begin
             part_size_g[i]:= t;
             exit;
            end;
        end;
      end;
  end;
begin
   //���˳����߰�����˹����ȡֵ
  result:= -1;
  
   if game_abhs_g then
     result:= get_abhs_value;

   if result= -1 then
    begin
      //���ֶα���������
      result:= get_part_postion;
      if result> -1 then
        exit;

     if game_shunxu_g then
      begin
       result:= GameSave1.tip7; //ȡ��˳��ֵ
       inc(GameSave1.tip7);
       if GameSave1.tip7 >= wordlist1.Count then
          GameSave1.tip7:= 0;
      end else begin
                result:= Random(wordlist1.Count);
               end;
      set_part_postion(result); //���浽�ֶα��б�
    end;
   
end;

procedure TForm_pop.init_tiame_day_abhs;
begin
   //��ʼ��abhsָ��
   if game_abhs_g then
    begin
      if stringlist_abhs5.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs5.Strings[0],1,fastcharpos(stringlist_abhs5.Strings[0],',',1)-1),g_time_5) then
            g_time_5:= 0;

      if stringlist_abhs30.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs30.Strings[0],1,fastcharpos(stringlist_abhs30.Strings[0],',',1)-1),g_time_30) then
            g_time_30:= 0;
      if stringlist_abhs240.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs240.Strings[0],1,fastcharpos(stringlist_abhs240.Strings[0],',',1)-1),g_time_240) then
            g_time_240:= 0;
     if stringlist_abhs_d1.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d1.Strings[0],1,fastcharpos(stringlist_abhs_d1.Strings[0],',',1)-1),g_day_1) then
            g_day_1:= 0;
     if stringlist_abhs_d2.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d2.Strings[0],1,fastcharpos(stringlist_abhs_d2.Strings[0],',',1)-1),g_day_2) then
            g_day_2:= 0;
     if stringlist_abhs_d4.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d4.Strings[0],1,fastcharpos(stringlist_abhs_d4.Strings[0],',',1)-1),g_day_4) then
            g_day_4:= 0;
     if stringlist_abhs_d7.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d7.Strings[0],1,fastcharpos(stringlist_abhs_d7.Strings[0],',',1)-1),g_day_7) then
            g_day_7:= 0;
     if stringlist_abhs_d15.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d15.strings[0],1,fastcharpos(stringlist_abhs_d15.Strings[0],',',1)-1),g_day_15) then
            g_day_15:= 0;
      
   end;
end;

function TForm_pop.get_abhs_value: integer;
var k: integer;
    ss: string;
    label pp;
begin
   //���ذ�����˹ֵ
g_on_abhs:= false;

     result:= -1;
     init_tiame_day_abhs;
   k:= DateTimeToFileDate(now);
    //++++++++++++++++++++++++++++++++++++  g_time_5
   if g_time_5> 0 then
     begin
              if (k - g_time_5 > 300) and Assigned(stringlist_abhs5) and (stringlist_abhs5.Count> 0) then
               begin
                ss:= stringlist_abhs5.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs5.Delete(0);
                stringlist_abhs30.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs5.Count= 0 then
                   g_time_5:= 0;
                 goto pp;
               end;
     end;
  //++++++++++++++++++++++++++++++++++++  g_time_5 end

   //++++++++++++++++++++++++++++++++++++  g_time_30
     if g_time_30> 0 then
     begin
              if (k - g_time_30 > 1500) and Assigned(stringlist_abhs30) and (stringlist_abhs30.Count> 0) then
               begin
                ss:= stringlist_abhs30.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs30.Delete(0);
                stringlist_abhs240.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs30.Count= 0 then
                   g_time_30:= 0;

               goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_time_30 end

     //++++++++++++++++++++++++++++++++++++  g_time_240  ��Ϊ120����
      if g_time_240> 0 then
     begin
              if (k - g_time_240 > 5400) and Assigned(stringlist_abhs240) and (stringlist_abhs240.Count> 0) then
               begin
                ss:= stringlist_abhs240.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs240.Delete(0);
                stringlist_abhs_d1.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs240.Count= 0 then
                   g_time_240:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_time_240 end

       //++++++++++++++++++++++++++++++++++++  g_day_1
       if g_day_1> 0 then
     begin
              if (k - g_day_1 > 72000) and Assigned(stringlist_abhs_d1) and (stringlist_abhs_d1.Count> 0) then
               begin
                ss:= stringlist_abhs_d1.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d1.Delete(0);
                stringlist_abhs_d2.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d1.Count= 0 then
                   g_day_1:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_1 end

       //++++++++++++++++++++++++++++++++++++  g_day_2
        if g_day_2> 0 then
     begin
              if (k - g_day_2 > 86400) and Assigned(stringlist_abhs_d2) and (stringlist_abhs_d2.Count> 0) then
               begin
                ss:= stringlist_abhs_d2.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d2.Delete(0);
                stringlist_abhs_d4.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d2.Count= 0 then
                   g_day_2:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_2 end

       //++++++++++++++++++++++++++++++++++++  g_day_4
       if g_day_4> 0 then
     begin
              if (k - g_day_4 > 172800) and Assigned(stringlist_abhs_d4) and (stringlist_abhs_d4.Count> 0) then
               begin
                ss:= stringlist_abhs_d4.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d4.Delete(0);
                stringlist_abhs_d7.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d4.Count= 0 then
                   g_day_4:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_4 end

       //++++++++++++++++++++++++++++++++++++  g_day_7
         if g_day_7> 0 then
     begin
              if (k - g_day_7 > 259200) and Assigned(stringlist_abhs_d7) and (stringlist_abhs_d7.Count> 0) then
               begin
                ss:= stringlist_abhs_d7.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d7.Delete(0);
                stringlist_abhs_d15.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d7.Count= 0 then
                   g_day_7:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_7 end

       //++++++++++++++++++++++++++++++++++++  g_day_15
       if g_day_15> 0 then
     begin
              if (k - g_day_15 > 691200) and Assigned(stringlist_abhs_d15) and (stringlist_abhs_d15.Count> 0) then
               begin
                ss:= stringlist_abhs_d15.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d15.Delete(0);
                //stringlist_abhs.Append(ss);
                if stringlist_abhs_d15.Count= 0 then
                   g_day_15:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_15 end

    pp:
     if result >= wordlist1.Count then
          result:= Random(wordlist1.Count)
          else
                g_on_abhs:= true;

  if result= -1 then
     exit;

  if g_abhs_index<> result then
   begin
    g_abhs_index:= result;
    g_abhs_count:= 0;
   end else begin
               inc(g_abhs_count);
             if g_abhs_count>= 2 then
               result:= get_abhs_value;
               
            end;
 
end;

procedure TForm_pop.load_abhs;
var ss: string;
begin

   if (Game_save_path<> '') and (fastcharpos(Game_save_path,'!',1)> 0) then
      ss:= Game_save_path
     else ss:= game_doc_path_G+'save\';

   //if FileExists(ss+ '1'+ g_string_abhs) then    һ���ڵ�abhs������
   //  begin
      stringlist_abhs5.Clear; //���abhs
    //  stringlist_abhs5.LoadFromFile(ss+ '1' + g_string_abhs);
     // end;
    //  if FileExists(ss+ '2'+ g_string_abhs) then
    // begin
       stringlist_abhs30.Clear;
    // stringlist_abhs30.LoadFromFile(ss+ '2'+ g_string_abhs);
   //  end;
     // if FileExists(ss+ '3'+ g_string_abhs) then
   //  begin
      stringlist_abhs240.Clear;
  //  stringlist_abhs240.LoadFromFile(ss+ '3'+ g_string_abhs);
  //  end;
      if FileExists(ss+ '4'+ g_string_abhs) then
     begin
     stringlist_abhs_d1.Clear;
    stringlist_abhs_d1.LoadFromFile(ss+ '4'+ g_string_abhs);
    end;
      if FileExists(ss+ '5'+ g_string_abhs) then
     begin
     stringlist_abhs_d2.Clear;
    stringlist_abhs_d2.LoadFromFile(ss+ '5'+ g_string_abhs);
    end;
      if FileExists(ss+ '6'+ g_string_abhs) then
     begin
     stringlist_abhs_d4.Clear;
    stringlist_abhs_d4.LoadFromFile(ss+ '6'+ g_string_abhs);
    end;
      if FileExists(ss+ '7'+ g_string_abhs) then
     begin
     stringlist_abhs_d7.Clear;
     stringlist_abhs_d7.LoadFromFile(ss+ '7'+ g_string_abhs);
    end;
      if FileExists(ss+ '8'+ g_string_abhs) then
     begin
     stringlist_abhs_d15.Clear;
     stringlist_abhs_d15.LoadFromFile(ss+ '8'+ g_string_abhs);
    end;
end;

procedure TForm_pop.save_abhs;
var ss: string;
begin
   if game_abhs_g then
    begin
     if fastcharpos(Game_save_path,'!',1)> 0 then
     ss:= Game_save_path
     else
     ss:= game_doc_path_G+'save\';

     // if stringlist_abhs5.Count > 0 then               һ���ڵ�abhs������
    {  stringlist_abhs5.SaveToFile(ss+ '1'+ g_string_abhs);
     if stringlist_abhs30.Count > 0 then
     stringlist_abhs30.SaveToFile(ss+ '2'+ g_string_abhs);
     if stringlist_abhs240.Count > 0 then
    stringlist_abhs240.SaveToFile(ss+ '3'+ g_string_abhs);  }
    if stringlist_abhs_d1.Count > 0 then
    stringlist_abhs_d1.SaveToFile(ss+ '4'+ g_string_abhs);
    if stringlist_abhs_d2.Count > 0 then
    stringlist_abhs_d2.SaveToFile(ss+ '5'+ g_string_abhs);
    if stringlist_abhs_d4.Count > 0 then
    stringlist_abhs_d4.SaveToFile(ss+ '6'+ g_string_abhs);
    if stringlist_abhs_d7.Count > 0 then
    stringlist_abhs_d7.SaveToFile(ss+ '7'+ g_string_abhs);
    if stringlist_abhs_d15.Count > 0 then
   stringlist_abhs_d15.SaveToFile(ss+ '8'+ g_string_abhs);
    end;
end;

procedure TForm_pop.del_abhs;
var ss: string;
begin

     if fastcharpos(Game_save_path,'!',1)> 0 then
     ss:= Game_save_path
     else
     ss:= game_doc_path_G+'save\';

      stringlist_abhs5.Clear; //���abhs
      DeleteFile(ss+'1' + g_string_abhs);


       stringlist_abhs30.Clear;
     DeleteFile(ss+'2'+ g_string_abhs);


      stringlist_abhs240.Clear;
    DeleteFile(ss+'3'+ g_string_abhs);


     stringlist_abhs_d1.Clear;
    DeleteFile(ss+'4'+ g_string_abhs);


     stringlist_abhs_d2.Clear;
    DeleteFile(ss+'5'+ g_string_abhs);


     stringlist_abhs_d4.Clear;
    DeleteFile(ss+'6'+ g_string_abhs);


     stringlist_abhs_d7.Clear;
     DeleteFile(ss+'7'+ g_string_abhs);


     stringlist_abhs_d15.Clear;
     DeleteFile(ss+'8'+ g_string_abhs);

     DeleteFile(ss+'1words.ini.abhs');
     DeleteFile(ss+'2words.ini.abhs');
     DeleteFile(ss+'3words.ini.abhs');
     DeleteFile(ss+'4words.ini.abhs');
     DeleteFile(ss+'5words.ini.abhs');
     DeleteFile(ss+'6words.ini.abhs');
     DeleteFile(ss+'7words.ini.abhs');
     DeleteFile(ss+'8words.ini.abhs');

end;

procedure TForm_pop.ComboBox1Enter(Sender: TObject);
begin
  combobox1.Tag:= combobox1.ItemIndex;
end;

procedure TForm_pop.game_up_role; //��������
var i,k: integer;
    str1: Tstringlist;
    t: Tplayer;
begin
str1:= Tstringlist.Create;
   for i:= 0 to 4 do
      begin
        k:= game_upgrade(i);
        if k > 0 then
         begin
          t:= game_get_role_from_i(i);
             str1.Append(t.plname + ' ������'+ inttostr(k)+' ��');
         end;
      end;

       if str1.Count > 0 then
        begin
         draw_text_17_m(str1,1000,clblack);
         G_game_delay(3000);
        end;
str1.free;
     {
   �������200����
   ���� 2000��ÿ���� 10��
   ���� 10000��ÿ���� 50��
   ���� 5000�� ÿ���� 25��
   ����ֵ����һ��500����һ�����Ժ���ֵ���Եȼ�
   �٣��ǣ�����ÿ����һ��
  }
end;

function TForm_pop.get_error_words: string;
begin
   result:= '��'+inttostr(jit_word_p+1)+'���ʣ�'+ get_word_safe(jit_word_p);
end;

procedure TForm_pop.save_set(const s: string);
begin
  save_check;
 gamesave1.leiji:= gamesave1.leiji + Trunc((now - jit_kssj) *24*60*60);
 save_game_progress(s+ 'default.sav');
end;

procedure TForm_pop.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;
end;

procedure TForm_pop.Action21Execute(Sender: TObject);
begin
   if G_word = g_dangqian_zhuangtai then
    begin
      skp_string(Jit_words);
    end;
end;

function TForm_pop.get_pop_string(c: integer): string;
begin
    // ��ȡpop�ַ���
    pk_zhihui_g.game_zt:=1;
    if game_at_net_g then
     set_caoshi_list_value(g_nil_user_c); //��ʼ����ʱ��¼��

    result:= '<table align=center style="font-size:28pt;"><tr><td align=right><font size=3>'+ inttostr(game_pop_count) + '</font></td></tr>';
    dec(game_pop_count);
        jit_num:= 1;
    result:= result+ start_show_word(true) + '</table>';

end;

function TForm_pop.html_asw_string(c: integer): string;
begin
    //��ȡѡ��𰸺���ַ���

    result:= '<table align=center style="font-size:28pt;"><tr><td align=right><font size=3>'+ inttostr(game_pop_count) + '</font></td></tr>' +
             check_asw(c,true) + '</table>';

end;

function TForm_pop.create_net_guai(id: integer): boolean;
var c,d1: integer;
    t: cardinal;
     i: integer;
begin
     //�������ͣ�һ�����±�ʾ���ع֣�һ�����ϣ������߶���һ��sid��������������һ��С��id
    {
     �õ�һ��������
     �ǻ�ȡ����ֵĹ�����

     Tnet_guai=packed record
      sid: word;       //��������Ĺ֣�sid
      ming: integer;
      ti:   integer;
      ling: integer;
      shu:  integer;
      gong: integer;
      fang: integer;
      L_fang:word; //��ʱ����ֵ
    }
    c:= 0;
    if (id > 0) and (id < 10000) then
     begin
       result:= false;
       exit;
     end;

    longrec(d1).Lo:= g_nil_user_c;
    longrec(d1).Hi:= g_nil_user_c;
      for i:= 0 to 4 do
        net_guai_g[i].sid:= g_nil_user_c;

    if id > 10000 then
     begin
       //����һ��������  cmd ����һ����ʾ��ȡһ��������

        c:= 1;
       longrec(d1).Hi:= longrec(id).Hi;

     end else if id < 0 then
               begin
                 //����һ��С�ӵĹ�����
                c:= 2; // ��ʾ��ȡһ��С�ӵĹ�����
                d1:= abs(id);

               end;
    //�������ݣ����ȴ������Ϸ���
     screen.Cursor:= crhourglass;
    send_pak_tt(g_rep_guai_c,c,d1,0,my_s_id_g);

    t:= GetTickCount;
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;
      screen.Cursor:= crdefault;
    if Game_wait_ok1_g and (game_wait_integer_g > 0) then
     begin
      //�ִ����ɹ�
      result:= true;
     end else  result:= false; //������������Ĺ�ʧ��
end;

procedure TForm_pop.net_cmd_center(c, d1, d2: integer; sid: word);
var i: integer;
begin
     //����ʱ������Ȩ�����������
     //pk_zhihui_g.game_zt: integer;   //0����״̬��1�������ʣ�2�ڿ�3��ҩ��4��������5������6ս��
    if (game_player_head_G.duiwu_dg= 0) or (game_at_net_g= false)
      or (pk_zhihui_g.game_zt= 0) then
       exit;

    {
     data1��Ϊ1��ʾ��Ҫ���µ��ȣ�Ϊ���ʾ����˿���Ȩ
     �п���Ȩʱ�����������ʴ��ڣ�������Ĳ��ԣ���ôʧȥ�����Ļ���

     
     sid��ʾ�˻�ÿ���Ȩ��sid��������Լ�����˿���Ȩ����ô��ʼ��Ӧ����������������˻���˿���Ȩ����ô
     ������Ӧ����

    }
   if d1= 1 then
    begin
      //���µ���
      net_cmd_send_center;
      exit;
    end;

   pk_zhihui_g.is_kongzhi:= (sid= my_s_id_g);

   //��������
     i:= sid_to_roleId(sid);  //���ｫͬʱ���õ���ʱ��Ҫ������
     if i >= 5 then
       highlight_guai_base(i -5)
      else
        highlight_my_base(i);

   //��ʾ����ʱ �ӳ��ĵ���ʱҪ�༸�룬�����������
    if game_player_head_G.duiwu_dg= 100 then
       Timer_daojishi.Tag:= 35
       else
         Timer_daojishi.Tag:= 30;
     Timer_daojishi.Enabled:= true;

   if pk_zhihui_g.is_kongzhi then
    begin
      //��ʾ����
      start_show_word(false);
    end;
end;

function TForm_pop.sid_to_roleId(sid: integer): integer;
var i: integer;
begin
     // ��sidת��Ϊrole����guai����Ļid ��ͬʱ�趨����ʱ��λ��

result:= 0;



     text_show_array_G[5].peise:= $FF00887C;
      text_show_array_G[5].xiaoguo:= fxNone;


    //0--4���ҷ���ţ�5--9���з����
    if sid= my_s_id_g then
     begin
      result:= 0;  //�Լ�����������ǰ���
      text_show_array_G[5].left1:= g_get_roleAndGuai_left(0) + game_bmp_role_width -9;
      text_show_array_G[5].top1:= g_C_role_top + 8;
      exit;
     end;

     if sid= (g_nil_user_c-11) then
     begin
      result:= -1;  //g_nil_user_c-11,����ת��Ϊ -1
      text_show_array_G[5].left1:= g_get_roleAndGuai_left(0) + game_bmp_role_width -9;
      text_show_array_G[5].top1:= g_C_role_top + 8;
      exit;
     end;

       for i:= 0 to 4 do
        if net_guai_g[i].sid= sid then
         begin
          result:= i+ 5;
          text_show_array_G[5].left1:= g_get_roleAndGuai_left(result)+ game_bmp_role_width -9;
           text_show_array_G[5].top1:= g_C_guai_top+ game_bmp_role_h + 18;
          exit;
         end;

    if not game_at_net_g then
      begin
        result:= sid;
        exit; //���������������Ϸ������ֵ�sidûƥ�� ֱ���˳�
      end;

      for i:= 0 to 3 do
        if game_player_head_G.duiyuan[i] =sid then
           result:= i+ 1;

     text_show_array_G[5].top1:= g_C_role_top + 8;
     text_show_array_G[5].left1:= g_get_roleAndGuai_left(result)+ game_bmp_role_width -9;
end;

procedure TForm_pop.Timer_daojishiTimer(Sender: TObject);
begin
  //����ʱ
     text_show_array_G[5].xianshi:= true;
      Timer_daojishi.Tag:= Timer_daojishi.Tag -1;
       text_show_array_G[5].zhi:= inttostr(Timer_daojishi.Tag div 10);

      if time_list1.Timer_show_jit_word= -50 then //��100��ʼ
       begin
         //�ٴ���ʾӢ��
        draw_asw(jit_words,0);
        draw_asw('����Ӣ��',3);
        time_list1.Timer_show_jit_alpha:= 0;
       end else if time_list1.Timer_show_jit_word< -50 then
                 begin
                   if time_list1.Timer_show_jit_alpha=1 then
                    begin
                     //-255..0..255  �䰵
                     if time_list1.Timer_show_jit_word mod 10 = 0 then
                        draw_asw(game_word_1,0)  //��ʾ����
                        else if time_list1.Timer_show_jit_word mod 10 = -4 then
                                draw_asw(jit_words,0);

                       // inc(time_list1.Timer_show_jit_alpha);
                    end;

                 end;
      inc(time_list1.Timer_show_jit_word);

 if  Timer_daojishi.Tag<= 0 then
    begin
       text_show_array_G[5].xianshi:= false;   //��ʱ����������Ƕӳ������������·������Ȩ������
       Timer_daojishi.Enabled:= false;

     if not game_at_net_g then
     begin
      //��������Ϊ������ʧ�ܣ���ʱ
       add_to_errorword_list(game_dangqian_word_id);
          edit1.Visible:= false;
         edit1.Text:= '';
       after_check_asw(false);

     end else begin
      pk_zhihui_g.is_kongzhi:= false;
      if pk_zhihui_g.is_zhihui then
        begin
          set_caoshi_list_value(game_player_head_G.kongzhiquan); //��ǰ����Ȩ������д��һ�γ�ʱ��¼
          //���µ���
          net_cmd_send_center;
        end;
              end;
    end;
end;

function TForm_pop.roleId_to_sid(roleId: integer): integer;
begin
     // ��roleidת��Ϊsid��0-4���ҷ�id��5-9�ǵз�id

     if roleId in[5..9] then
       begin
       result:=  net_guai_g[roleId- 5].sid;
       exit;
       end;

     if not game_at_net_g then
      begin
        if roleId= -1 then
           result:= g_nil_user_c- 11
           else
            result:= roleid;
        exit; //���������������Ϸ����ֱ���˳�
      end;

result:= g_nil_user_c;





    //0--4���ҷ���ţ�5--9���з����
    if roleId= 0 then
     begin
      result:= my_s_id_g;  //�Լ�����������ǰ���
      exit;
     end else if roleId= -1 then
                 begin
                  result:= g_nil_user_c- 11;  //-1�̶�ת��Ϊ��ֵ
                  exit;
                 end;


    if roleId in[1..4] then
       result:= game_player_head_G.duiyuan[roleId-1];

end;

procedure TForm_pop.net_cmd_send_center; //����ʱ�����������
var sid: word;
begin
      {
       1.ȡ��һ����ǰ�ֵ�������
       2��������Լ������ڿ���Ȩ����ʼ����
       ����Ǳ��ˣ����Ϳ���Ȩָ��
       4������ǹ����ʵ����ң���ֱ�Ӽ�����˺�ֵ��Ȼ���Ͷ���ָ��
          ���ڶ������������µ���
       }

    if (game_player_head_G.duiwu_dg<> 0) and (game_player_head_G.duiwu_dg<> 100) then
       exit;  //�Ȳ��Ƕӳ�Ҳ��������ģʽ���˳�


  g_wo_guai_dangqian:=  game_p_list_ex; //�õ��ֵ�ս��������id�����ٶ���

      // 0--4���ҷ���Ա��5--9���з���Ա

     sid:= roleId_to_sid(g_wo_guai_dangqian); //ȡ�õ�ǰ��sid

     if sid < g_nil_user_c then
     begin
       {�������˿���Ȩ}
          net_cmd_center(0, 0, 0, sid); //�˻�û���

      Data_net.send_game_kongzhi(0, 0, 0,sid); //���Ϳ���Ȩ����
     end else begin
               // �ֻ�û��ᣬֱ�Ӽ�����˺�ֵ��Ȼ���Ͷ���

              end;

  write_label2_11; //������ʾ
end;

{����ʱ����ָ�����}
procedure TForm_pop.net_rec_game_cmd(fq_sid: word;   //����sid
                                  js_sid: word;    //���ܷ����ܹ�������sid
                                  fq_m: integer;
                                  fq_t: integer;   //�����飬���𷽴��͵�����ֵ
                                  fq_l: integer;
                                  js_m: integer;   //���ܷ����͵��ǲ�ֵ
                                  js_t: integer;
                                  js_l: integer;
                                  flag: word;    //���ͣ�ָ����0�޶�����1����������2����������3��Ʒ������4��Ʒ�ָ���5�����ָ���6,��7��
                                  wu: word);
begin
//��ʱ��ֹͣ����ʼ����
   Timer_daojishi.Enabled:= false;
   text_show_array_G[5].xianshi:= false;
   //***************************************
        //highlight_my(p); //��������

   //***************************************

 //���������������ָ�ӣ���ô�������µ���ָ�� ?����Ҫд�ڱ�ĵط�
    if pk_zhihui_g.is_zhihui then
          net_cmd_send_center;
end;

procedure TForm_pop.gong_js(f, j,w: integer;guai: boolean); //�ҷ��������������������
var x: Tmtl_rec;
    q,q2,fh: integer;
begin
   {
    ���㹥�����˺�ֵ��f��ʾ����id��J��ʾ��������id
    w��ʾ��Ʒ���
    guaiΪtrue����ʾ�Ǽ������Ĺ�����

    �趨����������ֵ�ͱ��������Ĳ�ֵ
    ������ʼʱ�趨��ֵ�������������趨��ֵ
   }
  // ˳��idתΪsid
    mtl_game_cmd_dh1.flag:= 0;
    mtl_game_cmd_dh1.fq_sid:= roleId_to_sid(f);
    mtl_game_cmd_dh1.js_sid:= roleId_to_sid(j);
    // mtl_game_cmd_dh1.flag:= ��ֵ��֮ǰ�Ĺ����ڱ��趨
    mtl_game_cmd_dh1.wu:= w;   //��Ʒ����

     f_time_role_id:= j;
     

    if guai then
    begin
      if j= -1 then  //�����Ⱥ������ô��ȡһ�����id��ȡ�÷���ֵ
     fh:= get_r_role_id
     else
      fh:= j;
     x:=game_get_Attack_value(game_guai_xishu_f,w);  //ȡ�ùַ������� ����Ϊ�������ͣ����趨�ַ���ֵ��
     q2:= game_read_values(get_pid_from_showId(fh),ord(g_defend)) * game_read_values(get_pid_from_showId(fh),ord(g_linshifang)); //����ֵ

    end else begin
              x:= game_get_my_Attack_value(w);  //ȡ���ҷ������� ����Ϊ�������ͣ����趨�ҷ���ֵ��
              if j= -1 then  //�����Ⱥ������ô��ȡһ�����id��ȡ�÷���ֵ
               fh:= get_min_guai_f
               else
                 fh:= j;
               if fh >= 5 then
                  fh:= fh -5;
              q2:= net_guai_g[fh].fang + net_guai_g[f].L_fang;
              
             end;


              {���ڷ��ص�����Ϊ���������ԣ�����ֵ�Ǽ���ȥ
              �������ֻ����ֵ������}
               if x.m.Lo<> 0 then
               q:= round((q2 / abs(x.m.Lo) + 1) * 10)
               else q:= 2; //����ϵ��
            
            game_guai_fanghu_xishu_f:= Game_base_random(q);
            if game_guai_fanghu_xishu_f > 10 then
               x.m.Lo:= x.m.Lo + q2
                else
                 x.m.Lo:= x.m.Lo + (q2 div (5+ Game_base_random(6)));

            if x.m.Lo > 0 then
              x.m.Lo:= 0;
          with mtl_game_cmd_dh1 do  //�趨��ֵ
          begin
          js_m:=      x.m.Lo;
          js_t:=      x.t.Lo;
          js_l:=      x.l.Lo;
          js_g:=   x.m.Hi;
          js_f:=   x.t.Hi;
          js_shu:=    x.l.Hi;
          end;


end;

procedure TForm_pop.huifu_js(f, j, w: integer);   //����ָ�ֵ
     procedure add_blood(p2: integer; kk: integer;ll: boolean);      //�ָ�����Ƕ����
        var t2:Tplayer;
            j2: integer;
        begin
          t2:= game_get_role_from_i(p2);
           if t2= nil then
            exit;
                                  //����ȫ���Ͱ����ģ����ܵȼ�����������

                                  j2:= data2.get_game_goods_type(w,goods_m1);

                                  if t2.plvalues[ord(g_life)] <= 0 then
                                   if j2< game_m_ban_qi then
                                     exit;  //��ֵС��8��9�����������������˳�

                                if (j2= game_m_quan_qi) or (j2=game_m_quan) then
                                   j2:= t2.plvalues[ord(g_gdsmz27)]
                                    else if (j2= game_m_ban_qi) or (j2=game_m_ban) then
                                         j2:= t2.plvalues[ord(g_gdsmz27)] div 2
                                          else j2:= j2 * (kk+10) div 10 + t2.plvalues[ord(g_life)];

                               if j2 > t2.plvalues[ord(g_gdsmz27)] then
                                  j2:= t2.plvalues[ord(g_gdsmz27)];
                                 // 27 ����ֵ 100
                                {�޸�Ϊ��ͳһ�������ڵĲ�ֵ
                               game_show_blood(true,j2- t2.plvalues[ord(g_life)],p2,1);
                                t2.plvalues[ord(g_life)]:= j2;
                                G_game_delay(500); //Ʈ��ʱ�� }
                                mtl_game_cmd_dh1.js_m:=j2- t2.plvalues[ord(g_life)];

                              j2:= data2.get_game_goods_type(w,goods_t1);
                                if (j2= game_m_quan_qi) or (j2=game_m_quan) then
                                   j2:= t2.plvalues[ord(g_gdtl25)]
                                    else if (j2= game_m_ban_qi) or (j2=game_m_ban) then
                                         j2:= t2.plvalues[ord(g_gdtl25)] div 2
                                          else j2:= j2 * (kk+10) div 10 + t2.plvalues[ord(g_tili)];

                               if j2 > t2.plvalues[ord(g_gdtl25)] then
                                  j2:= t2.plvalues[ord(g_gdtl25)];
                                  //��������
                                 //Ʈ����Ʈ������false���£�Ʈ����ֵ������id�����ͣ�1Ѫ������������������
                               { game_show_blood(true,j2-t2.plvalues[ord(g_tili)],p2,2);
                                 t2.plvalues[ord(g_tili)]:= j2;
                                G_game_delay(500); //Ʈ��ʱ��  }
                                   mtl_game_cmd_dh1.js_t:=j2- t2.plvalues[ord(g_tili)];
                                if ll then
                                begin
                                j2:= data2.get_game_goods_type(w,goods_L1);
                                if (j2= game_m_quan_qi) or (j2=game_m_quan) then
                                   j2:= t2.plvalues[ord(g_gdll26)]
                                    else if (j2= game_m_ban_qi) or (j2=game_m_ban) then
                                         j2:= t2.plvalues[ord(g_gdll26)] div 2
                                          else j2:= j2 * (kk+10) div 10 + t2.plvalues[ord(g_lingli)];
                               if j2 > t2.plvalues[ord(g_gdll26)] then
                                  j2:= t2.plvalues[ord(g_gdll26)];
                                 // 26 ���� 0
                              { game_show_blood(true,j2-t2.plvalues[ord(g_lingli)],p2,3);
                                t2.plvalues[ord(g_lingli)]:= j2; }
                                mtl_game_cmd_dh1.js_l:=j2- t2.plvalues[ord(g_lingli)];
                                end; //�ָ�����

        end;
var i,k,k2: integer;
    label pp;
begin
   //����Ϊ�ָ������ߣ��ָ������ߣ��ָ����ͣ�����̽������ҷ�����Ļָ����ֵĻָ���������
   //�ж�����Ʒ�ָ����Ƿ����ָ����۳���Ʒ�������۳��������ĵ�����
   //p����-1����ʾȫ��ָ�

   {�ָ����ļ������
   �ָ����Ķ�������}
    mtl_game_cmd_dh1.flag:= 0;
   mtl_game_cmd_dh1.fq_sid:= roleId_to_sid(f);
    mtl_game_cmd_dh1.js_sid:= roleId_to_sid(j);
    // mtl_game_cmd_dh1.flag:= ��ֵ��֮ǰ�Ĺ����ڱ��趨
    mtl_game_cmd_dh1.wu:= w;   //��Ʒ����

    //����Ʒ��ʱ����ʹ�õı�����0-4���ҷ����5-9���з�����
        f_time_role_id:= j;
        if j >= 5 then
           j:= j -5;

      with mtl_game_cmd_dh1 do
      begin
      fq_m:= game_read_values(get_pid_from_showId(f),ord(g_life));
      fq_t:= game_read_values(get_pid_from_showId(f),ord(g_tili));
      fq_l:= game_read_values(get_pid_from_showId(f),ord(g_lingli));
      js_g:= 0;
      js_f:= 0;
      js_shu:= 0;
      end;

               k:= game_fashu__filter(w); //ȡ�õȼ���������������
             i:= data2.get_game_goods_type(w,goods_type1); //ȡ������
               if i and 128= 128 then
                begin
                //�����ָ����۳��ָ�����������
                 //�۳�����
              //   if f=j then //�����ͬһ���ˣ���۳�˫����������Ϊ��ָ�һ����
               //   mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- data2.get_game_goods_type(w,goods_L1) *2
               //  else
                 mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- data2.get_game_goods_type(w,goods_L1);



                 //������������Ӧ��ֵ������������
                 if j= -1 then
                  begin
                     //***********************************************************
                    {for i2:= 0 to 4 do
                       add_blood(i2,k,false); ȫ��ظ��ģ���һ��ͳһֵ}
                       k2:= data2.get_game_goods_type(w,goods_m1);
                                if (k2= game_m_quan_qi) or (k2=game_m_quan) then
                                   mtl_game_cmd_dh1.js_m:= 32767   //ȫ��
                                    else if (k2= game_m_ban_qi) or (k2=game_m_ban) then
                                        mtl_game_cmd_dh1.js_m:= 32766 //����
                                          else mtl_game_cmd_dh1.js_m:= k2 * (k+10) div 10;
                              k2:= data2.get_game_goods_type(w,goods_t1);
                                if (k2= game_m_quan_qi) or (k2=game_m_quan) then
                                    mtl_game_cmd_dh1.js_t:= 32767
                                    else if (k2= game_m_ban_qi) or (k2=game_m_ban) then
                                         mtl_game_cmd_dh1.js_t:= 32766
                                          else mtl_game_cmd_dh1.js_t:= k2 * (k+10) div 10;
                                mtl_game_cmd_dh1.js_l:= 0; //�������ӵ�����
                    //************************************************************
                  end else add_blood(j,k,false);
                end else if (i and 2= 2) or (i and 256= 256) then
                          begin

                            //�۳���Ʒ����������Ʒ���ǵ���ָ�
                            if read_goods_number(w)> 0 then
                                write_goods_number(w,-1)
                                else
                                  goto pp;

                            //��������Ʒ��������ֱ�ӹ���ֵ�⣬��Ҫ��ʱ

                                if game_read_values(get_pid_from_showId(j),ord(g_life)) <= 0 then
                                   if data2.get_game_goods_type(w,goods_m1)< game_m_ban_qi then
                                     goto pp;  //��Ʒ��ֵС��8��9�����������������˳�
                                  { ������Щֵ�ڶ�ʱ���������ڻ��
                               t.plvalues[1]:=t.plvalues[1]+ data2.get_game_goods_type(d,goods_y1);  //����ֵ
                               t.plvalues[2]:=t.plvalues[2]+ data2.get_game_goods_type(d,goods_s1);   //2���ٶ�
                               t.plvalues[3]:=t.plvalues[3]+ data2.get_game_goods_type(d,goods_g1);  // 3��������
                               t.plvalues[7]:=t.plvalues[7]+ data2.get_game_goods_type(d,goods_z1);   //7������
                               t.plvalues[20]:=t.plvalues[20]+ data2.get_game_goods_type(d,goods_f1);  // 20������ֵ
                                                                 }

                               add_blood(j,0,true); //�����壬�飬���ڶ�������Ϊ�㣬��ʾû�и��ӵĵȼ�
                               pp: time_list1.Timer_wupin_huifu:= true;
                           if data2.get_game_goods_type(w,goods_n1)<>0 then
                              begin
                                //���嶨ʱ��
                                game_add_to_goods_time_list(w);
                              end;
                          end;


end;

procedure TForm_pop.huifu_donghua;  //�ָ�ʱ����
var t2: Tplayer;
    fq1,js1,i: integer;
     function can_show(i88: integer): boolean;
      begin
       result:= true;
        t2:= game_get_role_from_i(i88); //ȡ�ý�����ʵ����������������
               if t2<> nil then
                begin
                 if (js1= -1) and (t2.plvalues[ord(g_life)]<= 0) then
                    result:= false;
                 end else result:= false;
      end;
      procedure add_mtl(i88: integer);
      var m: smallint;
      begin
       t2:= game_get_role_from_i(i88); //ȡ�ý�����ʵ����������������
               if t2<> nil then
                begin
                 if (js1= -1) and (t2.plvalues[ord(g_life)]<= 0) then
                    exit;

                 if  mtl_game_cmd_dh1.js_m = 32767 then
                     m:= t2.plvalues[ord(g_gdsmz27)]
                     else if mtl_game_cmd_dh1.js_m = 32766 then
                        m:= t2.plvalues[ord(g_gdsmz27)] div 2
                        else m:= mtl_game_cmd_dh1.js_m;
                 t2.plvalues[ord(g_life)]:= t2.plvalues[ord(g_life)] +m;
                  if t2.plvalues[ord(g_life)] > t2.plvalues[ord(g_gdsmz27)] then
                     t2.plvalues[ord(g_life)]:= t2.plvalues[ord(g_gdsmz27)];

                 if  mtl_game_cmd_dh1.js_t = 32767 then
                     m:= t2.plvalues[ord(g_gdtl25)]
                     else if mtl_game_cmd_dh1.js_t = 32766 then
                        m:= t2.plvalues[ord(g_gdtl25)] div 2
                        else m:= mtl_game_cmd_dh1.js_t;
                 t2.plvalues[ord(g_tili)]:= t2.plvalues[ord(g_tili)] +m;
                    if t2.plvalues[ord(g_tili)] > t2.plvalues[ord(g_gdtl25)] then
                     t2.plvalues[ord(g_tili)]:= t2.plvalues[ord(g_gdtl25)];

                 if  mtl_game_cmd_dh1.js_l = 32767 then
                     m:= t2.plvalues[ord(g_gdll26)]
                     else if mtl_game_cmd_dh1.js_l = 32766 then
                        m:= t2.plvalues[ord(g_gdll26)] div 2
                        else m:= mtl_game_cmd_dh1.js_l;
                 t2.plvalues[ord(g_lingli)]:= t2.plvalues[ord(g_lingli)] +m;
                    if t2.plvalues[ord(g_lingli)] > t2.plvalues[ord(g_gdll26)] then
                     t2.plvalues[ord(g_lingli)]:= t2.plvalues[ord(g_gdll26)];
                end;
      end;
begin
     {�ָ������������
     1������ʱ���ҷ�����ָ�
     2������ʱ���ָֻ�
     3������ʱ���ҷ�����ָ�
     4������ʱ���ָֻ�
      ����������sid���ҷ������ڲ�����ʱû��sid
     }
     
     game_pic_check_area:= G_all_Pic_n;
    G_DanTiWuPinHuiFu.time:= Game_amt_length;
    G_DanTifashuHuiFu.time:= Game_amt_length;
    G_quanTiFaShuHuiFu.time:= Game_amt_length;
    
    fq1:= sid_to_roleId(mtl_game_cmd_dh1.fq_sid);
    js1:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);

         if fq1>= 5 then
          highlight_guai(fq1-5)
          else
            highlight_my(fq1); //��������

         if js1>= 5 then
          highlight_guai(js1-5)
          else  if js1= -1 then
                begin
                     highlight_my(js1);
                end else
                 highlight_my(js1); //��������



   //   ��������
   if js1=-1 then
    time_list1.Timer_fashu_huifu:= true
   else
   time_list1.Timer_wupin_huifu:= true;

    if js1= -1 then
     begin
      for i:= 0 to 4 do
        if can_show(i) then
           game_show_blood(true,mtl_game_cmd_dh1.js_m,i,1);
     end else
       game_show_blood(true,mtl_game_cmd_dh1.js_m,js1,1);
    G_game_delay(500); //Ʈ��ʱ��
      //��������
   //Ʈ����Ʈ������false���£�Ʈ����ֵ������id�����ͣ�1Ѫ������������������
  if js1= -1 then
     begin
      for i:= 0 to 4 do
        if can_show(i) then
        game_show_blood(true,mtl_game_cmd_dh1.js_t,i,1);
     end else
  game_show_blood(true,mtl_game_cmd_dh1.js_t,js1,2);
    G_game_delay(500); //Ʈ��ʱ��
  // 26 ���� 0
    if js1= -1 then
     begin
      for i:= 0 to 4 do
        if can_show(i) then
        game_show_blood(true,mtl_game_cmd_dh1.js_l,i,1);
     end else
   game_show_blood(true,mtl_game_cmd_dh1.js_l,js1,3);

   //�޸�ֵ
  if fq1>= 5 then
   begin
    //���ڵ���5�ģ���ʾ��
    fq1:= fq1-5;
    net_guai_g[fq1].ming:= mtl_game_cmd_dh1.fq_m;
    net_guai_g[fq1].ti:= mtl_game_cmd_dh1.fq_t;
    net_guai_g[fq1].ling:= mtl_game_cmd_dh1.fq_l;

   end else begin
               t2:= game_get_role_from_i(fq1); //ȡ�÷�����ʵ����������������
               if t2<> nil then
                begin
                 t2.plvalues[ord(g_life)]:= mtl_game_cmd_dh1.fq_m;
                 t2.plvalues[ord(g_tili)]:= mtl_game_cmd_dh1.fq_t;
                 t2.plvalues[ord(g_lingli)]:= mtl_game_cmd_dh1.fq_l;
                end;
            end;

   if js1>= 5 then
   begin
    //���ڵ���5�ģ���ʾ��
    net_guai_g[js1-5].ming:= net_guai_g[js1-5].ming + mtl_game_cmd_dh1.js_m;
    net_guai_g[js1-5].ti:= net_guai_g[js1-5].ti     + mtl_game_cmd_dh1.js_t;
    net_guai_g[js1-5].ling:= net_guai_g[js1-5].ling + mtl_game_cmd_dh1.js_l;

   end else begin
               if js1=-1 then
                begin
                for i:= 0 to 4 do
                   add_mtl(i);
                end else add_mtl(js1);

            end;

  draw_game_role(-1); //�ػ�
end;

function TForm_pop.game_get_role_from_sid(i: integer): Tplayer;
var j: integer;
begin

result:= nil;
  for j:= 0 to Game_role_list.Count-1 do
    begin
     if Assigned(Game_role_list.Items[j]) then
      if Tplayer(Game_role_list.Items[j]).plvalues[34]= i then
       begin
        result:= Tplayer(Game_role_list.Items[j]);
        exit;
       end;
    end;

end;

function TForm_pop.get_comp_word: boolean;
    var ss: string;
     begin
     result:= false;

     case jit_tmp_3 of
      0: ss:= game_word_1;
      1: ss:= game_word_2;
      2: ss:= game_word_3;
     end;

      if (comparetext(trim(edit1.Text),trim(jit_words))=0) or (comparetext(trim(edit1.Text),trim(ss))=0) then
         begin
          if (edit1.Text<>'') and (edit1.Text[1]=' ') then
             add_to_errorword_list(game_dangqian_word_id); //��Ϊ���ʣ���ӵ������б�
         result:= true;
         end else begin
                if length(edit1.Text) >= 20 then
                  begin
                    if ByteType(edit1.Text,1)= mbLeadByte then
                      begin
                        //���������
                        exit;
                       { if (pos(edit1.Text,ss)> 0) or (pos(edit1.Text,jit_words)> 0) then
                           result:= true; }
                      end else if (pos(edit1.Text,ss)> 0) or (pos(edit1.Text,jit_words)> 0) then
                           result:= true;
                  end;
              end;
end;

procedure TForm_pop.Edit1Change(Sender: TObject);
    
begin
   {1��������ڵ��ʻ��ߵ�����ȷ�𰸵ģ���ôʤ�������˳�
   2�����򣬱Ƚ��Ƿ�ƥ�䲿�ִ�
   3��
   }

   if game_bg_music_rc_g.type_char_spk and (edit1.Text<> '') then
     begin
       form1.game_spk_string(edit1.Text[length(edit1.Text)]);
     end;

     if edit1.Visible and get_comp_word then
        begin
         edit1.Visible:= false;
         text_show_array_G[5].xianshi:= false;
         Timer_daojishi.Enabled:= false;
         if game_bg_music_rc_g.type_char_spk then
            form1.game_spk_string(edit1.Text);
            
         edit1.Text:= '';
         draw_asw(game_word_1,2);
         after_check_asw(true);
        end else begin
                    if game_bg_music_rc_g.type_word_flash then
                     begin
                      time_list1.Timer_show_jit_word:= -100;
                      time_list1.Timer_show_jit_alpha:=1;
                       draw_asw('5�����ٴ���ʾ����',3);
                     end else begin
                                time_list1.Timer_show_jit_word:= -80;
                                time_list1.Timer_show_jit_alpha:=0;
                                 draw_asw(game_word_1,0); //��ʾ����
                                 draw_asw('3�����ٴ���ʾ����',3);
                              end;
                 

                 end;
end;

procedure TForm_pop.ActionList1Execute(Action: TBasicAction;
  var Handled: Boolean);
  var c: string;
begin
    c:= lowercase(ShortCutToText((action as Taction).ShortCut));
    if edit1.Visible and (length(c)=1) then
     begin
       edit1.SelText:= c[1];
       Handled:= true;
     end else begin
                //��������ģʽ���ҿ�ݼ�ֵ������ȷ�𰸵�����ĸ����ôȷ�ϴ�ֵ
                 if g_tiankong then
                  begin
                   if (game_word_1<> '') and (upcase(game_word_1[1])=upcase(c[1])) then
                    begin
                     Handled:= true;
                     Action6Execute(self);
                    end;
                   if (game_word_2<> '') and (upcase(game_word_2[1])=upcase(c[1])) then
                    begin
                     Handled:= true;
                     Action7Execute(self);
                    end;
                   if (game_word_3<> '') and (upcase(game_word_3[1])=upcase(c[1])) then
                    begin
                     Handled:= true;
                     Action9Execute(self);
                    end;
                  end;
              end;
end;

procedure TForm_pop.HandleCTLColorEdit(var Msg: TWMCTLCOLOREDIT);
begin
    if Msg.ChildWnd = Edit1.Handle then
    begin
     SetBkMode(Msg.ChildDC, TRANSPARENT);
     Msg.Result := integer(Edit1.Brush.Handle);    //ǿ��ת��
    end;
end;

procedure TForm_pop.create_edit_bmp(s: string);
begin
       //��edit ������ͼ
         //edit ��ͼ edit1.Brush.Bitmap:=

{ if Assigned(game_edit1_bmp) then
      game_edit1_bmp.Free;
   //  begin

        game_edit1_bmp:= Tbitmap.Create;
        game_edit1_bmp.Width:= edit1.ClientWidth;
        game_edit1_bmp.Height:= edit1.ClientHeight;
        game_edit1_bmp.Canvas.Font.Color:= clsilver;
        game_edit1_bmp.Canvas.Font.Name:= '����';
        game_edit1_bmp.Canvas.Font.Size:= 10;
   //  end;

     game_edit1_bmp.Canvas.FillRect(rect(0,0,game_edit1_bmp.width,game_edit1_bmp.Height));

        game_edit1_bmp.Canvas.TextOut(48,6,s);

     edit1.Brush.Bitmap:= game_edit1_bmp;  }

end;

procedure TForm_pop.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    edit1.Repaint;
end;

procedure TForm_pop.set_Action_az;
var st: Tshortcut;
    i: integer;
    b: boolean;
begin
    Action_az1.ShortCut:= 0;
    Action_az2.ShortCut:= 0;
    Action_az3.ShortCut:= 0;

    if g_tiankong then
     begin

       if game_word_1<> '' then
        begin
         st:= TextToShortCut(upcase(game_word_1[1]));
         b:= false;
          for i:= 0 to ActionList1.ActionCount -1 do
              if TAction(ActionList1.Actions[i]).ShortCut= st then
                 b:= true;
          if not b then
             Action_az1.ShortCut:= st;
        end;
       if game_word_2<> '' then
          begin
         st:= TextToShortCut(upcase(game_word_2[1]));
         b:= false;
          for i:= 0 to ActionList1.ActionCount -1 do
              if TAction(ActionList1.Actions[i]).ShortCut= st then
                 b:= true;
          if not b then
             Action_az2.ShortCut:= st;
        end;
       if game_word_3<> '' then
          begin
         st:= TextToShortCut(upcase(game_word_3[1]));
         b:= false;
          for i:= 0 to ActionList1.ActionCount -1 do
              if TAction(ActionList1.Actions[i]).ShortCut= st then
                 b:= true;
          if not b then
             Action_az3.ShortCut:= st;
        end;
     end;
end;

procedure TForm_pop.Action_az1Execute(Sender: TObject);
begin
  //��̬��ݼ� �յĹ���
end;

procedure TForm_pop.Action_az2Execute(Sender: TObject);
begin
    ////��̬��ݼ� �յĹ���
end;

procedure TForm_pop.Action_az3Execute(Sender: TObject);
begin
   ////��̬��ݼ� �յĹ���
end;

procedure bubble_path_to_xy;   //���ݽǶȺ�·�����ȼ�����µ������
var hd: single;  //����
begin
   hd:= 90- abs(bubble_data1.arrow_Angle); //������Ƕ�

   if bubble_data1.start_X<= 0 then
    begin
     //�����������ǽ��
      hd:= 90- hd; //������ߺ�ĽǶ�
      hd:= hd * pi /180; //��û���
      bubble_data1.boll_top:= round(cos(hd) * bubble_data1.boll_path_length);
      bubble_data1.boll_top:= bubble_data1.start_Y- bubble_data1.boll_top;

       bubble_data1.boll_left:= round(sin(hd) * bubble_data1.boll_path_length);
       bubble_data1.boll_left:= bubble_data1.start_X + bubble_data1.boll_left;

    end else if bubble_data1.start_X>= 640 then
              begin
                //���������ұ�ǽ��
                hd:= 90- hd; //������ߺ�ĽǶ�
                hd:= hd * pi /180; //��û���
                 bubble_data1.boll_top:= round(cos(hd) * bubble_data1.boll_path_length);
                 bubble_data1.boll_top:= bubble_data1.start_Y- bubble_data1.boll_top;

                  bubble_data1.boll_left:= round(sin(hd) * bubble_data1.boll_path_length);
                  bubble_data1.boll_left:= bubble_data1.start_X - bubble_data1.boll_left;

              end else begin
                         //ԭʼԭ��
                        
                        hd:= hd * pi /180; //��û���

                         bubble_data1.boll_top:= round(sin(hd) * bubble_data1.boll_path_length);
                         bubble_data1.boll_top:= bubble_data1.start_Y- bubble_data1.boll_top;

                          bubble_data1.boll_left:= round(cos(hd) * bubble_data1.boll_path_length);
                          if bubble_data1.arrow_Angle < 0 then
                             bubble_data1.boll_left:= bubble_data1.start_X - bubble_data1.boll_left
                             else
                              bubble_data1.boll_left:= bubble_data1.start_X + bubble_data1.boll_left;
                       end;

  dec(bubble_data1.boll_top,16); //��ȥ16����Ϊ�����������
   dec(bubble_data1.boll_left,16);

end;

procedure ball_at_left_right(L: integer=16);  //���Ƿ����е���Ե���  g_boll_21_cn
//var x: integer;
begin

  // x:= (bubble_data1.boll_left+ L) div g_boll_w_cn; //����xֵ����������ż��
   if (bubble_data1.boll_left<= L) or (bubble_data1.boll_left>=(640-L*2)) then
     begin
       //����ԭ��ͳ���
       if (bubble_data1.start_X<> 0) and (bubble_data1.start_X<> 640) then
        begin
       bubble_data1.start_Y:= bubble_data1.boll_top; //ָ��ԭ��
       

       if (bubble_data1.boll_left<= L) then
       bubble_data1.start_X:= 0
       else  begin
              bubble_data1.start_X:= 640;
             // l:= l* 2;
             end;
       if l<= 0 then
         bubble_data1.start_Y:= bubble_data1.start_Y + 16;
      //��λ���ƶ�����ͷ
       bubble_data1.boll_path_length:= L; //�켣����
        end;
     end;
end;

procedure TForm_pop.show_bubble_on_scr;  //��ʾ����������Ļ
var r: Trect;
    i,j: integer;
begin
  {λ����Ϣ��������ɫ��������Ϊ��Ĳ���ʾ����͸�}
  {bubble_boll_g_array,0..3byte��3��ʾ��ɫ��������1��ʾ��2��ʾ�ߣ�0��ʾ�Ƿ���ͬɫͳ����}
  for i:= 0 to g_boll_14_cn do
    for j:= 0 to g_boll_21_cn do
     begin
      if LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0 then
        begin
          r.Left:= j * g_boll_w_cn + ((i mod 2) * g_boll_w_cn div 2);
          r.Top:= i * g_boll_h_cn;
          r.Right:= r.Left + LongRec(bubble_boll_g_array[i,j]).Bytes[1];
          r.Bottom:=r.Top + LongRec(bubble_boll_g_array[i,j]).Bytes[2];
          AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], r,$FFFFFFFF, LongRec(bubble_boll_g_array[i,j]).Bytes[3]-1, fxBlendNA);
        end;
     end;

  AsphyreCanvas1.Draw(image_bubble, 256,416, 0, fxBlend); //�������ݷ���̨
  //��������̨�ϵ�����
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], rect(271,433,303,465)
    ,$FFFFFFFF,bubble_data1.next_color, fxBlendNA); //�˴�colorû�м�ȥһ

   //��������
   AsphyreCanvas1.Line(0,390,640,390,$FF1E90DF,$FF1E90DF,fxNone);
    if (g_dangqian_zhuangtai= g_bubble)  and (bubble_data1.dot_line_count<= 0) then
     begin
       //������׼��
       bubble_data1.start_X:= 336;
       bubble_data1.start_Y:= 432; //ָ��ԭ��
       bubble_data1.boll_path_length:= 22;
       while true do
        begin
          
          bubble_path_to_xy;

          i:= (bubble_data1.boll_top+ g_boll_h_cn div 2) div g_boll_h_cn;
             if i mod 2=0 then
                j:= (bubble_data1.boll_left+ g_boll_w_cn div 2) div g_boll_w_cn
                else
                 j:= bubble_data1.boll_left div g_boll_w_cn; //������
         if boll_can_stk(i,j,bubble_data1.boll_left mod g_boll_w_cn)
           or (bubble_data1.boll_path_length> 640) then
            break; //��ͣ��ʱ�ж�

           ball_at_left_right(0); //����Ƿ����е���Ե����
          inc(bubble_data1.boll_left,16);
          inc(bubble_data1.boll_top,16);
         AsphyreCanvas1.PutPixel(bubble_data1.boll_left,bubble_data1.boll_top,$FFFFFFFF,fxnone);
         inc(bubble_data1.boll_path_length,2);
        end;
     end;

   //���������е�����
  if bubble_data1.boll_show then
   begin
      with r do
       begin
       Left:= bubble_data1.boll_left;
       Top:= bubble_data1.boll_top;
       Right:= Left + 32;
       Bottom:=Top + 32;
       end;
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], r,$FFFFFFFF, bubble_data1.boll_color -1, fxBlendNA);

   end;

  //����ָ��
  AsphyreCanvas1.DrawRot(imgae_arrow,336,432,bubble_data1.arrow_Angle * pi /180,1,$FFFFFFFF, 0, fxBlendNA);

 {image_bubble) then
     image_bubble.Free;
  if assigned(imgae_arrow}
end;

procedure TForm_pop.Action22Execute(Sender: TObject);
begin
   //left
  if g_dangqian_zhuangtai= g_bubble then
   begin
    show_text(false,'');
    if bubble_data1.arrow_Angle > -70 then
       bubble_data1.arrow_Angle:= bubble_data1.arrow_Angle-7;
   end;
end;

procedure TForm_pop.Action23Execute(Sender: TObject);
begin
    //right
   if g_dangqian_zhuangtai= g_bubble then
   begin
      show_text(false,'');
     if bubble_data1.arrow_Angle < 70 then
       bubble_data1.arrow_Angle:= bubble_data1.arrow_Angle+7;
   end;
end;


procedure TForm_pop.Action24Execute(Sender: TObject);
begin
   //up ����

  if g_dangqian_zhuangtai= g_bubble then
   begin
     if bubble_data1.dot_line_count> 0 then
       dec(bubble_data1.dot_line_count);
     g_dangqian_zhuangtai:= g_boll_move; //����������״̬
     if gamesave1.tip5= 0 then
       play_sound(1);

     dec(bubble_data1.sycs); //ʣ�෢��������ȥһ
     bubble_data1.boll_color:= bubble_data1.next_color+1; //next color������Ϊ��С���ģ�������Ҫ��һ
     bubble_data1.next_color:= Random(7); //����������
     bubble_data1.start_X:= 336;
     bubble_data1.start_Y:= 432; //ָ��ԭ��
      //��λ���ƶ�����ͷ
       bubble_data1.boll_path_length:= 48; //�켣����
       //����������
       bubble_path_to_xy;
     bubble_data1.zt:= 0; //״̬��0��ʾ���ƶ���1��ʾ����ʧ
     bubble_data1.boll_show:= true;
     time_list1.Timer_bubble:= true;
   end;
end;

procedure TForm_pop.Timer_bubbleTimer;  //���������򶯻�
         procedure boll_xuankong(y,x: integer);
          begin   //���������
           if LongRec(bubble_boll_g_array[y,x]).Bytes[0]= 3 then
              exit
              else LongRec(bubble_boll_g_array[y,x]).Bytes[0]:= 3;
           if y= 0 then  //�ж϶���
             begin
               if x= 0 then
                begin
                 if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0 then
                    boll_xuankong(y,x+1);
                 if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                    boll_xuankong(y+1,x);
                end else if x= g_boll_21_cn then
                           begin
                            if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0 then
                               boll_xuankong(y,x-1);
                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                               boll_xuankong(y+1,x-1);
                           end else begin
                                     if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0  then
                                        boll_xuankong(y,x+1);
                                     if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0  then
                                        boll_xuankong(y,x-1);
                                     if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0  then
                                        boll_xuankong(y+1,x);
                                     if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                                        boll_xuankong(y+1,x-1);
                                    end;
             end else begin //*********************************�ж��м��е���
                        if x= 0 then
                         begin
                           if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]>0 then
                              boll_xuankong(y-1,x);  //����ͬһ��
                           if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                              boll_xuankong(y+1,x);  //��ͬ
                           if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0 then
                              boll_xuankong(y,x+1);   //����
                           if y mod 2=1 then
                            begin //�����У����ж�����
                             if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]>0 then
                              boll_xuankong(y-1,x+1);  //��������
                             if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]>0 then
                              boll_xuankong(y+1,x+1);  //����
                            end;
                         end else if x= g_boll_21_cn then  //�ұߵ���
                               begin
                                  if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0 then
                                     boll_xuankong(y,x-1);   //��ǰ
                                  if y mod 2=0 then
                                  begin                //ż����
                                  if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]>0 then
                                     boll_xuankong(y-1,x-1);  //��С
                                  if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                                     boll_xuankong(y+1,x-1);  //��С
                                  end else
                                    begin //�����У�
                                    if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]>0 then
                                     boll_xuankong(y-1,x+1);  //��������
                                    if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]>0 then
                                     boll_xuankong(y+1,x+1);  //����
                                    if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]>0 then
                                     boll_xuankong(y-1,x);  //��ͬ
                                    if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                                     boll_xuankong(y+1,x);  //��ͬ
                                    end;
                               end else begin  //�м����
                                          if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]>0 then
                                             boll_xuankong(y-1,x);  //����ͬһ��
                                          if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                                             boll_xuankong(y+1,x);  //��ͬ
                                          if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0 then
                                             boll_xuankong(y,x+1);   //����
                                           if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0 then
                                             boll_xuankong(y,x-1);   //����
                                            if y mod 2= 0 then
                                             begin
                                             if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]>0 then
                                             boll_xuankong(y-1,x-1);  //��С
                                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                                             boll_xuankong(y+1,x-1);  //��С
                                             end else begin
                                            if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]>0 then
                                             boll_xuankong(y-1,x+1);  //���д�
                                            if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]>0 then
                                             boll_xuankong(y+1,x+1);  //�´�
                                                      end;
                                        end;
                      end;

          end; //procedure
         procedure boll_to_grid;
          var x,y: integer;
          begin
             //���뵽���񣬲�����Ƿ����ͣ�����Ƿ���Ҫת��
             //�����ı�Ե����4�� and С��26��Ϊ��Чλ��

            y:= (bubble_data1.boll_top+ g_boll_h_cn div 2) div g_boll_h_cn;
             if y mod 2=0 then
                x:= (bubble_data1.boll_left+ g_boll_w_cn div 2) div g_boll_w_cn
                else
                 x:= bubble_data1.boll_left div g_boll_w_cn; //������

            if boll_can_stk(y,x,bubble_data1.boll_left mod g_boll_w_cn) then
              begin
               bubble_data1.boll_show:= false;
               longrec(bubble_boll_g_array[y,x]).Bytes[3]:= bubble_data1.boll_color;
               LongRec(bubble_boll_g_array[y,x]).Bytes[1]:= 32;
               LongRec(bubble_boll_g_array[y,x]).Bytes[2]:= 32;
               bubble_data1.last_y:= y;
               bubble_data1.last_x:= x;
               if y= g_boll_14_cn then
                begin  //��Ϸ����*******************************************************************
                 show_text(true,'��Ϸ������');
                 if gamesave1.tip5= 0 then
                     play_sound(15);

                 g_dangqian_zhuangtai:= g_end;
                 inc(bubble_data1.sycs); //ʹ�ô�����һ��������ֹ���ֱ�����
                 G_game_delay(2000);
                 self.ModalResult:= mrcancel;
                end else
                     bubble_data1.zt:= 1; //�����Ƿ���ʧ���

              end else begin
                         //���Ƿ����е���Ե���  g_boll_21_cn
                         ball_at_left_right;
                       end;
          end; //end procedure
          procedure mark_boll(y,x,flag: integer); //��������򣬲������
           begin
             if LongRec(bubble_boll_g_array[bubble_data1.last_y,bubble_data1.last_x]).Bytes[3]= 0 then
                exit; //�����ʧ�������ˣ��˳�
            //�����������6��λ��
            if LongRec(bubble_boll_g_array[y,x]).Bytes[0]= flag then
              exit
              else
                LongRec(bubble_boll_g_array[y,x]).Bytes[0]:= flag;
            if y= 0 then  //�ж϶��У�����������һ����������䣬����������һ�в�������
             begin
               if x= 0 then
                begin
                 if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                    mark_boll(y,x+1,flag);
                 if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                    mark_boll(y+1,x,flag);
                end else if x= g_boll_21_cn then
                           begin
                            if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                               mark_boll(y,x-1,flag);
                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                               mark_boll(y+1,x-1,flag);
                           end else begin
                                     if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y,x+1,flag);
                                     if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y,x-1,flag);
                                     if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y+1,x,flag);
                                     if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y+1,x-1,flag);
                                    end;
             end else begin //*********************************�ж��м��е���
                        if x= 0 then
                         begin
                           if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y-1,x,flag);  //����ͬһ��
                           if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y+1,x,flag);  //��ͬ
                           if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y,x+1,flag);   //����
                           if y mod 2=1 then
                            begin //�����У����ж�����
                             if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y-1,x+1,flag);  //��������
                             if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y+1,x+1,flag);  //����
                            end;
                         end else if x= g_boll_21_cn then  //�ұߵ���
                               begin
                                  if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y,x-1,flag);   //��ǰ
                                  if y mod 2=0 then
                                  begin                //ż����
                                  if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y-1,x-1,flag);  //��С
                                  if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y+1,x-1,flag);  //��С
                                  end else
                                    begin //�����У�
                                    if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y-1,x+1,flag);  //��������
                                    if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y+1,x+1,flag);  //����
                                    if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y-1,x,flag);  //��ͬ
                                    if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y+1,x,flag);  //��ͬ
                                    end;
                               end else begin  //�м����
                                          if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y-1,x,flag);  //����ͬһ��
                                          if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y+1,x,flag);  //��ͬ
                                          if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y,x+1,flag);   //����
                                           if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y,x-1,flag);   //����
                                            if y mod 2= 0 then
                                             begin
                                             if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y-1,x-1,flag);  //��С
                                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y+1,x-1,flag);  //��С
                                             end else begin
                                            if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y-1,x+1,flag);  //���д�
                                            if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y+1,x+1,flag);  //�´�
                                                      end;
                                        end;
                      end;
           end; //procedure
          function boll_clear: boolean;  //����Ƿ��л��е���
           var i,j,k: integer;
           begin
             //������򱻻��У�������ʧ״̬
             result:= false; //����Ѿ����������ڱ�С״̬����Ϊtrue
             for i:= 0 to g_boll_14_cn do
              begin
                for j:= 0 to g_boll_21_cn do
                    if LongRec(bubble_boll_g_array[i,j]).Bytes[0]=1 then
                      begin
                        result:= true;
                        if LongRec(bubble_boll_g_array[i,j]).Bytes[1]> 0 then
                          begin
                           LongRec(bubble_boll_g_array[i,j]).Bytes[1]:= LongRec(bubble_boll_g_array[i,j]).Bytes[1]-1;
                           LongRec(bubble_boll_g_array[i,j]).Bytes[2]:= LongRec(bubble_boll_g_array[i,j]).Bytes[2]-1;
                          end else begin
                                    LongRec(bubble_boll_g_array[i,j]).Bytes[3]:= 0; //��ɫȡ��
                                    LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 0;
                                    end;
                      end;
              end; //i

              if result= false then
               begin
                  k:= 0;
                 for i:= 0 to g_boll_14_cn do
                   for j:= 0 to g_boll_21_cn do
                        if LongRec(bubble_boll_g_array[i,j]).Bytes[3]>0 then
                             inc(k);
                 game_pop_count:= k; //ʣ�µ��������
                 if k= 0 then
                  begin
                   //��Ϸʤ�� *********************************************************
                     if gamesave1.tip5= 0 then
                     play_sound(14);

                   if Random(2)= 0 then
                    begin
                    k:= Random(9009)+ 2000;
                    show_text(true,'ʤ������������Ǯ '+inttostr(k));
                    form1.game_attribute_change(1,0,k);
                    end else begin
                            k:= Random(4009)+ 500;
                            show_text(true,'ʤ����ȫ��Ӿ���ֵ '+inttostr(k));
                            form1.game_attribute_change(0,19,k);
                         end;
                    g_dangqian_zhuangtai:= g_end;
                    inc(bubble_data1.sycs); //������һ��������ֹ���뱳���ʽ���
                    //���轱��

                   result:= true;
                   G_game_delay(3000);
                   self.ModalResult:= mrok;
                   exit;
                  end;
                 //���û��������ʧ�е�����ô����Ƿ�����ɹ���С��ʧ
                 //���ȸ������һ����ӵ������ݹ����Ƿ�3�����������������ɫΪ�㣬��ôɨ���Ƿ������յ���
                 mark_boll(bubble_data1.last_y,bubble_data1.last_x,2); //Ԥ�����
                 //ͳ��Ԥ��������������Ԥ���
                 k:= 0;
                 for i:= 0 to g_boll_14_cn do
                   for j:= 0 to g_boll_21_cn do
                        if LongRec(bubble_boll_g_array[i,j]).Bytes[0]=2 then
                           begin
                             inc(k);
                             LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 0; //������ʧ�е���ı��
                           end;

                 //������ڵ���3������ʽ���һ�£����򣬼���Ƿ������յ���
                 if k>= 3 then
                  begin
                  if gamesave1.tip5= 0 then
                     play_sound(4);
                   mark_boll(bubble_data1.last_y,bubble_data1.last_x,1); //��ʽ������С����
                   //�Ӿ���ֵ���������***********************************************************

                   case Random(12) of
                   0: begin
                        inc(bubble_data1.sycs);
                        show_text(false,'���������ݻ���һ��');
                      end;
                   1: begin
                       form1.game_attribute_change(1,0,30); //ȫ�����Ӿ���ֵ5
                       show_text(false,'���ӽ�Ǯ30');
                      end;
                   2: begin
                       inc(bubble_data1.sycs,2);
                        show_text(false,'���������ݻ���2��');
                      end;
                   3: begin
                       inc(bubble_data1.sycs,k);
                        show_text(false,'���������ݻ���'+inttostr(k)+'��');
                      end;
                   4: begin
                       inc(bubble_data1.sycs,3);
                        show_text(false,'���������ݻ���3��');
                      end;
                   5: begin
                       inc(bubble_data1.dot_line_count,2);
                        show_text(false,'�۵���׼�� 2��');
                      end;
                   6: begin
                       inc(bubble_data1.dot_line_count,3);
                        show_text(false,'�۵���׼�� 3��');
                      end;
                   7: begin
                       inc(bubble_data1.dot_line_count,1);
                        show_text(false,'�۵���׼�� 1��');
                      end;
                   8: begin
                       form1.game_attribute_change(0,19,-50); //ȫ�����Ӿ���ֵ5
                      show_text(false,'���۾���ֵ50');
                      end;
                    else
                      form1.game_attribute_change(0,19,30); //ȫ�����Ӿ���ֵ5
                      show_text(false,'ȫ�����Ӿ���ֵ30');
                    end;
                   
                   result:= true;
                  end else begin
                             //����Ƿ���������ֻ�����һ������ʧʱ�����˼��
                             k:= 0;
                             if LongRec(bubble_boll_g_array[bubble_data1.last_y,bubble_data1.last_x]).Bytes[3]= 0 then
                                begin
                                  for i:= 0 to g_boll_21_cn do
                                     if LongRec(bubble_boll_g_array[0,i]).Bytes[3]> 0 then
                                        boll_xuankong(0,i); //������������Ϊ 3

                                  for i:= 0 to g_boll_14_cn do
                                      for j:= 0 to g_boll_21_cn do
                                         if LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0 then
                                          if  LongRec(bubble_boll_g_array[i,j]).Bytes[0]= 3 then
                                              LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 0
                                              else begin
                                                   inc(k);
                                                   LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 1; //����������Ϊ��ʧ
                                                   result:= true;
                                                   end;
                                 if result then
                                  begin
                                    if (gamesave1.tip5= 0) then
                                        play_sound(4); //��������
                                    form1.game_attribute_change(0,19,k* k); //��������ʧ��ȫ�����Ӿ���ֵ5
                                    show_text(false,'ȫ�����Ӿ���ֵ'+ inttostr(k*k));
                                  end;
                                end;
                           end;
               end;
           end;
begin
    //���㲢������Ĺ켣
    //��������ͣ��λ��ʱ�����㲢������ʧ�����µ���
    if g_dangqian_zhuangtai<> g_boll_move then
      begin
       time_list1.Timer_bubble:= false;
       exit;
      end;

    if bubble_data1.zt= 0 then
     begin
      //״̬��0��ʾ���ƶ�
      inc(bubble_data1.boll_path_length,4);
       bubble_path_to_xy; //����������

      //����������⣬������Ƿ����ͣ�������ͣ������ô���ü���Ƿ������ʧ
       boll_to_grid;
     end else if bubble_data1.zt= 1 then  //��ʧ����־
                begin
                  //״̬��1��ʾ������Ƿ����ʧ
                    if boll_clear= false then
                     begin  //û�л��е���ɹ���ʧ
                     time_list1.Timer_bubble:= false;
                     if bubble_data1.sycs > 0 then
                        g_dangqian_zhuangtai:= g_bubble //���µ���Ϊ����
                        else
                        start_show_word(false);  //���µ���Ϊ������
                     end;
                end;


  
end;

procedure TForm_pop.Action25Execute(Sender: TObject);
begin
   game_bg_music_rc_g.type_word:= not game_bg_music_rc_g.type_word;
   if edit1.Visible then
      start_show_word(false);
end;

procedure TForm_pop.wuziqi_msg(var Msg: TMessage);  //����������������Ϣ
var x,y,i: integer;
    b: boolean;
begin
 if msg.LParam <> 999 then
    exit;

   case msg.WParam of
   0: begin
       //���治����
        messagebox(handle,'�������治���ڡ�','����',mb_ok);
        close;
       end;
   1: begin
       //�ܵ�����ʧ��
        messagebox(handle,'����������ͨѶ�Ĺܵ�����ʧ�ܡ�','����',mb_ok);
        close;
       end;
   2: begin//��������ʧ��
        messagebox(handle,'������������ʧ�ܡ�','����',mb_ok);
        close;
      end;
   3: begin//�����ݿ��Զ�ȡ��
      // if wuziqi_flag= 2 then
      // begin
       //EnterCriticalSection(wuziqi_CriticalSection);
       //wuziqi_flag:= 3; //���ݶ�ȡ��
         // wuziqi_receive
         
         statusbar1.Panels[0].Text:= wuziqi_receive;
         if not (wuziqi_receive[0] in['0'..'9']) then
           begin
                  b:= false;
                  while true do
                   begin
                   for i:= 1 to wuziqi_char_count_cn do
                    if wuziqi_receive[i-1]=#0 then
                     break
                     else
                       wuziqi_receive[i-1]:= wuziqi_receive[i];
                    if b then
                      break;
                    if wuziqi_receive[0]= #10 then
                       b:= true;
                   end;
                 if wuziqi_receive[0]= #0 then
                    exit;

           end;

             if not (wuziqi_receive[0]in['0'..'9']) then
                    exit;
                    
             b:= false;
             x:= 0;
             y:= 0;
             for i:= 0 to wuziqi_char_count_cn do
              begin
                if not (wuziqi_receive[i] in['0'..'9']) then
                   b:= true
                   else
                if b then
                  y:= y * 10 + strtoint(wuziqi_receive[i])
                  else
                   x:= x * 10 + strtoint(wuziqi_receive[i]);
              end;
             LongRec(bubble_boll_g_array[y,x]).Bytes[3]:= g_ball_color_cpt;
             if wuziqi_result=1 then //��������������0��ʾ������1��ʾʧ�ܣ�2��ʾʤ����3��ʾ����
             begin
              g_tiankong:=true; //��ֹ������ʾ
               draw_asw('�����ˡ�',0,0);
               wuziqi_rec1.word_showing:= true;
              G_game_delay(2000);
              wuziqi_rec1.cpt_win:= true;
               postmessage(handle,wuziqi_msg_c,4,999);
             end
             else begin
                     g_dangqian_zhuangtai:= g_wuziqi1;
                   if wuziqi_rec1.me_count > 4 then
                    begin
                     wuziqi_rec1.word_time:= 128;
                     //ˢ�µ���
                     show_a_word_on_wzq;
                     wuziqi_rec1.word_showing:= true;
                    end;

                  end;
             inc(wuziqi_rec1.cpt_count);
             wuziqi_rec1.cpt_row:= y;
             wuziqi_rec1.cpt_col:= X;
             wuziqi_rec1.row:= y;
             wuziqi_rec1.col:= X;
      // wuziqi_flag:= 4; //���ݶ�ȡ���
      // LeaveCriticalSection(wuziqi_CriticalSection);
      // end;
      end;
    4: begin
        self.ModalResult:= mrcancel;
       end;
   end;
end;

procedure TForm_pop.wuziqi_sendstr(s: string); //��������������
var i: integer;
begin
    s:= s + #13#10;
    EnterCriticalSection(wuziqi_CriticalSection);
               wuziqi_flag:= 5; //����������д����
                 fillchar(wuziqi_send, sizeof(wuziqi_send), #0);
                 i:= length(s);
                 move(pchar(s)^,wuziqi_send,i);
                 byte(wuziqi_send[wuziqi_char_count_cn]):= lo(i);
               //wuziqi_send

               wuziqi_flag:= 6; //����������д�����
    LeaveCriticalSection(wuziqi_CriticalSection);
end;
procedure quad_wuziqi(tp: Tpoint;L: integer; C: dword);
var C4: Tcolor4;
    T4: Tpoint4;
begin
    //��������
   T4[0].x:= tp.X- L;
   T4[0].y:= tp.y- L;
    T4[1].x:= tp.X+ L;
   T4[1].y:= tp.y- L;
    T4[2].x:= tp.X+ L;
   T4[2].y:= tp.y+ L;
    T4[3].x:= tp.X- L;
   T4[3].y:= tp.y+ L;

   C4[0]:= C;
   C4[1]:= C;
   C4[2]:= C;
   C4[3]:= C;
   Form_pop.AsphyreCanvas1.Quad(T4,C4,fxnone);
end;

procedure quad_wuziqi2(tp: Tpoint;L: integer; C: dword);
begin
    //����ʮ��

   Form_pop.AsphyreCanvas1.Line(tp.x-L,tp.y,tp.x+L,tp.y,c,c,fxnone);
   Form_pop.AsphyreCanvas1.Line(tp.x,tp.y-L,tp.x,tp.y+L,c,c,fxnone);
end;

procedure TForm_pop.show_wuziqi_on_src; //��ʾ�����嵽��Ļ
 const w=32;
var r: Trect;
    i,j: integer;
    t: tpoint;
begin
  {λ����Ϣ��������ɫ��������Ϊ��Ĳ���ʾ����͸�}
  {bubble_boll_g_array,0..3byte��3��ʾ��ɫ��������1��ʾ��2��ʾ�ߣ�0��ʾ�Ƿ���ͬɫͳ����}
  for i:= 0 to 14 do
    for j:= 0 to 14 do
     begin
      if LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0 then
        begin
          r.Left:= j * w + w+ 20;
          r.Top:= i * w;
          r.Right:= r.Left + 32;
          r.Bottom:=r.Top + 32;
          AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], r,$FFFFFFFF, LongRec(bubble_boll_g_array[i,j]).Bytes[3]-1, fxBlend);
          //�������������µ��ӣ���ô��ʮ����ȥ
          if (i= wuziqi_rec1.row) and (j= wuziqi_rec1.col) then
             begin
             t.X:= r.Left+16;
             t.Y:= r.Top+16;
             quad_wuziqi2(t,5, $FF1E90DF);
             end;
        end;
     end;


       //�����ұߵ���������
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'],576,90 ,$FFFFFFFF, 0, fxBlend);
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'],576,314,$FFFFFFFF, 2, fxBlend);
     //��������
     AsphyreFonts1[0].TextOut(inttostr(wuziqi_rec1.cpt_count),576,154,$FFD08080, $FFD08080,fxBlend);
     AsphyreFonts1[0].TextOut(inttostr(wuziqi_rec1.me_count),576,376,$FFD08080, $FFD08080,fxBlend);
     if wuziqi_rec1.xy0 then
       form_pop.AsphyreCanvas1.Line(wuziqi_rec1.x0
                                   ,wuziqi_rec1.y0,wuziqi_rec1.x1,wuziqi_rec1.y1,$FFFFFFFF,$FFFFFFFF, fxnone);

     if wuziqi_rec1.word_showing then  //��ʾ����
       begin
       r.Left:= wuziqi_rec1.cpt_col * w + 52;
       r.Top:= wuziqi_rec1.cpt_row * w;
       r.Right:= r.Left + game_bmp_width;
       r.Bottom:=r.Top + game_bmp_h1;
       AsphyreCanvas1.DrawEx(image_word,r,$AAFFFFFF,0, fxBlend);
       end;

     //���������ӵ��С���Σ��ù���λ�����
    if g_dangqian_zhuangtai= g_wuziqi1 then
     begin
       //���λ��ת��Ϊ��������õ�û�����ӣ���ô��һ��������ȥ
       GetCursorPos(T);
       t:= panel1.ScreenToClient(t);
       if (t.X< 52) or (t.X> 531) or (t.Y< 0) or (t.Y>479) then
         exit;
       if LongRec(bubble_boll_g_array[t.Y div w,(t.X-52) div w]).Bytes[3]= 0 then
         begin
          if (t.Y mod w in[8..24]) and ((t.X-52) mod w in[8..24]) then
           begin
             t.Y:= t.Y div w * w+16;
             t.X:=(t.X-52) div w * w+ 68;
             quad_wuziqi(t,8, $FFFFFFFF);
           end;
         end;

     end;

   
end;

procedure TForm_pop.show_a_word_on_wzq;
var ss,ss2: string;
    i: integer;
begin
    //��������ʱ��ʾһ������
  ss:= get_word_safe(get_Word_id); //ȡ�õ��ʱ�ţ�����д����ظ�ѡ����ȡ�ش��󵥴ʱ��
  ss2:= copy(ss,1,pos('=',ss)-1);

     if (ss2<> '') and (checkbox2.checked) then
        skp_string(ss2);
    if Assigned(form_chinese) and G_can_chinese_tts then
       begin
        ss2:= copy(ss,pos('=',ss)+1,255);
        if length(ss2)> 8 then
         begin
           i:= pos(' ',ss2);
           if i= 0 then
              i:= pos('��',ss2);
           if i> 0 then
             ss2:= copy(ss2,1,i-1);
         end;
        if ss2<> '' then
           form_chinese.cn_string:=ss2;
       end;
    g_tiankong:=true; //��ֹ������ʾ
    ss:= StringReplace(ss,'=',' ',[]);
    draw_asw(ss,0,0);
end;

procedure TForm_pop.show_ad(add_i: integer);  //ˢ�¹��
begin
{  if (Game_ad_count_G.X<> 1) or (Game_ad_count_G.Y < 10)then
   begin
    inc(jit_num);
     if jit_num mod 15 = 0 then
      begin
       if game_bg_music_rc_g.show_ad_web then
        form1.game_page(0)
        else begin
               //�ڱ����ڶ�����ʾ���
              // WebBrowser1.Navigate('http://www.finer2.com/wordgame/jiqiao'+inttostr(Random(20)+1)+'.htm');
             end;
      end;
   end;
       }
end;

procedure TForm_pop.create_top_ad; //����һ����ҳ���С����
 const h= 100;
begin
 {  self.Height:= self.Height + h;
   checkbox2.Top:= checkbox2.Top + h;
   checkbox3.Top:= checkbox3.Top + h;
   checkbox8.Top:= checkbox8.Top + h;
   button11.Top:= button11.Top + h;
   label1.Top:= label1.Top + h;
   combobox1.Top:= combobox1.Top + h;
   panel1.Top:= panel1.Top+ h;
   groupbox3.Top:= groupbox3.Top + h;
    
    label3.Top:= label2.Top + h;
    label4.Top:= label2.Top + h;
    label5.Top:= label2.Top + h;
    label6.Top:= label2.Top + h;
    label7.Top:= label2.Top + h;
    label8.Top:= label2.Top + h;
    label9.Top:= label2.Top + h;
    label10.Top:= label2.Top + h;
    label11.Top:= label2.Top + h;
    label2.Top:= label2.Top + h;
    WebBrowser1:= TWebBrowser.Create(application);
    WebBrowser1.ParentWindow:= self.Handle;
    WebBrowser1.Left:= 0;
    WebBrowser1.Top:= 0;
    WebBrowser1.Height:= h;
    WebBrowser1.Width:= 700;

    WebBrowser1.Navigate('http://www.finer2.com/wordgame/game.htm');   }
end;

procedure TForm_pop.SpVoice1EndStream(Sender: TObject;
  StreamNumber: Integer; StreamPosition: OleVariant);
begin
   postmessage(form_chinese.handle,msg_langdu_huancong,1022,0);
end;

procedure TForm_pop.N15Click(Sender: TObject);
begin
    del_a_word;
end;

procedure TForm_pop.N17Click(Sender: TObject);
begin
      //�����µ���
      edit2.Text:= '';
      edit3.Text:= '';
   groupbox1.Caption:= '����µ���';
    groupbox1.Visible:= true;
end;

procedure TForm_pop.N16Click(Sender: TObject);
begin
     //�޸ĵ�ǰ����
   if G_word = g_dangqian_zhuangtai then
  begin
     edit2.Text:= Jit_words;
     edit3.Text:= game_word_1;
    groupbox1.Caption:= '�༭����';
    groupbox1.Visible:= true;
  end
  else messagebox(handle,'��ǰ����ʾ�ĵ��ʡ�','���ܱ༭',mb_ok);
end;

procedure TForm_pop.Button13Click(Sender: TObject);
begin
 groupbox1.Visible:= false;
end;

procedure TForm_pop.Button14Click(Sender: TObject);
begin
 button14.Tag:= 1;
    if game_pop_type=3 then
    begin
    // game_fight_result:= 2;  ����ʱ�Զ�Ϊ2
     game_fight_result_adv; //�жϽ��
    end else self.ModalResult:= mrok;

end;

procedure TForm_pop.Button12Click(Sender: TObject);
begin
     //ȷ����������޸�
     if (edit2.Text= '') or (edit3.Text= '') then
        begin
          messagebox(handle,'����д���ʺ����Ľ��͡�','���',mb_ok);
          exit;
        end;
screen.Cursor:= crhourglass;
    if groupbox1.Caption= '����µ���' then
     begin
      if messagebox(handle,'ȷ����ӵ�ǰ���ʣ�','���',mb_yesno) = mryes then
                 begin
                  if wordlist1.Values[edit2.Text]<>'' then
                   if messagebox(handle,'�õ����Ѿ����ڣ��Ƿ񸲸ǣ�','����',mb_yesno) = mryes then
                       wordlist1.Values[edit2.Text]:= edit3.Text;
                 end;

     end else begin
                if messagebox(handle,'ȷ���༭��ǰ���ʣ�','�༭',mb_yesno) = mryes then
                 begin
                   wordlist1.Values[edit2.Text]:= edit3.Text;
                 end;
              end;
screen.Cursor:= crdefault;
end;

procedure TForm_pop.N14Click(Sender: TObject);
begin
    //�༭��ǰ�ʿ�
    ShellExecute(handle,'open',pchar(game_app_path_G+'lib\'+ combobox1.Text),nil,nil,sw_shownormal);
end;

function TForm_pop.get_word_safe(i: integer): string;
begin
   if (i>= wordlist1.Count) or (i<0) then
    result:= wordlist1.Strings[Random(wordlist1.Count)]
   else
    result:= wordlist1.Strings[i];
end;

end.

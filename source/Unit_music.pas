unit Unit_music;

interface

uses
  Classes,windows,SysUtils,unit_lrc;
const
  music_msg_c= $0400 + $6113;

type
  tr_music = class(TThread)
  private
    { Private declarations }
    lrc: TLyric;
    tim: dword;
    tongbu: integer;
  protected
    procedure Execute; override;
    procedure show_index;
  end;

implementation
    uses bass,unit_data,basswma,unit_set;
{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure tr_music.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ tr_music }

procedure tr_music.Execute;
var strs: HSTREAM;
    ss: string;
    k: integer;
    act: DWORD;
    msg: TMSG;
    label pp,qq,tt;
begin
  { Place thread code here }
    if not BASS_Init(-1, 44100, 0, form_set.Handle, nil) then
      exit;

      k:= 0; //���������ڵ��ļ�

        pp:
       if bg_music_filelist_g.Count> 0 then
       begin
        if game_bg_music_rc_g.bg_music_radm then
           begin
           game_bg_music_rc_g.bg_music_index:= Random(bg_music_filelist_g.Count);
           qq:
           ss:= bg_music_filelist_g.Strings[game_bg_music_rc_g.bg_music_index];
           end else begin
                     if game_bg_music_rc_g.bg_music_index >= bg_music_filelist_g.count then
                        game_bg_music_rc_g.bg_music_index:= 0;

                     if bg_music_filelist_g.count= 0 then
                        begin
                         game_bg_music_rc_g.bg_music:= false;
                         goto pp;
                        end;
                     ss:= bg_music_filelist_g.Strings[game_bg_music_rc_g.bg_music_index];
                     inc(game_bg_music_rc_g.bg_music_index);
                    end;

         //ȡ��ͬ����Ϣ
         if (ss<> '') and (ss[1]='[') then
            begin
              if not TryStrToInt(copy(ss,2,pos(']',ss)-2),tongbu) then
                 tongbu:= 0;

             delete(ss,1,pos(']',ss));
            end;

          if not FileExists(ss) then //�ļ�������
           begin
             inc(k);
             if k>= 20 then
                game_bg_music_rc_g.bg_music:= false
                else goto pp;
           end;

        strs:= BASS_StreamCreateFile(False, pchar(ss), 0, 0, 0);
         if strs= 0 then
            strs:= BASS_WMA_StreamCreateFile(False, pchar(ss), 0, 0, 0);

          if strs<> 0 then
            begin
             synchronize(show_index);
              BASS_SetConfig(BASS_CONFIG_GVOL_STREAM,game_bg_music_rc_g.bg_yl * 100); //�趨����
             BASS_ChannelPlay(strs, False);

               tim:= 0;

              ss:= copy(ss,1,length(ss)-3)+'lrc';
             if FileExists(ss) then
               begin //��ʾ���
                 tt:
                 if not Assigned(lrc)then
                     lrc:= TLyric.Create;
                 lrc.loadLyric(ss);
                tim:= GetTickCount;
               end else if game_bg_music_rc_g.lrc_dir<> '' then
                          begin  //���lrc-dir·�����ڣ���ô������·��
                            ss:= game_bg_music_rc_g.lrc_dir + ExtractFileName(ss);
                            if FileExists(ss) then
                               goto tt;
                          end;

             act := BASS_ChannelIsActive(strs);
             if act= 0 then
              begin
               act:=  BASS_ErrorGetCode;
               messagebox(0,pchar('���ű�������ʱ�����˴��������ԡ�����ţ�'+ inttostr(act)),'����',mb_ok);
               game_bg_music_rc_g.bg_music:= false;
              end;
             while game_bg_music_rc_g.bg_music and (act > 0) do
               begin
                //������Ϣ
                if PeekMessage(msg, 0, 0, 0, PM_REMOVE) then
                begin
                 if msg.message= music_msg_c then
                  begin
                     case msg.wParam of
                     1: begin
                         //�޸�����
                         if msg.lParam= 888 then
                         BASS_SetConfig(BASS_CONFIG_GVOL_STREAM,game_bg_music_rc_g.bg_yl * 100); //�趨����
                        end;
                     2: begin
                         //���û���
                         if msg.lParam= 888 then
                         BASS_ChannelSetFX(strs,BASS_FX_DX8_ECHO,0);
                        end;
                     3: begin
                         //�������
                         if msg.lParam= 888 then
                         BASS_ChannelRemoveFX(strs,BASS_FX_DX8_ECHO);
                        end;
                     4: begin
                         //������һ��
                         if msg.lParam= 888 then
                         begin
                          BASS_ChannelStop(strs);
                          BASS_StreamFree(strs);
                          goto pp;
                         end;
                        end;
                      5: begin
                            //����ָ���ĸ�
                          if msg.lParam= 888 then
                             begin
                              BASS_ChannelStop(strs);
                               BASS_StreamFree(strs);
                              goto qq;
                             end;
                         end;
                      6: begin
                          //����ͬ��
                           if msg.lParam<= 20 then
                             begin
                              tongbu:= (msg.lParam -10) * 1000;
                              ss:= bg_music_filelist_g.Strings[game_bg_music_rc_g.bg_music_index];
                              if ss[1]= '[' then
                                 delete(ss,1,pos(']',ss));

                                 ss:= '['+ inttostr(tongbu)+ ']'+ ss;
                                 bg_music_filelist_g.Strings[game_bg_music_rc_g.bg_music_index]:= ss;

                             end;
                         end; //end 6
                     end;

                  end;
                 end;

                 if (tim> 0) and (game_bg_music_rc_g.bg_lrc=false) then
                 lrc.get_lrc_string(integer(GetTickCount -tim) + tongbu);

                sleep(25);
                act := BASS_ChannelIsActive(strs);
               end; //end while

               if game_bg_music_rc_g.bg_music then
                  begin
                    BASS_ChannelStop(strs);
                    BASS_StreamFree(strs);
                    goto pp;
                  end;
            end else begin
                      act:=  BASS_ErrorGetCode;
                       messagebox(0,pchar('���ű�������ʱ�����˴��������ԡ�����ţ�'+ inttostr(act)),'����',mb_ok);
                       game_bg_music_rc_g.bg_music:= false;
                       inc(k);
                       if k< 20 then
                        goto pp;
                     end;

         BASS_ChannelStop(strs);
        BASS_StreamFree(strs);
       end;

      if Assigned(lrc)then
         lrc.Free;
      BASS_Free(); //�ͷ�bass ��
end;

procedure tr_music.show_index;
begin
   form_set.listbox2.ItemIndex:=  game_bg_music_rc_g.bg_music_index;
   form_set.TrackBar3.Position:= 10;
end;

end.

unit unit_lrc;

interface 
 uses Classes,SysUtils,Graphics,windows,forms;

type 
 TOneLyric=Record
   time:longint; 
   lyStr:string[200];
 end; 

 TLyric=class 
 private 
   FFilename:string;
   findex: integer; //��ǰ���λ��
   FOffset:integer; //ʱ�䲹��ֵ �䵥λ�Ǻ��룬��ֵ��ʾ������ǰ����ֵ�෴�������������������ʾ�����ġ�
   FAur:string; //������ 
   FBy:string; //���ߣ�ָ�༭LRC��ʵ��ˣ� 
   FAl:string; //ר���� 
   FTi:string; //����
   FCount:integer; 

   FLyricArray : array of TOneLyric;
   function GetLyric(i:integer): TOneLyric ;
   function ExistTime(vTime:longint):boolean; 

   procedure sortLyric; 
   procedure ResetLyrics(FTxt:Tstrings); 
 protected 
 public 
   constructor Create; 
   destructor Destroy; override; 
   procedure loadLyric(afilename:string); 
   procedure SetTxt(aLyrics:Tstrings); 
   procedure UnloadLyric(strs:Tstrings); 

   //������ǰ(��ֵ)�������Ӻ�(��ֵ)atime���� 
   function ChgOffset(atime:integer):boolean; 

   //��ǰ(��ֵ)/�Ӻ�(��ֵ)ĳһ���� aTime���� 
   function ChgOneLyric(oldTime:longint;aTime:integer):boolean; 

   //���������ݵ��ļ� 
   function SaveLyricsToFile(vFileName:string):boolean; 
   function get_lrc_string(t: integer): boolean;
   property filename:string read ffilename; 
   property Ar:string read FAur; 
   property By:string read FBy; 
   property Al:string read FAl; 
   property Ti:string read FTi; 
   property Offset :integer read FOffset; 

   property LyricArray[i:integer]: TOneLyric read GetLyric ;

   property Count:integer read FCount; 
 end; 

implementation 


constructor TLyric.Create; 
begin 
 inherited Create; 
 FTi:='';
 FAur:='';
 Fal:='';
 FBy:='';
 FOffset:=0; 
end; 

function TLyric.ExistTime(vTime:longint):boolean; 
var i:integer; 
begin 
 result:=false; 
 for i:=0 to length(FLyricArray) -1 do 
   if  FLyricArray[i].time =vTime then 
   begin 
       result:=true; 
       break; 
   end; 
end; 

procedure TLyric.loadLyric(afilename:string); 
var 
 FTxt:Tstrings; 
begin 
 FTi:='';
 FAur:='';
 Fal:='';
 FBy:='';
 FOffset:=0; 

 FFilename:=afilename; 
 //������ 

 FTxt:=TStringlist.create; 
 FTxt.LoadFromFile(Ffilename); 

 ResetLyrics(FTxt);

 FTxt.Clear; 
 FTxt.free;
 findex:= -1;

end; 

procedure TLyric.SetTxt(aLyrics:Tstrings); 
begin 
 FTi:='';
 FAur:='';
 Fal:='';
 FBy:='';
 FOffset:=0; 

 //������ 
 ResetLyrics(aLyrics); 
end; 

//���ݸ���ļ�  ����ÿ�и�� 
procedure TLyric.ResetLyrics(FTxt:Tstrings); 
var i:integer; 
 function makeOneLyric(CurLyric:string):string; 
 var p1,p2,p3:integer; 
    timestr,lyricstr:string; 
    time1,time2:longint; 

    isFuSign:boolean; 
 begin 
   p1:=pos('[',CurLyric);//��һ����[��λ�� 
   if p1=0 then begin   //�ж��Ƿ�Ƿ��� 
     result:= CurLyric;          //�� '[' 
     exit; 
   end; 
   p2:=pos(']',CurLyric); //��һ����]��λ�� 
   if p2=0 then begin 
     result:= CurLyric; 
     exit;          //�� ']' 
   end; 

   timestr:=copy(curLyric,p1+1,p2-p1-1); 
   //��������Ϊ��� 
   lyricStr:= copy(curLyric,1,p1-1) + copy(curLyric,p2+1,length(curLyric)-p2) ; 

   lyricStr:=makeOneLyric(lyricStr); 

   if copy(Lowercase(timeStr),1,2)='ar' then  //������Ϣ 
      FAur:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,2)='ti' then  //��Ŀ���� 
      FTi:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,2)='al' then  //ר���� 
      FAl:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,2)='by' then  //�༭LRC��ʵ��� 
      FBy:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,6)='offset' then  //ʱ�䲹��ֵ 
     try 
       FOffset:= strtoint(copy(timestr,8,length(timestr)-7)) 
     except 
       FOffset:=0; 
     end 
   else   //��ʱΪ ʱ���� 
   begin 
      p3:= pos(':',timestr) ; 
      if p3>0 then begin //�ж��Ƿ�Ƿ��� 
         isFuSign:=false; 
        try 
         time1:=strtoint(copy(timestr,1,p3-1))*1000; 
         if time1<0 then 
         isFuSign:=true;  //��¼ �� ʱ���ǩ Ϊ ����С���㣩 
        except 
         //�Ƿ������ 
         exit;          //�������� 
        end; 

        try 
         time2:= trunc( strtofloat(copy(timestr,p3+1,length(timestr)-p3)) *1000); 
         if isFuSign then 
         time2:=-time2; 
        except 
         exit;          //�� ���� 
        end; 

        if not ExistTime(time1*60+time2) then 
        begin 
         setLength(FLyricArray,length(FLyricArray)+1); 
         //if trim(lyricStr)=' then 
         //  lyricStr:= '(Music)'; 
         with FLyricArray[length(FLyricArray)-1] do 
         begin 
         time :=time1*60+time2; 
         lystr:=lyricStr; 
         end; 
         result:=lyricStr; 
        end; 
      end; 
   end; 

 end; 
begin 
 SetLength(FLyricArray,0);

 //������ʸ����� 
 for i:= 0 to FTxt.count-1 do 
 begin 
     makeOneLyric(FTxt[i]) ; 
 end; 

 FCount:=length(FLyricArray) ; 
 sortLyric;

 {if FTi<>' then FTi:= replaceWithchr(FTi,'&','&&'); 
 if FAur<>' then FAur:= replaceWithchr(FAur,'&','&&'); 
 if FAl<>' then FAl:= replaceWithchr(FAl,'&','&&'); 
 if FBy<>' then FBy:= replaceWithchr(FBy,'&','&&'); 
 } 
 //���� ����ʱ��ƫ�ƣ����¼���ÿ����ʱ�� 
   for i:=0 to length(FLyricArray)-1 do 
   begin 
      //FLyricArray[i].lyStr := replaceWithchr(FLyricArray[i].lyStr,'&','&&'); 

      if FLyricArray[i].time >= 0 then 
        begin 
         if FLyricArray[i].time - FOffset>=0 then 
         FLyricArray[i].time:=FLyricArray[i].time - FOffset ; 

        end 
      else 
        FLyricArray[i].time:=0; 
   end; 
end; 

procedure TLyric.UnloadLyric(strs:Tstrings); 
var i:integer; 
begin 
  SetLength(FLyricArray,strs.Count ); 
  FCount:= strs.Count; 
  for i:=0 to strs.Count -1 do 
  begin 
     FLyricArray[i].time :=0; 
     FLyricArray[i].lyStr := strs[i]; 
  end; 

  FTi:='';
  FAur:='';
  Fal:='';
  FBy:='';
  FOffset:=0; 

end; 

destructor TLyric.Destroy; 
begin 
 SetLength(FLyricArray,0); 

 inherited Destroy; 
end; 

function TLyric.GetLyric(i:integer): TOneLyric ; 
begin 
 if (i>=0) and (i<length(FLyricArray)) then
   result:=FLyricArray[i] ;
end; 

procedure TLyric.sortLyric; 
var i,j:integer; 
 tmpLyric:TOneLyric; 
begin 
  for i:=0 to length(FLyricArray)-2 do
  begin 
    for j:=i to length(FLyricArray)-1 do 
    begin 
       if FLyricArray[j].time < FLyricArray[i].time then 
       begin 
         tmpLyric:= FLyricArray[i]; 
         FLyricArray[i]:= FLyricArray[j]; 
         FLyricArray[j]:= tmpLyric; 
       end; 
    end; 
  end; 
end; 

function TLyric.ChgOffset(atime:integer):boolean;//��ǰ(��ֵ)���Ӻ�(��ֵ)atime���� 
var i,numberLine:integer; 
 p1,p2,p3:integer; 
    timestr,lyricstr,CurLyric,signStr:string; 
    aOffset:longint; 
    afind:boolean; 
 FTxt:Tstrings; 
begin 
  Result:=false; 

 //�޸�offset �����ļ� 
   afind:=false; 
   aOffset:=0; 
   numberLine:=-1; 

   FTxt:=TStringlist.create; 
try 
   FTxt.LoadFromFile(FFilename); 

    for i:=0 to FTxt.Count-1 do 
    begin 
       curLyric:=fTxt[i]; 

         p1:=pos('[',CurLyric);//��һ����[��λ�� 
         if p1=0 then begin   //�ж��Ƿ�Ƿ��� 
         continue;          //�� '[' 
         end; 
         p2:=pos(']',CurLyric); //��һ����]��λ�� 
         if p2=0 then begin 
         continue;          //�� ']' 
         end; 

         timestr:=copy(curLyric,p1+1,p2-p1-1); 
         //��������Ϊ��� 
         lyricStr:= copy(curLyric,1,p1-1) + copy(curLyric,p2+1,length(curLyric)-p2) ; 

         if copy(Lowercase(timeStr),1,6)='offset' then  //�ҵ� ʱ�䲹���� 
         begin 
         try 
         aOffset:= strtoint(copy(timestr,8,length(timestr)-7)); 
         except 
         continue; 
         end ; 
         fTxt[i]:=copy(curLyric,1,p1-1) 
         +'[offset:'+inttostr(aOffset+aTime) +']' 
         +copy(curLyric,p2+1,length(curLyric)-p2); 

         if  aOffset+aTime=0 then 
         FTxt.Delete(i); 

         fTxt.SaveToFile(FFilename); 
         afind:=true; 
         break; 
         end
         else
         begin
         if numberLine=-1 then 
         begin
         signStr:=copy(Lowercase(timeStr),1,2) ; 
         if (signStr<>'ar') and (signStr<>'al') and (signStr<>'ti') and (signStr<>'by') then begin 
         p3:= pos(':',timestr) ; 
         if p3>0 then         //Ϊʱ���� 
         numberLine:=i;        //��¼�к�
         end; 
         end; 
         end; 
    end; 

  if (not afind) and (numberLine<>-1) then
  begin 
    //fTxt.Add('[offset:'+inttostr(aOffset+aTime) +']'); 
    fTxt.Insert(numberline, '[offset:'+inttostr(aOffset+aTime) +']'); 
    fTxt.SaveToFile(FFilename); 
  end;

  //����������
  loadLyric(FFilename); 

  result:=true;     

  FTxt.Clear; 
finally 
  FTxt.free;
end; 
end; 

function TLyric.ChgOneLyric(oldTime:longint;aTime:integer):boolean; 
var i:integer; 
   FTxt:Tstrings; 
   AjustOk:boolean;
   thisLyric:string; 

  function AjustOneLine(var curLyric:string):boolean; 
  var 
    isFu:boolean;//��ʱ���Ƿ�Ϊ��. 

    p1,p2,p3:integer;
    timestr,left_lyric,right_lyric:string;    // 
    time1,time2:longint; 
    findok:boolean; 
    isValid:boolean;// 
    
    NewTimeLabel:string; 
    NewTime:longint;

    UseMS:boolean; 
  begin 
       //---------�ô��� �Ƿ��б�ǩ ---------- 
       p1:=pos('[',CurLyric);//��һ����[��λ�� 
       if p1=0 then begin   //�ж��Ƿ�Ƿ��� 
         Result:=false;          //�� '['
         exit; 
       end; 
       p2:=pos(']',CurLyric); //��һ����]��λ�� 
       if p2=0 then begin 
         result:= false; 
         exit;          //�� ']' 
       end;
       //==========���� �Ƿ��б�ǩ========== 

       //----------Ŀǰ��ǩ �Ƿ��� ָ��ʱ��� ��ǩ---------- 
       timestr:=copy(curLyric,p1+1,p2-p1-1); 

       Left_lyric:= copy(curLyric,1,p1-1); 
       Right_lyric:= copy(curLyric,p2+1,length(curLyric)-p2)  ;

       isValid:=true; 
       findok:=false; 
       p3:= pos(':',timestr) ; 
       if p3>0 then begin //�ж��Ƿ� �Ϸ�ʱ���ǩ 
         isFu:=false; 
         try
         time1:=strtoint(copy(timestr,1,p3-1))*1000; 
         if time1<0 then 
         isFu:=true; 
         except 
         //�Ƿ������ 
         isValid:=false;          //�������� 
         end;

         try 
         if isValid then 
         begin 
         time2:= trunc( strtofloat(copy(timestr,p3+1,length(timestr)-p3)) *1000); 
         if isFu then 
         time2:=-time2;
         end; 
         except 
         isValid:=false;          //�� ���� 
         end; 

         if isValid and (time1*60+time2 - FOffset = oldtime) then //�ҵ� ָ��ʱ�䴮 
         findOk:=true;  //�ҵ� �� �� �� ...


       end; //�Ƿ��� �жϽ��� 
       //==========�Ƿ��ҵ� ָ��ʱ���ǩ========== 

       //-------�ҵ� �� û�ҵ� ֮��Ĵ��� ---------- 
       if findok then begin
         Result:= true; 

         //���� ��ʱ���ǩ��timerstr�� 
         //���� �µ�ʱ���ǩ
         NewTime:=time1*60+time2 - aTime;

         //���� ԭ���Ƿ�ʹ�ú��� �� Ŀǰ������ƫ��ʱ���Ƿ����ں��뼶��
         //          ������ �Ƿ� ʹ�ú��� 
         UseMS:= (Pos('.',timestr)>0) or (aTime mod 1000 <>0); 

         //ת��ʱ��Ϊʱ�䴮���磺 72�� ==>> '00:01:12.000'

         //ͼ���㣬��ʱ���˸�ϵͳ����
         //NewTimeLabel:=ConvertTimeToTimestr(NewTime,0,false,true,UseMS,true);
          NewTimeLabel:= timetostr(FileDateToDateTime(NewTime));

         //���� �µĸ�ʲ���
         curLyric := left_Lyric + '[' + NewTimeLabel + ']'+ Right_Lyric;


         end 
        else //�� û�ҵ� 
         begin  //�� ���и��ʣ�ಿ�� ���ҿ� 

         if AjustOneLine(Right_lyric) then
         begin 
         //��ʣ�ಿ�����ҵ��� 
         curLyric:= Left_lyric+ '[' + timestr +']' +Right_lyric ; 

         Result:=true; 
         end 
         //else  ʣ�ಿ���� û�еĻ� ��ֻ�÷��� false ��
         //   (������ʼ�����Ѿ�Ĭ��=false) 

         end; 
        //=========�ҵ� �� û�ҵ� ֮��Ĵ���==========   

  end; //end function AjustOneLine 

begin 
   AjustOk:=false; 
   Result:=false; 

   FTxt:=TStringlist.create; 
try 
   FTxt.LoadFromFile(FFilename);

    for i:=0 to FTxt.Count-1 do 
    begin 
       thisLyric:=FTxt[i]; 

       if AjustOneLine(thisLyric) then
       begin 
         AjustOk:=true; 
         //���� ������ �ĸ���� 
         FTxt[i]:=thisLyric; 

         break;
       end; 
    end; 

  if AjustOk then 
  begin 
    //�������ļ�
    FTxt.SaveToFile(FFilename); 

    //���������� 
    loadLyric(FFilename); 

    Result:=true;
  end; 
  
  FTxt.Clear; 
finally 
  FTxt.free; 
end;

end; 

//���������ݵ��ļ� 
function TLyric.SaveLyricsToFile(vFileName:string):boolean; 
var i:integer;
  aTxt:Tstrings ; 
begin 
  result:=false; 
  if FCount<=0 then exit; 

  aTxt:=Tstringlist.Create;
  try
     if FTi <>'' then
       aTxt.Add('����:'+FTi);
     if FAur <>'' then
       aTxt.Add('����:'+FAur);
     if Fal <>'' then
       aTxt.Add('ר��:'+Fal);
    // if Fby <>' then
    //   lbxpreview.Items.Add('��ʱ༭:'+Fby);
      if aTxt.Count >0 then
         aTxt.Add('--- --- --- --- --- --- ---');

    for i:=0 to FCount-1 do
       aTxt.Add(LyricArray[i].lyStr ) ;

    aTxt.SaveToFile(vFilename);

    Result:=true;
  finally
    aTxt.Free;
  end;
end;

procedure draw_to_dc(const s: string);
var  dskcanvas:TCanvas;
begin
  dskcanvas:=TCanvas.create;
  dskcanvas.handle:=getdc(0);
  dskcanvas.Font.Name:= '����';
 // dskcanvas.Font.Color:= clgreen;
  dskcanvas.Font.Size:= 40;
 // dskcanvas.Pen.Mode:= pmXor;
  //dskcanvas.Brush.Style:= bsClear;
   dskcanvas.FillRect(rect(40,screen.WorkAreaHeight- 58,screen.Width-40,screen.WorkAreaHeight- 3));
  dskcanvas.textout(40,screen.WorkAreaHeight- 58,s);

  ReleaseDC(0,dskcanvas.handle);
  dskcanvas.Free;
end;

function TLyric.get_lrc_string(t: integer): boolean;
var i: integer;
    label pp;
begin
result:= false;
 for i:= 0 to  high(FLyricArray) do
  begin
   if i= high(FLyricArray) then
     goto pp;
    if (FLyricArray[i].time < t) and (FLyricArray[i+1].time > t) then
      begin
       pp:
       if findex <>i then
       begin
        //����

       draw_to_dc(FLyricArray[i].lyStr);

       findex:= i;
       end;
       result:= true;
       exit;
      end;
  end;

end;

end.
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
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
    Label12: TLabel;
    Label13: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label14: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    is_write_name: boolean; //�Ƿ��޸����ƣ����������ֵ���߶�ֵ���޸��к�
  public
    { Public declarations }
    show_type_i: integer;
    procedure show_ss(ss: string);
    procedure show_ss2(ss: string);
  end;

var
  Form2: TForm2;

implementation
   uses unit1;
{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
self.ModalResult:= mrcancel;
end;

procedure TForm2.Button1Click(Sender: TObject);
var ss: string;
begin
 if edit1.Text= '' then
  begin
    showmessage('���Ʋ���Ϊ��');
    exit;
  end;

 if edit2.Text= '' then
  edit2.Text:= '1'
   else
    begin
     try
       strtoint(edit2.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit3.Text= '' then
  edit3.Text:= '1'
   else
    begin
     try
       strtoint(edit3.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit4.Text= '' then
  edit4.Text:= '1'
   else
    begin
     try
       strtoint(edit4.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit5.Text= '' then
  edit5.Text:= '1'
   else
    begin
     try
       strtoint(edit5.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit6.Text= '' then
  edit6.Text:= '1'
   else
    begin
     try
       strtoint(edit6.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit7.Text= '' then
  edit7.Text:= '1'
   else
    begin
     try
       strtoint(edit7.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit8.Text= '' then
  edit8.Text:= '1'
   else
    begin
     try
       strtoint(edit8.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit9.Text= '' then
  edit9.Text:= '1'
   else
    begin
     try
       strtoint(edit9.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit10.Text= '' then
  edit10.Text:= '1'
   else
    begin
     try
       strtoint(edit10.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit11.Text= '' then
  edit11.Text:= '1'
   else
    begin
     try
       strtoint(edit11.text);
     except
       showmessage('����������');
       exit;
     end;
    end;
    if edit12.Text= '' then
  edit12.Text:= '1'
   else
    begin
     try
       strtoint(edit12.text);
     except
       showmessage('����������');
       exit;
     end;
    end;

 ss:= edit1.Text+ ','+ edit2.Text+ ','+edit3.Text+ ','+edit4.Text+ ','+edit5.Text+ ','+
 edit6.Text+ ','+edit7.Text+ ','+edit8.Text+ ','+edit9.Text+ ','+edit10.Text+ ','+
 edit11.Text+ ','+edit12.Text+ ','+edit13.Text;

 form1.write_ss(ss);
 form1.SynEditor1Change(sender);
end;

procedure TForm2.show_ss(ss: string);
begin
  if ss= '' then
   exit;

   if pos('=',ss)>0 then
    delete(ss,1,pos('=',ss));

   edit1.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
    edit2.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit3.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit4.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit5.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit6.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit7.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit8.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit9.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit10.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit11.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit12.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit13.Text:=ss;

   //���������ٴ��޸�label��ǩ

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
 is_write_name:= false;
 form1.read_ss_up;
end;

procedure TForm2.show_ss2(ss: string);
begin
  if ss= '' then
   exit;

   if pos('=',ss)>0 then
    delete(ss,1,pos('=',ss));
    if copy(ss,1,pos(',',ss)-1)<> '' then
     label14.Caption := copy(ss,1,pos(',',ss)-1);

      if is_write_name then
            edit1.Text:= copy(ss,1,pos(',',ss)-1);

   delete(ss,1,pos(',',ss));
    edit2.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit3.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit4.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit5.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit6.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit7.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit8.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit9.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit10.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit11.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit12.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));

   if is_write_name then
      edit13.Text:= ss;

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
 is_write_name:= false;
  form1.read_ss_down;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  if show_type_i= 3 then
   begin
    label2.Caption:= '����';
      edit2.Hint:= '��Ʒ������������';
    label3.Caption:= '��';
      edit3.Hint:= '����Ʒ�����ķ���ֵ���ӣ�ͨ����װ����';
    label4.Caption:= '��';
      edit4.Hint:= '����Ʒ����������ֵ���ӣ�ͨ����װ����';
    label5.Caption:= '��';
      edit5.Hint:= '����Ʒ����������ֵ���ӣ�ͨ����װ����';
    label6.Caption:= '��';
      edit6.Hint:= '����Ʒ�������ٶ�ֵ���ӣ�ͨ����װ����';
    label7.Caption:= '��';
      edit7.Hint:= '���ĸ���Ʒ����������ֵ����';
    label8.Caption:= '��';
      edit8.Hint:= '����Ʒ�����Ĺ��������ӣ�ͨ����������';
    label9.Caption:= '��';
      edit9.Hint:= '����Ʒ��������������';
    label10.Caption:= '��';
      edit10.Hint:= '����Ʒ�����������ӣ�ͨ����������';
    label11.Caption:= '��־';
      edit11.Hint:= '�������ԣ���ͬ���͵���Ʒ���ò�ͬ';
    label12.Caption:= '�۸�';
      edit12.Hint:= '�����';
   end else if show_type_i= 2 then
       begin
       //����������ֵ��Ѫֵ������ħ��������ֵ��������Ʒ�������Ǯ��������Ʒ������������ʣ��ٶ�
        label2.Caption:= '����';
          edit2.Hint:= '����Ĺ�����';
    label3.Caption:= '��';
      edit3.Hint:= '����ķ���ֵ';
    label4.Caption:= 'Ѫ';
      edit4.Hint:= '�����Ѫֵ';
    label5.Caption:= 'ħ��';
      edit5.Hint:= '���������ħ������һ������ʹ��';
    label6.Caption:= '����';
      edit6.Hint:= '��ܸù�����õľ���ֵ';
    label7.Caption:= '����';
      edit7.Hint:= '�ùֱ���ܺ��������Ʒ���';
    label8.Caption:= '��Ǯ';
      edit8.Hint:= '�ùֱ���ܺ�����Ľ�Ǯ';
    label9.Caption:= '������';
      edit9.Hint:= '�ùֱ���ܺ����ָ����Ʒ������';
    label10.Caption:= '����';
      edit10.Hint:= '�ùֱ���ܺ����ָ����Ʒ�ĸ��ʣ�X��֮һ��������Ϊ1�����ǵ���Ʒ';
    label11.Caption:= '�ٶ�';
      edit11.Hint:= '�ùֵ��ٶȣ��ٶ�Խ�ߣ��ֵ������Ĵ���Խ��';
    label12.Caption:= 'ͷ���ţ�49Ĭ�Ϲ��59Ĭ������';
      edit12.Hint:= 'ͷ����';
       end;

if show_type_i= 3 then //��Ʒ
    begin
      if edit2.Text<> '' then
       begin
         case strtoint(edit2.Text) of
           1,9,16,24: begin
                     label11.Caption:= '��Ů';
                     edit11.Hint:= '10X����ʽ��20X��Ůʽ��30X��ͨ�á�'+ #10#13+
                     'Xֵ��1..9����ʾ��������';
                      if (strtoint(edit2.Text)=16) or (strtoint(edit2.Text)=24) then
                       begin
                        label10.Caption:= '�ȼ�';
                        edit10.Hint:= '���д������������͵ȼ���'
                       end;
                    end;
           4: begin
               label11.Caption:= 'ʱ��';
                edit11.Hint:= '����ʱ����0��ʾһ����Ч��1Ϊ10�룬2Ϊ20�룬�Դ�����';
              end;
           128: begin
                 label11.Caption:= '�ȼ�';
                edit11.Hint:= '��Ҫ�ﵽ�˵ȼ�����ѧϰ�˼�����';
                  label3.Caption:= '��Ů';
                edit3.Hint:= '3��ʾ��Ů��ѧ��1���п�ѧ��0Ů��ѧ';
                  label10.Caption:= '��ȫ';
                label10.Hint:= '1=���壬Ϊ0����ʾȫ��';
                edit10.Hint:= '1��ʾ����ָ��򹥻���Ϊ0����ʾȫ��';
                  label12.Caption:= '�����';
                edit12.Hint:= '0��ʾ�ָ�����1��ʾ������';
                end;
           256:begin
               label11.Caption:= 'ʱ��';
                edit11.Hint:= '����ʱ����0��ʾһ����Ч��1Ϊ10�룬2Ϊ20�룬�Դ�����';
              end;
         end; //end case
       end;
    end;

end;

procedure TForm2.Button7Click(Sender: TObject);
begin
 button1click(sender);
 form1.SynEditor1Change(sender);
 self.ModalResult:= mrok;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
 is_write_name:= true;
  form1.read_ss_up_2;


end;

procedure TForm2.Button6Click(Sender: TObject);
begin
 is_write_name:= true;
 form1.read_ss_down_2;
end;

end.

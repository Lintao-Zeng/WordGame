unit Unit_p_edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm_P_edit = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_P_edit: TForm_P_edit;

implementation
    uses unit1;
{$R *.dfm}

procedure TForm_P_edit.FormShow(Sender: TObject);
var i: integer;
begin
 stringgrid1.Cells[0,0]:= '����';
  stringgrid1.Cells[1,0]:= 'ֵ';

  stringgrid1.Cells[0,1]:= '����';
         //���ԣ�64��
  stringgrid1.Cells[0,2]:= '��Ǯ';
  stringgrid1.Cells[0,3]:= '����ֵ';
  stringgrid1.Cells[0,4]:= '�ٶ�';
  stringgrid1.Cells[0,5]:= '������';
  stringgrid1.Cells[0,6]:= '�Ƿ��ϳ�';
  stringgrid1.Cells[0,7]:= '����';
  stringgrid1.Cells[0,8]:= '����';
  stringgrid1.Cells[0,9]:= '����';
  stringgrid1.Cells[0,10]:= '����ֵ';
  stringgrid1.Cells[0,11]:= '����ֵ';
  stringgrid1.Cells[0,12]:= '����ֵ';
  stringgrid1.Cells[0,13]:= '�Ը�';
  stringgrid1.Cells[0,14]:= '�Ա�';
  stringgrid1.Cells[0,15]:= '̰��';
  stringgrid1.Cells[0,16]:= '���Ƕ���İ���ֵ';
  stringgrid1.Cells[0,17]:= '�����ǵİ���ֵ';
  stringgrid1.Cells[0,18]:= '���������ζ�';
  stringgrid1.Cells[0,19]:= '���Ƕ������ζ�';
  stringgrid1.Cells[0,20]:= '������¼';
  stringgrid1.Cells[0,21]:= '����ֵ';
  stringgrid1.Cells[0,22]:= '����ֵ';
  stringgrid1.Cells[0,23]:= '���';
  stringgrid1.Cells[0,24]:= '̸��ǰ���ı��';
  stringgrid1.Cells[0,25]:= '̸���α�';
  stringgrid1.Cells[0,26]:= '�´�����';
  stringgrid1.Cells[0,27]:= '�̶�����';
  stringgrid1.Cells[0,28]:= '�̶�����';
  stringgrid1.Cells[0,29]:= '�̶�����ֵ';
  stringgrid1.Cells[0,30]:= '��ǰ�ȼ�';
  stringgrid1.Cells[0,31]:= '��ʱ����';
    stringgrid1.Cells[0,32]:= 'ϵͳ����';
    stringgrid1.Cells[0,33]:= 'ϵͳ����';
    stringgrid1.Cells[0,34]:= 'ͷ�����';
   for i:= 35 to 65 do
      stringgrid1.Cells[0,i]:= '����' + inttostr(i-1);

        //װ����10��
  stringgrid1.Cells[0,66]:= 'װ����δ�ã�';
    stringgrid1.Cells[0,67]:= 'ͷ��';
    stringgrid1.Cells[0,68]:= '��';
    stringgrid1.Cells[0,69]:= '����';
    stringgrid1.Cells[0,70]:= '�Ŵ�';
    stringgrid1.Cells[0,71]:= '����';
    stringgrid1.Cells[0,72]:= '��ָ';
    stringgrid1.Cells[0,73]:= '����';
    stringgrid1.Cells[0,74]:= '����';
    stringgrid1.Cells[0,75]:= '����';

     //���ܣ�24��
             for i:= 76 to 99 do
      stringgrid1.Cells[0,i]:= '������ϱ��' + inttostr(i-75);


      //������64��
       for i:= 100 to 163 do
      stringgrid1.Cells[0,i]:= '������ϱ��' + inttostr(i-99);

end;

procedure TForm_P_edit.Button1Click(Sender: TObject);
var i: integer;
begin
    try
      for i:= 2 to StringGrid1.rowCount- 1 do
        strtoint(StringGrid1.Cells[1,i]);
    except
      raise Exception.Create('����ֵ���������֡�');
    end;



   for i:= 1 to StringGrid1.rowCount- 1 do
    form1.SynEditor1.lines.Strings[i]:= StringGrid1.Cells[1,i];

  file_is_change:= true;
  
    self.ModalResult:= mrok;
end;

procedure TForm_P_edit.Button2Click(Sender: TObject);
begin
    self.Close;
end;

end.

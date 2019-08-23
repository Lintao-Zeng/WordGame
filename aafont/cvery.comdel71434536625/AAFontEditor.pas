{*******************************************************************************

                          AAFont - ƽ����Ч����ؼ���
                          ---------------------------
                           (C)Copyright 2001-2004
                            CnPack ������ �ܾ���

            ��һ�ؼ����������������������������������������GNU ��
        ����ͨ�ù������֤Э�����޸ĺ����·�����һ���򣬻��������֤��
        �ڶ��棬���ߣ���������ѡ�����κθ��µİ汾��

            ������һ�ؼ�����Ŀ����ϣ�������ã���û���κε���������û��
        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� GNU �Ͽ���ͨ�ù�
        �����֤��

            ��Ӧ���Ѿ��Ϳؼ���һ���յ�һ�� GNU �Ͽ���ͨ�ù������֤��
        �����������û�У�д�Ÿ���
            Free Software Foundation, Inc., 59 Temple Place - Suite
        330, Boston, MA 02111-1307, USA.

            ��Ԫ���ߣ�CnPack ������ �ܾ���
            ���ص�ַ��http://www.yygw.net
            �����ʼ���yygw@yygw.net

*******************************************************************************}

unit AAFontEditor;
{* |<PRE>
================================================================================
* ������ƣ�ƽ����Ч����ؼ���
* ��Ԫ���ƣ�ƽ����Ч�������ԡ�����༭����Ԫ
* ��Ԫ���ߣ�CnPack ������ �ܾ���
* ������ַ��http://www.yygw.net
* Eamil   ��yygw@yygw.net
* ����ƽ̨��PWin2000Pro + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 + C++Build 5/6
* ������ע��
* �����£�2002.07.02
================================================================================
|</PRE>}

interface

{$I AAFont.inc}

uses
  Windows, Messages, SysUtils, Classes,
{$IFDEF COMPILER6_UP}
  DesignIntf, DesignEditors;
{$ELSE}
  DsgnIntf;
{$ENDIF}

type

{ TAAEffectProperty }

  TAAEffectProperty = class(TClassProperty)
  {* TAAEffectƽ��������Ч���������Ա༭����ͨ�����û���������ڿ��ӻ��༭ƽ��
     ������Ч������}
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

{ TAALabelEditor }

  TAALabelEditor = class(TComponentEditor)
  {* TAALabel���������ؼ�������༭����ͨ�����û���������ڿ��ӻ��༭ƽ��
     ������Ч������}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

uses
  AAFont, AACtrls, AAFontDialog;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TAAEffect), nil, '', TAAEffectProperty);
  RegisterComponentEditor(TAALabel, TAALabelEditor);
end;

resourcestring
  SAAEffect = 'ƽ����Ч����';
  SAALabelVert = '����ƽ����Ч����(&F)...';

{ TAAEffectProperty }

type
  TAAEffectAccess = class(TAAEffect);

procedure TAAEffectProperty.Edit;
var
  AEffect: TAAEffect;
  FontLabel: TFontLabel;
begin
  AEffect := TAAEffect(Pointer(GetOrdValue));
  with TAAFontDialog.Create(nil) do
  try
    if (PropCount = 1) and (TAAEffectAccess(AEffect).GetOwner is TFontLabel) then
    begin
      FontLabel := TFontLabel(TAAEffectAccess(AEffect).GetOwner);
      AllowChangeFont := True;
      Font.Assign(FontLabel.Font);
    end
    else
    begin
      FontLabel := nil;
      AllowChangeFont := False;
    end;
    Effect.Assign(AEffect);
    if Execute then
    begin
      SetOrdValue(Integer(Effect));
      if FontLabel <> nil then
        FontLabel.Font.Assign(Font);
    end;
  finally
    Free;
  end;
end;

function TAAEffectProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end;

function TAAEffectProperty.GetValue: string;
begin
  Result := SAAEffect;
end;

{ TAALabelEditor }

procedure TAALabelEditor.ExecuteVerb(Index: Integer);
var
  Ctrl: TAALabel;
begin
  if Index = 0 then
  begin
    if Component is TAALabel then
    begin
      Ctrl := TAALabel(Component);
      with TAAFontDialog.Create(nil) do
      try
        AllowChangeFont := True;
        Font.Assign(Ctrl.Font);
        Effect.Assign(Ctrl.Effect.FontEffect);
        if Execute then
        begin
          Ctrl.Font.Assign(Font);
          Ctrl.Effect.FontEffect := Effect;
          Designer.Modified;
        end;
      finally
        Free;
      end;
    end;
  end
  else
    inherited;
end;

function TAALabelEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := SAALabelVert
  else
    Result := inherited GetVerb(Index);
end;

function TAALabelEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.




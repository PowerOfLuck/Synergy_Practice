object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=LibraryDB;Data Source=HOME-PC;Use Proce' +
      'dure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstat' +
      'ion ID=HOME-PC;Use Encryption for Data=False;Tag with column col' +
      'lation when possible=False'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 72
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Books')
    Left = 136
    Top = 72
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = ADOQuery1
    Left = 96
    Top = 8
  end
end

library Project1;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  Web.Win.ISAPIThreadPool,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  DataModuleUnit in 'DataModuleUnit.pas' {DataModule1: TDataModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

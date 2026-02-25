object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'actRoot'
      PathInfo = '/'
      OnAction = WebModule1actRootAction
    end
    item
      Name = 'actList'
      PathInfo = '/list'
      OnAction = WebModule1actListAction
    end
    item
      Name = 'actForm'
      PathInfo = '/form'
      OnAction = WebModule1actFormAction
    end
    item
      Name = 'actAdd'
      PathInfo = '/add'
      OnAction = WebModule1actAddAction
    end>
  Height = 230
  Width = 415
end

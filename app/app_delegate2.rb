class AppDelegate2
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
  end

  def buildWindow
    @mainWindowController = MainWindowController.alloc.initWithWindowNibName('MainWindowController')
    @mainWindowController.window.makeKeyAndOrderFront(self)
  end
end

class UIView
  def addSubviews *views
    views.flatten.each { |view| addSubview view }
  end
end

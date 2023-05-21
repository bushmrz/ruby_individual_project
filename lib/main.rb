require_relative 'logger'
require_relative './views/main_window'

LoggerHolder.instance.level = Logger::DEBUG
MainWindow.new.create.show
require_relative 'logger'
require_relative 'lib/views/main_window'

LoggerHolder.instance.level = Logger::DEBUG
MainWindow.new.create.show